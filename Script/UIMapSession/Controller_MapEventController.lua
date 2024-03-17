local View = require("UIDialog/UIDialogView")
local DataModel = require("UIMapSession/UIMapSessionDataModel")
local MapEventBase = require("UIMapSession/Model_MapEventBase")
local classModName = {}
local continue = false
local classMod, allMod, isFinish, CA
local isInited = false
local classModAction
local End = function()
  if allMod == nil then
    print_r("段落配置错误,需要策划解决!!!\n段落勾选了不返回上个界面,会卡在最后一段剧情\n\n解决方式:\n方式1.勾选段落-返回上个界面,方式\n2.引导工厂+引导+引导命令工厂")
    return
  end
  continue = false
  isFinish = true
  classMod = nil
  allMod = {}
end
local controller = {
  Init = function(ca)
    allMod = {}
    classMod = nil
    continue = false
    isFinish = true
    isInited = true
  end,
  OnEnd = function()
    End()
  end,
  Update = function()
    if classModAction ~= nil then
      classModAction()
      classModAction = nil
      return
    end
    if isFinish == true or classMod == nil then
      return
    end
    classMod:OnUpdate()
  end
}

function controller.InitEvent(obj, id, args)
  if isInited ~= true then
    controller.Init()
  end
  local rt = MapSessionManager:SessionOnInit()
  isFinish = false
  return rt ~= "break"
end

function controller.GetClassMod()
  return classMod
end

function controller.RecycleCurrent()
  if classMod ~= nil then
    classMod:Dtor()
    classMod = nil
    CA = nil
    isFinish = true
    continue = false
  end
end

function controller.IsFinish()
  return isFinish
end

function controller.SetFlag(sid, id)
  Net:SendProto("adventure.set_flag", function(json)
    MapSessionManager:ProtocolCallback(sid, "adventure.set_flag", Json.encode(json.map_event))
  end, id)
end

function controller.GetGroup(sid, groupId)
  Net:SendProto("adventure.get_group", function(json)
    MapSessionManager:ProtocolCallback(sid, "adventure.get_group", Json.encode(json.map_event[groupId]))
  end, groupId)
end

function controller.EventReceiveQuest(questId)
  if questId == nil then
    return
  end
  Net:SendProto("quest.accept", function()
    local quests = PlayerData.ServerData.quests
  end, tostring(questId))
end

function controller.EventChangeScene(sceneName, uiPath, param)
  if not sceneName then
    return
  end
  CoroutineManager:Reg("needleClick", LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
    CommonTips.OpenLoadingCB(function()
      UIManager:Pause(false)
      if sceneName == "Battle" then
        SafeReleaseScene(false)
      end
      CBus:ChangeScene(sceneName, function()
        if uiPath then
          local initParam = {}
          if uiPath == "UI/InsZone/InsZone" then
            MapNeedleEventData.openInsZone = true
            MapNeedleEventData.scene = sceneName
            PlayerData.BattleCallBackPage = "UI/InsZone/InsZone"
            PlayerData.Last_Chapter_Parms = nil
            initParam = {chapterId = param}
          end
          UIManager:Open(uiPath, Json.encode(initParam))
        end
      end)
    end)
    CoroutineManager:UnReg("needleClick")
  end))
end

function controller.OpenStore(id)
  local stationPlace = PlayerData:GetFactoryData(id, "HomeStationPlaceFactory")
  HomeStationStoreManager:Create(stationPlace.resId, stationPlace.id)
  local coachCA = PlayerData:GetFactoryData(stationPlace.resId, "HomeCoachFactory")
  HomeStationStoreManager:Load(coachCA.defaultTemplate)
  for i, v in pairs(stationPlace.npcList) do
    HomeStationStoreManager:CreateCustom(v.id, 0, v.isRandom, v.npcX, v.npcZ, v.tree)
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local conductor = PlayerData:GetUserInfo().gender == 1 and homeConfig.conductorM or homeConfig.conductorW
  local offsetX = math.random(0, 10) >= 5 and 2 or 28
  local offsetZ = math.random(7, 10)
  HomeStationStoreManager:CreateCustom(conductor, 0, true, offsetX, offsetZ, "PassengerKCD:move")
  local c = PlayerData:GetFactoryData(stationPlace.serverId, "HomeCharacterFactory")
  HomeStationStoreManager:CreateSpeicalCharacter(stationPlace.serverId, 0, 0, c.interactiveIconPath)
  UIManager:Open("UI/CityStore/CityStore", Json.encode({
    StationId = tostring(0),
    PlaceId = tostring(id)
  }))
  local sound = SoundManager:CreateSound(stationPlace.bgm)
  if sound ~= nil then
    sound:Play()
  end
end

return controller
