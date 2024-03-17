local View = require("UIGradeUp/UIGradeUpView")
local DataModel = require("UIGradeUp/UIGradeUpDataModel")
local ViewFunction = {
  GradeUp_Btn_Shade_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    View.self:Confirm()
  end,
  GradeUp_Btn_1_Click = function(btn, str)
  end
}
return ViewFunction
