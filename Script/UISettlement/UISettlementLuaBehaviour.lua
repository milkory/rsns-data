local CommonItem = require("Common/BtnItem")
local View = require("UISettlement/UISettlementView")
local DataModel = require("UISettlement/UISettlementDataModel")
local ViewFunction = require("UISettlement/UISettlementViewFunction")
local SettlementConfig = require("UISettlement/UISettlementSetting")
local BattleResult, RoleList
local Data = {}
local Score, UserLevelMaxData, UnitLevelMaxData
local ReportTrackList = {}
local ConfigFactory, delay_ani_time
local isGridFinish = false
local UserExpConfig
DataModel.now_evaluate = {}
DataModel.now_evaluate_index = 4
local is_administration = false
local comparison_table = {
  [1] = {cn = "甲", en = "S"},
  [2] = {cn = "乙", en = "A"},
  [3] = {cn = "丙", en = "B"},
  [4] = {cn = "丁", en = "C"},
  [5] = {cn = "丁", en = "C"}
}
local PlayRoleSound = function(role_id, sound_type)
  local roleConfig = PlayerData:GetFactoryData(role_id)
  if roleConfig.fileList[1] == nil then
    return
  end
  local file_id = roleConfig.fileList[1].file
  local file_cfg = PlayerData:GetFactoryData(file_id)
  local battle_list = file_cfg.BattleAudio or {}
  local sound_list = {}
  for i, v in ipairs(battle_list) do
    if sound_type == 1 then
      if v.AudioTypeInt == 4 then
        table.insert(sound_list, v.id2)
      end
    elseif sound_type == -1 and v.AudioTypeInt == 3 then
      table.insert(sound_list, v.id2)
    end
  end
  local sound_count = #sound_list
  if 1 <= sound_count then
    math.randomseed(os.time())
    local sound_id = sound_list[math.random(1, sound_count)]
    local sound = SoundManager:CreateSound(sound_id)
    if sound ~= nil then
      sound:Play()
    end
  end
end
local CountEvaluateScore = function(stageid)
  local LevelFactory = PlayerData:GetFactoryData(stageid, "LevelFactory")
  local maxScoreList = LevelFactory.maxScoreList
  local difficulty = LevelFactory.difficulty
  local difficulty_num
  if difficulty == "Normal" then
    difficulty_num = ConfigFactory.sdiff01
  end
  if difficulty == "Difficult" then
    difficulty_num = ConfigFactory.sdiff02
  end
  local time = LevelFactory.time or 1
  local sec = (time - BattleResult.duration) * ConfigFactory.stime01
  if sec < 0 then
    sec = 0
  end
  local roleScore = ConfigFactory.slive01 - (table.count(BattleResult.roleInfoList) - BattleResult.survivor) * ConfigFactory.slive02
  local score = math.max((sec + roleScore) * (difficulty_num or 1), 0)
  Score = score
  local evaluate
  for i = 1, table.count(maxScoreList) do
    if score > tonumber(maxScoreList[i].gradeLine) then
      evaluate = comparison_table[i]
      DataModel.now_evaluate_index = i
      break
    end
  end
  if evaluate == nil then
    evaluate = comparison_table[#comparison_table]
    DataModel.now_evaluate_index = #comparison_table
  end
  if is_administration == true then
    DataModel.now_evaluate = evaluate.cn
  else
    DataModel.now_evaluate = evaluate.en
  end
end
local Img_PlayerExp, Group_Damage, Group_Score, Group_MVP, before_lv_ani, now_lv_ani
local now_exp_ani = 0
local before_exp_ani = 0
local show_top_exp_ani, top_exp_ani, top_exp_ani_speed, damage_ani, damage_ani_speed, front_exp, diff_exp, temp_lv_ani, temp_score_ani, temp_score_ani_speed
local before_expel = 0
local now_expel = 0
local expel_ani = 0
local cacheSeriesName = ""
local cacheDeterrence = 0
local old_coreLv = 0
local old_coreLvAni = 0
local new_coreLv = 0
local coreLv_ani = 0
local core_breakCnt = 0
local core_breakLv = 0
local core_unitId = 0
local old_coreNum = 0
local new_coreNum = 0
local core_restart = false
local InitCoreInfo = function()
  core_restart = false
  if PlayerData.BattleInfo.coreId == nil then
    return
  end
  local serverInfo = PlayerData.ServerData.engines[tostring(PlayerData.BattleInfo.coreId)]
  local curLv = serverInfo.lv
  old_coreNum = serverInfo.num
  old_coreLv = curLv
  old_coreLvAni = old_coreLv
  local coreCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.coreId)
  core_unitId = 0
  local curMaxLv = 0
  for i, levelInfo in ipairs(coreCA.coreLevelList) do
    if levelInfo.id == PlayerData.BattleInfo.battleStageId then
      core_unitId = levelInfo.profileId
      curMaxLv = levelInfo.grade
      break
    end
  end
  core_breakCnt = 0
  for i = 1, old_coreLv do
    local info = coreCA.coreExpList[i]
    if info and info.isBreak then
      core_breakCnt = core_breakCnt + 1
    end
  end
  new_coreNum = tonumber(PlayerData.BattleInfo.BattleResult.cores) or 0
  new_coreLv = curLv
  for i = curLv + 1, curMaxLv do
    local info = coreCA.coreExpList[i]
    if info and new_coreNum >= info.num then
      new_coreLv = new_coreLv + 1
    end
    if info.isBreak then
      core_breakLv = i
      break
    end
  end
  if core_breakLv == 0 then
    local cnt = #coreCA.coreExpList
    for i = curMaxLv + 1, cnt do
      local info = coreCA.coreExpList[i]
      if info.isBreak then
        core_breakLv = i
        break
      end
    end
    if core_breakLv == 0 then
      core_breakLv = cnt
    end
  end
  coreLv_ani = (new_coreLv - old_coreLv) / SettlementConfig.NumSpeed
  serverInfo.lv = new_coreLv
  if new_coreNum > tonumber(serverInfo.num) then
    serverInfo.num = new_coreNum
  end
  core_restart = curMaxLv > new_coreLv
  if new_coreLv > old_coreLv then
    local preRedName = RedpointTree.NodeNames.Core .. "|" .. PlayerData.BattleInfo.coreId
    for lv = old_coreLv, new_coreLv do
      local expInfo = coreCA.coreExpList[lv]
      if expInfo and 0 < expInfo.id then
        local tempListCA = PlayerData:GetFactoryData(expInfo.id)
        if tempListCA and 0 < #tempListCA.EngineRewardList then
          local redName = preRedName .. "|" .. lv
          RedpointTree:InsertNode(redName)
          RedpointTree:ChangeRedpointCnt(redName, 1)
        end
      end
    end
  end
