local DataModel = {
  data = nil,
  curLv = 1,
  slotOpenCount = 0,
  slotInstallCount = 0,
  curCostElectric = 0,
  curSelectType = 0,
  slotLvRecord = {},
  coachSpeedAffect = 0,
  CurCostItemList = {}
}

function DataModel.InitData()
  local homeInfo = PlayerData:GetHomeInfo()
  DataModel.curLv = homeInfo.electric_lv + 1
  local electricConfig = PlayerData:GetFactoryData(99900023, "ConfigFactory")
  local electricInfo = electricConfig.electricList[DataModel.curLv]
  DataModel.slotOpenCount = electricInfo.slotNum
  DataModel.slotInstallCount = homeInfo.slot_num
  DataModel.curCostElectric = homeInfo.electric_used
end

function DataModel.InitSlotLvRecord()
  local electricConfig = PlayerData:GetFactoryData(99900023, "ConfigFactory")
  local count = #electricConfig.electricList
  local slot = 1
  for i = 1, count do
    local info = electricConfig.electricList[i]
    for j = slot, info.slotNum do
      table.insert(DataModel.slotLvRecord, i - 1)
    end
    if slot <= info.slotNum then
      slot = info.slotNum + 1
    end
  end
end

function DataModel.GetSlotElectric()
  local electricConfig = PlayerData:GetFactoryData(99900023, "ConfigFactory")
  local curElectric = 0
  for i = 1, DataModel.slotInstallCount do
    curElectric = curElectric + electricConfig.buyElectricList[i].electric
  end
  return curElectric
end

function DataModel.GetTotalElectric()
  local electricConfig = PlayerData:GetFactoryData(99900023, "ConfigFactory")
  local curElectric = electricConfig.electricList[DataModel.curLv].electric
  return math.floor((curElectric + DataModel.GetSlotElectric()) * (1 + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseElectricLimited))) + PlayerData.GetFurSkillBuff(EnumDefine.HomeSkillEnum.RiseElectricMax)
end

return DataModel
