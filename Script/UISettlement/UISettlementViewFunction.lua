local View = require("UISettlement/UISettlementView")
local SettlementConfig = require("UISettlement/UISettlementSetting")
local DataModel = require("UISettlement/UISettlementDataModel")
local CommonItem = require("Common/BtnItem")
local ReportTrackList = {}
local SetReportTrackList = function(jsons)
  local mod = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId).mod
  if mod == "试炼场" then
    return
  end
  local BattleResult = PlayerData.BattleInfo.BattleResult
  ReportTrackList.reason = jsons
  ReportTrackList.round_type = PlayerData.selectedRightIndex
  local chapterId = -1
  if PlayerData.Last_Chapter_Parms ~= nil and PlayerData.Last_Chapter_Parms.chapterId ~= nil then
    chapterId = PlayerData.Last_Chapter_Parms.chapterId
  end
  ReportTrackList.chapter_id = chapterId
  local chapterIndex = -1
  if chapterId ~= -1 then
    chapterIndex = PlayerData:GetFactoryData(chapterId).chapterIndex
  end
  ReportTrackList.episode_id = chapterIndex .. "-" .. PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId).levelChapter
  ReportTrackList.duration = BattleResult.duration
  ReportTrackList.is_first_time = DataModel.JsonList.chapter_level[tostring(PlayerData.BattleInfo.battleStageId)] and DataModel.JsonList.chapter_level[tostring(PlayerData.BattleInfo.battleStageId)].challenge_times == 1 and 1 or 0
  ReportTrackList.challenge_times = DataModel.JsonList.chapter_level[tostring(PlayerData.BattleInfo.battleStageId)] and DataModel.JsonList.chapter_level[tostring(PlayerData.BattleInfo.battleStageId)].challenge_times or 0
  ReportTrackList.challenge_grade = DataModel.now_evaluate_index
  ReportTrackList.leader_id = PlayerData.BattleInfo.header
  ReportTrackList.shuffle_times = BattleResult.shuffle_times
  ReportTrackList.card_take = BattleResult.card_take
  ReportTrackList.card_use = BattleResult.card_use
  ReportTrackList.energy_get = BattleResult.energy_get
  ReportTrackList.energy_cost = BattleResult.energy_cost
  local battle_cast = {}
  local roleInfoList = {}
  for k, v in pairs(BattleResult.roleInfoList) do
    battle_cast[k] = {}
    battle_cast[k].name = PlayerData:GetFactoryData(tonumber(k)).name
    local server = PlayerData:GetRoleById(tonumber(k))
    battle_cast[k].hero_level = server and server.lv or 0
    battle_cast[k].hero_awaken = server and server.resonance_lv or 0
    battle_cast[k].hero_grade = server and server.awake_lv or 0
    roleInfoList[k] = {}
    roleInfoList[k].name = v.name
    roleInfoList[k].dmg = v.damage
    roleInfoList[k].heal = v.heal
    roleInfoList[k].u_dmg = v.getHit
    roleInfoList[k].be_heal = v.getHeal
    roleInfoList[k].die_acts = v.dieacts
  end
  ReportTrackList.battle_cast = Json.encode(battle_cast)
  ReportTrackList.battle_statistic = Json.encode(roleInfoList)
  ReportTrackList.b_json = Json.encode(DataModel.DeadHero)
  local battle_total = {}
  battle_total.dmg = BattleResult.damageTotal
  battle_total.skill_dmg = BattleResult.skill_dmg
  battle_total.buff_skill_dmg = BattleResult.buff_skill_dmg or 0
  battle_total.shield = BattleResult.shield
  battle_total.effective_shield = BattleResult.effective_shield
  battle_total.heal = BattleResult.healTotal
  battle_total.effective_heal = BattleResult.effective_heal
  battle_total.card_get = BattleResult.card_take
  battle_total.skill_card_get = BattleResult.skill_card_get
  battle_total.power_get = BattleResult.energy_get
  battle_total.skill_power_get = BattleResult.skill_power_get
  ReportTrackList.battle_total = Json.encode(battle_total)
  ReportTrackList.battle_skill = Json.encode(BattleResult.battleSkillInfoDic)
  ReportTrackList.card_select = Json.encode(BattleResult.card_selectList)
  local card_abandon = {}
  for k, v in pairs(BattleResult.battleSkillInfoDic) do
    card_abandon[k] = v.card_abandon
  end
  ReportTrackList.card_abandon = Json.encode(card_abandon)
  ReportTrackList.card_abandon_times = BattleResult.card_abandon_times
  ReportTrackEvent.Round_flow(ReportTrackList)
