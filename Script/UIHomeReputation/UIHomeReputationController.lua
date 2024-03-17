local View = require("UIHomeReputation/UIHomeReputationView")
local DataModel = require("UIHomeReputation/UIHomeReputationDataModel")
local HomeCommon = require("Common/HomeCommon")
local Controller = {}

function Controller:FirstInit()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  local stateInfo = HomeCommon.GetCityStateInfo(DataModel.StationId)
  local listCA = PlayerData:GetFactoryData(stateInfo.cityMapId, "ListFactory")
  View.Img_BG:SetSprite(Controller:GetBgPath(listCA))
  local posZ = View.Img_BG.transform.position.z
  View.Img_BG:SetPosition(Vector3(DataModel.PosX, DataModel.PosY, posZ))
  HomeCommon.SetReputationElement(View.Group_Zhu.Group_Reputation, DataModel.StationId, false)
  local curReward = HomeCommon.GetCurLvRepData(DataModel.StationId)
  local iconPath, iconFlagPath = Controller:GetHonorPng()
  local titleName = curReward.peopleName
  if iconPath == "" then
    View.Group_Zhu.Img_HonorIcon:SetActive(false)
  else
    View.Group_Zhu.Img_HonorIcon:SetActive(true)
    View.Group_Zhu.Img_HonorIcon:SetSprite(iconPath)
  end
  if iconFlagPath == "" then
    View.Group_Zhu.Img_FlagIcon:SetActive(false)
  else
    View.Group_Zhu.Img_FlagIcon:SetActive(true)
    View.Group_Zhu.Img_FlagIcon:SetSprite(iconFlagPath)
  end
  View.Group_Zhu.Group_NpcInfoL.Group_Station.Txt_Station:SetText(stationCA.name)
  View.Group_Zhu.Group_NpcInfoL.Txt_Title:SetText(titleName)
  View.Group_Zhu.Group_NpcInfoL.Txt_Force:SetActive(false)
  if stationCA.force > 0 then
    local tagCA = PlayerData:GetFactoryData(stationCA.force, "TagFactory")
    View.Group_Zhu.Group_NpcInfoL.Txt_Force:SetActive(true)
    View.Group_Zhu.Group_NpcInfoL.Txt_Force:SetText(string.format(GetText(80601533), tagCA.tagName))
  end
  View.Group_Zhu.Group_Content.ScrollView_Content.Viewport.Content.Txt_Des:SetText(stationCA.des)
  View.Group_Zhu.Group_Content.ScrollView_Content.Viewport.Content.Img_2.Txt_Revenue:SetText(string.format("%.1f%%", curReward.revenue * 100))
  View.Group_Zhu.Group_Content.ScrollView_Content.Viewport.Content.Img_2.Txt_BuyNum:SetText(string.format("%.1f%%", curReward.buyNum * 100))
  View.Group_Zhu.Group_Content.ScrollView_Content.Viewport.Content.Img_2.Txt_BargainNum:SetText(curReward.bargainNum)
  View.Group_Zhu.Group_Content.ScrollView_Content.Viewport.Content.Img_2.Txt_RiseNum:SetText(curReward.riseNum)
  View.Group_Zhu.Group_Content.ScrollView_Content.Viewport.Content.Img_2.Txt_Rate:SetText(string.format("%.1f%%", curReward.bargainSuccessRate * 100))
  View.Group_Zhu.Group_Content.ScrollView_Content.Viewport.Content.Img_2.Txt_BuyCapacity:SetText(curReward.wareNum)
  View.Group_Zhu.Group_Content.ScrollView_Content.Viewport.Content.Img_2.Txt_cocAutoRefreshNum:SetText(curReward.cocAutoRefreshNum)
  View.Group_Zhu.Group_Content.ScrollView_Content.Viewport.Content.Img_2.Txt_offerAutoRefreshNum:SetText(curReward.offerAutoRefreshNum)
  View.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(#DataModel.RewardList)
  View.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
  local moveTo = DataModel.MoveToPos
  if moveTo == 0 then
    moveTo = 1
  end
  View.Group_Reward.ScrollGrid_Reward.grid.self:MoveToPos(moveTo)
end

function Controller:GetHonorPng()
  local rewardList = HomeCommon.GetRepRewardList(DataModel.StationId)
  local iconPath = ""
  local iconFlagPath = ""
  for i = DataModel.CurLv + 1, 1, -1 do
    local reward = rewardList[i]
    if iconPath == "" then
      iconPath = reward.honorPng
    end
    if iconFlagPath == "" then
      iconFlagPath = reward.flagPng
    end
    if iconPath ~= "" and iconFlagPath ~= "" then
      break
    end
  end
  return iconPath, iconFlagPath
end

function Controller:GetBgPath(listCA)
  local serverTime = TimeUtil:GetServerTimeStamp()
  local todayZeroStamp = TimeUtil:GetFutureTime(0, 0)
  local deltaTime = serverTime - todayZeroStamp
  local idx = 1
  for k, v in pairs(listCA.bgList) do
    local h = tonumber(string.sub(v.changeTime, 1, 2))
    local m = tonumber(string.sub(v.changeTime, 4, 5))
    local s = tonumber(string.sub(v.changeTime, 7, 8))
    local time = h * 60 * 60 + m * 60 + s
    if deltaTime < time then
      idx = k
      break
    end
  end
  idx = idx - 1
  if idx <= 0 then
    idx = #listCA.bgList
  end
  return listCA.bgList[idx].bgPath
end

function Controller:SetScrollViewValueChanged()
  View.Group_Zhu.Group_Content.ScrollView_Content.self:SetContentAncoredPosValueChanged(function(pos)
    View.Group_Zhu.Group_Content.Img_Tips:SetActive(pos.y < 148)
  end)
end

function Controller:RefreshRepElement(element, elementIndex)
  local info = DataModel.RewardList[elementIndex]
  local canGet = info.state == 1
  local alreadyGet = info.state == 2
  local notCanGet = info.state == 0
  element.Group_BG.Group_Wei:SetActive(notCanGet)
  element.Group_BG.Group_Already:SetActive(not notCanGet)
  local showElement
  if notCanGet then
    showElement = element.Group_BG.Group_Wei
  else
    showElement = element.Group_BG.Group_Already
  end
  showElement.Txt_Reputation:SetText(info.needRep)
  showElement.ScrollView_Describe.Viewport.Txt_Describe:SetText(info.desc)
  showElement.Group_Reward:SetActive(info.honorPng == "")
  element.Group_Xun:SetActive(info.honorPng ~= "")
  element.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
  element.ScrollGrid_Reward.grid.self:SetDataCount(#info.rewards)
  element.ScrollGrid_Reward.grid.self:RefreshAllElement()
  element.ScrollGrid_Reward.grid.self:MoveToTop()
  element.Group_State.Btn_Get.self:SetActive(canGet)
  element.Group_State.Btn_Get.self:SetClickParam(elementIndex)
  element.Group_State.Group_AlreadyGet.self:SetActive(alreadyGet)
  element.Group_State.Group_Not.self:SetActive(notCanGet)
  element.Group_Grade.Group_Wei.self:SetActive(notCanGet)
  element.Group_Grade.Group_Already.self:SetActive(canGet)
  element.Group_Grade.Group_AlreadyGet.self:SetActive(alreadyGet)
  if notCanGet then
    showElement = element.Group_Grade.Group_Wei
  elseif canGet then
    showElement = element.Group_Grade.Group_Already
  else
    showElement = element.Group_Grade.Group_AlreadyGet
  end
  showElement.Txt_Grade:SetText(elementIndex)
  local preIdx = elementIndex - 1
  if 0 < preIdx then
    info = DataModel.RewardList[preIdx]
    canGet = info.state == 1
    alreadyGet = info.state == 2
    notCanGet = info.state == 0
  else
    notCanGet = false
    canGet = true
  end
  local linePath
  if notCanGet then
    linePath = DataModel.LinePath[1]
  elseif canGet then
    linePath = DataModel.LinePath[2]
  else
    linePath = DataModel.LinePath[3]
  end
  showElement.Img_Line1:SetSprite(linePath)
end

function Controller:RefreshChildRewardElement(element, elementIndex)
  local info = DataModel.RewardList[tonumber(element.ParentParam)]
  local rewardInfo = info.rewards[elementIndex]
  local BtnItem = require("Common/BtnItem")
  BtnItem:SetItem(element.Group_Item, {
    id = rewardInfo.id,
    num = rewardInfo.num
  })
  element.Group_Item.Btn_Item:SetClickParam(rewardInfo.id)
end

function Controller:ClickRewardItem(str)
  local itemId = tonumber(str)
  CommonTips.OpenPreRewardDetailTips(itemId)
end

function Controller:ClickGetReward(str)
  local getLv = tonumber(str)
  Net:SendProto("station.rep_reward", function(json)
    CommonTips.OpenShowItem(json.reward)
    DataModel.RewardList[getLv].state = 2
    local stationId = DataModel.StationId
    local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
    if stationCA.attachedToCity > 0 then
      stationId = stationCA.attachedToCity
    end
    local station = PlayerData:GetHomeInfo().stations[tostring(stationId)]
    if station.rep_reward == nil then
      station.rep_reward = {}
    end
    table.insert(station.rep_reward, getLv)
    View.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
  end, getLv)
end

return Controller
