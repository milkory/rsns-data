local MainDataModel = require("UIHomeTrade/UIHomeTradeDataModel")
local HomeCommon = require("Common/HomeCommon")
local DataModel = {
  StationId = 0,
  CurCityGoodsInfo = nil,
  LocalSellGoods = {},
  MaxSpace = 0,
  CurUseSpace = 0,
  CurTradeType = 0,
  TradeType = {Buy = 1, Sale = 2},
  CurSellList = nil,
  CurAcquisitionList = nil,
  AcquistionRemoveReocrd = nil,
  CurSelectGoodIdx = 0,
  IdToDetailInfo = nil,
  TempGoodsList = nil,
  TempCurCost = 0,
  TempCurSpace = 0,
  TempCurProfit = 0,
  TempCurAvgCost = 0,
  TempCurTotalSalePrice = 0,
  BuyBatchMode = 1,
  SaleBatchMode = 1,
  DayRefreshTime = 0,
  AddBargainCount = 0,
  AddBargainSuccessRate = 0,
  AddBargainRange = 0,
  AddRiseCount = 0,
  AddRiseSuccessRate = 0,
  AddRiseRange = 0,
  GoodsBuyLimitUp = nil,
  AllGoodsBuyLimitUp = 0,
  AllSpeGoodsBuyLimitUp = 0,
  TaxCuts = 0,
  ActivityGoodsBuyLimitUp = {},
  ActivityTaxCuts = {},
  FirstBargainBuy = 0,
  FirstBargainSale = 0,
  AfterBargainFailBuy = 0,
  AfterBargainFailSale = 0,
  BargainSuccessRateIndex = 1,
  RiseSuccessRateIndex = 1,
  PersonTotalTZ = 0,
  DrinkBuff = nil,
  QuestGoodsId = nil,
  recent_trade_report = nil,
  BargainBuff = nil,
  SoundEnum = {
    tradeBarginSuccess = "tradeBarginSuccessList",
    tradeRaiseSuccess = "tradeRaiseSuccessList",
    tradeBargainFailure = "tradeBargainFailureList",
    tradeSettlementBuy = "tradeSettlementBuyList",
    tradeSettlementSell = "tradeSettlementSell",
    tradeSettlementSell30W = "tradeSettlementSell30W",
    tradeSettlementSell100W = "tradeSettlementSell100W"
  },
  ChildQuestInfoUrl = "UI/HomeTrade/QuestInfo",
  IsShowChildQuest = false,
  CurShowGoodsId = 0
}

function DataModel.ClearData()
  if MainDataModel.IsTradeOpen then
    return
  end
  DataModel.CurCityGoodsInfo = nil
  DataModel.CurSellList = nil
  DataModel.CurAcquisitionList = nil
  DataModel.AcquistionRemoveReocrd = nil
  DataModel.QuestGoodsId = nil
  DataModel.IdToDetailInfo = nil
  DataModel.TempGoodsList = nil
  DataModel.BargainBuff = nil
  DataModel.ClearLocalHomeSkillData()
end

function DataModel.ClearLocalHomeSkillData()
  DataModel.AddBargainCount = 0
  DataModel.AddBargainSuccessRate = 0
  DataModel.AddBargainRange = 0
  DataModel.AddRiseCount = 0
  DataModel.AddRiseSuccessRate = 0
  DataModel.AddRiseRange = 0
  DataModel.GoodsBuyLimitUp = {}
  DataModel.AllGoodsBuyLimitUp = 0
  DataModel.AllSpeGoodsBuyLimitUp = 0
  DataModel.TaxCuts = 0
end

