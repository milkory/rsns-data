local View = require("UIUpgradeSuccess/UIUpgradeSuccessView")
local DataModel = require("UIUpgradeSuccess/UIUpgradeSuccessDataModel")
local ViewFunction = {
  UpgradeSuccess_Btn_Mask_Click = function(btn, str)
    View:CloseUI()
  end
}
return ViewFunction