end
local FindPictures = function(id)
  for c, d in pairs(PlayerData.ServerData.pictures) do
    if d == id then
      return true
    end
  end
  return false
end
local FindMusic = function(id)
  for c, d in pairs(PlayerData.ServerData.music) do
    if d == id then
      return true
    end
  end
  return false
end
local FindEnemy = function(id)
  for c, d in pairs(PlayerData.ServerData.enemy) do
    if d == id then
      return true
    end
  end
  return false
end
local UnLockBook = function()
  if PlayerData.LevelData then
    local CA = PlayerData.LevelData
    local pictureList = CA.pictureList
    if table.count(pictureList) > 0 then
      for k, v in pairs(pictureList) do
        if FindPictures(v.id) == false then
          table.insert(PlayerData.ServerData.pictures, v.id)
        end
      end
    end
    local musicList = CA.musicList
    if table.count(musicList) > 0 then
      for k, v in pairs(musicList) do
        if FindMusic(v.id) == false then
          table.insert(PlayerData.ServerData.music, v.id)
        end
      end
    end
    local enemyBookList = CA.enemyBookList
    if table.count(enemyBookList) > 0 then
      for k, v in pairs(enemyBookList) do
        if FindEnemy(v.id) == false then
          table.insert(PlayerData.ServerData.enemy, v.id)
        end
      end
    end
  end
