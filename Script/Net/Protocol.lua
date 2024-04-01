local Protocol = {}
Protocol["main.index"] = function()
  return {}
end
Protocol["main.notice"] = function()
  return {}
end
Protocol["deck.set_deck"] = function(squadIndex, roles, hid, failCb)
  return {
    squadIndex = squadIndex,
    roleId = roles,
    hid = hid,
    failCb = failCb
  }
end
Protocol["deck.set_name"] = function(squadIndex, squadName)
  return {squadIndex = squadIndex, squadName = squadName}
end
Protocol["hero.breakthrough"] = function(roleId)
  return {roleId = roleId}
end
Protocol["hero.awakening"] = function(roleId)
  return {roleId = roleId}
end
Protocol["hero.resonance"] = function(roleId, itemArr)
  return {roleId = roleId, itemArr = itemArr}
end
Protocol["hero.upgrade_skill"] = function(roleId, skillIndex)
  return {roleId = roleId, skillIndex = skillIndex}
end
Protocol["equip.forging"] = function(forgeId)
  return {forgeId = forgeId}
end
Protocol["equip.resolve"] = function(equipmentId)
  return {equipmentId = equipmentId}
end
Protocol["hero.set_equips"] = function(roleId, equipId, index)
  return {
    roleId = roleId,
    equipId = equipId,
    index = index
  }
end
Protocol["shop.info"] = function(shopIds)
  return {shopIds = shopIds}
end
Protocol["shop.buy"] = function(shopId, itemIndex, num, itemId)
  return {
    shopId = shopId,
    itemIndex = itemIndex,
    num = num,
    itemId = itemId or ""
  }
end
Protocol["item.recycle_material"] = function(materialIds)
  return {materialIds = materialIds}
end
Protocol["shop.refresh"] = function(shopId)
  return {shopId = shopId}
end
Protocol["battle.start_battle"] = function(levelId, eventId, squadIndex, levelType, levelIndex, isEvent, eventIndex, sid, levelKey, failCb, difficulty, next_distance, areaId, coreId)
  if eventIndex then
    if areaId then
      return {
        levelId = tostring(levelId),
        sid = sid,
        eventId = eventId == nil and "" or tostring(eventId),
        squadIndex = math.floor(squadIndex),
        eventIndex = eventIndex,
        levelType = levelType,
        isEvent = isEvent,
        failCb = failCb,
        difficulty = difficulty or 1,
        areaId = areaId,
        coreId = coreId
      }
    else
      return {
        levelId = tostring(levelId),
        sid = sid,
        eventId = eventId == nil and "" or tostring(eventId),
        squadIndex = math.floor(squadIndex),
        eventIndex = eventIndex,
        levelType = levelType,
        isEvent = isEvent,
        failCb = failCb,
        difficulty = difficulty or 1,
        coreId = coreId
      }
    end
  else
    return {
      levelId = tostring(levelId),
      eventId = eventId == nil and "" or tostring(eventId),
      squadIndex = math.floor(squadIndex),
      levelType = levelType,
      levelIndex = levelIndex,
      isEvent = isEvent,
      levelKey = levelKey,
      failCb = failCb,
      difficulty = difficulty or 1,
      coreId = coreId
    }
  end
end
Protocol["battle.end_battle"] = function(levelUid, score, b_json, failCb, currentHP, completed, cores)
  return {
    levelUid = tostring(levelUid),
    score = tostring(score),
    bJson = b_json,
    failCb = failCb,
    currentHP = currentHP,
    completed = completed,
    cores = cores
  }
end
Protocol["main.set_receptionist"] = function(receptionistId)
  return {receptionistId = receptionistId}
end
Protocol["item.use_items"] = function(itemId, num, choice, itemType)
  return {
    itemId = itemId,
    num = num,
    choice = choice,
    itemType = itemType
  }
end
Protocol["meal.takeout"] = function(num)
  return {num = num}
end
Protocol["item.sell_items"] = function(itemId, num)
  return {itemId = itemId, num = num}
end
Protocol["main.set_rolename"] = function(role_name, failCb)
  return {role_name = role_name, failCb = failCb}
