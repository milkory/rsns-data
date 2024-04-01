local View = require("UIMainUI/UIMainUIView")
local DataModel = require("UIMainUI/UIMainUIDataModel")
local RenderSettingController = require("UIMainUI/UIMainUIRenderSettingController")
local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
local MapDataModel = require("UIHome/UIHomeMapDataModel")
local MapController = require("UIHome/UIHomeMapController")
local TradeController = require("UIHome/UIHomeTradeController")
local Controller = {isInitEffect = false}
local isHide = false

function Controller:Init()
  isHide = true
  CommonFilter.RefreshHome()
end

local HandleHeadRedDot = function()
  local funcCommon = require("Common/FuncCommon")
  local isUnlock = funcCommon.FuncActiveCheck(117, false)
  if isUnlock then
    local count, state = PlayerData:GetUnreadMailNum()
    if state then
      return true
    end
  end
  if RedpointTree:GetRedpointCnt(RedpointTree.NodeNames.AchievementUI) > 0 then
    return true
  end
  local now_lv = PlayerData:GetPlayerLevel()
  local lv_cfg = PlayerData:GetFactoryData(99900051).Playerranklist
  local nowIndex = 1
  for i, v in ipairs(lv_cfg) do
    if now_lv >= v.level then
      nowIndex = i
    end
  end
  local can_recv_cnt = nowIndex - #(PlayerData:GetHomeInfo().rank_reward or {})
  if 0 < can_recv_cnt then
    return true
  end
  return false
end

function Controller:PlayBGM()
  local lineInfo = {}
  local isTravel, configId = MapDataModel.GetTrainCurPos(lineInfo)
  local bgSoundId = 0
  if DataManager:GetFactoryNameById(configId) == "HomeStationFactory" then
    bgSoundId = DataModel.CurShowSceneInfo.bgmId
  else
    local lineCA = PlayerData:GetFactoryData(configId)
    if lineInfo.lastStationId == lineCA.station02 and lineCA.bgmId2 > -1 then
      bgSoundId = lineCA.bgmId2
    else
      bgSoundId = lineCA.bgmId
    end
  end
  if DataModel.TrainEventBgmId ~= nil then
    bgSoundId = DataModel.TrainEventBgmId
  end
  DataModel.nowSoundId = bgSoundId
  local sound = SoundManager:CreateSound(bgSoundId)
  if sound ~= nil then
    sound:Play()
  end
end

function Controller:InitCommonShow()
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  local user_info = PlayerData:GetUserInfo()
  View.Group_Common.Group_TopLeft.Btn_Gold.Txt_Num:SetText(user_info.gold)
  View.Group_Common.Group_TopLeft.Txt_Name:SetText(user_info.role_name or "")
  View.Group_Common.Group_TopLeft.Txt_UID:SetText(string.format(GetText(80600575), user_info.uid))
  View.Group_Common.Group_TopLeft.Group_LV.Txt_Num:SetText(user_info.lv or 1)
  local endExp = PlayerData:GetMaxExp()
  View.Group_Common.Group_TopLeft.Img_EXPPB:SetFilledImgAmount(user_info.exp / endExp)
  local show_red = HandleHeadRedDot()
  View.Group_Common.Group_TopLeft.Img_Remind:SetActive(show_red)
  if user_info.avatar ~= nil then
    local photoFactory = PlayerData:GetFactoryData(user_info.avatar, "ProfilePhotoFactory")
    if photoFactory ~= nil then
      View.Group_Common.Group_TopLeft.Btn_ProfilePhoto.Img_Client:SetSprite(photoFactory.imagePath)
      return
    end
  end
  local head = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  if head ~= nil and head.playerHeadList ~= nil then
    View.Group_Common.Group_TopLeft.Btn_ProfilePhoto.Img_Client:SetSprite(head.playerHeadList[user_info.gender + 1].playerHeadPath)
  end
end

function Controller:ShowEnterCityAbout(isShow)
  View.Btn_City.self:SetActive(false)
  View.Btn_Dungeon.self:SetActive(false)
  if isShow then
    local stationCA = PlayerData:GetFactoryData(TradeDataModel.EndCity, "HomeStationFactory")
    View.Btn_City.Txt_CityName:SetText(stationCA.name)
    View.Btn_Dungeon.Txt_CityName:SetText(stationCA.name)
    local HomeCommon = require("Common/HomeCommon")
    local stateInfo = HomeCommon.GetCityStateInfo(TradeDataModel.EndCity)
    if stateInfo ~= nil then
      View.Btn_City.Txt_Name:SetText(stateInfo.name)
      View.Btn_City.self:SetActive(stateInfo.cityMapId > 0)
      View.Btn_Dungeon.self:SetActive(0 < stateInfo.dungeonId)
    end
  end
end

function Controller:SwitchTab(type, calcPosterGirl)
  PlayerData.TempCache.MainUIShowState = type
  Controller:ShowOutSide(false)
  Controller:ShowCoach(false)
  Controller:ShowAdjutant(false)
  local isTravel = PlayerData:GetHomeInfo().station_info.stop_info[2] ~= -1
  View.Btn_Launch.self:SetActive(not isTravel)
  Controller:ShowEnterCityAbout(not isTravel)
  View.Group_Common.self:SetActive(true)
  View.Group_OutSide.Group_Station.Btn_HandleG.Img_Lock:SetActive(not PlayerData.IsSolicitFunOpen())
  if type ~= PlayerData.TempCache.MainUIShowState and type ~= DataModel.UIShowEnum.OutSide and UIManager:IsPanelOpened("UI/Attraction/Attractions") then
    UIManager:ClosePanel(true, "UI/Attraction/Attractions")
  end
  if type == DataModel.UIShowEnum.OutSide then
    Controller:ShowOutSide()
    local ishow = PlayerData.showPosterGirl == 1
    if DataModel.IsEvent or PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
      ishow = true
    end
    Controller:ShowPosterGirl(ishow)
    Controller:ReopenAttractions()
  elseif type == DataModel.UIShowEnum.Coach then
    Controller:ShowCoach()
    local ishow = false
    if DataModel.IsEvent or PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
      ishow = true
    end
    Controller:ShowPosterGirl(ishow)
  elseif type == DataModel.UIShowEnum.Adjutant then
    Controller:ShowAdjutant()
    Controller:ShowPosterGirl(true, true)
  elseif type == DataModel.UIShowEnum.Passenger then
    View.Btn_Launch:SetActive(false)
    View.Btn_City:SetActive(false)
    View.Img_Dashboard:SetActive(false)
    View.Group_OutSide:SetActive(false)
    View.Group_Common:SetActive(false)
    View.Img_RT:SetActive(true)
    Controller:ShowPosterGirl(false)
  end
end

function Controller:ShowOutSide(isShow)
  if isShow == nil then
    isShow = true
  end
  View.Group_OutSide.self:SetActive(isShow)
  View.Group_Common.Group_MB.BtnPolygon_OutSide:SetActive(not isShow)
  local isTravel = PlayerData:GetHomeInfo().station_info.stop_info[2] ~= -1
  View.Group_OutSide.Group_Station.self:SetActive(isShow and not isTravel)
  View.Group_OutSide.Group_Running.self:SetActive(isShow and isTravel)
  if isShow then
    View.Group_Common.Group_MB.BtnPolygon_Adjutant:SetActive(true)
    View.Group_Common.Group_MB.BtnPolygon_Coach:SetActive(true)
    local x = View.Group_Common.Group_MB.BtnPolygon_Coach:GetAnchoredPositionX()
    if x < 0 then
      x = -x
      View.Group_Common.Group_MB.BtnPolygon_Coach:SetAnchoredPositionX(x)
    end
    View.Group_Common.Group_MB.BtnPolygon_Coach.Txt_Left:SetActive(false)
    View.Group_Common.Group_MB.BtnPolygon_Coach.Txt_Right:SetActive(true)
    local isInCoach = DataModel.CurSceneName == DataModel.SceneNameEnum.Home or not TradeDataModel.GetInTravel()
    Controller:ShowMBDurability(isInCoach)
    Controller:ShowMBSpeed(not isInCoach)
    Controller.ShowStrikeTip(false, false)
  end
end

function Controller:ShowCoach(isShow)
  if isShow == nil then
    isShow = true
  end
  View.Group_Coach.self:SetActive(isShow)
  View.Group_Common.Group_MB.BtnPolygon_Coach:SetActive(not isShow)
  if isShow then
    local isTravel = TradeDataModel.GetIsTravel()
    View.Group_OutSide.Group_Station.self:SetActive(isTravel)
    View.Group_Common.Group_MB.BtnPolygon_Adjutant:SetActive(true)
    View.Group_Common.Group_MB.BtnPolygon_OutSide:SetActive(true)
    local x = View.Group_Common.Group_MB.BtnPolygon_OutSide:GetAnchoredPositionX()
    if x < 0 then
      x = -x
      View.Group_Common.Group_MB.BtnPolygon_OutSide:SetAnchoredPositionX(x)
    end
    View.Group_Common.Group_MB.BtnPolygon_OutSide.Txt_Left:SetActive(false)
    View.Group_Common.Group_MB.BtnPolygon_OutSide.Txt_Right:SetActive(true)
    Controller:ShowMBDurability(true)
    Controller.ShowStrikeTip(false, false)
  end
end

function Controller:ShowAdjutant(isShow)
  if isShow == nil then
    isShow = true
  end
  View.Img_RT:SetActive(isShow)
  View.Group_Adjutant.self:SetActive(isShow)
  View.Group_Common.Group_MB.BtnPolygon_Adjutant:SetActive(not isShow)
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local scaleOneDaySecond = 86400 / homeConfig.dayScale
  local scaleTimeToday = (TimeUtil:GetServerTimeStamp() + PlayerData.TimeZone * 3600) % scaleOneDaySecond
  local mainUIConfig = PlayerData:GetFactoryData(99900034, "ConfigFactory")
  local todayZeroTimeStamp = scaleTimeToday / scaleOneDaySecond * 86400
  local idx = 0
  for k, v in pairs(mainUIConfig.bgList) do
    local h = tonumber(string.sub(v.changeTime, 1, 2))
    local m = tonumber(string.sub(v.changeTime, 4, 5))
    local s = tonumber(string.sub(v.changeTime, 7, 8))
    local checkTimeStamp = h * 3600 + m * 60 + s
    if todayZeroTimeStamp < checkTimeStamp then
      idx = k
      break
    end
  end
  idx = idx - 1
  if idx <= 0 then
    idx = #mainUIConfig.bgList
  end
  View.Group_Adjutant.Img_BG:SetSprite(isShow and mainUIConfig.bgList[idx].bgPath or "")
  self.SetSpeedAddShow()
  if isShow then
    Controller:ShowMBSpeed(false)
    Controller:ShowMBDurability(true)
    Controller.ShowStrikeTip(false, false)
    View.Group_Adjutant.Img_BG:SetActive(true)
    local isInCoach = DataModel.CurSceneName == DataModel.SceneNameEnum.Home
    View.Group_Common.Group_MB.BtnPolygon_Coach:SetActive(true)
    View.Group_Common.Group_MB.BtnPolygon_OutSide:SetActive(true)
    local element1, element2
    if isInCoach then
      element1 = View.Group_Common.Group_MB.BtnPolygon_OutSide
      element2 = View.Group_Common.Group_MB.BtnPolygon_Coach
    else
      element1 = View.Group_Common.Group_MB.BtnPolygon_Coach
      element2 = View.Group_Common.Group_MB.BtnPolygon_OutSide
    end
    local x = element1:GetAnchoredPositionX()
    if x < 0 then
      x = -x
      element1:SetAnchoredPositionX(x)
    end
    element1.Txt_Left:SetActive(false)
    element1.Txt_Right:SetActive(true)
    x = element2:GetAnchoredPositionX()
    if 0 < x then
      x = -x
      element2:SetAnchoredPositionX(x)
    end
    element2.Txt_Left:SetActive(true)
    element2.Txt_Right:SetActive(false)
  end
end

function Controller:ShowMBSpeed(isShow)
  if isShow == nil then
    isShow = true
  end
  View.Group_Common.Group_MB.Img_Speed:SetActive(isShow)
  View.Img_Dashboard:SetActive(not isShow)
end

function Controller:ShowMBDurability(isShow)
  if isShow == nil then
    isShow = true
  end
  if View.Group_Common.Group_MB.Img_Durability ~= nil then
    View.Group_Common.Group_MB.Img_Durability:SetActive(isShow)
  end
  View.Img_Dashboard:SetActive(isShow)
  if isShow then
    local serverRepairInfo = PlayerData:GetHomeInfo().readiness.repair
    local maxDurable = PlayerData.GetCoachMaxDurability()
    if View.Group_Common.Group_MB.Img_Durability ~= nil then
      View.Group_Common.Group_MB.Img_Durability.Txt_Durability:SetText(string.format(GetText(80601848), serverRepairInfo.current_durable, maxDurable))
      local percent = serverRepairInfo.current_durable / maxDurable
      View.Group_Common.Group_MB.Img_Durability.Txt_DurPCT:SetText(math.floor(percent * 100) .. "%")
      View.Group_Common.Group_MB.Img_Durability.Img_PB:SetFilledImgAmount(percent)
    end
  end
end

function Controller:HideAll(forbidShow)
  DataModel.posterGirlTempStatus = View.Group_Common.Group_PosterGirl.IsActive
  View.self:PlayAnim("HideAll", function()
    TrainCameraManager:SetCurCameraIgnoreUI(true)
    View.Img_Dashboard:SetActive(false)
    View.Btn_Launch.self:SetActive(false)
    View.Btn_City.self:SetActive(false)
    View.Btn_Dungeon.self:SetActive(false)
    Controller:ShowCoach(false)
    Controller:ShowOutSide(false)
    View.Btn_ShowUI:SetActive(true)
    Controller.forbidShow = forbidShow
  end)
end

function Controller:ReShowUI()
  View.Img_Dashboard:SetActive(true)
  View.Btn_ShowUI:SetActive(false)
  Controller:SwitchTab(PlayerData.TempCache.MainUIShowState)
  TrainCameraManager:SetCurCameraIgnoreUI(false)
  View.self:PlayAnim("ShowAll")
  Controller.forbidShow = nil
end

function Controller:RefreshFestivalGift()
  if DataModel.CurFrame <= 0 then
    self:CheckFestivalGift()
    DataModel.CurFrame = 90
  end
  DataModel.CurFrame = DataModel.CurFrame - 1
end

