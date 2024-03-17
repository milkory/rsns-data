local View = require("UISkillTips/UISkillTipsView")
local DataModel = require("UISkillTips/UISkillTipsDataModel")
local ViewFunction = require("UISkillTips/UISkillTipsViewFunction")
local RefreshUIOnBattle = function(data)
  print_r(data)
  if data.skillId == nil then
    return false
  end
  print_r("test")
  local skill = PlayerData:GetFactoryData(data.skillId, "SkillFactory")
  View.Img_Icon:SetSprite(skill.iconPath)
  View.Group_Skill.Txt_Name:SetText(skill.name)
  View.Group_Skill.Txt_LvNum:SetText(data.skillLv)
  View.Group_TypeAndCost.Txt_Cost:SetActive(data.cost ~= nil)
  View.Group_TypeAndCost.Txt_Cost:SetText(data.cost)
  View.Txt_Desc:SetText(SkillFactory:GetSkillDes(data.skillId, data.skillLv))
  View.Group_TypeAndCost.Txt_Des:SetText(skill.typeStr or "")
  return true
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    if RefreshUIOnBattle(data) == true then
      return
    end
    local serverSkill = table.count(PlayerData:GetRoleById(data.roleId)) ~= 0 and PlayerData:GetRoleById(data.roleId).skills[tonumber(data.index)] or {}
    if data.data then
      serverSkill = data.data
    end
    local skill = PlayerData:GetFactoryData(serverSkill.id, "SkillFactory")
    View.Img_Icon:SetSprite(skill.iconPath)
    View.Group_Skill.Txt_Name:SetText(skill.name)
    View.Group_Skill.Txt_LvNum:SetText(serverSkill.lv or 1)
    local cost = ""
    if skill.cardID ~= nil then
      cost = tostring(math.ceil(PlayerData:GetFactoryData(skill.cardID, "CardFactory").cost_SN))
    end
    View.Group_TypeAndCost.Txt_Cost:SetActive(skill.cardID ~= nil)
    View.Group_TypeAndCost.Txt_Cost:SetText(cost)
    View.Txt_Desc:SetText(SkillFactory:GetSkillDes(serverSkill.id, serverSkill.lv or 1))
    View.Group_TypeAndCost.Txt_Des:SetText(skill.typeStr or "")
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
