local View = require("UICommonSkip/UICommonSkipView")
local DataModel = require("UICommonSkip/UICommonSkipDataModel")
local ViewFunction = {
  CommonSkip_Btn_Skip_Click = function(btn, str)
    View.self:Confirm()
  end
}
return ViewFunction
