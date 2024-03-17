local data = {
  RoleId = -1,
  EquipUids = {},
  Init = function(self, RoleData)
    self.RoleId = RoleData.id
    self.EquipUids = RoleData.equipUids
  end,
  Destory = function(self)
    self.RoleId = -1
    self.EquipUids = {}
  end
}
return data
