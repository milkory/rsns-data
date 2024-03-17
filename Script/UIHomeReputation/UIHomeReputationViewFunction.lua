local View = require("UIHomeReputation/UIHomeReputationView")
local DataModel = require("UIHomeReputation/UIHomeReputationDataModel")
local Controller = require("UIHomeReputation/UIHomeReputationController")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  HomeReputation_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:RefreshRepElement(element, elementIndex)
  end,
  HomeReputation_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:Confirm()
    UIManager:GoBack(false)
  end,
  HomeReputation_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  HomeReputation_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80303383}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  HomeReputation_Group_Zhu_Group_Reputation_Btn_Reputation_Click = function(btn, str)
  end,
  HomeReputation_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeReputation_Group_Reward_ScrollGrid_Reward_Group_Item_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    Controller:RefreshChildRewardElement(element, elementIndex)
  end,
  HomeReputation_Group_Reward_ScrollGrid_Reward_Group_Item_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickRewardItem(str)
  end,
  HomeReputation_Group_Reward_ScrollGrid_Reward_Group_Item_Group_State_Btn_Get_Click = function(btn, str)
    Controller:ClickGetReward(str)
  end,
  HomeReputation_Group_RepTips_Btn__Click = function(btn, str)
  end,
  HomeReputation_Group_Tips_Btn_Close_Click = function(btn, str)
  end
}
return ViewFunction
