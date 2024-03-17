local DataModel = {
  TagType = {
    Edit = 1,
    Weapon = 2,
    Fix = 3,
    Skin = 4,
    Refit = 5
  },
  curSelectIdx = 0,
  preMouseDown = false,
  curFrameMouseDown = false,
  curFrameMouseUp = false,
  maxCoachNum = 8,
  isTrainMoved = false,
  TimeLineId = 0,
  TimeLineSound = nil,
  PassengerCoach = {},
  dragShowMode = 0,
  UnlockNextCoachLv = 0,
  FirstFrame = false,
  NeedRemoveScene = false
}

function DataModel.InitData()
  DataModel.preMouseDown = false
  DataModel.curSelectIdx = 0
  DataModel.dragShowMode = 0
  DataModel.recordEnterCoachIds = Clone(PlayerData:GetHomeInfo().coach_template)
  DataModel.maxCoachNum = DataModel.GetMaxCoachNum()
  DataModel.PassengerCoach = {}
  for k, v in pairs(PlayerData:GetHomeInfo().passenger) do
    for k1, v1 in pairs(v) do
      local furniture = PlayerData:GetHomeInfo().furniture[v1.u_fid]
      DataModel.PassengerCoach[furniture.u_cid] = 0
    end
  end
end

function DataModel.GetCurCoachNum()
  local bagCount = table.count(PlayerData:GetHomeInfo().coach_store)
  return bagCount
end

function DataModel.IsInitCoach(uid)
  local init = PlayerData:GetHomeInfo().coach_store[uid].init or 0
  return init == 1
end

function DataModel.GetMaxCoachNum()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local curElectricLv = PlayerData:GetHomeInfo().electric_lv
  for k, v in ipairs(homeConfig.electricLevelList) do
    if curElectricLv < v.lv then
      DataModel.UnlockNextCoachLv = v.lv
      return k - 1
    end
  end
  DataModel.UnlockNextCoachLv = 0
  return #homeConfig.electricLevelList
end

return DataModel
