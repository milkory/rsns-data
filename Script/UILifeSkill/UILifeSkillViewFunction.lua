local View = require("UILifeSkill/UILifeSkillView")
local DataModel = require("UILifeSkill/UILifeSkillDataModel")
local Controller = require("UILifeSkill/UILifeSkillController")
local ViewFunction = {
  LifeSkill_Btn_Close_Click = function(btn, str)
    Controller:Exit()
  end,
  LifeSkill_ScrollGrid_SkillList_SetGrid = function(element, elementIndex)
    Controller:RefreshElement(element, elementIndex)
  end,
  LifeSkill_ScrollGrid_SkillList_Group_Item_ScrollGrid_Photo_SetGrid = function(element, elementIndex)
    Controller:RefreshPhotoElement(element, elementIndex)
  end,
  LifeSkill_ScrollGrid_SkillList_Group_Item_ScrollGrid_Photo_Group_Item_Btn_Tips_Click = function(btn, str)
    UIManager:Open("UI/LifeSkillTips/LifeSkillTips", str)
  end
}
return ViewFunction
