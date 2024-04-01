CommonTips = {}
CommonTips.parms = {}

function CommonTips.OpenDiscardTip(content, yesTxt, noTxt, yesFuc, noFuc, isText, isLoadingCanvas)
  local list = {}
  list.content = content
  list.yesTxt = yesTxt
  list.noTxt = noTxt
  if isText ~= true and tonumber(content) ~= nil and string.len(content) == 8 then
    list.content = GetText(content)
  end
  if isText ~= true and tonumber(yesTxt) ~= nil and string.len(yesTxt) == 8 then
    list.yesTxt = GetText(yesTxt)
  end
  if isText ~= true and tonumber(noTxt) ~= nil and string.len(noTxt) == 8 then
    list.noTxt = GetText(noTxt)
  end
  if isLoadingCanvas == nil then
    isLoadingCanvas = false
  end
  UIManager:Open("UI/Battle/GroupDiscardTip", Json.encode(list), yesFuc, noFuc, isLoadingCanvas)
end

function CommonTips.OnPrompt(content, yesTxt, noTxt, yesFuc, noFuc, isText, isBgClick, isLoadingCanvas, checkTipParam)
  if checkTipParam and checkTipParam.checkTipKey then
    if checkTipParam.checkTipType == nil then
      checkTipParam.checkTipType = 1
    end
    if PlayerData:GetNoPrompt(checkTipParam.checkTipKey, checkTipParam.checkTipType) then
      yesFuc()
      return
    end
  end
  local list = {}
  list.content = content
  list.yesTxt = yesTxt
  list.noTxt = noTxt
  list.isBgClick = isBgClick or false
  list.checkTipParam = checkTipParam
  if isText ~= true and tonumber(content) ~= nil and string.len(content) == 8 then
    list.content = GetText(content)
  end
  if isText ~= true and tonumber(yesTxt) ~= nil and string.len(yesTxt) == 8 then
    list.yesTxt = GetText(yesTxt)
  end
  if isText ~= true and tonumber(noTxt) ~= nil and string.len(noTxt) == 8 then
    list.noTxt = GetText(noTxt)
  end
  if isLoadingCanvas == nil then
    isLoadingCanvas = false
  end
  UIManager:Open("UI/Common/Prompt/Prompt", Json.encode(list), yesFuc, noFuc, isLoadingCanvas)
end

function CommonTips.OnPromptMax(content, yesTxt, noTxt, yesFuc, noFuc, isText, isBgClick, isLoadingCanvas, checkTipParam)
  if checkTipParam and checkTipParam.checkTipKey then
    if checkTipParam.checkTipType == nil then
      checkTipParam.checkTipType = 1
    end
    if PlayerData:GetNoPrompt(checkTipParam.checkTipKey, checkTipParam.checkTipType) then
      yesFuc()
      return
    end
  end
  local list = {}
  list.content = content
  list.yesTxt = yesTxt
  list.noTxt = noTxt
  list.isBgClick = isBgClick or false
  list.checkTipParam = checkTipParam
  if isText ~= true and tonumber(content) ~= nil and string.len(content) == 8 then
    list.content = GetText(content)
  end
  if isText ~= true and tonumber(yesTxt) ~= nil and string.len(yesTxt) == 8 then
    list.yesTxt = GetText(yesTxt)
  end
  if isText ~= true and tonumber(noTxt) ~= nil and string.len(noTxt) == 8 then
    list.noTxt = GetText(noTxt)
  end
  if isLoadingCanvas == nil then
    isLoadingCanvas = false
  end
  UIManager:OpenSpecialUI("UI/Common/Prompt/PromptMax", Json.encode(list), yesFuc, noFuc)
end

function CommonTips.OnPromptConfirmOnly(content, yesTxt, yesFuc, isText, isLoadingCanvas)
  local list = {}
  list.content = content
  list.yesTxt = yesTxt
  if isText ~= true and tonumber(content) ~= nil and string.len(content) == 8 then
    list.content = GetText(content)
  end
  if isText ~= true and tonumber(yesTxt) ~= nil and string.len(yesTxt) == 8 then
    list.yesTxt = GetText(yesTxt)
  end
  if isLoadingCanvas == nil then
    isLoadingCanvas = false
  end
  UIManager:Open("UI/Common/Prompt/Prompt_1", Json.encode(list), yesFuc, nil, isLoadingCanvas)
end

function CommonTips.OpenTips(parms, isText)
  UIManager:CloseTip("UI/Common/Tips")
  if isText ~= true and tonumber(parms) ~= nil and string.len(parms) == 8 then
    parms = GetText(parms)
  end
  CommonTips.parms = parms or {}
  UIManager:Open("UI/Common/Tips", Json.encode(CommonTips.parms))
end

function CommonTips.OpenEquipment(parms, server)
  local params = {}
  local factory = PlayerData:GetFactoryData(parms.id, "EquipmentFactory")
  params.type = factory.type
  params.tipsPath = factory.tipsPath
  params.qualityInt = factory.qualityInt
  params.name = factory.name
  params.attack = factory.attack_SN
  params.defence = factory.defence_SN
  params.healthPoint = factory.healthPoint_SN
  params.des = factory.des
  params.skills = PlayerData:GetEquipById(parms.id) and PlayerData:GetEquipById(parms.id).skills or nil
  params.server = server or {}
  params.eid = parms.eid
  params.id = factory.id
  params.invokeInitParams = true
  UIManager:Open("UI/CharacterInfo/weapon/WeaponItemWindow/Group_EquipmentItem", Json.encode(params))
