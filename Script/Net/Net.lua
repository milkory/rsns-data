local Net = {
  sendGuideNO = 0,
  duration = 0,
  sendGuideMethodName = "",
  isWaitingResponse = false,
  updateGuideNoLimit = nil,
  firstGuideUpdateMethodName = "",
  firstGuide_step_index = -1,
  firstGuide_step_id = -1,
  isWaitingFirstGuideResponse = false,
  FailRepeatSendCode = {
    test = true,
    ["111"] = true,
    [80600026] = true,
    ["80600026"] = true
  },
  CacheProto = {},
  IsOpenTest = false,
  resources_version = -1,
  client_version = "*"
}
local protocol = require("Net/Protocol")
local mission_pro = {
  ["quest.list"] = 1,
  ["battle_pass.rec_pass_rewards"] = 1,
  ["quest.rec_quests_rewards"] = 1,
  ["item.recv_liveness_rewards"] = 1,
  ["quest.recv_rewards"] = 1,
  ["battle_pass.buy"] = 1
}
local squad_pro = {
  ["deck.preset"] = 1,
  ["deck.update_hero"] = 1,
  ["deck.set_deck"] = 1
}
local IsMatchClientVersion = function(version, versionStr)
  if versionStr == "" then
    return true
  end
  local tList = string.split(versionStr, ",")
  for key, value in ipairs(tList) do
    if value == "*" or value == version then
      return true
    end
  end
  return false
end
local IsMatchResourcesVersion = function(version, versionStr)
  if versionStr == "" then
    return true
  end
  local versionInt = tonumber(versionStr)
  local tagetVersionInt = tonumber(version:match("(%d+)$"))
  if versionInt < 0 or versionInt <= tagetVersionInt then
    return true
  end
  return false
end
local OnExitGame = function()
  CS.UnityEngine.Application.Quit()
end
local UpdateClient = function()
  local urlConfig = PlayerData:GetFactoryData(99900019).storeList
  local platform = HotfixSetting.platform
  local url = "http://soli-reso.com"
  for key, value in pairs(urlConfig) do
    if value.name == platform then
      url = value.adress
      break
    end
  end
  CS.UnityEngine.Application.OpenURL(url)
end
local HandleExtraReward = function(reward, cs_reward)
  local extra = {}
  for k, v in pairs(cs_reward) do
    for k1, v1 in pairs(v) do
      extra[k1] = v1
    end
  end
  for k, v in pairs(reward) do
    for k1, v1 in pairs(v) do
      if extra[k1] then
        v1.num = v1.num - extra[k1].num
      end
    end
  end
  reward.extra = extra
end

