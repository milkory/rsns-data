local View = require("UIHomeCarriageeditor/UIHomeCarriageeditorView")
local DataModel = require("UIHomeCarriageeditor/UIRefitDataModel")
local MainDataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
local MainController = require("UIHomeCarriageeditor/UIHomeCarriageeditorController")
local Controller = {}

function Controller:InitView()
  DataModel.ClearCacheObject()
  MainController:MoveTrain()
  MainController:RefreshResources()
  View.Group_TrainRefit.Group_Oil.self:SetActive(false)
  View.Group_TrainRefit.Group_SpeedChange.self:SetActive(false)
  self:SelectTag(DataModel.TagType.SpeedChange, true)
end

function Controller:SelectTag(type, force)
  if not force and type == DataModel.CurSelectType then
    return
  end
  local lastSelect = DataModel.CurSelectType
  DataModel.CurSelectType = type
  local element = View.Group_TrainRefit
  local oilSelected = type == DataModel.TagType.Oil
  local speedSelected = type == DataModel.TagType.SpeedChange
  element.Btn_Oil.Img_OilOFF.self:SetActive(not oilSelected)
  element.Btn_Oil.Img_OilON.self:SetActive(oilSelected)
  element.Btn_SpeedChange.Img_SpeedChangeOFF.self:SetActive(not speedSelected)
  element.Btn_SpeedChange.Img_SpeedChangeON.self:SetActive(speedSelected)
  local detailDo = function()
    element.Group_Oil.self:SetActive(oilSelected)
    element.Group_SpeedChange.self:SetActive(speedSelected)
    if oilSelected then
      self:InitOilView()
    elseif speedSelected then
      self:InitSpeedChangeView()
    end
  end
  local playAnimName = ""
  local curView
  if lastSelect == DataModel.TagType.Oil then
    playAnimName = "Fix_oil_out"
    curView = element.Group_Oil.self
  elseif lastSelect == DataModel.TagType.SpeedChange then
    playAnimName = "SpeedChange_out"
    curView = element.Group_SpeedChange.self
  end
  if playAnimName == "" or curView.IsActive == false then
    detailDo()
  else
    View.self:SelectPlayAnim(curView, playAnimName, function()
      detailDo()
    end)
  end
end

function Controller:InitOilView()
  MainController:MoveTrain()
  MainController:RefreshResources()
  local element = View.Group_TrainRefit.Group_Oil
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local curCount = PlayerData:GetHomeInfo().readiness.fuel.fuel_num
  local curLv = PlayerData:GetHomeInfo().readiness.fuel.fuel_lv
  local oilInfo = homeConfig.OilLevelList[curLv]
  local originValueTime = initConfig.trainRushTime + oilInfo.speeduptime
  local finTime = originValueTime + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RiseRushUseTime, originValueTime)
  local originValueSpeedUp = initConfig.trainRushSpeedAdd + oilInfo.speedup
  local finSpeedUp = originValueSpeedUp + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RushSpeed, originValueSpeedUp)
  element.Group_OilStatus.Txt_Text:SetText(string.format(GetText(80601035), finTime, finSpeedUp))
  local costInfo = initConfig.trainRushBuyList[1]
  DataModel.CostId = costInfo.id
  DataModel.oilOneCostCache = costInfo.num
  DataModel.CostCache = 0
  local isMaxLv = #homeConfig.OilLevelList == curLv
  local maxCount = PlayerData.GetMaxFuelNum()
  DataModel.oilBuyCount = 0
  DataModel.oilRemainBuyCount = maxCount - curCount
  element.Group_OilStatus.Img_circle.Txt_oilnum:SetText(curCount .. "/" .. maxCount)
  local cur = 35 + 290 / maxCount * curCount
  local max = 360
  element.Group_OilStatus.Img_circle.Img_full:SetFilledImgAmount(cur / max)
  local parent = element.Group_OilStatus.Img_circle.self.transform
  local len = #DataModel.CacheInstantDivideLine
  local originPath = "UI/Trainfactory/Img_Divideline"
  for i = 1, maxCount - 2 - len do
    local newObj = View.self:GetRes(originPath, parent)
    DataModel.CacheInstantDivideLine[len + 1] = newObj
    len = len + 1
  end
  local angle = 0
  local startAngle = 145
  local percentAngle = 290 / maxCount
  for i = 0, maxCount - 2 do
    angle = startAngle - percentAngle * (i + 1)
    local uiImg
    if i == 0 then
      uiImg = element.Group_OilStatus.Img_circle.Img_Divideline
    else
      uiImg = DataModel.CacheInstantDivideLine[i].transform:GetComponent(typeof(CS.Seven.UIImg))
    end
    uiImg:SetLocalEulerAngles(angle)
  end
  element.Group_OilStatus.Txt_Level:SetText(curLv)
  element.Group_OilStatus.Btn_OilUp.self:SetActive(not isMaxLv)
  element.Group_OilStatus.Btn_OilUpMax.self:SetActive(isMaxLv)
  element.Group_TextStatus.Slider_Num.self:SetMinAndMaxValue(0, DataModel.oilRemainBuyCount)
  element.Group_OilStatus.Txt_UseText:SetActive(false)
  element.Group_OilStatus.Btn_Button:SetActive(false)
  Controller:RefreshOilBuyShow(0)
  Controller:RefreshAutoOilShow()
  View.Group_TrainRefit.Group_Oil.Group_OilStatus.Btn_Button:SetActive(false)
  View.Group_TrainRefit.Group_Oil.Group_OilStatus.Txt_UseText:SetActive(false)