end
local RefreshAni = function()
  local exp = now_exp_ani - before_exp_ani
  if exp <= show_top_exp_ani and temp_score_ani >= Score and isGridFinish == true and before_expel >= now_expel and old_coreLvAni >= new_coreLv then
    DataModel.AniState = false
    if DataModel.IsSkipLevel == true then
      local parms = {}
      parms.before_lv_ani = before_lv_ani
      parms.temp_lv_ani = temp_lv_ani
      CommonTips.OpenGradeUpSkipLevel(parms)
      DataModel.IsSkipLevel = false
    end
    CommonTips.OpenQuestsCompleteTip()
    CommonTips.OpenRepLvUp()
    if now_expel == 1 then
      CommonTips.OpenExpelTips(cacheSeriesName, cacheDeterrence)
    end
    if PlayerData.BattleInfo.coreId ~= nil and new_coreLv > old_coreLv then
      CommonTips.OpenEngineCoreLvUp(PlayerData.BattleInfo.coreId, old_coreLv, new_coreLv)
    end
    if DataModel.DropAwardList.role and table.count(DataModel.DropAwardList.role) then
      local list = {}
      list.cards = {}
      list.index = 1
      list.goBackState = 1
      local count = 0
      for k, v in pairs(DataModel.DropAwardList.role) do
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
      UIManager:Open("UI/ShowCharacter/ShowCharacter", Json.encode(list), nil, nil, false, false)
    end
    return
  end
  local data = UserLevelMaxData
  local levelUpExp
  if data[temp_lv_ani] then
    levelUpExp = data[temp_lv_ani].levelUpExp
  else
    levelUpExp = data[table.count(data)].levelUpExp
  end
  local speed_exp_top_ani = exp / SettlementConfig.NumSpeed
  show_top_exp_ani = math.ceil(show_top_exp_ani + speed_exp_top_ani)
  show_top_exp_ani = exp < show_top_exp_ani and exp or show_top_exp_ani
  if 0 < exp then
    Img_PlayerExp.Group_Exp.self:SetActive(true)
    Img_PlayerExp.Group_Exp.Txt_Num:SetText(exp < show_top_exp_ani and exp or show_top_exp_ani)
  else
    Img_PlayerExp.Group_Exp.self:SetActive(false)
    Img_PlayerExp.Group_Exp.Txt_Num:SetText(0)
  end
  if temp_lv_ani > before_lv_ani then
    DataModel.IsSkipLevel = true
    if levelUpExp <= show_top_exp_ani - front_exp then
      front_exp = front_exp + levelUpExp
      temp_lv_ani = temp_lv_ani + 1
      diff_exp = now_exp_ani - show_top_exp_ani
    end
    if data[temp_lv_ani] then
      levelUpExp = data[temp_lv_ani].levelUpExp
    else
      levelUpExp = data[table.count(data)].levelUpExp
    end
    Img_PlayerExp.Img_Exp.Img_Before:SetFilledImgAmount(0)
    Img_PlayerExp.Img_Exp.Img_Now:SetFilledImgAmount((show_top_exp_ani - front_exp) / levelUpExp)
    local sum = show_top_exp_ani - front_exp
    if sum / levelUpExp == 0 then
      Img_PlayerExp.Img_Exp.Txt_Num:SetText("0%")
    else
      Img_PlayerExp.Img_Exp.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(sum / levelUpExp * 100, 1) .. "%")
    end
    if temp_lv_ani > before_lv_ani then
      DataModel.IsSkipLevel = true
    end
  else
    if levelUpExp <= show_top_exp_ani + before_exp_ani then
      front_exp = levelUpExp - before_exp_ani
      temp_lv_ani = temp_lv_ani + 1
      diff_exp = now_exp_ani - show_top_exp_ani
    end
    Img_PlayerExp.Img_Exp.Img_Now:SetFilledImgAmount((show_top_exp_ani + before_exp_ani) / levelUpExp)
    Img_PlayerExp.Img_Exp.Img_Before:SetFilledImgAmount(before_exp_ani / levelUpExp)
    local sum = show_top_exp_ani + before_exp_ani
    Img_PlayerExp.Img_Exp.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(sum / levelUpExp * 100, 1) .. "%")
  end
  Img_PlayerExp.Txt_Lv:SetText(temp_lv_ani)
  temp_score_ani_speed = Score / SettlementConfig.NumSpeed
  temp_score_ani = math.ceil(temp_score_ani + temp_score_ani_speed)
  Group_Score.Txt_Score:SetText(PlayerData:GetPreciseDecimalFloor(temp_score_ani > Score and Score or temp_score_ani, 0))
  for k, v in pairs(View.Group_Victory.Group_CharacterExp.StaticGrid_Character.grid) do
    local row = DataModel.RoleList[tonumber(k)]
    local element = v
    if row == nil then
      break
    end
    local before_lv = row.before.lv or 1
    local now_lv = row.now.lv or 1
    local Group_Character01 = element.Group_Character01
    local data = UnitLevelMaxData
    local levelUpExp
    if data[row.lv_ani] then
      levelUpExp = data[row.lv_ani].levelUpExp
    else
      levelUpExp = data[table.count(data)].levelUpExp
    end
    local now_exp = row.now.exp or 0
    local before_exp = row.before.exp or 0
    local exp = row.now_role_exp - before_exp
    row.exp_ani_speed = exp / SettlementConfig.NumSpeed
    row.exp_ani = math.ceil(row.exp_ani_speed + row.exp_ani)
    row.exp_ani = exp < row.exp_ani and exp or row.exp_ani
    if 0 < exp then
      Group_Character01.Group_Exp.self:SetActive(true)
      Group_Character01.Group_Exp.Txt_Num:SetText(now_exp < row.exp_ani and now_exp or row.exp_ani)
    else
      Group_Character01.Group_Exp.self:SetActive(false)
      Group_Character01.Group_Exp.Txt_Num:SetText(0)
    end
    local isMax = PlayerData:RoleLvIsMax(row.roleid, before_lv)
    if isMax == true then
      Group_Character01.Txt_LevelMax:SetText("MAX")
      Group_Character01.Img_Exp.Img_Now:SetFilledImgAmount(1)
      Group_Character01.Img_Exp.Img_Before:SetFilledImgAmount(0)
    else
      Group_Character01.Txt_LevelMax:SetText("")
    end
    if before_lv < row.lv_ani then
      if levelUpExp <= row.exp_ani - row.front_exp then
        row.front_exp = row.front_exp + levelUpExp
        row.lv_ani = row.lv_ani + 1
        diff_exp = now_exp_ani - row.exp_ani
      end
      if data[row.lv_ani] then
        levelUpExp = data[row.lv_ani].levelUpExp
      else
        levelUpExp = data[table.count(data)].levelUpExp
      end
      Group_Character01.Img_Exp.Img_Before:SetFilledImgAmount(0)
      Group_Character01.Img_Exp.Img_Now:SetFilledImgAmount((row.exp_ani - row.front_exp) / levelUpExp)
    else
      if levelUpExp <= row.exp_ani + before_exp then
        row.front_exp = levelUpExp - before_exp
        row.lv_ani = row.lv_ani + 1
        diff_exp = now_exp_ani - row.exp_ani
      end
      Group_Character01.Img_Exp.Img_Now:SetFilledImgAmount((row.exp_ani + before_exp) / levelUpExp)
      Group_Character01.Img_Exp.Img_Before:SetFilledImgAmount(before_exp / levelUpExp)
    end
    Group_Character01.Group_Exp.Txt_Num:SetText(exp < row.exp_ani and exp or row.exp_ani)
    Group_Character01.Group_Lv.Txt_Num:SetText(now_lv < row.lv_ani and now_lv or row.lv_ani)
  end
  if 0 < expel_ani then
    local expelSpeed = expel_ani / SettlementConfig.NumSpeed
    before_expel = before_expel + expelSpeed
    before_expel = before_expel > now_expel and now_expel or before_expel
    View.Group_Victory.Img_Expel.Group_1.Txt_Schedule:SetText(math.ceil(before_expel * 100) .. "%")
  end
  if 0 < coreLv_ani then
    old_coreLvAni = old_coreLvAni + coreLv_ani
    old_coreLvAni = old_coreLvAni >= new_coreLv and new_coreLv or old_coreLvAni
    View.Group_Victory.Group_Core.Group_Break.Txt_Num:SetText(string.format(GetText(80602007), math.floor(old_coreLvAni + 1.0E-4), core_breakLv))
  end
