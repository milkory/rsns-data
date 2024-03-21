local View = require("UIHomeSafe/UIHomeSafeView")
local MainController = require("UIHomeSafe/UIHomeSafeController")
local DataModel = require("UIHomeSafe/UIHomeSafeDataModel")
local RouteLevelDataModel = require("UIHomeSafe/UIRouteLevelDataModel")
local BtnItem = require("Common/BtnItem")
local controller = {}
local OpenReportPanel = function()
  Net:SendProto("building.report_levels", function(json)
    RouteLevelDataModel.InitRouteLevelDataModel(json.levels)
    View.Group_Main.self:SetActive(false)
    View.Group_Zhu.self:SetActive(true)
    UIManager:LoadSplitPrefab(View, "UI/Home/HomeSafe/HomeSafe", "Group_Ding")
    View.Group_Ding.self:SetActive(true)
    MainController:RefreshResource(3)
    UIManager:LoadSplitPrefab(View, "UI/Home/HomeSafe/HomeSafe", "Group_Report")
    if not View.Group_Report.self.IsActive then
      View.self:PlayAnim("Report")
    end
    View.Group_Report:SetActive(true)
    controller.ShowPersonalInfo()
    View.Group_Report.Group_OnlineList.Group_Bottom.Group_Refresh.Group_Able:SetActive(true)
    View.Group_Report.Group_OnlineList.Group_Bottom.Group_Refresh.Group_Unable:SetActive(false)
  end, DataModel.BuildingId)
