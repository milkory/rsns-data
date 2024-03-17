local DataModel = {
  Params = {},
  CurShowList = {}
}

function DataModel.Init()
  DataModel.CurShowList = {}
  local tradeConfig = PlayerData:GetFactoryData(99900062, "ConfigFactory")
  if DataModel.Params.type == 1 then
    DataModel.CurShowList = tradeConfig.buyItemList
  elseif DataModel.Params.type == 2 then
    DataModel.CurShowList = tradeConfig.sellItemList
  end
end

return DataModel
