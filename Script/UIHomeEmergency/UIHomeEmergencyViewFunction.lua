local View = require("UIHomeEmergency/UIHomeEmergencyView")
local DataModel = require("UIHomeEmergency/UIHomeEmergencyDataModel")
local ViewFunction = {
  HomeEmergency_characterList_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  HomeEmergency_characterList_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  HomeEmergency_characterList_Group_TopLeft_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeEmergency_characterList_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomeEmergency_characterList_Group_TopRight_Btn_Level_Click = function(btn, str)
    DataModel.RefreshRoleListPanel(DataModel.ESortType.level)
  end,
  HomeEmergency_characterList_Group_TopRight_Btn_Rarity_Click = function(btn, str)
    DataModel.RefreshRoleListPanel(DataModel.ESortType.quality)
  end,
  HomeEmergency_characterList_Group_TopRight_Btn_Time_Click = function(btn, str)
    DataModel.RefreshRoleListPanel(DataModel.ESortType.time)
  end,
  HomeEmergency_characterList_Group_TopRight_Btn_Comat_Click = function(btn, str)
  end,
  HomeEmergency_characterList_ScrollGrid__SetGrid = function(element, elementIndex)
    local info = DataModel.allCanLiveInCharacter[elementIndex]
    element.Group_Character.Group_State:SetActive(info.liveInfo ~= nil)
    element.Group_Character.Img_Bottom:SetSprite(UIConfig.CharacterBottom[info.qualityInt])
    element.Group_Character.Img_Character.Img_Character:SetSprite(info.roleListResUrl)
    element.Group_Character.Btn_Item:SetClickParam(info.id)
    element.Group_Character.Txt_Name:SetText(info.name)
    element.Group_Character.Txt_LVNum:SetText(info.lv)
    element.Group_Character.Group_Awake.Img_Awake:SetSprite("UI/Common/Common_icon_Awake_" .. info.awake_lv)
    local ca = PlayerData:GetFactoryData(info.id, "UnitFactory")
    local cardList = PlayerData:GetRoleCardList(ca.id)
    local portraitId = PlayerData:GetRoleById(info.id).current_skin[1]
    local unitViewCA = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    element.Group_Character.Img_Character.Img_Character:SetSprite(unitViewCA.roleListResUrl)
    if PlayerData:GetRoleById(info.id).current_skin[2] == 1 and ca.isSpine2 == 1 then
      element.Group_Character.Img_Character.Img_Character:SetSprite(unitViewCA.State2RoleListRes)
    end
    for i = 1, table.count(cardList) do
      local cardCA = PlayerData:GetFactoryData(cardList[table.count(cardList) - i + 1].id)
      local color = cardCA.color
      element.Group_Character.Group_SkillColor["Group_SkillColor" .. i].Img_Color:SetSprite(UIConfig.CharacterSkillColor[color])
    end
    local Group_Locate = element.Group_Character.Group_SkillColor.Group_Locate
    Group_Locate.Img_Line:SetSprite(UIConfig.CharacterLine[ca.line])
    DataModel.roleIndex = elementIndex
    element.Group_Character.Group_Break.StaticGrid_BK.grid.self:RefreshAllElement()
    element.Group_Character.Img_Decorate:SetSprite(UIConfig.CharacterDecorate[info.qualityInt])
    element.Group_Character.Img_MedicalPoint.Group_Contain.Txt_Num:SetText(ca.medicalPoint)
  end,
  HomeEmergency_characterList_ScrollGrid__Group_Item_Group_Character_Btn_Mask_Click = function(btn, str)
  end,
  HomeEmergency_characterList_ScrollGrid__Group_Item_Group_Character_Group_Break_StaticGrid_BK_SetGrid = function(element, elementIndex)
    local roleData = DataModel.allCanLiveInCharacter[DataModel.roleIndex]
    element.Img_On:SetActive(elementIndex <= roleData.awake_lv)
  end,
  HomeEmergency_characterList_ScrollGrid__Group_Item_Group_Character_Btn_Item_Click = function(btn, str)
    UIManager:GoBack(false)
    DataModel.RefreshFurRoleData(str)
  end
}
return ViewFunction
