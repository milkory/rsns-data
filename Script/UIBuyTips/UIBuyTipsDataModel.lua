local View = require("UIBuyTips/UIBuyTipsView")
local DataModel = {}
local money
DataModel.CommoditData = {}
DataModel.currentNum = 0
DataModel.EnumBtnType = {
  Add = 1,
  Subtraction = 2,
  Max = 3,
  Min = 4
}
local SetFurniture = function(element, data, isDetail)
  element:SetActive(true)
  element.Txt_Name:SetText(DataModel.commoditCA.commodityName)
  element.Img_Mask.Img_Item:SetSprite(DataModel.commoditCA.commodityView)
  View.Txt_Name:SetActive(false)
  local item = DataModel.commoditCA.commodityItemList[1]
  if item then
    local itemCA = PlayerData:GetFactoryData(item.id)
    if itemCA.plantScores then
      element.Group_Attribute.Group_AttributePlant.self:SetActive(itemCA.plantScores > 0)
      element.Group_Attribute.Group_AttributePlant.Txt_Scores:SetText(itemCA.plantScores)
    else
      element.Group_Attribute.Group_AttributePlant.self:SetActive(false)
    end
    if itemCA.fishScores then
      element.Group_Attribute.Group_AttributeFish.self:SetActive(0 < itemCA.fishScores)
      element.Group_Attribute.Group_AttributeFish.Txt_Scores:SetText(itemCA.fishScores)
    else
      element.Group_Attribute.Group_AttributeFish.self:SetActive(false)
    end
    if itemCA.petScores then
      element.Group_Attribute.Group_AttributePet.self:SetActive(0 < itemCA.petScores)
      element.Group_Attribute.Group_AttributePet.Txt_Scores:SetText(itemCA.petScores)
    else
      element.Group_Attribute.Group_AttributePet.self:SetActive(false)
    end
    if itemCA.foodScores then
      element.Group_Attribute.Group_AttributeAppetite.self:SetActive(0 < itemCA.foodScores)
      element.Group_Attribute.Group_AttributeAppetite.Txt_Scores:SetText(itemCA.foodScores)
    else
      element.Group_Attribute.Group_AttributeAppetite.self:SetActive(false)
    end
    if itemCA.comfort then
      element.Group_Attribute.Group_AttributeComfort.self:SetActive(0 < itemCA.comfort)
      element.Group_Attribute.Group_AttributeComfort.Txt_Scores:SetText(itemCA.comfort)
    else
      element.Group_Attribute.Group_AttributeComfort.self:SetActive(false)
    end
  end
end
local SetItem = function(element)
  local data = DataModel.commoditCA
  element:SetActive(true)
  element.Txt_Num:SetActive(true)
  element.Txt_Num:SetText(data.commodityNum or 1)
  element.Img_Time:SetActive(false)
  element.Group_EType:SetActive(false)
  local commodity = data.commodityItemList[1]
  local factoryName = DataManager:GetFactoryNameById(commodity.id)
  local itemCA = PlayerData:GetFactoryData(commodity.id)
  View.Txt_Name:SetActive(true)
  View.Txt_Name:SetText(itemCA.name)
  element.Img_Item:SetSprite(itemCA.iconPath)
  element.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.qualityInt + 1])
  element.Img_Mask:SetSprite(UIConfig.MaskConfig[data.qualityInt + 1])
  if factoryName == "EquipmentFactory" then
    local detailData = PlayerData:GetFactoryData(commodity.id)
    element.Group_EType:SetActive(true)
    local index = PlayerData:GetTypeInt("enumEquipTypeList", detailData.equipTagId)
    element.Group_EType.Img_Icon:SetSprite(UIConfig.EquipmentTypeMark[index])
    element.Group_EType.Img_IconBg:SetSprite(UIConfig.EquipmentTypeMarkBg[detailData.qualityInt])
  end
end
local SetData = function(data)
  DataModel.CommoditData = data
  if data.id then
    DataModel.commoditCA = PlayerData:GetFactoryData(data.id)
  end
  if data.commoditData and data.commoditData.id then
    DataModel.commoditCA = PlayerData:GetFactoryData(data.commoditData.id)
  end
  DataModel.ShopCA = PlayerData:GetFactoryData(data.shopid)
end

