local DataModel = require("CommonFilter/FilterData")
local Controller = {}
local getString = function(state)
  local str = "lv"
  if state == EnumDefine.SortType.rarity then
    str = "qualityInt"
  elseif state == EnumDefine.SortType.time then
    str = "obtain_time"
  end
  return str
end
local sort = function(data)
  local temp = {}
  local index = 2
  for k, v in pairs(DataModel.SortData) do
    if v.type ~= EnumDefine.SortType.filter then
      local tab = {}
      tab.state = v.type
      tab.isUp = v.state == DataModel.EnumSort.down_on or v.state == DataModel.EnumSort.down_off
      if v.isActive then
        temp[1] = tab
      else
        temp[index] = tab
        index = index + 1
      end
    end
  end
  table.sort(data, function(a, b)
    local isUp = temp[1].isUp
    local str = getString(temp[1].state)
    if a[str] ~= b[str] then
      if isUp then
        return a[str] > b[str]
      else
        return a[str] < b[str]
      end
    end
    isUp = temp[2].isUp
    str = getString(temp[2].state)
    if a[str] ~= b[str] then
      if isUp then
        return a[str] > b[str]
      else
        return a[str] < b[str]
      end
    end
    isUp = temp[3].isUp
    str = getString(temp[3].state)
    if a[str] ~= b[str] then
      if isUp then
        return a[str] > b[str]
      else
        return a[str] < b[str]
      end
    end
    return a.id > b.id
  end)
  return data
end

function Controller:GetRoleList()
  local temp = {}
  local data = sort(DataModel.tempData)
  for k, v in pairs(data) do
    temp[k] = v.id
  end
  return temp
end

function Controller:SquadSort()
  DataModel.temp_Filter_Sort_Data = sort(DataModel.temp_Filter_Sort_Data)
  DataModel.callback(DataModel.temp_Filter_Sort_Data)
end

function Controller:SquadFilter()
  DataModel.temp_Filter_Sort_Data = {}
  local temp = {}
  for k, v in pairs(DataModel.FilterData) do
    local tab = {}
    for k1, v1 in pairs(v.filters) do
      if k1 == 1 and v1.state then
        tab[-1] = 0
        break
      elseif v1.state then
        tab[k1 - 2] = 0
      end
    end
    temp[k] = tab
  end
  local index = 1
  for k, v in pairs(DataModel.tempData) do
    local ca = PlayerData:GetFactoryData(v.id)
    local line = temp[1]
    if line[-1] ~= nil or line[ca.line - 1] ~= nil then
      local camp = temp[2]
      if camp[-1] ~= nil or camp[PlayerData:SearchRoleCampInt(ca.sideId) - 1] ~= nil then
        local quality = temp[3]
        if quality[-1] ~= nil or quality[ca.qualityInt - 1] ~= nil then
          DataModel.temp_Filter_Sort_Data[index] = v
          index = index + 1
        end
      end
    end
  end
end

return Controller