function DataModel.InitHomeSkillData()
  DataModel.ClearLocalHomeSkillData()
  DataModel.DrinkBuff = PlayerData:GetCurDrinkBuff()
  DataModel.AllGoodsBuyLimitUp = HomeCommon.GetCurLvRepData(DataModel.StationId).buyNum
  DataModel.AddBargainCount = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddHaggleNum)
  DataModel.AddBargainSuccessRate = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.HaggleSuccessRate)
  DataModel.AddBargainRange = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.HaggleRange)
  DataModel.AddRiseCount = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddRiseNum)
  DataModel.AddRiseSuccessRate = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseSuccessRate)
  DataModel.AddRiseRange = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseRange)
  DataModel.GoodsBuyLimitUp = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddQty, DataModel.StationId)
  DataModel.TaxCuts = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.TaxCuts, DataModel.StationId)
  DataModel.AllSpeGoodsBuyLimitUp = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddSpecQty, DataModel.StationId)
  DataModel.ActivityGoodsBuyLimitUp = PlayerData:GetActivityBuff(EnumDefine.HomeSkillEnum.AddQty, DataModel.StationId)
  if DataModel.ActivityGoodsBuyLimitUp == 0 then
    DataModel.ActivityGoodsBuyLimitUp = {}
  end
  DataModel.ActivityTaxCuts = PlayerData:GetActivityBuff(EnumDefine.HomeSkillEnum.TaxCuts)
  if DataModel.ActivityTaxCuts == 0 then
    DataModel.ActivityTaxCuts = {}
  end
  DataModel.AfterBargainFailBuy = 0
  DataModel.AfterBargainFailSale = 0
  DataModel.CalcDrinkBuffData()
  local serverInvest = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].invest
  local num = 0
  if serverInvest == nil or #serverInvest == 0 then
    local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
    if 0 < stationCA.attachedToCity then
      serverInvest = PlayerData:GetHomeInfo().stations[tostring(stationCA.attachedToCity)].invest
    end
  end
  if serverInvest ~= nil then
    for k, v in pairs(serverInvest) do
      num = num + v.cost
    end
  end
  DataModel.PersonTotalTZ = num
end

function DataModel.InitQuestGoodsId()
  DataModel.QuestGoodsId = {}
  for cityId, v in pairs(PlayerData:GetHomeInfo().stations) do
    if v.quests and v.quests.Buy then
      for questId, v1 in pairs(v.quests.Buy) do
        if v1.info and type(v1.info) == "table" then
          local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
          local endStation = v1.sid and tonumber(v1.sid) or questCA.endStationList[1].id
          local needInfo = {}
          for k2, v2 in pairs(questCA.goodsList) do
            needInfo[v2.id] = v2.num
          end
          for goodsId, v2 in pairs(v1.info) do
            local numGoodsId = tonumber(goodsId)
            if needInfo[numGoodsId] then
              if DataModel.QuestGoodsId[numGoodsId] == nil then
                local t = {}
                t.needNum = 0
                t.curNum = PlayerData:GetGoodsById(numGoodsId).num
                DataModel.QuestGoodsId[numGoodsId] = t
              end
              if DataModel.QuestGoodsId[numGoodsId].quests == nil then
                DataModel.QuestGoodsId[numGoodsId].quests = {}
              end
              local goodsIdTable = DataModel.QuestGoodsId[numGoodsId]
              local goodsIdQuest = goodsIdTable.quests
              local curNeedNum = needInfo[numGoodsId] - v2
              local t = {}
              t.questId = questId
              t.needNum = curNeedNum
              t.endStation = endStation
              table.insert(goodsIdQuest, t)
              goodsIdTable.needNum = goodsIdTable.needNum + curNeedNum
            end
          end
        end
      end
    end
  end
end

