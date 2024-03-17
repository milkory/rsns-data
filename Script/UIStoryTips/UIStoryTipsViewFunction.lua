local View = require("UIStoryTips/UIStoryTipsView")
local DataModel = require("UIStoryTips/UIStoryTipsDataModel")
local ViewFunction = {
  StoryTips_Btn_BG_Click = function(btn, str)
    View.self:CloseUI()
  end
}
return ViewFunction
