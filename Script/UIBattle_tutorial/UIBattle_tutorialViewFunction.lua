local View = require("UIBattle_tutorial/UIBattle_tutorialView")
local Controller = require("UIBattle_tutorial/UIBattle_Controller")
local ViewFunction = {
  Battle_tutorial_Group_minor_Btn_left_Click = function(btn, str)
    Controller.OnClickBtn(false)
  end,
  Battle_tutorial_Group_minor_Btn_right_Click = function(btn, str)
    Controller.OnClickBtn(true)
  end,
  Battle_tutorial_ScrollGrid_Line_SetGrid = function(element, elementIndex)
    Controller.SetElement(element, elementIndex)
  end,
  Battle_tutorial_ScrollGrid_Line_Group_Tutorial_Btn_Item_Click = function(btn, str)
    Controller.GridBtn(tonumber(str))
  end,
  Battle_tutorial_Group_minor_Btn_left_Btn_ImgLeft_Click = function(btn, str)
    Controller.OnClickBtn(false)
  end,
  Battle_tutorial_Group_minor_Btn_right_Btn_ImgRight_Click = function(btn, str)
    Controller.OnClickBtn(true)
  end,
  Battle_tutorial_Btn_close_Click = function(btn, str)
    UIManager:GoBack(false)
    View.self:Confirm()
  end
}
return ViewFunction
