local View = require("UILittleTips/UILittleTipsView")
local DataModel = require("UILittleTips/UILittleTipsDataModel")
local ViewFunction = require("UILittleTips/UILittleTipsViewFunction")
local ShowInfo = function(element, id)
  local questConfig = PlayerData:GetFactoryData(id, "QuestFactory")
  element.Txt_Name:SetText(questConfig.name)
  local clientInfo = PlayerData:GetFactoryData(questConfig.client, "ProfilePhotoFactory")
  element.Img_Client:SetSprite(clientInfo.imagePath)
  element.self:SetActive(false)
  element.self:SetActive(true)
  DataModel.nextTipShowTime = DataModel.nextTipShowTime + DataModel.intervalTime
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    for k, v in pairs(data.questIds) do
      table.insert(DataModel.questIds, v)
    end
    DataModel.timeClosed = DataModel.timeClosed + #data.questIds * DataModel.intervalTime
    local id = DataModel.questIds[1] or 0
    if id ~= 0 then
      table.remove(DataModel.questIds, 1)
      local curIdx = DataModel.showIdxRecord % 3 + 1
      DataModel.showIdxRecord = DataModel.showIdxRecord + 1
      local showView = View["Group_Tips" .. curIdx]
      ShowInfo(showView, id)
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    DataModel.timeRecord = DataModel.timeRecord + 0.02
    if DataModel.timeRecord >= DataModel.nextTipShowTime then
      local id = DataModel.questIds[1] or 0
      if id ~= 0 then
        table.remove(DataModel.questIds, 1)
        local curIdx = DataModel.showIdxRecord % 3 + 1
        DataModel.showIdxRecord = DataModel.showIdxRecord + 1
        local showView = View["Group_Tips" .. curIdx]
        ShowInfo(showView, id)
      end
    end
    if DataModel.timeRecord >= DataModel.timeClosed + 0.5 then
      UIManager:CloseTip("UI/Common/LittleTips")
    end
  end,
  ondestroy = function()
    DataModel.timeRecord = 0
    DataModel.timeClosed = 0
    DataModel.nextTipShowTime = 0
    DataModel.questIds = {}
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
