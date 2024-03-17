local View = require("UITradeLevelTip/UITradeLevelTipView")
local DataModel = require("UITradeLevelTip/UITradeLevelTipDataModel")
local ViewFunction = {
  TradeLevelTip_Btn_Close_Click = function(btn, str)
    View.self:CloseUI()
  end
}
return ViewFunction
