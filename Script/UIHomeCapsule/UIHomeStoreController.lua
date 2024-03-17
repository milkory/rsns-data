local View = require("UIHomeCapsule/UIHomeCapsuleView")
local DataModel = require("UIHomeCapsule/UIHomeStoreDataModel")
local Controller = {}

function Controller:ChooseTab(index)
  DataModel.curIndex = index
  DataModel.Now_List = DataModel.List[index]
  DataModel.ShopId = DataModel.Now_List.shopid
  View.Group_HomeStore.Group_FurnitureStore.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.Now_List.shopFactory.shopList))
  View.Group_HomeStore.Group_FurnitureStore.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_HomeStore.Group_Right.StaticGrid_BQ.grid.self:RefreshAllElement()
end

function Controller:RefreshGrid()
  local row = DataModel.List[DataModel.curIndex]
  DataModel.itemList = {}
  local cnt = 0
  for i, v in pairs(row.shopFactory.shopList) do
    cnt = cnt + 1
    local row = {}
    local itemData = PlayerData:GetFactoryData(v.id)
    row.image = itemData.commodityView
    row.name = itemData.commodityName
    row.purchase = itemData.purchase
    row.purchaseNum = itemData.purchaseNum
    row.shopid = v.id
    row.commoditData = itemData
    DataModel.itemList[cnt] = row
  end
  View.Group_FurnitureStore.ScrollGrid_List.grid.self:SetDataCount(cnt)
  View.Group_FurnitureStore.ScrollGrid_List.grid.self:RefreshAllElement()
end

function Controller.InitStore()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  DataModel.List = {}
  local count = 1
  for c, d in pairs(homeConfig.storeList) do
    local storeFactory = PlayerData:GetFactoryData(d.id)
    local severStoreValue = PlayerData.ServerData.shops[tostring(d.id)]
    DataModel.List[count] = {}
    if severStoreValue then
      DataModel.List[count].server = severStoreValue
    end
    DataModel.List[count].shopFactory = storeFactory
    DataModel.List[count].shopid = d.id
    DataModel.List[count].name = storeFactory.name
    count = count + 1
  end
  print_r(DataModel.List)
end

return Controller
