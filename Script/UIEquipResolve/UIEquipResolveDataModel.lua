local DataModel = {
  ScreenIndex = 1,
  NewForgeIndex = 1,
  OldForgeIndex = 1,
  Equip = nil
}

function DataModel:GetForgeType(isRefresh)
  if isRefresh == nil then
    isRefresh = false
  end
  if isRefresh then
    self.ForgeType = {}
    for i, v in ipairs(PlayerData:GetFactoryData(99900017, "ConfigFactory").enumEquipTypeList) do
      local data = PlayerData:GetFactoryData(v.equipType, "TagFactory")
      self.ForgeType[i] = self.ForgeType[i] or {
        name = data.tagName,
        detail = {},
        id = v.equipType
      }
    end
    for i, v in pairs(PlayerData.ServerData.equipments.equips) do
      local data = PlayerData:GetFactoryData(v.id, "EquipmentFactory")
      local tag = PlayerData:GetFactoryData(data.equipTagId, "TagFactory")
      table.insert(self.ForgeType[tag.tagID + 1].detail, {
        data = data,
        eid = v.eid
      })
    end
    for i = 1, #self.ForgeType do
      table.sort(self.ForgeType[i], function(a, b)
        return a.id < b.id
      end)
    end
  end
  return self.ForgeType
end

return DataModel
