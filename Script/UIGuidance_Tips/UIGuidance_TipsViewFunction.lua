local View = require("UIGuidance_Tips/UIGuidance_TipsView")
local DataModel = require("UIGuidance_Tips/UIGuidance_TipsDataModel")
local ViewFunction = {
  Guidance_Tips_Btn_Close_Click = function(btn, str)
    View.self:CloseUI()
  end
}
return ViewFunction
