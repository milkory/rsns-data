local View = require("UIScheduleReward/UIScheduleRewardView")
local DataModel = require("UIScheduleReward/UIScheduleRewardDataModel")
local Controller = require("UIScheduleReward/UIScheduleRewardController")
local ViewFunction = {
  ScheduleReward_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false)
    View.self:Confirm()
  end,
  ScheduleReward_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetElement(element, elementIndex)
  end,
  ScheduleReward_ScrollGrid_List_Group_Item_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:SetRewardItemElement(element, elementIndex)
  end,
  ScheduleReward_ScrollGrid_List_Group_Item_Group_Reward_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickRewardItem(str)
  end,
  ScheduleReward_ScrollGrid_List_Group_Item_Group_Can_Btn_Click_Click = function(btn, str)
    Controller:ClickReward(str)
  end
}
return ViewFunction
