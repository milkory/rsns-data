local View = require("UIDrinkBuff/UIDrinkBuffView")
local DataModel = require("UIDrinkBuff/UIDrinkBuffDataModel")
local ViewFunction = {
  DrinkBuff_Btn_Close_Click = function(btn, str)
    UIManager:GoBack()
  end
}
return ViewFunction
