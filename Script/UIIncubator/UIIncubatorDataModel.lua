local DataModel = {
  Type = {},
  Select = {},
  Index = 0,
  TotalUse = 0,
  SelectData = {},
  SendStr = ""
}

function DataModel:Reset()
  DataModel.Type = {}
  DataModel.SelectData = {}
  DataModel.Select = {}
  DataModel.Index = 0
  DataModel.SendStr = ""
  DataModel.TotalUse = 0
end

function DataModel:GetType()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local serverData = PlayerData.ServerData.user_home_info.creatures
  for i, v in ipairs(homeConfig.typeList) do
    table.insert(DataModel.Type, {
      time = v.purifyTime,
      data = {}
    })
    for id, data in pairs(serverData) do
      local config = PlayerData:GetFactoryData(id, "HomeCreatureFactory")
      if config.mod == "生物" and config.purifyTime / 3600 == v.purifyTime then
        table.insert(DataModel.Type[i].data, {
          serverData = data,
          config = config,
          use = 0
        })
      end
    end
  end
end

return DataModel
