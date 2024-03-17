local View = require("UIHomeCarriageeditor/UIHomeCarriageeditorView")
local DataModel = require("UIHomeCarriageeditor/UIFixDataModel")
local MainDataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
local MainController = require("UIHomeCarriageeditor/UIHomeCarriageeditorController")
local Controller = {}

function Controller:InitView(currTag)
  MainController:MoveTrain()
  DataModel.CurSelectType = 0
  View.Group_Fix.Group_TakeCare.self:SetActive(false)
  View.Group_Fix.Group_Wash.self:SetActive(false)
  View.Group_Fix.Group_TrainMaintenance.self:SetActive(false)
  View.Group_Fix.Btn_Wash.Img_WashOFF.self:SetActive(false)
  View.Group_Fix.Btn_Wash.Img_WashON.self:SetActive(true)
  View.Group_Fix.Btn_TakeCare.Img_TakeCareOFF.self:SetActive(true)
  View.Group_Fix.Btn_TakeCare.Img_TakeCareON.self:SetActive(false)
  View.Group_Fix.Btn_TrainMaintenance.Img_TrainMaintenanceOFF.self:SetActive(true)
  View.Group_Fix.Btn_TrainMaintenance.Img_TrainMaintenanceON.self:SetActive(false)
  View.Group_Fix.Group_Wash.self:SetActive(false)
  View.Group_Fix.Group_TrainMaintenance.self:SetActive(false)
  View.Group_Fix.Group_TakeCare.self:SetActive(false)
  if currTag then
    Controller:SelectTag(currTag, true)
  else
    Controller:SelectTag(DataModel.TagType.Wash, true)
  end
end

function Controller:SelectTag(type, force)
  if not force and type == DataModel.CurSelectType then
    return
  end
  local lastSelect = DataModel.CurSelectType
  DataModel.CurSelectType = type
  local upkeepSelected = type == DataModel.TagType.Upkeep
  local washSelected = type == DataModel.TagType.Wash
  local repairSelected = type == DataModel.TagType.Repair
  View.Group_Fix.Btn_TakeCare.Img_TakeCareOFF.self:SetActive(not upkeepSelected)
  View.Group_Fix.Btn_TakeCare.Img_TakeCareON.self:SetActive(upkeepSelected)
  View.Group_Fix.Btn_Wash.Img_WashOFF.self:SetActive(not washSelected)
  View.Group_Fix.Btn_Wash.Img_WashON.self:SetActive(washSelected)
  View.Group_Fix.Btn_TrainMaintenance.Img_TrainMaintenanceOFF.self:SetActive(not repairSelected)
  View.Group_Fix.Btn_TrainMaintenance.Img_TrainMaintenanceON.self:SetActive(repairSelected)
  local detailDo = function()
    View.Group_Fix.Group_TakeCare.self:SetActive(upkeepSelected)
    View.Group_Fix.Group_Wash.self:SetActive(washSelected)
    View.Group_Fix.Group_TrainMaintenance.self:SetActive(repairSelected)
    if upkeepSelected then
      self:InitUpkeepView()
    elseif washSelected then
      self:InitWashView()
    elseif repairSelected then
      self:InitRepairView()
    end
  end
  local playAnimName = ""
  local element
  if lastSelect == DataModel.TagType.Upkeep then
    playAnimName = "Fix_takeCare_out"
    element = View.Group_Fix.Group_TakeCare.self
  elseif lastSelect == DataModel.TagType.Wash then
    playAnimName = "Fix_wash_out"
    element = View.Group_Fix.Group_Wash.self
  elseif lastSelect == DataModel.TagType.Repair then
    playAnimName = "TrainMaintenance_new_out"
    element = View.Group_Fix.Group_TrainMaintenance.self
  end
  if playAnimName == "" or element.IsActive == false then
    detailDo()
  else
    View.self:SelectPlayAnim(element, playAnimName, function()
      detailDo()
    end)
  end
end

