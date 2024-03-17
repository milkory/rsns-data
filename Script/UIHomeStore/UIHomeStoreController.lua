local View = require("UIHomeStore/UIHomeStoreView")
local DataModel = require("UIHomeStore/UIHomeStoreDataModel")
local Controller = {}

function Controller:ChooseTab(index)
  DataModel.curIndex = index
  DataModel.Now_List = DataModel.List[index]
  if DataModel.lastElement ~= nil then
    DataModel.lastElement.Btn_FurnitureStore.Img_pitchon:SetActive(false)
  end
  DataModel.ShopId = DataModel.Now_List.shopid
  DataModel.lastElement = View.ScrollGrid_StoreList.grid[index]
  DataModel.lastElement.Btn_FurnitureStore.Img_pitchon:SetActive(true)
  View.Group_FurnitureStore.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.Now_List.shopFactory.shopList))
  View.Group_FurnitureStore.ScrollGrid_List.grid.self:RefreshAllElement()
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

function Controller.InitButtomGrid()
  View.ScrollGrid_StoreList.grid.self:SetDataCount(table.count(DataModel.List))
  View.ScrollGrid_StoreList.grid.self:RefreshAllElement()
end

function Controller.InitStore()
  local bottom_list = PlayerData.GetInitStoreConfig()
  DataModel.List = {}
  local count = 1
  for c, d in pairs(bottom_list) do
    if d.id >= 40300009 then
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
  end
  print_r(DataModel.List)
  View.Group_TopRight.Btn_FurnitureCoin.Txt_FurnitureCoin:SetText(PlayerData:GetUserInfo().furniture_coins)
end

return Controller