function Controller:CheckFestivalGift()
  local isGiftShow
  if PlayerData:GetPlayerLevel() < PlayerData:GetFactoryData(99900015, "ConfigFactory").LevelLimit then
    isGiftShow = false
  elseif DataModel.IsEvent or PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
    isGiftShow = false
  else
    isGiftShow = PlayerData:GetCurFestivalIndex() > 0
  end
  View.Group_Common.Group_PosterGirl.Btn_FestivalGift.self:SetActive(isGiftShow)
  if isGiftShow and PlayerData.forceShowedPosterGirl ~= true then
    if DataModel.isPosterGirlShow ~= true then
      self:ShowPosterGirl(true)
    end
    PlayerData.showPosterGirl = 1
    PlayerData.forceShowedPosterGirl = true
  end
end

function Controller:ShowPosterGirl(isShow, showSpine2, forceDisplay)
  if isShow == nil then
    isShow = true
  end
  if showSpine2 == nil then
    showSpine2 = false
  end
  DataModel.isPosterGirlShow = isShow
  View.Group_Common.Group_PosterGirl.self:SetActive(isShow)
  if isShow then
    if not DataModel.IsEvent or PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Adjutant then
      Controller:RefreshReceptionistData(PlayerData.ServerData.user_info.receptionist_id, showSpine2)
    elseif PlayerData.ServerData.user_info.guardId ~= "" then
      Controller:RefreshReceptionistData(PlayerData.ServerData.user_info.guardId, showSpine2)
    else
      local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
      if PlayerData.ServerData.user_info.gender == 0 then
        Controller:RefreshReceptionistData(defaultConfig.playerSpineList[1].id, false)
      else
        Controller:RefreshReceptionistData(defaultConfig.playerSpineList[2].id, false)
      end
    end
    if DataModel.IsEvent then
      View.Group_Common.Img_DialogBox:SetActive(true)
      View.Group_Common.Group_PosterGirl.Btn_Change.self:SetActive(false)
    else
      View.Group_Common.Group_PosterGirl.Btn_Change.self:SetActive(true)
    end
    View.timer:Resume()
    if PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
      View.Group_Common.Img_DialogBox:SetActive(true)
    end
    Controller.LoadSpineBg()
  else
    View.timer:Pause()
    if View.sound and View.sound.audioSource then
      View.sound:Stop()
      View.Group_Common.Img_DialogBox:SetActive(false)
      DataModel.soundEndTime = 0
    end
    View.Group_Common.Img_DialogBox:SetActive(false)
  end
end

function Controller.LoadSpineBg()
  local roleId, viewId
  if DataModel.RoleData ~= nil and table.count(DataModel.RoleData) > 0 then
    viewId = DataModel.RoleData.current_skin[1]
    roleId = DataModel.roleId
  elseif PlayerData.ServerData.user_info.guardId ~= "" then
    roleId = PlayerData.ServerData.user_info.guardId
  else
    local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    if PlayerData.ServerData.user_info.gender == 0 then
      roleId = defaultConfig.playerSpineList[1].id
    else
      roleId = defaultConfig.playerSpineList[2].id
    end
    viewId = PlayerData:GetFactoryData(roleId, "UnitFactory").viewId
  end
  local live2D = PlayerData:GetPlayerPrefs("int", roleId .. "live2d")
  if live2D == 1 then
    View.Group_Common.Group_PosterGirl.Img_SpineBG:SetActive(false)
    return
  end
  local viewCfg = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  if viewCfg.SpineBackground and viewCfg.SpineBackground ~= "" then
    View.Group_Common.Group_PosterGirl.Img_SpineBG:SetSprite(viewCfg.SpineBackground)
    DataModel.offsetX = viewCfg.SpineBGX and viewCfg.SpineBGX or 0
    DataModel.offsetY = viewCfg.SpineBGY and viewCfg.SpineBGY or 0
    local x = View.Group_Common.Group_PosterGirl.SpineAnimation_Character.transform.localPosition.x - DataModel.offsetX
    local y = DataModel.offsetY
    View.Group_Common.Group_PosterGirl.Img_SpineBG.transform.localPosition = Vector3(x, y, 0)
    local scale = viewCfg.SpineBGScale or 1
    View.Group_Common.Group_PosterGirl.Img_SpineBG.transform.localScale = Vector3(scale, scale, 0)
  end
  local show = viewCfg.SpineBackground and viewCfg.SpineBackground ~= "" and PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Adjutant
  View.Group_Common.Group_PosterGirl.Img_SpineBG:SetActive(show)
end

function Controller.SpineBgFollow()
  if View.Group_Common.Group_PosterGirl.Img_SpineBG.IsActive then
    local x = View.Group_Common.Group_PosterGirl.SpineAnimation_Character.transform.localPosition.x - DataModel.offsetX
    local pos = Vector3(x, DataModel.offsetY, 0)
    View.Group_Common.Group_PosterGirl.Img_SpineBG.transform.localPosition = pos
  end
end

function Controller:RefreshEffect(receptionistData)
  if receptionistData.clickEffectUrl ~= nil and receptionistData.clickEffectUrl ~= "" then
    View.Group_Common.Group_PosterGirl.SpineAnimation_CharacterEffect:SetActive(true)
    View.Group_Common.Group_PosterGirl.SpineAnimation_CharacterEffect:SetData(receptionistData.clickEffectUrl, "")
    View.Group_Common.Group_PosterGirl.SpineAnimation_CharacterEffect:SetLocalScale(Vector3(100, 100, 1))
    View.Group_Common.Group_PosterGirl.SpineAnimation_CharacterEffect:SetAction("effect_click", false, true)
  end
  if not DataModel.showSpine2 then
    local live2D = PlayerData:GetPlayerPrefs("int", DataModel.roleId .. "live2d")
    local clickAnimationList = receptionistData.clickAnimationList
    if live2D ~= 1 and clickAnimationList and table.count(clickAnimationList) > 0 then
      local weightIndex = {}
      local totalWeight = 0
      for i, v in ipairs(clickAnimationList) do
        totalWeight = totalWeight + v.weight
        table.insert(weightIndex, v.weight)
      end
      local random_num = math.random() * totalWeight
      local sum = 0
      for i, weight in ipairs(weightIndex) do
        sum = sum + weight
        if random_num <= sum then
          local randomAnim = clickAnimationList[i]
          if randomAnim then
            View.Group_Common.Group_PosterGirl.SpineAnimation_Character:SetAction(randomAnim.name, false, true)
          end
          break
        end
      end
    end
  end
end

function Controller:RefreshReceptionistData(roleId, showSpine2)
  local oldRoleId = DataModel.roleId
  DataModel.roleId = tostring(roleId)
  DataModel.RoleData = PlayerData:GetRoleById(roleId)
  local viewId
  if DataModel.RoleData ~= nil and table.count(DataModel.RoleData) > 0 then
    viewId = DataModel.RoleData.current_skin[1]
  else
    viewId = PlayerData:GetFactoryData(roleId, "UnitFactory").viewId
  end
  local receptionistData = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  local spineUrl = receptionistData.spineUrl
  print_r(viewId, receptionistData)
  print_r("-----------------------------")
  View.Group_Common.Group_PosterGirl.SpineAnimation_CharacterEffect:SetActive(false)
  View.Group_Common.Group_PosterGirl.Group_Character.self:SetActive(false)
  View.Group_Common.Group_PosterGirl.Group_CharacterIMG.self:SetActive(false)
  View.Group_Common.Group_PosterGirl.Group_Mask.self:SetActive(false)
  View.Group_Common.Group_PosterGirl.SpineSecondMode_Character:SetLocalScale(Vector3(1, 1, 1))
  local live2D = PlayerData:GetPlayerPrefs("int", roleId .. "live2d")
  local isSpine2 = false
  if showSpine2 and PlayerData:GetRoleById(roleId).resonance_lv == 5 and receptionistData.spine2Url ~= nil and receptionistData.spine2Url ~= "" and DataModel.RoleData.current_skin[2] == 1 then
    spineUrl = receptionistData.spine2Url
    isSpine2 = true
  end
  if receptionistData ~= nil and spineUrl ~= "" and live2D ~= 1 then
    View.Group_Common.Group_PosterGirl.Group_Character.self:SetActive(false)
    DataModel.showSpine2 = isSpine2
    if isSpine2 then
      View.Group_Common.Group_PosterGirl.Group_SpineAnimationAlpha:SetActive(false)
      View.Group_Common.Group_PosterGirl.SpineAnimation_Character:SetActive(false)
      View.Group_Common.Group_PosterGirl.SpineAnimation_Character:SetData("")
      View.Group_Common.Group_PosterGirl.SpineSecondMode_Character:SetActive(true)
      View.Group_Common.Group_PosterGirl.SpineSecondMode_Character:SetPrefab(spineUrl)
      if receptionistData.state2Overturn == true then
        View.Group_Common.Group_PosterGirl.SpineSecondMode_Character:SetLocalScale(Vector3(-1, 1, 1))
      end
      View.Group_Common.Group_PosterGirl.Group_Mask.self:SetActive(true)
    else
      View.Group_Common.Group_PosterGirl.SpineSecondMode_Character:SetPrefab("")
      View.Group_Common.Group_PosterGirl.SpineSecondMode_Character:SetActive(false)
      View.Group_Common.Group_PosterGirl.Group_SpineAnimationAlpha:SetActive(true)
      View.Group_Common.Group_PosterGirl.SpineAnimation_Character:SetActive(true)
      View.Group_Common.Group_PosterGirl.SpineAnimation_Character:SetData(spineUrl)
      View.Group_Common.Group_PosterGirl.SpineAnimation_Character:SetLocalScale(Vector3(100, 100, 1))
    end
  elseif receptionistData ~= nil and receptionistData.resUrl ~= "" then
    View.Group_Common.Group_PosterGirl.SpineAnimation_Character:SetActive(false)
    View.Group_Common.Group_PosterGirl.SpineSecondMode_Character:SetActive(false)
    View.Group_Common.Group_PosterGirl.Group_CharacterIMG:SetActive(true)
    if isSpine2 == true then
      View.Group_Common.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetSprite(receptionistData.State2Res)
      View.Group_Common.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetLocalPosition(Vector3(0, 0, 0))
      View.Group_Common.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetLocalScale(Vector3(1, 1, 1))
      View.Group_Common.Group_PosterGirl.Group_Mask.self:SetActive(true)
    else
      View.Group_Common.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetSprite(receptionistData.resUrl)
      View.Group_Common.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetLocalPosition(Vector3(-370 + receptionistData.offsetX, receptionistData.offsetY, 0))
      View.Group_Common.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetLocalScale(Vector3(receptionistData.offsetScale, receptionistData.offsetScale, receptionistData.offsetScale))
    end
    View.Group_Common.Group_PosterGirl.Group_CharacterIMG.Img_Character:SetNativeSize()
  end
  View.Group_Common.Group_PosterGirl.Btn_ChangeAnimation:SetActive(not isSpine2)
  View.Group_Common.Group_PosterGirl.Btn_ChangeAnimation2:SetActive(isSpine2)
end

function Controller:ExitTo(uiName, param, callback)
  View.self:SetEnableAnimator(true)
  View.self:PlayAnim("Out", function()
    UIManager:Open(uiName, param, callback)
  end)
end

function Controller:Exit(UI, status)
  View.self:SetEnableAnimator(true)
  UIManager:Open(UI, status)
end

function Controller:Exit2(UI, status)
  View.self:SetEnableAnimator(true)
  UIManager:Open(UI, status)
end

function Controller:ChangeDashBoard()
  if TradeDataModel.GetInTravel() then
    local mainUIConfig = PlayerData:GetFactoryData(99900034, "ConfigFactory")
    local curSpeed = PlayerData.GetCoachMaxSpeed()
    local cnt = #mainUIConfig.dashboardList
    for i = cnt, 1, -1 do
      local info = mainUIConfig.dashboardList[i]
      if curSpeed >= info.changeSpeed then
        DataModel.MaxDashBoardSpeed = info.maxSpeed
        View.Group_Common.Group_MB.Img_Speed.Img_S:SetSprite(info.dashboardPath)
        break
      end
    end
  end
end

function Controller.RefreshTrains()
  HomeTrainManager:LoadTrains(DataModel.roomSkinIds, DataModel.startHeight)
end

function Controller.InitTrain(isInitEnvironment)
  DataModel.RefreshData(PlayerData.ServerData.user_home_info.coach)
  Controller.RefreshTrains()
  if isInitEnvironment then
    Controller.InitEnvironment()
  end
end

function Controller.InitEnvironment()
  local isTravel, id = MapDataModel.GetTrainCurPos()
  if isTravel then
    local homeLineCA = PlayerData:GetFactoryData(id, "HomeLineFactory")
    if homeLineCA ~= nil then
      HomeSceneManager:InitEnvironment(homeLineCA.sceneGroup)
      return
    end
  else
    HomeSceneManager:InitEnvironment(DataModel.CurShowSceneInfo.sceneGroup)
  end
  HomeSceneManager:InitEnvironment(DataModel.envIDs)
end

function Controller.InitChangeNamePanel()
  View.Group_Info.Group_ChangeName.self:SetActive(true)
  View.Group_Info.Group_ChangeName.InputField_ChangeName.self:SetText("")
end

function Controller.CloseChangeNamePanel()
  View.Group_Info.Group_ChangeName.self:SetActive(false)
end

function Controller.RefreshOnhockPanel(json)
  View.Group_Onhock.self:SetActive(true)
  local awards = DataModel.tempHockReward
  local awardNum = 0
  local tempT = {}
  if awards ~= nil and awards.item ~= nil then
    for k, v in pairs(awards.item) do
      if tonumber(k) == 11400040 then
        awardNum = v.num
      end
      tempT[k] = v.num
    end
  end
  PlayerData:RefreshGetItems(tempT)
  local awards_report = json.awards_report
  View.Group_Onhock.Group_1.Img_GetTips.Txt_GetTips:SetText(string.format(GetText(80600302), awardNum))
  View.Group_Onhock.Group_1.Txt_TotalTips:SetText(string.format(GetText(80600303), math.ceil(awards_report.all_distance)))
  View.Group_Onhock.Group_1.Img_NowTips.Txt_NowTips:SetText(string.format(GetText(80600304), math.ceil(awards_report.this_distance)))
  local rewardTime = awards_report.awards_time
  if 43200 < rewardTime then
    rewardTime = 43200
  end
  local timeTable = TimeUtil:SecondToTable(rewardTime)
  View.Group_Onhock.Group_1.Img_Time.Txt_Time:SetText(string.format(GetText(80600305), timeTable.hour, timeTable.minute, timeTable.second))
  local stationCA = PlayerData:GetFactoryData(TradeDataModel.StartCity, "HomeStationFactory")
  View.Group_Onhock.Group_1.Txt_StartCity:SetText(stationCA.name)
  local curDis = TradeDataModel.GetTrainCurDistance()
  View.Group_Onhock.Group_1.Txt_StartCityKm:SetText(string.format("%.2fkm", curDis))
  stationCA = PlayerData:GetFactoryData(TradeDataModel.EndCity, "HomeStationFactory")
  View.Group_Onhock.Group_1.Txt_GoalCity:SetText(stationCA.name)
  View.Group_Onhock.Group_1.Txt_GoalCityKm:SetText(string.format("%.2fkm", TradeDataModel.StartEndTotalDistance - curDis))
  View.Group_Onhock.Group_1.Txt_Speed:SetText(TradeDataModel.Speed .. "km/h")
  local leftX = -180
  local rightX = 180
  local ratio = 0
  if TradeDataModel.StartEndTotalDistance ~= 0 then
    ratio = curDis / TradeDataModel.StartEndTotalDistance
  end
  if 1 < ratio then
    ratio = 1
  end
  local curX = leftX + (rightX - leftX) * ratio
  View.Group_Onhock.Group_1.Img_ProgressBar.Img_Progress:SetAnchoredPositionX(curX)