end

function CommonTips.OpenItem(parms, yesFuc)
  UIManager:Open("UI/Common/ItemTips", Json.encode(parms), yesFuc)
end

function CommonTips.OpenPreEquipmentTips(parms, server)
  local factory = PlayerData:GetFactoryData(parms.id, "EquipmentFactory")
  parms.type = factory.type
  parms.tipsPath = factory.tipsPath
  parms.qualityInt = factory.qualityInt
  parms.name = factory.name
  parms.attack = factory.attack_SN
  parms.defence = factory.defence_SN
  parms.healthPoint = factory.healthPoint_SN
  parms.des = factory.des
  parms.skills = PlayerData:GetEquipById(parms.id) and PlayerData:GetEquipById(parms.id).skills or nil
  parms.server = server or {}
  parms.isPre = true
  parms.eid = parms.eid
  parms.invokeInitParams = false
  UIManager:Open("UI/CharacterInfo/weapon/WeaponItemWindow/Group_EquipmentItem", Json.encode(parms))
end

function CommonTips.OpenPreItemTips(parms, yesFuc)
  UIManager:Open("UI/Common/ItemPreTips", Json.encode(parms), yesFuc)
end

function CommonTips.OpenShowItem(parms, yesFuc, titleStr)
  if parms == nil or table.count(parms) == 0 then
    return
  end
  if parms.role and table.count(parms.role) then
    local list = {}
    list.cards = {}
    list.index = 1
    list.showItem = 1
    list.reward = parms
    local count = 0
    for k, v in pairs(parms.role) do
      count = count + 1
      local row = {}
      list.cards[count] = row
      row.id = tonumber(k)
      row.isNew = true
      if PlayerData:GetRoleById(k) and 0 < table.count(PlayerData:GetRoleById(k)) then
        row.isNew = false
      end
    end
    list.type = 1
    UIManager:Open("UI/ShowCharacter/ShowCharacter", Json.encode(list), function()
      UIManager:Open("UI/Common/ShowItem", Json.encode({rewards = parms, title = titleStr}))
    end, nil, false, true)
  elseif parms.card_pack and 0 < table.count(parms.card_pack) then
    local cardId = 86200002
    for i, v in pairs(parms.card_pack) do
      cardId = i
      break
    end
    UIManager:Open("UI/CollectionCard/CardDrawing", Json.encode({cardId = cardId}), function()
      UIManager:Open("UI/Common/ShowItem", Json.encode({rewards = parms, title = titleStr}))
    end, nil, false, false)
  else
    UIManager:Open("UI/Common/ShowItem", Json.encode({rewards = parms, title = titleStr}), yesFuc)
  end
end

function CommonTips.OpenAntiAddiction(parms, yesFuc)
  UIManager:Open("UI/Login/AntiAddiction", Json.encode(parms), yesFuc)
end

function CommonTips.OpenSettlement()
  UIManager:Open("UI/Settlement/Settlement")
end

function CommonTips.OpenLoading(callback, uiName, pngPath, AniInitCompleteCallback, text)
  if text == nil then
    text = ""
  end
  UIManager:OpenLoading(uiName, pngPath, AniInitCompleteCallback, text)
  if callback ~= nil then
    callback()
  end
end

