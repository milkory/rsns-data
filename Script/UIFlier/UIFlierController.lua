local DataModel = require("UIFlier/UIFlierDataModel")
local View = require("UIFlier/UIFlierView")
local UIFlierController = {}
local this = UIFlierController

function UIFlierController.RefreshOnShow()
  this.RefreshTopPanel(true)
  this.RefreshCopyPanel(true)
  this.RefreshSendStationPanel(true)
  this.RefreshSendPosPanel(false)
  this.RefreshCopyNunPanel(false)
  this.RefreshSendNumPanel(false)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if PosClickHandler.GetCoachDirtyPercent() < homeConfig.cleantwo then
    CommonTips.OpenFlierConditionTips({
      showType = EnumDefine.FlierConditionShowType.showNeedClean,
      stationId = DataModel.stationId
    })
  end
end

function UIFlierController.RefreshCopyPanel(state)
  if not state then
    View.GroupCopyPanel:SetActive(false)
    return
  end
  View.GroupCopyPanel:SetActive(true)
  local remainCopyFlierNum = PlayerData.GetRemainCopyLeafLetNum()
  local format = 0 < remainCopyFlierNum and "<color=#FFFFFF>%d</color>" or "<color=#FF0000>%d</color>"
  View.GroupCopyPanel.GroupBottom.GroupCopy.TxtCopyRemain:SetText(string.format("剩余加印数量：" .. format, remainCopyFlierNum))
  View.GroupCopyPanel.GroupBottom.Img_CantCopy:SetActive(0 >= DataModel.GetMaxCopyNum())
end

function UIFlierController.RefreshCopyNunPanel(state)
  if not state then
    View.GroupCopyNumPanel:SetActive(false)
    return
  end
  View.GroupCopyNumPanel.self:SetActive(true)
  local costCfg = PlayerData:GetFactoryData(99900061).leafletAddPay
  local count = View.GroupCopyNumPanel.CopyCostGroup.transform.childCount
  for i = 1, count do
    local costItem = View.GroupCopyNumPanel.CopyCostGroup["Cost" .. i]
    costItem:SetActive(costCfg[i])
  end
  local maxValue = DataModel.GetMaxCopyNum()
  local minValue = 0 < maxValue and 1 or 0
  View.GroupCopyNumPanel.Group_Slider.Slider_Value:SetMinAndMaxValue(minValue, maxValue)
  View.GroupCopyNumPanel.Group_Slider.Slider_Value:SetSliderValue(minValue)
  DataModel.curSelectCopyFlierNum = minValue
  View.GroupCopyNumPanel.Group_Slider.Group_Num.Txt_Select:SetText(string.format("%d/%d", minValue, maxValue))
end

function UIFlierController.RefreshSendPosPanel(state)
  if not state then
    View.GroupSendPosPanel:SetActive(false)
    return
  end
  this.RefreshTopPanel(false)
  this.RefreshCopyPanel(false)
  this.RefreshSendStationPanel(false)
  View.GroupSendPosPanel.self:SetActive(true)
  DataModel.curFlierSendStartPos = nil
  DataModel.curFlierSendPosList = {}
  View.GroupSendPosPanel.Img_CantConfirm:SetActive(true)
  local count = table.count(PlayerData:GetFactoryData(DataModel.stationId, "HomeStationFactory").cityLeafletLest)
  View.GroupSendPosPanel.StaticGrid.grid.self:SetDataCount(count)
  View.GroupSendPosPanel.StaticGrid.grid.self:RefreshAllElement()
end

