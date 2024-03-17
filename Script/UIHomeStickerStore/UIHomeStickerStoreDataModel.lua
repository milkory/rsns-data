local DataModel = {}

function DataModel:Init()
  local shopId = PlayerData:GetFactoryData(99900014, "ConfigFactory").HBPStoreList[1].id
  DataModel.ShopId = shopId
  local shopItemList = PlayerData:GetFactoryData(shopId, "StoreFactory").shopList
  DataModel.ItemList = shopItemList
end

return DataModel
