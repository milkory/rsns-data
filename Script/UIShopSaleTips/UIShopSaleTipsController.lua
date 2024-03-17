local View = require("UIShopSaleTips/UIShopSaleTipsView")
local DataModel = require("UIShopSaleTips/UIShopSaleTipsDataModel")
local Controller = {}
local SetFurniture = function(element, data, isDetail)
  element:SetActive(true)
  element.Img_Mask.Img_Item:SetSprite(data.tipsPath or data.petIconPath)
  local item = data
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

function Controller:Init()
  local commodityCA = PlayerData:GetFactoryData(DataModel.Data.commodityId, "CommodityFactory")
  local BtnItem = require("Common/BtnItem")
  DataModel.isConfig = PlayerData:GetStoreBuyTipsConfig(commodityCA.recycleItem)
  View.Group_Item.self:SetActive(false)
  View.Img_Furniture.self:SetActive(false)
  if DataModel.isConfig == true then
    SetFurniture(View.Img_Furniture, PlayerData:GetFactoryData(commodityCA.recycleItem))
  else
    BtnItem:SetItem(View.Group_Item, {
      id = DataModel.Data.id
    })
  end
  View.Group_Item.Btn_Item:SetClickParam(DataModel.Data.id)
  View.Group_Item.Img_Item:SetSprite(commodityCA.commodityView)
  DataModel.MoneyList = commodityCA.recycleMoneyList
  View.Group_Slider.Slider_Value.self:SetMinAndMaxValue(1, DataModel.Data.num)
  Controller:SetNum(1)
end

function Controller:SetNum(value)
  if value > DataModel.Data.num then
    value = DataModel.Data.num
  elseif value < 1 then
    value = 1
  end
  DataModel.CurrentNum = math.floor(value)
  View.Group_Slider.Slider_Value:SetSliderValue(DataModel.CurrentNum)
  View.Group_Gold.Txt_Num:SetText(DataModel.CurrentNum * DataModel.MoneyList[1].moneyNum)
  View.Group_Slider.Group_Num.Txt_Select:SetText(DataModel.CurrentNum)
  View.Group_Slider.Group_Num.Txt_Possess:SetText(DataModel.Data.num)
end

function Controller:Confirm()
  local saledRecord = {}
  local itemId = ""
  local num = DataModel.CurrentNum
  if DataModel.Data.uids then
    for k, v in pairs(DataModel.Data.uids) do
      saledRecord[num] = v
      num = num - 1
      if itemId ~= "" then
        itemId = itemId .. ","
      end
      itemId = itemId .. v
      if num == 0 then
        break
      end
    end
    num = nil
  else
    itemId = DataModel.Data.id
  end
  Net:SendProto("shop.recycle", function(json)
    UIManager:GoBack(false)
    CommonTips.OpenShowItem(json.reward)
    local factoryName = DataManager:GetFactoryNameById(DataModel.Data.id)
    if factoryName == "HomeFurnitureFactory" then
      local serverData = PlayerData:GetHomeInfo().furniture
      for k, v in pairs(saledRecord) do
        serverData[v] = nil
      end
    elseif factoryName == "PetFactory" then
      local serverData = PlayerData:GetHomeInfo().pet
      for k, v in pairs(saledRecord) do
        serverData[v] = nil
      end
    elseif factoryName == "HomeCreatureFactory" then
      local serverData = PlayerData:GetHomeInfo().creatures
      local serverNum = serverData[tostring(DataModel.Data.id)].num
      serverNum = serverNum - num
      serverData[tostring(DataModel.Data.id)].num = serverNum
    end
    View.self:Confirm()
  end, DataModel.Data.shopId, DataModel.Data.commodityId, itemId, DataModel.CurrentNum)
end

function Controller:Cancel()
  UIManager:GoBack(false)
end

return Controller
