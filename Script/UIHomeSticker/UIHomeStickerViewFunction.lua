local View = require("UIHomeSticker/UIHomeStickerView")
local DataModel = require("UIHomeSticker/UIHomeStickerDataModel")
local Controller = require("UIHomeSticker/UIHomeStickerController")
local lastSelect
local ViewFunction = {
  HomeSticker_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if Controller.isCameraAnime then
      return
    end
    HomeCharacterManager:RecycleChangeSkinCharacter()
    UIManager:GoBack()
    lastSelect = nil
  end,
  HomeSticker_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    if Controller.isCameraAnime then
      return
    end
    HomeCharacterManager:RecycleChangeSkinCharacter()
    HomeStationStoreManager:QuitStationStore()
    UIManager:GoHome()
    lastSelect = nil
    local homeCommon = require("Common/HomeCommon")
    local cityStoreDataModel = require("UICityStore/UICityStoreDataModel")
    local bgSoundId = homeCommon.GetCurShowSceneInfo(cityStoreDataModel.StationId).bgmId
    local sound = SoundManager:CreateSound(bgSoundId)
    if sound ~= nil then
      sound:Play()
    end
    local sDataModel = require("UIMainUI/UIMainUIDataModel")
    if MainManager.bgSceneName == sDataModel.SceneNameEnum.Home then
      local HomeController = require("UIHome/UIHomeController")
      local HomeCoachDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
      local HomeCoachController = require("UIHomeCoach/UIHomeCoachController")
      HomeController:RefreshTrains()
      HomeCoachController:InitEnvironment()
      HomeCharacterManager:CreateAll(HomeCoachDataModel.characterData, HomeCoachDataModel.petData)
      HomeCharacterManager:ReShowAll()
    end
  end,
  HomeSticker_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomeSticker_Btn_Take_Click = function(btn, str)
    Controller:Take()
  end,
  HomeSticker_Group_InviteMember_ScrollGrid_MemberList_SetGrid = function(element, elementIndex)
    local data = DataModel.allCheckInCharacters[elementIndex]
    element.Img_Member:SetSprite(data.face)
    element.Txt_Name:SetText(data.name)
    element.Btn_Select:SetClickParam(elementIndex)
    if DataModel.curSelectCharacterIdx == elementIndex then
      lastSelect = element.Img_Picekd.gameObject
      element.Img_Picekd:SetActive(true)
    else
      element.Img_Picekd:SetActive(false)
    end
  end,
  HomeSticker_Group_Album_ScrollGrid_AlbumList_SetGrid = function(element, elementIndex)
    local data = DataModel.allCheckInCharacters[DataModel.curSelectCharacterIdx].profilePhotoList[elementIndex]
    local iconPath = PlayerData:GetFactoryData(data.id).imagePath
    local owned = DataModel.playerAvatar[tostring(data.id)]
    element.Img_Photo:SetActive(owned)
    element.Img_NotOwned:SetActive(not owned)
    if owned then
      element.Img_Photo:SetSprite(iconPath)
    end
  end,
  HomeSticker_Btn_HS_Click = function(btn, str)
  end,
  HomeSticker_Group_InviteMember_ScrollGrid_MemberList_Group_Item_Btn_Select_Click = function(btn, str)
    local id = tonumber(str)
    if DataModel.curSelectCharacterIdx ~= id then
      DataModel.curSelectCharacterIdx = tonumber(str)
      Controller:Select(DataModel.curSelectCharacterIdx)
      if lastSelect then
        lastSelect:SetActive(false)
      end
      lastSelect = btn.transform.parent:Find("Img_Picekd").gameObject
      lastSelect:SetActive(true)
    end
  end,
  HomeSticker_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeSticker_Img_HBP_Btn_HBPStore_Click = function(btn, str)
    UIManager:Open("UI/HomeSticker/HomeStickerStore")
  end,
  HomeSticker_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end,
  HomeSticker_Btn_HS_Btn_Add_Click = function(btn, str)
  end,
  HomeSticker_Group_HBPStore_ScrollGrid__SetGrid = function(element, elementIndex)
  end,
  HomeSticker_Prompt_Btn_Confirm_Click = function(btn, str)
  end,
  HomeSticker_Prompt_Btn_Cancel_Click = function(btn, str)
  end,
  HomeSticker_Prompt_Group_Tip_Btn_Tip_Click = function(btn, str)
  end,
  HomeSticker_Group_StickerAcquire_Btn__Click = function(btn, str)
  end,
  HomeSticker_Group_StickerAcuqire_Btn__Click = function(btn, str)
  end
}
return ViewFunction