function CommonTips.OpenLoadingCB(callback)
  local data = PlayerData:GetFactoryData(99900036, "ConfigFactory")
  local loadingPath = ""
  local enterMainUIList
  if data then
    enterMainUIList = data.enterMainUIList
  end
  if enterMainUIList and 0 < #enterMainUIList then
    loadingPath = enterMainUIList[math.random(1, #enterMainUIList)].imagePath
  end
  UIManager:OpenLoading("", loadingPath, callback)
end

function CommonTips.OpenPreRewardDetailTips(id, row, showGetWay)
  local type = PlayerData:GetRewardType(id)
  if type == "EquipTips" then
    local params = {}
    local ueid
    if row and row.ueid ~= nil then
      ueid = row.ueid
    end
    local factory = PlayerData:GetFactoryData(id, "EquipmentFactory")
    params.scene = 0
    params.type = factory.type
    params.tipsPath = factory.tipsPath
    params.qualityInt = factory.qualityInt
    params.name = factory.name
    params.attack_SN = factory.attack_SN
    params.defence_SN = factory.defence_SN
    params.healthPoint_SN = factory.healthPoint_SN
    params.des = factory.des
    params.skills = PlayerData:GetEquipById(id) and PlayerData:GetEquipById(id).skills or nil
    local server = {}
    server.lv = 1
    server.id = id
    if ueid then
      server = row and row.server or PlayerData:GetEquipById(ueid)
      params.eid = ueid
    end
    params.id = id
    CommonTips.OpenPreEquipmentTips(params, server)
  end
  if type == "HomeWeapon" then
    local weaponUid
    if row then
      weaponUid = row.uid
    end
    local data = {id = id, weaponUid = weaponUid}
    UIManager:Open("UI/Trainfactory/Weapon/Group_TrainWeaponItem", Json.encode(data))
  end
  if type == "ItemTips" then
    CommonTips.OpenPreItemTips({
      itemId = id,
      type = EnumDefine.OpenTip.NoDepot,
      isShowGetWay = showGetWay
    })
  end
  if type == "CharacterTips" then
    CommonTips.OpenUnitDetail({id = id})
  end
  if type == "GoodsTips" then
    CommonTips.OpenGoodsTips(id, 1)
  end
  if type == "SkinViewTips" then
    CommonTips.OpenSkinViewTips({id = id, isSkinView = true})
  end
  if type == "FridgeItemTips" then
    CommonTips.OpenPreItemTips({
      itemId = id,
      type = EnumDefine.OpenTip.NoDepot
    })
  end
  if type == "FurnitureTips" then
    CommonTips.OpenFurnitureTip(id, 0)
  end
  if type == "DressTips" then
    CommonTips.OpenDressTips(id)
  end
  if type == "PhotoTips" then
    CommonTips.OpenPhotoItemTips(id)
  end
  if type == "CardTips" then
    local cardId = tonumber(id)
    UIManager:Open("UI/CollectionCard/CollectionCard_Tips", Json.encode({cardId = cardId}))
  end
end

local StoryItemConfig = {
  ["照片"] = true,
  ["录像"] = true,
  ["磁带"] = true
}

function CommonTips.OpenRewardDetail(id, row)
  if StoryItemConfig[PlayerData:GetFactoryData(tonumber(id)).mod] then
    CommonTips.OpenStoryItemTip(id, row)
    return
  end
  local type = PlayerData:GetRewardType(id)
  if type == "EquipTips" then
    local params = {}
    local ueid
    if row and row.ueid ~= nil then
      ueid = row.ueid
    end
    local factory = PlayerData:GetFactoryData(id, "EquipmentFactory")
    params.scene = 0
    params.type = factory.type
    params.tipsPath = factory.tipsPath
    params.qualityInt = factory.qualityInt
    params.name = factory.name
    params.attack_SN = factory.attack_SN
    params.defence_SN = factory.defence_SN
    params.healthPoint_SN = factory.healthPoint_SN
    params.des = factory.des
    params.skills = PlayerData:GetEquipById(id) and PlayerData:GetEquipById(id).skills or nil
    local server = {}
    server.lv = 1
    server.id = id
    if ueid then
      server = PlayerData:GetEquipById(ueid)
      params.eid = ueid
    end
    params.id = id
    CommonTips.OpenEquipment(params, server)
  end
  if type == "ItemTips" then
    CommonTips.OpenItem({
      itemId = id,
      type = EnumDefine.OpenTip.NoDepot
    })
  end
  if type == "CharacterTips" then
    CommonTips.OpenUnitDetail({id = id})
  end
  if type == "GoodsTips" then
    CommonTips.OpenGoodsTips(id, 1)
  end
  if type == "SkinViewTips" then
    CommonTips.OpenSkinViewTips({id = id, isSkinView = true})
  end
  if type == "FridgeItemTips" then
    CommonTips.OpenItem({
      itemId = id,
      type = EnumDefine.OpenTip.NoDepot
    })
  end
  if type == "FurnitureTips" then
    CommonTips.OpenFurnitureTip(id, 0)
  end
  if type == "DressTips" then
    CommonTips.OpenDressTips(id)
  end
  if type == "PhotoTips" then
    CommonTips.OpenPhotoItemTips(id)
  end
  if type == "CardTips" then
    local cardId = tonumber(id)
    UIManager:Open("UI/CollectionCard/CollectionCard_Tips", Json.encode({cardId = cardId}))
  end
  if type == "CardPackTips" then
    CommonTips.OpenItem({
      itemId = id,
      type = EnumDefine.OpenTip.NoDepot
    })
  end
  if type == "HomeWeapon" then
    local weaponUid
    if row then
      weaponUid = row.uid
    end
    local data = {id = id, weaponUid = weaponUid}
    UIManager:Open("UI/Trainfactory/Weapon/Group_TrainWeaponItem", Json.encode(data))
  end
end

function CommonTips.SkillTips(roleId, index, data)
  local params = {
    roleId = roleId,
    index = index,
    data = data
  }
  UIManager:Open("UI/Common/SkillTips", Json.encode(params))
end

function CommonTips.SkillTipsOnBattle(skillid, skilllv, skillcost)
  local params = {
    skillId = skillid,
    skillLv = skilllv,
    cost = skillcost
  }
  UIManager:Open("UI/Common/SkillTips", Json.encode(params))
end

function CommonTips.SaleTips(data)
  local params = {data = data}
  UIManager:Open("UI/Common/SaleTips", Json.encode(params))
end

function CommonTips.OpenShopSaleTips(data, yesFunc)
  local params = {data = data}
  UIManager:Open("UI/Common/ShopSaleTips", Json.encode(params), yesFunc)
end

function CommonTips.OpenBuyTips(data, yesFuc)
  UIManager:Open("UI/Common/BuyTips", Json.encode(data), yesFuc)
end

function CommonTips.OpenConvertTips(data, yesFuc)
  UIManager:Open("UI/Common/ConvertTips", Json.encode(data), yesFuc)
end

function CommonTips.OpenStoreBuy(isMoveEnergyOpen)
  local json = {}
  json.shops = PlayerData.ServerData.shops
  json.index = 2
  if PlayerData.RechargeGoods == nil then
    Net:SendProto("shop.info", function(json)
      if isMoveEnergyOpen then
        json.index = 3
        json.isMoveEnergyOpen = true
      end
      UIManager:Open("UI/Store/Store", Json.encode(json))
    end)
    return
  end
  if isMoveEnergyOpen then
    json.index = 3
    json.isMoveEnergyOpen = true
  end
  UIManager:Open("UI/Store/Store", Json.encode(json))
end

function CommonTips.OpenBreakSuccessTip(list)
  UIManager:Open("UI/Common/TipsAttUp", Json.encode(list))
end

function CommonTips.OpenAwakeTalentTip(list)
  UIManager:Open("UI/Common/TalentTips", Json.encode(list))
end

function CommonTips.OpenArbitrarilyUI(ui, parms)
  local params = parms
  PlayerData:ResetCharacterFilter()
  PlayerData:ResetSuaqsFilter()
  PlayerData:ResetDepotFilter()
  CommonTips.OpenLoading(nil, "", "", function()
    local questComplete = function()
      CommonTips.OpenQuestsCompleteTip()
      CommonTips.OpenQuestPcntUpdateTip(true)
      CommonTips.OpenRepLvUp()
    end
    local scene = "Main"
    if MapNeedleEventData.event and MapNeedleEventData.openInsZone then
      scene = MapNeedleEventData.scene
    end
    if ui == nil or ui == "" then
      CBus:ChangeScene(scene, nil, function()
        questComplete()
      end)
      return
    end
    if ui ~= nil and ui ~= "" then
      if params ~= nil and table.count(params) > 0 then
        CBus:ChangeScene(scene, function()
          if ui == "UI/Chapter/Battle_Dungeon" then
            UIManager:Open("UI/MainUI/MainUI")
          end
          UIManager:Open(ui, Json.encode(params))
          questComplete()
        end)
      else
        CBus:ChangeScene(scene, function()
          UIManager:Open(ui)
          questComplete()
        end)
      end
    end
  end)
  LoadingManager.loadingPercent = 0.9
end

function CommonTips.OpenChangeSceneAnime()
  UIManager:Open("UI/Common/CommonChangeScene")
end

function CommonTips.OpenSkip(list, yesFuc)
  UIManager:Open("UI/Common/CommonSkip", Json.encode(list), yesFuc)
end

function CommonTips.OpenUnitDetail(parms)
  UIManager:Open("UI/CharacterInfo/CharacterTips", Json.encode(parms))
end

function CommonTips.OpenEnemyDetail(parms)
  UIManager:Open("UI/Book/Enemy_Illustration/Enemy_Detail", Json.encode(parms))
end

function CommonTips.OpenRoleAwakeSuccess(RoleData, CA, id)
  local list = {}
  list.RoleData = RoleData
  list.id = id
  list.RoleCA = CA
  UIManager:Open("UI/CharacterInfo/Group_AwakeSuccess", Json.encode(list))
end

function CommonTips.OpenRoleResonanceSuccess(RoleData, CA, id)
  local list = {}
  list.RoleData = RoleData
  list.id = id
  list.RoleCA = CA
  UIManager:Open("UI/CharacterInfo/Group_ResonanceSuccess", Json.encode(list))
end

function CommonTips.OpenFurnitureTip(id, cnt)
  local json = {}
  json.id = id
  json.cnt = cnt
  UIManager:Open("UI/Home/FurnitureTips", Json.encode(json))
end

function CommonTips.OpenThemeTip(id)
  local json = {}
  json.id = id
  UIManager:Open("UI/Home/ThemeTips", Json.encode(json))
end

function CommonTips.OpenStoryItemTip(parms, row)
  local json = {}
  if row then
    json = row
  end
  json.id = parms
  UIManager:Open("UI/StoryItemTips/StoryItemTip", Json.encode(json))
end

function CommonTips.OpenCardDes(json)
  UIManager:Open("UI/Battle/Prefab/CardDes", Json.encode(json))
end

function CommonTips.OpenExplain(id, position, extraData)
  local json = {}
  json.id = id
  json.position = position
  json.extraData = extraData
  UIManager:Open("UI/Common/Group_Explain", Json.encode(json))
end

function CommonTips.OpenRoleDetail(id)
  local json = {}
  json.id = id
  UIManager:Open("UI/Common/RoleDetail", Json.encode(json))
end

function CommonTips.OpenGroupWeapon(parms)
  local json = parms
  UIManager:Open("UI/CharacterInfo/weapon/Group_Weapon", Json.encode(json))
end

function CommonTips.OpenQuestsTip(questIds)
  if questIds == nil or #questIds == 0 then
    return
  end
  local t = {}
  t.questIds = questIds
  UIManager:Open("UI/Common/LittleTips", Json.encode(t))
end

function CommonTips.OpenQuestsCompleteTip(questIds, yesCallBack)
  if questIds == nil then
    questIds = Clone(PlayerData.TempCache.AutoCompleteLevels)
    PlayerData.TempCache.AutoCompleteLevels = nil
  elseif PlayerData.TempCache.AutoCompleteLevels ~= nil then
    for i, info in ipairs(PlayerData.TempCache.AutoCompleteLevels) do
      table.insert(questIds, info)
    end
    PlayerData.TempCache.AutoCompleteLevels = nil
  end
  if questIds == nil or #questIds == 0 then
    return
  end
  local t = {}
  t.questIds = questIds
  local count = #t.questIds
  local idx = 1
  while count >= idx do
    local quest = t.questIds[idx]
    local questCA = PlayerData:GetFactoryData(quest, "QuestFactory")
    if #questCA.rewardsList == 0 then
      table.remove(t.questIds, idx)
      count = count - 1
    else
      idx = idx + 1
    end
  end
  if 0 < count then
    UIManager:Open("UI/Common/QuestComplete", Json.encode(t), yesCallBack)
  end
  questIds = nil
end

function CommonTips.OpenQuestPcntUpdateTip(checkShow)
  local showTip = {}
  if PlayerData.TempCache.AutoUpdateLevels and #PlayerData.TempCache.AutoUpdateLevels > 0 then
    for k, v in pairs(PlayerData.TempCache.AutoUpdateLevels) do
      local questCA = PlayerData:GetFactoryData(v.id, "QuestFactory")
      if not v.isNew and questCA.isShowAchieveProgress or v.isNew and questCA.isShowUnlock then
        table.insert(showTip, v)
      end
    end
  end
  if 0 < #showTip then
    if checkShow and UIManager:IsPanelOpened("UI/Home/HomeSafe/HomeSafe") then
      return
    end
    UIManager:Open("UI/Common/QuestTips/QuestTips", Json.encode(showTip))
  end
  PlayerData.TempCache.AutoUpdateLevels = nil
end

function CommonTips.OnItemPrompt(content, params, yesFuc, noFuc, isText)
  local list = {}
  list.content = content
  list.yesTxt = params.yesTxt
  list.noTxt = params.noTxt
  list.isBgClick = params.isBgClick or false
  list.itemId = params.itemId
  list.itemNum = params.itemNum or PlayerData:GetGoodsById(list.itemId).num
  list.useNum = params.useNum
  if isText ~= true and tonumber(content) ~= nil and string.len(content) == 8 then
    list.content = GetText(content)
  end
  if isText ~= true and tonumber(params.yesTxt) ~= nil and string.len(params.yesTxt) == 8 then
    list.yesTxt = GetText(params.yesTxt)
  end
  if isText ~= true and tonumber(list.noTxt) ~= nil and string.len(list.noTxt) == 8 then
    list.noTxt = GetText(list.noTxt)
  end
  UIManager:Open("UI/Common/ItemPrompt/ItemPrompt", Json.encode(list), yesFuc, noFuc)
end

function CommonTips.OnItemPromptBatch(content, params, yesFuc, noFuc, isText)
  local list = {}
  list.content = content
  list.yesTxt = params.yesTxt
  list.noTxt = params.noTxt
  list.isBgClick = params.isBgClick or false
  list.itemId = params.itemId
  list.itemNum = params.itemNum or PlayerData:GetGoodsById(list.itemId).num
  list.useNum = params.useNum
  if isText ~= true and tonumber(content) ~= nil and string.len(content) == 8 then
    list.content = GetText(content)
  end
  if isText ~= true and tonumber(params.yesTxt) ~= nil and string.len(params.yesTxt) == 8 then
    list.yesTxt = GetText(params.yesTxt)
  end
  if isText ~= true and tonumber(list.noTxt) ~= nil and string.len(list.noTxt) == 8 then
    list.noTxt = GetText(list.noTxt)
  end
  UIManager:Open("UI/Common/ItemPrompt/ItemPromptBatch", Json.encode(list), yesFuc, noFuc)
end

function CommonTips.OpenGroupStrengthen(parms)
  local json = parms
  UIManager:Open("UI/CharacterInfo/weapon/Group_Strengthen", Json.encode(json))
end

function CommonTips.OpenBuyEnergyTips(levelId, yesFunc, noFunc, is_line_fail, difficulty)
  difficulty = difficulty or 1
  local levelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
  local costEnergyNum = levelCA.energyStart + levelCA.energyEnd + levelCA.extraEnergy * (difficulty - 1)
  if is_line_fail then
    costEnergyNum = PlayerData:GetFactoryData(99900014).shareEnergyEnd
  end
  local holdNum = PlayerData.ServerData.user_info.energy
  if costEnergyNum > holdNum then
    local recordTime = PlayerData:GetPlayerPrefs("int", "battleEnergy")
    local severTime = TimeUtil:GetServerTimeStamp()
    local reallyTime = recordTime == 0 and severTime or recordTime
    local newDate = os.date("*t", reallyTime)
    local resetTime = os.time({
      year = newDate.year,
      month = newDate.month,
      day = newDate.day,
      hour = 0,
      minute = 0,
      second = 0
    })
    local days = (severTime - resetTime) / 24 / 60 / 60
    if 1 <= days or recordTime == 0 then
      UIManager:Open("UI/Energy/EnergyBuyTips", nil, function()
        UIManager:Open("UI/Energy/Energy", nil, yesFunc, noFunc)
      end, noFunc)
    else
      UIManager:Open("UI/Energy/Energy", nil, yesFunc, noFunc)
    end
    return true
  end
  return false
end

function CommonTips.OpenArriveTip(isBack)
  local Controller = require("UIMainUI/UIMainUIController")
  local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
  if PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
    if TradeDataModel.IsReturn() then
      TradeDataModel.CurStayCity = TradeDataModel.StartCity
    else
      TradeDataModel.CurStayCity = TradeDataModel.EndCity
    end
    Controller.ChangeDriveBtnState()
    Controller.ShowEndActive(true)
    Controller:InitCommonShow()
    Controller.ReachNewCityRoleTip()
  elseif PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
    if TrainManager.CurrTrainState == TrainState.Arrive or TrainManager.CurrTrainState == TrainState.Back then
      local before_lv_ani = PlayerData.ServerData.user_info.lv
      PlayerData.TempCache.SendArrive = true
      Net:SendProto("station.auto_arrived", function(json)
        PlayerData.TempCache.SendArrive = false
        local parms = {}
        parms.before_lv_ani = before_lv_ani
        parms.temp_lv_ani = PlayerData.ServerData.user_info.lv
        if PlayerData.ServerData.user_info.lv > before_lv_ani then
          CommonTips.OpenGradeUpSkipLevel(parms, function()
          end)
        end
        local t = TradeDataModel.GetAnnouncementList(EnumDefine.Announcement.Arrive)
        SoundManager:PlaySoundList(t)
        if json.fatigue then
          CommonTips.OpenFatigueTip(json.fatigue)
        end
        if json.drive_distance then
          PlayerData:GetHomeInfo().drive_distance = json.drive_distance
        end
        if json.drive_time then
          PlayerData:GetHomeInfo().drive_time = json.drive_time
        end
        if json.home_lines then
          PlayerData:GetHomeInfo().home_lines = json.home_lines
        end
        if TradeDataModel.IsReturn() then
          TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.Refresh)
        else
          TradeDataModel.CurStayCity = TradeDataModel.EndCity
          TradeDataModel.StateEnter = EnumDefine.TrainStateEnter.Arrive
        end
        PlayerData:ClearPollute()
        Controller.ShowEndActive(true)
        Controller.ShowAutoDriveTxt(false)
        Controller.ChangeDriveBtnState()
        if MainManager.bgSceneName ~= "Battle" then
          Controller:InitCommonShow()
          Controller.ReachNewCityRoleTip()
        end
      end, function(json)
        PlayerData.TempCache.SendArrive = false
        if json.station_info then
          PlayerData:RefreshStationInfo(json.station_info)
        end
        TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.Refresh)
        Controller.ChangeDriveBtnState()
        Controller:RunBtnState(true)
      end, isBack and 2 or 0)
    else
      Controller.ShowEndActive(false)
    end
  elseif PlayerData:GetHomeInfo().station_info.is_arrived == 2 then
    Controller.ShowEndActive(false)
  end