function Controller:InitUpkeepView()
  View.self:SelectPlayAnim(View.Group_Fix.Group_TakeCare.self, "Fix_takeCare_in")
  MainController:RefreshResources()
  local driveTime = PlayerData:GetHomeInfo().drive_time
  local driveDistance = PlayerData:GetHomeInfo().drive_distance
  local upkeepCount = PlayerData:GetHomeInfo().readiness.maintain.maintain_num
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local element = View.Group_Fix.Group_TakeCare
  local showDriveTime = driveTime * homeConfig.timeRatio
  showDriveTime = math.floor(showDriveTime * 10 + 0.5) / 10
  element.Group_Record.Txt_TimeData:SetText(showDriveTime .. "h")
  element.Group_Record.Txt_DistanceData:SetText(math.floor(driveDistance * homeConfig.disRatio) .. "km")
  element.Group_Record.Txt_NumData:SetText(upkeepCount)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local maxUpkeepDis = homeConfig.maintaindistance
  local costInfo = homeConfig.maintainpriceList[1]
  DataModel.CostId = costInfo.id
  DataModel.CostCache = 0
  local curMoveDistance = PlayerData:GetHomeInfo().readiness.maintain.maintain_distance
  local level1Dis = maxUpkeepDis * 400 / 550
  local level2Dis = maxUpkeepDis * 100 / 550
  local level3Dis = maxUpkeepDis * 50 / 550
  local good = curMoveDistance <= level1Dis
  local normal = curMoveDistance <= level2Dis + level1Dis and curMoveDistance > level1Dis
  local statusELement, lineElement
  element.Group_Status.Group_Good.self:SetActive(false)
  element.Group_Status.Group_Normal.self:SetActive(false)
  element.Group_Status.Group_Bad.self:SetActive(false)
  element.Group_Mileage.Img_Line.Img_Green:SetActive(false)
  element.Group_Mileage.Img_Line.Img_Yellow:SetActive(false)
  element.Group_Mileage.Img_Line.Img_Red:SetActive(false)
  if good then
    statusELement = element.Group_Status.Group_Good
    lineElement = element.Group_Mileage.Img_Line.Img_Green
    element.Group_Mileage.Txt_Detail:SetText(string.format(GetText(80600399), math.floor(curMoveDistance * homeConfig.disRatio)))
  elseif normal then
    statusELement = element.Group_Status.Group_Normal
    lineElement = element.Group_Mileage.Img_Line.Img_Yellow
    element.Group_Mileage.Txt_Detail:SetText(string.format(GetText(80600400), math.floor(curMoveDistance * homeConfig.disRatio)))
  else
    statusELement = element.Group_Status.Group_Bad
    lineElement = element.Group_Mileage.Img_Line.Img_Red
    element.Group_Mileage.Txt_Detail:SetText(GetText(80600401))
    DataModel.CostCache = costInfo.num
    DataModel.CostCache = math.floor(DataModel.CostCache * (1 - PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.ReduceRepairCost)) + 0.5)
  end
  element.Btn_Fix.Group_Open.self:SetActive(DataModel.CostCache ~= 0)
  element.Btn_Fix.Group_Close.self:SetActive(DataModel.CostCache == 0)
  element.Group_Money.self:SetActive(DataModel.CostCache ~= 0)
  element.Group_Money.Txt_Money:SetText(DataModel.CostCache)
  local percent = curMoveDistance / maxUpkeepDis
  if 1 < percent then
    percent = 1
  elseif percent < 0 then
    percent = 0
  end
  statusELement.self:SetActive(true)
  lineElement:SetActive(true)
  lineElement:SetFilledImgAmount(percent)
  local x = 600 * percent - 300
  element.Group_Mileage.Img_Line.Img_Hand:SetAnchoredPositionX(x)
  View.Group_Fix.Group_TakeCare.Group_Mileage.Img_BlackBase.Txt_Num:SetText(math.floor(curMoveDistance * homeConfig.disRatio) .. "/" .. math.floor(maxUpkeepDis * homeConfig.disRatio))
  Controller:RefreshAutoUpkeepShow()
end

