local View = require("UIDressTips/UIDressTipsView")
local DataModel = require("UIDressTips/UIDressTipsDataModel")
local ViewFunction = {
  DressTips_Btn_BG_Click = function(btn, str)
    UIManager:CloseTip("UI/ChangeSkin/DressTips")
  end
}
return ViewFunction