function DataModel.CalcDrinkBuffData(remove)
  local mul = 1
  if remove then
    mul = -1
  end
  if DataModel.DrinkBuff ~= nil then
    local buffCA = PlayerData:GetFactoryData(DataModel.DrinkBuff.id, "HomeBuffFactory")
    if buffCA.buffType == EnumDefine.HomeSkillEnum.AddHaggleNum then
      DataModel.AddBargainCount = DataModel.AddBargainCount + DataModel.DrinkBuff.param * mul
    elseif buffCA.buffType == EnumDefine.HomeSkillEnum.HaggleSuccessRate then
      DataModel.AddBargainSuccessRate = DataModel.AddBargainSuccessRate + DataModel.DrinkBuff.param * mul
    elseif buffCA.buffType == EnumDefine.HomeSkillEnum.HaggleRange then
      DataModel.AddBargainRange = DataModel.AddBargainRange + DataModel.DrinkBuff.param * mul
    elseif buffCA.buffType == EnumDefine.HomeSkillEnum.AddRiseNum then
      DataModel.AddRiseCount = DataModel.AddRiseCount + DataModel.DrinkBuff.param * mul
    elseif buffCA.buffType == EnumDefine.HomeSkillEnum.RiseSuccessRate then
      DataModel.AddRiseSuccessRate = DataModel.AddRiseSuccessRate + DataModel.DrinkBuff.param * mul
    elseif buffCA.buffType == EnumDefine.HomeSkillEnum.RiseRange then
      DataModel.AddRiseRange = DataModel.AddRiseRange + DataModel.DrinkBuff.param * mul
    elseif buffCA.buffType == EnumDefine.HomeSkillEnum.AddQty then
      DataModel.AllGoodsBuyLimitUp = DataModel.AllGoodsBuyLimitUp + DataModel.DrinkBuff.param * mul
    elseif buffCA.buffType == EnumDefine.HomeSkillEnum.TaxCuts then
      DataModel.TaxCuts = DataModel.TaxCuts + DataModel.DrinkBuff.param * mul
    elseif buffCA.buffType == EnumDefine.HomeSkillEnum.AddSpecQty then
      DataModel.AllSpeGoodsBuyLimitUp = DataModel.AllSpeGoodsBuyLimitUp + DataModel.DrinkBuff.param * mul
    elseif buffCA.buffType == EnumDefine.HomeSkillEnum.AddSuccessRate then
      DataModel.AddBargainSuccessRate = DataModel.AddBargainSuccessRate + DataModel.DrinkBuff.param * mul
      DataModel.AddRiseSuccessRate = DataModel.AddRiseSuccessRate + DataModel.DrinkBuff.param * mul
    end
  end
end

function DataModel.CalcSpaceInfo()
  DataModel.MaxSpace = MainDataModel.NumFloorPrecision(PlayerData.GetMaxTrainGoodsNum())
  DataModel.CurUseSpace = MainDataModel.NumFloorPrecision(PlayerData:GetUserInfo().space_info.now_train_goods_num)
end

function DataModel.InitLocalSellGoods()
  DataModel.LocalSellGoods = {}
  local stationCA = PlayerData:GetFactoryData(MainDataModel.StationId)
  for k, v in ipairs(stationCA.sellList) do
    DataModel.LocalSellGoods[v.id] = 0
  end
end

function DataModel.InitDayRefreshTime()
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
  local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
  local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
  local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
  DataModel.DayRefreshTime = targetTime
end

function DataModel.GetMoney()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  return PlayerData:GetGoodsById(tonumber(homeConfig.tradeCoin)).num
end

function DataModel.GetActionValue()
  return PlayerData:GetUserInfo().move_energy or 0
end

function DataModel.RefreshSellList(subTemp)
  local sellList = DataModel.CurCityGoodsInfo.sell_price
  DataModel.CurSellList = {}
  DataModel.IdToDetailInfo = {}
  local subNumTable = {}
  if subTemp then
    for k, v in pairs(DataModel.TempGoodsList) do
      subNumTable[v.id] = v.num
    end
  end
  for k, v in pairs(sellList) do
    local listCA = PlayerData:GetFactoryData(k, "ListFactory")
    local goodsCA = PlayerData:GetFactoryData(listCA.goodsId, "HomeGoodsFactory")
    local t = {}
    t.id = tonumber(k)
    t.goodsId = listCA.goodsId
    t.name = goodsCA.name
    t.des = goodsCA.des
    t.imagePath = goodsCA.imagePath
    t.space = goodsCA.space
    t.isSpecial = goodsCA.isSpeciality
    t.qualityInt = goodsCA.qualityInt
    t.needItemNum = listCA.needItemNum
    t.isBan = t.needItemNum > DataModel.PersonTotalTZ
    t.oriPrice = listCA.price
    t.price = v.price
    t.newPrice = MainDataModel.NumRound(t.price * (1 - DataModel.CurCityGoodsInfo.b_quota))
    t.percent = t.price / listCA.price
    t.trend = v.trend
    local up = (DataModel.GoodsBuyLimitUp[t.goodsId] or 0) + (DataModel.GoodsBuyLimitUp.all or 0) + DataModel.AllGoodsBuyLimitUp
    up = up + (DataModel.ActivityGoodsBuyLimitUp[t.goodsId] or 0) + (DataModel.ActivityGoodsBuyLimitUp.all or 0)
    if t.isSpecial then
      up = up + DataModel.AllSpeGoodsBuyLimitUp
    end
    local maxCount = listCA.num
    if 0 < up then
      maxCount = MainDataModel.NumRound(listCA.num * (1 + up))
    end
    local remainTotal = v.stock - v.sold
    if maxCount > remainTotal then
      maxCount = remainTotal
    end
    maxCount = maxCount + v.extra
    if v.num == nil then
      t.num = maxCount
    else
      t.num = maxCount - v.num
      if t.num < 0 then
        t.num = 0
      end
    end
    if subTemp then
      t.num = t.num - (subNumTable[t.id] or 0)
      if t.num < 0 then
        for k, v in pairs(DataModel.TempGoodsList) do
          if v.id == t.id then
            v.num = v.num + t.num
            break
          end
        end
        t.num = 0
      end
    end
    t.revertRemainNum = t.num + (subNumTable[t.id] or 0)
    table.insert(DataModel.CurSellList, t)
    DataModel.IdToDetailInfo[t.id] = t
  end
  DataModel.SortSellList()
