local View = require("UIGroup_ResonanceSuccess/UIGroup_ResonanceSuccessView")
local DataModel = require("UIGroup_ResonanceSuccess/UIGroup_ResonanceSuccessDataModel")
local ViewFunction = require("UIGroup_ResonanceSuccess/UIGroup_ResonanceSuccessViewFunction")
local bg_base_fill = 0.45
local bg_base_h = 800
local txt_base = 100
local ShowNewResonance = function(talentId)
  View.self:SetActive(true)
  local data = PlayerData:GetFactoryData(talentId, "AwakeFactory")
  print_r(data)
  View.Txt_Name:SetText(data.name)
  View.Txt_Des:SetText(data.desc)
  View.Img_Bg:SetImgWidthAndHeight(3000, View.Txt_Des:GetHeight() + bg_base_h * bg_base_fill)
  View.Img_Icon:SetSprite(data.path)
  View.Txt_UnlockTitle:SetText((string.format(GetText(80600419), DataModel.RoleData.resonance_lv)))
  View.Img_IconBgRound:SetActive(false)
  View.Img_IconBg:SetActive(false)
  if DataModel.RoleData.resonance_lv == 5 then
    View.Img_IconBgRound:SetActive(true)
  else
    View.Img_IconBg:SetActive(true)
  end
  local homeSkillList = DataModel.RoleCA.homeSkillList
  local life_id, need_lv
  local skillPreParamRecord = {}
  for i, v in ipairs(homeSkillList) do
    if v.nextIndex and v.nextIndex > 0 then
      local nextId = homeSkillList[v.nextIndex].id
      local cfg = PlayerData:GetFactoryData(v.id, "HomeSkillFactory")
      skillPreParamRecord[nextId] = cfg.param
    end
    if v.resonanceLv == DataModel.RoleData.resonance_lv then
      life_id = v.id
      need_lv = v.resonanceLv
      break
    end
  end
  View.Group_LifeSkillDesc:SetActive(false)
  if life_id then
    local life_cfg = PlayerData:GetFactoryData(life_id)
    View.Group_LifeSkillDesc.Img_Lock:SetActive(need_lv > DataModel.RoleData.resonance_lv)
    local desc = life_cfg.desc
    if life_cfg.isReplace then
      local param = life_cfg.param
      if skillPreParamRecord[life_id] then
        param = param + skillPreParamRecord[life_id]
      end
      if life_cfg.isPCT then
        param = param * 100
      else
        param = math.modf(param)
      end
      desc = string.format(desc, param)
    end
    View.Group_LifeSkillDesc.Txt_SkillDesc:SetWidth(500)
    View.Group_LifeSkillDesc.Txt_SkillDesc:SetText(desc)
    View.Group_LifeSkillDesc.Txt_SkillName:SetText(life_cfg.name)
    View.Group_LifeSkillDesc:SetActive(true)
    View.Group_LifeSkillDesc.self:SetLocalPositionY(-165 - View.Txt_Des:GetHeight())
    View.Img_Bg:SetFilledImgAmount(View.Txt_Des:GetHeight() / bg_base_h + bg_base_fill + 75 / bg_base_h)
  end
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local list = Json.decode(initParams)
    DataModel.RoleData = list.RoleData
    DataModel.RoleCA = list.RoleCA
    View.self:PlayAnim("ResonanceSuccessIn")
    ShowNewResonance(list.id)
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
