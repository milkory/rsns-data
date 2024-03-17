local View = require("UIHomeElectricUp/UIHomeElectricUpView")
local DataModel = require("UIHomeElectricUp/UIHomeElectricUpDataModel")
local ViewFunction = {
  HomeElectricUp_Btn__Click = function(btn, str)
    UIManager:GoBack(false)
  end
}
return ViewFunction
