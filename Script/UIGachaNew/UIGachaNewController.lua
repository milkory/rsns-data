local DataModel = require("UIGachaNew/UIGachaNewDataModel")
local View = require("UIGachaNew/UIGachaNewView")
local Top
local Controller = {}
local CommonItem = require("Common/BtnItem")
local selectedTabX = 10

function Controller:Init()
  Top = {
    {
      id = 11400007,
      key = 11400007,
      view = View.Group_Currency.Group_Onepull
    },
    {
      id = 11400005,
      key = "bm_rock",
      view = View.Group_Currency.Group_Diamond
    }
  }
  selectedTabX = PlayerData:GetFactoryData(99900001).extractTabX or 10
end

function Controller:RefreshTop()
  for i, v in ipairs(Top) do
    if i == 1 then
      local id = DataModel.CardPool[DataModel.Index].data.id
      local itemId = PlayerData:GetFactoryData(id).costList[1].id
      local itemCA = PlayerData:GetFactoryData(itemId)
      local num = PlayerData:GetGoodsById(itemId).num
      v.view.Txt_Num:SetText(num)
      v.view.Img_Icon:SetSprite(itemCA.buyPath)
    else
      local num = PlayerData:GetSpecialCurrencyById(v.key)
      v.view.Txt_Num:SetText(num)
    end
  end
end

function Controller:GetIndex(id)
  DataModel:GetCardPool()
  for i, v in ipairs(DataModel.CardPool) do
    if id == v.data.id then
      return i
    end
  end
  return 1
end

function Controller:RefreshTab(index)
  local grid = View.ScrollGrid_Tab.grid
  grid[DataModel.Index].Btn_Tab.Img_Selected:SetActive(false)
  grid[DataModel.Index].Btn_Tab.Img_Unselected:SetActive(true)
  grid[DataModel.Index].Btn_Tab:SetAnchoredPositionX(0)
  DataModel.Index = index
  DataModel.BgIndex = nil
  grid[DataModel.Index].Btn_Tab.Img_Selected:SetActive(true)
  grid[DataModel.Index].Btn_Tab.Img_Unselected:SetActive(false)
  grid[DataModel.Index].Btn_Tab:SetAnchoredPositionX(selectedTabX)
  View.Img_BG:SetSprite(DataModel.CardPool[index].data.imageBg)
end

function Controller:OpenSelectRoleTip(index)
  local cardPool = DataModel.CardPool[DataModel.Index]
  local data = cardPool.data
  local cfg = PlayerData:GetFactoryData(data.id, "ExtractFactory")
  local params = {
    id = cfg.btnList[index].id
  }
  CommonTips.OpenUnitDetail(params)
end

function Controller:RefreshMain(index)
  local grid = View.NewPage_PoolList.grid.self
  DataModel:GetCardPool()
  local count = #DataModel.CardPool
  grid:SetDataCount(count)
  grid:RefreshAllElement()
  local tabGrid = View.ScrollGrid_Tab.grid.self
  tabGrid:SetDataCount(count)
  tabGrid:RefreshAllElement()
  if index > count then
    index = count
  end
  self:RefreshTab(index)
  self:RefreshTop()
end

function Controller:ShowBuyItem(type, data)
  local item = {}
  local isEnough, cost
  if type == EnumDefine.DrawCard.One then
    cost = data.costList
  else
    cost = data.costTenList
  end
  for i, v in ipairs(cost) do
    if PlayerData:GetGoodsById(v.id).num >= v.num and not isEnough then
      item[v.id] = v.num
      isEnough = true
    end
    if i == #cost and not isEnough then
      item[v.id] = v.num
    end
  end
  DataModel.CommodityId = data.commodityId
  DataModel.GachaType = type
  DataModel.DataIDPool = {
    id = tostring(data.id),
    item = item
  }
  DataModel.IsEnough = false
  if isEnough then
    DataModel.IsEnough = isEnough
    for i, v in pairs(item) do
      CommonItem:SetItem(View.Group_BuyItem.Group_Middle.Group_Item1, {
        id = i,
        num = PlayerData:GetGoodsById(i).num
      })
      CommonItem:SetItem(View.Group_BuyItem.Group_Middle.Group_Item2, {
        id = i,
        num = PlayerData:GetGoodsById(i).num - v
      })
      local commodity = PlayerData:GetFactoryData(i, "CommodityFactory")
      View.Group_BuyItem.Group_Middle.Txt_Des:SetText(string.format(GetText(80600520), v, commodity.name))
    end
    View.Group_BuyItem.Group_Middle.Txt_Have:SetActive(false)
  else
    for i, v in pairs(item) do
      local priceId = 11400005
      local needNum = v - PlayerData:GetGoodsById(i).num
      CommonItem:SetItem(View.Group_BuyItem.Group_Middle.Group_Item2, {id = i, num = needNum})
      local commodity = PlayerData:GetFactoryData(i, "CommodityFactory")
      local priceCfg = PlayerData:GetFactoryData(data.commodityId, "CommodityFactory")
      local price = priceCfg.moneyList[1].moneyNum * needNum
      DataModel.Price = price
      CommonItem:SetItem(View.Group_BuyItem.Group_Middle.Group_Item1, {
        id = priceId,
        num = DataModel.Price
      })
      DataModel.NeedNum = needNum
      DataModel.MoneyNum = PlayerData:GetGoodsById(priceId).num
      local item = PlayerData:GetFactoryData(priceId)
      View.Group_BuyItem.Group_Middle.Txt_Des:SetText(string.format(GetText(80600500), price, item.name, needNum, commodity.name))
    end
    View.Group_BuyItem.Group_Middle.Txt_Have:SetText(string.format(GetText(80600521), DataModel.MoneyNum))
    View.Group_BuyItem.Group_Middle.Txt_Have:SetActive(true)
  end
  View.Group_BuyItem.self:SetActive(true)