function Controller:InitWashView()
  if View.Group_Fix == nil or View.Group_Fix.Group_Wash == nil then
    return
  end
  View.self:SelectPlayAnim(View.Group_Fix.Group_Wash.self, "Fix_wash_in")
  MainController:RefreshResources()
  local element = View.Group_Fix.Group_Wash
  Net:SendProto("home.clean_status", function(json)
    local percent = json.current_clean
    local isLimitUp = (json.rub_status or 0) == 1
    element.Img_circle.Group_Limit:SetActive(isLimitUp)
    element.Group_RubbishStatus.Btn_RubbishBox.Img_RedPoint:SetActive(isLimitUp)
    element.Group_RubbishStatus.Group_Npc.Img_Empty:SetActive(not isLimitUp)
    element.Group_RubbishStatus.Group_Npc.Img_Full:SetActive(isLimitUp)
    element.Img_circle.Txt_Percentage:SetText(math.floor(percent * 100) .. "%")
    local showPercent = percent
    if showPercent <= 0.08 and 0 < showPercent then
      showPercent = 0.1
    elseif 0.92 <= showPercent and showPercent < 1 then
      showPercent = 0.9
    end
    element.Img_circle.Img_full:SetFilledImgAmount(showPercent)
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local isGood = percent >= homeConfig.cleanone
    local isNormal = percent >= homeConfig.cleantwo and percent < homeConfig.cleanone
    local isBad = percent < homeConfig.cleantwo
    element.Group_WashStatus.Group_Good.self:SetActive(isGood)
    element.Group_WashStatus.Group_Normal.self:SetActive(isNormal)
    element.Group_WashStatus.Group_Bad.self:SetActive(isBad)
    local costInfo = homeConfig.cleancoefficienttwoList[1]
    DataModel.CostId = costInfo.id
    DataModel.CostCache = 0
    if percent < 1 then
      DataModel.CostCache = (homeConfig.cleancoefficientone - percent * 100) * costInfo.num * #PlayerData:GetHomeInfo().coach
      DataModel.CostCache = math.floor(DataModel.CostCache + 0.5)
    end
    element.Group_WashButton.Btn_Wash.Group_Open.self:SetActive(DataModel.CostCache ~= 0)
    element.Group_WashButton.Btn_Wash.Group_Close.self:SetActive(DataModel.CostCache == 0)
    local showPercent = math.floor(percent * 100)
    if isGood then
      element.Group_WashStatus.Txt_Text:SetText(string.format(GetText(80601030), showPercent))
    elseif isNormal then
      element.Group_WashStatus.Txt_Text:SetText(string.format(GetText(80601031), showPercent, 100 - showPercent))
    elseif isBad then
      element.Group_WashStatus.Txt_Text:SetText(string.format(GetText(80601032), showPercent))
    end
    element.Group_WashButton.Group_Money.self:SetActive(DataModel.CostCache ~= 0)
    element.Group_WashButton.Group_Money.Txt_Money:SetText(DataModel.CostCache)
    Controller:RefreshAutoWashShow()
  end)
end

