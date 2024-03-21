local DataModel = {
  StationId = 0,
  BuildingId = 0,
  NpcId = 0,
  BgPath = "",
  BgColor = "FFFFFF",
  List = {},
  CurIndex = 0,
  Now_List = {},
  ShopId = 0,
  refreshChecked = false,
  AutoRefreshTime = {},
  NPCDialogEnum = {
    enterText = "enterText",
    drinkText = "drinkText",
    upperText = "upperText",
    OneText = "OneText",
    StoreText = "StoreText",
    talkText = "talkText",
    ItemText = "ItemText"
  },
  DrinkInfo = 0,
  DrinkCurCount = 0,
  DrinkIdx = 0,
  CacheOpenStore = {},
  CacheEventList = {}
}

function DataModel.InitShopData(idx)
  if idx == nil then
    idx = DataModel.CurIndex
  end
  local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  local storeInfo = stationConfig.barStoreList[idx]
  local storeId = storeInfo.id
  local storeFactory = PlayerData:GetFactoryData(storeId)
  local severStoreValue = PlayerData.ServerData.shops[tostring(storeId)]
  DataModel.List[idx] = {}
  if severStoreValue then
    DataModel.List[idx].server = severStoreValue
  end
  DataModel.List[idx].storeType = storeFactory.storeType
  DataModel.List[idx].shopId = storeId
  DataModel.List[idx].name = storeFactory.name
  local t = {}
  local idxRecord = {}
  if storeFactory.storeType == "Random" and severStoreValue then
    local shopList
    local sortId = 0
    for k1, v1 in ipairs(storeFactory.commodityFixedList) do
      shopList = PlayerData:GetFactoryData(v1.id).shopList
      if shopList ~= nil then
        for k2, v2 in ipairs(shopList) do
          idxRecord[v2.id] = sortId
          sortId = sortId + 1
        end
      else
        idxRecord[v1.id] = sortId
        sortId = sortId + 1
      end
    end
    for k1, v1 in ipairs(storeFactory.shopList) do
      shopList = PlayerData:GetFactoryData(v1.id).shopList
      if shopList ~= nil then
        for k2, v2 in ipairs(shopList) do
          if idxRecord[v2.id] == nil then
            idxRecord[v2.id] = sortId
            sortId = sortId + 1
          end
        end
      elseif idxRecord[v1.id] == nil then
        idxRecord[v1.id] = sortId
        sortId = sortId + 1
      end
    end
    for k1, v1 in pairs(severStoreValue.items) do
      local id = tonumber(v1.id)
      if idxRecord[id] ~= nil then
        local ca = PlayerData:GetFactoryData(v1.id)
        if ca ~= nil then
          table.insert(t, {
            id = id,
            idx = k1,
            storeType = storeFactory.storeType
          })
        end
      end
    end
  else
    for k1, v1 in pairs(storeFactory.shopList) do
      table.insert(t, {
        id = v1.id,
        idx = k1,
        storeType = storeFactory.storeType
      })
    end
  end
  DataModel.List[idx].idxRecord = idxRecord
  DataModel.List[idx].shopList = t
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
end

function DataModel.RefreshShopDataDetail()
  local removeIdx = {}
  for i, j in pairs(DataModel.Now_List.shopList) do
    local row = j
    local data = PlayerData:GetFactoryData(row.id)
    if DataModel.Now_List.server then
      if DataModel.Now_List.storeType == "Random" then
        for k, v in pairs(DataModel.Now_List.server.items) do
          if k == row.idx and tonumber(v.id) == tonumber(row.id) then
            row.py_cnt = v.py_cnt
          end
        end
      else
        for k, v in pairs(DataModel.Now_List.server.items) do
          if tonumber(v.id) == tonumber(row.id) then
            row.py_cnt = v.py_cnt
            if v.last_auto_refresh and data.isTriggerTime then
              row.endTime = v.last_auto_refresh + (data.continueTime or 0)
              if TimeUtil:GetServerTimeStamp() >= row.endTime then
                table.insert(removeIdx, i)
              end
            end
          end
        end
      end
    end
    if data.purchase then
      row.residue = data.purchaseNum - (row.py_cnt or 0)
      if 0 > row.residue then
        row.residue = 0
      end
    else
      row.residue = 100
    end
    row.buyLimit = false
    row.limitRep = 0
    row.limitGrade = 0
    if data.isBuyCondition then
      if 0 < data.repGradeCondition then
        local stationId = DataModel.StationId
        if 0 < data.stationCondition then
          stationId = data.stationCondition
          local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
          if 0 < stationCA.attachedToCity then
            stationId = stationCA.attachedToCity
          end
        end
        local curRep = PlayerData:GetHomeInfo().stations[tostring(stationId)].rep_lv
        if curRep < data.repGradeCondition then
          row.buyLimit = true
          row.limitRep = data.repGradeCondition
        end
      end
      if 0 < data.gradeCondition then
        local curLv = PlayerData:GetPlayerLevel()
        if curLv < data.gradeCondition then
          row.buyLimit = true
          row.limitGrade = data.gradeCondition
        end
      end
    end
  end
  local count = 0
  for k, v in pairs(removeIdx) do
    table.remove(DataModel.Now_List.shopList, v - count)
    count = count + 1
  end
  local idxRecord = DataModel.Now_List.idxRecord
  local isLocalSort = DataModel.Now_List.storeType == "Regular"
  table.sort(DataModel.Now_List.shopList, function(a, b)
    if a.residue == 0 and b.residue > 0 then
      return false
    end
    if a.residue > 0 and b.residue == 0 then
      return true
    end
    if a.buyLimit and not b.buyLimit then
      return false
    end
    if not a.buyLimit and b.buyLimit then
      return true
    end
    if isLocalSort then
      return a.idx < b.idx
    else
      local sort1 = idxRecord[a.id]
      if sort1 == nil then
        error("shopId : " .. DataModel.Now_List.shopId .. " not exist id : " .. a.id)
        return false
      end
      local sort2 = idxRecord[b.id]
      if sort2 == nil then
        error("shopId : " .. DataModel.Now_List.shopId .. " not exist id : " .. b.id)
        return false
      end
      if sort1 < sort2 then
        return true
      end
    end
    return false
  end)
end

function DataModel.GetYN()
  return PlayerData:GetGoodsById(11400001).num
end

function DataModel.GetHS()
  return PlayerData:GetGoodsById(11400005).num
end

function DataModel.GetCharacterCoin()
  return PlayerData:GetGoodsById(11400017).num
end

function DataModel.CheckRefreshCehcked()
  local id = PlayerData:GetUserInfo().uid
  local time = PlayerData:GetPlayerPrefs("int", "refreshBarStore")
  if time ~= nil then
    local curTime = TimeUtil:GetServerTimeStamp()
    if 86400 < curTime - time then
      DataModel.refreshChecked = false
    else
      local t1 = TimeUtil:GetTimeStampTotalDays(time)
      local t2 = TimeUtil:GetTimeStampTotalDays(curTime)
      if t1 == t2 then
        DataModel.refreshChecked = true
      else
        DataModel.refreshChecked = false
      end
    end
  end
end

function DataModel.SetRefreshChecked()
  local id = PlayerData:GetUserInfo().uid
  PlayerData:SetPlayerPrefs("int", "refreshBarStore", TimeUtil:GetServerTimeStamp())
end

return DataModel
