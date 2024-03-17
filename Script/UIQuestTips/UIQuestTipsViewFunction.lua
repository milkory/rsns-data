local View = require("UIQuestTips/UIQuestTipsView")
local DataModel = require("UIQuestTips/UIQuestTipsDataModel")
local Controller = require("UIQuestTips/UIQuestTipsController")
local ViewFunction = {
  QuestTips_Btn_Close_Click = function(btn, str)
    Controller:Show()
  end
}
return ViewFunction
