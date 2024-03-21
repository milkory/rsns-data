local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = require("UICharacterInfo/DataModel")
local UICache = {}
local Group_TATop
local module = {
  Init = function(self)
    UICache = {}
  end,
  Load = function(self, RoleData)
    Group_TATop = {}
    DataModel.TabResonance_Lock = true
    DataModel.RightResonanceIndex = nil
    DataModel.tempLevel = DataModel.RoleData.re_lv
    DataModel.tempExp = DataModel.RoleData.re_exp
    Group_TATop = View.Group_TabResonance.Group_TATop
    if RoleData then
      DataModel.RoleData = RoleData
    end
    self:Refresh(false)
  end,
  Refresh = function(self, isUpDate)
    local level = DataModel.RoleData.resonance_lv
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabResonance")
    View.self:SetRaycastBlock(true)
    local Group_AwakeIcon = View.Group_TabResonance.Group_AwakeIcon
    local isMax = false
    View.Group_TabResonance.Group_ResonanceCheck.self:SetActive(false)
    View.Group_TabResonance.Btn_CloseCheck:SetActive(false)
    View.Group_Middle.Img_BlackMask:SetActive(false)
    Group_AwakeIcon.Group_Stage05.Img_Icon:SetAlpha(0.19607843137254902)
    local isRnLock = PlayerData:IsRoleResonanceLock(DataModel.RoleCA.id)
    Group_AwakeIcon.Group_Stage05.SpineNode_TalentLock:SetActive(false)
    Group_AwakeIcon.Group_Stage04.SpineNode_TalentLock:SetActive(false)
    if level == table.count(DataModel.RoleCA.awakeList) - 1 then
      isMax = true
      Group_AwakeIcon.Group_Stage05.Img_Icon:SetAlpha(1)
      if isRnLock then
        Group_AwakeIcon["Group_Stage0" .. level].SpineNode_TalentLock:SetActive(true)
        if isUpDate then
          Group_AwakeIcon["Group_Stage0" .. level].SpineNode_TalentLock:SetAction("gongzheng_suo01", false, true)
        else
          Group_AwakeIcon["Group_Stage0" .. level].SpineNode_TalentLock:SetAction("gongzheng_suo02", false, true)
        end
      elseif isUpDate then
        Group_AwakeIcon["Group_Stage0" .. level].SpineNode_TalentLock:SetActive(true)
        Group_AwakeIcon["Group_Stage0" .. level].SpineNode_TalentLock:SetAction("gongzheng_suo03", false, true)
      end
    end
    for i = 1, 4 do
      local talentId = DataModel.RoleCA.talentList[i].talentId
      local data = PlayerData:GetFactoryData(talentId, "AwakeFactory")
      local img = "Group_Stage0" .. i
      local Group_Off = Group_AwakeIcon[img].Group_Off
      local Group_On = Group_AwakeIcon[img].Group_On
      local Img_resonanceselect = Group_AwakeIcon[img].Img_resonanceselect
      Img_resonanceselect:SetActive(false)
      Group_On.Group_Talent.Img_Icon:SetSprite(data.path)
      Group_Off.Group_Talent.Img_Icon:SetSprite(data.path)
      Group_Off:SetActive(false)
      Group_On:SetActive(false)
      Group_On.Img_Gold:SetActive(false)
      Group_Off.Txt_Stage:SetText(string.format(GetText(80600415), i))
      if level < i then
        Group_Off:SetActive(true)
      else
        Group_On:SetActive(true)
      end
    end
    if isMax == true then
      for k = 1, 4 do
        local img = "Group_Stage0" .. k
        local Group_On = Group_AwakeIcon[img].Group_On
        Group_On.Img_Gold:SetActive(true)
      end
    end
    Group_AwakeIcon.Group_Stage05.Img_Icon:SetSprite(UIConfig.CharacterResonanceFive)
    if DataModel.RoleCA.talentList[5] then
      local talentId = DataModel.RoleCA.talentList[5].talentId
      local data = PlayerData:GetFactoryData(talentId, "AwakeFactory")
      Group_AwakeIcon.Group_Stage05.Img_Icon:SetSprite(data.path)
      local Img_resonanceselect = Group_AwakeIcon.Group_Stage05.Img_resonanceselect
      Img_resonanceselect:SetActive(false)
    end
    local Group_TabResonance = View.Group_TabResonance
    local grid = View.Group_TabResonance.ScrollGrid_Item.grid.self
    Group_TabResonance.Btn_Awake:SetActive(true)
    Group_TabResonance.Btn_LvLock.self:SetActive(false)
    if isMax == false then
      DataModel.TabResonance_Lock = false
      local awakeId = DataModel.RoleCA.awakeList[level + 1].awakeId
      local data = PlayerData:GetFactoryData(awakeId, "AwakeFactory")
      grid:SetDataCount(table.count(data.materialList))
      grid:RefreshAllElement()
      grid:SetActive(true)
      Group_TabResonance.Group_Max.self:SetActive(false)
      Group_TabResonance.Group_TalentLock:SetActive(false)
      if data.level <= DataModel.RoleData.lv then
        Group_TabResonance.Btn_Awake.self:SetActive(true)
        Group_TabResonance.Btn_LvLock.self:SetActive(false)
      else
        Group_TabResonance.Btn_Awake.self:SetActive(false)
        Group_TabResonance.Btn_LvLock.self:SetActive(true)
        Group_TabResonance.Btn_LvLock.Txt_T:SetText(string.format(GetText(80600239), data.level))
      end
    else
      grid:SetActive(false)
      Group_TabResonance.Group_Max.self:SetActive(true)
      Group_TabResonance.Group_TalentLock:SetActive(true)
      if isRnLock then
        Group_TabResonance.Group_TalentLock:SelectPlayAnim("")
        if isUpDate then
          Group_TabResonance.Group_TalentLock:SelectPlayAnim("TalentLockOff")
        else
          Group_TabResonance.Group_TalentLock:SelectPlayAnim("TalentLockOffStay")
        end
      else
        Group_TabResonance.Group_TalentLock:SelectPlayAnim("")
        if isUpDate then
          Group_TabResonance.Group_TalentLock:SelectPlayAnim("TalentLockOn")
        else
          Group_TabResonance.Group_TalentLock:SelectPlayAnim("TalentLockOnStay")
        end
      end
      Group_TabResonance.Btn_Awake:SetActive(false)
      Group_TabResonance.Btn_LvLock.self:SetActive(false)
    end
    local level_a = "<color=white>" .. level .. "</color>"
    Group_TabResonance.Group_Text.Group_Ed.Txt_Stage3:SetText(string.format(GetText(80600416), level_a))
    Group_TabResonance.Group_Tips.self:SetActive(false)
  end
}
return module
