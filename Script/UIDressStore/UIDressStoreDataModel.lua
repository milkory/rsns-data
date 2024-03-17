local View = require("UIDressStore/UIDressStoreView")
local DataModel = {}
DataModel.shopId = nil
DataModel.skinData = {}
DataModel.isBack = false
DataModel.characterId = nil
DataModel.unitId = nil
DataModel.shopItemTypes = {}
DataModel.curSelectShopItemType = nil
DataModel.allShopItems = {}
DataModel.curTypeShopItems = {}
DataModel.allSelectShopItems = {}
DataModel.defaultShopItemType = nil
DataModel.skinTypeElements = {}
DataModel.skinElements = {}

function DataModel.Init()
  for i, v in ipairs(PlayerData:GetFactoryData(99900014, "ConfigFactory").dressTypeOrder) do
    table.insert(DataModel.shopItemTypes, v.id)
  end
  DataModel.defaultShopItemType = PlayerData:GetFactoryData(99900014, "ConfigFactory").defaultDressType
end

function DataModel.SetJsonData(json)
  if not json then
    return
  end
  local data = Json.decode(json)
  DataModel.characterId = data.characterId
  if data.characterId == 70000067 or data.characterId == 70000063 then
    local gender = PlayerData:GetUserInfo().gender or 1
    DataModel.unitId = gender == 1 and 10000137 or 10000173
    DataModel.skinData = PlayerData.ServerData.guard
  end
  DataModel.shopItems = data.shopItems
  DataModel.shopId = data.shopId
end

function DataModel.InitData()
  DataModel.isBack = false
  DataModel.allShopItems = {}
  DataModel.allSelectShopItems = {}
  for index, id in pairs(DataModel.shopItems) do
    local commodityCA = PlayerData:GetFactoryData(id, "CommodityFactory")
    for _, cfg in pairs(commodityCA.commodityItemList) do
      local skinCA = PlayerData:GetFactoryData(cfg.id, "HomeCharacterSkinFactory")
      DataModel.allShopItems[skinCA.skinType] = DataModel.allShopItems[skinCA.skinType] or {}
      local _, skinUid = DataModel.IsSkinHave(cfg.id)
      local item = CharacterUtil.GenerateSkinShopItem(id, index, cfg.id, skinUid)
      if skinUid and DataModel.IsSkinWear(cfg.id) then
        DataModel.allSelectShopItems[skinCA.skinType] = item
      end
      table.insert(DataModel.allShopItems[skinCA.skinType], item)
    end
  end
  for skinType, skinUid in pairs(DataModel.skinData) do
    local skinData = PlayerData.ServerData.dress[skinUid]
    local itemId = tonumber(skinData.id)
    skinType = tonumber(skinType)
    if not DataModel.IsShopHave(itemId) then
      DataModel.allShopItems[skinType] = DataModel.allShopItems[skinType] or {}
      local item = CharacterUtil.GenerateSkinShopItem(nil, -1, itemId, skinUid)
      DataModel.allSelectShopItems[skinType] = item
      table.insert(DataModel.allShopItems[skinType], item)
    end
  end
  local GetSort = function(isHave, isWear)
    if isHave and isWear then
      return 0
    end
    if not isHave then
      return 1
    end
    if isHave and not isWear then
      return 2
    end
  end
  for i, v in pairs(DataModel.allShopItems) do
    table.sort(v, function(a, b)
      local sort1 = GetSort(DataModel.IsSkinHave(a.itemId), DataModel.IsSkinWear(a.itemId))
      local sort2 = GetSort(DataModel.IsSkinHave(b.itemId), DataModel.IsSkinWear(b.itemId))
      return sort1 < sort2
    end)
  end
end

function DataModel.RefreshOnShow()
  if DataModel.defaultShopItemType then
    DataModel.SetCurSkinListByType(DataModel.defaultShopItemType)
  end
  DataModel.skinTypeElements = {}
  View.Group_RightPanel.Group_Top.ScrollGrid_SkinType.grid.self:SetDataCount(table.count(DataModel.shopItemTypes))
  View.Group_RightPanel.Group_Top.ScrollGrid_SkinType.grid.self:RefreshAllElement()
  local characterCA = PlayerData:GetFactoryData(DataModel.characterId, "HomeCharacterFactory")
  local spinePath = characterCA.resStatePath[2] and characterCA.resStatePath[2].path or characterCA.resDir
  View.Group_Character.SpineAnimation_:SetSpineInit(spinePath, "dorm_stand")
  local takeOnJson = PlayerData.GetCharacterSkinJson(DataModel.characterId)
  View.Group_Character.SpineAnimation_:ChangeSkin(takeOnJson)
  View.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
end

function DataModel.SetCurSkinListByType(skinType)
  DataModel.curSelectShopItemType = skinType
  DataModel.curTypeShopItems = DataModel.allShopItems[skinType] or {}
  DataModel.skinElements = {}
  View.Group_RightPanel.Group_Middle.ScrollGrid_Skin.grid.self:SetDataCount(#DataModel.curTypeShopItems)
  View.Group_RightPanel.Group_Middle.ScrollGrid_Skin.grid.self:RefreshAllElement()
  View.Group_RightPanel.Group_Middle.Img_NoCloth:SetActive(#DataModel.curTypeShopItems == 0)
end

function DataModel.IsShopHave(skinId)
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
  local shopItems = DataModel.allShopItems[skinCA.skinType]
  if shopItems then
    for i, item in pairs(shopItems) do
      if item.itemId == tonumber(skinId) then
        return true
      end
    end
  end
  return false
end

function DataModel.IsSkinHave(skinId)
  if not skinId then
    return false
  end
  for skinUid, v in pairs(PlayerData.ServerData.dress) do
    if v.id == tostring(skinId) then
      return true, skinUid
    end
  end
  return false
end

function DataModel.IsSkinWear(skinId)
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
  local skinUid = DataModel.skinData[tostring(skinCA.skinType)]
  if skinUid then
    local skinData = PlayerData.ServerData.dress[skinUid]
    return skinData.id == tostring(skinId)
  end
  return false
end

function DataModel.IsSkinSelect(skinId)
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
  local selectItem = DataModel.allSelectShopItems[skinCA.skinType]
  if selectItem then
    return selectItem.itemId == skinId
  end
  return false
end

function DataModel.ChangeSkin(item, takeOn)
  local skinId = item.itemId
  local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
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
  local takeOnJson, takeOffJson = CharacterUtil.DealSkinData(DataModel.characterId, item, takeOn, DataModel.allSelectShopItems)
  View.Group_Character.SpineAnimation_:ChangeSkin(takeOnJson, takeOffJson)
end

function DataModel.SaveDresses()
  CharacterUtil.SaveDresses(DataModel.unitId, DataModel.allSelectShopItems, DataModel.skinData)
end

function DataModel.InitSceneCharacterSkin()
  local takeOnJson = PlayerData.GetCharacterSkinJson(DataModel.characterId)
  HomeStationStoreManager:InitSceneCharacterSkin(DataModel.characterId, takeOnJson)
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