end

local TimeFree = function(timeTable)
  if timeTable.hour > 0 then
    return string.format(GetText(80600002), timeTable.hour, timeTable.minute)
  end
  if 0 < timeTable.minute then
    return string.format(GetText(80600003), timeTable.minute)
  end
  if 0 < timeTable.second then
    return string.format(GetText(80600004), timeTable.second)
  end
  return "0"
end

function Controller:SetBasicPage(element, elementIndex)
  local cardPool = DataModel.CardPool[elementIndex]
  local data = cardPool.data
  element.Group_Card.Group_Front.Group_Basic.Group_TenPulls.BtnPolygon_TenPulls.self:SetClickParam(elementIndex)
  element.Group_Card.Group_Front.Group_Basic.Group_OnePull.BtnPolygon_OnePull.self:SetClickParam(elementIndex)
  local Ten_Img_Cost = element.Group_Card.Group_Front.Group_Basic.Group_TenPulls.Img_Cost
  local len = #data.costTenList
  for i, v in ipairs(data.costTenList) do
    if PlayerData:GetGoodsById(v.id).num > 0 or i == len then
      local item = PlayerData:GetFactoryData(v.id, "ItemFactory")
      Ten_Img_Cost.Img_Icon:SetSprite(item.buyPath)
      Ten_Img_Cost.Txt_Item:SetText("\195\151" .. v.num)
      break
    end
  end
  local Group_OnePull = element.Group_Card.Group_Front.Group_Basic.Group_OnePull
  if data.freeCD ~= 0 then
    if cardPool.server and (not cardPool.server.free_last_countdown or TimeUtil:GetServerTimeStamp() >= tonumber(cardPool.server.free_last_countdown)) then
      Group_OnePull.Img_Cost.self:SetActive(false)
      Group_OnePull.Img_Free.self:SetActive(true)
      if cardPool.detail.timeFunc1 ~= nil then
        EventManager:RemoveOnSecondEvent(cardPool.detail.timeFunc1)
        cardPool.detail.timeFunc1 = nil
      end
    else
      Group_OnePull.Img_Cost.self:SetActive(true)
      Group_OnePull.Img_Free.self:SetActive(false)
      if tonumber(cardPool.server.free_last_countdown) > TimeUtil:GetServerTimeStamp() then
        local testFunc = function()
          if tonumber(cardPool.server.free_last_countdown) <= TimeUtil:GetServerTimeStamp() then
            Group_OnePull.Img_Cost.self:SetActive(false)
            Group_OnePull.Img_Free.self:SetActive(true)
            if cardPool.detail.timeFunc1 ~= nil then
              EventManager:RemoveOnSecondEvent(cardPool.detail.timeFunc1)
              cardPool.detail.timeFunc1 = nil
            end
            return
          end
          local time = TimeUtil:SecondToTable(tonumber(cardPool.server.free_last_countdown) - TimeUtil:GetServerTimeStamp())
          Group_OnePull.Img_Cost.Txt_Free:SetText(TimeFree(time))
        end
        if cardPool.detail.timeFunc1 == nil then
          cardPool.detail.timeFunc1 = testFunc
          EventManager:AddOnSecondEvent(cardPool.detail.timeFunc1)
        end
        Group_OnePull.Img_Cost.Txt_Free:SetActive(true)
      end
      local len = #data.costList
      for i, v in ipairs(data.costList) do
        if PlayerData:GetGoodsById(v.id).num > 0 or i == len then
          local item = PlayerData:GetFactoryData(v.id, "ItemFactory")
          Group_OnePull.Img_Cost.Img_Icon:SetSprite(item.buyPath)
          Group_OnePull.Img_Cost.Txt_Item:SetText("\195\151" .. v.num)
          break
        end
      end
    end
  else
    Group_OnePull.Img_Cost.self:SetActive(true)
    Group_OnePull.Img_Free.self:SetActive(false)
    local len = #data.costList
    for i, v in ipairs(data.costList) do
      if PlayerData:GetGoodsById(v.id).num > v.num or i == len then
        local item = PlayerData:GetFactoryData(v.id, "ItemFactory")
        Group_OnePull.Img_Cost.Img_Icon:SetSprite(item.buyPath)
        Group_OnePull.Img_Cost.Txt_Item:SetText("\195\151" .. v.num)
        break
      end
    end
  end
  if data.endTime ~= "" then
    local startTime = TimeUtil:GetTimeTable(data.startTime)
    local endTime = TimeUtil:GetTimeTable(data.endTime)
    local str = string.format(GetText(80600005), startTime.year, startTime.month, startTime.day, startTime.hour .. ":" .. startTime.minute, endTime.year, endTime.month, endTime.day, endTime.hour .. ":" .. endTime.minute)
    element.Group_Card.Group_Front.Group_Basic.Group_TimeLimit.Txt_CutOffTime:SetText(str)
  end
  element.Group_Card.Group_Front.Group_Basic.Group_TimeLimit.self:SetActive(data.endTime ~= "")
  element.Group_Card.Group_Front.Group_Basic.Group_Normal.self:SetActive(data.endTime == "")
  if cardPool.detail.timeFunc == nil and data.endTime ~= "" then
    local testFunc1 = function(isFirst)
      local lastTime = TimeUtil:LastTime(data.endTime)
      local time = TimeUtil:SecondToTable(lastTime)
      if DataModel.Index == elementIndex or isFirst then
        element.Group_Card.Group_Front.Group_Basic.Group_TimeLimit.Txt_RemainingTime:SetText(TimeUtil:GetGachaDesc(time))
      end
      if lastTime == 0 and cardPool.detail.timeFunc ~= nil then
        EventManager:RemoveOnSecondEvent(cardPool.detail.timeFunc)
        cardPool.detail.timeFunc = nil
        if DataModel.Index == elementIndex then
          Controller:RefreshMain(1)
          View.NewPage_PoolList.grid.self:LocatElementImmediate(1)
          Controller:PlayAnimeByIndex(1)
        else
          Controller:RefreshMain(Controller:GetIndex(data.id))
          View.NewPage_PoolList.grid.self:LocatElementImmediate(Controller:GetIndex(data.id))
          Controller:PlayAnimeByIndex(Controller:GetIndex(data.id))
        end
      end
    end
    testFunc1(true)
    cardPool.detail.timeFunc = testFunc1
    EventManager:AddOnSecondEvent(cardPool.detail.timeFunc)
  end
  element.Group_Card.Group_Front.Group_Basic.Txt_Name:SetText(data.name)
