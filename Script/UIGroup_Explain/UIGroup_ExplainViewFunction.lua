local View = require("UIGroup_Explain/UIGroup_ExplainView")
local DataModel = require("UIGroup_Explain/UIGroup_ExplainDataModel")
local ViewFunction = {
  Group_Explain_Btn_Close_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end
}
return ViewFunction
