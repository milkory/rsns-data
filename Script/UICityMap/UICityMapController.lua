local View = require("UICityMap/UICityMapView")
local DataModel = require("UICityMap/UICityMapDataModel")
local HomeCommon = require("Common/HomeCommon")
local Controller = {}
local OpenCityMapDo = function(info)
  DataModel.cityMapId = info.metaId
  Controller:Init()
  View.self:PlayAnim("In")
end
local guideDo = function(info)
  GuideManager:ExecuteClientOnlyGuide(info.metaId)
end
local CheckInvestLock = function(isShowTip)
  if isShowTip == nil then
    isShowTip = true
  end
  local stationId = DataModel.stationId
  local stationCA = PlayerData:GetFactoryData(stationId)
  if stationCA.attachedToCity > 0 then
    stationId = stationCA.attachedToCity
    stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  end
  local serverStation = PlayerData:GetHomeInfo().stations[tostring(stationId)]
  local curLv = serverStation.rep_lv or 0
  if curLv < stationCA.cityPrestige then
    if isShowTip then
      CommonTips.OpenTips(string.format(GetText(80600685), stationCA.cityPrestige))
    end
    return true
  end
  return false
end
local InitShowConstruct = function(stationCA)
  DataModel.ConstructMaxNum = 0
  DataModel.ConstructNowNum = 0
  DataModel.ConstructNowCA = {}
  local StationList = PlayerData:GetHomeInfo().stations[tostring(DataModel.stationId)]
  DataModel.StationState = StationList.state
  for k, v in pairs(StationList.construction) do
    DataModel.ConstructNowNum = DataModel.ConstructNowNum + v.proportion
  end
  local construction_count = 0
  for i = 1, #stationCA.constructStageList do
    local row = stationCA.constructStageList[i]
    DataModel.ConstructMaxNum = DataModel.ConstructMaxNum + row.constructNum
    DataModel.ConstructNowCA = row
    construction_count = i
    if row.state and row.state ~= -1 and DataModel.ConstructNowNum >= DataModel.ConstructMaxNum and DataModel.StationState < row.state then
      DataModel.StationState = row.state
      PlayerData:GetHomeInfo().stations[tostring(DataModel.stationId)].state = row.state
    end
    if DataModel.ConstructNowNum <= DataModel.ConstructMaxNum then
      break
    end
  end
  DataModel.Index_Construct = construction_count
  local row_server = StationList.construction[construction_count]
  local Group_Construct = View.Group_Construct
  Group_Construct.Txt_Num:SetText(row_server.proportion .. "/" .. DataModel.ConstructNowCA.constructNum)
  Group_Construct.Txt_Dec:SetText(DataModel.ConstructNowCA.name)
  Group_Construct.Img_PB:SetFilledImgAmount(row_server.proportion / DataModel.ConstructNowCA.constructNum)
  Group_Construct.Btn_Construct:SetSprite(stationCA.constructIconPath)
  Group_Construct.Img_RedPoint:SetActive(false)
  local stageRewardList = PlayerData:GetFactoryData(DataModel.ConstructNowCA.id).stageRewardList
  local count = 0
  for k, v in pairs(stageRewardList) do
    if v.construct <= DataModel.ConstructNowNum and row_server.rec_index[k] == nil then
      count = count + 1
    end
  end
  if count ~= 0 then
    Group_Construct.Img_RedPoint:SetActive(true)
  end
end
local RefreshMissIonRed = function()
  View.Group_TopRight.Btn_Mission.Img_Remind:SetActive(false)
  local row = PlayerData:GetBattlePassRedState()
  local count_1 = row.count_1
  local count_2 = row.count_2
  local count_3 = row.count_3
  if count_1 == true or count_2 == true or count_3 == true then
    View.Group_TopRight.Btn_Mission.Img_Remind:SetActive(true)
  end
end

