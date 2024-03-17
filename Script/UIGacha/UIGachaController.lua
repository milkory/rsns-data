local DataModel = require("UIGacha/UIGachaDataModel")
local View = require("UIGacha/UIGachaView")
local Top
local Controller = {}
local CommonItem = require("Common/BtnItem")

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
end

function Controller:RefreshTop()
  for i, v in ipairs(Top) do
    local num = PlayerData:GetSpecialCurrencyById(v.key)
    v.view.Img_Icon:SetSprite(PlayerData:GetFactoryData(v.id).iconPath)
    v.view.Txt_Num:SetText(num)
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
  local grid = View.Group_Tab.StaticGrid_Tab.grid
  grid[DataModel.Index].Img_other:SetActive(true)
  grid[DataModel.Index].Img_now:SetActive(false)
  DataModel.Index = index
  grid[DataModel.Index].Img_other:SetActive(false)
  grid[DataModel.Index].Img_now:SetActive(true)
  View.Btn_Next:SetActive(DataModel.Index ~= #DataModel.CardPool)
  View.Btn_Previous:SetActive(DataModel.Index ~= 1)
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
  local grid = View.Page_PoolList.grid.self
  DataModel:GetCardPool()
  local count = #DataModel.CardPool
  grid:SetDataCount(count)
  grid:RefreshAllElement()
  local otherGrid = View.Group_Tab.StaticGrid_Tab.grid.self
  otherGrid:SetDataCount(count)
  otherGrid:RefreshAllElement()
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

return Controller