end

function CommonTips.OpenGradeUpSkipLevel(parms, yesFunc)
  local json = parms
  UIManager:Open("UI/Common/GradeUp/GradeUp", Json.encode(json), yesFunc)
  SdkReporter.TrackLevelUp(parms.before_lv_ani, parms.temp_lv_ani)
end

function CommonTips.OpenGoodsTips(goodsId, type)
  local data = {}
  data.goodsId = goodsId
  data.goodsType = type
  UIManager:Open("UI/Common/GoodsTips", Json.encode(data))
end

function CommonTips.OpenRepLvUp()
  if PlayerData.TempCache.repLvUpCache ~= nil then
    local info = {}
    info.stationId = PlayerData.TempCache.repLvUpCache.stationId
    info.preLevel = PlayerData.TempCache.repLvUpCache.preRepLv
    info.level = PlayerData.TempCache.repLvUpCache.repLv
    PlayerData.TempCache.repLvUpCache = nil
    UIManager:Open("UI/Common/RepLevelUp", Json.encode(info))
  end
end

function CommonTips.OpenTradeLvUp(tradeLv, preTradeLv)
  if tradeLv == preTradeLv then
    return
  end
  local info = {}
  info.level = tradeLv
  info.preLevel = preTradeLv
  UIManager:Open("UI/Common/TradeLevelUp", Json.encode(info))
