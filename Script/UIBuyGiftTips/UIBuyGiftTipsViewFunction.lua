local CommonItem = require("Common/BtnItem")
local View = require("UIBuyGiftTips/UIBuyGiftTipsView")
local DataModel = require("UIBuyGiftTips/UIBuyGiftTipsDataModel")
local ViewFunction = {
  BuyGiftTips_Btn_BG_Click = function(btn, str)
    View.self:CloseUI()
    if DataModel.Data.isMoveEnergyOpen then
      UIManager:GoBack()
    end
  end,
  BuyGiftTips_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local rewardList = DataModel.Data.commoditData.rewardList
    local row = rewardList[tonumber(elementIndex)]
    local ca = PlayerData:GetFactoryData(row.id)
    local num = row.num
    CommonItem:SetItem(element.Group_Item, row)
    if ca.SkinName then
      element.Txt_Name:SetText(ca.SkinName)
    else
      element.Txt_Name:SetText(ca.name)
    end
    element.Group_1.Txt_Num:SetText(num)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
  end,
  BuyGiftTips_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local rewardList = DataModel.Data.commoditData.rewardList
    local row = rewardList[tonumber(str)]
    CommonTips.OpenPreRewardDetailTips(row.id)
  end,
  BuyGiftTips_Btn_Cancel_Click = function(btn, str)
    View.self:CloseUI()
    if DataModel.Data.isMoveEnergyOpen then
      UIManager:GoBack()
    end
  end,
  BuyGiftTips_Btn_Sale_Click = function(btn, str)
    View.self:CloseUI()
    if DataModel.isEnough == false then
      CommonTips.OpenTips(80601070)
      local callback = function()
        CommonTips.OpenStoreBuy()
      end
      CommonTips.OnPrompt(80600147, nil, nil, callback)
      return
    end
    View.self:Confirm()
  end,
  BuyGiftTips_Group_Moon_Group_List_Group_Item1_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel.OpenRewardDetail(1)
  end,
  BuyGiftTips_Group_Moon_Group_List_Group_Item2_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel.OpenRewardDetail(2)
  end,
  BuyGiftTips_Group_Moon_Group_List_Group_Item3_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel.OpenRewardDetail(3)
  end,
  BuyGiftTips_Group_Moon_Group_List_Group_Item4_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  BuyGiftTips_Group_Moon_ScrollView_List_Viewport_Content_Group_Item1_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel.OpenRewardDetail(1)
  end,
  BuyGiftTips_Group_Moon_ScrollView_List_Viewport_Content_Group_Item2_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel.OpenRewardDetail(2)
  end,
  BuyGiftTips_Group_Moon_ScrollView_List_Viewport_Content_Group_Item3_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel.OpenRewardDetail(3)
  end,
  BuyGiftTips_Group_Moon_ScrollView_List_Viewport_Content_Group_Item4_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel.OpenRewardDetail(4)
  end
}
return ViewFunction
