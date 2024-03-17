local View = require("UIHomeCapsule/UIHomeCapsuleView")
local DataModel = require("UIHomeCapsule/UIHomeCapsuleDataModel")
local Controller = require("UIHomeCapsule/UIHomeCapsuleController")
local HomeStoreDataModel = require("UIHomeCapsule/UIHomeStoreDataModel")
local HomeStoreController = require("UIHomeCapsule/UIHomeStoreController")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  HomeCapsule_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  HomeCapsule_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  HomeCapsule_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomeCapsule_Group_JYB_Btn_Buy_Click = function(btn, str)
  end,
  HomeCapsule_Group_ND_Group_Pay_Group_One_Btn_1_Click = function(btn, str)
    Controller:OnePick()
  end,
  HomeCapsule_Group_ND_Group_Pay_Group_One1_Btn_1_Click = function(btn, str)
    Controller:OnePick()
  end,
  HomeCapsule_Group_ND_Group_Pay_Group_Ten_Btn_1_Click = function(btn, str)
    Controller:TenPick()
  end,
  HomeCapsule_Group_ND_Group_BQ_Group_1_Group_CZ_Btn__Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectPond(idx)
  end,
  HomeCapsule_Group_ND_Group_BQ_Group_1_Group_XS_Btn__Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectPond(idx)
  end,
  HomeCapsule_Group_ND_Group_BQ_Group_2_Group_CZ_Btn__Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectPond(idx)
  end,
  HomeCapsule_Group_ND_Group_BQ_Group_2_Group_XS_Btn__Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectPond(idx)
  end,
  HomeCapsule_Group_ND_Group_BQ_Group_3_Group_CZ_Btn__Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectPond(idx)
  end,
  HomeCapsule_Group_ND_Group_BQ_Group_3_Group_XS_Btn__Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectPond(idx)
  end,
  HomeCapsule_Group_ND_Group_BQ_Group_4_Group_CZ_Btn__Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectPond(idx)
  end,
  HomeCapsule_Group_ND_Group_BQ_Group_4_Group_XS_Btn__Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectPond(idx)
  end,
  HomeCapsule_Group_ND_Group_BQ_Group_5_Group_CZ_Btn__Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectPond(idx)
  end,
  HomeCapsule_Group_ND_Group_BQ_Group_5_Group_XS_Btn__Click = function(btn, str)
    local idx = tonumber(str)
    Controller:SelectPond(idx)
  end,
  HomeCapsule_Group_ND_Group_ZT_ScrollGrid_PrizeList_SetGrid = function(element, elementIndex)
    local data = DataModel.pondInfo[DataModel.curSelectIdx].capsuleList[elementIndex]
    element.Group_Item.Btn_Item:SetClickParam(data.id)
    element.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.qualityInt])
    element.Group_Item.Img_Item:SetSprite(data.imagePath)
    element.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[data.qualityInt])
    element.Img_1:SetActive(data.limitNum ~= -1)
    element.Txt_ResidueNum:SetActive(data.limitNum ~= -1)
    if data.limitNum ~= -1 then
      element.Txt_ResidueNum:SetText(string.format(GetText(80600363), data.remainCount))
    end
    element.Group_Item.Txt_Num:SetText(data.num)
    element.Img_Empty.self:SetActive(data.limitNum ~= -1 and data.remainCount == 0)
  end,
  HomeCapsule_Group_ND_Group_ZT_ScrollGrid_PrizeList_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    local param = {}
    param.itemId = itemId
    CommonTips.OpenItem(param)
  end,
  HomeCapsule_Group_ND_Group_ZT_Btn_Tips_Click = function(btn, str)
    local data = DataModel.pondInfo[DataModel.curSelectIdx]
    if data ~= nil then
      View.Group_ND.Group_Details.self:SetActive(true)
      View.Group_ND.Group_Details.Txt_Details:SetText(data.ca.details)
    end
  end,
  HomeCapsule_Group_ND_Group_Details_Btn_Close_Click = function(btn, str)
    View.Group_ND.Group_Details.self:SetActive(false)
  end,
  HomeCapsule_Group_YN_Btn_Buy_Click = function(btn, str)
  end,
  HomeCapsule_Group_HomeStore_Group_FurnitureStore_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local idx = tonumber(elementIndex)
    element.Btn_1:SetClickParam(idx)
    local row = HomeStoreDataModel.Now_List.shopFactory.shopList[idx]
    local data = PlayerData:GetFactoryData(row.id)
    element.Txt_Name:SetText(data.commodityName)
    element.Img_Item:SetSprite(data.commodityView)
    local qualityInt = data.qualityInt
    element.Img_Quality:SetSprite(UIConfig.HomeStoreQuality[qualityInt + 1])
    if HomeStoreDataModel.Now_List.server then
      for k, v in pairs(HomeStoreDataModel.Now_List.server.items) do
        if tonumber(v.id) == tonumber(row.id) then
          row.py_cnt = v.py_cnt
        end
      end
    end
    local purchase = data.purchase
    if purchase == true then
      row.residue = data.purchaseNum - (row.py_cnt or 0)
      if row.residue < 0 then
        row.residue = 0
      end
      element.Group_SY.self:SetActive(true)
      element.Group_SY.Txt_Num:SetText(string.format(GetText(row.residue), row.residue))
      if row.residue == 0 then
        element.Img_ShouWan.self:SetActive(true)
      else
        element.Img_ShouWan.self:SetActive(false)
      end
    else
      row.residue = 100
      element.Group_SY.self:SetActive(false)
      element.Img_ShouWan.self:SetActive(false)
    end
    row.storeType = HomeStoreDataModel.Now_List.shopFactory.storeType
    local money = data.moneyList[1]
    if money then
      element.Img_Money:SetActive(true)
      local left_money = PlayerData:GetFactoryData(tonumber(data.moneyList[1].moneyID))
      element.Img_Money.self:SetSprite(left_money.buyPath)
      element.Img_Money.Txt_MoneyNum:SetText(data.moneyList[1].moneyNum)
    else
      element.Btn_Item.Img_Money:SetActive(false)
    end
    element.Img_Time.self:SetActive(false)
  end,
  HomeCapsule_Group_HomeStore_Group_FurnitureStore_ScrollGrid_List_Group_Item_Btn_1_Click = function(btn, str)
    local row = HomeStoreDataModel.Now_List.shopFactory.shopList[tonumber(str)]
    if row.residue == 0 then
      CommonTips.OpenTips(80600077)
      return
    end
    row.commoditData = PlayerData:GetFactoryData(row.id)
    row.index = tonumber(str) - 1
    row.shopid = HomeStoreDataModel.ShopId
    row.name = row.commoditData.commodityName
    row.image = row.commoditData.commodityView
    row.qualityInt = row.commoditData.qualityInt + 1
    CommonTips.OpenBuyTips(row, function(cnt)
      local CoachDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
      CoachDataModel.ResetFurnitureTypeData()
      Controller:RefreshCoin()
    end)
  end,
  HomeCapsule_Group_HomeStore_Group_Right_StaticGrid_BQ_SetGrid = function(element, elementIndex)
    element.Btn_Click:SetClickParam(elementIndex)
    element.Group_Weixuanzhong.self:SetActive(elementIndex ~= HomeStoreDataModel.curIndex)
    local isShow = elementIndex <= #HomeStoreDataModel.List
    element.self:SetActive(isShow)
    if isShow then
      local shopId = HomeStoreDataModel.List[elementIndex].shopid
      local storeConfig = PlayerData:GetFactoryData(shopId, "StoreFactory")
      element.Group_Xuanzhong.Txt_Name:SetText(storeConfig.storeName)
      element.Group_Xuanzhong.Img_Xuanzhong:SetSprite(storeConfig.pngSelect)
      element.Group_Weixuanzhong.Txt_Name:SetText(storeConfig.storeName)
      element.Group_Weixuanzhong.Img_Weixuanzhong:SetSprite(storeConfig.pngNotSelect)
    end
  end,
  HomeCapsule_Group_Zhu_Group_niudan_Btn_niudan_Click = function(btn, str)
    Controller:ChangeToView(1)
  end,
  HomeCapsule_Group_Zhu_Btn_shangdian_Click = function(btn, str)
    Controller:ChangeToView(2)
  end,
  HomeCapsule_Group_HomeStore_Group_Right_StaticGrid_BQ_Group_BQ_Btn_Click_Click = function(btn, str)
    local idx = tonumber(str)
    HomeStoreDataModel.curIndex = idx
    HomeStoreController:ChooseTab(idx)
    View.Group_HomeStore.Group_Right.StaticGrid_BQ.grid.self:RefreshAllElement()
  end
}
return ViewFunction
