local DataModel = require("UISquads/UISquadsDataModel")
local DataController = require("UISquads/UISquadsDataController")
local _BattleStartCallback = function()
  PlayerData.BattleInfo.squadIndex = DataModel.curSquadIndex
  SafeReleaseScene(false)
  CBus:ChangeScene("Battle")
  GameSetting:LoadPlayerSetting()
end
local BattleFinishCallback = function(info, isPrologue)
  local res = Json.decode(info)
  PlayerData.BattleInfo.BattleResult = res
  if isPrologue == true then
    Net:SendProto("battle.end_battle", function(json)
      Train.EventBattleFinish(json)
      CBus:ChangeScene("Main")
    end, PlayerData.BattleInfo.levelUid, 1, Json.encode({
      enemyIds = res.enemy_ids,
      enemy_level_min = res.enemy_level_min,
      enemy_level = res.enemy_level,
      weather_id = res.weather_id,
      second_weather_id = res.second_weather_id,
      bgId = res.bgId
    }), nil, nil, nil, res.cores)
  else
    CommonTips.OpenSettlement()
  end
end
local BattleTestFinishCallback = function()
  if MapNeedleEventData.scene then
    SafeReleaseScene(false)
    CBus:ChangeScene(MapNeedleEventData.scene, function()
      local SortType = {
        pluckList = {},
        isIncr = false
      }
      local data = {
        currentRoleId = DataModel.BattleResultTestID,
        fromView = EnumDefine.CommonFilterType.OtherSort,
        sortType = SortType
      }
      UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
      UIManager:SetHistory("UI/InsZone/InsZone")
    end)
    return
  end
  CBus:ChangeScene("Main", function()
    local SortType = {
      pluckList = {},
      isIncr = false
    }
    local data = {
      currentRoleId = DataModel.BattleResultTestID,
      fromView = EnumDefine.CommonFilterType.OtherSort,
      sortType = SortType
    }
    UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
    local status = {btn = "Member"}
    UIManager:SetHistory("UI/CharacterList/CharacterList", Json.encode(status))
  end)
end
local InitBattle = function(levelId, roleDataList, randomSeed, isBattleTest, battleFinishCallback, enemyLevelMin, difficulty, bgId, enemyLevel, enemyRn, weatherIdList, weatherRateSN, enemyLevelOffset, secondWeatherList, secondWeatherRateSN, secondWeatherCount, enemy_ids, trainWeaponSkill)
  local isLevelFinish = PlayerData.IsLevelFinished(levelId)
  local playerLv = PlayerData:GetUserInfo().lv
  local weatherCount = weatherIdList ~= nil and #weatherIdList or 0
  ReplayManager:InitBattle(levelId, randomSeed, playerLv, isLevelFinish, isBattleTest, 1, enemyLevelMin or 1, difficulty or 1, bgId or -1, enemyLevel or -1, enemyRn or -1, weatherIdList, weatherRateSN or -1 or 0, enemyLevelOffset or 0, secondWeatherList, secondWeatherRateSN or -1, secondWeatherCount or 0, weatherCount or 0, enemy_ids or "", trainWeaponSkill or "")
  for k, v in pairs(roleDataList) do
    if next(v) ~= nil and v.isBlocked ~= true then
      local petProp = PlayerData:GetRolePetProperty(v.unitId)
      local equip1Id = 0 <= tonumber(v.equip1Id) and tonumber(v.equip1Id) or 11800220
      local equip2Id = 0 <= tonumber(v.equip2Id) and tonumber(v.equip2Id) or 11800220
      ReplayManager:AddRole(tonumber(v.unitId), tonumber(v.unitViewId), tonumber(v.skill1Lv), tonumber(v.skill2Lv), tonumber(v.skill3Lv), tonumber(v.lv), tonumber(v.awakeLv), tonumber(v.resonanceLv), tonumber(v.trustLv), tonumber(equip1Id), tonumber(v.equip1Lv), tonumber(v.e1s1Id), math.floor(tonumber(v.e1s1NumSN)), tonumber(v.e1s2Id), math.floor(tonumber(v.e1s2NumSN)), tonumber(v.e1s3Id), math.floor(tonumber(v.e1s3NumSN)), tonumber(v.e1s4Id), math.floor(tonumber(v.e1s4NumSN)), tonumber(12300776), math.floor(tonumber(petProp.atk * SafeMath.safeNumberTime)), tonumber(12300777), math.floor(tonumber(petProp.def) * SafeMath.safeNumberTime), tonumber(equip2Id), tonumber(v.equip2Lv), tonumber(v.e2s1Id), math.floor(tonumber(v.e2s1NumSN)), tonumber(v.e2s2Id), math.floor(tonumber(v.e2s2NumSN)), tonumber(v.e2s3Id), math.floor(tonumber(v.e2s3NumSN)), tonumber(v.e2s4Id), math.floor(tonumber(v.e2s4NumSN)), tonumber(12300771), math.floor(tonumber(petProp.hp * SafeMath.safeNumberTime)), tonumber(v.e2s6Id), math.floor(tonumber(v.e2s6NumSN)), tonumber(v.equip3Id), tonumber(v.equip3Lv), tonumber(v.e3s1Id), math.floor(tonumber(v.e3s1NumSN)), tonumber(v.e3s2Id), math.floor(tonumber(v.e3s2NumSN)), tonumber(v.e3s3Id), math.floor(tonumber(v.e3s3NumSN)), tonumber(v.e3s4Id), math.floor(tonumber(v.e3s4NumSN)), tonumber(v.e3s5Id), math.floor(tonumber(v.e3s5NumSN)), tonumber(v.e3s6Id), math.floor(tonumber(v.e3s6NumSN)), tonumber(v.cardNum1), tonumber(v.cardNum2))
    end
  end
  if battleFinishCallback == nil then
    ReplayManager:RegBattleFinishCallback(BattleFinishCallback)
  else
    ReplayManager:RegBattleFinishCallback(battleFinishCallback)
  end
  _BattleStartCallback()
  local level_difficulty = difficulty or 1
  SdkReporter.TrackBattleStart(levelId, level_difficulty)
