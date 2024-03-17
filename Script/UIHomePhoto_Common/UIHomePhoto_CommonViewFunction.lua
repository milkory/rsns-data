local View = require("UIHomePhoto_Common/UIHomePhoto_CommonView")
local DataModel = require("UIHomePhoto_Common/UIHomePhoto_CommonDataModel")
local ViewFunction = {
  HomePhoto_Common_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  HomePhoto_Common_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  HomePhoto_Common_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomePhoto_Common_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomePhoto_Common_Btn_close_Click = function(btn, str)
    UIManager:GoBack()
  end
}
return ViewFunction
