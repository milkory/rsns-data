local DataModel = {Type = 0, Index = 1}

function DataModel:GetEquipmentType(isRefresh)
  if isRefresh == nil then
    isRefresh = false
  end
  if isRefresh then
    self.Equipments = {}
    local selfequips = {}
    local count = 0
    local lastType
    local isAllSameType = false
    for i, v in pairs(PlayerData.ServerData.roles) do
      if v.equips then
        for a, b in ipairs(v.equips) do
          if b ~= "" then
            selfequips[tostring(b)] = v.id
            count = count + 1
          end
        end
      end
    end
    local equipmentSlotList = PlayerData:GetFactoryData(tonumber(DataModel.RoleId)).equipmentSlotList
    for k, v in pairs(equipmentSlotList) do
      local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", v.tagID)
      if lastType == nil then
        lastType = typeInt
      elseif typeInt == lastType or typeInt == 0 then
        if lastType == 0 then
          lastType = 0
        end
        isAllSameType = true
      end
    end
    for i, v in pairs(PlayerData.ServerData.equipments.equips) do
      local data = PlayerData:GetFactoryData(v.id, "EquipmentFactory")
      local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", data.equipTagId)
      local isCross = false
      local isWeight = false
      if v.weight > data.overweight then
        isWeight = true
      end
      if isWeight == true and isAllSameType == true and (typeInt == lastType or lastType == 0) then
        isCross = true
      end
      local type
      if self.Type == 0 then
        type = true
      else
        type = typeInt == self.Type
      end
      data.skills = v.skills
      local index = typeInt
      if isWeight == false and DataModel.Type == typeInt then
        isCross = true
      end
      local owner = selfequips[i] or nil
      local allequips = index == 2 and v.id or nil
      table.insert(self.Equipments, {
        data = data,
        eid = v.ueid,
        owner = owner,
        allequips = allequips,
        type = type,
        index = index,
        iscross = isCross,
        isweight = isWeight
      })
    end
    table.sort(self.Equipments, function(a, b)
      return a.index < b.index
    end)
  end
  return self.Equipments
end

return DataModel