end

function DataModel.SortSellList()
  table.sort(DataModel.CurSellList, function(a, b)
    if not a.isBan and b.isBan then
      return true
    elseif a.isBan and not b.isBan then
      return false
    elseif a.isBan and b.isBan then
      if a.needItemNum < b.needItemNum then
        return true
      end
    elseif a.oriPrice > b.oriPrice then
      return true
    end
    return false
  end)
end

function DataModel.RefreshAcquisitionList()
  local acquisitionList = DataModel.CurCityGoodsInfo.buy_price
  DataModel.CurAcquisitionList = {}
  DataModel.IdToDetailInfo = {}
  local stockInfo = PlayerData.ServerData.user_home_info.warehouse
  for k, v in pairs(stockInfo) do
    local id = tonumber(k)
    local goodsCA = PlayerData:GetFactoryData(id, "HomeGoodsFactory")
    if v.num > 0 and goodsCA.mod == "基础货物" then
      local t = {}
      t.goodsId = id
      t.name = goodsCA.name
      t.des = goodsCA.des
      t.imagePath = goodsCA.imagePath
      t.space = goodsCA.space
      t.qualityInt = goodsCA.qualityInt
      t.num = v.num
      t.avgPrice = v.avg_price or 0
      t.trend = 0
      local isInAcquisition = false
      local price = 0
      local percent, listCA
      for k1, v1 in pairs(acquisitionList) do
        listCA = PlayerData:GetFactoryData(k1, "ListFactory")
        if t.goodsId == tonumber(listCA.goodsId) then
          t.id = tonumber(k1)
          t.isSpecial = goodsCA.isSpeciality
          t.trend = v1.trend
          isInAcquisition = true
          price = v1.price
          if DataModel.CurCityGoodsInfo.sell_price[k1] ~= nil then
            percent = DataModel.CurCityGoodsInfo.sell_price[k1].price / listCA.price
            t.isLocal = true
            break
          end
          if DataModel.LocalSellGoods[t.id] ~= nil then
            percent = 1
            t.isLocal = true
          end
          break
        end
      end
      t.isActive = isInAcquisition
      t.price = price
      t.newPrice = MainDataModel.NumRound(t.price * (1 + DataModel.CurCityGoodsInfo.r_quota))
      if percent ~= nil then
        t.percent = percent
      else
        t.percent = price / listCA.price
      end
      if t.isActive then
        table.insert(DataModel.CurAcquisitionList, t)
        DataModel.IdToDetailInfo[t.id] = t
      end
    end
  end
  DataModel.SortAcquisitionList()
end

function DataModel.SortAcquisitionList()
  table.sort(DataModel.CurAcquisitionList, function(a, b)
    if a.isActive == true and b.isActive == false then
      return true
    elseif a.isActive == false and b.isActive == true then
      return false
    elseif a.price > b.price then
      return true
    end
    return false
  end)
end

