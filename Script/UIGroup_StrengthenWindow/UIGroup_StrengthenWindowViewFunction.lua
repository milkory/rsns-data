local View = require("UIGroup_StrengthenWindow/UIGroup_StrengthenWindowView")
local DataModel = require("UIGroup_StrengthenWindow/UIGroup_StrengthenWindowDataModel")
local ViewFunction = {
  Group_StrengthenWindow_Btn_Black_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end
}
return ViewFunction
