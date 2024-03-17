local View = require("UIThemeTips/UIThemeTipsView")
local DataModel = require("UIThemeTips/UIThemeTipsDataModel")
local ViewFunction = {
  ThemeTips_Btn_BG_Click = function(btn, str)
    UIManager:CloseTip("UI/Home/ThemeTips")
  end,
  ThemeTips_Btn_OK_Click = function(btn, str)
    UIManager:CloseTip("UI/Home/ThemeTips")
  end
}
return ViewFunction
