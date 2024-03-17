local View = require("UIConvertTips/UIConvertTipsView")
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
local SetItem = function(element, data, isDetail)
  element.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.Data.qualityInt + 1])
  element.Img_Item:SetSprite(data.Data.iconPath)
  element.Img_Mask:SetSprite(UIConfig.MaskConfig[data.Data.qualityInt + 1])
  element.Img_Time:SetActive(false)
end

function DataModel:OpenBuyTips(isOpen, data)
  if isOpen then
    DataModel.CommoditData = data
    self.SetNumBtn(self, DataModel.EnumBtnType.Min)
    SetItem(View.Group_Item, data)
    View.Group_Slider.Slider_Value:SetMinAndMaxValue(1, data.ItemInfo.num)
    if data.ItemInfo.num == 1 then
      View.Group_Slider.Slider_Value:SetMinAndMaxValue(0, data.ItemInfo.num)
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
  local price = DataModel.CommoditData.Data.breakItemList[1] and DataModel.CommoditData.Data.breakItemList[1].num or 1
  local price_item = DataModel.CommoditData.Data.breakItemList[1] and PlayerData:GetFactoryData(DataModel.CommoditData.Data.breakItemList[1].id)
  local Price_Num = price * num
  View.Group_Gold.Txt_Num:SetText(math.ceil(Price_Num))
  if price_item then
    View.Group_Gold.Img_:SetSprite(price_item.iconPath)
  end
  View.Group_Slider.Group_Num.Txt_Possess:SetText(DataModel.CommoditData.ItemInfo.num)
end

function DataModel:SetNumBtn(btnType)
  local maxNum = DataModel.CommoditData.ItemInfo.num
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
  if DataModel.CommoditData.ItemInfo.num == 1 then
    return
  end
  DataModel.currentNum = value
  SetNum(DataModel.CommoditData.ItemInfo.num)
end

function DataModel:Recycled()
  Net:SendProto("item.recycled", function(json)
    PlayerData:RefreshUseItems({
      [DataModel.CommoditData.Data.id] = math.ceil(DataModel.currentNum)
    })
    CommonTips.OpenShowItem(json.reward, UIManager:GoBack())
  end, DataModel.CommoditData.Data.id, DataModel.currentNum)
end

return DataModel
