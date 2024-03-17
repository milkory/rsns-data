local View = require("UIGradeUp/UIGradeUpView")
local DataModel = require("UIGradeUp/UIGradeUpDataModel")
local ViewFunction = require("UIGradeUp/UIGradeUpViewFunction")
local UserExpConfig
local SkipLevel = function(list)
  View.Group_Grade.self:SetActive(true)
  local Group_Grade = View.Group_Grade
  Group_Grade.Txt_UpBefore:SetText(list.before_lv_ani)
  Group_Grade.Txt_UpLater:SetText(list.temp_lv_ani)
  if list.temp_lv_ani - list.before_lv_ani == 1 then
    Group_Grade.Txt_AddNum:SetText(UserExpConfig[list.temp_lv_ani] and UserExpConfig[list.temp_lv_ani].levelUpEnergy or 0)
  elseif list.temp_lv_ani - list.before_lv_ani > 1 then
    local allEnery = 0
    for i = list.before_lv_ani, list.temp_lv_ani - 1 do
      allEnery = allEnery + (UserExpConfig[i] and UserExpConfig[i].levelUpEnergy or 0)
    end
    Group_Grade.Txt_AddNum:SetText(allEnery)
  end
  local homeSkll_Energy = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddEnergyMax)
  Group_Grade.Txt_ActionBefore:SetText(UserExpConfig[list.before_lv_ani].EnergyMax + homeSkll_Energy)
  Group_Grade.Txt_ActionLater:SetText(UserExpConfig[list.temp_lv_ani].EnergyMax + homeSkll_Energy)
  local homeSkll_HomeEnergy = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseEnergyLimited)
  Group_Grade.Txt_HomeEnergyBefore:SetText(UserExpConfig[list.before_lv_ani].homeEnergyMax + homeSkll_HomeEnergy)
  Group_Grade.Txt_HomeEnergyLater:SetText(UserExpConfig[list.temp_lv_ani].homeEnergyMax + homeSkll_HomeEnergy)
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local sound = SoundManager:CreateSound(PlayerData:GetFactoryData(99900002).gradeUp)
    if sound ~= nil then
      sound:Play()
    end
    local list = Json.decode(initParams)
    UserExpConfig = PlayerData:GetFactoryData(99900004).expList
    SkipLevel(list)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