function UIFlierController.RefreshSendStationPanel(state)
  if not state then
    View.GroupSendStationPanel:SetActive(false)
    return
  end
  View.GroupSendStationPanel:SetActive(true)
  View.GroupCopyPanel.Group_station.Txt_:SetText(PlayerData:GetFactoryData(DataModel.stationId, "HomeStationFactory").name)
  DataModel.curFlierSendDestinationList = {}
  DataModel.curFlierSendDestination = nil
  View.GroupSendStationPanel.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.GetUnLockCanSendFlierStationList()))
  View.GroupSendStationPanel.ScrollGrid_List.grid.self:RefreshAllElement()
  View.GroupSendStationPanel.Group_btn.Img_CantSend:SetActive(PlayerData.GetLeafLetNum() == 0 or PlayerData:GetCurPassengerNum() == PlayerData:GetMaxPassengerNum())
end

function UIFlierController.RefreshSendNumPanel(state)
  if not state then
    View.Group_SendNum.self:SetActive(false)
    return
  end
  View.Group_SendNum.self:SetActive(true)
  local leafletNum = PlayerData.GetLeafLetNum()
  local format = 0 < leafletNum and "<color=#FFFFFF>%d</color>/%d" or "<color=#FF0000>%d</color>/%d"
  View.Group_SendNum.GroupBottom.Group_num.Txt_chiyouNum:SetText(string.format(format, leafletNum, DataModel.maxHaveFlierNum))
  local remainCopyFlierNum = PlayerData.GetRemainCopyLeafLetNum()
  View.Group_SendNum.GroupBottom.Group_num.Txt_addFlierNum:SetText(remainCopyFlierNum)
  View.Group_SendNum.GroupBottom.Img_CantCopy:SetActive(remainCopyFlierNum == 0 or leafletNum == DataModel.maxHaveFlierNum)
  local sendBasic = DataModel.sendBasic
  local minValue = leafletNum >= sendBasic and 1 or 0
  local maxValue = math.floor(leafletNum / sendBasic)
  View.Group_SendNum.Group_chooseNum.Group_Slider.Slider_Value:SetMinAndMaxValue(minValue, maxValue)
  View.Group_SendNum.Group_chooseNum.Group_Slider.Slider_Value.self:SetSliderValue(minValue)
  DataModel.curSelectSendFlierNum = minValue == 1 and sendBasic or 0
  View.Group_SendNum.Group_chooseNum.Group_Slider.Txt_Select:SetText(string.format("%d/%d", DataModel.curSelectSendFlierNum, leafletNum))
  View.Group_SendNum.Group_chooseNum.Btn_Add.Txt_:SetText("+" .. DataModel.sendBasic)
  View.Group_SendNum.Group_chooseNum.Btn_Reduce.Txt_:SetText("-" .. DataModel.sendBasic)
end

function UIFlierController.RefreshTopPanel(state)
  if not state then
    View.GroupTopPanel.self:SetActive(false)
    return
  end
  View.GroupTopPanel.self:SetActive(true)
  local homeCommon = require("Common/HomeCommon")
  homeCommon.SetPassengerElement(View.GroupTopPanel.Group_TopRight.Group_PassengerCapacity)
  View.GroupTopPanel.Group_TopRight.Group_Cerent.Txt_:SetText(string.format("%d/%d", PlayerData.GetLeafLetNum(), DataModel.maxHaveFlierNum))
end

function UIFlierController.TimeRefresh()
  local refresh = false
  if TimeUtil:GetServerTimeStamp() > DataModel.NextFreeFlierTime then
    local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
    local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
    local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
    local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
    DataModel.NextFreeFlierTime = targetTime
    refresh = true
  end
  if TimeUtil:GetServerTimeStamp() > DataModel.NextOverPrintTime then
    local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
    local targetTime = TimeUtil:GetNextWeekTime(1, h, TimeUtil:GetServerTimeStamp())
    DataModel.NextOverPrintTime = targetTime
    refresh = true
  end
  if refresh then
    Net:SendProto("station.psg_source_info", function(json)
      if json.leaflet_location then
        DataModel.unLockFlierSendPosList = json.leaflet_location
      end
      this.RefreshTopPanel(true)
      this.RefreshCopyPanel(true)
    end)
  end
end

return UIFlierController