end

function Controller.RefreshWornPanel()
  View.Group_Worn.self:SetActive(true)
  local toCity = TradeDataModel.NextCityPath[#TradeDataModel.NextCityPath - 1]
  local stationCA = PlayerData:GetFactoryData(toCity, "HomeStationFactory")
  View.Group_Worn.Group_Schedule.Img_Origin.Txt_City:SetText(stationCA.name)
  View.Group_Worn.Group_Schedule.Txt_ReturnNum:SetText(string.format(GetText(80600299), math.ceil(TradeDataModel.DistanceToLastStation)))
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local coachCount = #DataModel.roomID
  local t = {}
  for k, v in pairs(homeConfig.coachCostList) do
    if t[v.id] == nil then
      t[v.id] = 0
    end
    t[v.id] = t[v.id] + v.num * coachCount
  end
  for k, v in pairs(stationCA.kmCostList) do
    if t[v.id] == nil then
      t[v.id] = 0
    end
    t[v.id] = t[v.id] + v.num * TradeDataModel.DistanceToLastStation
  end
  local cost = 0
  for k, v in pairs(t) do
    cost = v
    break
  end
  DataModel.coachWornCost = math.floor(cost + 0.5)
  View.Group_Worn.Group_ReturnCost.Txt_Cost:SetText("X" .. DataModel.coachWornCost)
  View.Group_Worn.Btn_Return.Txt_Return:SetText(string.format(GetText(80600336), stationCA.name))
  DataModel.coachWornToCityName = stationCA.name
end

function Controller.AutoAddMoveEnergy()
  if PlayerData:GetUserInfo().move_energy == nil then
    return
  end
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local homeCommon = require("Common/HomeCommon")
  local maxEnergy = homeCommon.GetMaxHomeEnergy()
  if maxEnergy <= PlayerData:GetUserInfo().move_energy then
    return
  end
  local onceTime = homeConfig.homeEnergyAddCD
  local onceAdd = homeConfig.homeEnergyAdd
  local id = homeConfig.homeEnergyItemId
  if TimeUtil:GetServerTimeStamp() >= PlayerData:GetUserInfo().move_energy_time + onceTime then
    PlayerData:GetUserInfo().move_energy_time = PlayerData:GetUserInfo().move_energy_time + onceTime
    PlayerData:GetUserInfo().move_energy = PlayerData:GetUserInfo().move_energy + onceAdd
    if maxEnergy < PlayerData:GetUserInfo().move_energy then
      PlayerData:GetUserInfo().move_energy = maxEnergy
    end
    View.Group_Resources.Group_Energy.Txt_Num:SetText(PlayerData:GetUserInfo().move_energy .. "/" .. maxEnergy)
  end
end

function Controller.UpdateCameraEffect()
  if #DataModel.camTimeEffect == 0 then
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    for k, v in pairs(homeConfig.cameraEffectPathList) do
      local t = {}
      local h = tonumber(string.sub(v.time, 1, 2))
      local m = tonumber(string.sub(v.time, 4, 5))
      local s = tonumber(string.sub(v.time, 7, 8))
      t.time = h * 60 * 60 + m * 60 + s
      t.path = v.path
      table.insert(DataModel.camTimeEffect, t)
    end
  end
  local serverTime = TimeUtil:GetServerTimeStamp()
  if DataModel.todayZeroTimeStamp == 0 then
    local dt = os.date("*t", PlayerData.ServerData.server_now)
    DataModel.todayZeroTimeStamp = TimeUtil:TimeStamp(string.format("%d-%2d-%2d 00:00:00", dt.year, dt.month, dt.day))
  end
  local delta = serverTime - DataModel.todayZeroTimeStamp
  if delta >= DataModel.oneDayTimeStamp then
    local dt = os.date("*t", PlayerData.ServerData.server_now)
    DataModel.todayZeroTimeStamp = TimeUtil:TimeStamp(string.format("%d-%2d-%2d 00:00:00", dt.year, dt.month, dt.day))
    delta = 0
  end
  local count = #DataModel.camTimeEffect
  for i = count, 1, -1 do
    local info = DataModel.camTimeEffect[i]
    if delta > info.time then
      if DataModel.curTimeEffect ~= info.path then
        DataModel.curTimeEffect = info.path
        HomeTrainManager:AllTrainShowLight(i == count)
      end
      return
    end
  end
  local info = DataModel.camTimeEffect[count]
  if DataModel.curTimeEffect ~= info.path then
    DataModel.curTimeEffect = info.path
    HomeTrainManager:AllTrainShowLight(true)
  end
end

function Controller.GetOnHockReward(isShowTip)
  if TimeUtil:GetServerTimeStamp() < PlayerData.ServerData.user_home_info.awards.last + 60 then
    if isShowTip then
      CommonTips.OpenTips(80600348)
    end
    return
  end
  Net:SendProto("station.get_awards", function(json)
    PlayerData.ServerData.user_home_info.awards.last = TimeUtil:GetServerTimeStamp()
    DataModel.tempHockReward = json.reward
    View.Group_Onhock.self:SetActive(true)
    Controller.RefreshOnhockPanel(json)
    View.Group_Resources.Group_Weapon.Txt_Num:SetText(PlayerData:GetGoodsById(11400040).num)
  end)
end

function Controller.RefreshTrainMove(force)
  if force or not TradeDataModel.GetIsStop() and PlayerData:GetHomeInfo().station_info.is_arrived ~= 1 then
    local curDis = TradeDataModel.GetTrainCurDistance()
    if TradeDataModel.EndCity > 0 then
      local stationCA = PlayerData:GetFactoryData(TradeDataModel.EndCity, "HomeStationFactory")
      View.Group_Common.Group_Position.Txt_Destination:SetText(string.format(GetText(80600945), stationCA.name))
    end
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local showDis = math.ceil(TradeDataModel.CurRemainDistance * homeConfig.disRatio)
    View.Group_Common.Group_Position.Txt_Distance:SetText(string.format(GetText(80600703), math.max(0, showDis)))
    local leftX = -180
    local rightX = 180
    local ratio = 0
    ratio = curDis / TradeDataModel.TravelTotalDistance
    if 1 < ratio then
      ratio = 1
    end
    local curX = leftX + (rightX - leftX) * ratio
    View.Group_Common.Group_Position.Img_ProcessBar.Img_PositionMark:SetAnchoredPositionX(curX)
    View.Group_Common.Group_Position.Img_ProcessBar.Img_PB:SetFilledImgAmount(ratio)
  end
  if force then
    Controller.ShowAutoDriveTxt(TradeDataModel.DriveState == "Drive" and TradeDataModel.GetIsTravel())
    View.Group_Common.Group_Position.self:SetActive(TradeDataModel.GetInTravel())
  end
end

function Controller.ShowAutoDriveTxt(isShow)
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  if isShow == nil then
    isShow = true
  end
  View.Group_Common.Group_Position.Img_Cruise.self:SetActive(isShow and not View.Group_Common.Group_Back.self.IsActive)
end

function Controller.GetRandomMap(mapData)
  local total = 0
  for i, v in pairs(mapData) do
    v.sum = v.weight + total
    total = v.sum
  end
  local last = 0
  local weight = math.random(0, total)
  local levelid = 0
  for i, v in pairs(mapData) do
    if weight < v.sum and last < weight then
      levelid = v.id
    end
  end
  if levelid == 0 then
    return
  end
  local levelCA = PlayerData:GetFactoryData(levelid, "AdvLevelFactory")
  PlayerPrefs.SetString("MapName", levelCA.mapPath)
end

function Controller.SetQuestTrace()
  if View ~= nil then
    QuestTrace.SetQuestTrace(View.Group_Common.Group_Navigation)
  end
end

function Controller.SwitchBGM(nowSoundId, targetSoundId, minVolume, duration)
  if nowSoundId ~= targetSoundId then
    local resUrl = PlayerData:GetFactoryData(nowSoundId).resUrl
    local audio = SoundManager:GetBgmSource(resUrl)
    local targetSound = SoundManager:CreateSound(targetSoundId)
    if targetSound then
      DOTweenTools.DOFadeSound(audio, duration, minVolume, function()
        targetSound:Play()
        local targetVolume = PlayerData:GetFactoryData(targetSoundId).volume
        targetSound:SetVolume(0.1)
        DOTweenTools.DOFadeSound(audio, duration, targetVolume)
      end)
    end
  end
end

function Controller.SetTouchCamera()
  if not View.touchCamera then
    local cam = MainManager.cam
    if cam == nil or cam:IsNull() then
      return
    end
    local envCamera = cam.transform
    if envCamera then
      local touchCamera = envCamera:GetComponent(typeof(CS.TouchCamera))
      if touchCamera == nil then
        touchCamera = envCamera.gameObject:AddComponent(typeof(CS.TouchCamera))
      end
      View.touchCamera = touchCamera
      touchCamera.canDrag = false
    end
  end
  if View.touchCamera then
    if not View.touchCamera:IsNull() then
      local isTravel, configId = MapDataModel.GetTrainCurPos()
      View.touchCamera.enabled = not isTravel
      if not isTravel then
        View.touchCamera._rightx = DataModel.CurShowSceneInfo.sceneWidth or 0
        View.touchCamera._leftx = -View.touchCamera._rightx
        View.touchCamera.canDrag = true
        View.touchCamera:InitPos()
      end
    else
      View.touchCamera = nil
    end
  end
end

function Controller.GoToNewCity(stationId, callback, isTrailer)
  if stationId == nil then
    stationId = MapDataModel.CurSelectedId
  end
  if TradeDataModel.EndCity == stationId then
    return
  end
  if PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
    return
  end
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  local lvCheckOk = PlayerData:GetUserInfo().lv >= stationCA.playerLevel
  local levelCheckOk = 0 > stationCA.specifiedLevelId or PlayerData:GetLevelPass(stationCA.specifiedLevelId)
  local questCheckOk = 0 > stationCA.questId or PlayerData.IsQuestComplete(stationCA.questId)
  local canGo = lvCheckOk and levelCheckOk and questCheckOk
  if not canGo then
    CommonTips.OpenTips(80601184)
    return
  end
  local homeCommon = require("Common/HomeCommon")
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  if PlayerData:GetUserInfo().move_energy > homeCommon.GetMaxHomeEnergy() + homeConfig.energyOver then
    homeCommon.OpenMoveEnergyUseItem(function()
      homeCommon.SetMoveEnergyElement(View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_HomeEnergy)
    end)
    return
  end
  PlayerData:SetTargetFrameRate()
  PlayerData.FreeCameraIndex = 1
  DataModel.SetCamera(PlayerData.FreeCameraIndex)
  local yesFunc = function()
    local detailDo = function()
      Controller:RunBtnState(true)
      Controller.ShowEndActive(false)
      TrainManager:TravelReset()
      DataModel:InitModel()
      PlayerData:SetAutoTrailerIds()
      TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.DriveNew)
      PlayerData:RefreshPolluteData()
      TradeDataModel.SetTrainMode(function()
        View.Group_Common.Group_Position.self:SetActive(TradeDataModel.GetInTravel())
        Controller:OpenLight(1)
        if table.count(PlayerData.polluteEffectList) == 0 then
          RenderSettingController.SetSkyRender()
        end
      end)
      Controller:ChangeDashBoard()
      Controller.SetSpeedAddShow()
      Controller.ChangeDriveBtnState()
      Controller.InitEnvironment()
      MapController:ShowDetailMap(false)
      MapDataModel.TravelLineWayPoints = {}
      Controller.SetTouchCamera()
      Controller.ShowAutoDriveTxt(true)
      PlayerData.showPosterGirl = -1
      Controller:SwitchTab(DataModel.UIShowEnum.OutSide, true)
      if callback ~= nil and type(callback) == "function" then
        callback()
      end
    end
    local drive = function()
      local getInTravel = TradeDataModel.GetInTravel()
      local internal = CS.FRef.getProperty(TrainManager, "InternalTrainManager")
      CS.FRef.setProperty(internal.EventCtrl.LevelCtrl, "_isEvent", false)
      local tradeDataModel = require("UIHome/UIHomeTradeDataModel")
      tradeDataModel.lastStopDistance = -1
      Net:SendProto(isTrailer and "station.req_back" or "station.drive", function(json)
        if isTrailer then
          PlayerData:GetHomeInfo().req_back_num = PlayerData:GetHomeInfo().req_back_num - 1
          View.Group_Common.Group_TopLeft.Btn_Gold.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
        end
        View.Group_Common.Group_MB.Group_PollutionIndex.Img_Mask.Group_Color:SetLocalEulerAngles(0)
        Net:SendProto("unification.world_pollute", function()
          PlayerData:GetPolluteTurntable(1)
        end)
        MapNeedleData.SetNeedleData()
        MapNeedleEventData.SetEventData()
        if DataModel.CurSceneName == DataModel.SceneNameEnum.Home then
          View.self:StartC(LuaUtil.cs_generator(function()
            MainManager:SetTrainViewFilter(30, true)
            coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
            local cb = function()
              UIManager:Pause(false)
              CBus:ChangeScene("Main", nil, function()
                detailDo()
              end)
            end
            CommonTips.OpenLoading(nil, nil, nil, cb)
          end))
        elseif getInTravel then
          detailDo()
          TradeDataModel.SetMapGlobalNeedles()
          local t = TradeDataModel.GetAnnouncementList(EnumDefine.Announcement.Start)
          SoundManager:PlaySoundList(t)
        else
          if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Adjutant then
            View.Group_Adjutant.Img_BG:SetActive(false)
          end
          local TimeLine = require("Common/TimeLine")
          local curStayStationCA = PlayerData:GetFactoryData(TradeDataModel.CurStayCity)
          for k, v in pairs(curStayStationCA.timeLineList) do
            TimeLine.RemoveTimeLine(v.id)
          end
          View.Group_Common.SoftMask_HomeMap.Group_MapActive:SetActive(false)
          MapDataModel.HomeMapType = 1
          MapController:ShowDetailMap(false)
          View.self:PlayAnim("MapOut2")
          local trainConfig = PlayerData:GetFactoryData(99900037, "ConfigFactory")
          local sound = SoundManager:CreateSound(trainConfig.whistleSoundId)
          if sound ~= nil then
            sound:Play()
          end
          local loadingConfig = PlayerData:GetFactoryData(99900036, "ConfigFactory")
          local text = ""
          if loadingConfig.bigWorldTipsList and 0 < #loadingConfig.bigWorldTipsList then
            text = loadingConfig.bigWorldTipsList[math.random(1, #loadingConfig.bigWorldTipsList)].tips
          end
          for k, v in pairs(curStayStationCA.pullOutTimeLineList) do
            TimeLine.LoadTimeLine(v.id)
          end
          Controller:ShowPosterGirl(false)
          HomeTrainManager:MoveTrain(trainConfig.pullOutSpeedMax or 1, trainConfig.pullOutASpeed or 1, trainConfig.pullOutTime or 1, trainConfig.delayTime, function()
            sound = SoundManager:CreateSound(trainConfig.trainSoundId)
            if sound ~= nil then
              sound:Play()
            end
          end, function()
            CommonTips.OpenLoading(function()
              detailDo()
            end, nil, nil, nil, text)
          end)
        end
      end, stationId)
    end
    local cfg = PlayerData:GetFactoryData("99900007")
    local max = PlayerData.GetMaxFuelNum()
    local buyNum = 0
    if PlayerData:GetPlayerPrefs("int", "IsAutoAddRush") == 1 then
      local remainTime = max - PlayerData:GetHomeInfo().readiness.fuel.fuel_num
      if 0 < remainTime then
        local costItem = cfg.trainRushBuyList
        local have = PlayerData:GetGoodsById(costItem[1].id).num
        local moneyNum = costItem[1] and costItem[1].num or 0
        buyNum = math.min(remainTime, math.floor(have / moneyNum))
      end
    end
    if 0 < PlayerData:GetHomeInfo().readiness.repair.current_durable then
      if 0 < buyNum then
        Net:SendProto("home.refuel", function(json)
          MapController:RefreshAcceNum()
          Controller:InitCommonShow()
          drive()
        end, tostring(buyNum))
      else
        drive()
      end
    else
      CommonTips.OpenTips(80601327)
    end
  end
  local stateInfo = homeCommon.GetCityStateInfo(stationId)
  if stateInfo == nil or PlayerData:GetPlayerLevel() >= stateInfo.recommendLevel then
    yesFunc()
  else
    local checkTipParam = {}
    checkTipParam.isCheckTip = true
    checkTipParam.checkTipKey = "StationDriveLevelCheck"
    checkTipParam.checkTipType = 1
    checkTipParam.showDanger = true
    CommonTips.OnPrompt(string.format(GetText(80601216), stateInfo.recommendLevel), nil, nil, yesFunc, nil, nil, nil, nil, checkTipParam)
  end
end

function Controller.ChangeBtn(btn, cb)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local Group_Gear = View.Group_OutSide.Group_Running.Group_Gear
  local Btn_D = Group_Gear.Btn_D
  local Btn_R = Group_Gear.Btn_R
  local Btn_B = Group_Gear.Btn_B
  local img = Group_Gear.Img_Gear
  local t = {
    {btn = Btn_D, angle = 0},
    {btn = Btn_R, angle = 90},
    {btn = Btn_B, angle = 45}
  }
  for i, v in ipairs(t) do
    if v.btn ~= btn then
      v.btn.Group_On:SetActive(false)
      v.btn.Group_Off:SetActive(true)
    else
      v.btn.Group_On:SetActive(true)
      v.btn.Group_Off:SetActive(false)
      local tween = DOTweenTools.DOLocalRotate(img.transform, 0, 0, v.angle, 0.1)
      if cb ~= nil then
        DOTweenTools.DoComplete(tween, cb)
      end
    end
  end
end

function Controller.ArriveRefreshShow(json)
  local bgSoundId = DataModel.CurShowSceneInfo.bgmId or PlayerData:GetFactoryData(TradeDataModel.EndCity).bgmId
  DataModel.nowSoundId = bgSoundId
  local sound = SoundManager:CreateSound(bgSoundId)
  if sound ~= nil then
    sound:Play()
  end
  for k, v in pairs(json.stations) do
    PlayerData:GetHomeInfo().stations[tostring(TradeDataModel.EndCity)][k] = v
  end
  local callback = function()
    PlayerData.TempCache.EventFinish = true
    Controller.MainLineEventShow(nil, false, false)
    Controller:SwitchTab(DataModel.UIShowEnum.OutSide, true)
    Controller.RefreshTrainMove(true)
    Controller:InitCommonShow()
    MapController:RefreshStationPos()
    Controller:ShowPosterGirl(PlayerData.showPosterGirl == 1)
    Controller.BackShow(false)
    Controller.ShowWarning(false)
    Controller.ShowAutoDriveTxt(false)
    View.Group_Common.Group_Position.self:SetActive(false)
    Controller.SetTouchCamera()
    View.self:PlayAnim("In")
    local t = TradeDataModel.GetAnnouncementList(EnumDefine.Announcement.Enter)
    SoundManager:PlaySoundList(t)
    CommonTips.OpenQuestsCompleteTip()
    CommonTips.OpenRepLvUp()
    View.Group_Common.Group_TopLeft.Btn_Gold.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
    if json.stations[tostring(TradeDataModel.EndCity)].is_first == 0 then
      CommonTips.OpenArriveNewCityTip(TradeDataModel.EndCity)
    end
    if json.fatigue then
      CommonTips.OpenFatigueTip(json.fatigue)
    end
  end
  local afterDo = function(isChangeScene)
    TradeDataModel.SetTrainMode(function()
      if not isChangeScene then
        local isReloadCoach = HomeTrainManager:GetCoachSkinState() ~= PosClickHandler.GetCoachDirtyType()
        if isReloadCoach then
          HomeTrainManager:ReloadTrains()
        end
      end
      callback()
    end)
  end
  local passengerAfterDo = function(isChangeScene)
    TradeDataModel.SetTrainMode(function()
      if not isChangeScene then
        local isReloadCoach = HomeTrainManager:GetCoachSkinState() ~= PosClickHandler.GetCoachDirtyType()
        if isReloadCoach then
          HomeTrainManager:ReloadTrains()
        end
      end
      DataModel.passengerCoroutine = View.self:StartC(LuaUtil.cs_generator(function()
        Controller:SwitchTab(DataModel.UIShowEnum.Passenger, false)
        local TimeLine = require("Common/TimeLine")
        local stationCA = PlayerData:GetFactoryData(TradeDataModel.CurStayCity)
        for k, v in pairs(stationCA.timeLineList) do
          TimeLine.RemoveTimeLine(v.id)
        end
        local passengerDataModel = require("UIPassenger/UIPassengerDataModel")
        passengerDataModel.CreateNpc(false)
        local psgDataModel = require("UIPassenger/UIPassengerDataModel")
        local outPsgIds = psgDataModel.GetOutPassengerList(json, 10)
        MainSceneCharacterManager:CreatePassengers(outPsgIds, false)
        coroutine.yield(CS.UnityEngine.WaitForSeconds(2))
        CommonTips.OpenPassengerRewardTips(json, callback)
        if DataModel.passengerCoroutine then
          View.self:StopC(DataModel.passengerCoroutine)
          DataModel.passengerCoroutine = nil
        end
      end))
    end)
  end
  local psgDataModel = require("UIPassenger/UIPassengerDataModel")
  local outPsgIds = psgDataModel.GetOutPassengerList(json)
  MapDataModel.TravelLineWayPoints = {}
  if DataModel.CurSceneName == DataModel.SceneNameEnum.Main then
    if 0 < #outPsgIds then
      passengerAfterDo(false)
    else
      afterDo(false)
    end
    CommonTips.OpenLoading(nil, "UI/Loading/Black_tip", nil)
  else
    local cb = function()
      UIManager:Pause(false)
      CBus:ChangeScene("Main", nil, function()
        if 0 < #outPsgIds then
          passengerAfterDo(true)
        else
          afterDo(true)
        end
      end)
    end
    CommonTips.OpenLoading(nil, "UI/Loading/Black_tip", nil, cb)
  end
end

function Controller.SetRushEffectState()
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local state = DataModel.GetIsRushing()
  if state then
    View.Group_OutSide.Group_Running.Group_RushEffect:SetDynamicGameObject(DataModel.MainRushEffectPath, 0, 0)
  end
  View.Group_OutSide.Group_Running.Group_RushEffect.self:SetActive(state)
end

function Controller.SetSpeedAddShow()
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  if TrainManager.CurrTrainState == TrainState.Rush then
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing:SetActive(true)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing.Group_RushTime:SetDynamicGameObject(DataModel.RushTimeBtnEffectPath, 0, 0)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing.Group_RushBuyBtn:SetActive(false)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_On:SetActive(false)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Off:SetActive(false)
  else
    local accelerate_num = PlayerData:GetHomeInfo().readiness.fuel.fuel_num
    if TradeDataModel.GetInTravel() then
      local isHave = 0 < accelerate_num
      View.Group_OutSide.Group_Running.Btn_Accelerate.Group_On:SetActive(isHave)
      View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Off:SetActive(not isHave)
    end
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_On.Txt_Num:SetText(accelerate_num)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Off.Txt_Num:SetText(accelerate_num)
    View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing:SetActive(false)
  end
end

function Controller.ChangeDriveBtnState()
  DataModel.isRun = false
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local Group_Gear = View.Group_OutSide.Group_Running.Group_Gear
  local Btn_D = Group_Gear.Btn_D
  local Btn_R = Group_Gear.Btn_R
  local Btn_B = Group_Gear.Btn_B
  if TrainManager.CurrTrainState == TrainState.Running or TrainManager.CurrTrainState == TrainState.AddSpeed or TrainManager.CurrTrainState == TrainState.ReduceSpeed or TrainManager.CurrTrainState == TrainState.Rush then
    Controller.ChangeBtn(Btn_D)
    Controller.BackShow(false)
    DataModel.isRun = TrainManager.CurrTrainState ~= TrainState.Rush
  elseif TrainManager.CurrTrainState == TrainState.Astern then
    Controller.ChangeBtn(Btn_R)
    Controller.BackShow(true)
  elseif TrainManager.CurrTrainState == TrainState.Stop or TrainManager.CurrTrainState == TrainState.Stopping or TrainManager.CurrTrainState == TrainState.Event or TrainManager.CurrTrainState == TrainState.Eventing or TrainManager.CurrTrainState == TrainState.EventFinish or TrainManager.CurrTrainState == TrainState.Arrive or TrainManager.CurrTrainState == TrainState.Arriving or TrainManager.CurrTrainState == TrainState.Backing or TrainManager.CurrTrainState == TrainState.Back then
    Controller.ChangeBtn(Btn_B)
    if TrainManager.CurrTrainState == TrainState.Arrive or TrainManager.CurrTrainState == TrainState.Arriving or TrainManager.CurrTrainState == TrainState.Back or TrainManager.CurrTrainState == TrainState.Eventing or TrainManager.CurrTrainState == TrainState.Event then
      Controller.BackShow(false)
    else
      Controller.BackShow(true)
    end
    if TrainManager.CurrTrainState == TrainState.Eventing or TrainManager.CurrTrainState == TrainState.Event then
      Controller.ShowAutoDriveTxt(false)
    end
  end
  if MapNeedleEventData.event then
    Controller.BackShow(true)
    Controller.ShowAutoDriveTxt(true)
  end
end

function Controller.ShowEndActive(isActive)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local Group_Running = View.Group_OutSide.Group_Running
  local Group_Common = View.Group_Common
  Group_Common.Btn_Enter.self:SetActive(isActive)
  Group_Common.Btn_Leave.self:SetActive(isActive)
  Group_Running.Btn_Mask:SetActive(isActive)
  View.Group_Common.Btn_ClickFight.self:SetActive(false)
end

function Controller.SetSpeedShow(speed, isTween)
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  if View and View.self and View.self.IsActive then
    local imgPercent = 0.67
    imgPercent = 0.164 + imgPercent * speed / DataModel.MaxDashBoardSpeed
    local angle = 120 - speed / DataModel.MaxDashBoardSpeed * 240
    angle = math.max(-130, angle)
    if View.Group_Common.Group_MB.Img_Speed.Img_Pointer.IsActive then
      if isTween then
        DOTweenTools.DOLocalRotate(View.Group_Common.Group_MB.Img_Speed.Img_Pointer.transform, 0, 0, angle, 0.5)
        DOTweenTools.DoImgProgressbar(View.Group_Common.Group_MB.Img_Speed.Img_BP, View.Group_Common.Group_MB.Img_Speed.Img_BP.Img.fillAmount, imgPercent, 0.5)
        DOTweenTools.DoTextProgress(View.Group_Common.Group_MB.Img_Speed.Txt_Speed, tonumber(View.Group_Common.Group_MB.Img_Speed.Txt_Speed.Txt.text), speed, 0.5, nil, nil, nil, true, "f0")
      else
        View.Group_Common.Group_MB.Img_Speed.Img_Pointer:SetLocalEulerAngles(angle)
        View.Group_Common.Group_MB.Img_Speed.Img_BP:SetFilledImgAmount(imgPercent)
        View.Group_Common.Group_MB.Img_Speed.Txt_Speed:SetText(math.floor(speed))
      end
    end
  end
end

function Controller:RandomPlayRoleSound(forceSound)
  DataModel.nextPlaySoundTime = DataModel.nextPlaySoundTime or 0
  local time = os.time()
  if time > DataModel.soundEndTime then
    local count = DataModel.roleAudioCount
    if count == 0 then
      return
    end
    math.randomseed(time)
    local roleAudio = DataModel.roleAudioList[math.random(3, count)]
    if forceSound then
      roleAudio = DataModel.roleAudioList[2]
    end
    local nowId = roleAudio.Audio2
    DataModel.lastRoleSoundId = nowId
    local sound = SoundManager:CreateSound(DataModel.lastRoleSoundId)
    if sound ~= nil then
      sound:Play()
      DataModel.soundEndTime = sound.audioSource.clip.length + time + 1
      View.sound = sound
    else
      DataModel.soundEndTime = 3 + time + 1
    end
    DataModel:GetNextSoundTime()
    View.timer:ReTimer(DataModel.nextDelay)
    View.Group_Common.Img_DialogBox:SetActive(true)
    local content = roleAudio.StoryText
    View.Group_Common.Img_DialogBox.Txt_Dialog:SetText(content)
    local txtHeight = View.Group_Common.Img_DialogBox.Txt_Dialog:GetHeight()
    View.Group_Common.Img_DialogBox:SetHeight(txtHeight + 80)
    View.Group_Common.Img_DialogBox.Txt_Dialog:SetHeight(txtHeight)
    View.Group_Common.Img_DialogBox.Txt_Dialog:SetTweenContent(content)
    if View.coroutineSound then
      View.self:StopC(View.coroutineSound)
      View.coroutineSound = nil
    end
    View.coroutineSound = View.self:StartC(LuaUtil.cs_generator(function()
      local soundTime = sound ~= nil and sound.audioSource.clip.length or 3
      coroutine.yield(CS.UnityEngine.WaitForSeconds(soundTime))
      View.Group_Common.Img_DialogBox:SetActive(false)
      View.sound = nil
    end))
    if DataModel.showSpine2 then
      local unit = PlayerData:GetRoleById(DataModel.roleId)
      local viewId = unit and unit.current_skin[1] or PlayerData:GetFactoryData(DataModel.roleId, "UnitFactory").viewId
      local viewCA = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
      if viewCA.spine2X ~= 0 then
        View.Group_Common.Img_DialogBox:SetAnchoredPositionX(-570 - viewCA.spine2X)
      else
        View.Group_Common.Img_DialogBox:SetAnchoredPositionX(-670)
      end
    else
      View.Group_Common.Img_DialogBox:SetAnchoredPositionX(-670)
    end
  end
end

function Controller:InitDrinkBuffShow()
  local drinkBuff = PlayerData:GetCurDrinkBuff()
  DataModel.IsDrinkBuffShow = drinkBuff ~= nil
  if DataModel.IsDrinkBuffShow then
    View.Group_Common.Group_TopLeft.Group_Buff.self:SetActive(true)
  end
  View.Group_Common.Group_TopLeft.Group_Buff.Img_Buff.self:SetActive(DataModel.IsDrinkBuffShow)
end

function Controller:InitSpeedUpBuffShow()
  local buff = PlayerData:GetCurStationStoreBuff(PlayerData:GetCurTrainBuffType())
  DataModel.IsSpeedUpBuffShow = buff ~= nil
  if DataModel.IsSpeedUpBuffShow then
    View.Group_Common.Group_TopLeft.Group_Buff.self:SetActive(true)
  end
  View.Group_Common.Group_TopLeft.Group_Buff.Img_BuffSpeed.self:SetActive(DataModel.IsSpeedUpBuffShow)
end

function Controller:InitBattleUpBuffShow()
  local buff = PlayerData:GetCurStationStoreBuff(EnumDefine.HomeSkillEnum.HomeBattleBuff)
  DataModel.IsBattleBuffShow = buff ~= nil
  if DataModel.IsBattleBuffShow then
    View.Group_Common.Group_TopLeft.Group_Buff.self:SetActive(true)
  end
  View.Group_Common.Group_TopLeft.Group_Buff.Img_BuffBattle.self:SetActive(DataModel.IsBattleBuffShow)
end

function Controller:CheckDrinkBuffShow()
  if DataModel.IsDrinkBuffShow then
    local drinkBuff = PlayerData:GetCurDrinkBuff()
    local curTime = TimeUtil:GetServerTimeStamp()
    if drinkBuff == nil or curTime >= drinkBuff.endTime then
      PlayerData:SetDrinkBuff(nil)
      View.Group_Common.Group_TopLeft.Group_Buff.Img_Buff.self:SetActive(false)
      DataModel.IsDrinkBuffShow = false
    end
  end
end

function Controller:CheckSpeedUpBuffShow()
  if DataModel.IsSpeedUpBuffShow then
    local buffType = PlayerData:GetCurTrainBuffType()
    local buff = PlayerData:GetCurStationStoreBuff(buffType)
    local curTime = TimeUtil:GetServerTimeStamp()
    if buff == nil or curTime >= buff.endTime then
      PlayerData:SetStationStoreBuff(nil, buffType)
      View.Group_Common.Group_TopLeft.Group_Buff.Img_BuffSpeed.self:SetActive(false)
      DataModel.IsSpeedUpBuffShow = false
    end
  end
end

function Controller:CheckBattleUpBuffShow()
  if DataModel.IsBattleBuffShow then
    local buffType = EnumDefine.HomeSkillEnum.HomeBattleBuff
    local buff = PlayerData:GetCurStationStoreBuff(buffType)
    local curTime = TimeUtil:GetServerTimeStamp()
    if buff == nil or curTime >= buff.endTime then
      PlayerData:SetStationStoreBuff(nil, buffType)
      View.Group_Common.Group_TopLeft.Group_Buff.Img_BuffBattle.self:SetActive(false)
      DataModel.IsBattleBuffShow = false
    end
  end
end

function Controller:TrainEvent(eventId, isEventEnter)
  Controller.StrikeShow(false)
  if eventId == nil then
    if DataModel.TrainEventId and PlayerData.BattleInfo.BattleResult and not PlayerData.BattleInfo.BattleResult.isWin then
      local t = {
        id = DataModel.TrainEventId
      }
      UIManager:Open("UI/MainUI/BattleLoss", Json.encode(t))
    end
    DataModel.TrainEventId = nil
    DataModel.TrainLevelId = nil
    DataModel.TrainLineId = nil
    DataModel.IsEvent = false
    DataModel.TrainEventBgmId = nil
    Controller.ShowRoleTip(false)
    Controller.SetGroupFightShow(false)
    return
  end
  local event = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
  if event.mod == "关卡事件" then
    if MainManager.bgSceneName == DataModel.SceneNameEnum.Main or MainManager.bgSceneName == DataModel.SceneNameEnum.Home then
      if isEventEnter then
        View.self:PlayAnim("BattleStart")
      else
        View.self:PlayAnim("BattleIng")
      end
      View.Group_Common.Btn_Enter:SetActive(false)
      View.Group_Common.Btn_Leave:SetActive(false)
      View.Group_Common.Group_Back.self:SetActive(false)
      View.Group_Common.Group_Fight.Btn_Mask:SetActive(false)
    end
    DataModel.IsEvent = true
    Controller.ShowRoleTip(true)
    local levelId = event.levelId
    DataModel.TrainEventId = eventId
    DataModel.TrainLevelId = levelId
    if event.isBgm then
      DataModel.TrainEventBgmId = event.bgmId
    end
    Controller.SetGroupFightShow(true)
  elseif event.mod == "点击关卡" or event.mod == "污染点击事件" then
  end
end

function Controller.SetGroupFightShow(isShow)
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  View.Group_Common.Group_Fight:SetActive(isShow)
  if isShow then
    if UIManager:IsPanelOpened("UI/Attraction/Attractions") then
      UIManager:ClosePanel(true, "UI/Attraction/Attractions")
    end
    Controller.ShowWarning(false)
  else
    Controller:ReopenAttractions()
  end
end

function Controller:RunBtnState(state)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local Group_Gear = View.Group_OutSide.Group_Running.Group_Gear
  local Btn_D = Group_Gear.Btn_D
  local Btn_R = Group_Gear.Btn_R
  local Btn_B = Group_Gear.Btn_B
  local Btn_Accelerate = View.Group_OutSide.Group_Running.Btn_Accelerate
  local allBtn = {
    Btn_B,
    Btn_R,
    Btn_D,
    Btn_Accelerate
  }
  for i, v in ipairs(allBtn) do
    v:SetBtnInteractable(state)
  end
end

function Controller.ReachNewCityRoleTip()
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  if PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
    View.Group_Common.Img_DialogBox:SetActive(true)
    View.Group_Common.Group_Position.Txt_Distance:SetText(GetText(80600424))
    Controller:ShowPosterGirl(true, false, true)
    local nowStationName = PlayerData:GetFactoryData(TradeDataModel.CurStayCity).name
    local content = string.format(GetText(80600741), nowStationName)
    View.Group_Common.Img_DialogBox.Txt_Dialog:SetText(content)
    local txtHeight = View.Group_Common.Img_DialogBox.Txt_Dialog:GetHeight()
    View.Group_Common.Img_DialogBox:SetHeight(txtHeight + 80)
    View.Group_Common.Img_DialogBox.Txt_Dialog:SetHeight(txtHeight)
    View.Group_Common.Img_DialogBox.Txt_Dialog:SetTweenContent(content)
  end
end

function Controller.ShowHelpButton()
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  if TradeDataModel.GetInTravel() then
    if PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 and not PlayerData.TempCache.IsHelp then
      View.Group_Common.Btn_Help.self:SetActive(true)
      View.Group_Common.Group_Back.self:SetActive(false)
    else
      View.Group_Common.Btn_Help.self:SetActive(false)
    end
  else
    View.Group_Common.Btn_Help.self:SetActive(false)
  end
end

function Controller.SetTrainBreakEffect()
  if TradeDataModel.GetInTravel() then
    local isBreak = PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 and not PlayerData.TempCache.IsHelp
    TrainManager:SetOutSideTrainBreakEffect(isBreak)
  end
end

function Controller.ShowRoleTip(isShow)
  if PlayerData:GetHomeInfo().station_info.is_arrived == 2 then
    return
  end
  if not isShow and PlayerData.showPosterGirl == 1 then
    return
  end
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  View.Group_Common.Img_DialogBox:SetActive(isShow)
  Controller:ShowPosterGirl(isShow, nil, isShow)
  local content = GetText(80601092)
  View.Group_Common.Img_DialogBox.Txt_Dialog:SetText(content)
  local txtHeight = View.Group_Common.Img_DialogBox.Txt_Dialog:GetHeight()
  View.Group_Common.Img_DialogBox:SetHeight(txtHeight + 80)
  View.Group_Common.Img_DialogBox.Txt_Dialog:SetHeight(txtHeight)
  View.Group_Common.Img_DialogBox.Txt_Dialog:SetTweenContent(content)
end

function Controller.FuncActive()
  local funcTable = {}
  funcTable[100] = function(active)
    View.Group_Common.Group_TopRight.Btn_Mission.self:SetActive(active)
    if active then
      local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
      local battlePass = PlayerData:GetFactoryData(initConfig.BattlePassId, "BattlePassFactory")
      print_r(battlePass, "battlePass.PassEndTime")
      View.Group_Common.Group_TopRight.Btn_Mission.self:SetActive(TimeUtil:IsActive(battlePass.PassStartTime, battlePass.PassEndTime))
    end
  end
  funcTable[101] = function(active)
    View.Group_Common.Group_TopRight.Btn_Store.self:SetActive(active)
  end
  funcTable[102] = function(active)
    View.Group_Common.Group_TopRight.Btn_Headhunt.self:SetActive(active)
  end
  funcTable[103] = function(active)
    View.Group_Common.Group_TopRight.Btn_Depot.self:SetActive(active)
  end
  funcTable[104] = function(active)
    View.Group_Common.Group_TopRight.Btn_Member.self:SetActive(active)
    View.Group_Common.Group_TopRight.Btn_Member.Img_Remind.self:SetActive(PlayerData.isAwakeRed)
  end
  funcTable[105] = function(active)
    View.Group_Common.Group_TopRight.Btn_Squads.self:SetActive(active)
  end
  funcTable[106] = function(active)
  end
  funcTable[107] = function(active)
  end
  funcTable[108] = function(active)
    View.Group_OutSide.Group_Station.Btn_Build.Img_Lock:SetActive(not active)
  end
  funcTable[109] = function(active)
  end
  funcTable[110] = function(active)
  end
  funcTable[118] = function(active)
    View.Group_Common.Group_TopRight.Btn_Activity:SetActive(false)
  end
  funcTable[120] = function(active)
    View.Group_Common.Group_TopRight.Btn_ActivityNew:SetActive(true)
    local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
    View.Group_Common.Group_TopRight.Btn_ActivityNew.Img_Remind:SetActive(ActivityMainDataModel.GetMainAllRedState())
  end
  local funcViewShow = function(activeTable)
    for k, v in pairs(funcTable) do
      v(activeTable[k] ~= nil)
    end
  end
  local funcCommon = require("Common/FuncCommon")
  funcCommon.CheckActiveFunc(funcViewShow)
end

function Controller.ShowCoachQuickJump(isShow, callback)
  if isShow == View.Group_Coach.Group_QuickJump.Btn_Close.IsActive then
    return
  end
  local showUI = function()
    View.Group_Coach.Group_QuickJump.Btn_DecorateOFF.self:SetActive(not isShow)
    View.Group_Coach.Group_QuickJump.Btn_Close:SetActive(isShow)
    View.Group_Coach.Group_QuickJump.Btn_DecorateON.self:SetActive(isShow)
    View.Group_Coach.Group_QuickJump.Group_Windows.self:SetActive(isShow)
  end
  if isShow then
    showUI()
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local maxCoachNum = 0
    local curLv = PlayerData:GetHomeInfo().electric_lv + 1
    for k, v in pairs(homeConfig.electricLevelList) do
      if curLv < v.lv then
        maxCoachNum = k - 1
        break
      end
    end
    if maxCoachNum == 0 then
      maxCoachNum = #homeConfig.electricLevelList
    end
    DataModel.MaxCoachNum = maxCoachNum
    DataModel.CurBanEnterCoachCount = 0
    DataModel.JumpRoomCtrList = {}
    local width = DataModel.MaxCoachNum * 125 + 15
    View.Group_Coach.Group_QuickJump.Group_Windows.Img_Base.StaticGrid_Train.self:SetWidth(width)
    View.Group_Coach.Group_QuickJump.Group_Windows.Img_Base.StaticGrid_Train.grid.self:RefreshAllElement()
    View.Group_Coach.Group_QuickJump.Group_Windows.Img_Base.self:SetWidth(width + 50)
    View.self:PlayAnimOnce("In_Jump", function()
      if callback then
        callback()
      end
    end)
  else
    View.self:PlayAnimOnce("Out_Jump", function()
      showUI()
      if callback then
        callback()
      end
    end)
  end
end

function Controller.ShowManagerTool(isShow, callback)
  if View.Group_Coach.Img_Control.IsActive == isShow then
    return
  end
  if isShow then
    View.Group_Coach.Img_Control.self:SetActive(true)
    View.Group_Coach.Img_Control.Btn_Passenger.Txt_num:SetActive(PlayerData.IsPassageFunOpen())
    View.Group_Coach.Img_Control.Btn_Passenger.Img_Lock:SetActive(not PlayerData.IsPassageFunOpen())
    View.Group_Coach.Img_Control.Btn_Passenger.Txt_num:SetText(string.format("%d/%d", PlayerData:GetCurPassengerNum(), PlayerData:GetMaxPassengerNum()))
    View.self:PlayAnimOnce("manage_in", function()
      if callback then
        callback()
      end
    end)
  else
    View.self:PlayAnimOnce("manage_out", function()
      View.Group_Coach.Img_Control.self:SetActive(false)
      if callback then
        callback()
      end
    end)
  end
end

function Controller.Battle(enemyLevel)
  local lineInfo = DataModel.CurrLineInfo
  local minLevel = 1
  local lineBgList = {}
  local lineEnemyLevel = -1
  local lineEnemyRn = -1
  local lineWeatherIdList = {}
  local lineWeatherRateSN = -1
  local areaId = -1
  local enemyWaveStr = ""
  if PlayerData.TempCache.AreaId ~= nil then
    areaId = PlayerData.TempCache.AreaId
  elseif DataModel.TrainEventAreaId ~= nil and DataModel.TrainEventAreaId > 0 then
    areaId = DataModel.TrainEventAreaId
  end
  local isForward = TrainManager.TrainCtrl.FirstTrain.CurrInfo.isForward
  local stationId = isForward and lineInfo.station02 or lineInfo.station01
  local stationInfo = PlayerData:GetHomeInfo().station_info
  local lineEvents
  if stationInfo ~= nil and stationInfo.line_events then
    lineEvents = stationInfo.line_events
  end
  local events
  if lineEvents ~= nil and lineEvents[tostring(stationId)] then
    events = lineEvents[tostring(stationId)].events
  end
  if events ~= nil then
    for i = 1, #events do
      if events[i].id == tostring(DataModel.TrainEventId) then
        if enemyLevel == nil and events[i].lv ~= nil then
          lineEnemyLevel = events[i].lv
        end
        if events[i].waves == nil then
          break
        end
        for j = 1, #events[i].waves do
          if 3 < j then
            goto lbl_108
          end
          if enemyWaveStr ~= "" then
            enemyWaveStr = enemyWaveStr .. ","
          end
          enemyWaveStr = enemyWaveStr .. events[i].waves[j]
        end
        break
      end
    end
  end
  ::lbl_108::
  local idx = PlayerData.TempCache.EventIndex
  if enemyLevel == nil and lineEnemyLevel <= 0 and idx ~= nil and idx ~= "" then
    local listId = tonumber(string.sub(idx, 1, 8))
    local areaInfo = PlayerData:GetFactoryData(areaId)
    if areaInfo ~= nil then
      local clickList = areaInfo.ClickLevelList
      for i = 1, #clickList do
        if clickList[i].id == listId then
          lineEnemyLevel = math.floor(math.random(clickList[i].levelLvMin, clickList[i].levelLvMax))
          break
        end
      end
    end
  end
  if lineInfo ~= nil then
    minLevel = lineInfo.enemyLevelMin
    lineBgList = lineInfo.lineBgList
    lineEnemyRn = lineInfo.LineEnemyRn
    lineWeatherRateSN = lineInfo.LineWeatherRate
    for i = 1, #lineInfo.LineWeatherList do
      lineWeatherIdList[i] = lineInfo.LineWeatherList[i].LineWTid
    end
  end
  local bgId = -1
  local currPosition = -1
  if TrainManager.TrainCtrl.FirstTrain ~= nil then
    currPosition = TrainManager.TrainCtrl.FirstTrain.Position
  end
  for i = 1, #lineBgList do
    if currPosition < lineBgList[i].distance0 then
      bgId = lineBgList[i].LineBgid
      break
    end
  end
  local trainWeaponParam = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainBattleBuff)
  local weaponSkillList = ""
  for i = 1, #trainWeaponParam do
    local skillData = PlayerData:GetFactoryData(trainWeaponParam[i].weaponSkillId)
    if skillData ~= nil and PlayerData:CheckTrainWeaponCondition(skillData.buffType, {areaId = areaId}) and skillData.skillBuff ~= nil and 0 < skillData.skillBuff then
      weaponSkillList = weaponSkillList .. skillData.skillBuff .. ":" .. trainWeaponParam[i].lv + 1
    end
    if weaponSkillList ~= "" and i ~= #trainWeaponParam then
      weaponSkillList = weaponSkillList .. ","
    end
  end
  local homeBuff = PlayerData:GetCurStationStoreBuff(EnumDefine.HomeSkillEnum.HomeBattleBuff)
  local curTime = TimeUtil:GetServerTimeStamp()
  if homeBuff ~= nil and curTime < homeBuff.endTime then
    local buffCA = PlayerData:GetFactoryData(homeBuff.id, "HomeBuffFactory")
    if weaponSkillList ~= "" then
      weaponSkillList = weaponSkillList .. ","
    end
    weaponSkillList = weaponSkillList .. buffCA.battleBuff .. ":1"
  end
  local status = {
    Current = "Chapter",
    squadIndex = PlayerData.BattleInfo.squadIndex,
    hasOpenThreeView = false,
    levelChainId = nil,
    eventId = DataModel.TrainEventId,
    minEnemyLevel = enemyLevel or minLevel,
    bgId = bgId,
    enemyLevel = enemyLevel or lineEnemyLevel,
    enemyRn = lineEnemyRn,
    lineWeatherIdList = lineWeatherIdList,
    lineWeatherRateSN = lineWeatherRateSN * SafeMath.safeNumberTime,
    areaId = areaId,
    trainWeaponSkill = weaponSkillList,
    enemy_ids = enemyWaveStr
  }
  PlayerData.BattleInfo.battleStageId = DataModel.TrainLevelId
  PlayerData.BattleCallBackPage = ""
  UIManager:Open("UI/Squads/Squads", Json.encode(status))
end

function Controller.Astern()
  TrainManager:ChangeState(TrainState.Astern, function()
    View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundDownToR:SetActive(true)
    Controller.ChangeDriveBtnState()
    Controller.ShowAutoDriveTxt(false)
  end)
end

function Controller.Stop()
  if TrainManager.CurrTrainState ~= TrainState.Stop and TrainManager.CurrTrainState ~= TrainState.Stopping and TrainManager.CurrTrainState ~= TrainState.Arrive then
    local oldState = TrainManager.CurrTrainState
    TrainManager:ChangeState(TrainState.Stopping, function()
      if oldState == TrainState.Astern then
        View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundDownToB:SetActive(true)
      else
        View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundUpToB:SetActive(true)
      end
      Controller.ChangeDriveBtnState()
      Controller.ShowAutoDriveTxt(false)
    end)
  end
end

function Controller.ImmediatelyStop()
  if TrainManager.CurrTrainState ~= TrainState.Stop and TrainManager.CurrTrainState ~= TrainState.Arrive then
    local oldState = TrainManager.CurrTrainState
    TrainManager:ChangeState(TrainState.Stop, function()
      if oldState == TrainState.Astern then
        View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundDownToB:SetActive(true)
      else
        View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundUpToB:SetActive(true)
      end
      Controller.ChangeDriveBtnState()
      Controller.ShowAutoDriveTxt(false)
    end)
  end
end

function Controller.Drive()
  if TrainManager.CurrTrainState ~= TrainState.Running and TrainManager.CurrTrainState ~= TrainState.AddSpeed then
    local drive = function()
      local targetSpeed = TradeDataModel.GetServerSpeed()
      TrainManager:Drive(targetSpeed)
      Controller:SwitchTab(DataModel.UIShowEnum.OutSide)
      View.Group_OutSide.Group_Running.Group_Gear.Group_Sound.Group_SoundUpToD:SetActive(true)
      Controller.ChangeDriveBtnState()
      MapDataModel.TravelLineWayPoints = {}
      Controller.ShowAutoDriveTxt(true)
      Controller:OpenLight(1)
      PlayerData:SetTargetFrameRate()
    end
    if TrainManager.CurrTrainState == TrainState.Stopping or PlayerData:GetHomeInfo().station_info.stop_info[2] == -2 then
      drive()
    else
      Net:SendProto("station.drive", function(json)
        drive()
      end, TradeDataModel.EndCity)
    end
  end
end

function Controller.SetRushState(isShow)
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    View.Group_Common.Group_MB.SpineNode_Rush:SetActive(isShow)
    if not isShow then
      View.Group_OutSide.Group_Running.Group_RushEffect:HideDynamicGameObject(DataModel.MainRushEffectPath)
      View.Group_Common.Group_MB.Group_Lighting:HideDynamicGameObject(DataModel.TrainRushEffectPath)
      local isHave = TrainWeaponTag.IsWeaponedById(83100032)
      if isHave then
        local cfg = PlayerData:GetFactoryData(83100032, "HomeWeaponFactory")
        View.Group_Common.Group_MB.Group_Lighting:HideDynamicGameObject(cfg.specialEffects)
      end
    end
  end
end

function Controller.Rush()
  if TrainManager.CurrTrainState == TrainState.Event or TrainManager.CurrTrainState == TrainState.Arrive or TrainManager.CurrTrainState == TrainState.Rush then
    print_r("不允许冲刺...谢谢")
    return
  end
  if DataModel.GetIsRushClick() then
    return
  end
  if PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
    UIManager:Open("UI/Common/BuyRushTips")
  elseif PlayerData:GetHomeInfo().readiness.fuel.fuel_num > 0 then
    DataModel.SetIsRushClick(true)
    if TrainManager.CurrTrainState ~= TrainState.Rush then
      DataModel.isRun = false
      local cb = function()
        PlayerData:GetHomeInfo().readiness.fuel.fuel_num = PlayerData:GetHomeInfo().readiness.fuel.fuel_num - 1
        View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing:SetActive(false)
        View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Ing.Group_RushBuyBtn:SetActive(false)
        View.Group_OutSide.Group_Running.Btn_Accelerate.Group_On:SetActive(false)
        View.Group_OutSide.Group_Running.Btn_Accelerate.Group_Off:SetActive(true)
        local ca = PlayerData:GetFactoryData(99900054).trainCameraList
        local row = ca[PlayerData.FreeCameraIndex]
        local tempTime = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.RiseRushUseTime)[2] or 0
        local totalTime = PlayerData:GetHomeInfo().readiness.fuel.acc_time + tempTime
        DataModel.SetRushNumber()
        DataModel.SetRushRemainTime(totalTime)
        Controller.SetRushState(true)
        DataModel.RushServerTime = totalTime + TimeUtil:GetServerTimeStamp()
        TrainManager:Rush(TradeDataModel.Speed, TradeDataModel.Speed + PlayerData:GetHomeInfo().readiness.fuel.acc_speed, totalTime, row.isRushView, row.fieldView)
        Controller.ChangeDriveBtnState()
      end
      Net:SendProto("station.accelerate", function(json)
        cb()
      end, function(json)
        DataModel.SetIsRushClick(false)
        DataModel.isRun = true
      end)
    else
      print_r("正在加速in...")
    end
  else
    CommonTips.OpenTips(80600793)
  end
