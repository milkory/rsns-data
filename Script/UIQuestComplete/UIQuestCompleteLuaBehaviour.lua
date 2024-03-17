local ItemCommon = require("Common/BtnItem")
local View = require("UIQuestComplete/UIQuestCompleteView")
local DataModel = require("UIQuestComplete/UIQuestCompleteDataModel")
local ViewFunction = require("UIQuestComplete/UIQuestCompleteViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.Data)
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.Data = data
    DataModel.QuestIds = data.questIds
    DataModel.InitQuestInfo()
    View.ScrollGrid_QuestList.self:SetActive(true)
    View.Group_Title1.self:SetActive(false)
    View.Group_Title2.self:SetActive(false)
    View.Group_Title3.self:SetActive(false)
    View.Group_Title4.self:SetActive(false)
    local count = table.count(DataModel.QuestInfo)
    local maskComponent = View.ScrollGrid_QuestList.self.transform:GetChild(1)
    local imgComponent
    if maskComponent ~= nil then
      maskComponent = maskComponent:GetComponent(typeof(UI.Mask))
      imgComponent = maskComponent:GetComponent(typeof(UI.Image))
    end
    if count <= 3 then
      maskComponent.enabled = false
      imgComponent.enabled = false
      View["Group_Title" .. count].self:SetActive(true)
      View.ScrollGrid_QuestList.self:SetEnable(false)
      View.ScrollGrid_QuestList.grid.self:SetStartCorner("Center")
    else
      maskComponent.enabled = true
      imgComponent.enabled = true
      View.Group_Title4.self:SetActive(true)
      View.ScrollGrid_QuestList.self:SetEnable(true)
      View.ScrollGrid_QuestList.grid.self:SetStartCorner("Left")
    end
    View.ScrollGrid_QuestList.grid.self:SetDataCount(#DataModel.QuestInfo)
    View.ScrollGrid_QuestList.grid.self:RefreshAllElement()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    ItemCommon:DestroyInstantiate()
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
