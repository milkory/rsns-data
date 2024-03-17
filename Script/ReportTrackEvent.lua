local ReportTrackEvent = {}
local index = 0
local getPublicParams = function()
  local jsonParams = {}
  local server_id = GameSetting.serverId
  local time = TimeUtil:GetServerTimeStamp()
  local user_name = PlayerPrefs.GetString("username")
  jsonParams.time = time
  jsonParams.server_id = server_id
  jsonParams.current_server_id = server_id
  jsonParams.user_unique_id = PlayerPrefs.GetString(user_name .. "openid")
  jsonParams.role_id = user_name
  jsonParams.app_id = 5187
  jsonParams.device_id = GSDKManager.AppService.DeviceID
  local collection_count = 0
  for k in pairs(PlayerData.ServerData.roles) do
    collection_count = collection_count + 1
  end
  jsonParams.hero_cnt = collection_count
  local levelData = PlayerData:GetFactoryData(PlayerData.last_level, "LevelFactory")
  local chapter = ""
  if levelData ~= nil then
    chapter = levelData.levelChapter .. " " .. levelData.levelName
  end
  jsonParams.round_process = chapter
  local role_level = 0
  local create_role_time = 0
  local role_name = ""
  local uid = ""
  local server_ip = PlayerData.ServerData.ip
  server_ip = server_ip or ""
  jsonParams.time_str = os.date("%X", time)
  local userInfo = PlayerData:GetUserInfo()
  if userInfo ~= nil then
    role_level = userInfo.lv
    create_role_time = userInfo.add_time
    role_name = userInfo.role_name
    uid = userInfo.uid
  end
  jsonParams.role_level = role_level
  jsonParams.vip_level = 0
  jsonParams.create_role_time = create_role_time
  jsonParams.role_name = role_name
  jsonParams.total_cost = 0
  jsonParams.ip = GSDKManager:GetIP()
  jsonParams.time_str = os.date("%X", time)
  index = index + 1
  jsonParams.uuid = tostring(jsonParams.app_id) .. "-" .. server_ip .. "-" .. tostring(jsonParams.time) .. "-" .. uid .. "-" .. tostring(index)
  return jsonParams
end