end
local RefreshBattleVictoryResultPage = function()
  local isCore = PlayerData.BattleInfo.coreId ~= nil
  local coreCA
  if isCore then
    coreCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.coreId)
  end
  temp_lv_ani = before_lv_ani
  now_lv_ani = Data.user_info.lv
  now_exp_ani = Data.user_info.exp
  before_exp_ani = DataModel.user_info.exp
  local temp_exp = 0
  if now_exp_ani - before_exp_ani <= 0 and now_lv_ani ~= before_lv_ani then
    if 0 < now_lv_ani - temp_lv_ani then
      for i = temp_lv_ani, now_lv_ani - 1 do
        local levelUpExp = UserLevelMaxData[i].levelUpExp
        temp_exp = temp_exp + levelUpExp - before_exp_ani
      end
      now_exp_ani = now_exp_ani + temp_exp
    else
      now_exp_ani = -1 * now_exp_ani
    end
    now_exp_ani = now_exp_ani + before_exp_ani
  end
  damage_ani = 0
  top_exp_ani = 0
  show_top_exp_ani = 0
  temp_score_ani = 0
  View.Group_Victory.Btn_Restart.self:SetActive(false)
  View.Group_Victory.self:SetActive(true)
  View.Group_Victory.Btn_Detail.self:SetActive(true)
  local group_victory = View.Group_Victory
  local victory_center = group_victory.Group_Center
  local victory_left = group_victory
  local LevelFactory = DataModel.LevelCA
  local level_chapter = LevelFactory.levelChapter or ""
  local chapter_name = LevelFactory.levelName or ""
  victory_left.Group_Score.Txt_Score:SetText(0)
  victory_left.Group_Score.Group_Time.Txt_MinNum:SetText(TimeUtil:SecondToTable(BattleResult.duration).minute)
  victory_left.Group_Score.Group_Time.Txt_SecNum:SetText(TimeUtil:SecondToTable(BattleResult.duration).second)
  victory_left.Group_Score.Group_Live.Txt_LiveNum:SetText(BattleResult.survivor)
  victory_left.Group_Level.Txt_LevelNumber:SetText(level_chapter)
  victory_left.Group_Level.Txt_LevelName:SetText(chapter_name)
  victory_left.Group_Tips:SetActive(not isCore)
  victory_left.Group_CoreTips:SetActive(isCore)
  victory_left.Group_MVP:SetActive(not isCore)
  victory_left.Group_CoreMVP:SetActive(isCore)
  victory_left.Group_Core:SetActive(isCore)
  Img_PlayerExp:SetActive(not isCore)
  if isCore then
    if 0 < core_unitId then
      local unitCA = PlayerData:GetFactoryData(core_unitId)
      View.Group_Victory.Group_CoreMVP.Txt_Victory:SetText(string.format(GetText(80601850), unitCA.name))
    end
    victory_left.Group_Core.Img_Di:SetSprite(coreCA.settlementIconPath)
    victory_left.Group_Core.Img_Icon:SetSprite(coreCA.coreIconPath)
    victory_left.Group_Core.Txt_EngName:SetText(coreCA.nameEN)
    victory_left.Group_Core.Txt_Name:SetText(GetText(coreCA.name))
    victory_left.Group_Core.Group_Break.Txt_Num:SetText(string.format(GetText(80602007), old_coreLv, core_breakLv))
    for i = 1, 5 do
      local element = victory_left.Group_Core.Group_Break["Img_Break" .. i]
      local isShow = i <= core_breakCnt
      element:SetActive(isShow)
      if isShow then
        element:SetSprite(coreCA.breakPath)
      end
    end
    local avatar = PlayerData:GetUserInfo().avatar
    local photoFactory = PlayerData:GetFactoryData(avatar, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      victory_left.Group_Core.Group_Record.Btn_ProfilePhoto.Img_Client:SetSprite(photoFactory.imagePath)
    end
    local endExp = PlayerData:GetMaxExp()
    victory_left.Group_Core.Group_Record.Img_EXPPB:SetFilledImgAmount(PlayerData:GetUserInfo().exp / endExp)
    victory_left.Group_Core.Group_Record.Txt_Num:SetText(string.format(GetText(coreCA.settlementNum), new_coreNum))
    victory_left.Group_Core.Group_Record.Txt_Num.Img_New:SetActive(old_coreNum < new_coreNum)
    victory_left.Group_Core.Group_Record.Txt_Time:SetText(os.date("%Y-%m-%d %H:%M", TimeUtil:GetServerTimeStamp()))
    victory_left.Group_Core.Group_Record.Group_LV.Txt_Num:SetText(PlayerData:GetPlayerLevel())
  end
  local unit = PlayerData:GetRoleById(BattleResult.mvpId)
  local unitCA = PlayerData:GetFactoryData(BattleResult.mvpId)
  local viewId = unitCA.viewId
  if unit and 0 < table.count(unit) then
    viewId = unit.current_skin[1]
  end
  local receptionistData = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  local spineUrl = receptionistData.spineUrl
  victory_center.SpineAnimation_Character:SetActive(false)
  victory_center.Img_Character:SetActive(false)
  victory_center.Spine_Character:SetActive(false)
  if receptionistData ~= nil and spineUrl ~= "" then
    local isSpine2 = false
    if PlayerData:GetRoleById(BattleResult.mvpId).resonance_lv == 5 and receptionistData.spine2Url ~= nil and receptionistData.spine2Url ~= "" and unit.current_skin[2] == 1 then
      isSpine2 = true
      spineUrl = receptionistData.spine2Url
    end
    victory_center.SpineAnimation_Character:SetActive(not isSpine2)
    victory_center.SpineSecondMode_Character:SetActive(isSpine2)
    if isSpine2 then
      victory_center.SpineAnimation_Character:SetLocalScale(Vector3(receptionistData.spine2Scale, receptionistData.spine2Scale, 1))
      victory_center.SpineSecondMode_Character:SetPrefab(spineUrl)
      victory_center.SpineAnimation_Character:SetData("")
      if receptionistData.state2Overturn == true then
        victory_center.Group_Spine.SpineSecondMode_Character:SetLocalScale(Vector3(-1 * receptionistData.spine2Scale, receptionistData.spine2Scale, 1))
      end
    else
      victory_center.SpineAnimation_Character:SetLocalScale(Vector3(100, 100, 1))
      victory_center.SpineSecondMode_Character:SetPrefab("")
      victory_center.SpineAnimation_Character:SetActive(true)
      victory_center.SpineAnimation_Character:SetData(spineUrl)
    end
  else
    victory_center.SpineAnimation_Character:SetActive(false)
    victory_center.self:SetActive(true)
    victory_center.Img_Character:SetSprite(receptionistData.resUrl)
    victory_center.Img_Character:SetNativeSize()
  end
  local name = unitCA.name
  local mvpInfo = BattleResult.roleInfoList[tostring(BattleResult.mvpId)]
  if not isCore then
    victory_left.Group_MVP.Group_NameAndDamage.Txt_Name:SetText(name)
    victory_left.Group_MVP.Group_NameAndDamage.Txt_DamageNum:SetText(mvpInfo.damage)
  else
    victory_left.Group_CoreMVP.Group_NameAndDamage.Txt_Name:SetText(name)
    local coreBuffCount = mvpInfo.coreBuffCount or {}
    local buffCnt = 0
    for i, cnt in pairs(coreBuffCount) do
      buffCnt = buffCnt + cnt
    end
    victory_left.Group_CoreMVP.Group_NameAndDamage.Txt_DamageNum:SetText(string.format(GetText(coreCA.mvpNum), buffCnt))
  end
  victory_left.Group_Score.Img_Bottom:SetSprite(UIConfig.SettleMentGradBottom[DataModel.now_evaluate])
  victory_left.Group_Score.Img_Grade:SetSprite(UIConfig.SettleMentGrad[DataModel.now_evaluate])
  victory_left.Group_Score.Img_Mask:SetSprite(UIConfig.SettleMentGradMask[DataModel.now_evaluate])
  local before_lv = DataModel.user_info.lv
  local now_lv = Data.user_info.lv
  Img_PlayerExp.Txt_Lv:SetText(before_lv)
  local data = UserLevelMaxData
  local levelUpExp
  if data[now_lv] then
    levelUpExp = data[now_lv].levelUpExp
  else
    levelUpExp = data[table.count(data)].levelUpExp
  end
  local now_exp = Data.user_info.exp
  local before_exp = DataModel.user_info.exp
  Img_PlayerExp.Group_Exp.Txt_Num:SetText(0)
  Img_PlayerExp.Img_Exp.Img_Now:SetFilledImgAmount(before_exp / levelUpExp)
  Img_PlayerExp.Img_Exp.Img_Before:SetFilledImgAmount(before_exp / levelUpExp)
  Img_PlayerExp.Img_Exp.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(before_exp / levelUpExp * 100, 1) .. "%")
  View.Group_Victory.Group_CharacterExp.self:SetActive(true)
  View.Group_Victory.Group_CharacterExp.StaticGrid_Character.self:RefreshAllElement()
  ViewFunction.Settlement_Group_Victory_Group_Right_Group_Statistics_Btn_Character_Click()
  View.Group_Victory.ScrollGrid_Rewards.self:SetActive(false)
  if not isCore and PlayerData.BattleInfo.DropAwardList and 0 < table.count(PlayerData.BattleInfo.DropAwardList) then
    View.Group_Victory.ScrollGrid_Rewards.self:SetActive(true)
    View.Group_Victory.ScrollGrid_Rewards.grid.self:SetDataCount(table.count(PlayerData.BattleInfo.DropAwardList))
    View.Group_Victory.ScrollGrid_Rewards.grid.self:RefreshAllElement()
  end
  local isShowExpel = false
  local levelCA = DataModel.LevelCA
  if 0 < levelCA.expelNum and 0 < levelCA.CorrespondingList then
    local listCA = PlayerData:GetFactoryData(levelCA.CorrespondingList, "ListFactory")
    local maxExpel = listCA.expelNum
    local serverInfo = PlayerData.ServerData.security_levels[tostring(listCA.buildingId)]
    if serverInfo and serverInfo[tostring(levelCA.CorrespondingList)] then
      serverInfo = serverInfo[tostring(levelCA.CorrespondingList)]
      if maxExpel > serverInfo.expel_num then
        isShowExpel = true
        cacheSeriesName = listCA.seriesName
        before_expel = serverInfo.expel_num / maxExpel
        local toExpel = (serverInfo.expel_num + levelCA.expelNum) / maxExpel
        toExpel = 1 < toExpel and 1 or toExpel
        now_expel = toExpel
        expel_ani = now_expel - before_expel
        View.Group_Victory.Img_Expel.self:SetActive(true)
        View.Group_Victory.Img_Expel.Group_1.Txt_Dec:SetText(string.format(GetText(80601113), cacheSeriesName))
        View.Group_Victory.Img_Expel.Group_1.Txt_Schedule:SetText(math.ceil(before_expel * 100) .. "%")
        serverInfo.expel_num = serverInfo.expel_num + levelCA.expelNum
        cacheDeterrence = 1 <= toExpel and listCA.deterrence or 0
        PlayerData:GetUserInfo().deterrence = PlayerData:GetUserInfo().deterrence + cacheDeterrence
      end
    end
  end
  if not isShowExpel then
    View.Group_Victory.Img_Expel.self:SetActive(false)
    before_expel = 0
    now_expel = 0
    expel_ani = 0
    cacheSeriesName = ""
  end
  View.self:StartC(LuaUtil.cs_generator(function()
    DataModel.AutoNextGoState = false
    DataModel.AniState = true
  end))
  local animName = "Win"
  if isCore then
    animName = "Core"
  end
  View.self:SelectPlayAnim(View.Group_Victory.self, animName, function()
    CommonTips.OpenQuestsCompleteTip()
    CommonTips.OpenRepLvUp()
  end)
  local Parent_1 = View.Group_Victory.Group_Score.Img_Bottom.Group_Effect.self
  Parent_1:SetDynamicGameObject(UIConfig.SettleMentEffect[DataModel.now_evaluate_index][1], 0, 0)
  DataModel.LoadSpineBg(viewId)
