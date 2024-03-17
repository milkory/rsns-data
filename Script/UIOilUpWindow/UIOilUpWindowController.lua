local View = require("UIOilUpWindow/UIOilUpWindowView")
local DataModel = require("UIOilUpWindow/UIOilUpWindowDataModel")
local Controller = {}

function Controller:Init()
  Controller:HideAll()
  if DataModel.Info.type == 1 then
    self:InitOilUpView()
  elseif DataModel.Info.type == 2 then
    self:InitSpeedAddView()
  else
    self:InitSpeedReduceView()
  end
end

function Controller:HideAll()
  View.Img_Hara.Img_Oil:SetActive(false)
  View.Img_Hara.Img_SpeedUp:SetActive(false)
  View.Img_Hara.Img_SlowDown:SetActive(false)
  View.Txt_Title:SetActive(false)
  View.Txt_TitleSpeedUp:SetActive(false)
  View.Txt_TitleSlowDown:SetActive(false)
  View.Group_OilNum:SetActive(false)
  View.Group_SurplusNum:SetActive(false)
  View.Group_BuildTime:SetActive(false)
  View.Group_Speed:SetActive(false)
  View.Group_SpeedUp:SetActive(false)
  View.Group_SlowDown:SetActive(false)
end

function Controller:InitOilUpView()
  View.Img_Hara.Img_Oil:SetActive(true)
  View.Txt_Title:SetActive(true)
  View.Group_OilNum:SetActive(true)
  View.Group_SurplusNum:SetActive(true)
  View.Group_BuildTime:SetActive(true)
  View.Group_Speed:SetActive(true)
  local curLv = DataModel.Info.level
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local curInfo = homeConfig.OilLevelList[curLv]
  local nextInfo = homeConfig.OilLevelList[curLv + 1]
  local color1 = "#FFFFFF"
  local color2 = "#FFA200"
  View.Group_OilNum.Txt_Num1:SetText(curLv)
  View.Group_OilNum.Txt_Num2:SetText(curLv + 1)
  local oilUpNum = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseRushLimited)
  local upValue = initConfig.trainRushLimit + curInfo.OilNum
  View.Group_SurplusNum.Txt_Num1:SetText(upValue + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RiseRushLimited, upValue) + oilUpNum)
  upValue = initConfig.trainRushLimit + nextInfo.OilNum
  View.Group_SurplusNum.Txt_Num2:SetText(upValue + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RiseRushLimited, upValue) + oilUpNum)
  View.Group_SurplusNum.Txt_Num2:SetColor(curInfo.OilNum == nextInfo.OilNum and color1 or color2)
  local timeValue = initConfig.trainRushTime + curInfo.speeduptime
  View.Group_BuildTime.Txt_Num1:SetText(timeValue + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RiseRushUseTime, timeValue) .. "s")
  timeValue = initConfig.trainRushTime + nextInfo.speeduptime
  View.Group_BuildTime.Txt_Num2:SetText(timeValue + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RiseRushUseTime, timeValue) .. "s")
  View.Group_BuildTime.Txt_Num2:SetColor(curInfo.speeduptime == nextInfo.speeduptime and color1 or color2)
  local speedValue = initConfig.trainRushSpeedAdd + curInfo.speedup
  View.Group_Speed.Txt_Num1:SetText(speedValue + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RushSpeed, speedValue) .. "km/h")
  speedValue = initConfig.trainRushSpeedAdd + nextInfo.speedup
  View.Group_Speed.Txt_Num2:SetText(speedValue + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RushSpeed, speedValue) .. "km/h")
  View.Group_Speed.Txt_Num2:SetColor(curInfo.speedup == nextInfo.speedup and color1 or color2)
  self:RefreshMaterialCost(curInfo.id)
end

function Controller:InitSpeedAddView()
  View.Img_Hara.Img_SpeedUp:SetActive(true)
  View.Txt_TitleSpeedUp:SetActive(true)
  View.Group_SpeedUp:SetActive(true)
  local element = View.Group_SpeedUp
  local trainCA = PlayerData:GetFactoryData(99900037, "ConfigFactory")
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local curLv = DataModel.Info.level
  local curInfo = homeConfig.speedUpList[curLv]
  local nextInfo = homeConfig.speedUpList[curLv + 1]
  local originValueBefore = trainCA.speedAdd + curInfo.Num
  local weaponSpeedAdd = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainStartAddSpeed, originValueBefore)
  element.Txt_Num1:SetText(math.floor(originValueBefore + 0.5 + weaponSpeedAdd) .. "km/h")
  local originValueAfter = trainCA.speedAdd + nextInfo.Num
  weaponSpeedAdd = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainStartAddSpeed, originValueAfter)
  element.Txt_Num2:SetText(math.floor(originValueAfter + 0.5 + weaponSpeedAdd) .. "km/h")
  self:RefreshMaterialCost(curInfo.id)