function Net.Callback(response, cb, failCb, protocol)
  local json = Json.decode(response)
  Net.resources_version = json.resources_version or -1
  Net.client_version = json.client_version or "*"
  print_r("<color=#00ff00ff>服务器=============>客户端</color>", json)
  if json.msg and json.msg ~= "" and type(json.msg) == "string" then
    Debug.LogError("<color=#00ff00ff>服务器错误信息：</color> " .. json.msg)
  end
  if Net.IsOpenTest and type(json.msg) == "string" then
    print_r("<color=#FFF000>服务器=============>客户端</color>特别的msg", json.msg)
  end
  if json.server_now then
    PlayerData.serverTimeOffset = TimeTool.UnixTimeStamp() - json.server_now
    PlayerData.ServerData.server_now = json.server_now
  end
  if json.rc == "" then
    if Net.CacheProto[cb] then
      Net.CacheProto[cb] = nil
    end
    if Net.isWaitingResponse == true then
      local tempGuideNo = Net.sendGuideNO
      Net.ResetGuideNo()
      SdkReporter.TrackGuideComplete(tempGuideNo)
      PlayerData:GetUserInfo().newbie_step = tempGuideNo
      GuideManager:SetGuideNO(tempGuideNo)
    end
    if Net.isWaitingFirstGuideResponse then
      Net.ResetFirstGuideData(true)
      Net.isWaitingFirstGuideResponse = false
    end
    if json.reward and table.count(json.reward) > 0 then
      local args = {}
      args.reward = json.reward
      args.protocolName = protocol
      PlayerData:AddRewardSever(args)
    end
    if json.monthly_card then
      PlayerData.ServerData.monthly_card = json.monthly_card
    end
    if json.req_back_num then
      PlayerData:GetHomeInfo().req_back_num = json.req_back_num
    end
    if json.monthly_req_back_num then
      PlayerData:GetHomeInfo().monthly_req_back_num = json.monthly_req_back_num
    end
    if json.consumables then
      PlayerData:RemoveRewardServer(json.consumables)
    end
    if json.quest_awards then
      PlayerData:SubQuestReward(json.reward, json.quest_awards)
    end
    if json.cs_reward then
      HandleExtraReward(json.reward, json.cs_reward)
    end
    if json.heros then
      PlayerData:RefreshRoles(json.heros)
    end
    if json.roles then
      PlayerData:RefreshRoles(json.roles)
    end
    if json.items then
      PlayerData:RefreshItem(json.items)
    end
    if json.chapter_level then
      PlayerData:RefreshChapterLevel(json.chapter_level)
    end
    if json.station_info then
      PlayerData:RefreshStationInfo(json.station_info)
    end
    if json.display_train then
      PlayerData:RefreshDisplayTrain(json.display_train)
    end
    if json.material then
      PlayerData:RefreshMaterial(json.material)
    end
    if json.goods then
      PlayerData:RefreshGoods(json.goods)
    end
    if json.equips then
      PlayerData:RefreshEquips(json.equips)
    end
    if json.user_info then
      PlayerData:RefreshUserInfo(json.user_info)
    end
    if json.cards then
      PlayerData:RefreshCards(json.cards)
    end
    if json.mails then
      PlayerData:RefreshMails(json.mails)
    end
    if json.shops then
      PlayerData:RefreshShops(json.shops)
    end
    if json.server_quests then
      PlayerData:RefreshActivityBuffByServerQuest(json.server_quests, protocol == nil)
    end
    if json.recharge_goods then
      PlayerData.RechargeGoods = json.recharge_goods
    end
    if json.reputation then
      PlayerData:RefreshReputation(json.reputation)
    else
      PlayerData.TempCache.repLvUpCache = nil
      if json.reward and json.reward.rep then
        PlayerData:RefreshRewardRep(json.reward.rep)
      end
    end
    if json.change_city then
      PlayerData:RefreshStationState(json.change_city)
    end
    if json.stations then
      PlayerData:RefreshStationsDriveNum(json.stations)
      PlayerData:RefreshStationsFairyland(json.stations)
    end
    if json.readiness then
      PlayerData:RefreshReadiness(json.readiness)
    end
    if json.dev_degree then
      PlayerData:RefreshDevDegree(json.dev_degree)
    end
    if json.home_battery then
      PlayerData:GetHomeInfo().home_battery = json.home_battery
    end
    if json.dress then
      PlayerData.ServerData.dress = json.dress.dress
      PlayerData.ServerData.guard = json.dress.guard
    end
    if json.plot_paragraph then
      PlayerData:RefreshPlot_paragraph(json.plot_paragraph)
    end
    if json.enemies then
      PlayerData:RefreshEnemies(json.enemies)
    end
    if json.books then
      local books = json.books
      if json.books.music then
        PlayerData:RefreshMusic(books.music)
      end
      if json.books.pictures then
        PlayerData:RefreshPictures(books.pictures)
      end
      if json.books.enemy then
        PlayerData:RefreshEnemy(books.enemy)
      end
      if json.books.photo then
        PlayerData:RefreshPhoto(books.photo)
      end
      if json.books.video then
        PlayerData:RefreshVideo(books.video)
      end
      if json.books.sound then
        PlayerData:RefreshSound(books.sound)
      end
      if json.books.card_pack then
        PlayerData:RefreshCardPack(books.card_pack)
      end
    end
    if json.construction then
      PlayerData:RefreshConstruction(json.construction)
    end
    if json.change_order then
      PlayerData:RefreshOrders(json.change_order)
    end
    if json.update_quests then
      PlayerData:UpdateQuestData(json.update_quests)
    end
    if json.server_quests then
      PlayerData.RefreshServerQuests(json.server_quests)
    end
    if json.pollute_areas then
      PlayerData:RefrshPolluteLines(json.pollute_areas)
    end
    if json.areas then
      PlayerData:GetHomeInfo().areas = json.areas
    end
    if json.plots then
      PlayerData:RefreshGotWord(json.plots.data_bank)
    end
    if json.data_bank then
      PlayerData:RefreshGotWord(json.data_bank)
    end
    if protocol then
      GuideManager:ProtocolCallback(protocol)
      if mission_pro[protocol] then
        PlayerData.MissionRefreshState = true
      end
      if squad_pro[protocol] then
        PlayerData:GetAwakeEquipRed()
      end
    end
    if PlayerData.TempCache.AutoCompleteLevels then
      GuideManager:CompleteQuestCallBack(PlayerData.TempCache.AutoCompleteLevels)
    end
    if json.user_info and json.user_info.retry_login == 1 then
      CommonTips.OnPromptConfirmOnly("80600171", "80600068", function()
        CBus:NewLogout()
      end, false)
    else
      if cb ~= nil then
        cb(json)
      end
      if protocol then
        PlayerData:ProtocolCallback(protocol)
      end
      if json.update_quests and json.update_quests.achieve_quests then
        PlayerData:UpdateAchieveData(json.update_quests.achieve_quests)
      end
      if protocol ~= "battle.end_battle" and protocol ~= "station.arrive" and protocol ~= "shop.buy" then
        CommonTips.OpenQuestsCompleteTip()
      end
    end
  else
    if json.rc == "80601508" then
      if failCb then
        failCb(json)
      end
      return
    end
    if Net.CacheProto[cb] and Net.FailRepeatSendCode[json.rc] then
      ServerConnectManager:Add(Net.CacheProto[cb], true)
      CommonTips.OnPromptConfirmOnly(json.msg, "80600068", function()
        ServerConnectManager:RepeatSpecialProtocol()
      end, function()
        CBus:NewLogout()
      end, false)
      return
    end
    if json.rc == "undisplay" then
      return
    end
    if json.rc == 1007 or json.rc == 1011 then
      CommonTips.OpenTips("身份证号格式校验失败")
    elseif json.msg ~= nil and json.msg ~= "" then
      print_r(protocol)
      print_r("-----------protocol--------------")
      if not UseGSDK or protocol ~= "pay.query_oid" then
        CommonTips.OpenTips(json.msg)
      end
    end
    if json.rc == "80600058" then
      CommonTips.OnPromptConfirmOnly("80601507", nil, function()
        CBus:NewLogout()
      end, false)
      return
    end
    if failCb then
      failCb(json)
    end
  end