function Controller:Init()
  local stationCA = PlayerData:GetFactoryData(DataModel.stationId, "HomeStationFactory")
  local curStationDevData = PlayerData:GetHomeInfo().dev_degree[tostring(DataModel.stationId)]
  local cityMapId = DataModel.GetCurCityMapId()
  local listCA = PlayerData:GetFactoryData(cityMapId, "ListFactory")
  View.ScrollView_Map.Viewport.Group_BG.self:SetAnchoredPosition(Vector2(listCA.offsetX, listCA.offsetY))
  View.Group_City.Txt_Name:SetText(stationCA.name)
  View.Group_City.Txt_NameEN:SetText(stationCA.nameEN)
  View.Group_City.Img_City:SetSprite(stationCA.cityMapIconPath)
  local forceName = ""
  if listCA.isShowRep and stationCA.force > 0 then
    local tagCA = PlayerData:GetFactoryData(stationCA.force, "TagFactory")
    forceName = string.format(GetText(80601533), tagCA.tagName)
  end
  View.Group_City.Txt_Force:SetText(forceName)
  Controller:SetBgInfo(listCA.bgList)
  local count = View.ScrollView_Map.Viewport.Group_BG.transform.childCount
  local npcCount = #listCA.cityNPCList
  DataModel.showCount = npcCount
  View.Group_Construct.self:SetActive(listCA.isShowConstruct)
  if listCA.isShowConstruct then
    InitShowConstruct(stationCA)
  end
  for i = 1, count do
    local element = View.ScrollView_Map.Viewport.Group_BG["Group_Build" .. i]
    if element ~= nil then
      local checkShow = true
      local info = listCA.cityNPCList[i]
      if info ~= nil then
        local isOnlyHave = info.isOnlyHave
        if isOnlyHave == nil then
          isOnlyHave = true
        end
        if 0 < info.questId and isOnlyHave then
          checkShow = checkShow and QuestProcess.CheckQuestTime(info.questId)
          checkShow = checkShow and QuestProcess.CheckQuestPreQuestComplete(info.questId)
        else
          checkShow = checkShow and QuestProcess.CheckTime(info.activityId, info.startTime, info.endTime)
        end
        if checkShow then
          element.self:SetAnchoredPosition(Vector2(info.x, info.y))
          local curDegree = curStationDevData.dev_degree or 0
          checkShow = checkShow and curDegree >= info.dev
          if 0 < info.questId then
            if isOnlyHave then
              checkShow = checkShow and PlayerData:IsHaveQuest(info.questId)
            else
              checkShow = checkShow and PlayerData.IsQuestComplete(info.questId)
            end
          end
          if checkShow then
            local checkShowSpecial = info.func ~= "" and 0 < info.dialogId
            checkShowSpecial = checkShowSpecial and PlayerData:GetPlayerPrefs("int", "Dialog" .. info.dialogId) == 0
            if info.isSpecial == false then
              element.Btn_Build.self:SetActive(true)
              element.Btn_Special.self:SetActive(false)
              element.Btn_Build.Group_Anim.Img_BuildMask:SetActive(not info.isInstance)
              element.Btn_Build.Group_Anim.Img_InstanceMask:SetActive(info.isInstance)
              element.Btn_Build.Group_Anim.Img_Mask.Img_Icon:SetSprite(info.iconPath)
              element.Btn_Build.Group_Anim.Group_Name.Txt_Name:SetText(info.name)
              element.Btn_Build.Group_Anim.Group_Name.Img_Icon:SetSprite(info.nameIconPath)
              element.Btn_Build.Group_Anim.Group_Effect.self:SetActive(not info.isLock)
              if not info.isLock then
                if info.isInstance then
                  element.Btn_Build.Group_Anim.Group_Effect.Group_Instance:SetDynamicGameObject(info.effectPath, 0, 0)
                else
                  element.Btn_Build.Group_Anim.Group_Effect.Group_Build:SetDynamicGameObject(info.effectPath, 0, 0)
                end
              end
              element.Btn_Build.self:SetClickParam(i)
              local isShowRed = false
              if info.btnType == "HomeSafe" or info.btnType == "RubbishStation" then
                isShowRed = RedPointNodeStr.IsHaveRed(info.btnType)
              end
              element.Btn_Build.Group_Anim.Img_RedPoint:SetActive(isShowRed)
              local curLock = false
              if info.btnType == "HomeInvest" then
                curLock = CheckInvestLock(false)
              end
              element.Btn_Build.Group_Anim.Img_Lock.self:SetActive(info.isLock or curLock)
            else
              element.Btn_Build.self:SetActive(false)
              element.Btn_Special.self:SetActive(true)
              element.Btn_Special.Group_Anim.Img_Special:SetSprite(info.iconPath)
              element.Btn_Special.Group_Anim.Group_Name.Txt_Name:SetText(info.name)
              element.Btn_Special.Group_Anim.Group_Name.Img_Icon:SetSprite(info.nameIconPath)
              element.Btn_Special.self:SetClickParam(i)
              element.Btn_Special.Group_Anim.Img_Tip:SetActive(checkShowSpecial)
            end
          end
        end
      end
      element.self:SetActive(checkShow and i <= npcCount)
    end
  end
  View.Group_Reputation.self:SetActive(listCA.isShowRep)
  if HomeCommon.GetCurLvRepData(DataModel.stationId) ~= nil then
    HomeCommon.SetReputationElement(View.Group_Reputation, DataModel.stationId)
  end
  RefreshMissIonRed()
  QuestTrace.SetQuestTrace(View.Group_Navigation)
