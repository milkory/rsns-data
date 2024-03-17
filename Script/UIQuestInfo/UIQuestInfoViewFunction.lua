local View = require("UIQuestInfo/UIQuestInfoView")
local DataModel = require("UIQuestInfo/UIQuestInfoDataModel")
local Controller = require("UIQuestInfo/UIQuestInfoController")
local ViewFunction = {
  QuestInfo_Group_Item_Btn_Item_Click = function(btn, str)
    local id = tonumber(str)
    CommonTips.OpenRewardDetail(id)
  end,
  QuestInfo_ScrollGrid_QuestList_SetGrid = function(element, elementIndex)
    Controller:RefreshElement(element, elementIndex)
  end
}
return ViewFunction
