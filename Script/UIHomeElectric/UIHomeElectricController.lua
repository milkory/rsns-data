local View = require("UIHomeElectric/UIHomeElectricView")
local DataModel = require("UIHomeElectric/UIHomeElectricDataModel")
local BtnItem = require("Common/BtnItem")
local Controller = {}

function Controller:Init()
  Controller:InitSpeedEffect()
  Controller:SelectPanel(DataModel.curSelectType, true)
  View.Group_BQ.Txt_MKGD:SetText(string.format(GetText(80600420), DataModel.GetSlotElectric()))
end

function Controller:InitSpeedEffect()
  View.Group_BQ.Group_Overview.self:SetActive(true)
  local home_info = PlayerData:GetHomeInfo()
  local curSpeed = home_info.speed
  local homeSkillSpeed = math.floor(PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddSpeed) + 0.5)
  local drinkBuffSpeed = math.floor(PlayerData:GetDrinkBuffIncrease(EnumDefine.HomeSkillEnum.AddSpeed) + 0.5)
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  local weightGoodsSpeed = PlayerData:GetUserInfo().space_info.now_train_goods_num / initConfig.goodsSlowDown
  weightGoodsSpeed = math.floor(weightGoodsSpeed + 0.5)
  local weightPassengerSpeed = PlayerData:GetCurPassengerNum() / initConfig.passengerSlowDown
  weightPassengerSpeed = math.floor(weightPassengerSpeed + 0.5)
  local maintenanceSpeed = 0
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local maxUpkeepDis = homeConfig.maintaindistance
  if maxUpkeepDis <= home_info.readiness.maintain.maintain_distance then
    maintenanceSpeed = math.floor(curSpeed * homeConfig.slowdown + 0.5)
  end
  local coachSpeedAffect = 0
  for k, v in pairs(PlayerData:GetHomeInfo().coach) do
    local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
    coachSpeedAffect = coachSpeedAffect + coachCA.speedEffect
  end
  coachSpeedAffect = coachSpeedAffect + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainSpeed, curSpeed, "coach")
  coachSpeedAffect = math.floor(coachSpeedAffect + 0.5)
  local trainAccessoriesSpeed = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainSpeed, curSpeed, "accessories")
  trainAccessoriesSpeed = trainAccessoriesSpeed + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainSpeed, curSpeed, "pendant")
  DataModel.coachSpeedAffect = coachSpeedAffect
  View.Group_BQ.Group_Overview.Group_Speed.Group_Skill:SetActive(0 < homeSkillSpeed)
  View.Group_BQ.Group_Overview.Group_Speed.Group_Drink:SetActive(0 < drinkBuffSpeed)
  View.Group_BQ.Group_Overview.Group_Speed.Group_Weight:SetActive(0 < weightPassengerSpeed)
  View.Group_BQ.Group_Overview.Group_Speed.Group_Goods:SetActive(0 < weightGoodsSpeed)
  View.Group_BQ.Group_Overview.Group_Speed.Group_Maintenance:SetActive(0 < maintenanceSpeed)
  View.Group_BQ.Group_Overview.Group_Speed.Group_Carriage:SetActive(coachSpeedAffect < 0)
  View.Group_BQ.Group_Overview.Group_Speed.Group_Weapon:SetActive(trainAccessoriesSpeed ~= 0)
  View.Group_BQ.Group_Overview.Group_All.Txt_Num:SetText(string.format(GetText(80601517), curSpeed + trainAccessoriesSpeed + coachSpeedAffect + homeSkillSpeed + drinkBuffSpeed - weightPassengerSpeed - weightGoodsSpeed - maintenanceSpeed))
  View.Group_BQ.Group_Overview.Group_Speed.Group_Skill.Txt_Num:SetText(homeSkillSpeed .. "km/h")
  View.Group_BQ.Group_Overview.Group_Speed.Group_Drink.Txt_Num:SetText(drinkBuffSpeed .. "km/h")
  View.Group_BQ.Group_Overview.Group_Speed.Group_Weight.Txt_Num:SetText(-weightPassengerSpeed .. "km/h")
  View.Group_BQ.Group_Overview.Group_Speed.Group_Goods.Txt_Num:SetText(-weightGoodsSpeed .. "km/h")
  View.Group_BQ.Group_Overview.Group_Speed.Group_Maintenance.Txt_Num:SetText(-maintenanceSpeed .. "km/h")
  View.Group_BQ.Group_Overview.Group_Speed.Group_Carriage.Txt_Num:SetText(coachSpeedAffect .. "km/h")
  View.Group_BQ.Group_Overview.Group_Speed.Group_Weapon.Txt_Num:SetText(trainAccessoriesSpeed .. "km/h")
  local curCoachCount = #PlayerData:GetHomeInfo().coach
  local maxCount = 0
  local curElectricLv = PlayerData:GetHomeInfo().electric_lv
  for k, v in ipairs(homeConfig.electricLevelList) do
    if curElectricLv < v.lv then
      maxCount = k - 1
      break
    end
  end
  if maxCount == 0 then
    maxCount = #homeConfig.electricLevelList
  end
  View.Group_BQ.Group_Overview.Group_Carriage.Txt_Num:SetText(string.format(GetText(80601849), curCoachCount, maxCount))
