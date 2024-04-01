local View = require("UIMoveEnergy/UIMoveEnergyView")
local DataModel = require("UIMoveEnergy/UIMoveEnergyDataModel")
local Controller = {}
local HandelMeal = function()
  Net:SendProto("meal.info", function(json)
    local oldMealInfo = PlayerData:GetHomeInfo().meal_info
    local newMealInfo = json.meal_info
    if oldMealInfo and newMealInfo then
      local oldBoxMeal = oldMealInfo.box_meal or {}
      local newBoxMeal = newMealInfo.box_meal or {}
      for k, v in pairs(oldBoxMeal) do
        if newBoxMeal[k] == nil then
          PlayerData:ClearLoveBentoClicked(k)
        end
      end
    end
    DataModel.mealCount = 0
    PlayerData:GetHomeInfo().meal_info = newMealInfo
    local homeFoodDataModel = require("UIHomeFood/UIHomeFoodDataModel")
    homeFoodDataModel.RefreshFoodList()
    for k, v in pairs(homeFoodDataModel.foodList) do
      if not v.free then
        DataModel.mealCount = DataModel.mealCount + 1
      end
      if not v.used and v.free then
        local refreshTime = v.refreshTime
        local h = tonumber(string.sub(refreshTime, 1, 2))
        local m = tonumber(string.sub(refreshTime, 4, 5))
        local s = tonumber(string.sub(refreshTime, 7, 8))
        local isArrive = TimeUtil:GetNextSpecialTimeStamp(h, m, s, TimeUtil:GetFutureTime(0, 0)) <= TimeUtil:GetServerTimeStamp()
        if isArrive then
          DataModel.mealCount = DataModel.mealCount + 1
        end
      end
    end
    View.Img_BG.Group_Pick.Group_HomeFood.Img_Num.Txt_:SetText(DataModel.mealCount)
    local tip = DataModel.mealCount > 0 and GetText(80601970) or GetText(80601971)
    View.Img_BG.Group_Pick.Group_HomeFood.Img_Bubble.Txt_:SetText(tip)
  end)
end
local HandelRestArea = function()
  local homeCommon = require("Common/HomeCommon")
  local station_info = PlayerData:GetHomeInfo().station_info
  DataModel.StationId = station_info.sid
  local hasRestArea = false
  if station_info.status == -1 then
    local cityMapId = homeCommon.GetCityStateInfo(station_info.sid).cityMapId
    local cityNPCList = PlayerData:GetFactoryData(cityMapId).cityNPCList
    for k, v in pairs(cityNPCList) do
      if v.name == "休息区" then
        hasRestArea = true
        DataModel.restAreaInfo = v
        break
      end
    end
  end
  View.Img_BG.Group_Pick.Group_BarStore.Btn_Use:SetActive(hasRestArea)
  View.Img_BG.Group_Pick.Group_BarStore.Btn_NotUse:SetActive(not hasRestArea)
  local stations = PlayerData:GetHomeInfo().stations
  DataModel.restList = {}
  for k, v in pairs(stations) do
    local cfg = PlayerData:GetFactoryData(k)
    if cfg.limitNum > 0 then
      local data = {}
      data.cityName = cfg.name
      data.id = tonumber(k)
      data.status = cfg.limitNum > v.drink_num and 1 or -1
      table.insert(DataModel.restList, data)
    end
  end
  table.sort(DataModel.restList, function(t1, t2)
    if t1.status ~= t2.status then
      return t1.status > t2.status
    end
    return t1.id > t2.id
  end)
  View.Img_BG.Group_Pick.Group_BarStore.Img_Tip:SetActive(false)
end