function ReportTrackEvent.create_role_success(params)
  if UseGSDK then
    local eventName = "create_role_success"
    local jsonParams = getPublicParams()
    jsonParams.is_user_first = params.is_user_first or 0
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.role_login_success(params)
  if UseGSDK then
    local eventName = "role_login_success"
    local jsonParams = getPublicParams()
    jsonParams.is_user_first = params.is_user_first or 0
    jsonParams.is_real = params.is_real or 1
    jsonParams.coin1 = params.coin1 or 0
    jsonParams.coin2 = params.coin2 or 0
    jsonParams.total_dur = params.total_dur or 0
    jsonParams.guild_id = params.guild_id or ""
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.role_logout(params)
  if UseGSDK then
    local eventName = "role_logout"
    local jsonParams = getPublicParams()
    jsonParams.is_real = params.is_real or 1
    jsonParams.duration = params.duration or 0
    jsonParams.coin1 = params.coin1 or 0
    jsonParams.coin2 = params.coin2 or 0
    jsonParams.guild_id = params.guild_id or ""
    jsonParams.activity_point = params.activity_point or 0
    jsonParams.total_dur = params.total_dur or 0
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.charge_flow(params)
  if UseGSDK then
    local eventName = "charge_flow"
    local jsonParams = getPublicParams()
    jsonParams.order_id = params.order_id or ""
    jsonParams.currency = params.currency or "CNY"
    jsonParams.reason = params.reason or 0
    jsonParams.amount = params.amount or 0
    jsonParams.is_firstpay = params.is_firstpay or 0
    jsonParams.product_id = params.product_id or ""
    jsonParams.goods_cnt = params.goods_cnt or 0
    jsonParams.pay_channel = params.pay_channel or 0
    jsonParams.goods_price = params.goods_price or 0
    jsonParams.goods_original_price = params.goods_original_price or 0
    jsonParams.discount = params.discount or 0
    jsonParams.event_seq = params.event_seq or ""
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.shop_flow(params)
  if UseGSDK then
    local eventName = "shop_flow"
    local jsonParams = getPublicParams()
    jsonParams.shop_type = params.shop_type or ""
    jsonParams.real_price = params.real_price or ""
    jsonParams.product_unit_price = params.product_unit_price or 0
    jsonParams.product_type = params.product_type or ""
    jsonParams.product_total_price = params.product_total_price or 0
    jsonParams.product_name = params.product_name or ""
    jsonParams.product_id = params.product_id or ""
    jsonParams.product_count = params.product_count or 0
    jsonParams.price_type = params.price_type or ""
    jsonParams.item_effect_days = params.item_effect_days or 0
    jsonParams.event_seq = params.event_seq or ""
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.money_flow(params)
  if UseGSDK then
    local eventName = "money_flow"
    local jsonParams = getPublicParams()
    jsonParams.coin_type = params.coin_type or "CNY"
    jsonParams.action = params.action or 1
    jsonParams.amount = params.amount or 0
    jsonParams.after_amount = params.after_amount or 0
    jsonParams.reason = params.reason or ""
    jsonParams.event_seq = params.event_seq or ""
    jsonParams.sub_reason = params.sub_reason or ""
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.item_flow(params)
  if UseGSDK then
    local eventName = "item_flow"
    local jsonParams = getPublicParams()
    jsonParams.event_seq = params.event_seq or ""
    jsonParams.reason = params.reason or ""
    jsonParams.item_type = params.item_type or 0
    jsonParams.item_name = params.item_name or ""
    jsonParams.item_id = params.item_id or 0
    jsonParams.item_effect_days = params.item_effect_days or 0
    jsonParams.before_amount = params.before_amount or 0
    jsonParams.amount = params.amount or 0
    jsonParams.remain_amount = params.remain_amount or 0
    jsonParams.action = params.action or 0
    jsonParams.sub_reason = params.sub_reason or ""
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.tutorial_flow(params)
  if UseGSDK then
    local eventName = "tutorial_flow"
    local jsonParams = getPublicParams()
    jsonParams.tutorial_id = params.tutorial_id or ""
    jsonParams.reason = params.reason or 0
    jsonParams.sub_tutorial_id = params.sub_tutorial_id or ""
    jsonParams.duration = params.duration or 0
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.exp_flow(params)
  if UseGSDK then
    local eventName = "exp_flow"
    local jsonParams = getPublicParams()
    jsonParams.exp_type = params.exp_type or 1
    jsonParams.reason = params.reason or ""
    jsonParams.original_exp = params.original_exp or 0
    jsonParams.amount = params.amount or 0
    jsonParams.current_exp = params.current_exp or 0
    jsonParams.is_levelup = params.is_levelup or 0
    jsonParams.original_level = params.original_level or 0
    jsonParams.current_level = params.current_level or 0
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.task_flow(params)
  if UseGSDK then
    local eventName = "task_flow"
    local jsonParams = getPublicParams()
    jsonParams.event_seq = params.event_seq or ""
    jsonParams.task_type = params.task_type or 0
    jsonParams.task_id = params.task_id or 0
    jsonParams.reason = params.reason or 0
    jsonParams.task_duration = params.task_duration or 0
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.gameplay_flow(params)
  if UseGSDK then
    local eventName = "gameplay_flow"
    local jsonParams = getPublicParams()
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.mail_flow(params)
  if UseGSDK then
    local eventName = "mail_flow"
    local jsonParams = getPublicParams()
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.social_flow(params)
  if UseGSDK then
    local eventName = "social_flow"
    local jsonParams = getPublicParams()
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.guild_flow(params)
  if UseGSDK then
    local eventName = "guild_flow"
    local jsonParams = getPublicParams()
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.rename_flow(params)
  if UseGSDK then
    local eventName = "rename_flow"
    local jsonParams = getPublicParams()
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.movept_flow(params)
  if UseGSDK then
    local eventName = "movept_flow"
    local jsonParams = getPublicParams()
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.guide_flow(params)
  if UseGSDK then
    local eventName = "guide_flow"
    local jsonParams = getPublicParams()
    jsonParams.net_status = params.net_status or -1
    jsonParams.guide_id = params.guide_id or 0
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.Guide_flow(guide_id)
  if UseGSDK then
    local net_status = GSDKManager.networkState
    if 2 < net_status then
      net_status = 2
    end
    ReportTrackEvent.guide_flow({net_status = net_status, guide_id = guide_id})
  end