function DataModel.GetCanBuyOrSaleMaxNum(info, showTips)
  if info == nil then
    return 0
  end
  if DataModel.CurTradeType == DataModel.TradeType.Sale then
    return info.num
  else
    local remainSpace = DataModel.MaxSpace - DataModel.CurUseSpace - DataModel.TempCurSpace
    local num = math.floor(remainSpace / info.space)
    if num <= 0 then
      if showTips then
        CommonTips.OpenTips(80600284)
      end
      return 0
    end
    local remainCoin = DataModel.GetMoney() - MainDataModel.NumRound(DataModel.TempCurCost * (1 + DataModel.GetTax()) + DataModel.GetActivityGoodsTax())
    local newPrice = info.newPrice * (1 + DataModel.GetTax() + (DataModel.ActivityTaxCuts[info.goodsId] or 0))
    local remainCoinNum = math.floor(remainCoin / newPrice)
    if remainCoinNum <= 0 then
      if showTips then
        CommonTips.OpenTips(80600539)
      end
      return 0
    end
    if num > remainCoinNum then
      num = remainCoinNum
    end
    if num < info.num then
      return num
    end
    return info.num
  end
end

function DataModel.RefreshBuyToTempData(info, num)
  if 0 < num then
    if num > info.num then
      num = info.num
    end
    local remainSpace = DataModel.MaxSpace - DataModel.TempCurSpace - DataModel.CurUseSpace
    local addSpace = num * info.space
    if remainSpace < addSpace then
      num = MainDataModel.NumFloorPrecision(remainSpace / info.space)
      if num <= 0 then
        CommonTips.OpenTips(80600284)
        return false
      end
    end
  end
  local curTotalTempNum = 0
  local isFind = false
  for k, v in pairs(DataModel.TempGoodsList) do
    if v.id == info.id then
      isFind = true
      v.num = v.num + num
      if 0 >= v.num then
        table.remove(DataModel.TempGoodsList, k)
        break
      end
      curTotalTempNum = v.num
    end
  end
  if not isFind and 0 < num then
    local t = {}
    t.id = info.id
    t.num = num
    curTotalTempNum = num
    table.insert(DataModel.TempGoodsList, t)
  end
  if not isFind and num < 0 then
    return false
  end
  info.num = info.num - num
  DataModel.TempCurSpace = DataModel.TempCurSpace + num * info.space
  DataModel.TempCurCost = DataModel.TempCurCost + num * info.newPrice
  return true, curTotalTempNum
end

function DataModel.ReCalcTempBuy()
  DataModel.TempCurCost = 0
  for k, v in pairs(DataModel.TempGoodsList) do
    local goodInfo = DataModel.IdToDetailInfo[v.id]
    DataModel.TempCurCost = DataModel.TempCurCost + goodInfo.newPrice * v.num
  end
end

function DataModel.RefreshSaleToTempData(info, num)
  for k, v in pairs(DataModel.CurAcquisitionList) do
    if v.id == info.id then
      if v.num > 0 and num > v.num then
        num = v.num
      end
      break
    end
  end
  local curTotalTempNum = 0
  local isFind = false
  for k, v in pairs(DataModel.CurAcquisitionList) do
    if v.id == info.id then
      isFind = true
      v.num = v.num - num
      if v.num <= 0 then
        DataModel.AcquistionRemoveReocrd[v.id] = v
        table.remove(DataModel.CurAcquisitionList, k)
        DataModel.CurSelectGoodIdx = 1
      end
      break
    end
  end
  if not isFind and num < 0 then
    local t = DataModel.AcquistionRemoveReocrd[info.id]
    t.num = -num
    table.insert(DataModel.CurAcquisitionList, t)
    DataModel.AcquistionRemoveReocrd[info.id] = {}
    DataModel.SortAcquisitionList()
  end
  isFind = false
  for k, v in pairs(DataModel.TempGoodsList) do
    if v.id == info.id then
      isFind = true
      v.num = v.num + num
      if v.num <= 0 then
        table.remove(DataModel.TempGoodsList, k)
        break
      end
      curTotalTempNum = v.num
    end
  end
  if not isFind and 0 < num then
    local t = {}
    t.id = info.id
    t.num = num
    curTotalTempNum = t.num
    if info.isLocal == true then
      table.insert(DataModel.TempGoodsList, 1, t)
    else
      table.insert(DataModel.TempGoodsList, t)
    end
  end
  if not isFind and num < 0 then
    return false
  end
  DataModel.TempCurSpace = DataModel.TempCurSpace + num * info.space
  DataModel.TempCurTotalSalePrice = DataModel.TempCurTotalSalePrice + info.newPrice * num
  DataModel.TempCurAvgCost = DataModel.TempCurAvgCost + info.avgPrice * num
  DataModel.TempCurProfit = DataModel.TempCurTotalSalePrice - DataModel.TempCurAvgCost
  return true, curTotalTempNum
