local View = require("UICardDes/UICardDesView")
local DataModel = require("UICardDes/UICardDesDataModel")
local ViewFunction = {
  CardDes_Btn_Close_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end
}
return ViewFunction
