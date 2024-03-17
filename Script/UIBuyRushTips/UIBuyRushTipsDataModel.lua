local DataModel = {}
local View = require("UIBuyRushTips/UIBuyRushTipsView")
DataModel.EnumBtnType = {
  Add = 1,
  Subtraction = 2,
  Max = 3,
  Min = 4
}

function DataModel:SetNum(maxNum)
  local num = DataModel.currentNum
  View.Group_Slider.Group_Num.Txt_Select:SetText(math.ceil(num))
  View.Group_Slider.Group_Num.Txt_Possess:SetText(maxNum)
  local moneyNum = DataModel.CostItem[1] and DataModel.CostItem[1].num or 0
  local price = num * moneyNum
  DataModel.Price = price
  View.Group_Gold.Txt_Num:SetText(math.ceil(price))
  local icon = PlayerData:GetFactoryData(DataModel.CostItem[1].id).buyPath
  if icon == "" or icon == nil then
    View.Group_Gold.Img_:SetActive(false)
  else
    View.Group_Gold.Img_:SetActive(true)
    View.Group_Gold.Img_:SetSprite(icon)
  end
end

function DataModel:SetNumBtn(btnType)
  local maxNum = DataModel.maxNum
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
  self:SetNum(maxNum)
  View.Group_Slider.Slider_Value:SetSliderValue(num)
end

function DataModel:SetSlider(value)
  if DataModel.maxNum == 1 then
    return
  end
  DataModel.currentNum = value
  self:SetNum(DataModel.maxNum)
end

return DataModel
