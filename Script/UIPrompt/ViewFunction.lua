local PlotController = require("UIDialog/Model_PlotController")
local PlotText = require("UIDialog/Model_PlotText")
local ViewFunction = {
  Btn_BG_click = function(str)
  end,
  Btn_Confirm_click = function(str)
    UIManager:CloseCurrentUI(UIPath.UIPrompt)
  end,
  Btn_Cancel_click = function(str)
    UIManager:CloseCurrentUI(UIPath.UIPrompt)
  end
}
return ViewFunction
