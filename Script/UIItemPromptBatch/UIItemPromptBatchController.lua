local View = require("UIItemPromptBatch/UIItemPromptBatchView")
local DataModel = require("UIItemPromptBatch/UIItemPromptBatchDataModel")
local Controller = {}

function Controller:SetNum(num)
  if num > DataModel.params.maxNum then
    num = DataModel.params.maxNum
  end
  if num < 1 then
    num = 1
  end
  DataModel.params.useNum = num
  View.Group_SelectQuantity.Group_Slider.Slider_Value:SetSliderValue(DataModel.params.useNum)
  Controller:RefreshNumShow()
end

function Controller:MinNum()
  DataModel.params.useNum = 1
  View.Group_SelectQuantity.Group_Slider.Slider_Value:SetSliderValue(DataModel.params.useNum)
  Controller:RefreshNumShow()
end

function Controller:MaxNum()
  DataModel.params.useNum = DataModel.params.maxNum
  View.Group_SelectQuantity.Group_Slider.Slider_Value:SetSliderValue(DataModel.params.useNum)
  Controller:RefreshNumShow()
end

function Controller:RefreshNumShow()
  View.Group_SelectQuantity.Group_Slider.Group_Num.Txt_Select:SetText(DataModel.params.useNum)
end

return Controller
