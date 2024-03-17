local View = require("UIChangeSkin/UIChangeSkinView")
local DataModel = {}
DataModel.isBack = false
DataModel.characterId = 70000067
DataModel.isCaptain = false
DataModel.unitId = nil
DataModel.skinData = {}
DataModel.curSkinType = nil
DataModel.curSkins = {}
DataModel.allSelectSkin = {}
DataModel.skinTypes = {}
DataModel.defaultSkinType = nil
DataModel.skinTypeElements = {}
DataModel.skinElements = {}

function DataModel.Init()
  for i, v in ipairs(PlayerData:GetFactoryData(99900014, "ConfigFactory").dressTypeOrder) do
    table.insert(DataModel.skinTypes, v.id)
  end
  DataModel.defaultSkinType = PlayerData:GetFactoryData(99900014, "ConfigFactory").defaultDressType
end

function DataModel.SetJsonData(json)
  if not json then
    return
  end
  local data = Json.decode(json)
  DataModel.characterId = data.characterId
end

function DataModel.InitData()
  DataModel.isCaptain = DataModel.characterId == 70000067 or DataModel.characterId == 70000063
  if DataModel.isCaptain then
    DataModel.skinData = PlayerData.ServerData.guard
    local gender = PlayerData:GetUserInfo().gender or 1
    DataModel.unitId = gender == 1 and 10000137 or 10000173
  end
  if not DataModel.skinData then
    return
  end
  DataModel.isBack = false
  DataModel.allSelectSkin = {}
  for skinType, skinUid in pairs(DataModel.skinData) do
    local skinInfo = PlayerData.ServerData.dress[skinUid]
    DataModel.allSelectSkin[tonumber(skinType)] = CharacterUtil.GenerateSkinItem(skinInfo.id, skinUid)
  end
end

function DataModel.RefreshOnShow()
  local characterCA = PlayerData:GetFactoryData(DataModel.characterId, "HomeCharacterFactory")
  local spinePath = characterCA.resStatePath[2] and characterCA.resStatePath[2].path or characterCA.resDir
  View.Group_Character.SpineAnimation_:SetSpineInit(spinePath, "dorm_stand")
  local takeOnJson = PlayerData.GetCharacterSkinJson(DataModel.characterId)
  View.Group_Character.SpineAnimation_:ChangeSkin(takeOnJson)
  View.Group_RightPanel.Img_Bg.Img_Gender:SetSprite(characterCA.bgPath)
  if DataModel.defaultSkinType then
    DataModel.SetCurSkinListByType(DataModel.defaultSkinType)
  end
  DataModel.skinTypeElements = {}
  View.Group_RightPanel.Group_Top.ScrollGrid_SkinType.grid.self:SetDataCount(#DataModel.skinTypes)
  View.Group_RightPanel.Group_Top.ScrollGrid_SkinType.grid.self:RefreshAllElement()
end

function DataModel.SetCurSkinListByType(skinType)
  DataModel.curSkins = {}
  DataModel.curSkinType = skinType
  for skinUid, skinData in pairs(PlayerData.ServerData.dress) do
    if skinData.hid == "" or tonumber(skinData.hid) == DataModel.unitId then
      local skinCA = PlayerData:GetFactoryData(skinData.id, "HomeCharacterSkinFactory")
      local canWear = false
      for _, v in pairs(skinCA.character) do
        if v.id == DataModel.unitId then
          canWear = true
          break
        end
      end
      if canWear and skinCA.skinType == skinType then
        local t = CharacterUtil.GenerateSkinItem(skinData.id, skinUid)
        table.insert(DataModel.curSkins, t)
      end
    end
  end
  DataModel.skinElements = {}
  View.Group_RightPanel.Group_Middle.ScrollGrid_Skin.grid.self:SetDataCount(#DataModel.curSkins)
  View.Group_RightPanel.Group_Middle.ScrollGrid_Skin.grid.self:RefreshAllElement()
  View.Group_RightPanel.Group_Middle.Img_NoCloth:SetActive(#DataModel.curSkins == 0)
end

function DataModel.CheckSkinWear(skinUid)
  local skinInfo = PlayerData.ServerData.dress[skinUid]
  local skinCA = PlayerData:GetFactoryData(skinInfo.id, "HomeCharacterSkinFactory")
  return DataModel.allSelectSkin[skinCA.skinType] and DataModel.allSelectSkin[skinCA.skinType].skinUid == skinUid
end

function DataModel.ChangeSkin(skinItem, takeOn)
  local skinCA = PlayerData:GetFactoryData(skinItem.itemId, "HomeCharacterSkinFactory")
  if takeOn then
    local particle = View.Group_Character.transform:Find("UI_clothes"):GetComponent(typeof(CS.UnityEngine.ParticleSystem))
    particle:Play()
    local skinTypeCA = PlayerData:GetFactoryData(skinCA.skinType, "TagFactory")
    local animCA = PlayerData:GetFactoryData(skinTypeCA.animId, "ListFactory")
    if not animCA then
      return
    end
    local anims = DataModel.isBack and animCA.backAnimList or animCA.frontAnimList
    local index = math.random(1, table.count(anims))
    View.Group_Character.SpineAnimation_:SetActionWithoutMix(anims[index].animName, true, true)
    DataModel.sound = SoundManager:CreateSound(30002649)
    DataModel.sound:Play()
  end
  local takeOnJson, takeOffJson = CharacterUtil.DealSkinData(DataModel.characterId, skinItem, takeOn, DataModel.allSelectSkin)
  View.Group_Character.SpineAnimation_:ChangeSkin(takeOnJson, takeOffJson)
end

function DataModel.InitSceneCharacterSkin()
  local takeOnJson = PlayerData.GetCharacterSkinJson(DataModel.characterId)
  HomeCharacterManager:InitSceneCharacterSkin(DataModel.characterId, takeOnJson)
  local HomeTradeDataModel = require("UIHome/UIHomeTradeDataModel")
  local stationCA = PlayerData:GetFactoryData(HomeTradeDataModel.CurStayCity)
  local timeLineCA
  for k, timeline in pairs(stationCA.timeLineList) do
    timeLineCA = PlayerData:GetFactoryData(timeline.id, "TimeLineFactory")
    for i, v in pairs(timeLineCA.lczPathList) do
      TimelineManager:InitSceneCharacterSkin(timeLineCA.timeLinePath, v.lcz, takeOnJson)
    end
  end
end

DataModel.Init()
return DataModel