end
Protocol["main.paid_name"] = function(role_name, failCb)
  return {role_name = role_name, failCb = failCb}
end
Protocol["main.set_sign"] = function(sign)
  return {sign = sign}
end
Protocol["main.set_property"] = function(coin)
  return {
    attrs = "gold=" .. coin
  }
end
Protocol["recruit.do_recruit"] = function(poolID, num, failCb)
  return {
    poolID = poolID,
    num = num,
    failCb = failCb
  }
end
Protocol["battle.info"] = function()
  return {}
end
Protocol["mail.get"] = function()
  return {}
end
Protocol["mail.accredit"] = function(key)
  return {key = key}
end
Protocol["mail.read"] = function(key)
  return {key = key}
end
Protocol["mail.delete"] = function(key, del_all)
  return {
    key = key,
    del_all = del_all or 0
  }
end
Protocol["mail.receive_award"] = function(key, recv_all)
  return {
    key = key,
    recv_all = recv_all or 0
  }
end
Protocol["friend.get_lists"] = function()
  return {}
end
Protocol["friend.search"] = function(content)
  return {
    content = tostring(content)
  }
end
Protocol["friend.add_request"] = function(uid, re_word)
  return {
    uid = tostring(uid),
    re_word = tostring(re_word)
  }
end
Protocol["friend.accept_request"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["friend.refuse_request"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["friend.delete"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["friend.add_blacklist"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["friend.remove_blacklist"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["zone.get_msg"] = function(uid)
  return {
    uid = tostring(uid)
  }
end
Protocol["zone.leave_msg"] = function(uid, content)
  return {
    uid = tostring(uid),
    content = tostring(content)
  }
end
Protocol["zone.reply_msg"] = function(content, m_index)
  return {
    content = tostring(content),
    m_index = tostring(m_index)
  }
end
Protocol["zone.del_msg"] = function(m_index)
  return {
    m_index = tostring(m_index)
  }
end
Protocol["zone.set_permission"] = function(set_type)
  return {set_type = set_type}
end
Protocol["quest.recv_rewards"] = function(qid)
  return {
    qid = tostring(qid)
  }
end
Protocol["quest.accumulate"] = function(index)
  return {index = index}
end
Protocol["quest.receive_quests"] = function(quests)
  return {quests = quests}
end
Protocol["quest.rec_quests_rewards"] = function()
  return {}
end
Protocol["quest.accept"] = function(qid)
  return {qid = qid}
end
Protocol["pass.rec_pass_rewards"] = function()
  return {}
end
Protocol["hero.add_exp_by_material"] = function(roleId, itemArr)
  return {roleId = roleId, itemArr = itemArr}
end
Protocol["item.recv_liveness_rewards"] = function(index)
  return {
    index = math.floor(index)
  }
end
Protocol["item.rec_weekly_rewards"] = function(index)
  return {
    index = math.floor(index)
  }
end
Protocol["battle_pass.rec_pass_rewards"] = function(passType, passIndex, rec_all)
  return {
    passType = passType,
    passIndex = passIndex,
    rec_all = rec_all
  }
end
Protocol["battle_pass.buy"] = function(index)
  return {index = index}
end
Protocol["battle_pass.upgrade"] = function(num)
  return {num = num}
end
Protocol["main.set_real_info"] = function(id_card, real_name)
  return {id_card = id_card, real_name = real_name}
end
Protocol["battle.source_chapter"] = function()
  return {}
end
Protocol["battle.academy_awards"] = function(levelId)
  return {
    levelId = tostring(levelId)
  }
end
Protocol["main.verify_user"] = function(access_token)
  return {access_token = access_token}
end
Protocol["main.sign_in"] = function(activeSigninId)
  return {
    activeSigninId = tostring(activeSigninId)
  }
end
Protocol["shop.receive_awards"] = function(shopId, awardIndex)
  return {
    shopId = tostring(shopId),
    awardIndex = tostring(awardIndex)
  }
end
Protocol["shop.shop_card"] = function(itemId)
  return {
    itemId = tostring(itemId)
  }
end
Protocol["shop.purchase"] = function(itemId, shopId)
  return {
    itemId = tostring(itemId),
    shopId = tostring(shopId)
  }
end
Protocol["item.recycled"] = function(materialId, num)
  return {
    materialId = tostring(materialId),
    num = math.floor(num)
  }
end
Protocol["main.set_gender"] = function(genderId)
  return {gender = genderId}
end
Protocol["level_chain.open"] = function(LCId)
  return {levelChainId = LCId}
end
Protocol["level_chain.close"] = function()
  return {}
end
Protocol["card.update"] = function(roleId, skillCount)
  return {roleId = roleId, skillCount = skillCount}
end
Protocol["level_chain.set_buff"] = function(levelIndex, buffIndex)
  return {
    levelIndex = tostring(levelIndex),
    buffIndex = tostring(buffIndex)
  }
end
Protocol["level_chain.buff"] = function()
  return {}
end
Protocol["level_chain.finish"] = function()
  return {}
end
Protocol["home.study"] = function(coachId)
  return {coachId = coachId}
end
Protocol["home.build"] = function(coachId)
  return {coachId = coachId}
end
Protocol["home.decorate"] = function(furnitures, squadIndex, duration)
  return {
    furnitures = furnitures,
    squadIndex = squadIndex,
    duration = duration
  }
end
Protocol["home.open"] = function()
  return {}
end
Protocol["home.update_name"] = function(squadName)
  return {squadName = squadName}
end
Protocol["home.save_template"] = function(squadIndex, template)
  return {squadIndex = squadIndex, template = template}
end
Protocol["home.rename"] = function(squadIndex, squadName)
  return {squadIndex = squadIndex, squadName = squadName}
end
Protocol["deck.preset"] = function(roleId, skillCount, equipList, failCb)
  return {
    roleId = roleId,
    skillCount = skillCount,
    equipList = equipList,
    failCb = failCb
  }
end
Protocol["deck.update_hero"] = function(squadIndex, roleId, skills, equips, roleIndex, failCb)
  return {
    roleId = roleId,
    squadIndex = squadIndex,
    skills = skills,
    equips = equips,
    roleIndex = roleIndex,
    failCb = failCb
  }
end
Protocol["main.set_avatar"] = function(avatarId)
  return {avatar = avatarId}
end
Protocol["home.unlock_battery"] = function(squadIndex, batteryIndex)
  return {squadIndex = squadIndex, batteryIndex = batteryIndex}
end
Protocol["home.set_train_weapon"] = function(coachWeaponId, isUnset, weaponIndex, coachId)
  return {
    coachWeaponId = coachWeaponId,
    isUnset = isUnset,
    weaponIndex = weaponIndex,
    coachId = coachId
  }
end
Protocol["home.unset_battery"] = function(squadIndex, batteryIndex, batteryId)
  return {
    squadIndex = squadIndex,
    batteryIndex = batteryIndex,
    batteryId = batteryId
  }
end
Protocol["station.start_drive"] = function(terminus)
  return {terminus = terminus}
end
Protocol["station.drive"] = function(sid)
  return {sid = sid}
end
Protocol["station.arrive"] = function(sid, isBack)
  return {
    sid = sid,
    isBack = isBack or 0
  }
end
Protocol["station.stop"] = function(sid, next_distance, failCb)
  return {
    sid = sid,
    next_distance = next_distance,
    failCb = failCb
  }
end
Protocol["station.auto_arrived"] = function(failCb, isBack)
  return {
    isBack = isBack or 0,
    failCb = failCb
  }
end
Protocol["home.refuel"] = function(buy_num)
  return {buy_num = buy_num}
end
Protocol["station.accelerate"] = function(failCb)
  return {failCb = failCb}
end
Protocol["station.back_home_to_station"] = function()
  return {}
end
Protocol["home.update_electric"] = function()
  return {}
end
Protocol["home.open_electric_slot"] = function()
  return {}
end
Protocol["station.get_awards"] = function()
  return {}
end
Protocol["meal.info"] = function()
  return {}
end
Protocol["meal.eat"] = function(mealId, orderIndex)
  return {mealId = mealId, orderIndex = orderIndex}
end
Protocol["meal.mark_score"] = function(mealId, score)
  return {mealId = mealId, score = score}
end
Protocol["meal.take_out"] = function()
  return {}
end
Protocol["meal.sale"] = function(mealId)
  return {mealId = mealId}
end
Protocol["station.info"] = function(sid)
  return {sid = sid}
end
Protocol["station.up_price"] = function()
  return {}
end
Protocol["station.down_price"] = function()
  return {}
end
Protocol["station.buy"] = function(goodsArr)
  return {goodsArr = goodsArr}
end
Protocol["station.sell"] = function(goodsArr)
  return {goodsArr = goodsArr}
end
Protocol["building.clean"] = function(bdId)
  return {bdId = bdId}
end
Protocol["building.env_reward"] = function(index, bdId)
  return {index = index, bdId = bdId}
end
Protocol["station.get_quest"] = function(questIds)
  return {questIds = questIds}
end
Protocol["station.complete_quest"] = function(questIds)
  return {questIds = questIds}
end
Protocol["station.add_quest"] = function()
  return {}
end
Protocol["station.reset_quest"] = function(questIds)
  return {questIds = questIds}
end
Protocol["creature.place"] = function(uFid, creatureIds)
  return {uFid = uFid, creatureIds = creatureIds}
end
Protocol["creature.rec_rewards"] = function(uFid, cancel)
  return {uFid = uFid, cancel = cancel}
end
Protocol["creature.place_fish"] = function(uFid, fishIds, uSkin, failCb)
  return {
    uFid = uFid,
    fishIds = fishIds,
    uSkin = uSkin,
    failCb = failCb
  }
end
Protocol["recruit.cap_info"] = function()
  return {}
end
Protocol["recruit.do_caps"] = function(poolID, num)
  return {poolID = poolID, num = num}
end
Protocol["creature.plant"] = function(uFid, plantId, plantIndex)
  return {
    uFid = uFid,
    plantId = tostring(plantId),
    plantIndex = plantIndex
  }
end
Protocol["creature.remove_plant"] = function(uFid, plantIndex, uproot)
  return {
    uFid = uFid,
    plantIndex = plantIndex,
    uproot = uproot
  }
end
Protocol["hero.check_in"] = function(uFid, roleId, failCb)
  return {
    uFid = uFid,
    roleId = roleId,
    failCb = failCb
  }
end
Protocol["hero.photo"] = function(hid)
  return {hid = hid}
end
Protocol["hero.update_skin"] = function(typeId, skinId)
  return {typeId = typeId, skinId = skinId}
end
Protocol["home.update_skin"] = function(skinId, coachId)
  return {skinId = skinId, coachId = coachId}
end
Protocol["home.load_template"] = function(preIndex)
  return {preIndex = preIndex}
end
Protocol["home.save_coach"] = function(preIndex, coachIds)
  return {preIndex = preIndex, coachIds = coachIds}
end
Protocol["home.collect_waste"] = function(coachId, uFid)
  return {coachId = coachId, uFid = uFid}
end
Protocol["battle.adventure"] = function(levelId)
  return {levelId = levelId}
end
Protocol["adventure.adv_info"] = function()
  return {}
end
Protocol["adventure.end_adv"] = function(advReward)
  return {advReward = advReward}
end
Protocol["pet.feed"] = function(petId)
  return {petId = petId}
end
Protocol["pet.interact"] = function(petId)
  return {petId = petId}
end
Protocol["pet.add_pet_favor"] = function(petId, itemAttr)
  return {petId = petId, itemAttr = itemAttr}
end
Protocol["pet.upgrade"] = function(petId)
  return {petId = petId}
end
Protocol["station.drink"] = function(index)
  return {index = index}
end
Protocol["main.add_energy"] = function(num)
  return {num = num}
end
Protocol["station.refresh"] = function(sid)
  return {sid = sid}
end
Protocol["station.security"] = function(levelId)
  return {levelId = levelId}
end
Protocol["building.level"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["quest.list"] = function(type, sid)
  return {type = type, sid = sid}
end
Protocol["station.rep_reward"] = function(index)
  return {index = index}
end
Protocol["station.goods_info"] = function()
  return {}
end
Protocol["station.purchase_order"] = function(useNum)
  return {useNum = useNum}
end
Protocol["station.refresh_dicker"] = function()
  return {}
end
Protocol["equip.lock"] = function(lockedIds, unlockIds)
  return {lockedIds = lockedIds, unlockIds = unlockIds}
end
Protocol["equip.upgrade"] = function(equipId, costExp, equipList)
  return {
    equipId = equipId,
    costExp = costExp,
    equipList = equipList
  }
end
Protocol["equip.set_affix"] = function(equipId, affixIndex)
  return {equipId = equipId, affixIndex = affixIndex}
end
Protocol["equip.set_item_affix"] = function(equipId, itemId)
  return {equipId = equipId, itemId = itemId}
end
Protocol["hero.set_equip"] = function(roleId, equipId, unset)
  return {
    roleId = roleId,
    equipId = equipId,
    unset = unset
  }
end
Protocol["hero.save"] = function(roleId, equipList, preIndex)
  return {
    roleId = roleId,
    equipList = equipList,
    preIndex = preIndex
  }
end
Protocol["hero.load"] = function(roleId, preIndex)
  return {roleId = roleId, preIndex = preIndex}
end
Protocol["main.newbie_step"] = function()
  return {}
end
Protocol["station.invest"] = function(index)
  return {index = index}
end
Protocol["station.refresh_invest"] = function()
  return {}
end
Protocol["furniture.upgrade"] = function(uFid)
  return {uFid = uFid}
end
Protocol["main.rec_trust"] = function()
  return {}
end
Protocol["main.read"] = function(anyId, type)
  return {anyId = anyId, type = type}
end
Protocol["furniture.redecorate"] = function(uFid, uSkin)
  return {uFid = uFid, uSkin = uSkin}
end
Protocol["home.update_auto"] = function(auto_repair, auto_maintain, auto_wash, auto_fuel)
  return {
    auto_repair = auto_repair,
    auto_maintain = auto_maintain,
    auto_wash = auto_wash,
    auto_fuel = auto_fuel
  }
end
Protocol["home.repair"] = function()
  return {}
end
Protocol["home.skip"] = function()
  return {}
end
Protocol["home.get_coach"] = function()
  return {}
end
Protocol["home.expand"] = function()
  return {}
end
Protocol["home.maintain"] = function()
  return {}
end
Protocol["home.wash"] = function()
  return {}
end
Protocol["plot.info"] = function()
  return {}
end
Protocol["plot.dialog"] = function(paragraphId)
  return {paragraphId = paragraphId}
end
Protocol["plot.note"] = function(paragraphId)
  return {paragraphId = paragraphId}
end
Protocol["pet.check_in"] = function(petId, uFid)
  return {petId = petId, uFid = uFid}
end
Protocol["pet.bind"] = function(petId, roleId)
  return {petId = petId, roleId = roleId}
end
Protocol["pet.food"] = function(material, uFid)
  return {material = material, uFid = uFid}
end
Protocol["pet.feed"] = function(petId, material)
  return {material = material, petId = petId}
end
Protocol["pet.interact"] = function(petId, uFid)
  return {uFid = uFid, petId = petId}
end
Protocol["pet.rename"] = function(petId, name)
  return {petId = petId, name = name}
end
Protocol["furniture.rename"] = function(uFid, name)
  return {uFid = uFid, name = name}
end
Protocol["home.update_coach_name"] = function(coachName, userCid)
  return {coachName = coachName, userCid = userCid}
end
Protocol["station.expand_warehouse"] = function(num)
  return {num = num}
end
Protocol["station.deal_with_goods"] = function(storageArr, getArr)
  return {storageArr = storageArr, getArr = getArr}
end
Protocol["station.special_goods"] = function()
  return {}
end
Protocol["meal.fried_chicken"] = function(foodId, roleId)
  return {foodId = foodId, roleId = roleId}
end
Protocol["hero.change_skin"] = function(hid, skinId, isSpan2)
  return {
    hid = hid,
    skinId = skinId,
    isSpan2 = isSpan2
  }
end
Protocol["building.plot"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["home.update_fuel"] = function()
  return {}
end
Protocol["events.happen"] = function(eventId, sid, index, failCb)
  return {
    eventId = eventId,
    sid = sid,
    selectIndex = index,
    failCb = failCb
  }
end
Protocol["events.assault"] = function(eventId, sid, currentSpeed, failCb)
  return {
    eventId = eventId,
    sid = sid,
    currentSpeed = currentSpeed,
    failCb = failCb
  }
end
Protocol["home.rank_reward"] = function(index)
  return {index = index}
end
Protocol["building.reward_level"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["shop.recycle"] = function(shopId, goodId, itemId, num)
  return {
    shopId = shopId,
    goodId = goodId,
    itemId = itemId,
    num = num
  }
end
Protocol["home.refresh_coach"] = function()
  return {}
end
Protocol["home.rec_coach_waste"] = function(coachId)
  return {coachId = coachId}
end
Protocol["station.psg_source_info"] = function()
  return {}
end
Protocol["station.overprint_leaflet"] = function(num)
  return {num = num}
end
Protocol["station.attract_psg"] = function(sourceType, terminus, leaflet_num, cityPid, poolId)
  return {
    sourceType = sourceType,
    terminus = terminus,
    leaflet_num = leaflet_num,
    cityPid = cityPid,
    poolId = poolId
  }
end
Protocol["station.complete_order"] = function(orderIndex)
  return {orderIndex = orderIndex}
end
Protocol["station.get_stage_reward"] = function(conIndex, index, rewardType)
  return {
    conIndex = conIndex,
    index = index,
    rewardType = rewardType
  }
end
Protocol["station.refresh_order"] = function(orderIndex)
  return {orderIndex = orderIndex}
end
Protocol["station.mark_order"] = function(orderIndex)
  return {orderIndex = orderIndex}
end
Protocol["main.rank"] = function(rank_type, time_type, lv_sec, sid)
  return {
    rank_type = rank_type,
    time_type = time_type,
    lv_sec = lv_sec,
    sid = sid
  }
end
Protocol["unification.world_pollute"] = function()
  return {}
end
Protocol["main.use_code"] = function(code, failCb)
  return {code = code, failCb = failCb}
end
Protocol["home.clean_status"] = function()
  return {}
end
Protocol["plot.note_noun"] = function(nounIds)
  return {nounIds = nounIds}
end
Protocol["home.cultivate"] = function(cultivate_choose)
  return {cultivate_choose = cultivate_choose}
end
Protocol["station.replenish"] = function()
  return {}
end
Protocol["adventure.set_flag"] = function(operId)
  return {opeId = operId}
end
Protocol["adventure.get_group"] = function(groupId)
  return {groupId = groupId}
end
Protocol["building.report_level"] = function(levelId)
  return {levelId = levelId}
end
Protocol["building.report_levels"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["building.share_level"] = function(levelKey, payNum)
  return {levelKey = levelKey, payNum = payNum}
end
Protocol["building.cancel_share"] = function(levelKey)
  return {levelKey = levelKey}
end
Protocol["building.recommend_levels"] = function(buildingId)
  return {buildingId = buildingId}
end
Protocol["main.add_like"] = function(levelKey, receiver)
  return {levelKey = levelKey, receiver = receiver}
end
Protocol["building.receive"] = function(levelKey)
  return {levelKey = levelKey}
end
Protocol["station.park_reward"] = function(isReceive)
  return {isReceive = isReceive}
end
Protocol["station.donate"] = function(index)
  return {index = index}
end
Protocol["station.get_stage_reward"] = function(conIndex, index, rewardType, rec_all)
  return {
    conIndex = conIndex,
    index = index,
    rewardType = rewardType,
    rec_all = rec_all
  }
end
Protocol["station.construction_info"] = function()
  return {}
end
Protocol["pay.biligame_order_str"] = function(productId, shopId)
  return {productId = productId, shopId = shopId}
end
Protocol["pay.create_oid"] = function(productId, shopId)
  return {productId = productId, shopId = shopId}
end
Protocol["pay.ios_charge_refresh"] = function(receipt, out_trade_no, transactionId, failCb)
  return {
    receipt = receipt,
    out_trade_no = out_trade_no,
    transactionId = transactionId,
    failCb = failCb
  }
end
Protocol["pay.order_str"] = function(productId, shopId)
  return {productId = productId, shopId = shopId}
end
Protocol["pay.query_oid"] = function(out_trade_no)
  return {out_trade_no = out_trade_no}
end
Protocol["pay.wx_query_appid"] = function(channelFg)
  return {channelFg = channelFg}
end
Protocol["pay.wx_order_str"] = function(productId, shopId, channelFg)
  return {
    productId = productId,
    shopId = shopId,
    channelFg = channelFg
  }
end
Protocol["home.make_train_weapon"] = function(trainWeaponId, coachWeaponId)
  return {trainWeaponId = trainWeaponId, coachWeaponId = coachWeaponId}
end
Protocol["building.expel_reward"] = function(listId, index)
  return {listId = listId, index = index}
end
Protocol["events.money_through"] = function(eventId)
  return {
    eventId = tostring(eventId)
  }
end
Protocol["main.festival_reward"] = function(index)
  return {index = index}
end
Protocol["main.cancel"] = function()
  return {}
end
Protocol["events.bait_through"] = function(eventId, num, itemId)
  return {
    eventId = tostring(eventId),
    num = tostring(num),
    itemId = tostring(itemId)
  }
end
Protocol["hero.dress"] = function(hid, dresses)
  return {hid = hid, dresses = dresses}
end
Protocol["furniture.compound"] = function(uFid, formulaId, num)
  return {
    uFid = uFid,
    formulaId = formulaId,
    num = num
  }
end
Protocol["core.upgrade"] = function(coreId)
  return {coreId = coreId}
end
Protocol["station.note_pointer"] = function(id)
  return {pointerId = id}
end
Protocol["main.overview"] = function()
  return {}
end
Protocol["home.unlock_skin"] = function(skinId, coachId)
  return {skinId = skinId, coachId = coachId}
end
Protocol["hero.info"] = function(roleId)
  return {roleId = roleId}
end
Protocol["main.monthly_card"] = function()
  return {}
end
Protocol["home.upgrade_train_weapon"] = function(coachWeaponId)
  return {coachWeaponId = coachWeaponId}
end
Protocol["station.req_back"] = function(sid)
  return {sid = sid}
end
Protocol["hero.read"] = function(roleId)
  return {roleId = roleId}
end
Protocol["hero.open_resonance"] = function(hid, hStatus)
  return {r_status = hStatus, hid = hid}
end
Protocol["hero.open_awake"] = function(hid, hStatus)
  return {a_status = hStatus, hid = hid}
end
Protocol["book.read_enemy"] = function(enemyId)
  return {enemyId = enemyId}
end
Protocol["item.bargain"] = function(itemId)
  return {itemId = itemId}
end
Protocol["core.rec_reward"] = function(coreId, index)
  return {coreId = coreId, index = index}
end
Protocol["recruit.records"] = function(tagId, pageSize, pageNum)
  return {
    tagId = tagId,
    pageSize = pageSize,
    pageNum = pageNum
  }
end
Protocol["main.participate"] = function(activityId)
  return {activityId = activityId}
end
Protocol["main.red"] = function(activityId)
  return {activityId = activityId}
end
Protocol["book.top_card"] = function(packId)
  return {packId = packId}
end
Protocol["main.recv_activity"] = function(activityId, questId)
  return {qid = questId, activityId = activityId}
end
Protocol["home.unlock_drive_setup"] = function(setUpType)
  return {setUpType = setUpType}
end
Protocol["pet.info"] = function(petIds)
  return {petIds = petIds}
end
return Protocol