end
local RefreshBattleDefeatResultPage = function()
  Net:SendProto("battle.end_battle", function(jsons)
    Train.EventBattleFinish(jsons)
    DataModel.JsonList = jsons
    DataModel.AniState = false
    DataModel.AutoNextGoState = false
    local LevelFactory = DataModel.LevelCA
    local level_chapter = LevelFactory.levelChapter or ""
    local chapter_name = LevelFactory.levelName or ""
    View.Group_Defeat.Group_Level.Txt_LevelNumber:SetText(level_chapter)
    View.Group_Defeat.Group_Level.Txt_LevelName:SetText(chapter_name)
    View.Group_Defeat.self:SetActive(true)
    View.Group_Defeat.Btn_Detail.self:SetActive(true)
    View.Group_Defeat.Btn_Restart.self:SetActive(false)
    DataModel.now_evaluate_index = 0
    local heard_id = PlayerData.ServerData.squad[PlayerData.BattleInfo.squadIndex].header
    PlayRoleSound(heard_id, -1)
    View.self:SelectPlayAnim(View.Group_Defeat.self, "DefeatIn", function()
      CommonTips.OpenQuestsCompleteTip()
      CommonTips.OpenRepLvUp()
    end)
  end, PlayerData.BattleInfo.levelUid, 0, Json.encode(DataModel.DeadHero), function(json)
    if json.rc == "80601508" then
      View.Group_Timeout.self:SetActive(true)
      return
    end
  end, 0, PlayerData.BattleInfo.BattleResult.isExitBattle == true and -1 or 0, PlayerData.BattleInfo.BattleResult.cores)
