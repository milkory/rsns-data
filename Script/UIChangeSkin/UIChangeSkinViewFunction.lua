local View = require("UIChangeSkin/UIChangeSkinView")
local DataModel = require("UIChangeSkin/UIChangeSkinDataModel")
local ViewFunction = {
  ChangeSkin_Group_RightPanel_Group_Top_ScrollGrid_SkinType_SetGrid = function(element, elementIndex)
    local skinType = DataModel.skinTypes[elementIndex]
    DataModel.skinTypeElements[skinType] = element
    local typeCA = PlayerData:GetFactoryData(skinType, "TagFactory")
    element.Txt_:SetText(typeCA.name)
    local select = DataModel.curSkinType == skinType
    local iconPath = select and typeCA.selectIconPath or typeCA.unSelectIconPath
    element.Img_Icon:SetSprite(iconPath)
    element.Btn_:SetClickParam(skinType)
  end,
  ChangeSkin_Group_RightPanel_Group_Top_ScrollGrid_SkinType_Group_Item_Btn__Click = function(btn, str)
    if DataModel.curSkinType and DataModel.curSkinType == tonumber(str) then
      return
    end
    if DataModel.curSkinType then
      local oldSkinTypeCA = PlayerData:GetFactoryData(DataModel.curSkinType, "TagFactory")
      local oldElement = DataModel.skinTypeElements[DataModel.curSkinType]
      if oldElement then
        oldElement.Img_Icon:SetSprite(oldSkinTypeCA.unSelectIconPath)
      end
    end
    local curElement = DataModel.skinTypeElements[tonumber(str)]
    local curSkinTypeCA = PlayerData:GetFactoryData(tonumber(str), "TagFactory")
    curElement.Img_Icon:SetSprite(curSkinTypeCA.selectIconPath)
    DataModel.SetCurSkinListByType(tonumber(str))
  end,
  ChangeSkin_Group_RightPanel_Group_Middle_ScrollGrid_Skin_SetGrid = function(element, elementIndex)
    local skinItem = DataModel.curSkins[elementIndex]
    local skinCA = PlayerData:GetFactoryData(skinItem.itemId, "HomeCharacterSkinFactory")
    element.Txt_Name:SetText(skinCA.name)
    element.Img_Skin:SetSprite(skinCA.iconPath)
    element.Btn_:SetClickParam(elementIndex)
    local wear = DataModel.CheckSkinWear(skinItem.skinUid)
    element.Img_SelectBG:SetActive(wear)
    element.Img_Select:SetActive(wear)
    element.Img_SelectNameBG:SetActive(wear)
    DataModel.skinElements[skinItem.skinUid] = element
    element.Btn_Info:SetClickParam(skinItem.itemId)
  end,
  ChangeSkin_Group_RightPanel_Group_Middle_ScrollGrid_Skin_Group_Item_Btn__Click = function(btn, str)
    local skinItem = DataModel.curSkins[tonumber(str)]
    if not skinItem then
      return
    end
    local skinCA = PlayerData:GetFactoryData(skinItem.itemId, "HomeCharacterSkinFactory")
    local oldSkinItem = DataModel.allSelectSkin[skinCA.skinType]
    local wearing = DataModel.CheckSkinWear(skinItem.skinUid)
    if oldSkinItem then
      local oldElement = DataModel.skinElements[oldSkinItem.skinUid]
      if oldElement then
        oldElement.Img_SelectBG:SetActive(false)
        oldElement.Img_Select:SetActive(false)
        oldElement.Img_SelectNameBG:SetActive(false)
      end
    end
    if wearing then
      DataModel.ChangeSkin(skinItem, false)
    else
      local curElement = DataModel.skinElements[skinItem.skinUid]
      curElement.Img_SelectBG:SetActive(true)
      curElement.Img_Select:SetActive(true)
      curElement.Img_SelectNameBG:SetActive(true)
      DataModel.ChangeSkin(skinItem, true)
    end
  end,
  ChangeSkin_Group_Character_Btn_Turn_Click = function(btn, str)
    local animName = DataModel.isBack and "dorm_stand" or "dorm_stand_back"
    View.Group_Character.SpineAnimation_:SetActionWithoutMix(animName, true, true)
    DataModel.isBack = not DataModel.isBack
  end,
  ChangeSkin_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  ChangeSkin_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  ChangeSkin_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ChangeSkin_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ChangeSkin_Group_RightPanel_Group_Middle_ScrollGrid_Skin_Group_Item_Btn_Info_Click = function(btn, str)
    CommonTips.OpenDressTips(tonumber(str))
  end,
  ChangeSkin_Group_Character_Btn_Save_Click = function(btn, str)
    CharacterUtil.SaveDresses(DataModel.unitId, DataModel.allSelectSkin, DataModel.skinData)
    DataModel.InitSceneCharacterSkin()
    CommonTips.OpenTips(80602333)
  end
}
return ViewFunction