end

function Controller:SelectPanel(type, force)
  if not force and DataModel.curSelectType == type then
    return
  end
  DataModel.curSelectType = type
  if type == 1 then
    View.Group_CC.self:SetActive(false)
    Controller:InitDLPanel()
    View.Group_BQ.Group_DL.Img_XZ.self:SetActive(true)
    View.Group_BQ.Group_MK.Img_XZ.self:SetActive(false)
  elseif type == 2 then
    View.Group_DL.self:SetActive(false)
    Controller:InitCCPanel()
    View.Group_BQ.Group_DL.Img_XZ.self:SetActive(false)
    View.Group_BQ.Group_MK.Img_XZ.self:SetActive(true)
  end
end

function Controller:InitDLPanel()
  View.Group_DL.self:SetActive(true)
  local electricConfig = PlayerData:GetFactoryData(99900023, "ConfigFactory")
  local lvMax = #electricConfig.electricList
  local isMax = DataModel.curLv == lvMax
  View.Group_DL.Txt_AllGrade:SetText(DataModel.curLv - 1)
  local totalElectric = PlayerData:GetMaxElectric()
  View.Group_DL.Txt_AllNum:SetText(string.format(GetText(80600327), totalElectric))
  View.Group_DL.Txt_AllCost:SetText(PlayerData:GetHomeInfo().electric_used)
  local curElectricPercent = DataModel.curCostElectric / totalElectric
  local showPercent = curElectricPercent * 0.86 + 0.07
  View.Group_DL.Img_Progress:SetFilledImgAmount(showPercent)
  local eulerZ = curElectricPercent * -300 - 30.5
  View.Group_DL.Img_Progress.Group_Pointer.self:SetLocalEulerAngles(eulerZ)
  View.Group_DL.Txt_ElectricState:SetText(string.format("%2d", math.ceil(curElectricPercent * 100)))
  View.Group_DL.Txt_NowSpeed:SetText(string.format(GetText(80600331), PlayerData.GetCoachMaxSpeed()))
  showPercent = PlayerData:GetHomeInfo().speed / 320
  if 1 < showPercent then
    showPercent = 1
  end
  eulerZ = 160 * showPercent
  eulerZ = 80 - eulerZ
  View.Group_DL.Img_KD.Group_111.self:SetLocalEulerAngles(eulerZ)
  View.Group_DL.Btn_UpGrade.self:SetActive(not isMax)
  View.Group_DL.Btn_NotUpGrade.self:SetActive(isMax)
end

function Controller:InitCCPanel()
  UIManager:LoadSplitPrefab(View, "UI/Home/HomeElectric", "Group_CC")
  View.Group_CC.self:SetActive(true)
  local electricConfig = PlayerData:GetFactoryData(99900023, "ConfigFactory")
  local lvMax = #electricConfig.electricList
  View.Group_CC.Txt_AllElectric:SetText(string.format(GetText(80600338), DataModel.GetSlotElectric()))
  View.Group_CC.Group_1.Txt_Now:SetText(DataModel.slotInstallCount)
  View.Group_CC.Group_1.Txt_Total:SetText(DataModel.slotOpenCount)
  View.Group_CC.StaticGrid_MK.grid.self:RefreshAllElement()
  local showInstanllBtn = DataModel.slotInstallCount < DataModel.slotOpenCount
  View.Group_CC.Btn_Install.self:SetActive(showInstanllBtn)
  if showInstanllBtn then
    View.Group_CC.Btn_NotInstall.self:SetActive(false)
    View.Group_CC.Btn_Not.self:SetActive(false)
  else
    local showMax = DataModel.slotInstallCount == #electricConfig.buyElectricList
    View.Group_CC.Btn_NotInstall.self:SetActive(showMax)
    View.Group_CC.Btn_Not.self:SetActive(not showMax)
  end
end

