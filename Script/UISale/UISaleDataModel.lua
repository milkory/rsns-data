local DataModel = {
  Data = {},
  SelectTop = EnumDefine.Depot.Item
}

function DataModel.SetData(Type, data, factory)
  for k, v in pairs(data) do
    local id = tonumber(k)
    local data = factory[id]
    if data.saletypeInt == 1 then
      if v.num > 0 then
        table.insert(DataModel.Data[Type], {
          server = v,
          id = id,
          data = data,
          isDue = false
        })
      end
    elseif data.saletypeInt == 2 and v.dead_line ~= "" and v.num > 0 then
      local currentTime = TimeUtil:GetServerTimeStamp()
      local deadTime = TimeUtil:TimeStamp(v.dead_line)
      if currentTime > deadTime then
        table.insert(DataModel.Data[Type], {
          server = v,
          id = id,
          data = data,
          isDue = true
        })
      end
    end
  end
  table.sort(DataModel.Data[Type], function(a, b)
    if a.data.qualityInt ~= b.data.qualityInt then
      return a.data.qualityInt < b.data.qualityInt
    end
    return a.data.sort < b.data.sort
  end)
end

return DataModel
