local View = require("UIFlier_Tv/UIFlier_TvView")
local DataModel = {}
local this = DataModel
DataModel.StationId = nil
DataModel.CanSendStationIds = {}
DataModel.CanSendStationCtrs = {}
DataModel.SelectedSendStationCtr = nil
DataModel.SelectedSendStationId = nil

function DataModel.OnShowRefresh()
  local desc = PlayerData:GetFactoryData(80602296, "TextFactory")
  View.GroupCopyPanel.Group_Introduce.Txt_Dec:SetText(desc.text)
  this.RefreshStation()
  this.RefreshTop()
end

function DataModel.RefreshTop()
  local homeCommon = require("Common/HomeCommon")
  homeCommon.SetPassengerElement(View.Group_TopRight.Group_PassengerCapacity)
  local advNum = PlayerData:GetGoodsById(11400072).num
  View.Group_TopRight.Group_Adv.Txt_:SetText(advNum)
  View.Group_TopRight.Group_Time:SetActive(true)
  local maxSendNum = PlayerData:GetFactoryData(99900061, "ConfigFactory").tvTime
  View.Group_TopRight.Group_Time.Img_Bg.Txt_Num:SetText(string.format("%d/%d", PlayerData.SolicitData.tvSendNum, maxSendNum))
end

function DataModel.RefreshStation()
  View.Group_Send:SetActive(false)
  View.GroupCopyPanel.Group_Type:SetActive(false)
  View.Group_Station:SetActive(true)
  View.GroupCopyPanel.Group_station:SetActive(true)
  this.CanSendStationCtrs = {}
  this.SelectedSendStationCtr = nil
  this.SelectedSendStationId = nil
  local flierDataModel = require("UIFlier/UIFlierDataModel")
  this.CanSendStationIds = flierDataModel.GetUnLockCanSendFlierStationList(DataModel.StationId)
  View.Group_Station.ScrollGrid_List.grid.self:SetDataCount(table.count(this.CanSendStationIds))
  View.Group_Station.ScrollGrid_List.grid.self:RefreshAllElement()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.GroupCopyPanel.Group_station.Txt_:SetText(stationCA.name)
  local advNum = PlayerData:GetGoodsById(11400072).num
  local canSend = PlayerData.SolicitData.tvSendNum > 0 and 0 < advNum and PlayerData:GetCurPassengerNum() < PlayerData:GetMaxPassengerNum()
  View.Group_Station.Group_btn.Img_CantSend:SetActive(not canSend)
  View.self:PlayAnim("FlierTvStation")
end

function DataModel.RefreshSend()
  View.Group_Send:SetActive(true)
  View.GroupCopyPanel.Group_Type:SetActive(true)
  View.Group_Station:SetActive(false)
  View.GroupCopyPanel.Group_station:SetActive(false)
  View.Group_Send.ScrollGrid_List.grid.self:SetDataCount(table.count(PlayerData.SolicitData.tvPool))
  View.Group_Send.ScrollGrid_List.grid.self:RefreshAllElement()
  View.self:PlayAnim("FlierTvType")
end

return DataModel