function Controller:Init(data)
  local list = {}
  local itemIdList = data.idList
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local count = #itemIdList
  for i = 1, count do
    local itemId = itemIdList[i]
    local ca = PlayerData:GetFactoryData(itemId, "ItemFactory")
    local isDiamond = itemId == 11400005
    local needNum = isDiamond and homeConfig.orderCost[1].num or 1
    local energy = isDiamond and homeConfig.upgradeOrderValue or ca.exchangeList[1].num
    list[i] = {
      id = itemId,
      iconPath = ca.iconPath,
      needNum = needNum,
      name = ca.name,
      energy = energy
    }
  end
  DataModel.itemList = list
  DataModel.allDiamondUseNum = #homeConfig.orderCost
  DataModel.maxDiamondUseNum = DataModel.allDiamondUseNum - PlayerData:GetHomeInfo().meal_info.order_num
  View.Img_BG:SetActive(true)
  View.Group_Page2:SetActive(false)
  View.Img_BG.Group_Pick.StaticGrid_.self:RefreshAllElement()
  local index, statusInfo = DataModel.GetNowStatus()
  DataModel.nowstatus = index
  View.Img_BG.Img_BGStatement:SetSprite(statusInfo.bg)
  View.Img_BG.Spine_:SetAction(statusInfo.faceSpine, true, true)
  View.Img_BG.Img_Arrow:SetSprite(statusInfo.arrow)
  View.Img_BG.Txt_Statement:SetText(GetText(statusInfo.stateText))
  local nowNum = PlayerData:GetUserInfo().move_energy
  local homeCommon = require("Common/HomeCommon")
  local maxEnergy = homeCommon.GetMaxHomeEnergy()
  View.Img_BG.Txt_Num:SetText(string.format("%d<size=38>/%d</size>", nowNum, maxEnergy))
  View.Img_BG.Group_Tip:SetActive(5 <= index)
  for i = 1, 6 do
    View.Img_BG.Img_StatementIcon["Img_" .. i]:SetActive(i == index)
  end
  HandelRestArea()
  HandelMeal()
end

function Controller:InitView()
  local itemList = DataModel.itemList
  local groupPage1 = View.Group_Page1
  groupPage1.Btn_UseItem.Group_ItemEnergy.Img_Item:SetSprite(itemList[1].iconPath)
  groupPage1.Btn_UseMoney.Group_ItemEnergy.Img_Item:SetSprite(itemList[2].iconPath)
  groupPage1.Txt_Title:SetText(GetText(80601510))
  self._maskList = {
    groupPage1.Btn_UseItem.Img_Mask,
    groupPage1.Btn_UseMoney.Img_Mask
  }
  self._textNumList = {
    groupPage1.Btn_UseItem.Img_Num.Txt_Num,
    groupPage1.Btn_UseMoney.Img_Num.Txt_Num
  }
  self._btnAccessList = {
    groupPage1.Btn_UseItem.Btn_Access
  }
  self._textItemName = groupPage1.Img_DesBG.Txt_TitleMoney
  self._textDes = groupPage1.Img_DesBG.Txt_Des
  local count = #itemList
  local initIndex = count
  for i = count, 1, -1 do
    local isEnough = self:UpdateNum(i)
    if isEnough then
      initIndex = i
    end
  end
  Controller:SelectItem(initIndex)
  groupPage1.self:SetActive(true)
  View.Group_Page2.self:SetActive(false)
end

local GiftPackIsEnough = function()
  local week = true
  local month = true
  for k, v in pairs(PlayerData.RechargeGoods) do
    for k1, v1 in pairs(v) do
      if k1 == "82100015" then
        local ca = PlayerData:GetFactoryData(82100015)
        if v1.num >= ca.purchaseNum then
          week = false
        end
      end
      if k1 == "82100021" then
        local ca = PlayerData:GetFactoryData(82100021)
        if v1.num >= ca.purchaseNum then
          month = false
        end
      end
    end
  end
  return week or month
end

function Controller:SelectItem(index)
  local item = DataModel.itemList[index]
  if item.id == 11400005 then
    if DataModel.maxDiamondUseNum <= 0 then
      local callback = function()
        CommonTips.OpenStoreBuy(true)
      end
      if PlayerData.RechargeGoods == nil then
        Net:SendProto("shop.info", function(json)
          if GiftPackIsEnough() == false then
            CommonTips.OpenTips(80600467)
            return
          end
          CommonTips.OnPrompt(80602290, GetText(80600068), GetText(80600067), callback)
        end)
      else
        if GiftPackIsEnough() == false then
          CommonTips.OpenTips(80600467)
          return
        end
        CommonTips.OnPrompt(80602290, GetText(80600068), GetText(80600067), callback)
      end
      return
    end
    if not self:isItemEnough(index) then
      local callback = function()
        CommonTips.OpenStoreBuy()
      end
      CommonTips.OnPrompt(80600147, GetText(80600068), GetText(80600067), callback)
      return
    end
  end
  self._curIndex = index
  Controller:SetNumPage(true)
end

