local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = require("UICharacterInfo/DataModel")
local module = {
  skillSelectIndex = 1,
  SkillUp = function(self, index)
    self.skillSelectIndex = index
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_SkillLvup")
    View.Group_SkillLvup.self:SetActive(true)
    local skillId = DataModel.RoleCA.skillList[tonumber(index)].skillId
    local skillData = PlayerData:GetFactoryData(skillId, "SkillFactory")
    local level = PlayerData:GetRoleSkillLv(DataModel.RoleId, index)
    local str = SkillFactory:GetSkillLvupDetail(tonumber(skillId), level)
    local Group_Now = View.Group_SkillLvup.Group_Now
    Group_Now.Txt_Name:SetText(skillData.name)
    Group_Now.Txt_LvNum.self:SetText(level)
    Group_Now.Img_Icon:SetSprite(skillData.iconPath)
    Group_Now.Img_Desc.Txt_Desc:SetText(str)
    Group_Now.Img_Type.Txt_Des:SetText(skillData.typeStr)
    local levelUp = level + 1
    local strUp = SkillFactory:GetSkillLvupDetail(tonumber(skillId), levelUp)
    local Group_Next = View.Group_SkillLvup.Group_Next
    Group_Next.Txt_Name:SetText(skillData.name)
    Group_Next.Txt_LvNum.self:SetText(levelUp)
    Group_Next.Img_Icon:SetSprite(skillData.iconPath)
    Group_Next.Img_Desc.Txt_Desc:SetText(strUp)
    local costNum = skillData.cardID and PlayerData:GetFactoryData(skillData.cardID, "cardFactory").cost_SN or nil
    if costNum == nil or costNum == "" or costNum == 0 then
      Group_Next.Txt_Cost:SetActive(false)
      Group_Now.Txt_Cost:SetActive(false)
    else
      Group_Next.Txt_Cost:SetActive(true)
      Group_Next.Txt_Cost:SetText("Cost " .. math.ceil(costNum))
      Group_Now.Txt_Cost:SetActive(true)
      Group_Now.Txt_Cost:SetText("Cost " .. math.ceil(costNum))
    end
    local a, skillMaterialList = PlayerData:GetUnitSkillFactory(self.skillSelectIndex, DataModel.RoleId)
    if table.GetTableState(skillMaterialList) then
      local materialList = PlayerData:GetListFactory(skillMaterialList[level].id).materialList
      if table.GetTableState(materialList) then
        DataModel.UpdateMaterialList(materialList)
        View.Group_SkillLvup.StaticGrid_Item.grid.self:SetActive(true)
        View.Group_SkillLvup.StaticGrid_Item.grid.self:RefreshAllElement()
      end
    else
      View.Group_SkillLvup.StaticGrid_Item.grid.self:SetActive(false)
    end
    local cardCA = PlayerData:GetFactoryData(skillData.cardID)
    Group_Now.Img_Icon:SetColor(Color.white)
    Group_Next.Img_Icon:SetColor(Color.white)
    if cardCA.color == "Red" then
      Group_Now.Img_Icon:SetColor(GameSetting.redCardColor)
      Group_Next.Img_Icon:SetColor(GameSetting.redCardColor)
    end
    local state, updateLv, maxLv = PlayerData:GetNotSkillUpdate(DataModel.RoleId, index)
    if state == false then
      View.Group_SkillLvup.Btn_LvLock.self:SetActive(true)
      if PlayerData:GetRoleSkillLv(DataModel.RoleId, index) == maxLv then
        View.Group_SkillLvup.Btn_LvLock.Txt_T:SetText("Lv.Max")
      else
        View.Group_SkillLvup.Btn_LvLock.Txt_T:SetText(string.format(GetText(80600239), updateLv))
      end
    else
      View.Group_SkillLvup.Btn_LvLock.self:SetActive(false)
    end
  end
}
return module
