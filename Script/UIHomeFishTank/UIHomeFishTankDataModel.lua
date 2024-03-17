local DataModel = {
  curFurId = 0,
  curFurUfid = "",
  fishData = {},
  furFishData = {},
  fishChangeData = {},
  curSelectType = 0,
  FishType = {
    small = 1,
    middle = 2,
    big = 3,
    huge = 4,
    all = 5
  },
  maxVolume = 0,
  curUsedVolume = 0,
  curRubbishNum = 0,
  CurShowType = 0,
  ShowTypeEnum = {Fish = 1, Skin = 2},
  CurSelectFishTable = {},
  furSkinUId = "",
  curUsedSkinUId = "",
  skinData = nil
}

function DataModel.InitData()
  local furCA = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
  DataModel.maxVolume = furCA.fishtankVolume
  DataModel.InitFishData()
  DataModel.InitCurUsedData()
end

function DataModel.InitCurUsedData()
  local volume = 0
  local curRubbishNum = 0
  for k, v in pairs(DataModel.furFishData) do
    local fishCA = PlayerData:GetFactoryData(k, "HomeCreatureFactory")
    volume = volume + fishCA.fishVolume * v
    curRubbishNum = curRubbishNum + fishCA.fishGarbage * v
  end
  DataModel.curUsedVolume = volume
  DataModel.curRubbishNum = curRubbishNum
end

function DataModel.InitFishData()
  DataModel.fishData = {}
  for k, v in pairs(DataModel.FishType) do
    DataModel.fishData[v] = {}
  end
  DataModel.furFishData = {}
  local serverFurData = PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid]
  DataModel.furSkinUId = serverFurData.u_skin
  DataModel.curUsedSkinUId = DataModel.furSkinUId
  local serverCreatures = PlayerData.ServerData.user_home_info.creatures
  if serverFurData ~= nil and serverFurData.water ~= nil and serverFurData.water.fishes ~= nil then
    for k, v in pairs(serverFurData.water.fishes) do
      DataModel.furFishData[tonumber(k)] = v
      if serverCreatures[k] == nil then
        serverCreatures[k] = {}
        serverCreatures[k].num = 0
      end
    end
  end
  for k, v in pairs(serverCreatures) do
    local id = tonumber(k)
    local ca = PlayerData:GetFactoryData(id, "HomeCreatureFactory")
    if ca.mod == "鱼" then
      local notAdd = v.num == 0
      local furNotHad = DataModel.furFishData[id] == nil or DataModel.furFishData[id] == 0
      notAdd = notAdd and furNotHad
      if not notAdd then
        local t = {}
        t.id = id
        t.num = v.num
        t.ca = ca
        local typeInt = DataModel.FishTypeToInt(t.ca.fishType)
        table.insert(DataModel.fishData[typeInt], t)
        table.insert(DataModel.fishData[DataModel.FishType.all], t)
      end
    end
  end
  DataModel.fishChangeData = {}
  DataModel.curSelectType = 0
end

function DataModel.FishTypeToInt(fishType)
  local typeInt = DataModel.FishType.small
  if fishType == "小型鱼" then
    typeInt = DataModel.FishType.small
  elseif fishType == "中型鱼" then
    typeInt = DataModel.FishType.middle
  elseif fishType == "大型鱼" then
    typeInt = DataModel.FishType.big
  elseif fishType == "超大型鱼" then
    typeInt = DataModel.FishType.huge
  end
  return typeInt
end

function DataModel.ChangeFishData(id, num)
  local fishCA = PlayerData:GetFactoryData(id, "HomeCreatureFactory")
  local addVolume = fishCA.fishVolume * num
  if DataModel.curUsedVolume + addVolume > DataModel.maxVolume or DataModel.curUsedVolume + addVolume < 0 then
    CommonTips.OpenTips(80600361)
    return false
  end
  if DataModel.fishChangeData[id] == nil then
    DataModel.fishChangeData[id] = 0
  end
  local allFishNum = 0
  local key1, key2
  local isFind = false
  for k, v in pairs(DataModel.fishData) do
    for k1, v1 in pairs(v) do
      if v1.id == id then
        allFishNum = v1.num
        key1 = k
        key2 = k1
        isFind = true
        break
      end
    end
    if isFind then
      break
    end
  end
  if allFishNum - num < 0 then
    CommonTips.OpenTips(80600362)
    return false
  end
  if 0 > (DataModel.furFishData[id] or 0) + (DataModel.fishChangeData[id] or 0) + num then
    return false
  end
  DataModel.curUsedVolume = DataModel.curUsedVolume + addVolume
  DataModel.curRubbishNum = DataModel.curRubbishNum + fishCA.fishGarbage * num
  DataModel.fishData[key1][key2].num = allFishNum - num
  DataModel.fishChangeData[id] = DataModel.fishChangeData[id] + num
  return true
end

function DataModel.InitSkinData()
  DataModel.skinData = {}
  local furCA = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
  local keyUseSkinList = {}
  for k, v in pairs(furCA.SkinList) do
    keyUseSkinList[v.id] = 0
  end
  local cacheNotUse = {}
  for k, v in pairs(PlayerData:GetHomeInfo().furniture_skins) do
    local id = tonumber(v.id)
    if keyUseSkinList[tonumber(id)] == 0 then
      if v.u_fid ~= "" then
        local t = {}
        t.id = id
        local ca = PlayerData:GetFactoryData(id, "HomeFurnitureSkinFactory")
        t.name = ca.name
        t.iconPath = ca.iconPath
        t.isUsed = true
        t.selfUsed = v.u_fid == DataModel.curFurUfid
        t.u_skin = k
        t.u_skins = {}
        t.u_skins[k] = 0
        table.insert(DataModel.skinData, t)
      elseif cacheNotUse[id] ~= nil then
        local t = DataModel.skinData[cacheNotUse[id]]
        t.u_skins[k] = 0
      else
        local t = {}
        t.id = id
        local ca = PlayerData:GetFactoryData(id, "HomeFurnitureSkinFactory")
        t.name = ca.name
        t.iconPath = ca.iconPath
        t.isUsed = false
        t.u_skin = k
        t.u_skins = {}
        t.u_skins[k] = 0
        table.insert(DataModel.skinData, t)
        cacheNotUse[id] = #DataModel.skinData
      end
    end
  end
  DataModel.SortSkinData()
end

function DataModel.SortSkinData()
  table.sort(DataModel.skinData, function(a, b)
    if a.selfUsed then
      return true
    end
    if b.selfUsed then
      return false
    end
    if not a.isUsed and b.isUsed then
      return true
    end
    if a.isUsed and not b.isUsed then
      return false
    end
    return a.id < b.id
  end)
end

return DataModel
