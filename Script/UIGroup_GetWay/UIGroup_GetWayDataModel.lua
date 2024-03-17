local DataModel = {}

function DataModel:init(params)
  local data = Json.decode(params)
  local ItemID = data.itemID
  self.getwayList = PlayerData:GetFactoryData(ItemID).Getway
  self.posX = data.posX
  self.posY = data.posY
  self.goback_num = data.goback_num
end

return DataModel