end

function Controller:ClickBtn(idx)
  local cityMapId = DataModel.GetCurCityMapId()
  local listCA = PlayerData:GetFactoryData(cityMapId, "ListFactory")
  local info = listCA.cityNPCList[idx]
  local detailDo
  local isPlayOut = true
  if info ~= nil then
    local checkTime = true
    if info.questId > 0 then
      checkTime = QuestProcess.CheckQuestTime(info.questId)
    else
      checkTime = QuestProcess.CheckTime(info.activityId, info.startTime, info.endTime)
    end
    if not checkTime then
      CommonTips.OpenTips(80602659)
      return
    end
    if info.func == "OpenUI" then
      local isReturn = false
      if info.btnType == "HomeInvest" then
        isReturn = CheckInvestLock(true)
      end
      if info.uiPath == "UI/InsZone/StoryTips" or info.uiPath == "UI/Guidance/Guidance_Tips" then
        isPlayOut = false
      end
      if not isReturn then
        function detailDo()
          local t = {}
          
          t.stationId = DataModel.stationId
          t.buildingId = info.buildingId
          t.npcId = info.npcId
          t.bgPath = info.bgPath
          t.bgColor = info.bgColor
          t.isCityMapIn = true
          t.name = info.name
          t.textId = info.textId
          UIManager:Open(info.uiPath, Json.encode(t))
        end
      end
    elseif info.func == "OpenScene" then
      function detailDo()
        local stationPlace = PlayerData:GetFactoryData(info.stationPlace, "HomeStationPlaceFactory")
        
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
          StationId = tostring(DataModel.stationId),
          PlaceId = tostring(info.stationPlace)
        }))
        local sound = SoundManager:CreateSound(stationPlace.bgm)
        if sound ~= nil then
          sound:Play()
        end
      end
    elseif info.func == "OpenDialog" then
      isPlayOut = false
      
      function detailDo()
        UIManager:Open(UIPath.UIDialog, Json.encode({
          id = info.dialogId
        }))
      end
    elseif info.func == "OpenDungeon" then
      function detailDo()
        local status = {}
        
        status.chapterId = info.dungeonId
        status.startNew = true
        status.GoBackUI = "UI/CityMap/CityMap"
        local t = {}
        t.stationId = DataModel.stationId
        t.cityMapId = DataModel.cityMapId
        status.GoBackUIParam = Json.encode(t)
        PlayerData.Last_Chapter_Parms = status
        PlayerData.BattleCallBackPage = "UI/InsZone/InsZone"
        UIManager:Open("UI/InsZone/InsZone", Json.encode(status))
      end
    elseif info.func == "Tips" then
      isPlayOut = false
      
      function detailDo()
        CommonTips.OpenTips(info.textId)
      end
    elseif info.func == "OpenLevel" then
      function detailDo()
        local levelId = info.levelId
        
        local status = {
          Current = "Chapter",
          squadIndex = PlayerData.BattleInfo.squadIndex,
          hasOpenThreeView = false
        }
        local t = {}
        t.stationId = DataModel.stationId
        t.cityMapId = DataModel.cityMapId
        status.extraUIParamData = t
        PlayerData.BattleInfo.battleStageId = levelId
        PlayerData.BattleCallBackPage = "UI/CityMap/CityMap"
        UIManager:Open("UI/Squads/Squads", Json.encode(status))
      end
    elseif info.func == "OpenBuilding" then
      function detailDo()
        local buildingCA = PlayerData:GetFactoryData(info.buildingId, "BuildingFactory")
        
        UIManager:Open(buildingCA.uiPath, Json.encode({
          buildingId = info.buildingId,
          isCityMapIn = true,
          name = info.name
        }))
        PlayerData:TryPlayPlotByParagraphID(buildingCA.firstPlotId)
      end
    elseif info.func == "OpenCityMap" then
      detailDo = OpenCityMapDo
    elseif info.func == "Guide" then
      isPlayOut = false
      detailDo = guideDo
    end
  end
  if detailDo then
    local element = View.ScrollView_Map.Viewport.Group_BG["Group_Build" .. idx]
    if isPlayOut then
      element.self:SelectPlayAnim("PressDown")
    else
      element.self:SelectPlayAnim("PressDown2")
    end
    if isPlayOut then
      View.self:PlayAnim("Out", function()
        detailDo(info)
      end)
    else
      detailDo(info)
    end
  end
