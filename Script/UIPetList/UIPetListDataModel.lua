local DataModel = {}
local InitData = function(data)
  DataModel.ufid = data.ufid
  DataModel.selectType = data.selectType
  local petList = PlayerData:GetHomeInfo().pet ~= "" and PlayerData:GetHomeInfo().pet or {}
  DataModel.petList = {}
  local furniture = PlayerData.ServerData.user_home_info.furniture[data.ufid]
  local furPets = furniture.house.pets or {}
  local furCfgId = furniture.id
  DataModel.maxPetNum = PlayerData:GetFactoryData(furCfgId).PetNum
  DataModel.furPets = Clone(furPets)
  DataModel.furPets.count = 0
  for i = 1, DataModel.maxPetNum do
    if DataModel.furPets[i] ~= "" then
      DataModel.furPets[DataModel.furPets[i]] = i
      DataModel.furPets.count = DataModel.furPets.count + 1
    end
  end
  for k, v in pairs(petList) do
    table.insert(DataModel.petList, v)
    v.furPetIndex = DataModel.furPets[k] or 999
    v.pet_uid = k
  end
  DataModel.selectIndex = 1
  DataModel.petKindsList = PlayerData:GetFactoryData(99900022).petVarityList or {}
  DataModel.petKindsCount = #DataModel.petKindsList
  DataModel.selectKindList = {count = 0}
  DataModel.now_kinds = nil
  DataModel.favorUp = true
  DataModel.timeUp = true
  DataModel.favorFirst = {
    "favor",
    "obtain_time"
  }
  DataModel.timeFirst = {
    "obtain_time",
    "favor"
  }
  DataModel.SelectSortData(0)
  DataModel.SortData(DataModel.favorFirst)
  DataModel.lvFavorMax = nil
end
local SeletctParam = function(value)
  if value == "favor" then
    return DataModel.favorUp
  elseif value == "obtain_time" then
    return DataModel.timeUp
  end
  print("参数不存在！！！！！！！！！！！！")
  return false
end
local SortData = function(conditionList)
  table.sort(DataModel.sortData, function(t1, t2)
    local furPetIndex1 = DataModel.furPets[t1.pet_uid] or 999
    local furPetIndex2 = DataModel.furPets[t2.pet_uid] or 999
    if furPetIndex1 ~= furPetIndex2 then
      return furPetIndex1 < furPetIndex2
    end
    if t1.u_fid ~= "" and t2.u_fid == "" then
      return false
    end
    if t1.u_fid == "" and t2.u_fid ~= "" then
      return true
    end
    for i, v in ipairs(conditionList) do
      local param = SeletctParam(v) and 1 or -1
      if v == "favor" and t1.lv ~= t2.lv then
        return param * t1.lv > param * t2.lv
      end
      if t1[v] ~= t2[v] then
        return param * t1[v] > param * t2[v]
      end
    end
    return t1.id > t2.id
  end)
end
local SelectSortData = function()
  DataModel.sortData = {}
  local count = DataModel.selectKindList.count
  if count == 0 or count == DataModel.petKindsCount then
    DataModel.sortData = DataModel.petList
  else
    for k, v in pairs(DataModel.petList) do
      local kinds = PlayerData:GetFactoryData(v.id).petVarity
      if DataModel.selectKindList[kinds] then
        table.insert(DataModel.sortData, v)
      end
    end
  end
end
local GetPetState = function(status_level)
  local lv = 15 <= status_level and 15 or status_level
  lv = lv == 0 and 1 or lv
  local petStateConfig = PlayerData:GetFactoryData(99900022).petStateConfig
  for i, v in ipairs(petStateConfig) do
    if lv >= v.petStateMin and lv <= v.petStateMax then
      return v.stateName
    end
  end
end
local GetRoomId = function(ufid)
  local roomId = -1
  local posx = 0
  local roomList = PlayerData:GetHomeInfo().coach_template
  local furniture = PlayerData:GetHomeInfo().furniture[ufid]
  local coach_store = PlayerData:GetHomeInfo().coach_store
  for i, v in ipairs(roomList) do
    local cfgId = coach_store[v].id
    local coachType = PlayerData:GetFactoryData(cfgId).coachType
    local tagCA = PlayerData:GetFactoryData(coachType)
    if not tagCA.stopCarriage then
      roomId = roomId + 1
      if v == furniture.u_cid then
        posx = HomeManager.rooms[roomId]:GetFurniture(ufid).PosX
        break
      end
    end
  end
  if not PosClickHandler.GetRoomIsHaveEmptyTile(roomId) then
    return nil
  end
  return roomId
end
DataModel.InitData = InitData
DataModel.SortData = SortData
DataModel.SelectSortData = SelectSortData
DataModel.GetPetState = GetPetState
DataModel.GetRoomId = GetRoomId
return DataModel
