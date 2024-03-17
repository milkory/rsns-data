local View = require("UIPayTips/UIPayTipsView")
local DataModel = require("UIPayTips/UIPayTipsDataModel")
local Controller = require("UIPayTips/UIPayTipsController")
local ViewFunction = {
  PayTips_Btn_Close_Click = function(btn, str)
    Debug.Log("[Pay]PayTips_Btn_Close_Click")
    View.self:CloseUI()
  end,
  PayTips_Group_Pay_Group_ALIPAY_Btn__Click = function(btn, str)
    Controller:SelectAli()
  end,
  PayTips_Group_Pay_Group_WeChat_Btn__Click = function(btn, str)
    Controller:SelectWx()
  end,
  PayTips_Btn_Affirm_Click = function(btn, str)
    Debug.Log("[Pay]PayTips_Btn_Affirm_Click")
    Controller:OK()
  end
}
return ViewFunction
