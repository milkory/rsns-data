local View = require("UICityStore/UICityStoreView")
local DataModel = require("UICityStore/UICityStoreDataModel")
local Controller = {}

function Controller:ClearCacheEventList()
  if DataModel.CacheEventList == nil then
    return
  end
  for i, v in ipairs(DataModel.CacheEventList) do
    local character = HomeStationStoreManager:GetCharacterById(v.homeQId)
    if character ~= nil then
      HomeStationStoreManager:RecycleCustom(character)
    end
  end
  DataModel.CacheEventList = {}
end

function Controller:CheckQuestProcess()
  Controller:ClearCacheEventList()
  DataModel.CacheEventList = QuestProcess.CheckEventOpen(DataModel.PlaceId)
  if #DataModel.CacheEventList > 0 then
    QuestProcess.AddQuestCallBack(View.self.url, Controller.CheckQuestProcess)
    for i, v in ipairs(DataModel.CacheEventList) do
      local character = HomeStationStoreManager:GetCharacterById(v.homeQId)
      if character == nil then
        character = HomeStationStoreManager:CreateCustom(v.homeQId, 0, false, v.qXPos, v.qYPos)
      end
      local effectPart = character.effectPart
      effectPart:SetTouchEvent(v.bubbleString, tostring(i))
      effectPart:SetLayer(27)
    end
  end
end

return Controller
