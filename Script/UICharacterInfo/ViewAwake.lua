local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = require("UICharacterInfo/DataModel")
local UICache = {}
local module = {
  Init = function(self)
    UICache = {}
  end,
  Load = function(self, RoleData, isUpdate)
    if _Assert(UICache, {
      roleId = DataModel.RoleData.id,
      breakLevel = DataModel.RoleData.awake_lv
    }) and DataModel.InitState == false then
      return
    end
    if RoleData then
      DataModel.RoleData = RoleData
    end
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabAwake")
    local Group_TabAwake = View.Group_TabAwake
    Group_TabAwake.Group_AwakeCheck.self:SetActive(false)
    View.Group_TabAwake.Btn_CloseCheck:SetActive(false)
    View.Group_Middle.Img_BlackMask:SetActive(false)
    local level = DataModel.RoleData.awake_lv
    local ca = DataModel.RoleCA
    Group_TabAwake.Btn_BK:SetActive(true)
    if level < #ca.breakthroughList - 1 then
      local grid = Group_TabAwake.StaticGrid_Item.grid.self
      grid:RefreshAllElement()
      grid:SetActive(true)
      Group_TabAwake.Group_BK.Group_Current.StaticGrid_BK.grid.self:RefreshAllElement()
      Group_TabAwake.Group_BK.Group_Next.StaticGrid_BK.grid.self:RefreshAllElement()
      Group_TabAwake.Group_Max.self:SetActive(false)
      Group_TabAwake.Group_BK.self:SetActive(true)
      Group_TabAwake.Group_BK.Group_Current.Txt_BK:SetText("觉醒 " .. DataModel.RoleData.awake_lv)
      Group_TabAwake.Group_BK.Group_Next.Txt_BK:SetText("觉醒 " .. DataModel.RoleData.awake_lv + 1)
      Group_TabAwake.Group_TalentLock:SetActive(false)
      Group_TabAwake.Group_Icon1.Group_SkillIcon5.SpineNode_TalentLock:SetActive(false)
    else
      Group_TabAwake.StaticGrid_Item.grid.self:SetActive(false)
      Group_TabAwake.Group_BK.self:SetActive(false)
      Group_TabAwake.Group_Max.self:SetActive(true)
      Group_TabAwake.Btn_BK:SetActive(false)
      Group_TabAwake.Group_TalentLock:SetActive(true)
      Group_TabAwake.Group_Icon1.Group_SkillIcon5.SpineNode_TalentLock:SetActive(false)
      local isAwLock = PlayerData:IsRoleAwakeLock(ca.id)
      if isAwLock then
        Group_TabAwake.Group_TalentLock:SelectPlayAnim("")
        Group_TabAwake.Group_Icon1.Group_SkillIcon5.SpineNode_TalentLock:SetActive(true)
        if isUpdate then
          Group_TabAwake.Group_Icon1.Group_SkillIcon5.SpineNode_TalentLock:SetAction("juexing_suo01", false, true)
          Group_TabAwake.Group_TalentLock:SelectPlayAnim("TalentLockOff")
        else
          Group_TabAwake.Group_Icon1.Group_SkillIcon5.SpineNode_TalentLock:SetAction("juexing_suo02", false, true)
          Group_TabAwake.Group_TalentLock:SelectPlayAnim("TalentLockOffStay")
        end
      else
        Group_TabAwake.Group_TalentLock:SelectPlayAnim("")
        if isUpdate then
          Group_TabAwake.Group_Icon1.Group_SkillIcon5.SpineNode_TalentLock:SetActive(true)
          Group_TabAwake.Group_Icon1.Group_SkillIcon5.SpineNode_TalentLock:SetAction("juexing_suo03", false, true)
          Group_TabAwake.Group_TalentLock:SelectPlayAnim("TalentLockOn")
        else
          Group_TabAwake.Group_TalentLock:SelectPlayAnim("TalentLockOnStay")
        end
      end
    end
    local Group_Icon1 = Group_TabAwake.Group_Icon1
    for i = 1, 5 do
      local img = "Group_SkillIcon" .. i
      local Group_Off = Group_Icon1[img].Group_Off
      local Group_On = Group_Icon1[img].Group_On
      local Img_lightselect = Group_Icon1[img].Img_lightselect
      local Img_BreakthroughSelect = Group_Icon1[img].Img_BreakthroughSelect
      Group_Off:SetActive(false)
      Group_On:SetActive(false)
      Img_lightselect:SetActive(false)
      Group_On.Img_Icon:SetSprite(PlayerData:GetFactoryData(ca.breakthroughList[i + 1].breakthroughId).path)
      Group_Off.Img_Icon:SetSprite(PlayerData:GetFactoryData(ca.breakthroughList[i + 1].breakthroughId).path)
      Img_BreakthroughSelect:SetActive(false)
      if level < i then
        Group_Off:SetActive(true)
        Group_Off.Img_Lock.Txt_Lock:SetText(string.format(GetText(80600417), i))
      else
        Group_On:SetActive(true)
        if level == i then
          Img_BreakthroughSelect:SetActive(true)
        end
      end
    end
    for i = 1, 4 do
      local Img = "Group_Line" .. i
      local Img_LineOff = Group_Icon1[Img].Img_LineOff
      local Img_LineOn = Group_Icon1[Img].Img_LineOn
      Img_LineOff:SetActive(true)
      Img_LineOn:SetActive(false)
      if level > i then
        Img_LineOn:SetActive(true)
      end
    end
  end
}
return module