end

function CommonTips.ShowElectricLvUp(type, level)
  local info = {}
  info.type = type
  info.level = level
  UIManager:Open("UI/HomeElectricUp/HomeElectricUp", Json.encode(info))
end

function CommonTips.OnStrengthenSuccesePage(parms)
  local row = parms
  UIManager:Open("UI/CharacterInfo/weapon/StrengthenWindow/Group_StrengthenWindow", Json.encode(row))
end

function CommonTips.OnOpenSkinPage(parms, callback)
  local row = parms
  UIManager:Open("UI/CharacterInfo/Skin/Skin", Json.encode(row), callback)
end

function CommonTips.OnBuyGiftTips(parms, callback)
  local row = parms
  UIManager:Open("UI/Common/BuyGiftTips", Json.encode(row), callback)
end

function CommonTips.OpenExpelTips(seriesName, deterrence)
  local params = {}
  params.seriesName = seriesName or 0
  params.deterrence = deterrence or 0
  UIManager:Open("UI/Common/ExpelTips/ExpelTips", Json.encode(params))
end

function CommonTips.OpenFlierSendSuccess(passenger, furniture, sendType)
  if passenger then
    local add_passenger = {}
    if PlayerData:GetHomeInfo().passenger then
      for destination, v in pairs(passenger) do
        if not PlayerData:GetHomeInfo().passenger[destination] then
          add_passenger[destination] = v
        else
          add_passenger[destination] = {}
          for uid, info in pairs(v) do
            if not PlayerData:GetHomeInfo().passenger[destination][uid] then
              add_passenger[destination][uid] = info
            end
          end
        end
      end
    else
      add_passenger = passenger
    end
    if table.count(add_passenger) > 0 then
      local roleIds = {}
      local sameCareerPsgList = {}
      local sameCareerPsgIpairsList = {}
      local psgCreatList = {}
      local psgCA
      for destination, v in pairs(add_passenger) do
        for uid, info in pairs(v) do
          psgCA = PlayerData:GetFactoryData(info.id, "PassageFactory")
          sameCareerPsgList[psgCA.career] = sameCareerPsgList[psgCA.career] or {}
          table.insert(sameCareerPsgList[psgCA.career], info)
          table.insert(psgCreatList, info)
        end
      end
      for i, v in pairs(sameCareerPsgList) do
        table.insert(sameCareerPsgIpairsList, v)
      end
      table.sort(psgCreatList, function(a, b)
        local psgCA1 = PlayerData:GetFactoryData(a.id, "PassageFactory")
        local psgCA2 = PlayerData:GetFactoryData(b.id, "PassageFactory")
        if psgCA1.star == psgCA2.star then
          return tonumber(psgCA1.homePassage) < tonumber(psgCA2.homePassage)
        else
          return psgCA1.star < psgCA2.star
        end
      end)
      local passengerCA
      for _, v in ipairs(psgCreatList) do
        passengerCA = PlayerData:GetFactoryData(v.id, "PassageFactory")
        table.insert(roleIds, tonumber(passengerCA.homePassage))
        if 10 <= #roleIds then
          break
        end
      end
      local MainDataModel = require("UIMainUI/UIMainUIDataModel")
      PlayerData.TempCache.MainUIShowState = MainDataModel.UIShowEnum.Passenger
      UIManager:GoHome()
      local TimeLine = require("Common/TimeLine")
      local homeTradeDataModel = require("UIHome/UIHomeTradeDataModel")
      local stationCA = PlayerData:GetFactoryData(homeTradeDataModel.CurStayCity)
      for k, v in pairs(stationCA.timeLineList) do
        TimeLine.RemoveTimeLine(v.id)
      end
      local passengerDataModel = require("UIPassenger/UIPassengerDataModel")
      passengerDataModel.CreateNpc(true)
      MainSceneCharacterManager:CreatePassengers(roleIds, true)
      local mainView = require("UIMainUI/UIMainUIView")
      mainView.passengerCoroutine = mainView.self:StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(2))
        UIManager:Open("UI/Flier/FlierSendSuccess", Json.encode({add_passenger = sameCareerPsgIpairsList, sendType = sendType}))
        mainView.self:StopC(mainView.passengerCoroutine)
        mainView.passengerCoroutine = nil
      end))
    end
  end
  local psgData = require("UIPassenger/UIPassengerDataModel")
  psgData.RefreshPassenger(passenger, furniture)
