local View = require("UIPickGender/UIPickGenderView")
local DataModel = require("UIPickGender/UIPickGenderDataModel")
local Controller = require("UIPickGender/UIPickGenderController")
local ViewFunction = {
  PickGender_Video_Ocean_Skip_Click = function(btn, str)
  end,
  PickGender_Btn_Male_Click = function(btn, str)
    Controller.ClickMale()
  end,
  PickGender_Btn_Female_Click = function(btn, str)
    Controller.ClickFemale()
  end,
  PickGender_Group_InputName_Btn_Random_Click = function(btn, str)
    Controller.RandomName()
  end,
  PickGender_Group_InputName_Btn_Confirm_Click = function(btn, str)
    Controller.ModifyName()
  end,
  PickGender_Video_Intro_Skip_Click = function(btn, str)
  end
}
return ViewFunction
