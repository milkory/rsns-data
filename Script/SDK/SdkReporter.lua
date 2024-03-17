local SdkReporter = {}

function SdkReporter.Init()
  SdkReporter.sentBuy = {}
end

function SdkReporter.GetGameSdkLuaface()
  return CS.GameSdkLuaface
end

function SdkReporter.TrackLogin(isSuccess)
  SdkHelper.TrackLogin2(nil, SdkConst.default, isSuccess)
end

function SdkReporter.TrackEnterGame(uid)
  if not SdkHelper.IsTypeString(uid) then
    return
  end
  local t = {account_id = uid}
  CS.GameSdkLuaface.TrackEnterGame(t)
end

function SdkReporter.TrackLogout()
  SdkHelper.TrackCustom(SdkConst.EvtName.logout)
end

function SdkReporter.TrackCreateRole()
  SdkHelper.TrackCustom(SdkConst.EvtName.create_role)
end

function SdkReporter.TrackLevelUp(level, levelBefore)
  SdkHelper.TrackCustom(SdkConst.EvtName.level_up, {
    [SdkConst.EvtProp.level] = level,
    [SdkConst.EvtProp.level_before] = levelBefore
  })
end

function SdkReporter.TrackGuideComplete(guideId)
  SdkHelper.TrackCustom(SdkConst.EvtName.guide_complete, {
    [SdkConst.EvtProp.id] = guideId
  })
end

function SdkReporter.TrackDrawCard(pond_id, draw_type, draw_num, get_item_info)
  local t = {
    [SdkConst.EvtProp_DrawCard.pond_id] = pond_id,
    [SdkConst.EvtProp_DrawCard.draw_num] = draw_num,
    [SdkConst.EvtProp_DrawCard.get_item_info] = SdkHelper.ConvertTableToArrayStr(get_item_info)
  }
  SdkHelper.TrackCustom(SdkConst.EvtName.draw_card, t)
end

function SdkReporter.CheckSentBuy(order_id)
  if SdkReporter.sentBuy == nil then
    SdkReporter.sentBuy = {}
  end
  if SdkReporter.sentBuy[order_id] ~= nil then
    return true
  end
  SdkReporter.sentBuy[order_id] = true
  return false
end

function SdkReporter.TrackBuy(order_id, pay_amount, currency_type, pay_type, product_id, product_name, paystatus)
  local args = {
    order_id = order_id or "nil",
    pay_amount = pay_amount,
    currency_type = currency_type,
    pay_type = pay_type,
    product_id = product_id,
    paystatus = paystatus,
    product_num = 1,
    product_name = product_name or "nil"
  }
  CS.GameSdkLuaface.TrackBuy(args)
end

function SdkReporter.TrackBuySuccess(order_id, pay_amount, pay_type, product_id, product_name)
  if SdkReporter.CheckSentBuy(order_id) then
    return
  end
  local currencyType = PayHelper.GetCurrencyTypeStr()
  SdkReporter.TrackBuy(order_id, pay_amount, currencyType, pay_type, product_id, product_name, 0)
  TrackingIO2Reporter.Setryzf(order_id, pay_type, currencyType, pay_amount)
  JuLiangEngineHelper.OnEventPurchase("default", product_name, product_id, 1, pay_type, currencyType, true, pay_amount)
end

function SdkReporter.TrackBuyFail(order_id, pay_amount, pay_type, product_id, product_name)
  if SdkReporter.CheckSentBuy(order_id) then
    return
  end
  local currencyType = PayHelper.GetCurrencyTypeStr()
  SdkReporter.TrackBuy(order_id, pay_amount, currencyType, pay_type, product_id, product_name, 1)
end

function SdkReporter.TrackOrder(order_id, pay_amount, currency_type, pay_type)
  local args = {
    order_id = order_id or "nil",
    pay_amount = pay_amount,
    currency_type = currency_type,
    pay_type = pay_type,
    status = "success"
  }
  CS.GameSdkLuaface.TrackOrder(args)
  TrackingIO2Reporter.SetDD(order_id, currency_type, pay_amount)
end

function SdkReporter.TrackUseDiamond(args)
  local t = {
    [SdkTrackConst.EvtProp.use_diamond_amount] = args.amount,
    [SdkTrackConst.EvtProp.use_diamond_from] = args.reason
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.use_diamond, t)
end

function SdkReporter.TrackGetDiamond(args)
  local t = {
    [SdkTrackConst.EvtProp.get_diamond_amount] = args.amount,
    [SdkTrackConst.EvtProp.get_diamond_from] = args.reason
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.get_diamond, t)
end

function SdkReporter.TrackBattleStart(level_id, level_difficulty)
  local t = {
    [SdkTrackConst.EvtProp.level_id] = level_id,
    [SdkTrackConst.EvtProp.level_difficulty] = level_difficulty
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.battle_start, t)
end

function SdkReporter.TrackBattleFinish(isWin, level_id, level_difficulty, get_item_info, duration, deck_info)
  if isWin then
    SdkReporter.TrackBattleWin(level_id, level_difficulty, get_item_info, duration, deck_info)
  else
    SdkReporter.TrackBattleFail(level_id, level_difficulty, duration, deck_info)
  end
end

function SdkReporter.TrackBattleWin(level_id, level_difficulty, get_item_info, duration, deck_info)
  local t = {
    [SdkTrackConst.EvtProp.level_id] = level_id,
    [SdkTrackConst.EvtProp.duration] = duration,
    [SdkTrackConst.EvtProp.level_difficulty] = level_difficulty
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.battle_win, t)
end