end

function Controller:RefreshOilBuyShow(value)
  if value < 0 then
    value = 0
  elseif value > DataModel.oilRemainBuyCount then
    value = DataModel.oilRemainBuyCount
  end
  local element = View.Group_TrainRefit.Group_Oil
  DataModel.oilBuyCount = math.floor(value + 0.5)
  element.Group_TextStatus.Txt_Num:SetText(DataModel.oilBuyCount .. "/" .. DataModel.oilRemainBuyCount)
  element.Group_TextStatus.Slider_Num.self:SetSliderValue(DataModel.oilBuyCount)
  DataModel.CostCache = DataModel.oilBuyCount * DataModel.oilOneCostCache
  element.Group_OilButton.Group_Money.Txt_Money:SetText(DataModel.CostCache)
  element.Group_OilButton.Group_Money.self:SetActive(DataModel.CostCache ~= 0)
  element.Group_OilButton.Btn_Oil.Group_Open.self:SetActive(DataModel.CostCache ~= 0)
  element.Group_OilButton.Btn_Oil.Group_Close.self:SetActive(DataModel.CostCache == 0)
end

function Controller:RefreshAutoOilShow()
  local isOn = PlayerData:GetHomeInfo().readiness.fuel.auto_fuel == 1
  View.Group_TrainRefit.Group_Oil.Group_OilButton.Btn_Button.Img_ON:SetActive(isOn)
  View.Group_TrainRefit.Group_Oil.Group_OilButton.Btn_Button.Img_OFF:SetActive(not isOn)
end

function Controller:ConfirmOil()
  if DataModel.CostCache == 0 then
    return
  end
  CommonTips.OnPrompt(string.format(GetText(80601038), DataModel.CostCache, DataModel.oilBuyCount), nil, nil, function()
    if PlayerData:GetGoodsById(DataModel.CostId).num < DataModel.CostCache then
      CommonTips.OpenTips(80601025)
      return
    end
    Net:SendProto("home.refuel", function(json)
      Controller:InitOilView()
      MainController:RefreshResources()
    end, DataModel.oilBuyCount)
  end)
end

function Controller:AutoOil()
  local isAutoOil = PlayerData:GetHomeInfo().readiness.fuel.auto_fuel == 1
  local num = 1
  if isAutoOil then
    num = 0
  end
  Net:SendProto("home.update_auto", function()
    Controller:RefreshAutoOilShow()
  end, nil, nil, nil, num)
end

function Controller:ClickOilUp()
  local t = {}
  t.type = 1
  t.level = PlayerData:GetHomeInfo().readiness.fuel.fuel_lv
  UIManager:Open("UI/Trainfactory/OilUpWindow", Json.encode(t), function()
    Controller:InitOilView()
  end)
end

