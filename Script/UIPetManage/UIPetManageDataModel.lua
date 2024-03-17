local DataModel = {}
local CalPetFurList = function()
  DataModel.petHouseCount = 0
  DataModel.roomCount = 0
  DataModel.petFurList = {}
  for k, v in pairs(PlayerData:GetHomeInfo().furniture) do
    local functionType = PlayerData:GetFactoryData(v.id).functionType
    if functionType == 12600464 and v.u_cid ~= "" then
      local pets = PlayerData:GetHomeInfo().furniture[k].house.pets
      DataModel.roomCount = DataModel.roomCount + PlayerData:GetFactoryData(v.id).PetNum
      local roomId = -1
      local posx = -1
      local fur_exist = false
      local roomList = PlayerData:GetHomeInfo().coach_template
      local furniture = PlayerData:GetHomeInfo().furniture[k]
      local coach_store = PlayerData:GetHomeInfo().coach_store
      for i, v1 in ipairs(roomList) do
        local cfgId = coach_store[v1].id
        local coachType = PlayerData:GetFactoryData(cfgId).coachType
        local tagCA = PlayerData:GetFactoryData(coachType)
        if not tagCA.stopCarriage then
          roomId = roomId + 1
          if v1 == furniture.u_cid then
            fur_exist = true
            posx = HomeManager.rooms[roomId]:GetFurniture(k).PosX
            break
          end
        end
      end
      if fur_exist then
        DataModel.petHouseCount = DataModel.petHouseCount + 1
        table.insert(DataModel.petFurList, {
          u_fid = k,
          pets = pets,
          roomId = roomId,
          posx = posx
        })
      end
    end
  end
  table.sort(DataModel.petFurList, function(t1, t2)
    if t1.roomId ~= t2.roomId then
      return t1.roomId < t2.roomId
    end
    return t1.posx < t2.posx
  end)
end
local Init = function()
  CalPetFurList()
  local petList = PlayerData:GetHomeInfo().pet and PlayerData:GetHomeInfo().pet or {}
  DataModel.petList = {}
  DataModel.petInRoomCout = 0
  for k, v in pairs(petList) do
    table.insert(DataModel.petList, v)
    v.pet_uid = k
    if v.u_fid ~= "" then
      DataModel.petInRoomCout = DataModel.petInRoomCout + 1
    end
  end
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
  DataModel.petKindsList = PlayerData:GetFactoryData(99900022).petVarityList or {}
  DataModel.petKindsCount = #DataModel.petKindsList
  DataModel.selectKindList = {count = 0}
  DataModel.now_kinds = nil
  DataModel.SelectSortData(0)
  DataModel.SortData(DataModel.favorFirst)
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
    for i, v in ipairs(conditionList) do
      local param = SeletctParam(v) and 1 or -1
      if t1[v] ~= t2[v] then
        if v == "favor" and t1.lv ~= t2.lv then
          return param * t1.lv > param * t2.lv
        end
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
DataModel.Init = Init
DataModel.SortData = SortData
DataModel.SelectSortData = SelectSortData
return DataModel
