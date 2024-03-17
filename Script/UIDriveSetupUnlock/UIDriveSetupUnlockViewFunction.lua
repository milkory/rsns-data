local View = require("UIDriveSetupUnlock/UIDriveSetupUnlockView")
local DataModel = require("UIDriveSetupUnlock/UIDriveSetupUnlockDataModel")
local CommonItem = require("Common/BtnItem")
local use = {}
local ViewFunction = {
  DriveSetupUnlock_Btn_BG_Click = function(btn, str)
    UIManager:GoBack()
  end,
  DriveSetupUnlock_Group_Cost_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  DriveSetupUnlock_Group_Cost_StaticGrid_Cost_SetGrid = function(element, elementIndex)
    local trainCfg = PlayerData:GetFactoryData(99900064)
    print_r("------------------------------")
    print_r(DataModel.Cost)
    if trainCfg[DataModel.Cost][tonumber(elementIndex)] then
      element.Group_Item:SetActive(true)
      element.Group_Cost:SetActive(true)
      local itemId = trainCfg[DataModel.Cost][tonumber(elementIndex)].id
      local itemNum = trainCfg[DataModel.Cost][tonumber(elementIndex)].num
      CommonItem:SetItem(element.Group_Item, {id = itemId}, EnumDefine.ItemType.Material)
      local haveItem = PlayerData:GetGoodsById(itemId)
      local haveNum = haveItem.num or 0
      if itemId == 11400001 then
        element.Group_Cost.Txt_Need:SetText(PlayerData:NumToFormatString(itemNum, 1))
        element.Group_Cost.Txt_Have:SetText(PlayerData:NumToFormatString(haveNum, 1))
      else
        element.Group_Cost.Txt_Need:SetText(itemNum)
        element.Group_Cost.Txt_Have:SetText(haveNum)
      end
      if itemNum <= haveNum then
        element.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
      else
        element.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
      end
      element.Group_Item.Btn_Item:SetClickParam(itemId)
      use[itemId] = itemNum
    else
      element.Group_Item:SetActive(false)
      element.Group_Cost:SetActive(false)
    end
  end,
  DriveSetupUnlock_Group_Cost_StaticGrid_Cost_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenRewardDetail(tonumber(str))
  end,
  DriveSetupUnlock_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack()
  end,
  DriveSetupUnlock_Btn_Confirm_Click = function(btn, str)
    Net:SendProto("home.unlock_drive_setup", function(json)
      UIManager:GoBack()
      PlayerData:RefreshUseItems(use)
      local mainController = require("UIMainUI/UIMainUIController")
      mainController:InitCommonShow()
    end, DataModel.SetUpType)
  end
}
return ViewFunction
