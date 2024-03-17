local CharacterUtil = {}
local takeOnStrs = {}
local takeOffStrs = {}
local InsertTakeOn = function(data)
  if not data then
    return
  end
  local resPath = string.format("\"resPath\":\"%s\"", data.spineDataPath)
  local skinPath = string.format("\"skinPath\":\"%s\"", data.skinPath)
  table.insert(takeOnStrs, data.skinType .. ":[{" .. resPath .. "," .. skinPath .. "}]")
end
local InsertTakeOff = function(data)
  if not data then
    return
  end
  local resPath = string.format("\"resPath\":\"%s\"", data.spineDataPath)
  local skinPath = string.format("\"skinPath\":\"%s\"", data.skinPath)
  table.insert(takeOffStrs, data.skinType .. ":[{" .. resPath .. "," .. skinPath .. "}]")
end

function CharacterUtil.GetSkinTypeNude(skinType)
  if skinType == EnumDefine.ESkinType.Up then
    return EnumDefine.ESkinNude.Up
  end
  if skinType == EnumDefine.ESkinType.Bottom then
    return EnumDefine.ESkinNude.Bottom
  end
  if skinType == EnumDefine.ESkinType.Shoes then
    return EnumDefine.ESkinNude.Shoes
  end
end

function CharacterUtil.GetHairData(characterId, hairType)
  local hairId
  if characterId == 70000067 then
    hairId = 85500001
  elseif characterId == 70000063 then
    hairId = 85500011
  end
  if not hairId then
    return
  end
  local skinCA = PlayerData:GetFactoryData(hairId, "HomeCharacterSkinFactory")
  for i, v in pairs(skinCA.hairList) do
    if v.hairType == hairType then
      return {
        skinType = skinCA.skinType,
        spineDataPath = v.spineDataPath,
        skinPath = v.skinPath
      }
    end
  end
end

function CharacterUtil.GenerateSkinItem(skinId, skinUid)
  return {
    itemId = tonumber(skinId),
    skinUid = skinUid
  }
end

function CharacterUtil.GenerateSkinShopItem(commodityId, commodityIndex, skinId, skinUid)
  return {
    commodityId = commodityId,
    commodityIndex = commodityIndex,
    itemId = skinId,
    skinUid = skinUid
  }
end

function CharacterUtil.DealSkinData(characterId, skinItem, takeOn, curSkinData)
  local selectSkinCA = PlayerData:GetFactoryData(skinItem.itemId, "HomeCharacterSkinFactory")
  local selectSkinType = selectSkinCA.skinType
  local selectSkinTypeCA = PlayerData:GetFactoryData(selectSkinType, "TagFactory")
  local headSkin = curSkinData[EnumDefine.ESkinType.Head]
  local beforeHairType = EnumDefine.ESkinHairType.Default
  if headSkin then
    local headSkinCA = PlayerData:GetFactoryData(headSkin.itemId, "HomeCharacterSkinFactory")
    beforeHairType = headSkinCA.hairType
  end
  takeOnStrs = {}
  takeOffStrs = {}
  local takeOffId = curSkinData[selectSkinType] and curSkinData[selectSkinType].itemId or CharacterUtil.GetSkinTypeNude(selectSkinType)
  if takeOffId then
    local skinCA = PlayerData:GetFactoryData(takeOffId, "HomeCharacterSkinFactory")
    InsertTakeOff(skinCA)
    curSkinData[selectSkinType] = nil
  end
  if takeOn then
    InsertTakeOn(selectSkinCA)
    curSkinData[selectSkinType] = skinItem
    for i, v in pairs(selectSkinTypeCA.takeOnExtraRemove) do
      local skinId = curSkinData[v.id] and curSkinData[v.id].itemId
      if skinId then
        local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
        InsertTakeOff(skinCA)
        curSkinData[v.id] = nil
        if v.id == EnumDefine.ESkinType.Suit then
          local takeOnId
          if curSkinData[EnumDefine.ESkinType.Up] and not curSkinData[EnumDefine.ESkinType.Bottom] then
            takeOnId = EnumDefine.ESkinNude.Bottom
          end
          if not curSkinData[EnumDefine.ESkinType.Up] and curSkinData[EnumDefine.ESkinType.Bottom] then
            takeOnId = EnumDefine.ESkinNude.Up
          end
          if takeOnId then
            skinCA = PlayerData:GetFactoryData(takeOnId, "HomeCharacterSkinFactory")
            InsertTakeOn(skinCA)
          end
        end
      else
        takeOffId = CharacterUtil.GetSkinTypeNude(v.id)
        if takeOffId then
          local skinCA = PlayerData:GetFactoryData(takeOffId, "HomeCharacterSkinFactory")
          InsertTakeOff(skinCA)
        end
      end
    end
  else
    local takeOnId = CharacterUtil.GetSkinTypeNude(selectSkinType)
    if takeOnId then
      local skinCA = PlayerData:GetFactoryData(takeOnId, "HomeCharacterSkinFactory")
      InsertTakeOn(skinCA)
    end
    if selectSkinCA.skinType == EnumDefine.ESkinType.Suit then
      local skinCA = PlayerData:GetFactoryData(EnumDefine.ESkinNude.Up, "HomeCharacterSkinFactory")
      InsertTakeOn(skinCA)
      skinCA = PlayerData:GetFactoryData(EnumDefine.ESkinNude.Bottom, "HomeCharacterSkinFactory")
      InsertTakeOn(skinCA)
    end
  end
  local curHairType = EnumDefine.ESkinHairType.Default
  headSkin = curSkinData[EnumDefine.ESkinType.Head]
  if headSkin then
    local headSkinCA = PlayerData:GetFactoryData(headSkin.itemId, "HomeCharacterSkinFactory")
    curHairType = headSkinCA.hairType
  end
  if curHairType ~= beforeHairType then
    local hairData = CharacterUtil.GetHairData(characterId, beforeHairType)
    InsertTakeOff(hairData)
    hairData = CharacterUtil.GetHairData(characterId, curHairType)
    InsertTakeOn(hairData)
  end
  local takeOnJson = 0 < #takeOnStrs and "{" .. table.concat(takeOnStrs, ",") .. "}" or ""
  local takeOffJson = 0 < #takeOffStrs and "{" .. table.concat(takeOffStrs, ",") .. "}" or ""
  return takeOnJson, takeOffJson
end

function CharacterUtil.SaveDresses(unitId, curSkinData, serverSkinData)
  local change = false
  for skinType, skinItem in pairs(curSkinData) do
    if not serverSkinData[tostring(skinType)] or serverSkinData[tostring(skinType)] ~= skinItem.skinUid then
      serverSkinData[tostring(skinType)] = skinItem.skinUid
      change = true
    end
  end
  for skinType, skinItem in pairs(serverSkinData) do
    if not curSkinData[tonumber(skinType)] then
      serverSkinData[skinType] = nil
      change = true
    end
  end
  if change then
    local dresses = {}
    for skinType, skinItem in pairs(curSkinData) do
      table.insert(dresses, skinItem.skinUid)
    end
    local dressesStr = table.concat(dresses, ",")
    Net:SendProto("hero.dress", function(json)
    end, unitId, dressesStr)
  end
end

return CharacterUtil