end

local SetUILight = function(state)
  local Btn_Light = View.Group_OutSide.Group_Running.Btn_Light
  Btn_Light.Group_Off.self:SetActive(state == 0)
  Btn_Light.Group_On.self:SetActive(state == 1)
end

function Controller:InitCheDengLight()
  if TrainManager.CurrTrainState ~= TrainState.None or TrainManager.CurrTrainState == TrainState.Arrive and PlayerData:GetHomeInfo().station_info.is_arrived == 1 then
    PlayerData:SetPlayerPrefs("int", "huoCheLight", PlayerData:GetPlayerPrefs("int", "huoCheLight"))
    local state = PlayerData:GetPlayerPrefs("int", "huoCheLight")
    SetUILight(state)
    TrainManager:SetHuoOutSideCheLeight(state == 1, TrainWeaponTag.GetTrainLight())
  else
    PlayerData:SetPlayerPrefs("int", "huoCheLight", 0)
    TrainManager:SetHuoInternalCheLeight(false)
  end
end

function Controller:InitTrainEffect()
  Controller.isInitEffect = true
  local Trains = CS.FRef.getProperty(TrainManager.TrainCtrl, "Trains")
  if Trains == nil or Trains.Count == 0 then
    return
  end
  local path = TrainWeaponTag.GetTrainEffect()
  for i, v in pairs(path) do
    if 0 < v then
      local effect = EffectFactory:Produce(v)
      local eventCA = PlayerData:GetFactoryData(v, "EffectFactory")
      if effect then
        local particleSys = CS.FRef.getProperty(effect, "particleSys")
        particleSys.transform:SetParent(Trains[0].Skin.view.transform)
        particleSys.transform.localPosition = Vector3(eventCA.offsetX, eventCA.offsetY, eventCA.offsetZ)
        particleSys.transform.localScale = Vector3(eventCA.scaleX, eventCA.scaleY, eventCA.scaleZ or 0)
        particleSys.transform.localEulerAngles = Vector3(eventCA.eularX, eventCA.eularY, eventCA.eularZ)
        effect:PlayParticle()
      end
    end
  end
