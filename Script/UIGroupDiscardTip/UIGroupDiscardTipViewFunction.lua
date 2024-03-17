local View = require("UIGroupDiscardTip/UIGroupDiscardTipView")
local DataModel = require("UIGroupDiscardTip/UIGroupDiscardTipDataModel")
local ViewFunction = {
  GroupDiscardTip_Btn_BG_Click = function(btn, str)
  end,
  GroupDiscardTip_Btn_Confirm_Click = function(btn, str)
    if DataModel.isTrue == true then
      PlayerData:SetPlayerPrefs("int", "DiscardState", 1)
    else
      PlayerData:SetPlayerPrefs("int", "DiscardState", 0)
    end
    UIManager:GoBack(false, 1)
    UIManager:Pause(false)
    View.self:Confirm()
  end,
  GroupDiscardTip_Btn_Cancel_Click = function(btn, str)
    if not GuildanceManager.isGuild then
      PlayerData:SetPlayerPrefs("int", "DiscardState", 0)
      UIManager:GoBack(false, 1)
      UIManager:Pause(false)
      View.self:Cancel()
    end
  end,
  GroupDiscardTip_Group_Tip_Btn_Tip_Click = function(btn, str)
    DataModel:SetClick()
  end
}
return ViewFunction
