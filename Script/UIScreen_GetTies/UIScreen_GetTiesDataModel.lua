local DataModel = {}

function DataModel.Init(data)
  DataModel.NewBuffList = {}
  for k, v in pairs(data) do
    local petInfo = PlayerData:GetHomeInfo().pet[k]
    local petCfg = PlayerData:GetFactoryData(petInfo.id)
    local buffCount = #petInfo.buff_list
    local startIdx = buffCount - v + 1
    if 0 < startIdx then
      for i = startIdx, buffCount do
        local data = {}
        local name = petInfo.name ~= "" and petInfo.name or petCfg.petName
        data.petName = name
        local roleName = PlayerData:GetFactoryData(petInfo.role_id).name
        data.roleName = roleName or ""
        local tiesName = PlayerData:GetFactoryData(petInfo.buff_list[i]).tiesName
        data.tiesName = tiesName or ""
        table.insert(DataModel.NewBuffList, data)
      end
    end
  end
end

return DataModel