end
local InitPage = function()
  DataModel.AutoSettlement = false
  DataModel.LevelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId)
  if DataModel.LevelCA.saleLevelType == "pollute" or DataModel.LevelCA.saleLevelType == "Line" then
    DataModel.AutoSettlement = PlayerData:GetPlayerPrefs("int", "IsAutoFight") == 1
  end
  View.Group_SettlementPrompt.self:SetActive(false)
  View.Btn_Detail:SetActive(CBus:GetManager(CS.ManagerName.ReplayManager).isBattleTest)
  DataModel.user_info = PlayerData.ServerData.user_info
  before_lv_ani = DataModel.user_info.lv
  DataModel.before_roles = {}
  DataModel.DelayTime = 0
  DataModel.AutoNextTime = 300 + DataModel.DelayTime * 60
  delay_ani_time = 200
  isGridFinish = false
  DataModel.SettingTime = math.max(SettlementConfig.NumSpeed, SettlementConfig.FillSpeed)
  Img_PlayerExp = View.Group_Victory.Img_PlayerExp
  Group_Score = View.Group_Victory.Group_Score
  UnitLevelMaxData = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
  UserLevelMaxData = PlayerData:GetFactoryData(99900004, "ConfigFactory").expList
  for k, v in pairs(PlayerData.ServerData.roles) do
    DataModel.before_roles[k] = v
  end
  BattleResult = PlayerData.BattleInfo.BattleResult
  RoleList = BattleResult.roleInfoList
  View.Group_Defeat.self:SetActive(false)
  View.Group_Victory.self:SetActive(false)
  View.Group_Timeout.self:SetActive(false)
  View.Group_Victory.Btn_Next.Txt_Time:SetActive(DataModel.AutoSettlement)
  View.Group_Victory.Btn_Next.Txt_Time:SetText(string.format(GetText(80600167), DataModel.AutoNextTime / 60))
  View.Group_Defeat.Btn_Next.Txt_Time:SetActive(DataModel.AutoSettlement)
  View.Group_Defeat.Btn_Next.Txt_Time:SetText(string.format(GetText(80600167), DataModel.AutoNextTime / 60))
  DataModel.now_evaluate = {}
  DataModel.JsonList = {}
  local hero_list = {}
  local string_ded = ""
  local connect = "&"
  if 0 < table.count(BattleResult.deadRoleList) then
    for k, v in pairs(BattleResult.deadRoleList) do
      string_ded = string_ded .. v .. connect
    end
  end
  string_ded = string.sub(string_ded, 1, string.len(string_ded) - 1)
  hero_list.enemyIds = BattleResult.enemy_ids
  hero_list.enemy_level_min = BattleResult.enemy_level_min
  hero_list.enemy_level = BattleResult.enemy_level
  hero_list.weather_id = BattleResult.weather_id
  hero_list.second_weather_id = BattleResult.second_weather_id
  hero_list.bgId = BattleResult.bgId
  hero_list.level_progress = BattleResult.level_progress or 0
  if DataModel.LevelCA.saleLevelType == "buoy" then
    View.Group_Victory.Group_MVP.Txt_Victory:SetText(GetText(80602351))
    View.Group_Victory.Group_Tips.Txt_victory_CN:SetText(GetText(80602351))
    View.Group_Victory.Group_Tips.Txt_victory_EN:SetText(GetText(80602401))
  else
    View.Group_Victory.Group_MVP.Txt_Victory:SetText(GetText(80602400))
    View.Group_Victory.Group_Tips.Txt_victory_CN:SetText(GetText(80602400))
    View.Group_Victory.Group_Tips.Txt_victory_EN:SetText(GetText(80602402))
  end
  DataModel.DeadHero = hero_list
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.IsBuyEnergy = false
    DataModel.IsReStart = false
    DataModel.AutoNextGoState = true
    DataModel.IsSkipLevel = false
    ConfigFactory = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    View.self:SetActive(false)
    View.self:SetActive(true)
    PlayerData.FreeCameraIndex = 1
    InitPage()
    if BattleResult.isWin == false then
      DataModel.DeadHero.dead_hero_num = table.count(RoleList) - BattleResult.survivor
      RefreshBattleDefeatResultPage()
    elseif BattleResult.isWin == true then
      CountEvaluateScore(PlayerData.BattleInfo.battleStageId)
      local currentHP = {}
      if PlayerData.LevelChain.OnLevelChain == true then
        local roleList = PlayerData.ServerData.squad[100].role_list
        for i = 1, table.count(roleList) do
          if roleList[i] ~= "" then
            local hp = PlayerData:GetFactoryData(roleList[i].id, "UnitFactory").hp_SN
            currentHP[tostring(roleList[i])] = hp
          end
        end
      end
      PlayerData:RefreshChapterSeverData()
      Net:SendProto("battle.end_battle", function(jsons)
        DataModel.JsonList = jsons
        if PlayerData.LevelChain.OnLevelChain == true then
          PlayerData.ServerData.level_chain.roles = currentHP
        end
        Train.EventBattleFinish(jsons)
        UnLockBook()
        InitCoreInfo()
        PlayerData.BattleInfo.DropAwardList = PlayerData:SortShowItem(jsons.reward)
        DataModel.DropAwardList = jsons.reward
        if jsons.last_level ~= nil and PlayerData.ChooseChapterType == 1 then
          PlayerData.last_level = tonumber(jsons.last_level)
        end
        Data = jsons
        DataModel.RoleList = {}
        local count = 1
        for k, v in pairs(RoleList) do
          local row = {}
          DataModel.RoleList[count] = row
          row.roleid = k
          local factory = PlayerData:GetFactoryData(row.roleid, "UnitFactory")
          row.name = factory.name
          row.viewId = factory.viewId
          row.viewList = PlayerData:GetFactoryData(row.viewId, "UnitViewFactory")
          row.face = row.viewList.face
          row.before = DataModel.before_roles[tostring(row.roleid)] == nil and PlayerData:GetFactoryData(tostring(row.roleid)) or DataModel.before_roles[tostring(row.roleid)]
          row.now = Data.roles[tostring(row.roleid)] or row.before
          local now_role_exp = row.now.exp or 0
          local before_role_exp = row.before.exp or 0
          local before_role_lv = row.before.lv or 0
          local now_role_lv = row.now.lv or 0
          local temp_exp = 0
          if 0 < now_role_lv - before_role_lv then
            for i = before_role_lv, now_role_lv - 1 do
              local levelUpExp = UnitLevelMaxData[i].levelUpExp
              temp_exp = temp_exp + levelUpExp - before_role_exp
            end
            now_role_exp = now_role_exp + temp_exp + before_role_exp
          end
          row.now_role_exp = now_role_exp
          row.battleInfo = v
          row.exp_ani = 0
          count = count + 1
        end
        DataModel.DeadHero.dead_hero_num = table.count(DataModel.RoleList) - BattleResult.survivor
        if PlayerData.ChooseChapterType == 3 then
          ViewFunction:Settlement_Group_Victory_Group_Right_Btn_Next_Click()
        else
          RefreshBattleVictoryResultPage()
        end
        local mvp_id = BattleResult.mvpId
        PlayRoleSound(mvp_id, 1)
      end, PlayerData.BattleInfo.levelUid, math.floor(Score), Json.encode(DataModel.DeadHero), function(json)
        if json.rc == "80601508" then
          View.Group_Timeout.self:SetActive(true)
          return
        end
        Net:SendProto("battle.end_battle", function(jsons)
          DataModel.JsonList = jsons
          if PlayerData.LevelChain.OnLevelChain == true then
            PlayerData.ServerData.level_chain.roles = currentHP
          end
          Train.EventBattleFinish(jsons)
          UnLockBook()
          InitCoreInfo()
          PlayerData.BattleInfo.DropAwardList = PlayerData:SortShowItem(jsons.reward)
          DataModel.DropAwardList = jsons.reward
          if jsons.last_level ~= nil and PlayerData.ChooseChapterType == 1 then
            PlayerData.last_level = tonumber(jsons.last_level)
          end
          Data = jsons
          DataModel.RoleList = {}
          local count = 1
          for k, v in pairs(RoleList) do
            local row = {}
            DataModel.RoleList[count] = row
            row.roleid = k
            local factory = PlayerData:GetFactoryData(row.roleid, "UnitFactory")
            row.name = factory.name
            row.viewId = factory.viewId
            row.viewList = PlayerData:GetFactoryData(row.viewId, "UnitViewFactory")
            row.face = row.viewList.face
            row.before = DataModel.before_roles[tostring(row.roleid)] == nil and PlayerData:GetFactoryData(tostring(row.roleid)) or DataModel.before_roles[tostring(row.roleid)]
            row.now = Data.roles[tostring(row.roleid)] or row.before
            local now_role_exp = row.now.exp or 0
            local before_role_exp = row.before.exp or 0
            local before_role_lv = row.before.lv or 0
            local now_role_lv = row.now.lv or 0
            local temp_exp = 0
            if 0 < now_role_lv - before_role_lv then
              for i = before_role_lv, now_role_lv - 1 do
                local levelUpExp = UnitLevelMaxData[i].levelUpExp
                temp_exp = temp_exp + levelUpExp - before_role_exp
              end
              now_role_exp = now_role_exp + temp_exp + before_role_exp
            end
            row.now_role_exp = now_role_exp
            row.battleInfo = v
            row.exp_ani = 0
            count = count + 1
          end
          if PlayerData.ChooseChapterType == 3 then
            ViewFunction:Settlement_Group_Victory_Group_Right_Btn_Next_Click()
          else
            RefreshBattleVictoryResultPage()
          end
        end, PlayerData.BattleInfo.levelUid, math.floor(Score), Json.encode(DataModel.DeadHero), nil, Json.encode(currentHP), 1, PlayerData.BattleInfo.BattleResult.cores)
      end, Json.encode(currentHP), 1, PlayerData.BattleInfo.BattleResult.cores)
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if PlayerData.ChooseChapterType == 3 and BattleResult.isWin == true then
      return
    end
    if DataModel.AutoNextGoState == false then
      DataModel.AutoNextTime = DataModel.AutoNextTime - 1
      DataModel.SettingTime = DataModel.SettingTime - 1
    end
    if DataModel.SettingTime <= 0 then
      isGridFinish = true
    end
    if DataModel.AutoSettlement then
      if DataModel.AutoNextTime == 0 and DataModel.AutoNextGoState == false then
        DataModel.AutoNextGoState = true
        if BattleResult.isWin == false then
          ViewFunction:Settlement_Group_Defeat_Btn_Next_Click()
        elseif BattleResult.isWin == true then
          ViewFunction:Settlement_Group_Victory_Btn_Next_Click()
        end
      end
      if DataModel.AutoNextGoState == false then
        if BattleResult.isWin == false then
          View.Group_Defeat.Btn_Next.Txt_Time:SetText(string.format(GetText(80600167), math.ceil(0 <= DataModel.AutoNextTime / 60 and DataModel.AutoNextTime / 60 or 0)))
        elseif BattleResult.isWin == true then
          View.Group_Victory.Btn_Next.Txt_Time:SetText(string.format(GetText(80600167), math.ceil(0 <= DataModel.AutoNextTime / 60 and DataModel.AutoNextTime / 60 or 0)))
        end
      elseif DataModel.AutoNextGoState == true then
        View.Group_Victory.Btn_Next.Txt_Time:SetText("")
        View.Group_Defeat.Btn_Next.Txt_Time:SetText("")
      end
    end
    delay_ani_time = delay_ani_time - 1
    if DataModel.AniState == true and delay_ani_time <= 0 then
      RefreshAni()
    end
  end,
  ondestroy = function()
    if not DataModel.IsReStart then
      PlayerData.LevelData = {}
    end
    CommonItem:DestroyInstantiate()
    DataModel:CleanEffect()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