end

function Net:SendProto(methodName, cb, ...)
  if IsMatchResourcesVersion(HotfixSetting.serverPatchVersion, Net.resources_version) == false then
    CommonTips.OnPromptConfirmOnly("80602199", "80600068", function()
      OnExitGame()
    end, false)
    return
  end
  if IsMatchClientVersion(GameSetting.version, Net.client_version) == false then
    CommonTips.OnPromptConfirmOnly("80602200", "80602201", function()
      UpdateClient()
      OnExitGame()
    end, false)
    return
  end
  local params = protocol[methodName](...)
  local data = {}
  local failCb
  for k, v in pairs(params) do
    if type(v) == "table" then
      if #v == 0 then
        data[k] = ""
        for a, b in pairs(v) do
          data[k] = data[k] .. a .. ":" .. b .. ","
        end
      else
        data[k] = table.concat(v, "&")
      end
    elseif type(v) == "function" then
      failCb = v
    else
      data[k] = v
    end
  end
  if Net.sendGuideMethodName == methodName then
    local canUpdate = true
    if Net.updateGuideNoLimit then
      canUpdate = true
      for k, v in pairs(Net.updateGuideNoLimit) do
        if k == EnumDefine.GuideNoUpdateLimitDataEnum.CheckLevelMod then
          local levelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId, "LevelFactory")
          canUpdate = canUpdate and levelCA.mod == tostring(v)
        elseif PlayerData.TempCache.GuideNoUpdateLimitData[k] then
          canUpdate = canUpdate and tostring(PlayerData.TempCache.GuideNoUpdateLimitData[k]) == tostring(v)
        else
          canUpdate = canUpdate and tostring(data[k]) == tostring(v)
        end
      end
    end
    if canUpdate then
      data.newbie_step = Net.sendGuideNO
      Net.isWaitingResponse = true
    end
  elseif Net.sendGuideNO >= 999 then
    data.newbie_step = Net.sendGuideNO
    Net.isWaitingResponse = true
  end
  if Net.firstGuideUpdateMethodName == methodName then
    data.step_index = Net.firstGuide_step_index
    data.step_id = Net.firstGuide_step_id
    Net.isWaitingFirstGuideResponse = true
  end
  data.remote_id = PlayerData.RemoteId
  print_r("<color=#00ffffff>客户端=============>服务器</color>", methodName, data)
  if cb then
    self.CacheProto[cb] = {
      methodName = methodName,
      params = data,
      pid = PlayerData.pid,
      platform = PlayerData.platform,
      cb = function(response)
        self.Callback(response, cb, failCb, methodName)
      end
    }
  end
  ServerConnectManager:Add({
    methodName = methodName,
    params = data,
    pid = PlayerData.pid,
    platform = PlayerData.platform,
    cb = function(response)
      self.Callback(response, cb, failCb, methodName)
    end
  })
end

function Net.GetServeTimeOffset(cb)
  cb(PlayerData.serverTimeOffset)
end

function Net.SendGuideNO(methodName, guideNO, duration, isAtOnce)
  Net.sendGuideMethodName = methodName
  Net.sendGuideNO = guideNO
  Net.duration = duration
  if isAtOnce then
    Net:SendProto("main.newbie_step", function(json)
    end)
  end
end

function Net.ResetGuideNo()
  Net.sendGuideMethodName = ""
  Net.sendGuideNO = 0
  Net.duration = 0
  Net.updateGuideNoLimit = nil
  Net.isWaitingResponse = false
end

function Net.SetGuideNoUpdateLimit(key, value)
  if Net.updateGuideNoLimit == nil then
    Net.updateGuideNoLimit = {}
  end
  Net.updateGuideNoLimit[key] = value
end

function Net.SetFirstGuideUpdateData(methodName, step_index, step_id)
  Net.firstGuideUpdateMethodName = methodName
  Net.firstGuide_step_index = step_index
  Net.firstGuide_step_id = step_id
end

function Net.ResetFirstGuideData(isComplete)
  local tempStepId = Net.firstGuide_step_id
  Net.firstGuideUpdateMethodName = ""
  Net.firstGuide_step_index = -1
  Net.firstGuide_step_id = -1
  if isComplete == true then
    GuideManager:CompletePanelTriggerGuideId(tempStepId)
  end
end

return Net
