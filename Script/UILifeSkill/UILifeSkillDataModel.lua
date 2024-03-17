local DataModel = {
  HomeSkillInfo = {}
}

function DataModel.Init()
  DataModel.HomeSkillInfo = {}
  local curStationId = 0
  local station_info = PlayerData:GetHomeInfo().station_info
  if station_info ~= nil then
    local stop_info = station_info.stop_info
    if stop_info ~= nil and stop_info[2] == -1 then
      curStationId = tonumber(stop_info[1])
    end
  end
  local homeSkillIdIndex = {}
  local indexRecord = 0
  local stationCA = PlayerData:GetFactoryData(curStationId)
  local sellDic = {}
  for i, v in ipairs(stationCA.sellList) do
    local goodsCA = PlayerData:GetFactoryData(v.id)
    sellDic[goodsCA.goodsId] = 0
  end
  local checkGoodsIsInCity = function(goodsList, sellList)
    if goodsList == nil then
      return true
    end
    for i, v in ipairs(goodsList) do
      if sellList[v.id] then
        return true
      end
    end
    return false
  end
  local bookUnitCA = PlayerData:GetFactoryData(80900001, "BookFactory")
  for k, v in ipairs(bookUnitCA.unitList) do
    local unitCA = PlayerData:GetFactoryData(v.id, "unitFactory")
    local len = #unitCA.homeSkillList
    local homeSkillPreSkillIdRecord = {}
    for k1, v1 in ipairs(unitCA.homeSkillList) do
      local homeSkillCA = PlayerData:GetFactoryData(v1.id, "HomeSkillFactory")
      if homeSkillCA.tag == 1 and homeSkillPreSkillIdRecord[v1.id] == nil and ((homeSkillCA.city == nil or 0 >= homeSkillCA.city) and checkGoodsIsInCity(homeSkillCA.goodsList, sellDic) or homeSkillCA.city and homeSkillCA.city == curStationId) then
        local t = {}
        t.unitId = v.id
        t.resonanceLv = v1.resonanceLv
        t.nextId = 0
        t.param = homeSkillCA.param
        t.skillLv = 1
        local serverInfo = PlayerData.ServerData.roles[tostring(v.id)]
        t.hadUnit = false
        t.unlock = false
        if serverInfo then
          t.hadUnit = true
          if serverInfo.resonance_lv >= t.resonanceLv then
            t.unlock = true
          end
        end
        local info = v1
        while 0 < info.nextIndex and len >= info.nextIndex do
          local recordSelfId = info.id
          info = unitCA.homeSkillList[info.nextIndex]
          local nextId = info.id
          local nextResonanceLv = info.resonanceLv
          homeSkillPreSkillIdRecord[nextId] = recordSelfId
          if t.unlock and 0 < nextId and nextResonanceLv <= serverInfo.resonance_lv then
            local nextHomeSkillCA = PlayerData:GetFactoryData(nextId, "HomeSkillFactory")
            t.param = t.param + nextHomeSkillCA.param
            t.skillLv = t.skillLv + 1
          end
        end
        local recordTable
        if homeSkillIdIndex[v1.id] then
          recordTable = DataModel.HomeSkillInfo[homeSkillIdIndex[v1.id]]
        else
          recordTable = {}
          indexRecord = indexRecord + 1
          homeSkillIdIndex[v1.id] = indexRecord
          recordTable.id = v1.id
          recordTable.homeSkillCA = homeSkillCA
          recordTable.unlockCount = 0
          recordTable.param = 0
          recordTable.unitInfo = {}
          DataModel.HomeSkillInfo[indexRecord] = recordTable
        end
        if t.hadUnit and recordTable.unlockCount + 1 <= #recordTable.unitInfo then
          table.insert(recordTable.unitInfo, recordTable.unlockCount + 1, t)
        else
          table.insert(recordTable.unitInfo, t)
        end
        if t.unlock then
          recordTable.unlockCount = recordTable.unlockCount + 1
          recordTable.param = recordTable.param + t.param
        end
      end
    end
  end
  table.sort(DataModel.HomeSkillInfo, function(a, b)
    return a.homeSkillCA.sort > b.homeSkillCA.sort
  end)
end

return DataModel
