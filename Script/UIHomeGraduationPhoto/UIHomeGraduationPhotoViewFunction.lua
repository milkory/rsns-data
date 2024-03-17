local View = require("UIHomeGraduationPhoto/UIHomeGraduationPhotoView")
local DataModel = require("UIHomeGraduationPhoto/UIHomeGraduationPhotoDataModel")
local ViewFunction = {
  HomeGraduationPhoto_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  HomeGraduationPhoto_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  HomeGraduationPhoto_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeGraduationPhoto_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomeGraduationPhoto_Btn_close_Click = function(btn, str)
    UIManager:GoBack()
  end
}
return ViewFunction
