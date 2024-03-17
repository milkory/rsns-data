local DataModel = {
  Plants = {}
}
DataModel.SortType = {Num = 1, Mood = 2}
DataModel.CurrSort = {
  Type = DataModel.SortType.Num,
  IsDown = true
}

function DataModel:SortRule()
  if DataModel.CurrSort.Type == DataModel.SortType.Num then
    if DataModel.CurrSort.IsDown then
      table.sort(DataModel.Plants, function(a, b)
        if a.serverData.num > b.serverData.num then
          return true
        end
        return false
      end)
    else
      table.sort(DataModel.Plants, function(a, b)
        if a.serverData.num < b.serverData.num then
          return true
        end
        return false
      end)
    end
  elseif DataModel.CurrSort.Type == DataModel.SortType.Mood then
    if DataModel.CurrSort.IsDown then
      table.sort(DataModel.Plants, function(a, b)
        if a.config.PlantMood > b.config.PlantMood then
          return true
        end
        return false
      end)
    else
      table.sort(DataModel.Plants, function(a, b)
        if a.config.PlantMood < b.config.PlantMood then
          return true
        end
        return false
      end)
    end
  end
end

function DataModel:InitData()
  local serverData = PlayerData.ServerData.user_home_info.creatures
  DataModel.Plants = {}
  for id, data in pairs(serverData) do
    local config = PlayerData:GetFactoryData(id, "HomeCreatureFactory")
    if config.mod == "植物" and serverData.num ~= 0 then
      table.insert(DataModel.Plants, {
        serverData = data,
        config = config,
        use = 0
      })
    end
  end
end

return DataModel