end

function DataModel.ReCalcTempSale()
  DataModel.TempCurProfit = 0
  DataModel.TempCurAvgCost = 0
  DataModel.TempCurTotalSalePrice = 0
  for k, v in pairs(DataModel.TempGoodsList) do
    local goodInfo = DataModel.IdToDetailInfo[v.id]
    local price = goodInfo.newPrice
    DataModel.TempCurAvgCost = DataModel.TempCurAvgCost + goodInfo.avgPrice * v.num
    DataModel.TempCurTotalSalePrice = DataModel.TempCurTotalSalePrice + price * v.num
  end
  DataModel.TempCurProfit = DataModel.TempCurTotalSalePrice - DataModel.TempCurAvgCost
end

function DataModel.ConfirmBargain(isSuccess, quota)
  local isBuy = DataModel.CurTradeType == DataModel.TradeType.Buy
  if isBuy then
    DataModel.CurCityGoodsInfo.b_num = DataModel.CurCityGoodsInfo.b_num + 1
    DataModel.FirstBargainBuy = 0
  else
    DataModel.CurCityGoodsInfo.r_num = DataModel.CurCityGoodsInfo.r_num + 1
    DataModel.FirstBargainSale = 0
  end
  if isSuccess then
    if isBuy then
      DataModel.CurCityGoodsInfo.b_quota = quota
      DataModel.BargainSuccessRateIndex = DataModel.BargainSuccessRateIndex + 1
      DataModel.AfterBargainFailBuy = 0
    else
      DataModel.CurCityGoodsInfo.r_quota = quota
      DataModel.RiseSuccessRateIndex = DataModel.RiseSuccessRateIndex + 1
      DataModel.AfterBargainFailSale = 0
    end
  else
    local afterBargainFailParam = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AfterBargainFail)
    if isBuy then
      DataModel.AfterBargainFailBuy = afterBargainFailParam
    else
      DataModel.AfterBargainFailSale = afterBargainFailParam
    end
    return
  end
  DataModel.RefreshPriceInfo(quota)
end

function DataModel.RefreshPriceInfo(quota)
  local isBuy = DataModel.CurTradeType == DataModel.TradeType.Buy
  local percent = 0
  if isBuy then
    percent = 1 - quota
  else
    percent = 1 + quota
  end
  for k, v in pairs(DataModel.IdToDetailInfo) do
    v.newPrice = MainDataModel.NumRound(v.price * percent)
  end
  if isBuy then
    DataModel.ReCalcTempBuy()
  else
    DataModel.ReCalcTempSale()
  end
end

function DataModel.GoodsPriceWave(goods_price)
  local temp = {}
  for k, v in pairs(DataModel.CurCityGoodsInfo.sell_price) do
    local t = {}
    t.num = v.num or 0
    t.extra = v.extra or 0
    t.sold = v.sold or 0
    temp[k] = t
  end
  DataModel.CurCityGoodsInfo.sell_price = goods_price.sell_price
  DataModel.CurCityGoodsInfo.buy_price = goods_price.buy_price
  for k, v in pairs(DataModel.CurCityGoodsInfo.sell_price) do
    local sellInfo = temp[k]
    if sellInfo ~= nil then
      v.num = sellInfo.num or 0
      v.extra = sellInfo.extra or 0
      v.sold = sellInfo.sold or 0
    else
      v.num = 0
      v.extra = 0
      v.sold = 0
    end
  end
  if DataModel.CurTradeType == DataModel.TradeType.Buy then
    for k, v in pairs(DataModel.CurSellList) do
      v.price = DataModel.CurCityGoodsInfo.sell_price[tostring(v.id)].price
      v.newPrice = MainDataModel.NumRound(v.price * (1 - DataModel.CurCityGoodsInfo.b_quota))
    end
    DataModel.SortSellList()
    DataModel.ReCalcTempBuy()
  else
    for k, v in pairs(DataModel.CurAcquisitionList) do
      for k1, v1 in pairs(DataModel.CurCityGoodsInfo.buy_price) do
        local listCA = PlayerData:GetFactoryData(k1, "ListFactory")
        if v.goodsId == tonumber(listCA.goodsId) then
          v.price = v1.price
          v.newPrice = MainDataModel.NumRound(v.price * (1 + DataModel.CurCityGoodsInfo.r_quota))
          break
        end
      end
    end
    DataModel.ReCalcTempSale()
  end
