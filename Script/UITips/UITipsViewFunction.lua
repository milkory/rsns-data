local View = require("UITips/UITipsView")
local DataModel = require("UITips/UITipsDataModel")
local ViewFunction = {
  Tips_Btn_Mask_Click = function(btn, str)
    View.self:Close()
  end
}
return ViewFunction
