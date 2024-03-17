local View = require("UINewCarriage/UINewCarriageView")
local DataModel = require("UINewCarriage/UINewCarriageDataModel")
local ViewFunction = {
  NewCarriage_Btn_Close_Click = function(btn, str)
    View.self:CloseUI()
  end
}
return ViewFunction