end

function ReportTrackEvent.story_play(params)
  if UseGSDK then
    local eventName = "story_play"
    local jsonParams = getPublicParams()
    jsonParams.story_type = params.story_type or 1
    jsonParams.story_id = params.story_id or 0
    jsonParams.story_name = params.story_name or ""
    jsonParams.story_index = params.story_index or -1
    jsonParams.is_skipable = params.is_skipable or 1
    jsonParams.reason = params.reason or 0
    jsonParams.duration = params.duration or 0
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.Story_play(story_type, story_id, story_name, story_index, is_skipable, reason, duration)
  ReportTrackEvent.story_play({
    story_type = story_type,
    story_id = story_id,
    sn = story_name,
    story_index = story_index,
    is_skipable = is_skipable,
    reason = reason,
    duration = duration
  })
end

function ReportTrackEvent.Round_flow(flowList)
  local a = {}
  a["全局变化"] = flowList.reason or -1
  a["主线考核"] = flowList.round_type or -1
  a["第几章"] = flowList.chapter_id or -1
  a["关卡"] = flowList.episode_id or ""
  a["战斗时长"] = flowList.duration or -1
  a["是否首次挑战"] = flowList.is_first_time or -1
  a["累计挑战次数"] = flowList.challenge_times or -1
  a["挑战结果评价"] = flowList.challenge_grade or -1
  a["洗牌次数，即把牌打完几轮"] = flowList.shuffle_times or -1
  a["总抽卡数"] = flowList.card_take or -1
  a["总使用数"] = flowList.card_use or -1
  a["总获取能量点"] = flowList.energy_get or -1
  a["总消耗能量点"] = flowList.energy_cost or -1
  a["队长"] = flowList.leader_id or ""
  a["作战阵容"] = flowList.battle_cast or ""
  a["作战的伤害数据1"] = flowList.battle_statistic or ""
  a["作战的伤害数据2"] = flowList.battle_total or ""
  a["卡牌技能"] = flowList.battle_skill or ""
  a["战斗选择的卡牌"] = flowList.card_select or ""
  a["战斗中弃置记录"] = flowList.card_abandon or ""
  a["主动弃置卡牌的次数"] = flowList.card_abandon_times or -1
  print_r(a)
  print_r("战斗结算的数据格式 -------------------测试 ------------------测试 ----------------------------")
  if UseGSDK then
    local eventName = "round_flow"
    local jsonParams = getPublicParams()
    jsonParams.reason = flowList.reason or -1
    jsonParams.round_type = flowList.round_type or -1
    jsonParams.chapter_id = flowList.chapter_id or -1
    jsonParams.episode_id = flowList.episode_id or ""
    jsonParams.duration = flowList.duration or -1
    jsonParams.is_first_time = flowList.is_first_time or -1
    jsonParams.challenge_times = flowList.challenge_times or -1
    jsonParams.challenge_grade = flowList.challenge_grade or -1
    jsonParams.shuffle_times = flowList.shuffle_times or -1
    jsonParams.card_take = flowList.card_take or -1
    jsonParams.card_use = flowList.card_use or -1
    jsonParams.energy_get = flowList.energy_get or -1
    jsonParams.energy_cost = flowList.energy_cost or -1
    jsonParams.leader_id = flowList.leader_id or ""
    jsonParams.battle_cast = flowList.battle_cast or ""
    jsonParams.battle_statistic = flowList.battle_statistic or ""
    jsonParams.battle_total = flowList.battle_total or ""
    jsonParams.battle_skill = flowList.battle_skill or ""
    jsonParams.card_select = flowList.card_select or ""
    jsonParams.card_abandon = flowList.card_abandon or ""
    jsonParams.card_abandon_times = flowList.card_abandon_times or -1
    jsonParams.event = eventName
    jsonParams.b_json = flowList.b_json
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.hero_snapshot(params)
  if UseGSDK then
    local eventName = "hero_snapshot"
    local jsonParams = {}
    jsonParams.reason = params.reason or 0
    jsonParams.hero_get = params.hero_get or 0
    jsonParams.hero_store = params.hero_store or 0
    jsonParams.heros = params.heros or ""
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.hero_cast(params)
  if UseGSDK then
    local eventName = "hero_cast"
    local jsonParams = {}
    jsonParams.reason = params.reason or 0
    jsonParams.cast_index = params.cast_index or 0
    jsonParams.cast_oname = params.cast_oname or ""
    jsonParams.cast_nname = params.cast_nname or ""
    jsonParams.origin_cast = params.origin_cast or ""
    jsonParams.new_cast = params.new_cast or ""
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.awaken_flow(params)
  if UseGSDK then
    local eventName = "awaken_flow"
    local jsonParams = {}
    jsonParams.hero_id = params.hero_id or 0
    jsonParams.hero_name = params.hero_name or ""
    jsonParams.hero_level = params.hero_level or 0
    jsonParams.origin_awaken = params.origin_awaken or 0
    jsonParams.new_awaken = params.new_awaken or 0
    jsonParams.resource_cost = params.resource_cost or ""
    jsonParams.event_seq = params.event_seq or ""
    jsonParams.is_cast = params.is_cast or 0
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.break_flow(params)
  if UseGSDK then
    local eventName = "break_flow"
    local jsonParams = {}
    jsonParams.hero_id = params.hero_id or 0
    jsonParams.hero_name = params.hero_name or ""
    jsonParams.hero_level = params.hero_level or 0
    jsonParams.origin_break = params.origin_break or 0
    jsonParams.new_break = params.new_break or 0
    jsonParams.resource_cost = params.resource_cost or ""
    jsonParams.event_seq = params.event_seq or ""
    jsonParams.is_cast = params.is_cast or 0
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.skill_flow(params)
  if UseGSDK then
    local eventName = "skill_flow"
    local jsonParams = {}
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.equip_flow(params)
  if UseGSDK then
    local eventName = "equip_flow"
    local jsonParams = {}
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.base_flow(params)
  if UseGSDK then
    local eventName = "base_flow"
    local jsonParams = {}
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.recruit_flow(params)
  if UseGSDK then
    local eventName = "recruit_flow"
    local jsonParams = {}
    jsonParams.reason = params.reason or 0
    jsonParams.recruit_times_his = params.recruit_times_his or 0
    jsonParams.recruit_times_day = params.recruit_times_day or 0
    jsonParams.resource_cost = params.resource_cost or ""
    jsonParams.star_cnt3 = params.star_cnt3 or 0
    jsonParams.star_cnt4 = params.star_cnt4 or 0
    jsonParams.star_cnt5 = params.star_cnt5 or 0
    jsonParams.recruit_result = params.recruit_result or ""
    jsonParams.event_seq = params.event_seq or ""
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.hero_get(params)
  if UseGSDK then
    local eventName = "hero_get"
    local jsonParams = {}
    jsonParams.reason = params.reason or 0
    jsonParams.hero_id = params.hero_id or 0
    jsonParams.hero_name = params.hero_name or ""
    jsonParams.get_times = params.get_times or 0
    jsonParams.event_seq = params.event_seq or ""
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

function ReportTrackEvent.resonance_flow(params)
  if UseGSDK then
    local eventName = "resonance_flow"
    local jsonParams = {}
    jsonParams.event = eventName
    MGameManager.ReportTrackEvent(eventName, Json.encode(jsonParams))
  end
end

return ReportTrackEvent