end

function Controller:InitSpeedReduceView()
  View.Img_Hara.Img_SlowDown:SetActive(true)
  View.Txt_TitleSlowDown:SetActive(true)
  View.Group_SlowDown:SetActive(true)
  local element = View.Group_SlowDown
  local trainCA = PlayerData:GetFactoryData(99900037, "ConfigFactory")
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local curLv = DataModel.Info.level
  local curInfo = homeConfig.slowDownList[curLv]
  local nextInfo = homeConfig.slowDownList[curLv + 1]
  local originValueBefore = trainCA.speedReduce + curInfo.Num
  local weaponSpeedReduce = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainStoptAddSpeed, originValueBefore)
  element.Txt_Num1:SetText(math.floor(originValueBefore + 0.5 + weaponSpeedReduce) .. "km/h")
  local originValueAfter = trainCA.speedReduce + nextInfo.Num
  weaponSpeedReduce = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainStoptAddSpeed, originValueAfter)
  element.Txt_Num2:SetText(math.floor(originValueAfter + 0.5 + weaponSpeedReduce) .. "km/h")
  self:RefreshMaterialCost(curInfo.id)
end

function Controller:RefreshMaterialCost(id)
  View.Group_UseMaterial:SetActive(true)
  DataModel.CanUpdate = true
  DataModel.CostItems = {}
  local btnItem = require("Common/BtnItem")
  local costMaterial = PlayerData:GetFactoryData(id)
  for i = 1, 3 do
    local costInfo = costMaterial.OilMaterialList[i]
    local element = View.Group_UseMaterial["Group_Consume" .. i]
    if costInfo ~= nil then
      element.self:SetActive(true)
      DataModel.CostItems[costInfo.id] = costInfo.num
      btnItem:SetItem(element.Group_Item, {
        id = costInfo.id
      })
      element.Group_Item.Btn_Item:SetClickParam(costInfo.id)
      local haveNum = PlayerData:GetGoodsById(costInfo.id).num
      local color1 = "#FFFFFF"
      local colorRed = "#FF0000"
      element.Group_Cost.Txt_Have:SetText(PlayerData:TransitionNum(haveNum))
      element.Group_Cost.Txt_Need:SetText(PlayerData:TransitionNum(costInfo.num))
      element.Group_Cost.Txt_Have:SetColor(haveNum >= costInfo.num and color1 or colorRed)
      if haveNum < costInfo.num then
        DataModel.CanUpdate = false
      end
    else
      element.self:SetActive(false)
    end
  end
end

function Controller:ConfirmUpClick()
  if not DataModel.CanUpdate then
    CommonTips.OpenTips(80601046)
    return
  end
  local oldLv = DataModel.Info.level
  local newLv = oldLv + 1
  local uiPath = "UI/Trainfactory/Second/OilLevelUp"
  local protocolName = "home.update_fuel"
  local protocolParam
  if DataModel.Info.type == 2 then
    protocolName = "home.cultivate"
    protocolParam = 0
    oldLv = PlayerData:GetHomeInfo().expedite_lv
    uiPath = "UI/Trainfactory/Second/SpeedUpLevelUp"
  elseif DataModel.Info.type == 3 then
    protocolName = "home.cultivate"
    protocolParam = 1
    oldLv = PlayerData:GetHomeInfo().brake_lv
    uiPath = "UI/Trainfactory/Second/SlowDownLevelUp"
  end
  Net:SendProto(protocolName, function(json)
    PlayerData:RefreshUseItems(DataModel.CostItems)
    if protocolName == "home.cultivate" then
      if protocolParam == 0 then
        newLv = PlayerData:GetHomeInfo().expedite_lv + 1
        PlayerData:GetHomeInfo().expedite_lv = newLv
        SdkReporter.TrackTrain({
          accLv = newLv - 1
        })
      elseif protocolParam == 1 then
        newLv = PlayerData:GetHomeInfo().brake_lv + 1
        PlayerData:GetHomeInfo().brake_lv = newLv
        SdkReporter.TrackTrain({
          brakeLv = newLv - 1
        })
      end
    end
    Controller:CloseSelf(function()
      View.self:Confirm()
      if uiPath then
        local t = {}
        t.oldLv = oldLv
        t.newLv = newLv
        UIManager:Open(uiPath, Json.encode(t))
      end
    end)
  end, protocolParam)
end

function Controller:CloseSelf(cb)
  if DataModel.IsOutAnim then
    return
  end
  DataModel.IsOutAnim = true
  View.self:PlayAnim("Out_OilUp", function()
    UIManager:GoBack(false)
    DataModel.IsOutAnim = false
    View.self:Confirm()
    if cb then
      cb()
    end
  end)
end

return Controller