function SdkReporter.TrackBattleFail(level_id, level_difficulty, duration, deck_info)
  local t = {
    [SdkTrackConst.EvtProp.level_id] = level_id,
    [SdkTrackConst.EvtProp.duration] = duration,
    [SdkTrackConst.EvtProp.level_difficulty] = level_difficulty
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.battle_fail, t)
end

function SdkReporter.TrackExchangeCode(code)
  local t = {
    [SdkTrackConst.EvtProp.code] = code
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.exchange_code, t)
end

function SdkReporter.TrackCharacter(args)
  local t = {
    [SdkTrackConst.EvtProp.character_id] = args.hero_id,
    [SdkTrackConst.EvtProp.character_lv] = args.hero_level,
    [SdkTrackConst.EvtProp.character_state] = args.event_seq,
    [SdkTrackConst.EvtProp.resonance_Lv] = args.resonance_lv or 0,
    [SdkTrackConst.EvtProp.awaken_lv] = args.new_awaken or 0
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.character, t)
end

function SdkReporter.TrackGetCharacter(args)
  local t = {
    [SdkTrackConst.EvtProp.get_character_from] = args.reason,
    [SdkTrackConst.EvtProp.character_id] = args.hero_id
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.get_character, t)
end

function SdkReporter.TrackGetEmailReward(subject, content, onekey)
  local t = {
    [SdkTrackConst.EvtProp.is_claim_all] = onekey
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.get_email_reward, t)
end

function SdkReporter.TrackGetEquip(args)
  local t = {
    [SdkTrackConst.EvtProp.get_equip_from] = args.get_equip_from,
    [SdkTrackConst.EvtProp.equip_id] = args.equip_id
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.get_equip, t)
end

function SdkReporter.TrackEquip(args)
  local t = {
    [SdkTrackConst.EvtProp.equip_id] = args.equip_id,
    [SdkTrackConst.EvtProp.equip_lv] = args.equip_lv,
    [SdkTrackConst.EvtProp.cost_item] = args.cost_item,
    [SdkTrackConst.EvtProp.cost_equip] = args.cost_equip
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.equip, t)
end

function SdkReporter.TrackTaskComplete(args)
  local t = {
    [SdkTrackConst.EvtProp.task_id] = args.taskId
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.task_complete, t)
end

function SdkReporter.TrackTrain(args)
  local t = {
    [SdkTrackConst.EvtProp.train_elc_lv] = args.elcLv or 0,
    [SdkTrackConst.EvtProp.train_acc_lv] = args.accLv or 0,
    [SdkTrackConst.EvtProp.train_brake_lv] = args.brakeLv or 0
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.train, t)
end

function SdkReporter.TrackTrainMaint(args)
  local t = {
    [SdkTrackConst.EvtProp.train_clean] = args.clean or 0,
    [SdkTrackConst.EvtProp.train_repair] = args.repair or 0,
    [SdkTrackConst.EvtProp.train_maint] = args.maint or 0,
    [SdkTrackConst.EvtProp.train_maint_costtype] = args.costId or 0,
    [SdkTrackConst.EvtProp.train_maint_costamount] = args.cost or 0
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.train_maint, t)
end

function SdkReporter.TrackTrainWep(args)
  local t = {
    [SdkTrackConst.EvtProp.train_wep_id] = args.wepId or 0
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.train_wep, t)
end

function SdkReporter.TrackCar(args)
  local t = {
    [SdkTrackConst.EvtProp.create_car] = args.carId or 0
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.car, t)
end

function SdkReporter.TrackShopBuy(args)
  local t = {
    [SdkTrackConst.EvtProp.shop_id] = args.shopId or 0,
    [SdkTrackConst.EvtProp.shop_item_index] = args.index or 0,
    [SdkTrackConst.EvtProp.shop_item_id] = args.itemId or 0,
    [SdkTrackConst.EvtProp.shop_item_num] = args.num or 0
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.shop_buy, t)
end

function SdkReporter.TrackShopSell(args)
  local t = {
    [SdkTrackConst.EvtProp.shop_id] = args.shopId or 0,
    [SdkTrackConst.EvtProp.shop_item_index] = args.index or 0,
    [SdkTrackConst.EvtProp.shop_item_id] = args.itemId or 0
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.shop_sell, t)
end

function SdkReporter.TrackStationBuy(args)
  local t = {
    [SdkTrackConst.EvtProp.station_id] = args.stationId or 0,
    [SdkTrackConst.EvtProp.station_good_info_str] = args.goodStr or "nil",
    [SdkTrackConst.EvtProp.stationshop_price] = args.allPrice or 0,
    [SdkTrackConst.EvtProp.discount_value] = args.quato or "nil"
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.station_buy, t)
end

function SdkReporter.TrackStationSell(args)
  local t = {
    [SdkTrackConst.EvtProp.station_id] = args.stationId or 0,
    [SdkTrackConst.EvtProp.station_good_info_str] = args.goodStr or "nil",
    [SdkTrackConst.EvtProp.stationshop_price] = args.allPrice or 0,
    [SdkTrackConst.EvtProp.stationshop_profit] = args.profit or 0,
    [SdkTrackConst.EvtProp.discount_value] = args.quato or "nil"
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.station_sell, t)
end

function SdkReporter.TrackSignReward(args)
  local t = {
    [SdkTrackConst.EvtProp.sign_reward_id] = args.id or 0,
    [SdkTrackConst.EvtProp.sign_reward_day] = args.day or 0
  }
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.sign_reward, t)
end

SdkReporter.Init()
return SdkReporter
