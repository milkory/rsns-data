local View = require("UIStationSaleTips/UIStationSaleTipsView")
local DataModel = require("UIStationSaleTips/UIStationSaleTipsDataModel")
local ViewFunction = {
  StationSaleTips_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  StationSaleTips_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  StationSaleTips_Btn_Min_Click = function(btn, str)
    DataModel:SetSelectNum(1)
  end,
  StationSaleTips_Btn_Dec_Click = function(btn, str)
    DataModel:SetSelectNum(math.max(1, DataModel.curSelectNum - 1))
  end,
  StationSaleTips_Group_Slider_Slider_Value_Slider = function(slider, value)
    DataModel:OnSliderValue(value)
  end,
  StationSaleTips_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  StationSaleTips_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  StationSaleTips_Btn_Add_Click = function(btn, str)
    DataModel:SetSelectNum(math.max(1, math.min(DataModel.maxNum, DataModel.curSelectNum + 1)))
  end,
  StationSaleTips_Btn_Max_Click = function(btn, str)
    DataModel:SetSelectNum(math.max(1, DataModel.maxNum))
  end,
  StationSaleTips_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  StationSaleTips_Btn_Sale_Click = function(btn, str)
    if DataModel.curSelectNum <= DataModel.maxNum then
      Net:SendProto("item.recycle_material", function(json)
        PlayerData:RefreshUseItems({
          [DataModel.itemCA.id] = DataModel.curSelectNum
        })
        UIManager:GoBack(false, 1)
        View.self:Confirm()
        CommonTips.OpenShowItem(json.reward)
      end, DataModel.itemCA.id .. ":" .. DataModel.curSelectNum)
    end
  end
}
return ViewFunction