function DataModel:OpenBuyTips(isOpen, data)
  if isOpen then
    SetData(data)
    DataModel.isConfig = PlayerData:GetStoreBuyTipsConfig(DataModel.commoditCA.commodityItemList[1].id)
    DataModel.moneyList = DataModel.commoditCA.moneyList[1]
    local commoditCA = DataModel.commoditCA
    local moneyList = DataModel.moneyList
    local moneyNum = moneyList == nil and 0 or moneyList.moneyNum
    local moneyID = moneyList == nil and 0 or moneyList.moneyID
    local curHaveMoneyNum = PlayerData:GetGoodsById(moneyID).num
    local now_max = 0
    if commoditCA.isChange and 0 < DataModel.moneyList.correspondPrice then
      local listCA = PlayerData:GetFactoryData(DataModel.moneyList.correspondPrice, "ListFactory")
      local priceLength = #listCA.priceList
      for i = (DataModel.CommoditData.py_cnt or 0) + 1, priceLength do
        curHaveMoneyNum = curHaveMoneyNum - listCA.priceList[i].num
        if curHaveMoneyNum <= 0 then
          break
        end
        now_max = now_max + 1
      end
      while 0 <= curHaveMoneyNum - listCA.priceList[priceLength].num do
        now_max = now_max + 1
        curHaveMoneyNum = curHaveMoneyNum - listCA.priceList[priceLength].num
      end
    else
      now_max = math.floor(curHaveMoneyNum / moneyNum)
    end
    if now_max < 1 then
      now_max = 1
    end
    if commoditCA and commoditCA.oneTimeMax then
      local min = math.min(commoditCA.oneTimeMax, now_max)
      now_max = min
    end
    if commoditCA.purchase == true then
      local min = math.min(commoditCA.purchaseNum, now_max)
      now_max = min
    end
    if data.residue and data.residue ~= "" then
      now_max = math.min(now_max, data.residue)
    else
      data.residue = now_max
    end
    DataModel.CommoditData.residue = now_max
    self.SetNumBtn(self, DataModel.EnumBtnType.Min)
    View.Img_Furniture.self:SetActive(false)
    View.Group_Item.self:SetActive(false)
    if DataModel.isConfig == true then
      SetFurniture(View.Img_Furniture)
    else
      local CommonItem = require("Common/BtnItem")
      CommonItem:SetItem(View.Group_Item, {
        id = commoditCA.commodityItemList[1].id,
        num = commoditCA.commodityNum
      })
      local commodity = commoditCA.commodityItemList[1]
      local itemCA = PlayerData:GetFactoryData(commodity.id)
      View.Txt_Name:SetActive(true)
      View.Txt_Name:SetText(itemCA.name or itemCA.SkinName)
    end
    View.Group_Slider.Slider_Value:SetMinAndMaxValue(1, data.residue)
    if data.residue == 1 then
      View.Group_Slider.Slider_Value:SetMinAndMaxValue(0, data.residue)
    end
  else
    UIManager:GoBack(false, 1)
  end
end

function DataModel:Sale()
  self.OpenBuyTips(self, false)
  Net:SendProto("item.sell_items", function(json)
    PlayerData:RefreshUseItems({
      [DataModel.CommoditData.id] = math.ceil(DataModel.currentNum)
    })
    CommonTips.OpenShowItem(json.reward)
    UIManager:GoBack()
  end, tostring(DataModel.CommoditData.id), math.ceil(DataModel.currentNum))
end

local SetNum = function(maxNum)
  local num = DataModel.currentNum
  View.Group_Slider.Group_Num.Txt_Select:SetText(math.ceil(num))
  View.Group_Slider.Group_Num.Txt_Possess:SetText(maxNum)
  local moneyNum = DataModel.moneyList and DataModel.moneyList.moneyNum or 0
  local price = num * moneyNum
  if DataModel.commoditCA.isChange and 0 < DataModel.moneyList.correspondPrice then
    local buyCount = DataModel.CommoditData.py_cnt or 0
    local listCA = PlayerData:GetFactoryData(DataModel.moneyList.correspondPrice, "ListFactory")
    price = 0
    local priceLength = #listCA.priceList
    for i = buyCount + 1, priceLength do
      price = price + listCA.priceList[i].num
      num = num - 1
      if num <= 0 then
        break
      end
    end
    if 0 < num then
      price = price + num * listCA.priceList[priceLength].num
    end
  end
  money = price
  View.Group_Gold.Txt_Num:SetText(math.ceil(price))
  View.Group_Gold.Txt_Num:SetColor("#FFFFFF")
  if price > PlayerData:GetGoodsById(DataModel.moneyList.moneyID).num then
    View.Group_Gold.Txt_Num:SetColor("#FF0808")
  end
  if DataModel.commoditCA.monetaryView == "" or DataModel.commoditCA.monetaryView == nil then
    View.Group_Gold.Img_:SetActive(false)
  else
    View.Group_Gold.Img_:SetActive(true)
    View.Group_Gold.Img_:SetSprite(DataModel.commoditCA.monetaryView)
  end
