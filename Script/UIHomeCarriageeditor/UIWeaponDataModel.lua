local DataModel = {
  OperatorType = {
    Weapon = 1,
    Parts = 2,
    Pendant = 3
  },
  coachHeadUid = "",
  coachHeadInfo = {},
  coachInfo = {},
  partsInfo = {},
  pendantInfo = {},
  bagInfo = {}
}

function DataModel.InitCoachInfo()
  DataModel.coachInfo = {}
  local coachIds = PlayerData:GetHomeInfo().coach_template
  local useCoachRecord = {}
  DataModel.curUsedCoachCount = 0
  local editDataModel = require("UIHomeCarriageeditor/UIEditDataModel")
  for k, v in pairs(coachIds) do
    if k ~= 1 then
      local t = {}
      local coachInfo = PlayerData:GetHomeInfo().coach_store[v]
      t.id = tonumber(coachInfo.id)
      t.uid = v
      editDataModel.AddCAInfo(t, t.id, t.uid)
      t.name = coachInfo.name
      table.insert(DataModel.coachInfo, t)
    else
      DataModel.coachHeadUid = v
      local coachHeadInfo = {}
      local coachInfo = PlayerData:GetHomeInfo().coach_store[v]
      coachHeadInfo.id = tonumber(coachInfo.id)
      coachHeadInfo.uid = v
      editDataModel.AddCAInfo(coachHeadInfo, coachHeadInfo.id, coachHeadInfo.uid)
      coachHeadInfo.name = coachInfo.name
      DataModel.coachHeadInfo = coachHeadInfo
    end
    useCoachRecord[v] = 0
  end
  DataModel.InitCoachWeaponInfo()
  DataModel.InitPartsInfo()
  DataModel.InitPendantInfo()
end

function DataModel.InitCoachWeaponInfo(calcCA)
  local editDataModel = require("UIHomeCarriageeditor/UIEditDataModel")
  local serverInfo = PlayerData:GetHomeInfo().coach_store[DataModel.coachHeadInfo.uid]
  DataModel.coachHeadInfo.battery = serverInfo.battery
  if calcCA then
    editDataModel.AddCAInfo(DataModel.coachHeadInfo, DataModel.coachHeadInfo.id, DataModel.coachHeadInfo.uid)
  end
  for k, v in pairs(DataModel.coachInfo) do
    serverInfo = PlayerData:GetHomeInfo().coach_store[v.uid]
    v.battery = serverInfo.battery
    if calcCA then
      editDataModel.AddCAInfo(v, v.id, v.uid)
    end
  end
end

function DataModel.InitPartsInfo()
  DataModel.partsInfo = {}
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  for k, v in pairs(homeConfig.accessoryList) do
    local t = {}
    t.typeWeapon = v.id
    table.insert(DataModel.partsInfo, t)
  end
  for k, v in pairs(PlayerData:GetHomeInfo().train_accessories) do
    if DataModel.partsInfo[k] == nil then
      DataModel.partsInfo[k] = {}
    end
    DataModel.partsInfo[k].uid = v
    if v ~= "" then
      DataModel.partsInfo[k].id = tonumber(PlayerData:GetBattery()[v].id)
    end
  end
end

function DataModel.InitPendantInfo()
  DataModel.pendantInfo = {}
  local pendantElectricList = PlayerData:GetFactoryData(99900044).pendantElectricList
  for i, v in ipairs(pendantElectricList) do
    DataModel.pendantInfo[i] = {
      typeWeapon = 12600301,
      needElectricLv = v.id
    }
  end
  for k, v in pairs(PlayerData:GetHomeInfo().train_pendant) do
    DataModel.pendantInfo[k].uid = v
    if v ~= "" then
      DataModel.pendantInfo[k].id = tonumber(PlayerData:GetBattery()[v].id)
    end
  end
end

return DataModel
