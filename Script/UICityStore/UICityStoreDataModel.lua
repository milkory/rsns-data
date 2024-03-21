local DataModel = {
  CacheEventList = {}
}

function DataModel.FastFoodClick()
  if DataModel.forbidReturn then
    return
  end
  UIManager:Open("UI/HomeKeepFastFood/HomeKeepFastFood", DataModel.StationId)
end

function DataModel.CloseStore()
  if tonumber(DataModel.StationId) ~= 0 then
    local homeCommon = require("Common/HomeCommon")
    local bgSoundId = homeCommon.GetCurShowSceneInfo(DataModel.StationId).bgmId
    local sound = SoundManager:CreateSound(bgSoundId)
    if sound ~= nil then
      sound:Play()
    end
  else
    TrainCameraManager:OpenCamera(0)
    local sessionController = require("UIMapSession/UIMapSessionDataModelController")
    sessionController:ExitToSession(tonumber(PlayerData.BattleInfo.battleStageId))
  end
  local sDataModel = require("UIMainUI/UIMainUIDataModel")
  if MainManager.bgSceneName == sDataModel.SceneNameEnum.Home then
    local HomeController = require("UIHome/UIHomeController")
    local HomeCoachDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
    local HomeCoachController = require("UIHomeCoach/UIHomeCoachController")
    HomeController:RefreshTrains()
    HomeCoachController:InitEnvironment()
    HomeCharacterManager:CreateAll(HomeCoachDataModel.characterData, HomeCoachDataModel.petData)
    HomeCharacterManager:ReShowAll()
  end
end

function DataModel.RefreshKCDCharacter()
  local characterInfoList = {}
  local num = HomeStationStoreManager:GetCustomNum(0)
  local createNum = 0
  if num <= 5 then
    createNum = math.random(4, 7)
  elseif 5 < num and num <= 10 then
    if math.random(0, 10) > 2 then
      createNum = math.random(3, 8)
    end
  elseif 10 < num and num <= 15 then
    if 4 < math.random(0, 10) then
      createNum = math.random(2, 5)
    end
  elseif 15 < num and num <= 20 and math.random(0, 10) > 6 then
    createNum = math.random(1, 5)
  end
  if 0 < createNum then
    local npcRefreshList = PlayerData:GetFactoryData(81500002, "HomeStationPlaceFactory").npcRefreshList
    for i = 1, createNum do
      for i, v in pairs(npcRefreshList) do
        if not characterInfoList[v.id] then
          characterInfoList[v.id] = v
          break
        end
      end
    end
  end
  return characterInfoList
end

function DataModel.SetForbidReturn(isForbid)
  DataModel.forbidReturn = isForbid
end

return DataModel