end

function DataModel:SetNumBtn(btnType)
  local maxNum = DataModel.CommoditData.residue
  local num = DataModel.currentNum
  if btnType == DataModel.EnumBtnType.Add then
    if maxNum > num then
      num = num + 1
    else
      return
    end
  elseif btnType == DataModel.EnumBtnType.Subtraction then
    if 1 < num then
      num = num - 1
    else
      return
    end
  elseif btnType == DataModel.EnumBtnType.Max then
    num = maxNum
  elseif btnType == DataModel.EnumBtnType.Min then
    num = 1
  end
  DataModel.currentNum = num
  SetNum(maxNum)
  View.Group_Slider.Slider_Value:SetSliderValue(num)
end

function DataModel:SetSlider(value)
  if DataModel.CommoditData.residue == 1 then
    return
  end
  DataModel.currentNum = value
  SetNum(DataModel.CommoditData.residue)
end

function DataModel:BuyCommodit()
  local moneyList = DataModel.moneyList
  local moneyNum = moneyList == nil and 0 or moneyList.moneyNum
  local moneyID = moneyList == nil and 0 or moneyList.moneyID
  if money > PlayerData:GetGoodsById(moneyID).num then
    local callback = function()
      CommonTips.OpenStoreBuy()
    end
    local moneyName = PlayerData:GetFactoryData(moneyID).name
    if moneyID == 11400005 then
      CommonTips.OnPrompt(80600147, "确认", "取消", callback)
    elseif moneyID == 11400100 then
      local ca = PlayerData:GetFactoryData(moneyID, DataManager:GetFactoryNameById(moneyID))
      CommonTips.OpenTips(string.format(GetText(80601070), ca.name))
    else
      CommonTips.OpenTips(string.format(GetText(80601070), moneyName))
    end
  else
    local callback = function(json)
      if moneyID == 11400100 then
        PlayerData:RefreshUseItems({
          [moneyID] = math.ceil(DataModel.currentNum) * (moneyNum or 0)
        })
      else
        PlayerData:RefreshUseItems({
          [moneyID] = math.ceil(DataModel.currentNum) * (DataModel.moneyList.moneyNum or 0)
        })
      end
      UIManager:GoBack(false)
    end
    if DataModel.ShopCA.storeType == "Regular" then
      Net:SendProto("shop.buy", function(json)
        self:OnBuySuccess({json = json})
        local row = json.reward
        row.Title = "获得道具"
        callback(json)
        View.self:Confirm()
        if not DataModel.CommoditData.noShowReward then
          CommonTips.OpenShowItem(json.reward)
        end
      end, tostring(DataModel.CommoditData.shopid), DataModel.CommoditData.index, math.ceil(DataModel.currentNum), DataModel.commoditCA.id)
    else
      if DataModel.CommoditData.type and DataModel.CommoditData.type == "role" then
        Net:SendProto("shop.buy", function(json)
          self:OnBuySuccess({json = json})
          print_r(json)
          local row = json.reward
          row.Title = "获得角色"
          callback(json)
          View.self:Confirm()
          if not DataModel.CommoditData.noShowReward then
            CommonTips.OpenShowItem(json.reward)
          end
          DataModel.RefreshState = 1
        end, tostring(DataModel.CommoditData.shopid), DataModel.CommoditData.index, 1, DataModel.CommoditData.id)
        return
      end
      Net:SendProto("shop.buy", function(json)
        self:OnBuySuccess({json = json})
        local row = json.reward
        row.Title = "获得道具"
        callback(json)
        View.self:Confirm()
        if not DataModel.CommoditData.noShowReward then
          CommonTips.OpenShowItem(json.reward)
        end
      end, tostring(DataModel.CommoditData.shopid), DataModel.CommoditData.index, math.ceil(DataModel.currentNum))
    end
  end
end

function DataModel:OnBuySuccess(args)
  local shopId = DataModel.CommoditData.shopid
  local itemIndex = DataModel.CommoditData.index
  local itemId = DataModel.CommoditData.id or 0
  local num = DataModel.currentNum
  if DataModel.CommoditData.type and DataModel.CommoditData.type == "role" then
    num = 1
  end
  SdkReporter.TrackShopBuy({
    shopId = shopId,
    index = itemIndex,
    itemId = itemId,
    num = num
  })
end

return DataModel
