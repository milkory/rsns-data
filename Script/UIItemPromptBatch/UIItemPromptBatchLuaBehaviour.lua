local View = require("UIItemPromptBatch/UIItemPromptBatchView")
local DataModel = require("UIItemPromptBatch/UIItemPromptBatchDataModel")
local Controller = require("UIItemPromptBatch/UIItemPromptBatchController")
local CommonBtn = require("Common/BtnItem")
local ViewFunction = require("UIItemPromptBatch/UIItemPromptBatchViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.params)
  end,
  deserialize = function(initParams)
    DataModel.params = Json.decode(initParams)
    if DataModel.params.yesTxt then
      View.Btn_Confirm.Group_.Txt_Confirm:SetText(DataModel.params.yesTxt)
    end
    if DataModel.params.noTxt then
      View.Btn_Cancel.Group_.Txt_Cancel:SetText(DataModel.params.noTxt)
    end
    View.Txt_Des:SetText(DataModel.params.content)
    CommonBtn:SetItem(View.Group_Item, {
      id = DataModel.params.itemId
    })
    View.Group_Item.Btn_Item:SetClickParam(DataModel.params.itemId)
    View.Group_Need.Txt_Need:SetText(DataModel.params.useNum)
    View.Group_Need.Txt_Have:SetText(DataModel.params.itemNum)
    local color = UIConfig.Color.White
    if DataModel.params.itemNum < DataModel.params.useNum then
      color = UIConfig.Color.Red
    end
    View.Group_Need.Txt_Have:SetColor(color)
    local maxNum = DataModel.params.itemNum
    local itemCA = PlayerData:GetFactoryData(DataModel.params.itemId, "ItemFactory")
    if maxNum > itemCA.useLimitNum then
      maxNum = itemCA.useLimitNum
    end
    DataModel.params.maxNum = maxNum
    View.Group_SelectQuantity.Group_Slider.Group_Num.Txt_Possess:SetText(maxNum)
    View.Group_SelectQuantity.Group_Slider.Slider_Value:SetMinAndMaxValue(1, maxNum, true)
    View.Group_SelectQuantity.Group_Slider.Slider_Value:SetSliderValue(DataModel.params.useNum)
    Controller:RefreshNumShow()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
