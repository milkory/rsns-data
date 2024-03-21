local DataModel = {
  CacheInitParams = nil,
  StationId = 0,
  BuildingId = 0,
  NpcId = 0,
  BgPath = "",
  BgColor = "",
  CurTradeType = 0,
  CurTabType = 0,
  TradeType = {Buy = 1, Sale = 2},
  TabType = {
    Pet = 1,
    Plant = 2,
    Fish = 3,
    PetStuff = 4
  },
  TabBtnName = {
    "Btn_Pet",
    "Btn_Plant",
    "Btn_Fish",
    "Btn_PetStuff"
  },
  TabBuyDetailName = {
    "Group_Pet",
    "Group_General",
    "Group_General",
    "Group_General"
  },
  TabSaleDetailName = {
    "Group_General",
    "Group_General",
    "Group_General",
    "Group_General"
  },
  List = {},
  Now_List = {},
  NPCDialogEnum = {
    enterText = "enterText",
    animalStoreText = "animalStoreText",
    talkText = "talkText",
    petStoreText = "petStoreText",
    plantStoreText = "plantStoreText",
    fishStoreText = "fishStoreText",
    petStuffStoreText = "petStuffStoreText",
    petSellText = "petSellText",
    plantSellText = "plantSellText",
    fishSellText = "fishSellText",
    petStuffSellText = "petStuffSellText"
  },
  CurPetSelectedIdx = 0,
  BuyPetUId = "",
  CanSaleList = {},
  ShopIdToRecycle = {},
  TypeToShopId = {},
  CacheEventList = {}
}

function DataModel.InitShopData()
  local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  DataModel.List = {}
  DataModel.AutoRefreshTime = {}
  local count = 1
  for k, v in pairs(stationConfig.petStoreList) do
    local storeFactory = PlayerData:GetFactoryData(v.id)
    local severStoreValue = PlayerData.ServerData.shops[tostring(v.id)]
    DataModel.List[count] = {}
    if severStoreValue then
      DataModel.List[count].server = severStoreValue
    end
    DataModel.List[count].shopFactory = storeFactory
    DataModel.List[count].storeType = storeFactory.storeType
    DataModel.List[count].shopId = v.id
    DataModel.List[count].name = storeFactory.name
    local t = {}
    if (storeFactory.storeType == "Random" or storeFactory.storeType == "Repeatable") and severStoreValue then
      for k1, v1 in pairs(severStoreValue.items) do
        table.insert(t, {
          id = v1.id
        })
      end
    else
      for k1, v1 in pairs(storeFactory.shopList) do
        table.insert(t, {
          id = v1.id
        })
      end
    end
    DataModel.List[count].shopList = t
    local isAutoRefresh = storeFactory.autoRefresh
    if isAutoRefresh then
      for k1, v1 in pairs(storeFactory.refreshTimeList) do
        local h = tonumber(string.sub(v1.refreshTime, 1, 2))
        local m = tonumber(string.sub(v1.refreshTime, 4, 5))
        local s = tonumber(string.sub(v1.refreshTime, 7, 8))
        local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
        local find = false
        for k2, v2 in pairs(DataModel.AutoRefreshTime) do
          if v2 == targetTime then
            find = true
            break
          end
        end
        if not find then
          table.insert(DataModel.AutoRefreshTime, targetTime)
        end
      end
    end
    count = count + 1
  end
end

local GetShopIdRecycleList = function(shopId)
  if DataModel.ShopIdToRecycle[shopId] then
    return DataModel.ShopIdToRecycle[shopId]
  end
  local storeCA = PlayerData:GetFactoryData(shopId, "StoreFactory")
  local recycleListIdRecord = {}
  for k1, v1 in pairs(storeCA.recycleShopList) do
    local commodityCA = PlayerData:GetFactoryData(v1.id, "CommodityFactory")
    recycleListIdRecord[commodityCA.recycleItem] = v1.id
  end
  DataModel.ShopIdToRecycle[shopId] = recycleListIdRecord
  return recycleListIdRecord
