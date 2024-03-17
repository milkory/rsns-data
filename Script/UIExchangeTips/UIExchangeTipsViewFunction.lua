local View = require("UIExchangeTips/UIExchangeTipsView")
local DataModel = require("UIExchangeTips/UIExchangeTipsDataModel")
local ViewFunction = {
  ExchangeTips_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  ExchangeTips_Group_Exchange_Group_Item1_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  ExchangeTips_Group_Exchange_Group_Item2_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  ExchangeTips_Group_Exchange_Group_Item3_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  ExchangeTips_Group_Exchange_Group_ExchangeItem_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  ExchangeTips_Btn_Min_Click = function(btn, str)
    DataModel:SetSelectNum(1)
  end,
  ExchangeTips_Btn_Dec_Click = function(btn, str)
    DataModel:SetSelectNum(math.max(1, DataModel.curSelectNum - 1))
  end,
  ExchangeTips_Group_Slider_Slider_Value_Slider = function(slider, value)
    DataModel:OnSliderValue(value)
  end,
  ExchangeTips_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  ExchangeTips_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  ExchangeTips_Btn_Add_Click = function(btn, str)
    DataModel:SetSelectNum(math.max(1, math.min(DataModel.maxNum, DataModel.curSelectNum + 1)))
  end,
  ExchangeTips_Btn_Max_Click = function(btn, str)
    DataModel:SetSelectNum(math.max(1, DataModel.maxNum))
  end,
  ExchangeTips_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  ExchangeTips_Btn_Sale_Click = function(btn, str)
    if DataModel.curSelectNum <= DataModel.maxNum then
      local facName = DataManager:GetFactoryNameById(DataModel.commodityCA.commodityItemList[1].id)
      local maxNum = PlayerData:GetUserInfo().space_info.max_food_material_num or 0
      local nowNum = PlayerData:GetUserInfo().space_info.now_food_material_num or 0
      if facName == "FridgeItemFactory" and maxNum <= nowNum then
        CommonTips.OpenTips(80602172)
        return
      end
      Net:SendProto("shop.buy", function(json)
        local cost = DataModel.cost
        PlayerData:RefreshUseItems(cost)
        View.self:Confirm()
        UIManager:GoBack(false, 1)
        CommonTips.OpenShowItem(json.reward)
      end, DataModel.shopId, DataModel.index, DataModel.curSelectNum, DataModel.commodityCA.id)
    end
  end,
  ExchangeTips_Group_Exchange_Group_Item4_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  ExchangeTips_Group_Exchange_Group_Item5_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  ExchangeTips_Group_Exchange_Group_Item6_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end
}
return ViewFunction
