local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = require("UICharacterInfo/DataModel")
local _DecodeSafeNum = function(safeNumber)
  return math.floor(safeNumber / SafeMath.safeNumberTime)
end
local TransformMapPos = function(position, mousePos)
  local z = View.camera:WorldToScreenPoint(position).z
  local pos = View.camera:ScreenToWorldPoint(Vector3(mousePos.x, mousePos.y, z))
  return pos
end
local UICache = {}
local UITable, lastRoleId
local module = {
  Init = function(self)
    UICache = {}
  end,
  Load = function(self, RoleData, isRefresh)
    if lastRoleId == DataModel.RoleId and DataModel.InitState == false then
      return
    end
    UITable = View.Group_TabInfo
    local Group_TIBottomLeft = UITable.Group_TIBottomLeft
    local Group_TIRight = UITable.Group_TIRight
    local Group_TITop = Group_TIRight.Group_TITop
    if RoleData then
      DataModel.RoleData = RoleData
    end
    if not _Assert(UICache, {
      level = DataModel.RoleData.lv,
      exp = DataModel.RoleData.exp
    }) or DataModel.InitState == true or lv then
      Group_TITop.Img_LevelBottom.Txt_LVNum.self:SetText(tostring(DataModel.RoleData.lv))
      Group_TITop.Group_Awake.Txt_Awake:SetText("")
      self:_set_exp()
    end
    if isRefresh and isRefresh == true then
      DataModel:SetRoleAttributeCurrent()
    end
    Group_TITop.Btn_Attribute.Img_Health.Txt_Value:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.RoleAttributeCurrent[2].num, 0)))
    Group_TITop.Btn_Attribute.Img_Attack.Txt_Value:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.RoleAttributeCurrent[1].num, 0)))
    Group_TITop.Btn_Attribute.Img_Defense.Txt_Value:SetText((PlayerData:GetPreciseDecimalFloor(DataModel.RoleAttributeCurrent[3].num, 0)))
    Group_TITop.Btn_Attribute.Img_AtkRange.Txt_Value:SetText(DataModel.RoleAttributeCurrent[7].num)
    if not _Assert(UICache, {
      name = DataModel.RoleCA.name
    }) or DataModel.InitState == true then
      Group_TIBottomLeft.Txt_NameCH:SetText(DataModel.RoleCA.name)
    end
    Group_TIBottomLeft.Img_Quality:SetSprite(UIConfig.WeaponQuality[DataModel.RoleCA.qualityInt])
    Group_TIBottomLeft.Img_Quality:SetNativeSize()
    if not _Assert(UICache, {
      roleId = DataModel.RoleData.id,
      bkLevel = DataModel.RoleData.awake_lv
    }) or DataModel.InitState == true then
      local _bkTable = UITable.Group_TIRight.Group_TITop.Img_BKBottom
      _bkTable.StaticGrid_BK.grid.self:RefreshAllElement()
      _bkTable.Txt_BKLevel:SetText(UICache.bkLevel)
    end
    local theMiddle = UITable.Group_TIRight.Group_TIMiddle
    if not _Assert(UICache, {
      skill = DataModel.RoleCA.name
    }) or DataModel.InitState == true then
      theMiddle.StaticGrid_Skill.self:RefreshAllElement()
    end
    Group_TIBottomLeft.Group_Camp.Img_Icon:SetSprite(UIConfig.RoleCamp[tonumber(PlayerData:SearchRoleCampInt(DataModel.RoleCA.sideId))])
    local UIEquip = UITable.Group_TIRight.Group_TIBottom
    UIEquip.StaticGrid_Equipment.self:RefreshAllElement()
    local id = DataModel.RoleCA.awakeList[DataModel.RoleData.resonance_lv + 1] and DataModel.RoleCA.awakeList[DataModel.RoleData.resonance_lv + 1].awakeId or DataModel.RoleCA.awakeList[table.count(DataModel.RoleCA.awakeList)].awakeId
    Group_TITop.Img_LevelBottom.Txt_LVNum.Txt_LVAnd.Txt_LVCap:SetText(math.min(PlayerData:GetUserInfo().lv, PlayerData:GetFactoryData(99900001).roleLevelMax))
    local lineCA = PlayerData:GetFactoryData(99900017).enumJobList
    if DataModel.RoleCA.line == 1 or DataModel.RoleCA.line == 0 then
      Group_TIBottomLeft.Group_Station.Txt_Station:SetText(PlayerData:GetFactoryData(lineCA[1].tagId).tagName)
    end
    if DataModel.RoleCA.line == 2 then
      Group_TIBottomLeft.Group_Station.Txt_Station:SetText(PlayerData:GetFactoryData(lineCA[2].tagId).tagName)
    end
    if DataModel.RoleCA.line == 3 then
      Group_TIBottomLeft.Group_Station.Txt_Station:SetText(PlayerData:GetFactoryData(lineCA[3].tagId).tagName)
    end
    Group_TIBottomLeft.Group_Station.Img_Line:SetSprite(UIConfig.CharacterLine[DataModel.RoleCA.line])
    lastRoleId = DataModel.RoleId
    DataModel.AwakeMaxLevel = math.min(PlayerData:GetUserInfo().lv, PlayerData:GetFactoryData(99900001).roleLevelMax)
    View.Group_Files.self:SetActive(false)
    View.Group_TabInfo.Group_TIRight.Group_Attribute.self:SetActive(false)
    View.Group_TabInfo.Group_TIRight.Group_Attribute.StaticGrid_Item.grid.self:RefreshAllElement()
    View.Group_TabInfo.Group_TIRight.Group_Check.self:SetActive(true)
    View.Group_TabInfo.Group_TIRight.Group_Check.Btn_Attribute:SetActive(true)
    View.Group_TabInfo.Group_TIBottomLeft.Group_Type.StaticGrid_Type.self:SetActive(false)
    local count = 0
    if count ~= 0 then
      View.Group_TabInfo.Group_TIBottomLeft.Group_Type.StaticGrid_Type.self:SetActive(true)
      View.Group_TabInfo.Group_TIBottomLeft.Group_Type.StaticGrid_Type.grid.self:RefreshAllElement()
    end
    View.Group_TabInfo.Btn_Trust.Txt_TrustLevel:SetText("LV" .. DataModel.roleTrustLv)
    if DataModel.roleTrustLv >= 10 then
      View.Group_TabInfo.Btn_Trust.Img_Top:SetFilledImgAmount(1)
    else
      View.Group_TabInfo.Btn_Trust.Img_Top:SetFilledImgAmount(DataModel.roleTrustLvExp / DataModel.trustExpList[DataModel.roleTrustLv].exp)
    end
    View.Group_TabInfo.Group_TIRight.Group_TIMiddle.Btn_Close_Des.self:SetActive(false)
  end,
  _set_exp = function(self)
    local Group_TIRight = UITable.Group_TIRight
    local Group_TITop = Group_TIRight.Group_TITop
    local lv = DataModel.RoleData.lv
    local currentExp = DataModel.RoleData.exp
    local endExp = 0
    local ConfigFactory = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
    local isMaxLevel = false
    if lv > #ConfigFactory then
      isMaxLevel = true
    else
      endExp = ConfigFactory[lv].levelUpExp
    end
    Group_TITop.Img_LevelBottom.Txt_EXPNum:SetActive(not isMaxLevel)
    if isMaxLevel then
      Group_TITop.Img_LevelBottom.Img_EXPPB:SetFilledImgAmount(1)
    else
      Group_TITop.Img_LevelBottom.Txt_EXPNum:SetText(currentExp .. "/" .. endExp)
      Group_TITop.Img_LevelBottom.Img_EXPPB:SetFilledImgAmount(currentExp / endExp)
    end
  end
}
return module
