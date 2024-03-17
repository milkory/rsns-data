local View = require("UITalentTips/UITalentTipsView")
local DataModel = require("UITalentTips/UITalentTipsDataModel")
local ViewFunction = {
  TalentTips_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end
}
return ViewFunction