end

function CommonTips.OpenPassengerRewardTips(json, callback)
  UIManager:Open("UI/Passenger/PassengerReward", Json.encode({serverData = json}), callback)
  local psgData = require("UIPassenger/UIPassengerDataModel")
  psgData.RefreshPassenger(json.passenger, json.furniture)
end

function CommonTips.OpenFlierConditionTips(param)
  UIManager:Open("UI/Flier/FlierConditionTip", Json.encode(param))
end

function CommonTips.OpenConstructStage(parms)
  UIManager:Open("UI/HomeBattleCenter/ConstructStage/ConstructStage", Json.encode(parms))
end

function CommonTips.OpenEnergy(callback)
  UIManager:Open("UI/Energy/Energy", nil, function()
    if callback then
      callback()
    end
  end)
end

function CommonTips.OpenSkinViewTips(parms, callback)
  local row = parms
  UIManager:Open("UI/CharacterInfo/Skin/SkinPreview", Json.encode(row), callback)
end

function CommonTips.OpenGuidanceTips(param, isText)
  local t = {}
  if type(param) == "number" then
    t.textId = param
  end
  UIManager:CloseTip("UI/Guidance/Guidance_Tips")
  if isText ~= true and tonumber(param) ~= nil and string.len(param) == 8 then
    param = GetText(param)
  end
  t.text = param
  UIManager:Open("UI/Guidance/Guidance_Tips", Json.encode(t))
