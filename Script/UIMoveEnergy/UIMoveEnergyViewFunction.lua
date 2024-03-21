local Controller = require("UIMoveEnergy/UIMoveEnergyController")
local DataModel = require("UIMoveEnergy/UIMoveEnergyDataModel")
local View = require("UIMoveEnergy/UIMoveEnergyView")
local ViewFunction = {
  MoveEnergy_Btn_BG_Click = function(btn, str)
  end,
  MoveEnergy_Group_Page2_Group_Num_Btn_Min_Click = function(btn, str)
    Controller:SetUseNumMin()
  end,
  MoveEnergy_Group_Page2_Group_Num_Btn_Dec_Click = function(btn, str)
    Controller:ChangeUseNum(-1)
  end,
  MoveEnergy_Group_Page2_Group_Num_Group_Slider_Slider_Value_Slider = function(slider, value)
    if Controller._isSliderChanging ~= true then
      Controller:ChangeUseNumByPercent(value)
    end
  end,
  MoveEnergy_Group_Page2_Group_Num_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  MoveEnergy_Group_Page2_Group_Num_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  MoveEnergy_Group_Page2_Group_Num_Btn_Add_Click = function(btn, str)
    Controller:ChangeUseNum(1)
  end,
  MoveEnergy_Group_Page2_Group_Num_Btn_Max_Click = function(btn, str)
    Controller:SetUseNumMax()
  end,
  MoveEnergy_Group_Page2_Btn_Cancel_Click = function(btn, str)
    Controller:SetNumPage(false)
  end,
  MoveEnergy_Group_Page2_Btn_Sale_Click = function(btn, str)
    Controller:TryUseItem()
  end,
  MoveEnergy_Img_BG_Group_Pick_Group_UseItem_Group_Item_Img_Mask_Btn_Access_Click = function(btn, str)
  end,
  MoveEnergy_Img_BG_Group_Pick_StaticGrid__SetGrid = function(element, elementIndex)
    local data = DataModel.itemList[elementIndex]
    local isEnough, itemCnt = Controller:isItemEnough(elementIndex)
    element.Group_Item:SetActive(false)
    element.Group_Diamond:SetActive(false)
    if data.id == 11400005 then
      element.Group_Diamond:SetActive(true)
      element.Group_Diamond.Img_Item:SetSprite(data.iconPath)
      element.Group_Diamond.Img_Title.Txt_:SetText(data.name)
      element.Group_Diamond.Group_HomeEnergy.Txt_Num:SetText(-data.energy)
      element.Group_Diamond.Btn_:SetClickParam(elementIndex)
      element.Group_Diamond.Img_Limited.Txt_:SetText(string.format(GetText(80601878), DataModel.maxDiamondUseNum, DataModel.allDiamondUseNum))
    else
      element.Group_Item:SetActive(true)
      element.Group_Item.Img_Item:SetSprite(data.iconPath)
      element.Group_Item.Img_Title.Txt_:SetText(data.name)
      element.Group_Item.Txt_Num:SetText(itemCnt)
      element.Group_Item.Img_Mask:SetActive(not isEnough)
      if data.energy == 9999 then
        element.Group_Item.Group_HomeEnergy.Txt_Num:SetActive(false)
        element.Group_Item.Group_HomeEnergy.Txt_Max:SetActive(true)
      else
        element.Group_Item.Group_HomeEnergy.Txt_Num:SetActive(true)
        element.Group_Item.Group_HomeEnergy.Txt_Max:SetActive(false)
        element.Group_Item.Group_HomeEnergy.Txt_Num:SetText(-data.energy)
      end
      element.Group_Item.Img_Mask.Btn_Access:SetClickParam(elementIndex)
      element.Group_Item.Btn_:SetClickParam(elementIndex)
      element.Group_Item.Btn_:SetActive(isEnough)
      local itemCa = PlayerData:GetFactoryData(data.id)
      element.Group_Item.Img_TimeLeft:SetActive(false)
      if itemCa.limitedTime > 0 and 0 < itemCnt then
        element.Group_Item.Img_TimeLeft:SetActive(true)
        local item = DataModel.GetLastLimitTimeItem(data.id)
        local curTime = TimeUtil:GetServerTimeStamp()
        local remainTime = item.dead_line - curTime
        element.Group_Item.Img_TimeLeft.Txt_:SetText(string.format(GetText(80601976), math.ceil(remainTime / 86400)))
      end
    end
  end,
  MoveEnergy_Img_BG_Group_Pick_StaticGrid__Group_UseItem_Group_Item_Img_Mask_Btn_Access_Click = function(btn, str)
    Controller:OpenGetWay(tonumber(str))
  end,
  MoveEnergy_Img_BG_Group_Pick_Group_BarStore_Btn_Use_Click = function(btn, str)
    local info = DataModel.restAreaInfo
    local t = {}
    t.stationId = DataModel.StationId
    t.npcId = info.npcId
    t.bgPath = info.bgPath
    t.bgColor = info.bgColor
    t.isCityMapIn = true
    t.name = info.name
    t.buildingId = info.buildingId
    t.textId = info.textId
    UIManager:Open(info.uiPath, Json.encode(t))
  end,
  MoveEnergy_Img_BG_Group_Pick_Group_BarStore_Btn_NotUse_Click = function(btn, str)
  end,
  MoveEnergy_Img_BG_Group_Pick_Group_BarStore_Btn_Tip_Click = function(btn, str)
    local group_BarStore = View.Img_BG.Group_Pick.Group_BarStore
    if group_BarStore.Img_Tip.self.IsActive then
      group_BarStore.Img_Tip:SetActive(false)
    else
      group_BarStore.Img_Tip:SetActive(true)
      group_BarStore.Img_Tip.ScrollGrid_.grid.self:SetDataCount(#DataModel.restList)
      group_BarStore.Img_Tip.ScrollGrid_.grid.self:RefreshAllElement()
      group_BarStore.Img_Tip.ScrollGrid_.grid.self:MoveToTop()
      local itemNum = PlayerData:GetGoodsById(85000002).num
      group_BarStore.Img_Tip.Txt_NumYinzhi:SetText(string.format("%d/%d", itemNum, 1))
    end
  end,
  MoveEnergy_Img_BG_Group_Pick_Group_BarStore_Img_Tip_ScrollGrid__SetGrid = function(element, elementIndex)
    local info = DataModel.restList[elementIndex]
    element.Group_Provided:SetActive(info.status == 1)
    element.Group_NotProvided:SetActive(info.status == -1)
    if info.status == 1 then
      element.Group_Provided.Txt_:SetText(info.cityName)
    else
      element.Group_NotProvided.Txt_:SetText(info.cityName)
    end
  end,
  MoveEnergy_Img_BG_Group_Pick_Group_HomeFood_Btn_Use_Click = function(btn, str)
    UIManager:Open("UI/HomeFurniture/HomeFood", Json.encode({isOutside = true}))
  end,
  MoveEnergy_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  MoveEnergy_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  MoveEnergy_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  MoveEnergy_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  MoveEnergy_Img_BG_Group_Pick_Group_UseItem_Group_Item_Btn__Click = function(btn, str)
  end,
  MoveEnergy_Img_BG_Group_Pick_Group_UseItem_Group_Diamond_Btn__Click = function(btn, str)
  end,
  MoveEnergy_Img_BG_Group_Pick_StaticGrid__Group_UseItem_Group_Item_Btn__Click = function(btn, str)
    Controller:SelectItem(tonumber(str))
  end,
  MoveEnergy_Img_BG_Group_Pick_StaticGrid__Group_UseItem_Group_Diamond_Btn__Click = function(btn, str)
    Controller:SelectItem(tonumber(str))
  end,
  MoveEnergy_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end,
  MoveEnergy_Group_Page1_Btn_UseItem_Click = function(btn, str)
    Controller:SelectItem(1)
  end,
  MoveEnergy_Group_Page1_Btn_UseItem_Btn_Access_Click = function(btn, str)
    Controller:OpenGetWay(1)
  end,
  MoveEnergy_Group_Page1_Btn_UseMoney_Click = function(btn, str)
    Controller:SelectItem(2)
  end,
  MoveEnergy_Group_Page1_Btn_Close_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  MoveEnergy_Group_Page1_Btn_Sure_Click = function(btn, str)
    Controller:SetNumPage(true)
  end,
  MoveEnergy_Img_BG_Group_Pick_Group_HomeFood_Btn_Tip_Click = function(btn, str)
  end
}
return ViewFunction
