local MainDataModel = require("UIHomeTrade/UIHomeTradeDataModel")
local DataModel = {
  CurGoods = {},
  StationGoods = {},
  ChangeGoods = {},
  CurGoodsBatchMode = 0,
  StationGoodsBatchMode = 0,
  CurGoodsSpace = 0,
  CurGoodsMaxSpace = 0,
  StationGoodsSpace = 0,
  StationGoodsMaxSpace = 0,
  BuySpaceNum = 0,
  CanBuySpace = false
}

function DataModel.Init()
  DataModel.CurGoodsBatchMode = 0
  DataModel.StationGoodsBatchMode = 0
  DataModel.CurGoods = {}
  DataModel.StationGoods = {}
  DataModel.ChangeGoods = {}
  local space_info = PlayerData:GetUserInfo().space_info
  DataModel.CurGoodsSpace = space_info.now_train_goods_num
  DataModel.CurGoodsMaxSpace = PlayerData.GetMaxTrainGoodsNum()
  DataModel.StationGoodsSpace = PlayerData.GetStationCurrentGoodsNum(MainDataModel.StationId)
  DataModel.StationGoodsMaxSpace = PlayerData:GetHomeInfo().stations[tostring(MainDataModel.StationId)].max_goods_space or 0
  local curGoodsIdx = 1
  local stationGoodsIdx = 1
  for k, v in pairs(PlayerData:GetGoods()) do
    local saveCur = 0 < v.num
    local serverStation = v.stations and v.stations[tostring(MainDataModel.StationId)]
    local saveStation = serverStation ~= nil and 0 < serverStation
    local info
    if saveCur or saveStation then
      info = {}
      info.id = tonumber(k)
      local goodsCA = PlayerData:GetFactoryData(info.id, "HomeGoodsFactory")
      info.name = goodsCA.name
      info.des = goodsCA.des
      info.sort = goodsCA.sort
      info.imagePath = goodsCA.imagePath
      info.space = goodsCA.space
      info.qualityInt = goodsCA.qualityInt
      info.price = v.avg_price
      info.isGoods = goodsCA.mod == "订单货物"
    end
    if saveCur then
      local t = {}
      t.info = info
      t.num = v.num
      DataModel.CurGoods[curGoodsIdx] = t
      curGoodsIdx = curGoodsIdx + 1
    end
    if saveStation then
      local t1 = {}
      t1.info = info
      t1.num = serverStation or 0
      DataModel.StationGoods[stationGoodsIdx] = t1
      stationGoodsIdx = stationGoodsIdx + 1
    end
  end
  table.sort(DataModel.CurGoods, function(a, b)
    return a.info.sort > b.info.sort
  end)
  table.sort(DataModel.StationGoods, function(a, b)
    return a.info.sort > b.info.sort
  end)
end

function DataModel.CurToStation(idx, num)
  local remainNum = DataModel.StationGoodsMaxSpace - DataModel.StationGoodsSpace
  if remainNum < 0 then
    remainNum = 0
  end
  if num > remainNum then
    num = remainNum
  end
  if num == 0 then
    CommonTips.OpenTips(80601086)
    return false
  end
  local data = DataModel.CurGoods[idx]
  local stationIdx = -1
  for k, v in pairs(DataModel.StationGoods) do
    if v.info.id == data.info.id then
      stationIdx = k
      break
    end
  end
  if num >= data.num then
    num = data.num
    table.remove(DataModel.CurGoods, idx)
  else
    data.num = data.num - num
  end
  if stationIdx ~= -1 then
    local stationGoodsData = DataModel.StationGoods[stationIdx]
    stationGoodsData.num = stationGoodsData.num + num
  else
    local t = {}
    t.info = data.info
    t.num = num
    table.insert(DataModel.StationGoods, t)
  end
  DataModel.CurGoodsSpace = DataModel.CurGoodsSpace - num
  DataModel.StationGoodsSpace = DataModel.StationGoodsSpace + num
  if DataModel.ChangeGoods[data.info.id] == nil then
    DataModel.ChangeGoods[data.info.id] = 0
  end
  DataModel.ChangeGoods[data.info.id] = DataModel.ChangeGoods[data.info.id] + num
  return true
end

function DataModel.StationToCur(idx, num)
  local remainNum = DataModel.CurGoodsMaxSpace - DataModel.CurGoodsSpace
  if remainNum < 0 then
    remainNum = 0
  end
  if num > remainNum then
    num = remainNum
  end
  if num == 0 then
    CommonTips.OpenTips(80600284)
    return false
  end
  local data = DataModel.StationGoods[idx]
  local curGoodsIdx = -1
  for k, v in pairs(DataModel.CurGoods) do
    if v.info.id == data.info.id then
      curGoodsIdx = k
      break
    end
  end
  if num >= data.num then
    num = data.num
    table.remove(DataModel.StationGoods, idx)
  else
    data.num = data.num - num
  end
  if curGoodsIdx ~= -1 then
    local curGoodsData = DataModel.CurGoods[curGoodsIdx]
    curGoodsData.num = curGoodsData.num + num
  else
    local t = {}
    t.info = data.info
    t.num = num
    table.insert(DataModel.CurGoods, t)
  end
  DataModel.CurGoodsSpace = DataModel.CurGoodsSpace + num
  DataModel.StationGoodsSpace = DataModel.StationGoodsSpace - num
  if DataModel.ChangeGoods[data.info.id] == nil then
    DataModel.ChangeGoods[data.info.id] = 0
  end
  DataModel.ChangeGoods[data.info.id] = DataModel.ChangeGoods[data.info.id] - num
  return true
end

function DataModel.GetRemainStationSpace()
  local homeCommon = require("Common/HomeCommon")
  local repData = homeCommon.GetCurLvRepData(MainDataModel.StationId)
  local maxNum = repData.wareNum
  local curNum = PlayerData:GetHomeInfo().stations[tostring(MainDataModel.StationId)].max_goods_space or 0
  return maxNum - curNum
end

function DataModel.DealWithGoods(cb)
  local storageArr = ""
  local getArr = ""
  for k, v in pairs(DataModel.ChangeGoods) do
    local str = ""
    if 0 < v then
      if storageArr ~= "" then
        str = str .. ","
      end
      str = str .. "\"" .. k .. "\"" .. ":" .. v
      storageArr = storageArr .. str
    elseif v < 0 then
      if getArr ~= "" then
        str = str .. ","
      end
      str = str .. "\"" .. k .. "\"" .. ":" .. -v
      getArr = getArr .. str
    end
  end
  if storageArr == "" and getArr == "" then
    if cb then
      cb()
    end
    return
  end
  Net:SendProto("station.deal_with_goods", function(json)
    for k, v in pairs(DataModel.ChangeGoods) do
      local warehouseGoods = PlayerData:GetGoods()[tostring(k)]
      local stationId = tostring(MainDataModel.StationId)
      if 0 < v then
        warehouseGoods.num = warehouseGoods.num - v
        if warehouseGoods.stations == nil then
          warehouseGoods.stations = {}
          warehouseGoods.stations[stationId] = 0
        end
        if warehouseGoods.stations[stationId] == nil then
          warehouseGoods.stations[stationId] = 0
        end
        warehouseGoods.stations[stationId] = warehouseGoods.stations[stationId] + v
      elseif v < 0 then
        warehouseGoods.num = warehouseGoods.num - v
        warehouseGoods.stations[stationId] = warehouseGoods.stations[stationId] + v
      end
    end
    if cb then
      cb()
    end
  end, storageArr, getArr)
end

return DataModel