end

function CommonTips.OpenPolluteDialogBoxTip(textId)
  local t = {levelTextId = textId}
  CommonTips.OpenDialogBoxTip(t)
end

function CommonTips.OpenDialogBoxTip(param)
  UIManager:Open("UI/Common/DialogBox_Tip", Json.encode(param))
end

function CommonTips.OpenDialogBoxTipWithDetail(facePath, textId, eventId, isSuccess, params)
  local t = {
    facePath = facePath,
    levelTextId = textId,
    eventId = eventId,
    isSuccess = isSuccess,
    params = params
  }
  CommonTips.OpenDialogBoxTip(t)
end

function CommonTips.OpenToHomeCarriageeditor(param)
  local funcCommon = require("Common/FuncCommon")
  if not funcCommon.FuncActiveCheck(108, true) then
    CommonTips.OpenTips(80602516)
    return
  end
  if PlayerData.IsInStation() == false then
    CommonTips.OpenTips(80602517)
    return
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  MainManager:SetTrainViewFilter(0, true)
  HomeCoachFactoryManager:Create(homeConfig.TrainFactoryScenes, function()
    local str
    if param then
      str = Json.encode(param)
    end
    MainManager:SetTrainViewFilter(30, false)
    UIManager:Open("UI/Trainfactory/HomeCarriageeditor", str)
  end)