end
local Restart = function()
  if CommonTips.OpenBuyEnergyTips(PlayerData.BattleInfo.battleStageId) then
    return
  end
  View.Group_SettlementPrompt.self:SetActive(true)
  View.Group_SettlementPrompt.Txt_Prompt:SetText(GetText(80600280))
end
local ViewFunction = {
  Settlement_Group_Defeat_Btn_BG_Click = function(btn, str)
  end,
  Settlement_Group_Defeat_Btn_Next_Click = function(btn, str)
    View.Group_Defeat.self:SetActive(false)
    LoadingManager:SetLoadingPercent(0.75)
    CommonTips.OpenArbitrarilyUI(PlayerData.BattleCallBackPage, PlayerData.Last_Chapter_Parms)
    SetReportTrackList(PlayerData.BattleInfo.BattleResult.isExitBattle == true and 3 or 2)
  end,
  Settlement_Group_Defeat_Btn_Restart_Click = function(btn, str)
    Restart()
  end,
  Settlement_Group_Defeat_Btn_Replay_Click = function(btn, str)
  end,
  Settlement_Group_Victory_Group_CharacterExp_StaticGrid_Character_SetGrid = function(element, elementIndex)
    local row = DataModel.RoleList[tonumber(elementIndex)]
    if row == nil then
      element.self:SetActive(false)
      return
    end
    local face = row.face or PlayerData:GetFactoryData(PlayerData:GetRoleById(row.roleid).current_skin[1]).face
    local name = row.name
    local Group_Character01 = element.Group_Character01
    Group_Character01.Img_Mask.Img_Face:SetSprite(face)
    Group_Character01.Txt_Name:SetText(name)
    local before_lv = row.before.lv or 1
    local now_lv = row.now.lv or 1
    Group_Character01.Group_Lv.Txt_Num:SetText(before_lv)
    local data = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
    local levelUpExp
    if data[before_lv] then
      levelUpExp = data[before_lv].levelUpExp
    else
      levelUpExp = data[table.count(data)].levelUpExp
    end
    local now_exp = row.now.exp or 0
    local before_exp = row.before.exp or 0
    local exp = now_exp - before_exp
    local isMax = PlayerData:RoleLvIsMax(row.roleid, before_lv)
    if isMax == true then
      Group_Character01.Group_LevelUp.self:SetActive(false)
      Group_Character01.Txt_LevelMax:SetText("MAX")
    else
      Group_Character01.Txt_LevelMax:SetText("")
    end
    Group_Character01.Group_Exp.Txt_Num:SetText(0)
    Group_Character01.Img_Exp.Img_Now:SetFilledImgAmount(0)
    Group_Character01.Img_Exp.Img_Before:SetFilledImgAmount(before_exp / levelUpExp)
    row.lv_ani = before_lv
    row.lv_ani_speed = (now_lv - before_lv) / SettlementConfig.NumSpeed
    row.exp_ani = 0
    row.exp_ani_speed = exp / SettlementConfig.NumSpeed
    row.front_exp = 0
    row.diff_exp = 0
    local isShowTrust = PlayerData.BattleInfo.coreId ~= nil
    element.Group_Character01.Group_Trust:SetActive(not isShowTrust)
    if isShowTrust then
      local trustCfg = PlayerData:GetFactoryData(99900039)
      local trustLv = PlayerData:GetRoleById(row.roleid).trust_lv or 1
      local isMax = trustLv >= #trustCfg.trustExpList
      element.Group_Character01.Group_Trust.Txt_Max:SetActive(isMax)
      element.Group_Character01.Group_Trust.Img_Up:SetActive(not isMax)
      element.Group_Character01.Group_Trust.Txt_Leader:SetActive(false)
      if isMax == false then
        local heard_id = PlayerData.ServerData.squad[PlayerData.BattleInfo.squadIndex].header
        if row.roleid == heard_id then
          local leaderExtra = PlayerData:GetFactoryData(99900039).leaderExtra
          leaderExtra = math.floor(leaderExtra * 100)
          element.Group_Character01.Group_Trust.Txt_Leader:SetActive(true)
          element.Group_Character01.Group_Trust.Txt_Leader:SetText(string.format(GetText(80601879), leaderExtra))
        end
      end
    end
  end,
  Settlement_Group_Victory_Btn_Restart_Click = function(btn, str)
    Restart()
  end,
  Settlement_Group_Victory_Btn_Next_Click = function(btn, str)
    DataModel.AutoNextGoState = true
    SetReportTrackList(1)
    CommonTips.OpenArbitrarilyUI(PlayerData.BattleCallBackPage, PlayerData.Last_Chapter_Parms)
  end,
  Settlement_Group_Victory_Group_Statistics_StaticGrid_Character_SetGrid = function(element, elementIndex)
  end,
  Settlement_Group_Victory_Group_Statistics_Btn_Character_Click = function(btn, str)
  end,
  Settlement_Group_Victory_ScrollGrid_Rewards_SetGrid = function(element, elementIndex)
    local row = PlayerData.BattleInfo.DropAwardList[tonumber(elementIndex)]
    CommonItem:SetItem(element.Group_Item, {
      id = row.id,
      num = row.num or row.server.num
    }, EnumDefine.ItemType.Item, nil, View)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    if row == nil then
      element.self:SetActive(false)
      return
    end
  end,
  Settlement_Group_Victory_ScrollGrid_Rewards_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local row = PlayerData.BattleInfo.DropAwardList[tonumber(str)]
    CommonTips.OpenPreRewardDetailTips(row.id, row)
  end,
  Settlement_Group_Victory_Btn_Statistics_Click = function(btn, str)
  end,
  Settlement_Group_Victory_Group_Core_Group_Record_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  Settlement_Group_SettlementPrompt_Btn_BG_Click = function(btn, str)
  end,
  Settlement_Group_SettlementPrompt_Btn_Cancel_Click = function(btn, str)
    View.Group_SettlementPrompt.self:SetActive(false)
  end,
  Settlement_Group_SettlementPrompt_Btn_ReSquads_Click = function(btn, str)
    PlayerData.SquadsTempData.IsReStart = true
    local status = PlayerData.SquadsTempData
    UIManager:Open("UI/Squads/Squads", Json.encode(status))
  end,
  Settlement_Group_SettlementPrompt_Btn_Confirm_Click = function(btn, str)
    DataModel.IsReStart = true
    local noCallBack = function()
      DataModel.AutoNextGoState = false
      CommonTips.OpenArbitrarilyUI(PlayerData.BattleCallBackPage, PlayerData.Last_Chapter_Parms)
    end
    local StartBattle = require("UISquads/View_StartBattle")
    StartBattle:StartBattle(PlayerData.BattleInfo.battleStageId, PlayerData.BattleInfo.levelType, PlayerData.BattleInfo.roleDataList, PlayerData.BattleInfo.squadIndex, PlayerData.BattleInfo.levelIndexStr, PlayerData.BattleInfo.isBattleTest, PlayerData.BattleInfo.eventId, PlayerData.BattleInfo.levelKey, PlayerData.BattleInfo.battleFinishCallback, noCallBack, PlayerData.BattleInfo.enemyLevelMin, PlayerData.BattleInfo.difficulty, PlayerData.BattleInfo.bgId, PlayerData.BattleInfo.enemyLevel, PlayerData.BattleInfo.enemyRn, PlayerData.BattleInfo.weatherIdList, PlayerData.BattleInfo.weatherRateSN, PlayerData.BattleInfo.enemyLevelOffset, PlayerData.BattleInfo.secondWeatherList, PlayerData.BattleInfo.secondWeatherRateSN, PlayerData.BattleInfo.secondWeatherCount, PlayerData.BattleInfo.enemy_ids)
  end,
  Settlement_Group_Victory_Btn_Detail_Click = function(btn, str)
    UIManager:Open("UI/Battle/TestLevelDetail", Json.encode(require("UITestLevel/UITestLevelDataModel").RecordDetail))
  end,
  Settlement_Group_Defeat_Btn_Detail_Click = function(btn, str)
    UIManager:Open("UI/Battle/TestLevelDetail", Json.encode(require("UITestLevel/UITestLevelDataModel").RecordDetail))
  end,
  Settlement_Btn_Detail_Click = function(btn, str)
    UIManager:Open("UI/Battle/TestLevelDetail", Json.encode(require("UITestLevel/UITestLevelDataModel").RecordDetail))
  end,
  Settlement_Group_Timeout_Btn_BG_Click = function(btn, str)
  end,
  Settlement_Group_Timeout_Btn_Replay_Click = function(btn, str)
  end,
  Settlement_Group_Timeout_Btn_Next_Click = function(btn, str)
    View.Group_Timeout.self:SetActive(false)
    LoadingManager:SetLoadingPercent(0.75)
    CommonTips.OpenArbitrarilyUI(PlayerData.BattleCallBackPage, PlayerData.Last_Chapter_Parms)
  end,
  Settlement_Group_Timeout_Btn_Detail_Click = function(btn, str)
  end,
  Settlement_Group_Victory_Group_CharacterExp_BtnPolygon_Statistics_Click = function(btn, str)
  end,
  Settlement_Group_GradeUp_Btn_Shade_Click = function(btn, str)
    View.Group_GradeUp.self:SetActive(false)
    DataModel.IsSkipLevel = false
  end,
  Settlement_GradeUp_Btn_Shade_Click = function(btn, str)
  end,
  Settlement_Group_Victory_Group_Right_Group_CharacterExp_StaticGrid_Character_SetGrid = function(element, elementIndex)
    local row = DataModel.RoleList[tonumber(elementIndex)]
    if row == nil then
      element.self:SetActive(false)
      return
    end
    local face = row.face or PlayerData:GetFactoryData(row.viewId).face
    local name = row.name
    local Group_Character01 = element.Group_Character01
    Group_Character01.Img_Mask.Img_Face:SetSprite(face)
    Group_Character01.Txt_Name:SetText(name)
    local before_lv = row.before.lv or 1
    local now_lv = row.now.lv or 1
    Group_Character01.Group_Lv.Txt_Num:SetText(before_lv)
    local data = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
    local levelUpExp
    if data[before_lv] then
      levelUpExp = data[before_lv].levelUpExp
    else
      levelUpExp = data[table.count(data)].levelUpExp
    end
    local now_exp = row.now.exp or 0
    local before_exp = row.before.exp or 0
    local exp = now_exp - before_exp
    local isMax = PlayerData:RoleLvIsMax(row.roleid, before_lv)
    if isMax == true then
      Group_Character01.Group_LevelUp.self:SetActive(false)
      Group_Character01.Txt_LevelMax:SetText("MAX")
    else
      Group_Character01.Txt_LevelMax:SetText("")
    end
    Group_Character01.Group_Exp.Txt_Num:SetText(0)
    Group_Character01.Img_Exp.Img_Now:SetFilledImgAmount(0)
    Group_Character01.Img_Exp.Img_Before:SetFilledImgAmount(before_exp / levelUpExp)
    row.lv_ani = before_lv
    row.lv_ani_speed = (now_lv - before_lv) / SettlementConfig.NumSpeed
    row.exp_ani = 0
    row.exp_ani_speed = exp / SettlementConfig.NumSpeed
    row.front_exp = 0
    row.diff_exp = 0
  end,
  Settlement_Group_Victory_Group_Right_Group_Statistics_StaticGrid_Character_SetGrid = function(element, elementIndex)
    local row = DataModel.RoleList[tonumber(elementIndex)]
    if row == nil then
      element.self:SetActive(false)
      return
    end
    local face = row.face or PlayerData:GetFactoryData(row.viewId).face
    local name = row.name
    local Group_Character02 = element.Group_Character02
    Group_Character02.Img_Face:SetSprite(face)
    Group_Character02.Txt_Name:SetText(name)
    local now_lv = row.now.lv or 1
    Group_Character02.Txt_Num:SetText(now_lv)
    local battleInfo = row.battleInfo
    local all_damage = PlayerData.BattleInfo.BattleResult.damageTotal
    local damage_value = battleInfo.damage
    local Group_Damage = Group_Character02.Group_Damage
    Group_Damage.Img_Percentage:SetFilledImgAmount(damage_value / all_damage)
    Group_Damage.Txt_Num:SetText(damage_value)
    if damage_value / all_damage == 0 or all_damage == 0 then
      Group_Damage.Txt_Percentage:SetText("0%")
    else
      Group_Damage.Txt_Percentage:SetText(string.format("%.2f", damage_value / all_damage * 100) .. "%")
    end
    local all_takeaamage = PlayerData.BattleInfo.BattleResult.getHitTotal
    local takeaamage_value = battleInfo.getHit
    local Group_TakeDamage = Group_Character02.Group_TakeDamage
    Group_TakeDamage.Img_Percentage:SetFilledImgAmount(takeaamage_value / all_takeaamage)
    Group_TakeDamage.Txt_Num:SetText(takeaamage_value)
    if takeaamage_value / all_takeaamage == 0 or all_takeaamage == 0 then
      Group_TakeDamage.Txt_Percentage:SetText("0%")
    else
      Group_TakeDamage.Txt_Percentage:SetText(string.format("%.2f", takeaamage_value / all_takeaamage * 100) .. "%")
    end
    local all_therapy = PlayerData.BattleInfo.BattleResult.healTotal
    local therapy_value = battleInfo.heal
    local Group_Therapy = Group_Character02.Group_Therapy
    Group_Therapy.Img_Percentage:SetFilledImgAmount(therapy_value / all_therapy)
    Group_Therapy.Txt_Num:SetText(therapy_value)
    if therapy_value / all_therapy == 0 or all_therapy == 0 then
      Group_Therapy.Txt_Percentage:SetText("0%")
    else
      Group_Therapy.Txt_Percentage:SetText(string.format("%.2f", therapy_value / all_therapy * 100) .. "%")
    end
  end,
  Settlement_Group_Victory_Group_Right_Group_Statistics_Btn_Character_Click = function(btn, str)
    View.Group_Victory.Group_CharacterExp.self:SetActive(true)
    View.Group_Victory.Group_Statistics.self:SetActive(false)
  end,
  Settlement_Group_Victory_Group_Right_Btn_Next_Click = function(btn, str)
    DataModel.AutoNextGoState = true
    SetReportTrackList(1)
    local levelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId, "LevelFactory")
    local autoNextLevelBattle = levelCA.mod == EnumDefine.BattleLevelMod.challenge and not PlayerData.BattleInfo.isPassed and levelCA.nextLevel ~= nil and levelCA.nextLevel > 0 and LevelCheck.AllCheck(levelCA.nextLevel)
    local callBack = function()
      CommonTips.OpenArbitrarilyUI(PlayerData.BattleCallBackPage, PlayerData.Last_Chapter_Parms)
    end
    if table.count(DataModel.DropAwardList) == 0 then
      if autoNextLevelBattle == true then
        local StartBattle = require("UISquads/View_StartBattle")
        StartBattle:NextLevelBattle(true, callBack)
        return
      end
      callBack()
      return
    end
    CommonTips.OpenShowItem(DataModel.DropAwardList, function()
      if autoNextLevelBattle == true then
        local StartBattle = require("UISquads/View_StartBattle")
        StartBattle:NextLevelBattle(true, callBack)
        return
      end
      callBack()
    end)
  end,
  Settlement_Group_Reward_Btn_BG_Click = function(btn, str)
    local levelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId, "LevelFactory")
    local autoNextLevelBattle = levelCA.mod == EnumDefine.BattleLevelMod.challenge and not PlayerData.BattleInfo.isPassed and levelCA.nextLevel ~= nil and levelCA.nextLevel > 0 and LevelCheck.AllCheck(levelCA.nextLevel)
    local callBack = function()
      CommonTips.OpenArbitrarilyUI(PlayerData.BattleCallBackPage, PlayerData.Last_Chapter_Parms)
    end
    if autoNextLevelBattle then
      local StartBattle = require("UISquads/View_StartBattle")
      StartBattle:NextLevelBattle(true, callBack)
      return
    end
    callBack()
  end,
  Settlement_Group_Reward_ScrollGrid_Reward_Tab = function(index)
  end,
  Settlement_Group_Reward_ScrollGrid_Reward_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Settlement_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
    local row = PlayerData.BattleInfo.DropAwardList[tonumber(elementIndex)]
    element.Btn_Item:SetClickParam(elementIndex)
    if row == nil then
      element.self:SetActive(false)
      return
    end
    element.Img_Bottom:SetSprite(UIConfig.BottomConfig[row.quality + 1] or UIConfig.BottomConfig[1])
    element.Img_Mask:SetSprite(UIConfig.MaskConfig[row.quality + 1] or UIConfig.MaskConfig[1])
    local factoryName = row.factoryName
    local id = factoryName.id
    local image
    if factoryName == "UnitFactory" then
      local viewId = PlayerData:GetFactoryData(id, factoryName).viewId
      local factory = "UnitViewFactory"
      image = PlayerData:GetFactoryData(viewId, factory).face
    else
      image = PlayerData:GetFactoryData(id, factoryName).iconPath
    end
    element.Img_Item:SetSprite(image)
    element.Txt_Num:SetText(row.num)
  end,
  Settlement_Group_Reward_StaticGrid_Reward_Group_Item_Btn_Item_Click = function(btn, str)
    local row = PlayerData.BattleInfo.DropAwardList[tonumber(str)]
    CommonTips.OpenRewardDetail(row.id, row)
  end,
  Settlement_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  Settlement_Group_Victory_Group_Right_Group_CharacterExp_BtnPolygon_Statistics_Click = function(btn, str)
    View.Group_Victory.Group_Right.Group_CharacterExp.self:SetActive(false)
    View.Group_Victory.Group_Right.Group_Statistics.self:SetActive(true)
  end
}
return ViewFunction
