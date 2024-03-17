local View = require("UIBroadCast/UIBroadCastView")
local DataModel = require("UIBroadCast/UIBroadCastDataModel")
local ViewFunction = {
  BroadCast_Group_BG_Group_Upper_Group_TopRight_Btn_Close_Click = function(btn, str)
    View.self:CloseUI()
  end
}
return ViewFunction
