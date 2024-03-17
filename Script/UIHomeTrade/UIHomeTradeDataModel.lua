local DataModel = {
  StationId = 0,
  NpcId = 0,
  BgPath = "",
  BgColor = "#FFFFFF",
  CityHallName = "",
  BatchNum = 0,
  BatchType = 0,
  BatchInfo = 0,
  BatchIdx = 0,
  IsTradeOpen = false,
  NPCDialogEnum = {
    enterText = "enterText",
    talkText = "talkText",
    tabBuyText = "tabBuyText",
    tabSellText = "tabSellText",
    buyDownText = "buyDownText",
    buyUpText = "buyUpText",
    buyFlatText = "buyFlatText",
    cancelBuyText = "cancelBuyText",
    buySuccessText = "buySuccessText",
    sellDownText = "sellDownText",
    sellUpText = "sellUpText",
    sellFlatText = "sellFlatText",
    cancelSellText = "cancelSellText",
    sellSuccessText = "sellSuccessText",
    haggleSuccessText = "haggleSuccessText",
    haggleFailText = "haggleFailText",
    raiseSuccessText = "raiseSuccessText",
    raiseFailText = "raiseFailText",
    openWarehouseText = "openWarehouseText"
  }
}

function DataModel.Init()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationCA = PlayerData:GetFactoryData(stationCA.attachedToCity, "HomeStationFactory")
  end
  DataModel.CityHallName = stationCA.cityHallName
  DataModel.IsTradeOpen = false
end

function DataModel.RefreshSpecialGoodsInfo()
  Net:SendProto("station.special_goods", function(json)
    local sellSuddenRise = {}
    local sellSuddenDrop = {}
    local buySuddenRise = {}
    local buySuddenDrop = {}
    for k, v in pairs(json.special_goods.super_goods) do
      local stationId = tonumber(k)
      if stationId ~= DataModel.StationId then
        for k1, v1 in pairs(v) do
          if k1 == "sell_price" then
            for k2, v2 in pairs(v1) do
              local t = {}
              t.id = tonumber(k2)
              t.end_time = v2.end_time
              t.stationId = stationId
              local listCA = PlayerData:GetFactoryData(t.id, "ListFactory")
              local goodsCA = PlayerData:GetFactoryData(listCA.goodsId, "HomeGoodsFactory")
              t.goodsName = goodsCA.name
              local stationCA = PlayerData:GetFactoryData(t.stationId, "HomeStationFactory")
              t.stationName = stationCA.name
              if v2.is_rise == 1 then
                table.insert(sellSuddenRise, t)
              elseif v2.is_rise == -1 then
                table.insert(sellSuddenDrop, t)
              end
            end
          else
            for k2, v2 in pairs(v1) do
              local t = {}
              t.id = tonumber(k2)
              t.end_time = v2.end_time
              t.stationId = stationId
              local listCA = PlayerData:GetFactoryData(t.id, "ListFactory")
              local goodsCA = PlayerData:GetFactoryData(listCA.goodsId, "HomeGoodsFactory")
              t.goodsName = goodsCA.name
              local stationCA = PlayerData:GetFactoryData(t.stationId, "HomeStationFactory")
              t.stationName = stationCA.name
              if v2.is_rise == 1 then
                table.insert(buySuddenRise, t)
              elseif v2.is_rise == -1 then
                table.insert(buySuddenDrop, t)
              end
            end
          end
        end
      end
    end
    local rareInfo = {}
    for k, v in pairs(json.special_goods.rare_info) do
      local t = {}
      t.id = tonumber(v)
      local goodsCA = PlayerData:GetFactoryData(t.id, "HomeGoodsFactory")
      t.name = goodsCA.name
      table.insert(rareInfo, t)
    end
    PlayerData.TempCache.NPCTalkData[EnumDefine.NPCTalkDataEnum.BuySuddenRise] = buySuddenRise
    PlayerData.TempCache.NPCTalkData[EnumDefine.NPCTalkDataEnum.BuySuddenDrop] = buySuddenDrop
    PlayerData.TempCache.NPCTalkData[EnumDefine.NPCTalkDataEnum.SellSuddenRise] = sellSuddenRise
    PlayerData.TempCache.NPCTalkData[EnumDefine.NPCTalkDataEnum.SellSuddenDrop] = sellSuddenDrop
    PlayerData.TempCache.NPCTalkData[EnumDefine.NPCTalkDataEnum.RareGoods] = rareInfo
  end)
end

function DataModel.NumFloorPrecision(num)
  local a, b = math.modf(num)
  if 0 <= num then
    if b + 1.0E-4 > 1 then
      a = a + 1
    else
      return a
    end
  elseif b - 1.0E-4 < -1 then
    a = a - 1
  else
    return a
  end
  return a
end

function DataModel.NumCeilPrecision(num)
  local a, b = math.modf(num)
  if 0 <= num then
    if 0 > b - 1.0E-4 then
      return a
    else
      return a + 1
    end
  elseif 0 < b + 1.0E-4 then
    return a
  else
    return a - 1
  end
  return a + 1
end

function DataModel.GetPreciseDecimal(nNum, n)
  if type(nNum) ~= "number" then
    return nNum
  end
  n = n or 0
  n = math.floor(n)
  if n < 0 then
    n = 0
  end
  local nDecimal = 10 ^ n
  local nTemp = math.floor(nNum * nDecimal)
  local nRet = nTemp / nDecimal
  return nRet
end

function DataModel.NumRound(num)
  if 0 < num then
    return DataModel.NumFloorPrecision(num + 0.5)
  elseif num < 0 then
    return DataModel.NumFloorPrecision(num - 0.5)
  end
  return 0
end

return DataModel
