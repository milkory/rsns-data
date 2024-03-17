local View = require("UIBuyRushTips/UIBuyRushTipsView")
local DataModel = require("UIBuyRushTips/UIBuyRushTipsDataModel")
local ViewFunction = {
  BuyRushTips_Btn_BG_Click = function(btn, str)
    UIManager:CloseTip("UI/Common/BuyRushTips")
  end,
  BuyRushTips_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  BuyRushTips_Btn_Min_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Min)
  end,
  BuyRushTips_Btn_Dec_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Subtraction)
  end,
  BuyRushTips_Group_Slider_Slider_Value_Slider = function(slider, value)
    DataModel:SetSlider(tonumber(value))
  end,
  BuyRushTips_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  BuyRushTips_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  BuyRushTips_Btn_Add_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Add)
  end,
  BuyRushTips_Btn_Max_Click = function(btn, str)
    DataModel:SetNumBtn(DataModel.EnumBtnType.Max)
  end,
  BuyRushTips_Btn_Cancel_Click = function(btn, str)
    UIManager:CloseTip("UI/Common/BuyRushTips")
  end,
  BuyRushTips_Btn_Sale_Click = function(btn, str)
    local have = PlayerData:GetGoodsById(DataModel.CostItem[1].id).num
    if have >= DataModel.Price then
      Net:SendProto("home.refuel", function(json)
        View.Group_Item.Txt_Num:SetText(PlayerData:GetHomeInfo().readiness.fuel.fuel_num)
        local mainController = require("UIMainUI/UIMainUIController")
        mainController.SetSpeedAddShow()
        mainController:InitCommonShow()
        local MapController = require("UIHome/UIHomeMapController")
        MapController:RefreshAcceNum()
        UIManager:CloseTip("UI/Common/BuyRushTips")
      end, tostring(math.ceil(DataModel.currentNum)))
    else
      CommonTips.OpenTips(GetText(80600539))
    end
  end,
  BuyRushTips_Group_Tip_Btn_Tip_Click = function(btn, str)
    PlayerData:SetAutoAddRush()
    View.Group_Tip.Btn_Tip.Group_On.self:SetActive(PlayerData:GetPlayerPrefs("int", "IsAutoAddRush") == 1)
  end
}
return ViewFunction
