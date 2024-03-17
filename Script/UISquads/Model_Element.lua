local DataModel = require("UISquads/UISquadsDataModel")
local module = {
  SetElement = function(self, element, data)
    if element.current == nil then
      element.current = {}
    end
    local unitData = PlayerData:GetFactoryData(data.unitId, "UnitFactory")
    if unitData == nil then
      return
    end
    DataModel.curRefreshElement = element
    local ca = PlayerData:GetFactoryData(data.unitId)
    self:_SetRoleQuality(element, unitData.qualityInt)
    self:_SetRoleLevel(element, data.lv)
    self:_SetPortrait(element, data.unitId, ca)
    self:_SetRoleName(element, unitData.name)
    self._SetRoleCard(element, data)
    self._SetLine(element, ca)
    local currentRole = PlayerData:GetRoleById(data.unitId)
    local hasBatman = next(currentRole) == nil
    local expPercent = 1
    if not hasBatman then
      local expList = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
      local length = #expList
      if length < data.lv then
        expPercent = 1
      else
        expPercent = currentRole.exp / expList[data.lv].levelUpExp
      end
      element.Group_Awake.Img_Awake:SetSprite(UIConfig.AwakeCommon[data.resonanceLv + 1])
      self:_SetBreakThrough(element, data.awakeLv)
    end
    element.Group_LV.Group_ExpBar.Img_Bar:SetFilledImgAmount(expPercent)
    element.Group_Awake.Img_Awake:SetSprite(UIConfig.AwakeCommon[data.resonanceLv + 1])
    self:_SetBreakThrough(element, data.awakeLv)
    local ca = PlayerData:GetFactoryData(data.unitId)
    element.Group_Camp.Img_Mask.Img_Camp:SetSprite(UIConfig.RoleCamp[tonumber(PlayerData:SearchRoleCampInt(ca.sideId))])
    DataModel.curRefreshElement = nil
  end,
  _SetRoleQuality = function(self, element, rarityInt)
    if not _Assert(element.current, {Rarity = rarityInt}) then
      element.Img_Rarity:SetSprite(UIConfig.SquadsRarity[rarityInt])
    end
  end,
  _SetRoleCareer = function(self, element, careerInt)
    if not _Assert(element.current, {Career = careerInt}) then
    end
  end,
  _SetRoleLevel = function(self, element, level)
    if not _Assert(element.current, {Level = level}) then
      element.Group_LV.Txt_LVNum:SetText(level)
    end
  end,
  _SetPortrait = function(self, element, unitId, ca)
    if not _Assert(element.current, {UnitId = unitId}) then
      local server = PlayerData:GetRoleById(unitId)
      local portraitId = PlayerData:GetFactoryData(unitId).viewId
      local isServer = false
      if server and table.count(server) ~= 0 then
        isServer = true
        portraitId = server.current_skin[1]
      end
      local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
      element.Img_Mask.Img_Character:SetSprite(portrailData.squadsHalf1)
      if portrailData.squadsHalf1 == "" then
        element.Img_Mask.Img_Character:SetSprite(portrailData.roleListResUrl)
      end
      if isServer == true and server.current_skin[2] == 1 and ca.isSpine2 == 1 then
        element.Img_Mask.Img_Character:SetSprite(portrailData.squadsHalf2)
      end
      local posX = portrailData.squadsX or 0
      local posY = portrailData.squadsY or 0
      element.Img_Mask.Img_Character.transform.position.y = posY
      element.Img_Mask.Img_Character.transform.position.x = posX
    end
  end,
  _SetRoleName = function(self, element, roleName)
    if not _Assert(element.current, {RoleName = roleName}) then
      element.Txt_Name:SetText(roleName)
    end
  end,
  _SetBreakThrough = function(self, element, breakthrough)
    if not _Assert(element.current, {BreakThroughLv = breakthrough}) then
      element.Group_Break.StaticGrid_BK.grid.self:RefreshAllElement()
    end
  end,
  _SetLine = function(element, ca)
    local Group_SkillColor = element.Group_SkillColor
    local Group_Locate = Group_SkillColor.Group_Locate
    Group_Locate.Img_Line:SetSprite(UIConfig.CharacterLine[ca.line])
  end,
  _SetRoleCard = function(element, data)
    local Group_SkillColor = element.Group_SkillColor
    local cardList = PlayerData:GetRoleCardList(data.unitId)
    for i = 1, table.count(cardList) do
      local obj = "Group_SkillColor" .. i
      local cardCA = PlayerData:GetFactoryData(cardList[table.count(cardList) - i + 1].id)
      local color = cardCA.color
      Group_SkillColor[obj].Img_Color:SetSprite(UIConfig.CharacterSkillColor[color])
    end
  end
}
return module
