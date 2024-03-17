local DataModel = {
  envIDs = 70400001,
  layerSpeed = {
    6,
    60,
    100,
    1200,
    1500,
    2000,
    3000
  },
  startHeight = 0,
  roomID = {},
  roomSkinIds = {},
  roomData = {
    [1] = "{\"81300001\":[{\"x\":0, \"y\":0}],\"81300004\":[{\"x\":0, \"y\":0}],\"81300002\":[{\"x\":0, \"y\":0}],\"81300008\":[{\"x\":10, \"y\":10}],\"81300011\":[{\"x\":25, \"y\":0}],\"81300006\":[{\"x\":28, \"y\":3}],}",
    [2] = "{\"81300001\":[{\"x\":0, \"y\":0}],\"81300004\":[{\"x\":0, \"y\":0}],\"81300002\":[{\"x\":0, \"y\":0}],\"81300008\":[{\"x\":10, \"y\":10}],\"81300011\":[{\"x\":25, \"y\":0}],}",
    [3] = "{\"81300001\":[{\"x\":0, \"y\":0}],\"81300004\":[{\"x\":0, \"y\":0}],\"81300002\":[{\"x\":0, \"y\":0}],\"81300008\":[{\"x\":10, \"y\":10}],\"81300011\":[{\"x\":25, \"y\":0}],}"
  },
  roomFurnitureData = {},
  coach = {
    [1] = {
      id = 81200024,
      degree = 10,
      location = {
        [1] = {
          id = 81300020,
          y = 1,
          x = 1
        }
      }
    },
    [2] = {
      id = 81200002,
      degree = 40,
      delicious = 0,
      location = {
        [1] = {
          id = 81300002,
          y = 1,
          x = 1
        },
        [2] = {
          id = 81300001,
          y = 1,
          x = 1
        },
        [3] = {
          id = 81300004,
          y = 0,
          x = 0
        }
      }
    }
  },
  buildList = {},
  screenshot = {x = 800, y = 653},
  camOffsetX = 0,
  camOffsetY = -1.25,
  infoSta = false,
  initReturnAni = nil,
  firstIn = true,
  coachWornCost = 0,
  coachWornToCityName = "",
  tempHockReward = {},
  camTimeEffect = {},
  curTimeEffect = "",
  todayZeroTimeStamp = 0,
  oneDayTimeStamp = 86400,
  cameraTween = false,
  isOpenView = false,
  roleId = "",
  isAnimation2 = false
}

function DataModel.AddFurniture(idx, data)
  table.insert(DataModel.roomFurnitureData[idx], data)
end

function DataModel.RemoveFurniture(idx, id)
  local furAry = DataModel.roomFurnitureData[idx]
  local pos = -1
  for i, v in pairs(furAry) do
    if tonumber(v.ufid) == tonumber(id) then
      pos = i
      break
    end
  end
  if pos ~= -1 then
    table.remove(DataModel.roomFurnitureData[idx], pos)
  end
end

function DataModel.RefreshData(data)
  DataModel.roomID = {}
  DataModel.roomSkinIds = {}
  DataModel.roomData = {}
  DataModel.roomFurnitureData = {}
  for i, v in pairs(data) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    local tagCA = PlayerData:GetFactoryData(coachCA.coachType)
    if not tagCA.stopCarriage then
      table.insert(DataModel.roomID, v.id)
      local json = "{"
      local furniture = {}
      for i2, v2 in pairs(v.location) do
        local fur = {}
        fur.id = PlayerData.ServerData.user_home_info.furniture[v2.id].id
        fur.ufid = v2.id
        fur.x = v2.x
        fur.y = v2.y
        fur.z = v2.z or 0
        json = json .. "\"" .. i2 .. "\":[{ \"id\":" .. fur.id .. ", \"ufid\":" .. v2.id .. ", \"x\":" .. v2.x .. ",\"y\":" .. v2.y .. ",\"z\":" .. fur.z .. "}],"
        table.insert(furniture, {
          ufid = v2.id,
          id = fur.id
        })
      end
      json = json .. "}"
      table.insert(DataModel.roomData, json)
      table.insert(DataModel.roomFurnitureData, furniture)
    end
    local skinId = tonumber(v.skin)
    if skinId == nil then
      skinId = coachCA.defaultSkin
    end
    table.insert(DataModel.roomSkinIds, skinId)
  end
end

function DataModel.RefreshFurnitureData()
end

function DataModel.RefreshBuildList()
  local ary = PlayerData:GetFactoryData(99900014, "ConfigFactory").buildList
  local study = PlayerData.ServerData.user_home_info.studied_coach or {}
  local containsStudy = {}
  DataModel.buildList = {}
  for i, v in pairs(study) do
    containsStudy[tonumber(i)] = true
  end
  for i, v in pairs(ary) do
    local t = {}
    local data = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    t.data = data
    if table.count(data.studyMaterialList) > 0 then
      local sta = containsStudy[v.id] or false
      if sta == false then
        t.canBuild = false
      else
        t.canBuild = true
      end
    else
      t.canBuild = true
    end
    table.insert(DataModel.buildList, t)
    t.index = #DataModel.buildList
  end
  local curHomeLev = PlayerData.ServerData.user_home_info.home_lv
  table.sort(DataModel.buildList, function(a, b)
    if a.canBuild and not b.canBuild then
      return true
    elseif not a.canBuild and b.canBuild then
      return false
    end
    if not a.canBuild and not b.canBuild then
      if a.data.studyNeedLevel <= curHomeLev and b.data.studyNeedLevel > curHomeLev then
        return true
      elseif a.data.studyNeedLevel > curHomeLev and b.data.studyNeedLevel <= curHomeLev then
        return false
      end
    end
    if a.data.studyNeedLevel < b.data.studyNeedLevel then
      return true
    else
      return a.index < b.index
    end
  end)
end

function DataModel.GetTrainProperty()
  local data = {}
  data.none = 0
  data.comfort = 0
  local coachDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
  for i, v in pairs(DataModel.roomID) do
  end
  return data
end

return DataModel