end

function DataModel.GetMaxBargainCount(isBuy)
  local curRepData = HomeCommon.GetCurLvRepData(DataModel.StationId)
  local bargainBuffNum = DataModel.GetBargainBuffParam(EnumDefine.HomeSkillEnum.AddBargainNum)
  if isBuy then
    return curRepData.bargainNum + DataModel.AddBargainCount + bargainBuffNum
  else
    return curRepData.riseNum + DataModel.AddRiseCount + bargainBuffNum
  end
end

function DataModel.GetTax()
  local tax = HomeCommon.GetCurLvRepData(DataModel.StationId).revenue
  tax = tax + DataModel.TaxCuts
  if tax <= 0 then
    return 0
  end
  return tax
end

function DataModel.RefreshTradeDataPercent()
  local Drop = {}
  for k, v in pairs(DataModel.CurCityGoodsInfo.sell_price) do
    local listCA = PlayerData:GetFactoryData(k, "ListFactory")
    local percent = v.price / listCA.price
    if percent <= 0.9 then
      local t = {}
      t.id = tonumber(k)
      t.goodsId = listCA.goodsId
      local goodsCA = PlayerData:GetFactoryData(listCA.goodsId, "HomeGoodsFactory")
      t.name = goodsCA.name
      t.price = v.price
      t.percent = percent
      table.insert(Drop, t)
    end
  end
  PlayerData.TempCache.NPCTalkData[EnumDefine.NPCTalkDataEnum.Drop] = Drop
  local Rise = {}
  for k, v in pairs(DataModel.CurCityGoodsInfo.buy_price) do
    local listCA = PlayerData:GetFactoryData(k, "ListFactory")
    local percent = v.price / listCA.price
    if 1.1 <= percent then
      local t = {}
      t.id = tonumber(k)
      t.goodsId = listCA.goodsId
      local goodsCA = PlayerData:GetFactoryData(listCA.goodsId, "HomeGoodsFactory")
      t.name = goodsCA.name
      t.price = v.price
      t.percent = percent
      table.insert(Rise, t)
    end
  end
  PlayerData.TempCache.NPCTalkData[EnumDefine.NPCTalkDataEnum.Rise] = Rise
end

function DataModel.GetBargainBuffParam(enum)
  if DataModel.BargainBuff == nil then
    return 0
  end
  if DataModel.BargainBuff.type == enum then
    return DataModel.BargainBuff.param
  end
  return 0
end

function DataModel.GetActivityGoodsTax()
  if DataModel.ActivityTaxCuts then
    local tax = 0
    if DataModel.CurTradeType == DataModel.TradeType.Buy then
      for goodsId, param in pairs(DataModel.ActivityTaxCuts) do
        for k, v in pairs(DataModel.TempGoodsList) do
          local info = DataModel.IdToDetailInfo[v.id]
          if info.goodsId == goodsId then
            tax = tax + v.num * info.newPrice * param
          end
        end
      end
    else
      for goodsId, param in pairs(DataModel.ActivityTaxCuts) do
        for k, v in pairs(DataModel.TempGoodsList) do
          local info = DataModel.IdToDetailInfo[v.id]
          if info.goodsId == goodsId then
            local profit = v.num * (info.newPrice - info.avgPrice)
            if 0 < profit then
              tax = tax + profit * param
            end
          end
        end
      end
    end
    return tax
  end
  return 0
end

return DataModel
