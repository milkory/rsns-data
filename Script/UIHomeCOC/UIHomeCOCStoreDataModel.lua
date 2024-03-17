local DataModel = {
  List = {},
  itemList = {},
  Now_List = {},
  curIndex = 1
}

function DataModel.InitShopData()
  local MainDataModel = require("UIHomeCOC/UIHomeCOCDataModel")
  local stationConfig = PlayerData:GetFactoryData(MainDataModel.StationId, "HomeStationFactory")
  DataModel.List = {}
  DataModel.AutoRefreshTime = {}
  local count = 1
  for k, v in pairs(stationConfig.cocStoreList) do
    local storeFactory = PlayerData:GetFactoryData(v.id)
    local severStoreValue = PlayerData.ServerData.shops[tostring(v.id)]
    DataModel.List[count] = {}
    if severStoreValue then
      DataModel.List[count].server = severStoreValue
    end
    DataModel.List[count].storeType = storeFactory.storeType
    DataModel.List[count].shopId = v.id
    DataModel.List[count].name = storeFactory.name
    DataModel.List[count].isAutoRefresh = storeFactory.autoRefresh
    local t = {}
    local idxRecord = {}
    if storeFactory.storeType == "Random" and severStoreValue then
      for k1, v1 in pairs(severStoreValue.items) do
        table.insert(t, {
          id = tonumber(v1.id),
          idx = k1,
          storeType = storeFactory.storeType
        })
      end
      for k1, v1 in pairs(storeFactory.commodityFixedList) do
        idxRecord[v1.id] = k1 - 100
      end
      for k1, v1 in pairs(storeFactory.shopList) do
        if idxRecord[v1.id] == nil then
          idxRecord[v1.id] = k1
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
    DataModel.List[count].idxRecord = idxRecord
    DataModel.List[count].shopList = t
    count = count + 1
  end
end

function DataModel.RefreshShopDataDetail()
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
          end
        end
      end
    end
    if data.purchase then
      row.residue = data.purchaseNum - (row.py_cnt or 0)
      if row.residue < 0 then
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
    elseif idxRecord[a.id] < idxRecord[b.id] then
      return true
    end
    return false
  end)
end

return DataModel
