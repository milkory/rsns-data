local View = require("UIHomeElectric/UIHomeElectricView")
local DataModel = require("UIHomeElectric/UIHomeElectricDataModel")
local Controller = require("UIHomeElectric/UIHomeElectricController")
local ViewFunction = {
  HomeElectric_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  HomeElectric_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  HomeElectric_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomeElectric_Group_DL_Btn_UpGrade_Click = function(btn, str)
    Controller:RefreshElectricUpPanel()
  end,
  HomeElectric_Group_DL_Btn_NotUpGrade_Click = function(btn, str)
  end,
  HomeElectric_Group_CC_Btn_Install_Click = function(btn, str)
    Controller:RefreshElectricBuyPanel()
  end,
  HomeElectric_Group_CC_Btn_NotInstall_Click = function(btn, str)
  end,
  HomeElectric_Group_ElectricUp_Btn_Close_Click = function(btn, str)
    View.Group_ElectricUp.self:SetActive(false)
  end,
  HomeElectric_Group_ElectricUp_Btn_Cancel_Click = function(btn, str)
    View.Group_ElectricUp.self:SetActive(false)
  end,
  HomeElectric_Group_ElectricUp_Btn_LevelUp_Click = function(btn, str)
    local electricConfig = PlayerData:GetFactoryData(99900023, "HomeElectricConfig")
    local info = electricConfig.electricList[DataModel.curLv]
    local costList = PlayerData:GetFactoryData(info.id, "ListFactory").electricMaterialList
    local tempT = {}
    for k, v in pairs(costList) do
      local id = v.id
      if PlayerData:GetGoodsById(id).num < v.num then
        CommonTips.OpenTips(80600332)
        return
      end
      tempT[id] = v.num
    end
    Net:SendProto("home.update_electric", function(json)
      PlayerData:RefreshUseItems(tempT)
      local lv = PlayerData:GetHomeInfo().electric_lv
      SdkReporter.TrackTrain({elcLv = lv})
      PlayerData:GetHomeInfo().electric_lv = lv + 1
      PlayerData:GetHomeInfo().station_info = json.station_info
      DataModel.InitData()
      local beforeInfo = electricConfig.electricList[DataModel.curLv - 1]
      local curInfo = electricConfig.electricList[DataModel.curLv]
      PlayerData:GetHomeInfo().speed = PlayerData:GetHomeInfo().speed + curInfo.speed - beforeInfo.speed
      Controller:InitDLPanel()
      Controller:InitSpeedEffect()
      View.Group_ElectricUp.self:SetActive(false)
      CommonTips.ShowElectricLvUp(1, lv + 1)
    end)
  end,
  HomeElectric_Group_ElectricBuy_Btn_Close_Click = function(btn, str)
    View.Group_ElectricBuy.self:SetActive(false)
  end,
  HomeElectric_Group_ElectricBuy_Btn_Cancel_Click = function(btn, str)
    View.Group_ElectricBuy.self:SetActive(false)
  end,
  HomeElectric_Group_ElectricBuy_Btn_LevelUp_Click = function(btn, str)
    local curInstanllIdx = DataModel.slotInstallCount + 1
    local electricConfig = PlayerData:GetFactoryData(99900023, "HomeElectricConfig")
    local info = electricConfig.buyElectricList[curInstanllIdx]
    local costList = PlayerData:GetFactoryData(info.id, "ListFactory").electricMaterialList
    local tempT = {}
    for k, v in pairs(costList) do
      local id = v.id
      if PlayerData:GetGoodsById(id).num < v.num then
        CommonTips.OpenTips(80600333)
        return
      end
      tempT[id] = v.num
    end
    Net:SendProto("home.open_electric_slot", function(json)
      PlayerData:RefreshUseItems(tempT)
      local useNum = PlayerData:GetHomeInfo().slot_num
      PlayerData:GetHomeInfo().slot_num = useNum + 1
      PlayerData:GetHomeInfo().station_info = json.station_info
      DataModel.InitData()
      PlayerData:GetHomeInfo().speed = PlayerData:GetHomeInfo().speed + info.addSpeed
      View.Group_BQ.Txt_MKGD:SetText(string.format(GetText(80600420), DataModel.GetSlotElectric()))
      Controller:InitCCPanel()
      Controller:InitSpeedEffect()
      View.Group_ElectricBuy.self:SetActive(false)
      CommonTips.ShowElectricLvUp(2, useNum + 1)
    end)
  end,
  HomeElectric_Group_BQ_Group_DL_Btn_1_Click = function(btn, str)
    Controller:SelectPanel(1)
  end,
  HomeElectric_Group_BQ_Group_MK_Btn_1_Click = function(btn, str)
    Controller:SelectPanel(2)
  end,
  HomeElectric_Group_CC_StaticGrid_MK_SetGrid = function(element, elementIndex)
    local showNotUnlock = elementIndex > DataModel.slotOpenCount
    local showInstalled = elementIndex <= DataModel.slotInstallCount
    local showEmpty = elementIndex <= DataModel.slotOpenCount and elementIndex > DataModel.slotInstallCount
    element.Img_NotUnlock.self:SetActive(showNotUnlock)
    element.Img_Empty:SetActive(showEmpty)
    element.Img_Installed:SetActive(showInstalled)
    if showNotUnlock then
      element.Img_NotUnlock.Txt_Tips:SetText(string.format(GetText(80600421), DataModel.slotLvRecord[elementIndex] or 20))
    end
  end,
  HomeElectric_Group_CC_Btn_Not_Click = function(btn, str)
  end,
  HomeElectric_Group_CC_StaticGrid_MK_Group_MK_Img_Empty_Btn__Click = function(btn, str)
    Controller:RefreshElectricBuyPanel()
  end,
  HomeElectric_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeElectric_Group_DL_Btn_Core_Click = function(btn, str)
    UIManager:Open("UI/EngineCore/EngineCore")
  end,
  HomeElectric_Group_ElectricUp_Group_List_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetItemElement(element, elementIndex)
  end,
  HomeElectric_Group_ElectricUp_Group_List_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickItem(str)
  end,
  HomeElectric_Group_ElectricBuy_Group_List_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetItemElement(element, elementIndex)
  end,
  HomeElectric_Group_ElectricBuy_Group_List_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickItem(str)
  end
}
return ViewFunction