end

function Controller:SetBgInfo(bgList)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local scaleOneDaySecond = 86400 / homeConfig.dayScale
  local scaleTimeToday = (TimeUtil:GetServerTimeStamp() + PlayerData.TimeZone * 3600) % scaleOneDaySecond
  local todayZeroTimeStamp = scaleTimeToday / scaleOneDaySecond * 86400
  local idx = 1
  for k, v in pairs(bgList) do
    local h = tonumber(string.sub(v.changeTime, 1, 2))
    local m = tonumber(string.sub(v.changeTime, 4, 5))
    local s = tonumber(string.sub(v.changeTime, 7, 8))
    local time = h * 3600 + m * 60 + s
    if todayZeroTimeStamp < time then
      idx = k
      break
    end
  end
  idx = idx - 1
  if idx <= 0 then
    idx = #bgList
  end
  local detailInfo = bgList[idx]
  View.ScrollView_Map.Img_BG:SetSprite(detailInfo.bgPath)
  View.ScrollView_Map.Viewport.Group_BG.Group_Effect:HideDynamicGameObject()
  if 0 < detailInfo.effectListId then
    local listCA = PlayerData:GetFactoryData(detailInfo.effectListId, "ListFactory")
    if 0 < #listCA.effectList then
      local effectPath
      local weight = 0
      for k, v in pairs(listCA.effectList) do
        weight = weight + v.weight
      end
      local randomNum = math.random(1, weight)
      for k, v in pairs(listCA.effectList) do
        randomNum = randomNum - v.weight
        if randomNum <= 0 then
          effectPath = v.effectPath
          break
        end
      end
      if effectPath then
        View.ScrollView_Map.Viewport.Group_BG.Group_Effect:SetDynamicGameObject(effectPath, 0, 0)
      end
    end
  end
end

function Controller:FuncActive()
  local funcTable = {}
  funcTable[100] = function(active)
    View.Group_TopRight.Btn_Mission.self:SetActive(active)
    if active then
      local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
      local battlePass = PlayerData:GetFactoryData(initConfig.BattlePassId, "BattlePassFactory")
      View.Group_TopRight.Btn_Mission.self:SetActive(TimeUtil:IsActive(battlePass.PassStartTime, battlePass.PassEndTime))
    end
  end
  funcTable[101] = function(active)
    View.Group_TopRight.Btn_Store.self:SetActive(active)
  end
  funcTable[102] = function(active)
    View.Group_TopRight.Btn_Headhunt.self:SetActive(active)
  end
  funcTable[103] = function(active)
    View.Group_TopRight.Btn_Depot.self:SetActive(active)
  end
  funcTable[104] = function(active)
    View.Group_TopRight.Btn_Member.self:SetActive(active)
    View.Group_TopRight.Btn_Member.Img_Remind.self:SetActive(PlayerData.isAwakeRed)
  end
  funcTable[105] = function(active)
    View.Group_TopRight.Btn_Squads.self:SetActive(active)
  end
  funcTable[118] = function(active)
    View.Group_TopRight.Btn_Activity:SetActive(false)
  end
  funcTable[120] = function(active)
    View.Group_TopRight.Btn_ActivityNew:SetActive(true)
    local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
    View.Group_TopRight.Btn_ActivityNew.Img_Remind:SetActive(ActivityMainDataModel.GetMainAllRedState())
  end
  local funcViewShow = function(activeTable)
    for k, v in pairs(funcTable) do
      v(activeTable[k] ~= nil)
    end
  end
  local funcCommon = require("Common/FuncCommon")
  funcCommon.CheckActiveFunc(funcViewShow)
end

function Controller:PlayBgm()
  local bgm = SoundManager:GetBgmSource()
  if bgm.name == "Empty" then
    local info = HomeCommon.GetCurShowSceneInfo(DataModel.stationId)
    local sound = SoundManager:CreateSound(info.bgmId)
    if sound ~= nil then
      sound:Play()
    end
  end
end

function Controller:ClickReturn()
  if DataModel.cityMapId and DataModel.cityMapId > 0 then
    local ca = PlayerData:GetFactoryData(DataModel.cityMapId)
    local exitId = ca.exitId
    if 0 < exitId then
      local factoryName = DataManager:GetFactoryNameById(exitId)
      if factoryName == "HomeStationFactory" then
        DataModel.cityMapId = 0
      else
        DataModel.cityMapId = exitId
      end
      View.self:PlayAnim("Out", function()
        Controller:Init()
        View.self:PlayAnim("In")
      end)
      return
    end
  end
  UIManager:GoHome()
end

return Controller