end
local ShowLevelInfo = function(element, elementIndex, levelType)
  local level_id, data
  if levelType == 1 then
    data = RouteLevelDataModel.person_list[elementIndex]
    local key = data.key
    level_id = string.split(key, ":")[1]
    element.Group_Not:SetActive(data.is_shared == 0)
    element.Group_Allredy:SetActive(data.is_shared == 1)
    if data.is_shared == 0 then
      local levelCA = PlayerData:GetFactoryData(level_id)
      local gradeLv = math.floor(data.player_lv / levelCA.adaptLvSN) + levelCA.enemyLvOffset
      if data.battle_json ~= nil and data.battle_json.enemy_level ~= nil then
        gradeLv = data.battle_json.enemy_level
      end
      element.Group_Not.Img_Tuijian.Txt_Grade:SetText(gradeLv)
      local energyEnd = PlayerData:GetFactoryData(99900014).energyEnd
      element.Group_Not.Group_TZ.Txt_Cost:SetText(energyEnd)
      element.Group_Not.Btn_Appear:SetClickParam(elementIndex)
      element.Group_Not.Group_TZ.Btn_QW:SetClickParam(elementIndex)
    else
      element.Group_Allredy.Group_Remuneration.Txt_Num:SetText(data.reward_num)
      element.Group_Allredy.Btn_Appear:SetClickParam(elementIndex)
    end
  elseif levelType == 2 then
    data = RouteLevelDataModel.online_list[elementIndex]
    local key = data.key
    level_id = string.split(key, ":")[2]
    local levelCA = PlayerData:GetFactoryData(level_id)
    local gradeLv = math.floor(data.challenge_lv / levelCA.adaptLvSN) + levelCA.enemyLvOffset
    if data.battle_json ~= nil and data.battle_json.enemy_level ~= nil then
      gradeLv = data.battle_json.enemy_level
    end
    element.Img_Tuijian.Txt_Grade:SetText(math.floor(gradeLv))
    element.Group_PlayerName.Txt_Name:SetText(string.format(GetText(80601332), data.role_name))
    local shareEnergyEnd = PlayerData:GetFactoryData(99900014).shareEnergyEnd
    element.Group_TZ.Txt_Cost:SetText(shareEnergyEnd)
    element.Group_Remuneration.Txt_Num:SetText(data.reward_num)
    local avatar_id = data.avatar
    if avatar_id == nil or avatar_id == "" then
      local cfg = PlayerData:GetFactoryData(99900001)
      avatar_id = data.gender == 1 and cfg.profilePhotoM or cfg.profilePhotoW
    end
    local icon = PlayerData:GetFactoryData(avatar_id).imagePath
    element.Group_Player.Img_Mask.Img_Icon:SetSprite(icon)
    element.Group_TZ.Btn_QW:SetClickParam(elementIndex)
  elseif levelType == 3 then
    data = RouteLevelDataModel.achieve_list[elementIndex]
    local key = data.key
    level_id = string.split(key, ":")[1]
    element.Group_Time.Txt_Time:SetText(os.date(GetText(80600695), data.completed_ts or 0))
    element.Group_LIkeBtn.Btn_:SetClickParam(elementIndex)
    element.Group_LIkeBtn.Group_Not:SetActive(data.is_liked ~= 1)
    element.Group_LIkeBtn.Group_Allready:SetActive(data.is_liked == 1)
    element.Group_Like.Txt_Num:SetText(data.likes)
    element.Group_Add:SetActive(false)
    element.Group_PlayerName.Txt_Name:SetText(string.format(GetText(80601334), data.role_name))
    local avatar_id = data.avatar
    if avatar_id == nil or avatar_id == "" then
      local cfg = PlayerData:GetFactoryData(99900001)
      avatar_id = data.gender == 1 and cfg.profilePhotoM or cfg.profilePhotoW
    end
    local icon = PlayerData:GetFactoryData(avatar_id).imagePath
    element.Group_Player.Img_Mask.Img_Icon:SetSprite(icon)
    element.Group_GetBack.Group_Not:SetActive(data.received_ts == 0)
    element.Group_GetBack.Group_Allready:SetActive(data.received_ts ~= 0)
    element.Group_GetBack.Btn_:SetClickParam(elementIndex)
  end
  local level_cfg = PlayerData:GetFactoryData(level_id)
  local starInt = level_cfg.levelStarInt + 1
  for i = 1, 5 do
    local element = element.Txt_Name.Group_Star["Img_Star" .. i]
    element:SetActive(i <= starInt)
  end
  element.Txt_Name:SetText(level_cfg.levelName)
  if levelType == 1 or levelType == 2 then
    local days = RouteLevelDataModel.CalDaysBetween(TimeUtil:GetServerTimeStamp(), data.created_ts + level_cfg.caseTimeLimit * 24 * 60 * 60)
    element.Group_Time.Txt_Time:SetText(days)
    element.ScrollView_Describe.Viewport.Txt_Describe:SetText(level_cfg.description)
  end
  element.Group_Reward.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
  element.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(#data.reward_list)
  element.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
  element.Group_Reward.ScrollGrid_Reward.grid.self:MoveToTop()
end
local ShowLevelRewardInfo = function(element, elementIndex, select_indx, rewardType)
  local reward_list
  if rewardType == 1 then
    reward_list = RouteLevelDataModel.person_list[select_indx].reward_list
    element.Group_Lost:SetActive(reward_list[elementIndex].lost == 1)
  elseif rewardType == 2 then
    reward_list = RouteLevelDataModel.online_list[select_indx].reward_list
    if reward_list[elementIndex].share ~= 0 or not GetText(80602066) then
      local content = GetText(80602065)
    end
  elseif rewardType == 3 then
    reward_list = RouteLevelDataModel.achieve_list[select_indx].reward_list
  end
  local reward_info = reward_list[elementIndex]
  BtnItem:SetItem(element.Group_Item, {
    id = reward_info.id,
    num = reward_info.num
  })
  element.Group_Item.Btn_Item:SetClickParam(reward_info.id)
end
local ShowPanel = function(panel_type)
  View.Group_Report.Group_PersonalList:SetActive(panel_type == 1)
  View.Group_Report.Group_Tab.Group_Personal.Group_On:SetActive(panel_type == 1)
  View.Group_Report.Group_OnlineList:SetActive(panel_type == 2)
  View.Group_Report.Group_Tab.Group_Online.Group_On:SetActive(panel_type == 2)
  View.Group_Report.Group_LogList:SetActive(panel_type == 3)
  View.Group_Report.Group_Tab.Group_Record.Group_On:SetActive(panel_type == 3)
end
local ShowRewardInfoPanel = function(item_id)
  CommonTips.OpenPreRewardDetailTips(item_id)
end
local ShowPersonalInfo = function()
  ShowPanel(1)
  if RouteLevelDataModel.person_list.count == 0 then
    View.Group_Report.Group_PersonalList:SetActive(false)
    View.Group_Report.Group_Empty:SetActive(true)
    View.Group_Report.Group_Empty.Txt_PerAndOnline:SetActive(true)
    View.Group_Report.Group_Empty.Txt_Log:SetActive(false)
    return
  end
  View.Group_Report.Group_PersonalList:SetActive(true)
  View.Group_Report.Group_Empty:SetActive(false)
  View.Group_Report.Group_PersonalList.ScrollGrid_List.grid.self:SetDataCount(RouteLevelDataModel.person_list.count)
  View.Group_Report.Group_PersonalList.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_Report.Group_PersonalList.ScrollGrid_List.grid.self:MoveToTop()
end
local Share2Online = function(person_indx)
  local data = RouteLevelDataModel.person_list[tonumber(person_indx)]
  local params = {
    level_key = data.key,
    value_num = data.value_num,
    created_ts = data.created_ts
  }
  UIManager:Open("UI/Home/HomeSafe/AppearTips", Json.encode(params), function()
    View.Group_Ding.Btn_YN.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
    Net:SendProto("building.report_levels", function(json)
      RouteLevelDataModel.InitRouteLevelDataModel(json.levels)
      View.Group_Report.Group_PersonalList.ScrollGrid_List.grid.self:SetDataCount(RouteLevelDataModel.person_list.count)
      View.Group_Report.Group_PersonalList.ScrollGrid_List.grid.self:RefreshAllElement()
    end, DataModel.BuildingId)
  end)
end
local Battle = function(level_key, level_id, battle_json)
  battle_json = battle_json or {}
  local status = {
    Current = "Chapter",
    squadIndex = PlayerData.BattleInfo.squadIndex,
    hasOpenThreeView = false,
    level_key = level_key,
    enemy_ids = battle_json.enemyIds,
    minEnemyLevel = battle_json.enemy_level_min,
    enemyLevel = battle_json.enemy_level,
    bgId = battle_json.bgId
  }
  if battle_json.weather_id and battle_json.weather_id > 0 then
    status.lineWeatherIdList = {
      battle_json.weather_id
    }
    status.lineWeatherRateSN = SafeMath.safeNumberTime
  end
  if battle_json.second_weather_id and 0 < battle_json.second_weather_id then
    status.secondWeatherList = {
      battle_json.second_weather_id
    }
  end
  local t = {}
  t.buildingId = DataModel.BuildingId
  t.isCityMapIn = DataModel.IsCityMapIn
  t.autoShowLevel = 3
  status.extraUIParamData = t
  PlayerData.BattleInfo.battleStageId = tonumber(level_id)
  PlayerData.BattleCallBackPage = "UI/Home/HomeSafe/HomeSafe"
  UIManager:Open("UI/Squads/Squads", Json.encode(status))
end
local StartBattle = function(person_indx)
  local data = RouteLevelDataModel.person_list[tonumber(person_indx)]
  local level_key = PlayerData:GetUserInfo().uid .. ":" .. data.key
  local level_id = string.split(level_key, ":")[2]
  Battle(level_key, level_id, data.battle_json or {})
end
local CancelShare = function(person_indx)
  local data = RouteLevelDataModel.person_list[tonumber(person_indx)]
  local value = math.floor(data.reward_num * RouteLevelDataModel.cancel_coefficient)
  local params = {
    key = data.key,
    value = value
  }
  UIManager:Open("UI/Home/HomeSafe/CancelTips", Json.encode(params), function()
    View.Group_Ding.Btn_YN.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
    Net:SendProto("building.report_levels", function(json)
      RouteLevelDataModel.InitRouteLevelDataModel(json.levels)
      View.Group_Report.Group_PersonalList.ScrollGrid_List.grid.self:SetDataCount(RouteLevelDataModel.person_list.count)
      View.Group_Report.Group_PersonalList.ScrollGrid_List.grid.self:RefreshAllElement()
    end, DataModel.BuildingId)
  end)
end
local ShowOnlineInfo = function()
  local callback = function()
    ShowPanel(2)
    if RouteLevelDataModel.online_list.count == 0 then
      View.Group_Report.Group_OnlineList.ScrollGrid_List.self:SetActive(false)
      View.Group_Report.Group_Empty:SetActive(true)
      View.Group_Report.Group_Empty.Txt_PerAndOnline:SetActive(true)
      View.Group_Report.Group_Empty.Txt_Log:SetActive(false)
      return
    end
    View.Group_Report.Group_OnlineList.ScrollGrid_List.self:SetActive(true)
    View.Group_Report.Group_Empty:SetActive(false)
    View.Group_Report.Group_OnlineList.ScrollGrid_List.grid.self:SetDataCount(RouteLevelDataModel.online_list.count)
    View.Group_Report.Group_OnlineList.ScrollGrid_List.grid.self:RefreshAllElement()
    View.Group_Report.Group_OnlineList.ScrollGrid_List.grid.self:MoveToTop()
  end
  if RouteLevelDataModel.first_open_online then
    Net:SendProto("building.recommend_levels", function(json)
      RouteLevelDataModel.CreateOnlineData(json.rec_levels)
      RouteLevelDataModel.first_open_online = false
      callback()
    end, DataModel.BuildingId)
  else
    callback()
  end
end
local StartOnlineBattle = function(online_indx)
  local data = RouteLevelDataModel.online_list[online_indx]
  local level_key = data.key
  local level_id = string.split(level_key, ":")[2]
  local res = CommonTips.OpenBuyEnergyTips(level_id, function()
    MainController:RefreshResource(1)
  end, nil, true)
  if res then
    return
  end
  Battle(level_key, level_id, data.battle_json)
end
local RefreshOnlineInfo = function()
  if RouteLevelDataModel.refreshOnlienData then
    Net:SendProto("building.recommend_levels", function(json)
      RouteLevelDataModel.CreateOnlineData(json.rec_levels)
      RouteLevelDataModel.refreshOnlienData = false
      View.timer:Start()
      View.Group_Report.Group_OnlineList.Group_Bottom.Group_Refresh.Group_Able:SetActive(false)
      View.Group_Report.Group_OnlineList.Group_Bottom.Group_Refresh.Group_Unable:SetActive(true)
      View.Group_Report.Group_OnlineList.Group_Bottom.Group_Refresh.Group_Unable.Txt_Time:SetText(RouteLevelDataModel.refreshTimer)
      ShowOnlineInfo()
    end, DataModel.BuildingId)
  end
end
local ShowCompleteInfo = function()
  ShowPanel(3)
  if RouteLevelDataModel.achieve_list.count == 0 then
    View.Group_Report.Group_LogList:SetActive(false)
    View.Group_Report.Group_Empty:SetActive(true)
    View.Group_Report.Group_Empty.Txt_PerAndOnline:SetActive(false)
    View.Group_Report.Group_Empty.Txt_Log:SetActive(true)
    return
  end
  View.Group_Report.Group_LogList:SetActive(true)
  View.Group_Report.Group_Empty:SetActive(false)
  View.Group_Report.Group_LogList.ScrollGrid_List.grid.self:SetDataCount(RouteLevelDataModel.achieve_list.count)
  View.Group_Report.Group_LogList.ScrollGrid_List.grid.self:RefreshAllElement()
  View.Group_Report.Group_LogList.ScrollGrid_List.grid.self:MoveToTop()
end
local RecvRewards = function(achieve_indx)
  local data = RouteLevelDataModel.achieve_list[achieve_indx]
  if data.received_ts ~= 0 then
    return
  end
  Net:SendProto("building.receive", function(json)
    CommonTips.OpenShowItem(json.reward)
    data.received_ts = TimeUtil.GetServerTimeStamp()
    View.Group_Report.Group_LogList.ScrollGrid_List.grid.self:RefreshAllElement()
  end, data.key)
end
local AddLikeNum = function(Group_add, achieve_indx)
  local data = RouteLevelDataModel.achieve_list[achieve_indx]
  if data.is_liked == 1 then
    return
  end
  Net:SendProto("main.add_like", function(json)
    Group_add:SetActive(true)
    data.likes = data.likes + 1
    data.is_liked = 1
    View.self:SelectPlayAnim(Group_add, "Add", function()
      View.Group_Report.Group_LogList.ScrollGrid_List.grid.self:RefreshAllElement()
    end)
  end, data.key, data.receiver)
end
controller.OpenReportPanel = OpenReportPanel
controller.ShowLevelInfo = ShowLevelInfo
controller.ShowLevelRewardInfo = ShowLevelRewardInfo
controller.ShowRewardInfoPanel = ShowRewardInfoPanel
controller.ShowPersonalInfo = ShowPersonalInfo
controller.Share2Online = Share2Online
controller.StartBattle = StartBattle
controller.CancelShare = CancelShare
controller.ShowOnlineInfo = ShowOnlineInfo
controller.StartOnlineBattle = StartOnlineBattle
controller.RefreshOnlineInfo = RefreshOnlineInfo
controller.ShowCompleteInfo = ShowCompleteInfo
controller.RecvRewards = RecvRewards
controller.AddLikeNum = AddLikeNum
return controller