function Controller:InitSpeedChangeView()
  MainController:RefreshResources()
  local element = View.Group_TrainRefit.Group_SpeedChange
  local trainCA = PlayerData:GetFactoryData(99900037, "ConfigFactory")
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local speedAddMaxLv = #homeConfig.speedUpList
  local speedReduceMaxLv = #homeConfig.slowDownList
  local speedAddLv = PlayerData:GetHomeInfo().expedite_lv or 1
  local speedReduceLv = PlayerData:GetHomeInfo().brake_lv or 1
  local originValue = trainCA.speedAdd + homeConfig.speedUpList[speedAddLv].Num
  local curSpeedAddNum = originValue + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainStartAddSpeed, originValue)
  curSpeedAddNum = tostring(math.floor(curSpeedAddNum + 0.5))
  local showNumberElement = element.Group_SpeedUp.Group_Display.Img_DisplayBg.Group_Number
  if 2 < #curSpeedAddNum then
    showNumberElement.Txt_1:SetAlpha(1)
    showNumberElement.Txt_1:SetText(string.sub(curSpeedAddNum, 1, 1))
    showNumberElement.Txt_2:SetText(string.sub(curSpeedAddNum, 2, 2))
    showNumberElement.Txt_3:SetText(string.sub(curSpeedAddNum, 3, 3))
  else
    showNumberElement.Txt_1:SetAlpha(0.098)
    showNumberElement.Txt_1:SetText(0)
    showNumberElement.Txt_2:SetText(string.sub(curSpeedAddNum, 1, 1))
    showNumberElement.Txt_3:SetText(string.sub(curSpeedAddNum, 2, 2))
  end
  originValue = trainCA.speedReduce + homeConfig.slowDownList[speedReduceLv].Num
  local curSpeedReduceNum = originValue + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainStoptAddSpeed, originValue)
  curSpeedReduceNum = tostring(math.floor(curSpeedReduceNum + 0.5))
  showNumberElement = element.Group_SlowDown.Group_Display.Img_DisplayBg.Group_Number
  if 2 < #curSpeedReduceNum then
    showNumberElement.Txt_1:SetAlpha(1)
    showNumberElement.Txt_1:SetText(string.sub(curSpeedAddNum, 1, 1))
    showNumberElement.Txt_2:SetText(string.sub(curSpeedAddNum, 2, 2))
    showNumberElement.Txt_3:SetText(string.sub(curSpeedAddNum, 3, 3))
  else
    showNumberElement.Txt_1:SetAlpha(0.098)
    showNumberElement.Txt_1:SetText(0)
    showNumberElement.Txt_2:SetText(string.sub(curSpeedReduceNum, 1, 1))
    showNumberElement.Txt_3:SetText(string.sub(curSpeedReduceNum, 2, 2))
  end
  element.Group_SpeedUp.Txt_Level:SetText(speedAddLv)
  element.Group_SlowDown.Txt_Level:SetText(speedReduceLv)
  element.Group_SpeedUp.Btn_OilUp:SetActive(speedAddMaxLv > speedAddLv)
  element.Group_SlowDown.Btn_OilUp:SetActive(speedReduceMaxLv > speedReduceLv)
  element.Group_SpeedUp.Btn_OilUpMax:SetActive(speedAddMaxLv <= speedAddLv)
  element.Group_SlowDown.Btn_OilUpMax:SetActive(speedReduceMaxLv <= speedReduceLv)
  element.Img_CenterBg.Img_circle1.Group_Electric.Txt_Num:SetText(PlayerData.GetMaxElectric())
  element.Img_CenterBg.Img_circle1.Group_Speed.Txt_Num:SetText(PlayerData.GetCoachSpeed() .. "km/h")
  element.Img_CenterBg.Img_circle1.Group_MaxSpeed.Txt_Num:SetText(PlayerData.GetCoachMaxSpeed() .. "km/h")
end

function Controller:ClickSpeedChange(type)
  local t = {}
  t.type = type + 1
  if type == 1 then
    t.level = PlayerData:GetHomeInfo().expedite_lv or 1
  else
    t.level = PlayerData:GetHomeInfo().brake_lv or 1
  end
  UIManager:Open("UI/Trainfactory/OilUpWindow", Json.encode(t), function()
    self:InitSpeedChangeView()
  end)
end

function Controller:SetAutoUseBullet()
  local startLv = PlayerData:GetFactoryData(99900037).autoRushLv
  local curLv = PlayerData:GetHomeInfo().readiness.fuel.fuel_lv
  if startLv > curLv then
    CommonTips.OpenTips(string.format(GetText(80602610), startLv))
    return
  end
  local isAuto = PlayerData:GetPlayerPrefs("int", "autoUseBullet") ~= 0
  PlayerData:SetPlayerPrefs("int", "autoUseBullet", isAuto and 0 or 1)
  View.Group_TrainRefit.Group_Oil.Group_OilStatus.Btn_Button.Img_ON:SetActive(not isAuto)
  View.Group_TrainRefit.Group_Oil.Group_OilStatus.Btn_Button.Img_OFF:SetActive(isAuto)
end

return Controller