end

function Controller:SetNewbiePage(element, elementIndex)
  local cardPool = DataModel.CardPool[elementIndex]
  local data = cardPool.data
  local groupNewbie = element.Group_Card.Group_Front.Group_Newbie
  local imgCost = groupNewbie.Img_Cost
  for i, v in ipairs(data.costTenList) do
    if PlayerData:GetGoodsById(v.id).num > 0 or i == #data.costTenList then
      local item = PlayerData:GetFactoryData(v.id, "ItemFactory")
      imgCost.Img_Icon:SetSprite(item.buyPath)
      imgCost.Txt_Item:SetText("\195\151" .. v.num)
      break
    end
  end
  local poolData = PlayerData.ServerData.cards[tostring(data.id)]
  local poolNum = 0
  if poolData ~= nil then
    poolNum = poolData.pool_num or 0
  end
  if data.closeNum == nil then
    error("卡池id: " .. data.id .. " 配置缺少字段'closeNum'")
  end
  groupNewbie.Group_Num.Txt_Num:SetText(string.format(GetText(80602001), data.closeNum - poolNum, data.closeNum))
  groupNewbie.Btn_TenPulls.self:SetClickParam(elementIndex)
end

function Controller:OpenTryLevel(levelId)
  local status = {
    Current = "College",
    squadIndex = PlayerData.BattleInfo.squadIndex,
    hasOpenThreeView = false
  }
  PlayerData.BattleInfo.battleStageId = levelId
  PlayerData.BattleCallBackPage = "UI/Gacha/GachaNew"
  PlayerData.Last_Gacha_Index = DataModel.Index
  UIManager:Open("UI/Squads/Squads", Json.encode(status))
end

function Controller:PlayAnimeByIndex(index)
  local listX = View.NewPage_PoolList.self.pageNewController.ScrollRect.content.anchoredPosition.x
  for i = 1, #View.NewPage_PoolList.grid do
    local grid = View.NewPage_PoolList.grid[i]
    if grid.transform.anchoredPosition.x == -listX then
      grid.self:SelectPlayAnim("")
      grid.self:SelectPlayAnim(DataModel.CardPool[index].data.animName)
    end
  end
end

return Controller
