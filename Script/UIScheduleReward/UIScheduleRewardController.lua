local View = require("UIScheduleReward/UIScheduleRewardView")
local DataModel = require("UIScheduleReward/UIScheduleRewardDataModel")
local BtnItem = require("Common/BtnItem")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  local serverInfo = PlayerData.ServerData.security_levels[tostring(DataModel.data.buildingId)]
  local pondServerInfo = serverInfo[tostring(DataModel.data.pondId)]
  local buildingCA = PlayerData:GetFactoryData(DataModel.data.buildingId)
  local stationCA = PlayerData:GetFactoryData(buildingCA.stationId)
  local pondCA = PlayerData:GetFactoryData(DataModel.data.pondId)
  View.Txt_CityName:SetText(stationCA.name)
  View.Txt_SeriesName:SetText(string.format(GetText(80602075), pondCA.seriesName))
  View.Txt_Name:SetText(GetText(pondCA.sequenceName))
  local percent = pondServerInfo.expel_num / pondCA.expelNum
  View.Txt_ExpelNum:SetText(string.format(GetText(80602074), math.floor(percent * 100 + 1.0E-4)))
  View.Img_ScheduleDi:SetFilledImgAmount(percent)
  View.Img_ScheduleDi.Img_Pointer:SetAnchoredPositionX(374 * percent - 7)
  View.ScrollGrid_List.grid.self:SetDataCount(#DataModel.rewardInfo)
  View.ScrollGrid_List.grid.self:RefreshAllElement()
end

function Controller:SetElement(element, elementIndex)
  local info = DataModel.rewardInfo[elementIndex]
  element.Group_Not:SetActive(info.received or not info.canGet)
  element.Group_Can:SetActive(not info.received and info.canGet)
  element.Group_Can.Btn_Click:SetClickParam(elementIndex)
  element.Group_Complete:SetActive(info.received)
  element.Group_Not.Txt_ExpelNum:SetText(string.format(GetText(80602074), info.expelPercent))
  element.Group_Can.Txt_ExpelNum:SetText(string.format(GetText(80602074), info.expelPercent))
  element.Group_Reward.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
  element.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(#info.rewardItems)
  element.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
end

function Controller:SetRewardItemElement(element, elementIndex)
  local parentIndex = tonumber(element.ParentParam)
  local info = DataModel.rewardInfo[parentIndex]
  local rewardItem = info.rewardItems[elementIndex]
  BtnItem:SetItem(element.Group_Item, {
    id = rewardItem.id,
    num = rewardItem.num
  })
  element.Group_Item.Btn_Item:SetClickParam(rewardItem.id)
end

function Controller:ClickReward(str)
  local idx = tonumber(str)
  local info = DataModel.rewardInfo[idx]
  Net:SendProto("building.expel_reward", function(json)
    local serverInfo = PlayerData.ServerData.security_levels[tostring(DataModel.data.buildingId)]
    local pondServerInfo = serverInfo[tostring(DataModel.data.pondId)]
    local rewards = pondServerInfo.rewards or {}
    table.insert(rewards, info.idx - 1)
    pondServerInfo.rewards = rewards
    info.received = true
    DataModel.Sort()
    View.ScrollGrid_List.grid.self:RefreshAllElement()
    CommonTips.OpenShowItem(json.reward, function()
      CommonTips.OpenRepLvUp()
    end)
    local isAllReceived = true
    for k, v in pairs(DataModel.rewardInfo) do
      if v.canGet and not v.received then
        isAllReceived = false
        break
      end
    end
    if isAllReceived then
      RedpointTree:ChangeRedpointCnt(RedPointNodeStr.RedPointNodeStr.HomeSafeLevel .. DataModel.data.buildingId .. "|" .. DataModel.data.pondId, -1)
    end
  end, DataModel.data.pondId, info.idx - 1)
end

function Controller:ClickRewardItem(str)
  local id = tonumber(str)
  CommonTips.OpenPreItemTips({itemId = id})
end

return Controller
