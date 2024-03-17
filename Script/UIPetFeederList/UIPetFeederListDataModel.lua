local DataModel = {}
local Init = function(data)
  DataModel.roleList = {}
  DataModel.u_pet = data.u_pet
  for k, v in pairs(PlayerData:GetRoles()) do
    if v.u_pet == "" or v.u_pet == DataModel.u_pet or not v.u_pet then
      local data = {
        roleId = k,
        u_pet = v.u_pet
      }
      table.insert(DataModel.roleList, data)
      data.u_pet = not (data.u_pet ~= "" and data.u_pet) and 0 or data.u_pet
    end
  end
  DataModel.lvFirst = {
    "lv",
    "qualityInt",
    "obtain_time"
  }
  DataModel.qualityFirst = {
    "qualityInt",
    "lv",
    "obtain_time"
  }
  DataModel.timeFirst = {
    "obtain_time",
    "lv",
    "qualityInt"
  }
  DataModel.lvUp = true
  DataModel.qualityUp = true
  DataModel.timeUp = true
  DataModel.SelectSortData(0)
  DataModel.SortData(DataModel.lvFirst)
  DataModel.selectTogId = 1
end
local SeletctParam = function(value)
  if value == "lv" then
    return DataModel.lvUp
  elseif value == "qualityInt" then
    return DataModel.qualityUp
  elseif value == "obtain_time" then
    return DataModel.timeUp
  end
  print("参数不存在！！！！！！！！！！！！")
  return false
end
local SortData = function(conditionList)
  table.sort(DataModel.sortData, function(t1, t2)
    if t1.u_pet ~= t2.u_pet then
      return tonumber(t1.u_pet) > tonumber(t2.u_pet)
    end
    for i, v in ipairs(conditionList) do
      local param = SeletctParam(v) and 1 or -1
      local data1 = PlayerData:GetRoleById(t1.roleId)
      local data2 = PlayerData:GetRoleById(t2.roleId)
      if v == "qualityInt" then
        local quality1 = PlayerData:GetFactoryData(t1.roleId).qualityInt
        local quality2 = PlayerData:GetFactoryData(t2.roleId).qualityInt
        if quality1 ~= quality2 then
          return param * quality1 > param * quality2
        end
      end
      if data1[v] ~= data2[v] then
        return param * data1[v] > param * data2[v]
      end
    end
    return t1.roleId > t2.roleId
  end)
  print_r(DataModel.sortData)
end
local SelectSortData = function(dataType)
  DataModel.sortData = {}
  if dataType == 0 then
    DataModel.sortData = DataModel.roleList
  else
    for k, v in pairs(DataModel.roleList) do
    end
  end
end
DataModel.Init = Init
DataModel.SortData = SortData
DataModel.SelectSortData = SelectSortData
return DataModel
