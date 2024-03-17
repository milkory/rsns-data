local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = require("UICharacterInfo/DataModel")
local SkillInfo = require("UICharacterInfo/ViewSkillInfo")
local UICache = {}
local UITable, ChooseIndex, ChooseDownIndex
local baseDesHight = 78
local SetDownSkill = function(obj, row, index)
  obj.transform:Find("Img_WordIcon").transform:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(row.icon)
  obj.transform:Find("Txt_Word").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText("<color=#FFB800>" .. row.tagNameRichText .. "：" .. "</color>" .. row.detail)
  local hight_des = obj.transform:Find("Txt_Word").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
  end
  return Hight
end
local Clear = function()
  if DataModel.InstantiateList then
    for k, v in pairs(DataModel.InstantiateList) do
      Object.Destroy(v)
    end
  end
end
local SetDownAllSkill = function(view_skill, skillData)
  Clear()
  local Group_Detail = view_skill.Group_Detail
  Group_Detail.Txt_Des_Leader:SetText("")
  if skillData.ca.leaderCardConditionDesc ~= nil and skillData.ca.leaderCardConditionDesc ~= "" then
    local tagCA = PlayerData:GetFactoryData(80600356)
    if tagCA.text ~= "" then
      Group_Detail.Txt_Des_Leader:SetText(tagCA.text .. skillData.ca.leaderCardConditionDesc)
    end
  end
  Group_Detail.Txt_SkillName:SetText(skillData.ca.name)
  Group_Detail.Img_Icon:SetSprite(skillData.ca.iconPath)
  Group_Detail.Txt_CardNumber:SetText("")
  if skillData.num then
    Group_Detail.Txt_CardNumber:SetText(string.format(GetText(80600767), skillData.num))
  end
  Group_Detail.Txt_Cost:SetText(string.format(GetText(80600452), math.floor(skillData.cardCA.cost_SN)))
  local lastY = 0
  local img_desc_y = 70
  local img_desc_x = 510
  local top_des_height = img_desc_y
  local lastY_1 = 0
  local lastY_1_Bg = 0
  local count = 1
  local baseViewSpace = 635
  local space = 0
  local Content = view_skill.Group_Detail.ScrollView_Content.Viewport.Content
  Content.self:SetLocalPositionY(0)
  local Parent = Content.transform
  Content.Group_Top.Txt_Desc:SetText(tostring(skillData.ca.description) .. "\n" .. "\n" .. skillData.ca.detailDescription)
  Content.Group_Top.Txt_Desc:OnTextChange()
  Content.Group_Top.Img_Desc:SetImgWidthAndHeight(img_desc_x, 0)
  local des_height = Content.Group_Top.Txt_Desc:GetHeight()
  if img_desc_y < des_height then
    top_des_height = des_height + 10
    Content.Group_Top.Img_Desc:SetImgWidthAndHeight(img_desc_x, 0)
  end
  lastY_1 = lastY_1 - top_des_height
  local Group_Word_Obj = "UI/CharacterInfo/CharacterInfo_splited/Group_Word"
  space = top_des_height
  for i = 1, table.count(skillData.cardCA.tagList) do
    local talentCA = PlayerData:GetFactoryData(skillData.cardCA.tagList[i].tagId)
    if talentCA.isShowDetail == true then
      local obj = View.self:GetRes(Group_Word_Obj, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj:SetActive(true)
      table.insert(DataModel.InstantiateList, obj)
      local hight_des = SetDownSkill(obj, talentCA, count)
      if 0 < hight_des then
        lastY = lastY - hight_des / 2
      end
      lastY_1_Bg = hight_des + hight_des / 2
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      space = space + hight_des + hight
      count = count + 1
    end
  end
  local baseRightHeightBg = 74
  local rightSpace = 15
  local rightLastY = 0 - space
  local rightLastSpace
  local rightYSpace = 0
  local CardDesCharacter = Content
  local initY = 0 - space - rightSpace
  for i = 0, 6 do
    local obj = "Group_" .. i
    CardDesCharacter.Group_Right[obj]:SetActive(false)
    CardDesCharacter.Group_Right[obj].transform.localPosition = Vector3(-50, initY, 0)
  end
  local tagOutsideList = skillData.cardCA.tagOutsideList
  if tagOutsideList and 0 < table.count(tagOutsideList) then
    for i = 1, table.count(tagOutsideList) do
      local v = tagOutsideList[i]
      local tagCA = PlayerData:GetFactoryData(v.tagId)
      if tagCA and tagCA.isShowDetail == true then
        local obj = "Group_" .. i - 1
        CardDesCharacter.Group_Right[obj]:SetActive(true)
        CardDesCharacter.Group_Right[obj].Img_Face_Bg.Img_Face:SetSprite(tagCA.icon)
        CardDesCharacter.Group_Right[obj].Img_Mask:SetSprite(UIConfig.SkillRightPath)
        CardDesCharacter.Group_Right[obj].Txt_Des:SetText("<color=#FFB800>" .. tagCA.tagNameRichText .. "：" .. "</color>" .. tagCA.detail)
        local textHeight = CardDesCharacter.Group_Right[obj].Txt_Des:GetHeight()
        CardDesCharacter.Group_Right[obj].Txt_Des:SetHeight()
        rightLastSpace = baseRightHeightBg
        CardDesCharacter.Group_Right[obj].Img_Bg:SetImgWidthAndHeight(425, baseRightHeightBg)
        CardDesCharacter.Group_Right[obj].Img_Bg:SetActive(false)
        if baseRightHeightBg < textHeight then
          rightLastSpace = textHeight + rightSpace * 2
          rightYSpace = textHeight - baseRightHeightBg + rightSpace
          CardDesCharacter.Group_Right[obj].Img_Bg:SetImgWidthAndHeight(425, rightLastSpace)
        end
        if 1 < i then
          CardDesCharacter.Group_Right[obj].transform.localPosition = Vector3(-50, rightLastY - rightYSpace, 0)
        else
          CardDesCharacter.Group_Right[obj].transform.localPosition = Vector3(-50, initY - rightYSpace, 0)
        end
        rightLastY = rightLastY - rightLastSpace - rightSpace * 2
        space = space + rightLastSpace + rightSpace * 2
      end
    end
  end
  if baseViewSpace < space then
    Group_Detail.ScrollView_Content:SetContentHeight(space)
  end
end
local RefreshSkillpage = function()
  local Group_TabSkill = View.Group_TabSkill
  local skillList = DataModel.RoleCA.skillList
  DataModel.InstantiateList = {}
  for i = 1, table.count(skillList) do
    local obj = "Btn_Card" .. i
    local view_skill = Group_TabSkill[obj]
    view_skill:SetActive(true)
    local skillData = {}
    skillData.ca = PlayerData:GetFactoryData(DataModel.SkillList[i].id)
    skillData.ca.description = DataModel.SkillList[i].des
    skillData.cardCA = PlayerData:GetFactoryData(skillData.ca.cardID)
    skillData.num = skillList[i].num
    view_skill.Group_SkillIcon.Img_MaskSkill.Img_Skill:SetSprite(skillData.ca.iconPath)
    local viewId = DataModel.RoleCA.viewId
    local portrailData = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
    view_skill.Img_Mask.Img_Face:SetSprite(portrailData.roleListResUrl)
    view_skill.Txt_Number:SetText("X " .. skillData.num)
    view_skill.Img_Select:SetActive(false)
    view_skill.Img_Black:SetActive(true)
    view_skill.Img_CardMask.Img_Cost:SetNum(math.floor(skillData.cardCA.cost_SN))
    view_skill.Img_CaptainSkill:SetActive(false)
    if tonumber(i) == 3 and skillData.ca.leaderCardConditionDesc ~= nil and skillData.ca.leaderCardConditionDesc ~= "" then
      view_skill.Img_CaptainSkill:SetActive(true)
    end
  end
end
local ClickChooseTopSkillInfo = function(index)
  if ChooseIndex ~= nil and index == ChooseIndex and ChooseDownIndex == nil then
    return
  end
  local Group_TabSkill = View.Group_TabSkill
  Group_TabSkill.Img_SkillBase.Img_Nocard.self:SetActive(true)
  if ChooseIndex then
    local obj_old = "Btn_Card" .. ChooseIndex
    local view_skill_old = Group_TabSkill[obj_old]
    view_skill_old.Img_Select:SetActive(false)
    view_skill_old.Img_Black:SetActive(true)
  end
  local obj = "Btn_Card" .. index
  local view_skill = Group_TabSkill[obj]
  view_skill.Img_Select:SetActive(true)
  view_skill.Img_Select["Img_sin" .. index]:SetActive(false)
  view_skill.Img_Black:SetActive(false)
  local skillData = {}
  skillData.ca = PlayerData:GetFactoryData(DataModel.SkillList[index].id)
  skillData.ca.description = DataModel.SkillList[index].des
  skillData.cardCA = PlayerData:GetFactoryData(skillData.ca.cardID)
  skillData.num = DataModel.RoleCA.skillList[index].num
  SetDownAllSkill(Group_TabSkill, skillData)
  ChooseIndex = index
  Group_TabSkill.ScrollGrid_ExCard.self:SetActive(false)
  Group_TabSkill.Img_ExCardBase.self:SetActive(false)
  local deriveCardListCount = table.count(DataModel.SkillList[index].ExSkillList)
  if deriveCardListCount ~= 0 then
    Group_TabSkill.Img_SkillBase.Img_Nocard.self:SetActive(false)
    view_skill.Img_Select["Img_sin" .. index]:SetActive(true)
    DataModel.deriveCardList = DataModel.SkillList[index].ExSkillList
    Group_TabSkill.Img_ExCardBase.self:SetActive(true)
    Group_TabSkill.ScrollGrid_ExCard.self:SetActive(true)
    ChooseDownIndex = nil
    Group_TabSkill.ScrollGrid_ExCard.grid.self:MoveToTop()
    Group_TabSkill.ScrollGrid_ExCard.grid.self:SetDataCount(deriveCardListCount)
    Group_TabSkill.ScrollGrid_ExCard.grid.self:RefreshAllElement()
  end
end
local ClickChooseDownSkillInfo = function(index)
  if ChooseDownIndex ~= nil and index == ChooseDownIndex then
    return
  end
  local Group_TabSkill = View.Group_TabSkill
  if ChooseIndex then
    local obj_old = "Btn_Card" .. ChooseIndex
    local view_skill_old = Group_TabSkill[obj_old]
    view_skill_old.Img_Black:SetActive(true)
  end
  if ChooseDownIndex then
    local element = DataModel.deriveCardList[ChooseDownIndex].element
    local Btn_ExCard = element.Btn_ExCard
    Btn_ExCard.Img_Select:SetActive(false)
    Btn_ExCard.Img_Black:SetActive(true)
  end
  local element = DataModel.deriveCardList[index].element
  local Btn_ExCard = element.Btn_ExCard
  Btn_ExCard.Img_Select:SetActive(true)
  Btn_ExCard.Img_Black:SetActive(false)
  local row = DataModel.deriveCardList[index]
  local skillData = {}
  skillData.ca = PlayerData:GetFactoryData(row.ExSkillName)
  skillData.ca.description = row.description
  skillData.cardCA = PlayerData:GetFactoryData(skillData.ca.cardID)
  SetDownAllSkill(Group_TabSkill, skillData)
  ChooseDownIndex = index
end
local module = {
  skillSelectIndex = 1,
  Init = function(self)
    UICache = {}
  end,
  Load = function(self)
    if _Assert(UICache, {
      roleId = DataModel.RoleData.id,
      awakeLevel = DataModel.RoleData.awakeLevel
    }) and DataModel.InitState == false then
      return
    end
    UITable = View.Group_TabSkill
    ChooseIndex = nil
    ChooseDownIndex = nil
    RefreshSkillpage()
    ClickChooseTopSkillInfo(1)
  end,
  RefreshSkillLvUp = function(self)
    local state, updateLv, maxLv = PlayerData:GetNotSkillUpdate(DataModel.RoleId, self.skillSelectIndex)
    local level = PlayerData:GetRoleSkillLv(DataModel.RoleId, self.skillSelectIndex)
    if level == maxLv then
      View.Group_SkillLvup.self:SetActive(false)
    else
      SkillInfo:SkillUp(self.skillSelectIndex)
    end
    self:SelectSkill(self.skillSelectIndex)
  end,
  SelectSkill = function(self, index)
    local grid = View.Group_TabSkill.StaticGrid_Skill.grid
    self.skillSelectIndex = index
    grid.self:RefreshAllElement()
    local state, updateLv, maxLv = PlayerData:GetNotSkillUpdate(DataModel.RoleId, self.skillSelectIndex)
    if state == true then
      SkillInfo:SkillUp(self.skillSelectIndex)
    elseif updateLv == maxLv then
    end
  end,
  SkillUp = function(self)
    local level = 1
    local level = PlayerData:GetRoleSkillLv(DataModel.RoleId, self.skillSelectIndex)
    local unitLevelList, skillMaterialList, levelMax = PlayerData:GetUnitSkillFactory(self.skillSelectIndex, DataModel.RoleId)
    local isEnough = true
    local items = {}
    local materialList = PlayerData:GetListFactory(skillMaterialList[level].id).materialList
    for i, v in ipairs(materialList) do
      local haveNum = PlayerData:GetGoodsById(v.id).num
      if haveNum < v.num and isEnough then
        isEnough = false
        break
      end
      items[v.id] = v.num
    end
    if not isEnough then
      CommonTips.OpenTips(80600062)
      return
    end
    Net:SendProto("hero.upgrade_skill", function(json)
      DataModel.RoleData = PlayerData:GetRoleById(DataModel.RoleId)
      CommonTips.OpenTips(80600072)
      PlayerData:RefreshUseItems(items)
      self:RefreshSkillLvUp()
    end, tostring(DataModel.RoleId), self.skillSelectIndex)
  end,
  ClickChooseTopSkillInfo = function(self, index)
    ClickChooseTopSkillInfo(index)
  end,
  ClickChooseDownSkillInfo = function(self, index)
    ClickChooseDownSkillInfo(index)
  end
}
return module
