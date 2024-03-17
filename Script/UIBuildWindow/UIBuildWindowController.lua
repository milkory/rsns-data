local View = require("UIBuildWindow/UIBuildWindowView")
local DataModel = require("UIBuildWindow/UIBuildWindowDataModel")
local Controller = {}

function Controller:Init()
  DataModel.tween = nil
  DataModel.InitBuildCoachList()
  View.ScrollGrid_Type.grid.self:SetDataCount(#DataModel.buildCoachKeys)
  View.ScrollGrid_Type.grid.self:RefreshAllElement()
  self:SelectMainType(1)
end

function Controller:SelectMainType(idx)
  DataModel.selectMainIdx = idx
  View.ScrollGrid_Type.grid.self:RefreshAllElement()
  DataModel.selectChildIdx = 1
  local count = #DataModel.buildCoachList[DataModel.buildCoachKeys[idx].id]
  if count == 3 then
    View.Group_VerticalLayout.Group_BtnList.self:SetActive(true)
    View.Group_VerticalLayout.Group_BtnList.Img_Select:SetActive(true)
    View.Group_VerticalLayout.Group_BtnList.StaticGrid_Type.grid.self:RefreshAllElement()
    local key = DataModel.buildCoachKeys[DataModel.selectMainIdx].id
    if key == 12600247 then
      DataModel.selectChildIdx = 2
    end
  else
    View.Group_VerticalLayout.Group_BtnList.self:SetActive(false)
  end
  Controller:SelectChildType(DataModel.selectChildIdx, true)
end

function Controller:SelectChildType(idx, firstIn)
  local tweenComplete = function()
    DataModel.selectChildIdx = idx
    local key = DataModel.buildCoachKeys[DataModel.selectMainIdx].id
    local tagCA = PlayerData:GetFactoryData(key, "TagFactory")
    View.Group_Title.Txt_Title:SetText(tagCA.typeName)
    View.Group_Title.Txt_Title.Img_Icon:SetSprite(tagCA.carriageIcon)
    local info = DataModel.buildCoachList[key][idx]
    local coachCA = info.coachCA
    DataModel.curShowCoachId = coachCA.id
    View.Txt_CarriageDetail:SetText(coachCA.describe)
    View.Group_VerticalLayout.Group_Attribute.Group_Speed.Txt_Number:SetText(math.floor(coachCA.speedEffect + 0.5) .. "km/h")
    View.Group_VerticalLayout.Group_Attribute.Group_Electric.Txt_Number:SetText(coachCA.electricCost)
    View.Group_VerticalLayout.Group_Attribute.Group_Goods.Txt_Number:SetText(math.floor(coachCA.space + 0.5))
    View.Group_VerticalLayout.Group_Attribute.Group_Durable.Txt_Number:SetText(coachCA.carriagedurability)
    View.Group_VerticalLayout.Group_Attribute.Group_Passenger.Txt_Number:SetText(coachCA.passengerCapacity)
    View.Group_VerticalLayout.Group_Attribute.Group_Weapon.Txt_Number:SetText(coachCA.weaponNum)
    View.Group_VerticalLayout.Group_Attribute.Group_Armor.Txt_Number:SetText(coachCA.Armor)
    View.Group_VerticalLayout.Group_Attribute.Group_Sleep.Txt_Number:SetText(coachCA.characterNum)
    local remainTime = 0
    local building = PlayerData:GetHomeInfo().building
    for k, v in pairs(building) do
      remainTime = v.create_time + coachCA.waittime - TimeUtil:GetServerTimeStamp()
      if remainTime < 0 then
        remainTime = 0
      end
      break
    end
    local timeTable
    if DataModel.buildingCoachId ~= 0 and DataModel.buildingCoachId == DataModel.curShowCoachId then
      timeTable = TimeUtil:SecondToTable(remainTime)
      local percent = 1 - remainTime / coachCA.waittime
      if percent < 0 then
        percent = 0
      end
      View.Group_VerticalLayout.Group_BuildTime.Img_ProgressBar.Img_Yellow:SetFilledImgAmount(percent)
    else
      timeTable = TimeUtil:SecondToTable(coachCA.waittime)
      View.Group_VerticalLayout.Group_BuildTime.Img_ProgressBar.Img_Yellow:SetFilledImgAmount(0)
    end
    View.Group_VerticalLayout.Group_BuildTime.Txt_Num:SetText(string.format("%02d:%02d:%02d", timeTable.hour, timeTable.minute, timeTable.second))
    local costMaterials = {}
    if DataModel.buildingCoachId == coachCA.id then
      if DataModel.isBuilding then
        costMaterials = coachCA.JumptimeList
      else
        costMaterials = nil
      end
    else
      costMaterials = coachCA.buildMaterialList
    end
    if costMaterials then
      DataModel.curShowCostMaterial = Clone(costMaterials)
      View.Group_UseMaterial.StaticGrid_Material.self:SetActive(true)
      View.Group_UseMaterial.Img_Built:SetActive(false)
      View.Group_UseMaterial.StaticGrid_Material.grid.self:RefreshAllElement()
    else
      View.Group_UseMaterial.StaticGrid_Material.self:SetActive(false)
      View.Group_UseMaterial.Img_Built:SetActive(true)
    end
    if info.lockDescribe == nil then
      View.Group_Three.Btn_Startbuild.self:SetActive(DataModel.buildingCoachId == 0)
      View.Group_Three.Btn_StartbuildNO.self:SetActive(DataModel.buildingCoachId ~= 0 and DataModel.buildingCoachId ~= coachCA.id)
      View.Group_Three.Btn_Jumptime.self:SetActive(DataModel.buildingCoachId == coachCA.id and DataModel.isBuilding)
      View.Group_Three.Btn_Built.self:SetActive(DataModel.buildingCoachId == coachCA.id and not DataModel.isBuilding)
    else
      View.Group_Lock.Img_LockBase.Txt_Detail:SetText(info.lockDescribe)
    end
    View.Group_Three.self:SetActive(info.lockDescribe == nil)
    View.Group_Lock.self:SetActive(info.lockDescribe ~= nil)
    if #DataModel.buildCoachList[key] == 3 then
      View.Group_VerticalLayout.Group_BtnList.StaticGrid_Type.grid.self:RefreshAllElement()
    end
  end
  if DataModel.tween then
    DataModel.tween:Kill()
  end
  if firstIn then
    View.Group_VerticalLayout.Group_BtnList.Img_Select:SetAnchoredPositionX(DataModel.childSelectMovePos[idx])
    tweenComplete()
  else
    DataModel.tween = DOTweenTools.DOLocalMoveXCallback(View.Group_VerticalLayout.Group_BtnList.Img_Select.transform, DataModel.childSelectMovePos[idx], 0.25, function()
      DataModel.tween = nil
      tweenComplete()
    end)
  end
end

function Controller:RefreshMainTypeElement(element, elementIndex)
  local info = DataModel.buildCoachKeys[elementIndex]
  local tagCA = PlayerData:GetFactoryData(info.id, "TagFactory")
  element.Btn_Carriage:SetClickParam(elementIndex)
  element.Btn_Carriage.Img_Carriage:SetSprite(tagCA.icon)
  element.Btn_Carriage.Txt_Name:SetText(tagCA.typeName)
  element.Btn_Carriage.Img_GoldSelect:SetActive(elementIndex == DataModel.selectMainIdx)
  local isBuilding = false
  if DataModel.buildingCoachId > 0 then
    local coachCA = PlayerData:GetFactoryData(DataModel.buildingCoachId, "HomeCoachFactory")
    isBuilding = coachCA.coachType == info.id
  end
  element.Btn_Carriage.Group_Building:SetActive(isBuilding and DataModel.isBuilding)
  element.Btn_Carriage.Group_Built:SetActive(isBuilding and not DataModel.isBuilding)
  local isShow = info.lockDescribe ~= nil
  element.Btn_Carriage.Img_ShadowLock.self:SetActive(isShow)
  if isShow then
    element.Btn_Carriage.Img_ShadowLock.Txt_Detail:SetText(info.lockDescribe)
  end
end

function Controller:RefreshChildTypeElement(element, elementIndex)
  local key = DataModel.buildCoachKeys[DataModel.selectMainIdx].id
  local coachCA = DataModel.buildCoachList[key][elementIndex].coachCA
  element.Btn_Type:SetClickParam(elementIndex)
  element.Img_SmallOFF.Img_Icon:SetSprite(DataModel.childIconPathOFF[elementIndex])
  element.Img_SmallON.Img_Icon:SetSprite(DataModel.childIconPathON[elementIndex])
  element.Img_SmallOFF:SetActive(elementIndex ~= DataModel.selectChildIdx)
  element.Img_SmallON:SetActive(elementIndex == DataModel.selectChildIdx)
  element.Img_SmallOFF.Txt_Text:SetText(coachCA.name)
  element.Img_SmallON.Txt_Text:SetText(coachCA.name)
end

function Controller:RefreshMaterialElement(element, elementIndex)
  local curBuildCount = PlayerData:GetHomeInfo().build_num
  local btnCommon = require("Common/BtnItem")
  local costInfo = DataModel.curShowCostMaterial[elementIndex]
  if costInfo then
    local percent = 1
    if DataModel.buildingCoachId ~= DataModel.curShowCoachId then
      local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
      if curBuildCount < #homeConfig.buildSaleList then
        percent = homeConfig.buildSaleList[curBuildCount + 1].discountRange or 1
      end
    end
    element.self:SetActive(true)
    btnCommon:SetItem(element.Group_Item, {
      id = costInfo.id
    })
    element.Group_Item.Btn_Item:SetClickParam(costInfo.id)
    local haveNum = PlayerData:GetGoodsById(costInfo.id).num
    element.Group_Cost.Txt_Have:SetText(haveNum)
    local costNum = math.floor(costInfo.num * percent + 0.5)
    costInfo.costNum = costNum
    local color = "#FFFFFF"
    if haveNum < costNum then
      color = "#FF0000"
    end
    element.Group_Cost.Txt_Need:SetText(costNum)
    if costInfo.id == 11400005 or costInfo.id == 11400001 then
      element.Group_Cost.Txt_And:SetActive(false)
      element.Group_Cost.Txt_Have:SetActive(false)
      element.Group_Cost.Txt_Need:SetColor(color)
    else
      element.Group_Cost.Txt_And:SetActive(true)
      element.Group_Cost.Txt_Have:SetActive(true)
      element.Group_Cost.Txt_Have:SetColor(color)
      element.Group_Cost.Txt_Need:SetColor("#FFFFFF")
    end
    local isShowDiscount = costInfo.id == 11400001 and percent < 1
    element.Img_Discounts:SetActive(isShowDiscount and 0 < curBuildCount)
    element.Img_First:SetActive(isShowDiscount and curBuildCount == 0)
    if isShowDiscount then
      if 0 < curBuildCount then
        element.Img_Discounts.Txt_Percent:SetText(math.floor((percent - 1) * 100 + 0.5) .. "%")
      else
        element.Img_First.Txt_Percent:SetText(string.format(GetText(80601352), math.floor((percent - 1) * 100 + 0.5) .. "%"))
      end
    end
  else
    element.self:SetActive(false)
  end
end

function Controller:RefreshBuildTime()
  local remainTime = 0
  local building = PlayerData:GetHomeInfo().building
  local isBuilding = 0 < table.count(building)
  if isBuilding then
    for k, v in pairs(building) do
      local coachCA = PlayerData:GetFactoryData(v.id, "HomeCoachFactory")
      remainTime = v.create_time + coachCA.waittime - TimeUtil:GetServerTimeStamp()
      if remainTime <= 0 then
        remainTime = 0
        DataModel.isBuilding = false
        View.ScrollGrid_Type.grid.self:RefreshAllElement()
      end
      break
    end
  end
  if DataModel.curShowCoachId == DataModel.buildingCoachId then
    local coachCA = PlayerData:GetFactoryData(DataModel.curShowCoachId, "HomeCoachFactory")
    local time = coachCA.waittime
    if 0 < remainTime then
      local timeTable = TimeUtil:SecondToTable(remainTime)
      View.Group_VerticalLayout.Group_BuildTime.Txt_Num:SetText(string.format("%02d:%02d:%02d", timeTable.hour, timeTable.minute, timeTable.second))
      local percent = 1 - remainTime / time
      if percent < 0 then
        percent = 0
      end
      View.Group_VerticalLayout.Group_BuildTime.Img_ProgressBar.Img_Yellow:SetFilledImgAmount(percent)
    else
      if DataModel.tween then
        DataModel.tween:Kill()
      end
      View.Group_VerticalLayout.Group_BuildTime.Img_ProgressBar.Img_Yellow:SetFilledImgAmount(1)
      View.Group_VerticalLayout.Group_BuildTime.Txt_Num:SetText(string.format("%02d:%02d:%02d", 0, 0, 0))
      Controller:SelectChildType(DataModel.selectChildIdx, true)
    end
  end
end

function Controller:ConfirmBuild()
  local items = {}
  for k, v in pairs(DataModel.curShowCostMaterial) do
    if PlayerData:GetGoodsById(v.id).num < (v.costNum or 0) then
      CommonTips.OpenTips(80601046)
      return
    end
    items[v.id] = v.num
  end
  Net:SendProto("home.build", function(json)
    SdkReporter.TrackCar({
      carId = DataModel.curShowCoachId
    })
    PlayerData:GetHomeInfo().building = json.building
    PlayerData:GetHomeInfo().build_num = PlayerData:GetHomeInfo().build_num + 1
    PlayerData:RefreshUseItems(items)
    Controller:Exit()
  end, DataModel.curShowCoachId)
end

function Controller:ConfirmSkipBuilding()
  local items = {}
  local num = 0
  for k, v in pairs(DataModel.curShowCostMaterial) do
    items[v.id] = v.num
    num = v.num
    if PlayerData:GetGoodsById(v.id).num < (v.costNum or 0) then
      CommonTips.OpenTips(80601046)
      return
    end
  end
  local skip_count = PlayerData:GetHomeInfo().skip_num or 0
  local text = ""
  if skip_count == 0 then
    text = GetText(80601980)
    num = 0
  end
  CommonTips.OnPrompt(string.format(GetText(80601269) .. text, num), nil, nil, function()
    Net:SendProto("home.skip", function(json)
      if PlayerData:GetHomeInfo().skip_num == nil then
        PlayerData:GetHomeInfo().skip_num = 1
      else
        PlayerData:GetHomeInfo().skip_num = PlayerData:GetHomeInfo().skip_num + 1
      end
      PlayerData:GetHomeInfo().building = json.building
      PlayerData:RefreshUseItems(items)
      if json.reward then
        Controller:DetailGetCoach(json)
      else
        CommonTips.OpenTips(80601270)
      end
      Controller:Exit(json)
    end)
  end)
end

function Controller:ConfirmGetCoach()
  Net:SendProto("home.get_coach", function(json)
    Controller:DetailGetCoach(json)
    Controller:Exit(json)
  end)
end

function Controller:DetailGetCoach(json)
  json.reward.furniture = nil
  PlayerData:GetHomeInfo().building = {}
  local editDataModel = require("UIHomeCarriageeditor/UIEditDataModel")
  editDataModel.GetCoachInfo = json.reward.coach
end

function Controller:Exit(json)
  if DataModel.tween then
    DataModel.tween:Kill()
  end
  View.self:PlayAnim("BuildWindow_out", function()
    View.self:CloseUI()
    View.self:Confirm()
    if json and json.reward then
      CommonTips.OpenCoachReward(json.reward)
    end
  end)
end

return Controller
