local DataModel = require("UICharacterList/UICharacterListDataModel")
local line = {}
local module = {
  SetElement = function(element, data)
    local id = tostring(data.id)
    element.Img_Selected:SetActive(id == DataModel.selectRoleId)
    element.Txt_LVNum:SetText(data.lv)
    element.Group_Break.StaticGrid_BK.grid.self:RefreshAllElement()
    element.Group_Awake.Img_Awake:SetSprite(UIConfig.AwakeCommon[data.resonance_lv + 1])
    local portraitId = PlayerData:GetRoleById(id).current_skin[1]
    local ca = PlayerData:GetFactoryData(id)
    local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    element.Img_Mask.Img_Character:SetSprite(portrailData.roleListResUrl)
    if PlayerData:GetRoleById(id).current_skin[2] == 1 and ca.isSpine2 == 1 then
      element.Img_Mask.Img_Character:SetSprite(portrailData.State2RoleListRes)
    end
    element.Img_Mask.Img_Character:SetActive(true)
    local ca = PlayerData:GetFactoryData(data.id, "UnitFactory")
    element.Txt_Name:SetText(ca.name)
    if UIConfig.BottomConfig[ca.qualityInt] then
      element.Img_Bottom:SetActive(true)
      element.Img_Decorate:SetActive(true)
      element.Img_Bottom:SetSprite(UIConfig.CharacterBottom[ca.qualityInt])
      element.Img_Decorate:SetSprite(UIConfig.CharacterDecorate[ca.qualityInt])
    else
      element.Img_Bottom:SetActive(false)
      element.Img_Decorate:SetActive(false)
    end
    local Group_SkillColor = element.Group_SkillColor
    local cardList = PlayerData:GetRoleCardList(ca.id)
    for i = 1, table.count(cardList) do
      local obj = "Group_SkillColor" .. i
      local cardCA = PlayerData:GetFactoryData(cardList[table.count(cardList) - i + 1].id)
      local color = cardCA.color
      Group_SkillColor[obj].Img_Color:SetSprite(UIConfig.CharacterSkillColor[color])
    end
    local Group_Locate = Group_SkillColor.Group_Locate
    Group_Locate.Img_Line:SetSprite(UIConfig.CharacterLine[ca.line])
    element.Img_RedPiont:SetActive(PlayerData:GetAllRoleAwakeRedID(id))
  end
}
return module