end
local InitPetSaleData = function(shopId, savedTab)
  local recycleListIdRecord = GetShopIdRecycleList(shopId)
  local tabData = {}
  tabData.shopId = shopId
  tabData.commodityList = {}
  local index = 1
  local serverData = PlayerData:GetHomeInfo().pet
  for k1, v1 in pairs(serverData) do
    local id = tonumber(v1.id)
    if recycleListIdRecord[id] and v1.u_fid == "" and v1.role_id == "" then
      local t = {}
      t.data = v1
      t.uids = {}
      table.insert(t.uids, k1)
      t.id = id
      t.commodityId = recycleListIdRecord[id]
      t.num = 1
      tabData.commodityList[index] = t
      index = index + 1
    end
  end
  DataModel.CanSaleList[savedTab] = tabData
  DataModel.TypeToShopId[savedTab] = shopId
end
local InitFishSaleData = function(shopId, savedTab)
  local recycleListIdRecord = GetShopIdRecycleList(shopId)
  local tabData = {}
  tabData.shopId = shopId
  tabData.commodityList = {}
  local index = 1
  local serverData = PlayerData:GetHomeInfo().creatures
  for k1, v1 in pairs(serverData) do
    local id = tonumber(k1)
    if recycleListIdRecord[id] and v1.num and v1.num > 0 then
      local t = {}
      t.data = v1
      t.id = id
      t.commodityId = recycleListIdRecord[id]
      t.num = v1.num
      tabData.commodityList[index] = t
      index = index + 1
    end
  end
  DataModel.CanSaleList[savedTab] = tabData
  DataModel.TypeToShopId[savedTab] = shopId
end
local InitFurnitureSaleData = function(shopId, savedTab)
  local recycleListIdRecord = GetShopIdRecycleList(shopId)
  local tabData = {}
  tabData.shopId = shopId
  tabData.commodityList = {}
  local index = 1
  local serverData = PlayerData:GetHomeInfo().furniture
  local idToIndex = {}
  for k1, v1 in pairs(serverData) do
    if v1.u_cid == "" then
      local id = tonumber(v1.id)
      if idToIndex[id] then
        local t = tabData.commodityList[idToIndex[id]]
        t.num = t.num + 1
        table.insert(t.uids, k1)
      elseif recycleListIdRecord[id] then
        local t = {}
        t.data = v1
        t.uids = {}
        table.insert(t.uids, k1)
        t.id = id
        t.commodityId = recycleListIdRecord[id]
        t.num = 1
        tabData.commodityList[index] = t
        idToIndex[id] = index
        index = index + 1
      end
    end
  end
  DataModel.CanSaleList[savedTab] = tabData
  DataModel.TypeToShopId[savedTab] = shopId
end

function DataModel.InitCanSaleData()
  if table.count(DataModel.CanSaleList) > 0 then
    return
  end
  DataModel.CanSaleList = {}
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  for k, v in pairs(stationCA.petRecycleStoreList) do
    local savedTab
    if v.id == 40300024 then
      InitPetSaleData(v.id, DataModel.TabType.Pet)
    elseif v.id == 40300020 then
      InitFurnitureSaleData(v.id, DataModel.TabType.Plant)
    elseif v.id == 40300014 then
      InitFishSaleData(v.id, DataModel.TabType.Fish)
    elseif v.id == 40300025 then
      InitFurnitureSaleData(v.id, DataModel.TabType.PetStuff)
    end
  end
end

function DataModel.RefreshSpecialTypeData(tabType)
  local shopId = DataModel.TypeToShopId[tabType]
  if tabType == DataModel.TabType.Pet then
    InitPetSaleData(shopId, tabType)
  elseif tabType == DataModel.TabType.Fish then
    InitFishSaleData(shopId, tabType)
  else
    InitFurnitureSaleData(shopId, tabType)
  end
end

return DataModel
