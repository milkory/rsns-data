local View = require("UIItemPromptBatch/UIItemPromptBatchView")
local DataModel = require("UIItemPromptBatch/UIItemPromptBatchDataModel")
local Controller = require("UIItemPromptBatch/UIItemPromptBatchController")
local ViewFunction = {
  ItemPromptBatch_Btn_Confirm_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    PlayerData.TempCache.ItemPromptBatchNum = DataModel.params.useNum
    View.self:Confirm()
  end,
  ItemPromptBatch_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    View.self:Cancel()
  end,
  ItemPromptBatch_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenPreItemTips({itemId = itemId})
  end,
  ItemPromptBatch_Group_SelectQuantity_Btn_Min_Click = function(btn, str)
    Controller:MinNum()
  end,
  ItemPromptBatch_Group_SelectQuantity_Btn_Dec_Click = function(btn, str)
    Controller:SetNum(DataModel.params.useNum - 1)
  end,
  ItemPromptBatch_Group_SelectQuantity_Group_Slider_Slider_Value_Slider = function(slider, value)
    Controller:SetNum(math.floor(tonumber(value) + 0.5))
  end,
  ItemPromptBatch_Group_SelectQuantity_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  ItemPromptBatch_Group_SelectQuantity_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  ItemPromptBatch_Group_SelectQuantity_Btn_Add_Click = function(btn, str)
    Controller:SetNum(DataModel.params.useNum + 1)
  end,
  ItemPromptBatch_Group_SelectQuantity_Btn_Max_Click = function(btn, str)
    Controller:MaxNum()
  end
}
return ViewFunction