end

function Controller:OpenLight(isOpen)
  local state = PlayerData:GetPlayerPrefs("int", "huoCheLight")
  local now_State
  if state == 0 then
    now_State = 1
  else
    now_State = 0
  end
  if isOpen then
    now_State = isOpen
  end
  PlayerData:SetPlayerPrefs("int", "huoCheLight", now_State)
  SetUILight(now_State)
  TrainManager:SetHuoOutSideCheLeight(now_State == 1, TrainWeaponTag.GetTrainLight())
end

function Controller:JudgementReachArea()
  if TrainManager.TrainCtrl == nil or TrainManager.TrainCtrl.FirstTrain == nil or TrainManager.TrainCtrl.FirstTrain.CurrInfo == nil then
    return
  end
  local lineId = TrainManager.TrainCtrl.FirstTrain.CurrInfo.lineId
  if DataModel.CurrLineId == nil or DataModel.CurrLineId ~= lineId then
    DataModel.CurrLineId = lineId
    DataModel.AreaTipIndex = 0
    DataModel.CurrLineInfo = PlayerData:GetFactoryData(DataModel.CurrLineId, "HomeLineFactory")
  end
  if #DataModel.CurrLineInfo.AreaTipList == 0 then
    return
  end
  local currPosition = TrainManager.TrainCtrl.FirstTrain.Position
  for i, v in ipairs(DataModel.CurrLineInfo.AreaTipList) do
    local disMin = v.disMin
    local disMax = v.disMax
    if currPosition >= disMin and currPosition <= disMax and DataModel.AreaTipIndex ~= i then
      DataModel.AreaTipIndex = i
      UIManager:Open("UI/MainUI/Group_AreaTip", tostring(v.id))
    end
  end
