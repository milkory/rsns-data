local View = require("UIHomePetStore/UIHomePetStoreView")
local DataModel = require("UIHomePetStore/UIHomePetStoreDataModel")
local Controller = require("UIHomePetStore/UIHomePetStoreController")
local ViewFunction = {
  HomePetStore_Group_Main_Btn_Buy_Click = function(btn, str)
    Controller:ClickTrade()
  end,
  HomePetStore_Group_Main_Btn_Talk_Click = function(btn, str)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end,
  HomePetStore_Group_Store_Group_Tab_Btn_Buy_Click = function(btn, str)
    Controller:SelectTab(DataModel.TradeType.Buy, DataModel.CurTabType)
  end,
  HomePetStore_Group_Store_Group_Tab_Btn_Sell_Click = function(btn, str)
    Controller:SelectTab(DataModel.TradeType.Sale, DataModel.CurTabType)
  end,
  HomePetStore_Group_Store_Group_Resources_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_Pet_Group_Pet1_Group_Price_Btn_Money_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ConfirmBuyPet(idx)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_Pet_Group_Pet1_Btn_Pet_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickPetItem(idx)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_Pet_Group_Pet2_Group_Price_Btn_Money_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ConfirmBuyPet(idx)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_Pet_Group_Pet2_Btn_Pet_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickPetItem(idx)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_Pet_Group_Pet3_Group_Price_Btn_Money_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ConfirmBuyPet(idx)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_Pet_Group_Pet3_Btn_Pet_Click = function(btn, str)
    local idx = tonumber(str)
    Controller:ClickPetItem(idx)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_PlantByeForNow_ScrollGrid_List_SetGrid = function(element, elementIndex)
  end,
  HomePetStore_Group_Store_Group_NpcInfoL_Btn_Refresh_Click = function(btn, str)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_General_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:RefreshGeneralBuyShow(element, elementIndex)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_General_ScrollGrid_List_Group_Item_Btn_1_Click = function(btn, str)
    Controller:GeneralBuyClickItem(str)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_General_Group_Time_Img_1_Btn__Click = function(btn, str)
  end,
  HomePetStore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_Store.self.IsActive then
      Controller:ReturnToMain()
      return
    end
    UIManager:GoBack()
  end,
  HomePetStore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  HomePetStore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80300364}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  HomePetStore_Group_Store_Group_Sell_Group_General_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:RefreshGeneralSaleShow(element, elementIndex)
  end,
  HomePetStore_Group_Store_Group_Sell_Group_General_ScrollGrid_List_Group_Item_Btn_1_Click = function(btn, str)
    Controller:GeneralSaleClickItem(str)
  end,
  HomePetStore_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomePetStore_Group_Store_Group_StoreTab_Btn_Pet_Click = function(btn, str)
    Controller:SelectTab(DataModel.CurTradeType, DataModel.TabType.Pet)
  end,
  HomePetStore_Group_Store_Group_StoreTab_Btn_Plant_Click = function(btn, str)
    Controller:SelectTab(DataModel.CurTradeType, DataModel.TabType.Plant)
  end,
  HomePetStore_Group_Store_Group_StoreTab_Btn_Fish_Click = function(btn, str)
    Controller:SelectTab(DataModel.CurTradeType, DataModel.TabType.Fish)
  end,
  HomePetStore_Group_Store_Group_StoreTab_Btn_PetStuff_Click = function(btn, str)
    Controller:SelectTab(DataModel.CurTradeType, DataModel.TabType.PetStuff)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_Pet_Group_InputName_Group_BG_Btn_Close_Click = function(btn, str)
    View.Group_Store.Group_Buy.Group_Pet.Group_InputName.self:SetActive(false)
  end,
  HomePetStore_Group_Store_Group_Buy_Group_Pet_Group_InputName_Group_BG_Btn_Confirm_Click = function(btn, str)
    Controller:ConfirmReNamePet()
  end,
  HomePetStore_Group_Store_Group_Buy_Group_Pet_Group_InputName_Group_BG_Btn_Cancel_Click = function(btn, str)
    View.Group_Store.Group_Buy.Group_Pet.Group_InputName.self:SetActive(false)
  end
}
return ViewFunction
