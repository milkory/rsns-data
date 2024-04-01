local View = require("UICityStore/UICityStoreView")
local DataModel = require("UICityStore/UICityStoreDataModel")
local Controller = require("UICityStore/UICityStoreController")
local ViewFunction = require("UICityStore/UICityStoreViewFunction")
local Timer = require("Common/Timer")
local ClearCacheEventList = function()
  for i, v in ipairs(DataModel.CacheEventList) do
    local character = HomeStationStoreManager:GetCharacterById(v.homeQId)
    if character ~= nil then
      HomeStationStoreManager:RecycleCustom(character)
    end
  end
  DataModel.CacheEventList = {}
end
local Luabehaviour = {
  serialize = function()
    return Json.encode({
      StationId = DataModel.StationId,
      PlaceId = DataModel.PlaceId
    })
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local t = Json.decode(initParams)
      if t.StationId ~= nil then
        DataModel.StationId = t.StationId
      end
      if t.PlaceId then
        DataModel.PlaceId = t.PlaceId
      end
      if t.PlaceId ~= nil and t.PlaceId == "81500002" then
        View.timer = Timer.New(15, function()
          local characterInfoList = DataModel.RefreshKCDCharacter()
          local x, z
          local stationCA = PlayerData:GetFactoryData(DataModel.PlaceId, "HomeStationPlaceFactory")
          local count = table.count(stationCA.entranceList)
          View.coroutine = View.self:StartC(LuaUtil.cs_generator(function()
            for i, v in pairs(characterInfoList) do
              coroutine.yield(CS.UnityEngine.WaitForSeconds(1.5))
              if 1 < count then
                x = stationCA.entranceList[math.random(1, count)].entranceX
                z = stationCA.entranceList[math.random(1, count)].entranceY
              else
                x = 0 < count and stationCA.entranceList[count].entranceX or 1
                z = 0 < count and stationCA.entranceList[count].entranceY or 7
              end
              HomeStationStoreManager:CreateCustom(v.id, 0, false, x, z, v.tree)
            end
            if View.coroutine then
              View.self:StopC(View.coroutine)
              View.coroutine = nil
            end
          end))
        end)
        View.timer:Start()
      end
      View.Group_CommonTopLeft.Btn_Help:SetActive(DataModel.PlaceId ~= "81500007" and DataModel.PlaceId ~= "81500008")
      Controller:CheckQuestProcess()
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if View.timer ~= nil then
      if View.timer:IsOver() then
        View.timer:Start()
      end
      View.timer:Update()
    end
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    QuestProcess.RemoveQuestCallBack(View.self.url)
    if View.timer then
      View.timer:Stop()
    end
    if View.coroutine then
      View.self:StopC(View.coroutine)
      View.coroutine = nil
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
