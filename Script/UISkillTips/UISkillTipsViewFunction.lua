local View = require("UISkillTips/UISkillTipsView")
local DataModel = require("UISkillTips/UISkillTipsDataModel")
local ViewFunction = {
  SkillTips_Btn_Close_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  SkillTips_Btn_Lvup_Click = function(btn, str)
  end,
  SkillTips_Btn_LvMax_Click = function(btn, str)
  end,
  SkillTips_Btn_LvLock_Click = function(btn, str)
  end
}
return ViewFunction