end

function Controller:ReopenAttractions()
  if PlayerData.TempCache.MainUIShowState ~= DataModel.UIShowEnum.OutSide then
    return
  end
  local attrictionHistory = PlayerData:GetAttractionTipHistory()
  if not UIManager:IsPanelOpened("UI/Attraction/Attractions") and attrictionHistory.id ~= nil and attrictionHistory.disMin ~= nil then
    local currPosition = TrainManager.TrainCtrl.FirstTrain.Position
    if currPosition >= attrictionHistory.disMin and currPosition <= attrictionHistory.disMax then
      UIManager:Open("UI/Attraction/Attractions", Json.encode({
        index = attrictionHistory.index,
        id = attrictionHistory.id
      }))
      View.self:RegChildPanel("UI/Attraction/Attractions")
    end
  end
end

function Controller:JudgementReachAttraction()
  if not (DataModel.isGroupFightShow ~= true and not UIManager:IsPanelOpened("UI/Common/DialogBox_Tip") and UIManager:IsPanelOpened("UI/MainUI/MainUI")) or UIManager:IsPanelOpened("UI/Attraction/Attractions") or PlayerData.TempCache.MainUIShowState ~= DataModel.UIShowEnum.OutSide then
    return
  end
  if TrainManager.TrainCtrl == nil or TrainManager.TrainCtrl.FirstTrain == nil or TrainManager.TrainCtrl.FirstTrain.CurrInfo == nil then
    return
  end
  local lineId = TrainManager.TrainCtrl.FirstTrain.CurrInfo.lineId
  if DataModel.CurrLineId == nil or DataModel.CurrLineId ~= lineId then
    DataModel.CurrLineId = lineId
    DataModel.AttractionTipIndex = 0
    DataModel.CurrLineInfo = PlayerData:GetFactoryData(DataModel.CurrLineId, "HomeLineFactory")
  end
  if #DataModel.CurrLineInfo.AttractionList == 0 then
    return
  end
  local currPosition = TrainManager.TrainCtrl.FirstTrain.Position
  local isForward = TrainManager.TrainCtrl.FirstTrain.CurrInfo.isForward
  for i, v in ipairs(DataModel.CurrLineInfo.AttractionList) do
    local disMin = v.disMin
    local disMax = v.disMax
    if (isForward and math.abs(currPosition - disMin) < 50 or not isForward and math.abs(currPosition - disMax) < 50) and DataModel.AttractionTipIndex ~= i and not PlayerData:GetAttractionTipShowed(v.id) then
      PlayerData:SetAttractionTipShowed(v.id)
      DataModel.AttractionTipIndex = i
      PlayerData:SetAttractionTipRange(disMin, disMax)
      UIManager:Open("UI/Attraction/Attractions", Json.encode({
        index = 0,
        id = v.id
      }))
      View.self:RegChildPanel("UI/Attraction/Attractions")
    end
  end