function Controller:InitRepairView()
  local coachs = PlayerData:GetHomeInfo().coach
  local element = View.Group_Fix.Group_TrainMaintenance
  element.Img_TrainConstituteBg.Txt_TrainConstitute:SetText(string.format(GetText(80600772), 1, #coachs - 1))
  local serverRepairInfo = PlayerData:GetHomeInfo().readiness.repair
  local maxDurable = PlayerData.GetCoachMaxDurability()
  element.Img_circle.Txt_Durability:SetText(serverRepairInfo.current_durable .. "/" .. maxDurable)
  element.Img_circle.Img_full:SetFilledImgAmount(serverRepairInfo.current_durable / maxDurable)
  local delta = maxDurable - serverRepairInfo.current_durable
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local costInfo = homeConfig.repairpriceList[1]
  DataModel.CostId = costInfo.id
  local cost = delta * costInfo.num
  cost = math.floor(cost * (1 - PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.ReduceRepairCost)) + 0.5)
  element.Group_RepairDescription.Txt_RepairDescription:SetText(string.format(GetText(80600785), delta, cost))
  element.Group_FixButton.Group_Money.Txt_Money:SetText(cost)
  DataModel.CostCache = cost
  element.Group_FixButton.Btn_Fix.Group_Close.self:SetActive(DataModel.CostCache == 0)
  element.Group_FixButton.Group_Money.self:SetActive(DataModel.CostCache ~= 0)
  Controller:RefreshRepairAutoSelect()
end

function Controller:RefreshRepairAutoSelect()
  View.Group_Fix.Group_TrainMaintenance.Group_Auto.Btn_AutoSelect:SetActive(PlayerData:GetHomeInfo().readiness.repair.auto_repair == 1)
end

function Controller:ConfirmRepair()
  if DataModel.CostCache == 0 then
    return
  end
  CommonTips.OnPrompt(string.format(GetText(80601024), DataModel.CostCache), nil, nil, function()
    local costId = DataModel.CostId
    local cost = DataModel.CostCache
    Net:SendProto("home.repair", function(json)
      SdkReporter.TrackTrainMaint({
        repair = 1,
        costId = costId,
        cost = cost
      })
      MainController:RefreshResources()
      MainController:RemoveCurTimeLine()
      MainDataModel.TimeLineId = 84000011
      local timeLine = require("Common/TimeLine")
      timeLine.LoadTimeLine(MainDataModel.TimeLineId, function()
        MainDataModel.TimeLineId = 0
        MainDataModel.TimeLineSound = nil
        Controller:InitRepairView()
      end)
    end)
  end)
end

function Controller:AutoRepair(isAuto)
  Net:SendProto("home.update_auto", function(json)
    Controller:RefreshRepairAutoSelect()
  end, isAuto and 1 or 0)
end

function Controller:RefreshAutoUpkeepShow()
  local isOn = PlayerData:GetHomeInfo().readiness.maintain.auto_maintain == 1
  View.Group_Fix.Group_TakeCare.Btn_Button.Img_ON:SetActive(isOn)
  View.Group_Fix.Group_TakeCare.Btn_Button.Img_OFF:SetActive(not isOn)
end

function Controller:ConfirmUpkeep()
  if DataModel.CostCache == 0 then
    return
  end
  CommonTips.OnPrompt(string.format(GetText(80601028), DataModel.CostCache), nil, nil, function()
    local costId = DataModel.CostId
    local cost = DataModel.CostCache
    Net:SendProto("home.maintain", function()
      SdkReporter.TrackTrainMaint({
        maint = 1,
        costId = costId,
        cost = cost
      })
      MainController:RemoveCurTimeLine()
      MainDataModel.TimeLineId = 84000010
      local timeLine = require("Common/TimeLine")
      timeLine.LoadTimeLine(MainDataModel.TimeLineId, function()
        MainDataModel.TimeLineId = 0
        MainDataModel.TimeLineSound = nil
        Controller:InitUpkeepView()
      end)
    end)
  end)
end

function Controller:AutoUpkeep()
  local isAutoUpkeep = PlayerData:GetHomeInfo().readiness.maintain.auto_maintain == 1
  local num = 1
  if isAutoUpkeep then
    num = 0
  end
  Net:SendProto("home.update_auto", function()
    Controller:RefreshAutoUpkeepShow()
  end, nil, num)
end

function Controller:RefreshAutoWashShow()
  local isOn = PlayerData:GetHomeInfo().readiness.wash.auto_wash == 1
  View.Group_Fix.Group_Wash.Group_TextStatus.Btn_Button.Img_ON:SetActive(isOn)
  View.Group_Fix.Group_Wash.Group_TextStatus.Btn_Button.Img_OFF:SetActive(not isOn)
end

function Controller:ConfirmWash()
  if DataModel.CostCache == 0 then
    return
  end
  CommonTips.OnPrompt(string.format(GetText(80601036), DataModel.CostCache), nil, nil, function()
    Net:SendProto("home.wash", function()
      SdkReporter.TrackTrainMaint({
        clean = 1,
        costId = DataModel.CostId,
        cost = DataModel.CostCache
      })
      View.Group_Fix.Group_Wash.Group_WashButton.Btn_Wash.Group_Open.self:SetActive(false)
      View.Group_Fix.Group_Wash.Group_WashButton.Btn_Wash.Group_Close.self:SetActive(true)
      MainController:RemoveCurTimeLine()
      MainDataModel.TimeLineId = 84000005
      local timeLine = require("Common/TimeLine")
      timeLine.LoadTimeLine(MainDataModel.TimeLineId, function()
        MainDataModel.TimeLineId = 0
        MainDataModel.TimeLineSound = nil
        Controller:InitWashView()
      end)
      local targetFrameRate = CS.UnityEngine.Application.targetFrameRate or GameSetting.currentVisualFPSNum
      timeLine.SetTimeLineTimeCallback(84000005, 450 / targetFrameRate, function()
        HomeTrainManager:ReloadTrains()
        TrainManager:SetHuoInternalCheLeight(false)
      end)
    end)
  end)
end

function Controller:AutoWash()
  local isAutoWash = PlayerData:GetHomeInfo().readiness.wash.auto_wash == 1
  local num = 1
  if isAutoWash then
    num = 0
  end
  Net:SendProto("home.update_auto", function()
    Controller:RefreshAutoWashShow()
  end, nil, nil, num)
end

return Controller
