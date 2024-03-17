local View = require("UIEnergyBuyTips/UIEnergyBuyTipsView")
local DataModel = require("UIEnergyBuyTips/UIEnergyBuyTipsDataModel")
local ViewFunction = {
  EnergyBuyTips_Btn_Close_Click = function(btn, str)
  end,
  EnergyBuyTips_Btn_Confirm_Click = function(btn, str)
    local IsActive = View.Txt_NoReminded.Btn_Check.Txt_Check.IsActive
    local recordTime = IsActive and TimeUtil:GetServerTimeStamp() or 0
    PlayerData:SetPlayerPrefs("int", "battleEnergy", recordTime)
    UIManager:CloseTip("UI/Energy/EnergyBuyTips")
    View.self:Confirm()
  end,
  EnergyBuyTips_Btn_Cancel_Click = function(btn, str)
    UIManager:CloseTip("UI/Energy/EnergyBuyTips")
  end,
  EnergyBuyTips_Txt_NoReminded_Btn_Check_Click = function(btn, str)
    local IsActive = View.Txt_NoReminded.Btn_Check.Txt_Check.IsActive
    View.Txt_NoReminded.Btn_Check.Txt_Check:SetActive(not IsActive)
  end
}
return ViewFunction
