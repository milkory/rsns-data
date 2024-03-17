local View = require("UIFlierMain/UIFlierMainView")
local DataModel = require("UIFlierMain/UIFlierMainDataModel")
local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
local ViewFunction = {
  FlierMain_Group_Bg_Img_Leaflet_Img_Bg_Group_Leaflet_Btn_Come_Click = function(btn, str)
    if not PlayerData.IsFlierFunOpen() then
      CommonTips.OpenTips(80602291)
      return
    end
    if not PlayerData.IsPassageFunOpen() then
      error("检查乘客功能开启条件配置")
      return
    end
    local stationCA = PlayerData:GetFactoryData(TradeDataModel.EndCity, "HomeStationFactory")
    if not stationCA.isLeaflet then
      local txtCA = PlayerData:GetFactoryData(80601667, "TextFactory")
      CommonTips.OpenTips(string.format(txtCA.text, stationCA.name))
      return
    end
    UIManager:Open("UI/Flier/Flier", Json.encode({
      stationId = TradeDataModel.EndCity
    }))
  end,
  FlierMain_Group_Bg_Img_Magazine_Img_Bg_Group_Magazine_Btn_Come_Click = function(btn, str)
    if not PlayerData.IsMagazineFunOpen(DataModel.StationId) then
      CommonTips.OpenTips(80602292)
      return
    end
    UIManager:Open("UI/Flier/Flier_Magazine", Json.encode({
      stationId = TradeDataModel.EndCity
    }))
  end,
  FlierMain_Group_Bg_Img_Tv_Img_Bg_Group_Tv_Btn_Come_Click = function(btn, str)
    if not PlayerData.IsChannelFunOpen(DataModel.StationId) then
      CommonTips.OpenTips(80602293)
      return
    end
    UIManager:Open("UI/Flier/Flier_Tv", Json.encode({
      stationId = TradeDataModel.EndCity
    }))
  end,
  FlierMain_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  FlierMain_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  FlierMain_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  FlierMain_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80301233}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  FlierMain_Group_TopRight_Group_PassengerCapacity_Btn_Add_Click = function(btn, str)
  end,
  FlierMain_Group_TopRight_Group_PassengerCapacity_Btn_Icon_Click = function(btn, str)
  end,
  FlierMain_Btn_Adv_Click = function(btn, str)
    CommonTips.OpenNoteBook(2)
  end
}
return ViewFunction
