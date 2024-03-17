local View = require("UIGuidance/UIGuidanceView")
local DataModel = require("UIGuidance/UIGuidanceDataModel")
local Controller = require("UIGuidance/UIGuidanceController")
local ViewFunction = {
  Guidance_Btn_Tip_Click = function(btn, str)
    Controller.ClickTip()
  end
}
return ViewFunction
