local DataModel = {}
DataModel.isSetPainting = false
DataModel.SortType = {
  pluckList = {},
  isIncr = false
}
DataModel.Roles = {}
DataModel.RefreshBreakIndex = 0
DataModel.selectRoleId = ""

function DataModel.InitData(roleId)
  DataModel.selectRoleId = roleId
  DataModel.SetRoleData()
end

function DataModel.SetRoleData()
  DataModel.Roles = {}
  for k in pairs(PlayerData.ServerData.roles) do
    table.insert(DataModel.Roles, k)
  end
end

return DataModel