end
local module = {
  IsPrologueCleared = function(levelId)
    return PlayerData.ServerData.chapter_level[tostring(levelId)] ~= nil
  end
}

function module:StartBattle(levelId, levelType, roleDataList, squadIndex, levelIndexStr, isBattleTest, eventId, levelKey, battleFinishCallback, failCb, enemyLevelMin, difficulty, bgId, enemyLevel, enemyRn, weatherIdList, weatherRateSN, enemyLevelOffset, secondWeatherList, secondWeatherRateSN, secondWeatherCount, enemy_ids, trainWeaponSkill)
  local callback = function(randomSeed, waveStr)
    if waveStr == nil or waveStr == "" then
      waveStr = enemy_ids
    end
    InitBattle(levelId, roleDataList, randomSeed, isBattleTest, battleFinishCallback, enemyLevelMin, difficulty, bgId, enemyLevel, enemyRn, weatherIdList, weatherRateSN, enemyLevelOffset, secondWeatherList, secondWeatherRateSN, secondWeatherCount, waveStr, trainWeaponSkill)
  end
  PlayerData.BattleInfo.battleStageId = levelId
  PlayerData.BattleInfo.levelType = levelType
  PlayerData.BattleInfo.roleDataList = roleDataList
  PlayerData.BattleInfo.squadIndex = squadIndex - 1
  PlayerData.BattleInfo.levelIndexStr = levelIndexStr
  PlayerData.BattleInfo.isBattleTest = isBattleTest
  PlayerData.BattleInfo.battleFinishCallback = battleFinishCallback
  PlayerData.BattleInfo.isPassed = PlayerData:GetLevelPass(levelId)
  PlayerData.BattleInfo.eventId = eventId
  PlayerData.BattleInfo.levelKey = levelKey
  PlayerData.BattleInfo.enemyLevelMin = enemyLevelMin
  PlayerData.BattleInfo.difficulty = difficulty
  PlayerData.BattleInfo.bgId = bgId
  PlayerData.BattleInfo.enemyLevel = enemyLevel
  PlayerData.BattleInfo.enemyRn = enemyRn
  PlayerData.BattleInfo.weatherIdList = weatherIdList
  PlayerData.BattleInfo.weatherRateSN = weatherRateSN
  PlayerData.BattleInfo.enemyLevelOffset = enemyLevelOffset
  PlayerData.BattleInfo.secondWeatherList = secondWeatherList
  PlayerData.BattleInfo.secondWeatherRateSN = secondWeatherRateSN
  PlayerData.BattleInfo.secondWeatherCount = secondWeatherCount
  PlayerData.BattleInfo.enemy_ids = enemy_ids
  PlayerData.BattleInfo.trainWeaponSkill = trainWeaponSkill
  if failCb == nil then
    function failCb()
    end
  end
  PlayerData.BattleInfo.coreId = nil
  if PlayerData.SquadsTempData then
    PlayerData.BattleInfo.coreId = PlayerData.SquadsTempData.coreId
  end
  Net:SendProto("battle.start_battle", function(json)
    PlayerData.TempCache.GuideNoUpdateLimitData[EnumDefine.GuideNoUpdateLimitDataEnum.LevelId] = levelId
    local levelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
    local loadingPng = ""
    local loadingStr = ""
    if levelCA ~= nil then
      loadingPng = levelCA.loadingPng
      loadingStr = levelCA.loadingTips
    end
    if json.levelUid ~= nil then
      PlayerData.BattleInfo.levelUid = json.levelUid
      local CallBack = function()
        local enemyWaveStr = ""
        if json.waves ~= nil then
          for i = 1, #json.waves do
            if 3 < i then
              break
            end
            if enemyWaveStr ~= "" then
              enemyWaveStr = enemyWaveStr .. ","
            end
            enemyWaveStr = enemyWaveStr .. json.waves[i]
          end
        end
        callback(json.server_now, enemyWaveStr)
      end
      CommonTips.OpenLoading(nil, "", loadingPng, CallBack, loadingStr)
      LoadingManager:SetLoadingPercent(0.75)
    else
      UIManager:GoHome()
      CommonTips.OpenTips(80602114)
    end
    if PlayerData.ServerData.record_level == nil then
      PlayerData.ServerData.record_level = {}
    end
    if levelCA ~= nil then
      PlayerData.ServerData.record_level[levelCA.mod] = levelId
    end
    PlayerData.LevelData = levelCA
  end, levelId, eventId, squadIndex - 1, levelType, levelIndexStr, eventId and 1 or 0, DataModel.InitParams and DataModel.InitParams.EventIndex or nil, DataModel.InitParams and DataModel.InitParams.Sid or nil, levelKey, failCb, difficulty or 1, DataModel.InitParams and DataModel.InitParams.NextDistance or nil, DataModel.InitParams and DataModel.InitParams.areaId or nil, PlayerData.BattleInfo.coreId)
