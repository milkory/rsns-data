local DataModel = require("UISaleTips/UISaleTipsDataModel")
local View = require("UISaleTips/UISaleTipsView")
local Controller = {}
local SetItem = function(element, data, isDetail)
  data = data.factoryData
  local qualityInt = data.qualityInt + 1
  element.Img_Bottom:SetSprite(UIConfig.BottomConfig[qualityInt])
  element.Img_Item:SetSprite(data.iconPath)
  element.Img_Mask:SetSprite(UIConfig.MaskConfig[qualityInt])
  element.Img_Time:SetActive(false)
end

function Controller:OpenSaleTips(isOpen, data)
  if isOpen then
    data = data[1]
    DataModel.SaleData = data
    self.SetNumBtn(self, DataModel.EnumBtnType.Min)
    SetItem(View.Group_Item, data)
    View.Group_Slider.Slider_Value:SetMinAndMaxValue(1, data.server.num)
    if data.server.num == 1 then
      View.Group_Slider.Slider_Value:SetMinAndMaxValue(0, data.server.num)
    end
  else
    UIManager:GoBack(false, 1)
  end
end

function Controller:Sale()
  Net:SendProto("item.sell_items", function(json)
    PlayerData:RefreshUseItems({
      [DataModel.SaleData.id] = math.ceil(DataModel.currentNum)
    })
    CommonTips.OpenShowItem(json.reward, UIManager:GoBack())
  end, tostring(DataModel.SaleData.id), math.ceil(DataModel.currentNum))
end

local SetNum = function(maxNum)
  local num = DataModel.currentNum
  View.Group_Slider.Group_Num.Txt_Select:SetText(math.ceil(num))
  View.Group_Slider.Group_Num.Txt_Possess:SetText(maxNum)
  local price = num * DataModel.SaleData.factoryData.rewardList[1].num
  View.Group_Gold.Txt_Num:SetText(math.ceil(price))
end

function Controller:SetNumBtn(btnType)
  local maxNum = DataModel.SaleData.server.num
  local num = DataModel.currentNum
  if btnType == DataModel.EnumBtnType.Add then
    if maxNum > num then
      num = num + 1
    end
  elseif btnType == DataModel.EnumBtnType.Subtraction then
    if 1 < num then
      num = num - 1
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

function Controller:SetSlider(value)
  if DataModel.SaleData.server.num == 1 then
    return
  end
  DataModel.currentNum = value
  SetNum(DataModel.SaleData.server.num)
end

function Controller:OpenShowItem()
  local params = {
    itemId = DataModel.SaleData.id,
    type = EnumDefine.OpenTip.NoDepot
  }
  CommonTips.OpenItem(params)
end

return Controller