end

function Controller.RepRedPointCheck()
  local homeCommon = require("Common/HomeCommon")
  local stateInfo = homeCommon.GetCityStateInfo(TradeDataModel.EndCity)
  if stateInfo ~= nil then
    local listCA = PlayerData:GetFactoryData(stateInfo.cityMapId, "ListFactory")
    View.Btn_City.Img_RedPoint:SetActive(listCA.isShowRep and not homeCommon.IsAllRepValueGet(TradeDataModel.EndCity) or RedPointNodeStr.IsHaveRed("CityMap"))
    if listCA.isShowConstruct and View.Btn_City.Img_RedPoint.IsActive == false then
      View.Btn_City.Img_RedPoint:SetActive(homeCommon.IsAllConstructionValueGet(TradeDataModel.EndCity))
    end
  end
end

function Controller.BackShow(isShow)
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  View.Group_Common.Group_Back.self:SetActive(isShow)
  if isShow then
    View.Group_Common.Group_Position.Img_Cruise:SetActive(false)
  end
  Controller.ShowHelpButton()
end

function Controller.Back()
  TrainManager:ChangeState(TrainState.Back)
end

function Controller.StrikeShow(isShow)
  if MainManager.bgSceneName ~= DataModel.SceneNameEnum.Main and MainManager.bgSceneName ~= DataModel.SceneNameEnum.Home then
    return
  end
  if isShow then
    Controller.ShowWarning(false)
  end
end

function Controller.ShowWarning(isShow)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  if isShow == nil then
    isShow = true
  end
  if isShow then
    View.Group_Common.Group_MB.SpineNode_Warning:SetDynamicGameObject(DataModel.WarningEffectPath, 0, 0)
  end
  View.Group_Common.Group_MB.SpineNode_Warning:SetActive(isShow)
end

