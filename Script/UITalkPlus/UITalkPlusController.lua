local View = require("UITalkPlus/UITalkPlusView")
local DataModel = require("UITalkPlus/UITalkPlusDataModel")
local Controller = {}

function Controller:Init()
  DataModel.showCount = #DataModel.cacheEventList + 1
  View.ScrollGrid_List.grid.self:SetDataCount(DataModel.showCount)
  View.ScrollGrid_List.grid.self:RefreshAllElement()
  Controller:RefreshTopInfo()
end

function Controller:RefreshTopInfo()
  local buildingCA = PlayerData:GetFactoryData(DataModel.buildingId)
  View.Group_NpcInfoR.Txt_Title:SetText(buildingCA.name)
  View.Group_NpcInfoR.Img_Icon:SetSprite(buildingCA.buildingIconPath)
  local stationCA = PlayerData:GetFactoryData(buildingCA.stationId)
  View.Group_NpcInfoR.Group_Station.Txt_Station:SetText(stationCA.name)
end

function Controller:SetElement(element, elementIndex)
  local info = DataModel.cacheEventList[elementIndex]
  if info ~= nil then
    local questCA = PlayerData:GetFactoryData(info.questId)
    element.Btn_Talk.Txt_Name:SetText(questCA.name)
    element.Btn_Talk.Img_Icon:SetSprite("UI/Common/common_icon_quest")
  elseif elementIndex == DataModel.showCount then
    element.Btn_Talk.Txt_Name:SetText(GetText(80602503))
    element.Btn_Talk.Img_Icon:SetSprite("UI/Common/common_icon_back")
  end
  element.Btn_Talk:SetClickParam(elementIndex)
end

function Controller:ElementClick(str)
  local idx = tonumber(str)
  if idx == DataModel.showCount then
    View.self:CloseUI()
    View.self:Confirm()
    return
  end
  DataModel.cacheEventList[idx]:action()
end

function Controller:BindParentInfo(parentView, cacheEventList, buildingId)
  DataModel.parentView = parentView
  DataModel.cacheEventList = cacheEventList
  DataModel.buildingId = buildingId
  parentView:RegChildPanel(View.self.url)
  Controller:Init()
end

function Controller:CloseView()
  DataModel.parentView:UnregChildPanel(View.self.url)
  DataModel.parentView = nil
  DataModel.cacheEventList = nil
end

return Controller
