local View = require("UITestLevel/UITestLevelView")
local DataModel = require("UITestLevel/UITestLevelDataModel")
local module = {}

function module.RefreshUIDamage()
  if DataModel.isHide then
    return
  end
  View.Group_Statistics.Txt_TotalNum:SetText(DataModel.totalDamage)
  View.Group_Statistics.Txt_SkillTotalNum:SetText(DataModel.curSkillDamage)
  View.Group_Statistics.Txt_SkillDamageNum:SetText(DataModel.largestRecordedSkillDamage)
end

function module.RefreshUICost()
  if DataModel.isHide then
    return
  end
  View.Group_Statistics.Txt_CostNum:SetText(DataModel.usedCost)
end

function module.RefreshUICard()
  if DataModel.isHide then
    return
  end
  View.Group_Statistics.Txt_UseCardNum:SetText(DataModel.usedCards)
end

function module.RefreshUITensDamange()
  if DataModel.isHide then
    return
  end
  View.Group_Statistics.Txt_10sDamageNum:SetText(DataModel.sum_perFrameDamageList)
end

return module
