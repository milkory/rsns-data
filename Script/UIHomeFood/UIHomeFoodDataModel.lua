local DataModel = {
  curHomeEnergy = 0,
  todayUpgradeUseCount = 0,
  foodList = {},
  dayRefreshTimeStamp = 0
}

function DataModel.InitData()
  DataModel.curHomeEnergy = PlayerData:GetUserInfo().move_energy or 0
  DataModel.RefreshFoodList()
end

function DataModel.InitDayRefreshTime()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local orderTimeList = homeConfig.orderTimeList
  local count = #orderTimeList
  local idx = 0
  for i = 1, count do
    local orderTime = orderTimeList[i].time
    local h = tonumber(string.sub(orderTime, 1, 2))
    local m = tonumber(string.sub(orderTime, 4, 5))
    local s = tonumber(string.sub(orderTime, 7, 8))
    local orderTimeStamp = TimeUtil:GetNextSpecialTimeStamp(h, m, s, TimeUtil:GetFutureTime(0, 0))
    if orderTimeStamp > TimeUtil:GetServerTimeStamp() then
      DataModel.dayRefreshTimeStamp = orderTimeStamp
      break
    end
    idx = idx + 1
  end
  if count <= idx then
    local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
    local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
    local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
    DataModel.dayRefreshTimeStamp = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
  end
end

function DataModel.RefreshFoodList()
  DataModel.foodList = {}
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local count = #homeConfig.orderTimeList
  local totalCount = count + homeConfig.foodBag
  local usedRecord = {}
  for k, v in pairs(PlayerData.ServerData.user_home_info.meal_info.work_meal) do
    usedRecord[v] = 0
  end
  for i = 1, count do
    local used = usedRecord[i - 1] ~= nil
    local t = {}
    t.id = homeConfig.orderTimeList[i].id
    t.refreshTime = homeConfig.orderTimeList[i].time
    local foodCA = PlayerData:GetFactoryData(t.id, "FoodFactory")
    t.ca = foodCA
    t.free = true
    t.used = used
    DataModel.foodList[i] = t
  end
  local serverFood = PlayerData.ServerData.user_home_info.meal_info.box_meal
  local temp = {}
  for k, v in pairs(serverFood) do
    local t = {}
    t.id = tonumber(v.id)
    t.uid = k
    t.getTime = v.obtain_time
    t.dueTime = v.due_time
    t.hid = v.hid and tonumber(v.hid) or 10000055
    local foodCA = PlayerData:GetFactoryData(t.id, "FoodFactory")
    t.ca = foodCA
    table.insert(temp, t)
  end
  DataModel.Sort(temp)
  for i = count + 1, #temp + count do
    DataModel.foodList[i] = temp[i - count]
  end
  count = count + #temp
  for i = count + 1, totalCount do
    DataModel.foodList[i] = nil
  end
  DataModel.mealCount = count
end

function DataModel.UseFood(idx)
  DataModel.ListPosOffset(idx)
end

function DataModel.ListPosOffset(idx)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local count = #homeConfig.orderTimeList
  if idx <= count then
    DataModel.foodList[idx].used = true
  else
    local foodList = DataModel.foodList
    local uid = foodList[idx].uid
    PlayerData:ClearLoveBentoClicked(uid)
    for i = idx, count + homeConfig.foodBag - 1 do
      foodList[i] = foodList[i + 1]
      if foodList[i] == nil then
        break
      end
    end
    DataModel.mealCount = DataModel.mealCount - 1
  end
end

function DataModel.Sort(t)
  table.sort(t, function(a, b)
    local isClickedA = PlayerData:GetLoveBentoClicked(a.uid)
    local isClickedB = PlayerData:GetLoveBentoClicked(b.uid)
    if not isClickedA and isClickedB then
      return true
    elseif isClickedA and not isClickedB then
      return false
    elseif a.getTime > b.getTime then
      return true
    elseif a.getTime < b.getTime then
      return false
    elseif a.ca.id > b.ca.id then
      return true
    end
    return false
  end)
end

return DataModel
