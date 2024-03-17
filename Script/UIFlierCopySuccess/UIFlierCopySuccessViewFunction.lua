local View = require("UIFlierCopySuccess/UIFlierCopySuccessView")
local DataModel = require("UIFlierCopySuccess/UIFlierCopySuccessDataModel")
local ViewFunction = {
  FlierCopySuccess_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  FlierCopySuccess_Btn_Close_Click = function(btn, str)
    View.self:CloseUI()
  end
}
return ViewFunction