end

function module:AgainBattle(isOpenPrompt, noCallBack, yesCb)
  local yesCallBack = function()
    if yesCb ~= nil then
      yesCb()
    end
    module:StartBattle(PlayerData.BattleInfo.battleStageId, PlayerData.BattleInfo.levelType, PlayerData.BattleInfo.roleDataList, PlayerData.BattleInfo.squadIndex, PlayerData.BattleInfo.levelIndexStr, PlayerData.BattleInfo.isBattleTest, PlayerData.BattleInfo.eventId, PlayerData.BattleInfo.levelKey, PlayerData.BattleInfo.battleFinishCallback, noCallBack, PlayerData.BattleInfo.enemyLevelMin, PlayerData.BattleInfo.difficulty, PlayerData.BattleInfo.bgId, PlayerData.BattleInfo.enemyLevel, PlayerData.BattleInfo.enemyRn, PlayerData.BattleInfo.weatherIdList, PlayerData.BattleInfo.weatherRateSN, PlayerData.BattleInfo.enemyLevelOffset, PlayerData.BattleInfo.secondWeatherList, PlayerData.BattleInfo.secondWeatherRateSN, PlayerData.BattleInfo.secondWeatherCount, PlayerData.BattleInfo.enemy_ids, PlayerData.BattleInfo.trainWeaponSkill)
  end
  if isOpenPrompt == true then
    CommonTips.OnPrompt(80600280, nil, nil, yesCallBack, noCallBack)
  else
    yesCallBack()
  end
end

function module:NextLevelBattle(isOpenPrompt, noCallBack)
  local yesCallBack = function()
    local levelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId, "LevelFactory")
    if levelCA.nextLevel ~= nil and levelCA.nextLevel > 0 then
      local levelId = levelCA.nextLevel
      module:StartBattle(levelId, PlayerData.BattleInfo.levelType, PlayerData.BattleInfo.roleDataList, PlayerData.BattleInfo.squadIndex, nil, true, nil, PlayerData.BattleInfo.battleFinishCallback, noCallBack)
    else
      noCallBack()
    end
  end
  if isOpenPrompt == true then
    CommonTips.OnPrompt(80600279, nil, nil, yesCallBack, noCallBack)
  else
    yesCallBack()
  end
end

function module:StartBattleTest(levelId, roleDataList)
  DataModel.BattleResultTestID = {}
  local callback = function()
    DataModel.BattleResultTestID = roleDataList[1].unitId
    PlayerData.SetIsTest(true)
    InitBattle(levelId, roleDataList, CBus.currentFrame, true, BattleTestFinishCallback)
  end
  PlayerData.BattleInfo.battleStageId = levelId
  CommonTips.OpenLoading(nil, nil, nil, callback)
end

return module
