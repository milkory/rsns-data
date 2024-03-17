local View = require("UIFlierMain/UIFlierMainView")
local DataModel = {}
DataModel.StationId = nil

function DataModel.OnShowRefresh()
  if not DataModel.StationId then
    return
  end
  local leafletOpen = PlayerData.IsFlierFunOpen()
  local magazineOpen = PlayerData.IsMagazineFunOpen(DataModel.StationId)
  local tvOpen = PlayerData.IsChannelFunOpen(DataModel.StationId)
  View.Group_Bg.Img_Leaflet.Img_Unlock:SetActive(not leafletOpen)
  View.Group_Bg.Img_Leaflet.Img_Unlock.Txt_Dec:SetText(PlayerData:GetFactoryData(80602291, "TextFactory").text)
  View.Group_Bg.Img_Magazine.Img_Unlock:SetActive(not magazineOpen)
  View.Group_Bg.Img_Magazine.Img_Unlock.Txt_Dec:SetText(PlayerData:GetFactoryData(80602293, "TextFactory").text)
  View.Group_Bg.Img_Tv.Img_Unlock:SetActive(not tvOpen)
  View.Group_Bg.Img_Tv.Img_Unlock.Txt_Dec:SetText(PlayerData:GetFactoryData(80602292, "TextFactory").text)
  View.Group_Bg.Img_Leaflet.Img_Bg.Group_Leaflet.Btn_Come:SetActive(leafletOpen)
  View.Group_Bg.Img_Magazine.Img_Bg.Group_Magazine.Btn_Come:SetActive(magazineOpen)
  View.Group_Bg.Img_Tv.Img_Bg.Group_Tv.Btn_Come:SetActive(tvOpen)
  local leafletDesc = PlayerData:GetFactoryData(80602294, "TextFactory")
  View.Group_Bg.Img_Leaflet.Img_Bg.Group_Leaflet.Group_Introduce.Txt_Dec:SetText(leafletDesc.text)
  local magazineDesc = PlayerData:GetFactoryData(80602295, "TextFactory")
  View.Group_Bg.Img_Magazine.Img_Bg.Group_Magazine.Group_Introduce.Txt_Dec:SetText(magazineDesc.text)
  local tvDesc = PlayerData:GetFactoryData(80602296, "TextFactory")
  View.Group_Bg.Img_Tv.Img_Bg.Group_Tv.Group_Introduce.Txt_Dec:SetText(tvDesc.text)
  DataModel.RefreshTop()
  View.self:PlayAnim("FlierMain")
end

function DataModel.RefreshTop()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_Top.Group_Topic.Group_Location.Txt_Location:SetText(stationCA.name)
  local homeCommon = require("Common/HomeCommon")
  homeCommon.SetPassengerElement(View.Group_TopRight.Group_PassengerCapacity)
  local maxHaveFlierNum = PlayerData:GetFactoryData(99900061, "ConfigFactory").leafletMax + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.RiseFliersSaveLimited)
  View.Group_TopRight.Group_Cerent.Txt_:SetText(string.format("%d/%d", PlayerData.GetLeafLetNum(), maxHaveFlierNum))
  local advNum = PlayerData.ServerData.items["11400072"] and PlayerData.ServerData.items["11400072"].num or 0
  View.Group_TopRight.Group_Adv.Txt_:SetText(advNum)
end

return DataModel