function Controller:isItemEnough(index)
  index = index or self._curIndex
  local item = DataModel.itemList[index]
  local num = PlayerData:GetGoodsById(item.id).num or 0
  local needNum
  if item.id == 11400005 then
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local orderNum = PlayerData:GetHomeInfo().meal_info.order_num
    needNum = homeConfig.orderCost[math.min(orderNum + 1, #homeConfig.orderCost)].num
  else
    needNum = item.needNum
  end
  return num >= needNum, num
end

function Controller:GetItemMaxNum(index)
  index = index or self._curIndex
  local item = DataModel.itemList[index]
  local num = PlayerData:GetGoodsById(item.id).num or 0
  local maxNum = 0
  if item.id == 11400005 then
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local orderNum = PlayerData:GetHomeInfo().meal_info.order_num
    local needNum = 0
    for i = orderNum + 1, #homeConfig.orderCost do
      needNum = needNum + homeConfig.orderCost[i].num
      if num < needNum then
        break
      end
      maxNum = maxNum + 1
    end
    maxNum = math.min(DataModel.maxDiamondUseNum, maxNum)
  else
    maxNum = math.floor(num / item.needNum)
  end
  maxNum = math.max(math.min(maxNum, math.ceil(PlayerData:GetUserInfo().move_energy / item.energy)), 1)
  return maxNum
end

function Controller:UpdateNum(index)
  local textId
  local isEnough, num = self:isItemEnough(index)
  if isEnough then
    textId = 80600449
  else
    textId = 80600499
  end
  if self._btnAccessList[index] then
    self._btnAccessList[index].self:SetActive(not isEnough)
  end
  self._textNumList[index]:SetText(string.format(GetText(textId), num))
  return isEnough
end

function Controller:SetNumPage(isOpen)
  if isOpen and not self:isItemEnough() then
    CommonTips.OpenTips(GetText(80600010))
    return
  end
  View.Img_BG.self:SetActive(not isOpen)
  local groupPage2 = View.Group_Page2
  groupPage2.self:SetActive(isOpen)
  if isOpen then
    local groupDes = groupPage2.Group_Des
    local index = self._curIndex
    local item = DataModel.itemList[index]
    groupDes.Group_ItemEnergy.Img_Item:SetSprite(item.iconPath)
    local cfg = PlayerData:GetFactoryData(item.id)
    groupDes.Group_ItemEnergy.Img_Bottom:SetSprite(UIConfig.BottomConfig[cfg.qualityInt + 1])
    groupDes.Group_ItemEnergy.Img_Mask:SetSprite(UIConfig.MaskConfig[cfg.qualityInt + 1])
    groupDes.Txt_TitleMoney:SetText(item.name)
    local isDiamond = item.id == 11400005
    groupPage2.Group_Tip:SetActive(false)
    if isDiamond then
      groupPage2.Group_Tip:SetActive(true)
      local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
      local orderNum = PlayerData:GetHomeInfo().meal_info.order_num
      local needNum = homeConfig.orderCost[math.min(orderNum + 1, #homeConfig.orderCost)].num
      groupDes.Txt_Des:SetText(string.format(GetText(80601509), needNum, item.energy, DataModel.maxDiamondUseNum))
    elseif item.id == 11400065 then
      local cfg = PlayerData:GetFactoryData(item.id)
      groupDes.Txt_Des:SetText(cfg.des)
    else
      groupDes.Txt_Des:SetText(string.format(GetText(80601512), item.energy))
    end
    groupPage2.Group_Num.self:SetActive(not isDiamond)
    groupPage2.Img_Num.Txt_Num:SetText(string.format(GetText(80600449), PlayerData:GetGoodsById(item.id).num or 0))
    groupPage2.Group_Change.Txt_BeforeNum:SetText(PlayerData:GetUserInfo().move_energy)
    groupPage2.Group_Num.Group_Slider.Group_Num.Txt_Possess:SetText(self:GetItemMaxNum(index))
    Controller:SetUseNumMin()
  end
end

function Controller:UpdateUseState(ignoreSlider)
  local useNum = DataModel.curUseNum
  View.Group_Page2.Group_Num.Group_Slider.Group_Num.Txt_Select:SetText(useNum)
  local index = self._curIndex
  local item = DataModel.itemList[index]
  local afterNum = math.max(0, PlayerData:GetUserInfo().move_energy - item.energy * useNum)
  View.Group_Page2.Group_Change.Txt_AfterNum:SetText(afterNum)
  if ignoreSlider then
    return
  end
  local percent = (useNum - 1) / math.max(self:GetItemMaxNum(index) - 1, 1)
  self._isSliderChanging = true
  View.Group_Page2.Group_Num.Group_Slider.Slider_Value:SetSliderValue(percent)
  self._isSliderChanging = false
end

function Controller:ChangeUseNum(num)
  local newUSeNum = math.min(math.max(1, DataModel.curUseNum + num), self:GetItemMaxNum(self._index))
  if newUSeNum == DataModel.curUseNum then
    return
  end
  DataModel.curUseNum = newUSeNum
  self:UpdateUseState()
end

function Controller:SetUseNumMax()
  DataModel.curUseNum = self:GetItemMaxNum(self._index)
  self:UpdateUseState()
end

function Controller:SetUseNumMin()
  DataModel.curUseNum = 1
  self:UpdateUseState()
end

function Controller:ChangeUseNumByPercent(percent)
  local newUSeNum = math.ceil(math.max(self:GetItemMaxNum(self._curIndex) - 1, 1) * percent + 1)
  newUSeNum = math.min(self:GetItemMaxNum(), math.max(1, newUSeNum))
  if newUSeNum == DataModel.curUseNum then
    return
  end
  DataModel.curUseNum = newUSeNum
  self:UpdateUseState(true)
end

function Controller:TryUseItem()
  local index = self._curIndex
  local item = DataModel.itemList[index]
  local id = item.id
  local needNum = item.needNum
  local useNum = DataModel.curUseNum
  if PlayerData:GetUserInfo().move_energy <= 0 then
    CommonTips.OpenTips(80600522)
    return
  end
  if id == 11400005 then
    if 0 >= DataModel.maxDiamondUseNum then
      CommonTips.OpenTips(GetText(80600467))
      return
    end
    Net:SendProto("meal.takeout", function(json)
      SdkReporter.TrackUseDiamond({reason = "energy", amount = needNum})
      View.self:Confirm()
      UIManager:GoBack()
      DataModel.maxDiamondUseNum = DataModel.maxDiamondUseNum - useNum
      PlayerData:GetHomeInfo().meal_info.order_num = PlayerData:GetHomeInfo().meal_info.order_num + useNum
      CommonTips.OpenTips(string.format(GetText(80601513), useNum * item.energy))
    end, useNum)
  else
    local firstParam, secondParam, thirdParam, fourthParam
    local usedUid = {}
    firstParam = id
    secondParam = useNum
    local itemCA = PlayerData:GetFactoryData(id)
    if itemCA.limitedTime and 0 < itemCA.limitedTime then
      secondParam = nil
      local curTime = TimeUtil:GetServerTimeStamp()
      local limitItems = DataModel.GetLimitTimeItem(id)
      if curTime >= limitItems[1].dead_line then
        View.Img_BG.Group_Pick.StaticGrid_.self:RefreshAllElement()
        View.Group_Page2:SetActive(false)
        CommonTips.OpenTips(80600045)
        return
      end
      firstParam = limitItems[1].uid
      usedUid[1] = limitItems[1].uid
      for i = 2, useNum do
        firstParam = firstParam .. "," .. limitItems[i].uid
        usedUid[i] = limitItems[i].uid
      end
      fourthParam = 1
    end
    local nowNum = PlayerData:GetUserInfo().move_energy
    Net:SendProto("item.use_items", function(json)
      if next(usedUid) ~= nil then
        for k, v in pairs(usedUid) do
          PlayerData:GetLimitedItems()[v] = nil
        end
      else
        local useItem = {}
        useItem[id] = useNum
        PlayerData:RefreshUseItems(useItem)
      end
      View.self:Confirm()
      UIManager:GoBack()
      if item.id == 11400065 then
        CommonTips.OpenTips(string.format(GetText(80601513), nowNum))
      else
        CommonTips.OpenTips(string.format(GetText(80601513), useNum * item.energy))
      end
    end, firstParam, secondParam, thirdParam, fourthParam)
  end
end

function Controller:OpenGetWay(index)
  local data = {}
  data.itemID = DataModel.itemList[index].id
  data.posX = 273
  data.posY = 42
  UIManager:Open("UI/Common/Group_GetWay", Json.encode(data))
end

return Controller