end

function CommonTips.OpenFatigueTip(fatigue)
  UIManager:Open("UI/Common/FatigueAddTips", tostring(fatigue))
end

function CommonTips.OpenArriveNewCityTip(targetCityId)
  UIManager:Open("UI/MainUI/Group_ArriveNewCity", tostring(targetCityId))
end

function CommonTips.OpenStrikeTip(textId, textParam, isAutoClose)
  if isAutoClose == nil then
    isAutoClose = false
  end
  UIManager:Open("UI/MainUI/Strike_Tip", Json.encode({
    textId = textId,
    textParam = textParam,
    isAutoClose = isAutoClose
  }))
end

function CommonTips.CheckOpenNoticeLogin()
  if PlayerData:GetNoPrompt("logintNotice", 1, false) == false then
    CommonTips.OpenNoticeLogin()
    PlayerData:SetNoPrompt("logintNotice", 1, true, false)
  end
end

function CommonTips.OpenNoticeLogin()
  local callBack = function(param)
    UIManager:Open("UI/Notice/Notice_beforeLogin", Json.encode(param))
  end
  local url = PlayerData:GetFactoryData(99900001).NoticeAdress
  NoticeManager:GetNoticeHtml(callBack, url)
end

function CommonTips.OpenCoachReward(reward)
  local coachReward = reward.coach
  if coachReward then
    local t = {}
    local k, v = next(coachReward)
    t.id = v.id
    UIManager:Open("UI/Trainfactory/Second/BuildWindows/NewCarriage", Json.encode(t))
  end
end

function CommonTips.OpenUseTips(param)
  UIManager:Open("UI/Common/UseTips/UseTips", Json.encode(param))
end

function CommonTips.OpenDressTips(dressId)
  UIManager:Open("UI/ChangeSkin/DressTips", Json.encode({dressId = dressId}))
end

function CommonTips.OpenPhotoItemTips(photoId)
  UIManager:Open("UI/PhotoTips/PhotoTips", Json.encode({photoId = photoId}))
end

function CommonTips.OpenEngineCoreLvUp(coreId, oldLv, newLv)
  local t = {}
  t.coreId = coreId
  t.oldLv = oldLv
  t.newLv = newLv
  UIManager:Open("UI/EngineCore/CoreGradeUp/CoreGradeUp", Json.encode(t))
end

function CommonTips.OpenMoonthCard()
  if PlayerData.ServerData.monthly_card and PlayerData.ServerData.monthly_card["11400018"] then
    local row = PlayerData.ServerData.monthly_card["11400018"]
    local curServerTime = TimeUtil:GetServerTimeStamp()
    if row.reward_ts ~= nil and row.reward_ts ~= "" and curServerTime - row.reward_ts <= 86400 then
      return
    end
    if TimeUtil:GetServerTimeStamp() > row.deadline then
      return
    end
    UIManager:Open("UI/Common/MoonthCard/MoonthCard")
  end
end

function CommonTips.OpenNoteBook(bookIndex)
  local cfg = PlayerData:GetFactoryData(80300339, "ListFactory")
  local t = {}
  t.dataTab = cfg.dataTab
  t.bookIndex = bookIndex
  UIManager:Open("UI/Notebook/Notebook", Json.encode(t))
end

function CommonTips.OpenHelp(helpId)
  local data = {helpId = helpId}
  UIManager:Open("UI/Common/Group_Help", Json.encode(data))
end

return CommonTips
