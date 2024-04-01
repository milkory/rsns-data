local View = require("UIGroup_InvestTip/UIGroup_InvestTipView")
local DataModel = require("UIGroup_InvestTip/UIGroup_InvestTipDataModel")
local ViewFunction = {
  Group_InvestTip_Btn_BG_Click = function(btn, str)
    View.self:CloseUI()
  end,
  Group_InvestTip_Btn_Confirm_Click = function(btn, str)
    if View.Group_Tip.Btn_Tip.Group_On.IsActive then
      local date_str = os.date("%Y-%m-%d", PlayerData:GetSeverTime())
      local year, month, day = string.match(date_str, "(%d+)-(%d+)-(%d+)")
      year = tonumber(year)
      month = tonumber(month)
      day = tonumber(day) + 1
      local refreshTime = os.time({
        year = year,
        month = month,
        day = day,
        hour = 0,
        min = 0,
        sec = 0
      })
      PlayerData:SetPlayerPrefs("int", "ParkInvest", refreshTime)
    end
    View.self:Confirm()
    View.self:CloseUI()
  end,
  Group_InvestTip_Btn_Cancel_Click = function(btn, str)
    View.self:CloseUI()
  end,
  Group_InvestTip_Group_Tip_Btn_Tip_Click = function(btn, str)
    local isActive = View.Group_Tip.Btn_Tip.Group_On.IsActive
    View.Group_Tip.Btn_Tip.Group_On:SetActive(not isActive)
    View.Group_Tip.Btn_Tip.Group_Off:SetActive(isActive)
  end
}
return ViewFunction
