local View = require("UIHomeCOC/UIHomeCOCView")
local DataModel = require("UIHomeCOC/UIHomeCOCStoreDataModel")
local MainDataModel = require("UIHomeCOC/UIHomeCOCDataModel")
local Controller = {}

function Controller:ChooseTab(index)
  DataModel.curIndex = index
  DataModel.Now_List = DataModel.List[index]
  DataModel.RefreshShopDataDetail()
  View.Group_Store.Group_Furniture.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.Now_List.shopList))
  View.Group_Store.Group_Furniture.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_Store.Group_StoreTab.ScrollGrid_Tab.grid.self:RefreshAllElement()
  View.self:PlayAnimOnce("Switch")
  local isAutoRefresh = DataModel.Now_List.isAutoRefresh
  View.Group_Store.Group_Time.self:SetActive(isAutoRefresh)
  if isAutoRefresh then
    local time = storeFactory.refreshTimeList[1]
    local h = tonumber(string.sub(time.refreshTime, 1, 2))
    local m = tonumber(string.sub(time.refreshTime, 4, 5))
    local textId
    if storeFactory.refreshType == "Daily" then
      textId = 80600463
    elseif storeFactory.refreshType == "Weekly" then
      textId = 80600786
    elseif storeFactory.refreshType == "Monthly" then
      textId = 80600787
    end
    View.Group_Store.Group_Time.Txt_Time:SetText(string.format(GetText(textId), h, m))
  end
end

function Controller.InitStore()
  DataModel.InitShopData()
  local stationCA = PlayerData:GetFactoryData(MainDataModel.StationId, "HomeStationFactory")
  View.Group_Store.Group_StoreTab.ScrollGrid_Tab.grid.self:SetDataCount(#stationCA.cocStoreList)
  View.Group_Store.Group_StoreTab.ScrollGrid_Tab.grid.self:RefreshAllElement()
end

return Controller
