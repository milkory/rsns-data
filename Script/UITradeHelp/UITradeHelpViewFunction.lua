local View = require("UITradeHelp/UITradeHelpView")
local DataModel = require("UITradeHelp/UITradeHelpDataModel")
local ViewFunction = {
  TradeHelp_Btn_Close_Click = function(btn, str)
    UIManager:CloseTip("UI/HomeTrade/TradeHelp")
  end
}
return ViewFunction
