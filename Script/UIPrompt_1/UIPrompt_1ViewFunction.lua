local View = require("UIPrompt_1/UIPrompt_1View")
local ViewFunction = {
  Prompt_1_Btn_BG_Click = function(btn, str)
  end,
  Prompt_1_Btn_Confirm_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    View.self:Confirm()
  end
}
return ViewFunction