function Controller:RefreshElectricUpPanel()
  View.Group_ElectricUp.self:SetActive(true)
  UIManager:LoadSplitPrefab(View, "UI/Home/HomeElectric", "Group_ElectricUp")
  View.Group_ElectricUp.Txt_LvBefore:SetText(DataModel.curLv - 1)
  local nextLv = DataModel.curLv + 1
  View.Group_ElectricUp.Txt_LvAfter:SetText(nextLv - 1)
  local electricConfig = PlayerData:GetFactoryData(99900023, "ConfigFactory")
  local beforeInfo = electricConfig.electricList[DataModel.curLv]
  local afterInfo = electricConfig.electricList[nextLv]
  local curSlotElectric = DataModel.GetSlotElectric()
  View.Group_ElectricUp.Txt_AddElectricNumNow:SetText(math.floor((beforeInfo.electric + curSlotElectric) * (1 + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseElectricLimited))))
  View.Group_ElectricUp.Txt_AddElectricNum:SetText(math.floor((afterInfo.electric + curSlotElectric) * (1 + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseElectricLimited))))
  View.Group_ElectricUp.Txt_AddBuyNumNow:SetText(beforeInfo.slotNum)
  View.Group_ElectricUp.Txt_AddBuyNum:SetText(afterInfo.slotNum)
  local defaultSpeed = PlayerData:GetHomeInfo().speed + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddSpeed)
  View.Group_ElectricUp.Txt_SpeedNow:SetText(string.format(GetText(80600600), defaultSpeed))
  View.Group_ElectricUp.Txt_SpeedAdd:SetText(string.format(GetText(80600600), defaultSpeed + afterInfo.speed - beforeInfo.speed))
  local costList = PlayerData:GetFactoryData(beforeInfo.id, "ListFactory").electricMaterialList
  DataModel.CurCostItemList = costList
  View.Group_ElectricUp.Group_List.ScrollGrid_List.grid.self:SetDataCount(#costList)
  View.Group_ElectricUp.Group_List.ScrollGrid_List.grid.self:RefreshAllElement()
end

function Controller:RefreshElectricBuyPanel()
  View.Group_ElectricBuy.self:SetActive(true)
  UIManager:LoadSplitPrefab(View, "UI/Home/HomeElectric", "Group_ElectricBuy")
  local curInstanllIdx = DataModel.slotInstallCount + 1
  local electricConfig = PlayerData:GetFactoryData(99900023, "ConfigFactory")
  local info = electricConfig.buyElectricList[curInstanllIdx]
  local curElectric = PlayerData:GetMaxElectric()
  View.Group_ElectricBuy.Txt_AddElectricNumNow:SetText(math.floor(curElectric * (1 + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseElectricLimited))))
  View.Group_ElectricBuy.Txt_AddElectricNum:SetText(math.floor((curElectric + info.electric) * (1 + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseElectricLimited))))
  View.Group_ElectricBuy.Txt_AddBuyNumNow:SetText(DataModel.slotInstallCount)
  View.Group_ElectricBuy.Txt_AddBuyNum:SetText(curInstanllIdx)
  local defaultSpeed = PlayerData:GetHomeInfo().speed + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddSpeed)
  View.Group_ElectricBuy.Txt_SpeedNow:SetText(string.format(GetText(80600600), defaultSpeed))
  View.Group_ElectricBuy.Txt_SpeedAdd:SetText(string.format(GetText(80600600), defaultSpeed + info.addSpeed))
  local costList = PlayerData:GetFactoryData(info.id, "ListFactory").electricMaterialList
  DataModel.CurCostItemList = costList
  View.Group_ElectricBuy.Group_List.ScrollGrid_List.grid.self:SetDataCount(#costList)
  View.Group_ElectricBuy.Group_List.ScrollGrid_List.grid.self:RefreshAllElement()
end

function Controller:ClickItem(str)
  local itemId = tonumber(str)
  local t = {}
  t.itemId = itemId
  CommonTips.OpenItem(t)
end

function Controller:SetItemElement(element, elementIndex)
  local info = DataModel.CurCostItemList[elementIndex]
  local itemId = info.id
  BtnItem:SetItem(element.Group_Item, {id = itemId})
  element.Group_Item.Btn_Item:SetClickParam(itemId)
  local num = PlayerData:GetGoodsById(itemId).num
  element.Group_Num.Txt_Num1:SetText(PlayerData:TransitionNum(num))
  if num < info.num then
    element.Group_Num.Txt_Num1:SetColor("#FF0000")
  else
    element.Group_Num.Txt_Num1:SetColor("#FFFFFF")
  end
  element.Group_Num.Txt_Num2:SetText(PlayerData:TransitionNum(info.num))
end

function Controller:OnDisable()
  View.Group_ElectricUp:SetActive(false)
  View.Group_ElectricBuy:SetActive(false)
end

return Controller