function Controller.MainLineEventShow(eventId, isShow, isPrepareStrike)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  DataModel.SetTrainEventBgmId()
  local Group_Event = View.Group_Common.Group_Event
  if not isShow or eventId == nil then
    DataModel.IsEvent = false
    Controller.ShowRoleTip(false)
    Group_Event.self:SetActive(false)
    return
  end
  if eventId then
    local event = PlayerData:GetFactoryData(eventId, "AFKEventFactory")
    if event.mod == "关卡事件" then
      if UIManager:IsPanelOpened("UI/Chapter/Battle_Dungeon") then
        UIManager:GoBack()
      end
      if not isPrepareStrike then
      end
      if event.isBgm then
        DataModel.SetTrainEventBgmId(event.bgmId)
      end
      Controller.PlayTrainBgm()
      DataModel.IsEvent = true
      Controller.ShowWarning(false)
      local Group_Fight = Group_Event.Group_Fight
      local Group_Strike = Group_Event.Group_Strike
      local Group_Buy = Group_Event.Group_Buy
      local Group_Balloon = Group_Event.Group_Balloon
      Group_Event.self:SetActive(true)
      Group_Fight.self:SetActive(true)
      if isPrepareStrike then
        Controller.ShowRoleTip(false)
        if PlayerData:GetPlayerPrefs("int", "IsAutoStrike") == 1 and PlayerData.IsEnergyEnough() then
          Group_Event.self:SetActive(false)
          TrainManager:ChangeStrikeState(StrikeState.Start)
        else
          Group_Fight.Group_Fight.self:SetActive(true)
          Group_Fight.BtnPolygon_Fight.self:SetActive(false)
          Group_Event.Group_Back.self:SetActive(false)
          if event.tagUse == 12600799 then
            Group_Buy.self:SetActive(false)
            Group_Balloon.self:SetActive(true)
            Group_Balloon.Group_Balloon.self:SetActive(true)
            Group_Balloon.BtnPolygon_Balloon.self:SetActive(false)
          elseif event.tagUse == 12600798 then
            Group_Balloon.self:SetActive(false)
            Group_Buy.self:SetActive(true)
            Group_Buy.Group_Buy.self:SetActive(true)
            Group_Buy.BtnPolygon_Buy.self:SetActive(false)
          else
            Group_Buy.self:SetActive(false)
            Group_Balloon.self:SetActive(false)
          end
          Group_Strike.self:SetActive(true)
          Group_Strike.Group_Strike.self:SetActive(false)
          Group_Strike.BtnPolygon_Strike.self:SetActive(true)
          local strike = PlayerData.GetStrike()
          if strike and strike.id then
            local cfg = PlayerData:GetFactoryData(strike.id, "HomeWeaponFactory")
            Group_Strike.BtnPolygon_Strike.Txt_Cost:SetActive(true)
            Group_Strike.BtnPolygon_Strike.Txt_Cost:SetText(string.format(GetText(80601919), cfg.WeaponTired - PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.ReduceEscapeEnergy)))
          else
            Group_Strike.BtnPolygon_Strike.Txt_Cost:SetActive(false)
          end
        end
      else
        Group_Event.Group_Back.self:SetActive(true)
        Controller.ShowRoleTip(true)
        UIManager:CloseTip("UI/MainUI/Strike_Tip")
        Group_Fight.BtnPolygon_Fight.self:SetActive(true)
        Group_Fight.Group_Fight.self:SetActive(false)
        local level = PlayerData:GetFactoryData(event.levelId, "LevelFactory")
        Group_Fight.BtnPolygon_Fight.Txt_Cost:SetText(string.format(GetText(80601918), level.energyEnd))
        local lv = DataModel.GetTrainEventLv() or 0
        lv = MathEx.roundToDecimalPlaces(lv)
        Group_Fight.BtnPolygon_Fight.Txt_Lv:SetText(string.format(GetText(80601819), lv))
        local DataController = require("UISquads/UISquadsDataController")
        local currentSquad = {}
        local numSquad = 0
        local currentIndex = 1
        local curRoleList = PlayerData.ServerData.squad[currentIndex].role_list
        for i = 1, 5 do
          local temp = {}
          temp = curRoleList[i]
          if temp and temp.id == "" then
            temp.id = nil
          end
          if temp ~= nil and temp ~= "" and next(temp) ~= nil then
            numSquad = numSquad + 1
          end
          table.insert(currentSquad, temp)
        end
        local curSquad = DataController:GetRoleDataList(currentSquad)
        print_r(curSquad)
        local index = -1
        for k, v in pairs(curSquad) do
          if tonumber(v.unitId) == tonumber(PlayerData.ServerData.squad[currentIndex].header) then
            index = k
          end
        end
        if -1 < index then
          local row = curSquad[index]
          table.remove(curSquad, index)
          table.insert(curSquad, 1, row)
        end
        local eventCA = PlayerData:GetFactoryData(DataModel.TrainEventId)
        local levelId = eventCA.levelId
        local levelCA = PlayerData:GetFactoryData(levelId)
        local callBack = function()
          local levelType = 1
          local minEnemyLevel = 1
          local enemyLevel
          local minLevel = 1
          local lineEnemyRn = -1
          local lineWeatherIdList = {}
          local lineWeatherRateSN = -1
          local lineInfo = DataModel.CurrLineInfo
          if lineInfo ~= nil then
            minLevel = lineInfo.enemyLevelMin
            lineEnemyRn = lineInfo.LineEnemyRn
            lineWeatherRateSN = lineInfo.LineWeatherRate
            for i = 1, #lineInfo.LineWeatherList do
              lineWeatherIdList[i] = lineInfo.LineWeatherList[i].LineWTid
            end
          end
          lineWeatherRateSN = lineWeatherRateSN * SafeMath.safeNumberTime
          local bgId = levelCA.bgIdList[math.random(1, #levelCA.bgIdList)].id
          local areaId
          local enemyWaveStr = ""
          if PlayerData.TempCache.AreaId ~= nil then
            areaId = PlayerData.TempCache.AreaId
          elseif DataModel.TrainEventAreaId ~= nil and DataModel.TrainEventAreaId > 0 then
            areaId = DataModel.TrainEventAreaId
          end
          local isForward = TrainManager.TrainCtrl.FirstTrain.CurrInfo.isForward
          local stationId = isForward and lineInfo.station02 or lineInfo.station01
          local stationInfo = PlayerData:GetHomeInfo().station_info
          local lineEvents
          if stationInfo ~= nil and stationInfo.line_events then
            lineEvents = stationInfo.line_events
          end
          local events
          if lineEvents ~= nil and lineEvents[tostring(stationId)] then
            events = lineEvents[tostring(stationId)].events
          end
          if events ~= nil then
            for i = 1, #events do
              if events[i].id == tostring(DataModel.TrainEventId) then
                if enemyLevel == nil and events[i].lv ~= nil then
                  enemyLevel = events[i].lv
                end
                if events[i].waves == nil then
                  break
                end
                for j = 1, #events[i].waves do
                  if 3 < j then
                    goto lbl_136
                  end
                  if enemyWaveStr ~= "" then
                    enemyWaveStr = enemyWaveStr .. ","
                  end
                  enemyWaveStr = enemyWaveStr .. events[i].waves[j]
                end
                break
              end
            end
          end
          ::lbl_136::
          minEnemyLevel = enemyLevel or minLevel
          local enemyLevelOffset = 0
          local secondWeatherList = {}
          local secondWeatherRateSN = -1
          if levelCA.saleLevelType ~= "pollute" and levelCA.saleLevelType ~= "twig" and levelCA.saleLevelType ~= "buoy" or areaId == nil then
          else
            repeat
              do
                local polluteData = PlayerData.pollute_areas[tostring(areaId)]
                local polluteNum = -1
                if polluteData and polluteData.po_curIndex ~= nil then
                  polluteNum = math.ceil(polluteData.po_curIndex)
                end
                local areaCA = PlayerData:GetFactoryData(areaId)
                if areaCA then
                  local polluteLvList = areaCA.polluteLvList[polluteNum + 1]
                  if polluteLvList then
                    minEnemyLevel = polluteLvList.polluteLvMin
                  end
                  if polluteLvList ~= nil or levelCA.saleLevelType == "pollute" then
                    for i = 1, #areaCA.RnWtList do
                      secondWeatherList[#secondWeatherList + 1] = areaCA.RnWtList[i].RnWtId
                    end
                    secondWeatherRateSN = areaCA.polluteWeatherRate * SafeMath.safeNumberTime
                    break -- pseudo-goto
                  end
                end
              end
            until true
          end
          local secondWeatherCount = secondWeatherList ~= nil and #secondWeatherList or 0
          local trainWeaponParam = TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.TrainBattleBuff)
          local weaponSkillList = ""
          for i = 1, #trainWeaponParam do
            local skillData = PlayerData:GetFactoryData(trainWeaponParam[i].weaponSkillId)
            if skillData ~= nil and PlayerData:CheckTrainWeaponCondition(skillData.buffType, {areaId = areaId}) and skillData.skillBuff ~= nil and 0 < skillData.skillBuff then
              weaponSkillList = weaponSkillList .. skillData.skillBuff .. ":" .. trainWeaponParam[i].lv + 1
            end
            if weaponSkillList ~= "" and i ~= #trainWeaponParam then
              weaponSkillList = weaponSkillList .. ","
            end
          end
          local homeBuff = PlayerData:GetCurStationStoreBuff(EnumDefine.HomeSkillEnum.HomeBattleBuff)
          local curTime = TimeUtil:GetServerTimeStamp()
          if homeBuff ~= nil and curTime < homeBuff.endTime then
            local buffCA = PlayerData:GetFactoryData(homeBuff.id, "HomeBuffFactory")
            if weaponSkillList ~= "" then
              weaponSkillList = weaponSkillList .. ","
            end
            weaponSkillList = weaponSkillList .. buffCA.battleBuff .. ":1"
          end
          local StartBattle = require("UISquads/View_StartBattle")
          StartBattle:StartBattle(levelId, levelType, curSquad, currentIndex, nil, false, DataModel.TrainEventId, nil, nil, nil, minEnemyLevel, 1, bgId, enemyLevel, lineEnemyRn, lineWeatherIdList, lineWeatherRateSN, enemyLevelOffset, secondWeatherList, secondWeatherRateSN, secondWeatherCount, enemyWaveStr, weaponSkillList)
        end
        if event.isMain then
          View.self:PlayAnim("BattleStart")
          Group_Strike.self:SetActive(false)
          Group_Buy.self:SetActive(false)
          Group_Balloon.self:SetActive(false)
        else
          if event.tagUse == 12600799 then
            Group_Buy.self:SetActive(false)
            Group_Balloon.self:SetActive(true)
            Group_Balloon.Group_Balloon.self:SetActive(false)
            Group_Balloon.BtnPolygon_Balloon.self:SetActive(true)
            if PlayerData:GetPlayerPrefs("int", "IsAutoFight") == 1 then
              if PlayerData.canAuto == nil then
                View.self:PlayAnim("BattleStart")
              elseif numSquad < levelCA.minRoleNum then
                CommonTips.OpenTips(string.format(GetText(80601995), levelCA.minRoleNum))
                View.self:PlayAnim("BattleStart")
              else
                Controller.ShowRoleTip(false)
                Group_Event.self:SetActive(false)
                PlayerData.BattleCallBackPage = ""
                callBack()
              end
            else
              View.self:PlayAnim("BattleStart")
            end
          elseif event.tagUse == 12600798 then
            Group_Buy.self:SetActive(true)
            Group_Buy.Group_Buy.self:SetActive(false)
            Group_Buy.BtnPolygon_Buy.self:SetActive(true)
            Group_Balloon.self:SetActive(false)
            if PlayerData:GetPlayerPrefs("int", "IsAutoBuyRoad") == 1 then
              Controller.SpendMoneyBuyRoad(true)
            elseif PlayerData:GetPlayerPrefs("int", "IsAutoFight") == 1 then
              if PlayerData.canAuto == nil then
                View.self:PlayAnim("BattleStart")
              elseif numSquad < levelCA.minRoleNum then
                CommonTips.OpenTips(string.format(GetText(80601995), levelCA.minRoleNum))
                View.self:PlayAnim("BattleStart")
              else
                Controller.ShowRoleTip(false)
                Group_Event.self:SetActive(false)
                PlayerData.BattleCallBackPage = ""
                callBack()
              end
            else
              View.self:PlayAnim("BattleStart")
            end
          else
            Group_Buy.self:SetActive(false)
            Group_Balloon.self:SetActive(false)
            if PlayerData:GetPlayerPrefs("int", "IsAutoFight") == 1 then
              if PlayerData.canAuto == nil then
                View.self:PlayAnim("BattleStart")
              elseif numSquad < levelCA.minRoleNum then
                CommonTips.OpenTips(string.format(GetText(80601995), levelCA.minRoleNum))
                View.self:PlayAnim("BattleStart")
              else
                Controller.ShowRoleTip(false)
                Group_Event.self:SetActive(false)
                PlayerData.BattleCallBackPage = ""
                callBack()
              end
            else
              View.self:PlayAnim("BattleStart")
            end
          end
          if event.isStrike then
            Group_Strike.self:SetActive(true)
            Group_Strike.Group_Strike.self:SetActive(true)
            Group_Strike.BtnPolygon_Strike.self:SetActive(false)
          else
            Group_Strike.self:SetActive(false)
          end
        end
      end
    else
      Controller.ShowRoleTip(false)
    end
  end
end

function Controller.SpendMoneyBuyRoad(isAuto)
  local eventCA = PlayerData:GetFactoryData(DataModel.TrainEventId)
  local levelId = eventCA.levelId
  local levelCA = PlayerData:GetFactoryData(levelId)
  local homeLineCA = PlayerData:GetFactoryData(DataModel.TrainLineId)
  local isEnemyLvEquilsPlayer = levelCA.isEnemyLvEquilsPlayer
  local enemyLvOffset = levelCA.enemyLvOffset
  local levelLevel = DataModel.GetTrainEventLv()
  print_r("======levelLevel=========" .. levelLevel)
  local buyRatio = eventCA.buyRatio
  local needGold = 0
  needGold = PlayerData:GetFactoryData(99900014).buyGoldInit * levelLevel * buyRatio
  needGold = needGold * (1 - PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.ReduceBuyPassCost))
  needGold = math.floor(needGold + 0.5)
  local nowGold = PlayerData:GetUserInfo().gold
  if isAuto == true then
    if needGold > nowGold then
      View.self:PlayAnim("BattleStart")
      return
    end
    Controller.ShowRoleTip(false)
    local Group_Event = View.Group_Common.Group_Event
    Group_Event.self:SetActive(false)
    Net:SendProto("events.money_through", function(json)
      PlayerData.TempCache.EventFinish = true
      TrainManager:ChangeState(TrainState.EventFinish, function()
        Controller.ShowWarning(false)
        Controller:InitCommonShow()
        DataModel.SetTrainEventBasicId()
        DataModel.SetTrainEventBgmId()
        Controller.PlayTrainBgm()
        Controller.ShowStrikeTip(false, false)
        Controller:ShowMBDurability(false)
        TrainManager:LevelEventFinish()
        UIManager:Open("UI/MainUI/BuyRoad_Success")
        Controller.MainLineEventShow(DataModel.TrainEventId, false)
        DataModel.SetCamera(1)
        Controller:RunBtnState(true)
        Controller.BackShow(true)
        TradeDataModel.StateEnter = EnumDefine.TrainStateEnter.Refresh
        Controller.Drive()
      end)
    end, DataModel.TrainEventId)
  else
    if needGold > nowGold then
      CommonTips.OpenTips(80600260)
      return
    end
    local txt = string.format(GetText(80601827), needGold)
    CommonTips.OnPrompt(txt, nil, nil, function()
      Net:SendProto("events.money_through", function(json)
        PlayerData.TempCache.EventFinish = true
        TrainManager:ChangeState(TrainState.EventFinish, function()
          Controller.ShowWarning(false)
          Controller:InitCommonShow()
          DataModel.SetTrainEventBasicId()
          DataModel.SetTrainEventBgmId()
          Controller.PlayTrainBgm()
          Controller.ShowStrikeTip(false, false)
          Controller:ShowMBDurability(false)
          TrainManager:LevelEventFinish()
          UIManager:Open("UI/MainUI/BuyRoad_Success")
          Controller.MainLineEventShow(DataModel.TrainEventId, false)
          View.self:PlayAnimOnce("BattleEnd", function()
            DataModel.SetCamera(1)
            Controller:RunBtnState(true)
            Controller.BackShow(true)
            TradeDataModel.StateEnter = EnumDefine.TrainStateEnter.Refresh
          end)
        end)
      end, DataModel.TrainEventId)
    end)
  end
end

function Controller.OpenBattleLoss()
  if PlayerData.TempCache.consumables then
    UIManager:Open("UI/MainUI/BattleLoss")
  end
end

function Controller.PlayTrainBgm()
  local lineInfo = {}
  local isTravel, configId = MapDataModel.GetTrainCurPos(lineInfo)
  local bgSoundId = 0
  if DataManager:GetFactoryNameById(configId) == "HomeStationFactory" then
    bgSoundId = DataModel.CurShowSceneInfo.bgmId
  else
    local lineCA = PlayerData:GetFactoryData(configId)
    if lineInfo.lastStationId == lineCA.station02 and lineCA.bgmId2 > -1 then
      bgSoundId = lineCA.bgmId2
    else
      bgSoundId = lineCA.bgmId
    end
  end
  if DataModel.TrainEventBgmId ~= nil then
    bgSoundId = DataModel.TrainEventBgmId
  end
  DataModel.nowSoundId = bgSoundId
  local sound = SoundManager:CreateSound(bgSoundId)
  if sound ~= nil then
    sound:Play()
  end
end

function Controller.ShowStrikeTip(isReady, isStart, percent)
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  if isReady == nil then
    isReady = false
  end
  if isStart == nil then
    isStart = false
  end
  DataModel.SetIsStrikeStart(isStart)
  View.Group_Common.Group_MB.Img_Durability.Group_Ready:SetActive(isReady)
  View.Group_Common.Group_MB.Img_Durability.Group_Start:SetActive(isStart)
  if isReady then
    View.Group_Common.Group_MB.Img_Durability.SpineAnimation_Box:SetActive(true)
  end
  if DataModel.GetIsStrikeStart() then
    View.Group_Common.Group_MB.Img_Durability.SpineAnimation_Box:SetActive(false)
  else
    View.Group_Common.Group_MB.Img_Durability.SpineAnimation_Box:SetActive(true)
  end
end

function Controller.StrikeStart()
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local Group_Gear = View.Group_OutSide.Group_Running.Group_Gear
  local Btn_D = Group_Gear.Btn_D
  local Btn_R = Group_Gear.Btn_R
  local Btn_B = Group_Gear.Btn_B
  local Btn_Accelerate = View.Group_OutSide.Group_Running.Btn_Accelerate
  local allBtn = {
    Btn_B,
    Btn_R,
    Btn_D
  }
  for i, v in ipairs(allBtn) do
    v:SetBtnInteractable(false)
  end
  Btn_Accelerate:SetBtnInteractable(true)
end

function Controller.RushDelayComplete()
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  local Btn_Accelerate = View.Group_OutSide.Group_Running.Btn_Accelerate
  Btn_Accelerate.Group_Ing:SetActive(true)
  Btn_Accelerate.Group_Ing.Group_RushTime:SetDynamicGameObject(DataModel.RushTimeBtnEffectPath, 0, 0)
  Btn_Accelerate.Group_Ing.Group_RushBuyBtn:SetDynamicGameObject(DataModel.RushBuyBtnEffectPath, 0, 0)
  Btn_Accelerate.Group_Ing.Group_RushBuyBtn:SetActive(true)
  Btn_Accelerate.Group_On:SetActive(false)
  Btn_Accelerate.Group_Off:SetActive(false)
end

local max = 0.9
local min = 0.1

function Controller.Rushing(remainTime, rushTime)
  DataModel.SetRushRemainTime(remainTime)
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    local Btn_Accelerate = View.Group_OutSide.Group_Running.Btn_Accelerate
    if 0 < remainTime then
      Btn_Accelerate.Group_Ing.Img_Bar:SetFilledImgAmount(math.max(min, (max - min) / rushTime * remainTime + min))
      local number = math.floor(remainTime)
      if DataModel.GetRushNumber() == nil then
        Btn_Accelerate.Group_Ing.Txt_Time:SetText(string.format("%02d", number))
        Btn_Accelerate.Group_Ing.Txt_Time2:SetText(string.format("%02d", number))
        DataModel.SetRushNumber(number)
      end
      if number < 0 then
        number = 0
      end
      if DataModel.GetRushNumber() == number then
        View.self:SelectPlayAnim(Btn_Accelerate.Group_Ing.self, "RushTime", function()
          Btn_Accelerate.Group_Ing.Txt_Time:SetText(string.format("%02d", number))
          Btn_Accelerate.Group_Ing.Txt_Time2:SetText(string.format("%02d", number))
        end)
        DataModel.SetRushNumber(DataModel.GetRushNumber() - 1)
      end
    else
      do
        local accelerate_num = PlayerData:GetHomeInfo().readiness.fuel.fuel_num
        DataModel.SetRushNumber()
        DataModel.SetRushRemainTime()
        DataModel.SetIsRushClick(false)
        if TradeDataModel.GetInTravel() then
          local isHave = 0 < accelerate_num
          Btn_Accelerate.Group_On:SetActive(isHave)
          Btn_Accelerate.Group_Off:SetActive(not isHave)
        end
        Btn_Accelerate.Group_On.Txt_Num:SetText(accelerate_num)
        Btn_Accelerate.Group_Off.Txt_Num:SetText(accelerate_num)
        Btn_Accelerate.Group_Ing:SetActive(false)
        Controller.SetRushEffectState(false)
        Controller.SetRushState(false)
        DataModel.isRun = true
      end
    end
  else
    DataModel.SetRushNumber()
  end
end

function Controller.StrikeSuccess(state)
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    if state then
      View.Group_OutSide.Group_Running.Group_StrikeEffect:SetDynamicGameObject(DataModel.TrainStrikeEffectPath, 0, 0)
    end
    View.Group_OutSide.Group_Running.Group_StrikeEffect:SetActive(state)
  end
end

function Controller.WeaponRush()
  local isShow = DataModel.GetIsWeaponRushShow()
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    local isHave = TrainWeaponTag.IsWeaponedById(83100032)
    View.Group_Common.Group_MB.Group_Lighting.self:SetActive(isShow or isHave)
    if isHave then
      local cfg = PlayerData:GetFactoryData(83100032, "HomeWeaponFactory")
      View.Group_Common.Group_MB.Group_Lighting:SetDynamicGameObject(cfg.specialEffects, 0, 0)
    end
    if isShow then
      View.Group_Common.Group_MB.Group_Lighting:SetDynamicGameObject(DataModel.TrainRushEffectPath, 0, 0)
    end
  end
  TrainManager:SetLightingEffect(isShow)
end

function Controller.WeaponRushOver()
  if UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    View.Group_Common.Group_MB.Group_Lighting.self:SetActive(false)
  end
end

function Controller.BackFunction()
  local cfg = PlayerData:GetFactoryData(TradeDataModel.StartCity)
  CommonTips.OnPrompt(string.format(GetText(80601505), cfg.name), "80600068", "80600067", function()
    Net:SendProto("station.arrive", function(json)
      DataModel.justArrived = true
      TradeDataModel.EndCity = TradeDataModel.StartCity
      PlayerData.FreeCameraIndex = 1
      PlayerData:GetHomeInfo().station_info = json.station_info
      DataModel.GetCurShowSceneInfo()
      TrainCameraManager:SetPostProcessing(1, DataModel.CurShowSceneInfo.postProcessingPath)
      if json.station_info and json.station_info.distance then
        PlayerData:GetHomeInfo().station_info.station_info = json.station_info.station_info
        TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.Refresh)
      else
        PlayerData.ServerData.user_home_info.station_info.stop_info = json.station_info.stop_info
        TrainManager:TravelOver()
        PlayerData.showPosterGirl = 1
        TradeDataModel.CurRemainDistance = 0
        Controller.SetSpeedShow(0)
        Controller.ArriveRefreshShow(json)
      end
      PlayerData:ClearPollute()
      if json.drive_distance then
        PlayerData:GetHomeInfo().drive_distance = json.drive_distance
      end
      if json.drive_time then
        PlayerData:GetHomeInfo().drive_time = json.drive_time
      end
      MapController:RefreshStationPos()
      MapController:RefreshViewToTrain()
      Controller.ShowEndActive(false)
      Controller.StrikeShow(false)
      Controller:ShowPosterGirl(false)
      View.Group_Common.Img_DialogBox:SetActive(false)
      MapNeedleData.ResetData()
    end, TradeDataModel.StartCity, 2)
  end, nil)
end

function Controller.StopPosterGirlAudioSource()
  View.timer:Pause()
  if View.sound and View.sound.audioSource then
    View.sound:Stop()
    View.Group_Common.Img_DialogBox:SetActive(false)
    DataModel.soundEndTime = 0
  end
end

return Controller
