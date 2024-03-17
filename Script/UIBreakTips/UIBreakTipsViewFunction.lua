local View = require("UIBreakTips/UIBreakTipsView")
local DataModel = require("UIBreakTips/UIBreakTipsDataModel")
local ViewFunction = {
  BreakTips_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false)
  end
}
return ViewFunction
