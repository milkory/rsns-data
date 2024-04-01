local View = require("UIMainUI/UIMainUIView")
local Controller = require("UIMainUI/UIMainUIController")
local DataModel = require("UIMainUI/UIMainUIDataModel")
local NoticeDataModel = require("UINotice/UINoticeDataModel")
local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
local TradeController = require("UIHome/UIHomeTradeController")
local MapController = require("UIHome/UIHomeMapController")
local AdvDataModel = require("UIAdvMain/UIAdvMainDataModel")
local MapDataModel = require("UIHome/UIHomeMapDataModel")
local ViewFunction = {
  MainUI_Group_Common_Group_PosterGirl_Btn_ChangeAnimation_Click = function(btn, str)
    local isClick = View.Group_Common.Group_PosterGirl.SpineAnimation_Character:SetClickAction("click", function()
      View.Group_Common.Group_PosterGirl.SpineAnimation_Character:SetAction("idle", true, true)
    end)
    if isClick == true then
      local unit = PlayerData:GetRoleById(DataModel.roleId)
      local viewId = unit and unit.current_skin[1] or PlayerData:GetFactoryData(DataModel.roleId, "UnitFactory").viewId
      local live2D = PlayerData:GetPlayerPrefs("int", DataModel.roleId .. "live2d")
      if live2D ~= 1 then
        local receptionistData = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
        Controller:RefreshEffect(receptionistData)
      end
    end
    if PlayerData:GetHomeInfo().station_info.is_arrived == 2 or PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
      Controller:RandomPlayRoleSound()
    end
  end,
  MainUI_Group_Common_Group_PosterGirl_Btn_Change_Click = function(btn, str)
    DataModel:GetNextSoundTime()
    View.timer.delay = DataModel.nextDelay
    View.timer:Reset()
    local status = {
      btn = "Change",
      roleId = DataModel.roleId
    }
    Controller:ExitTo("UI/CharacterList/CharacterList", Json.encode(status), function()
      Controller:RandomPlayRoleSound(true)
    end)
  end,
  MainUI_Group_Common_Group_Navigation_Btn_Quest_Click = function(btn, str)
    Controller:ExitTo("UI/Quest/Quest")
  end,
  MainUI_Group_Common_Group_Navigation_Btn_Navigation_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_ScrollView_Map_Viewport_Content_ScrollGrid_Station_SetGrid = function(element, elementIndex)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_ScrollView_Map_Viewport_Content_ScrollGrid_Station_Group_Item_Btn_S1_Click = function(btn, str)
    MapController:ClickBtn(btn)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    MapController:ShowDetailMap(false)
    View.self:Confirm()
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    MapController:ShowDetailMap(false)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    local data = {helpId = 80301502}
    UIManager:Open("UI/Common/Group_Help", Json.encode(data))
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Btn_Map_Click = function(btn, str)
    MapController:ShowDetailMap(true)
  end,
  MainUI_Group_Common_Group_TopLeft_Btn_ProfilePhoto_Click = function(btn, str)
    if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Adjutant then
      Controller:ExitTo("UI/MainUI/ESC", Json.encode({showAdjutantBg = true}))
    else
      Controller:ExitTo("UI/MainUI/ESC")
    end
    DataModel.MainToESC = true
  end,
  MainUI_Group_Common_Group_TopLeft_Btn_Gold_Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Store_Click = function(btn, str)
    local a, b = PlayerData:OpenStoreCondition()
    if a == false then
      CommonTips.OpenTips(b[1].txt)
      return
    end
    Net:SendProto("shop.info", function(json)
      Controller:ExitTo("UI/Store/Store", Json.encode(json))
    end)
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Headhunt_Click = function(btn, str)
    Controller:ExitTo("UI/Gacha/GachaNew")
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Mission_Click = function(btn, str)
    Net:SendProto("quest.list", function(json)
      PlayerData.ServerData.quests = json.quests
      Controller:ExitTo("UI/BP_Quest/BattlePass_Quest")
    end, EnumDefine.QuestListDefine.BattlePassQuest)
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Member_Click = function(btn, str)
    local status = {btn = "Member", roleId = ""}
    Controller:ExitTo("UI/CharacterList/CharacterList", Json.encode(status))
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Squads_Click = function(btn, str)
    local status = {
      Current = "MainUI",
      hasOpenThreeView = false,
      squadIndex = PlayerData.BattleInfo.squadIndex
    }
    PlayerData.Last_Chapter_Parms = nil
    Controller:ExitTo("UI/Squads/Squads", Json.encode(status))
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Depot_Click = function(btn, str)
    Controller:ExitTo("UI/Depot/Depot")
  end,
  MainUI_Group_Coach_Btn_Decorate_Click = function(btn, str)
    PlayerData.TempCache.BeginDecorateTimeStamp = TimeUtil:GetServerTimeStamp()
    UIManager:Open("UI/Home/HomeCoach")
  end,
  MainUI_Group_OutSide_Group_Station_Btn_SellG_Click = function(btn, str)
    TradeController:SaleGarbage()
  end,
  MainUI_Group_OutSide_Group_Station_Btn_HandleG_Click = function(btn, str)
    if not PlayerData.IsSolicitFunOpen() then
      CommonTips.OpenFlierConditionTips({
        showType = EnumDefine.FlierConditionShowType.functionLock,
        stationId = TradeDataModel.EndCity
      })
      return
    end
    Net:SendProto("station.psg_source_info", function(json)
      PlayerData.SolicitData.leafletNum = json.own_leaflet
      PlayerData.SolicitData.copyLeafletNum = json.add_leaflet
      for i, v in pairs(json.leaflet_location) do
        PlayerData.SolicitData.stationSendPosList[v] = v
      end
      PlayerData.SolicitData.magazineSendNum = json.mgz_num
      PlayerData.SolicitData.magazinePool = json.mgz_pool
      PlayerData.SolicitData.tvSendNum = json.tv_num
      PlayerData.SolicitData.tvPool = json.tv_pool
      UIManager:Open("UI/Flier/FlierMain", Json.encode({
        StationId = TradeDataModel.EndCity
      }))
    end)
  end,
  MainUI_Group_OutSide_Group_Station_Btn_Build_Click = function(btn, str)
    local funcCommon = require("Common/FuncCommon")
    if not funcCommon.FuncActiveCheck(108, true) then
      return
    end
    CommonTips.OpenToHomeCarriageeditor()
  end,
  MainUI_Btn_ShowUI_Click = function(btn, str)
    if Controller.forbidShow ~= true then
      Controller:ReShowUI()
    end
  end,
  MainUI_Group_OutSide_Group_Running_Btn_Horn_Click = function(btn, str)
  end,
  MainUI_Group_OutSide_Group_Running_Btn_Accelerate_Click = function(btn, str)
    if PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 then
      CommonTips.OpenTips(80601262)
      return
    end
    Controller.Rush()
  end,
  MainUI_Group_OutSide_Group_Running_Group_Gear_Btn_D_Click = function(btn, str)
    if PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 then
      CommonTips.OpenTips(80601262)
      return
    end
    Controller.Drive()
  end,
  MainUI_Group_OutSide_Group_Running_Group_Gear_Btn_B_Click = function(btn, str)
    if PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 then
      CommonTips.OpenTips(80601262)
      return
    end
    Controller.Stop()
  end,
  MainUI_Group_OutSide_Group_Running_Group_Gear_Btn_R_Click = function(btn, str)
    if PlayerData:GetHomeInfo().readiness.repair.current_durable == 0 then
      CommonTips.OpenTips(80601262)
      return
    end
    PlayerData:SetPlayerPrefs("int", "IsStop", 0)
    Controller.Astern()
  end,
  MainUI_Group_OutSide_Group_Running_Btn_Mask_Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_PosterGirl_Btn_GetTrust_Click = function(btn, str)
    Net:SendProto("main.rec_trust", function(json)
      PlayerData:GetRoleById(DataModel.roleId).trust_exp = json.trust_exp
      PlayerData:GetRoleById(DataModel.roleId).trust_lv = json.trust_lv
      PlayerData:GetUserInfo().receptionist_ts = json.user_info.receptionist_ts
      CommonTips.OpenTips(80600757)
      View.Group_Common.Group_PosterGirl.Btn_GetTrust:SetActive(false)
    end)
  end,
  MainUI_Btn_Launch_Click = function(btn, str)
    MapController:ShowDetailMap(true)
  end,
  MainUI_Group_OutSide_Group_Station_Btn_Visit_Click = function(btn, str)
    CommonTips.OpenTips("功能开发中")
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_Energy_Btn_Energy_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_ScrollView_Map_Viewport_Content_Btn_Close_Click = function(btn, str)
    MapDataModel.CurSelectedId = 0
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.ScrollView_Map.Viewport.Content.Img_Selected:SetActive(false)
    View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_StationInfo.self:SelectPlayAnim("StationInfoOut")
  end,
  MainUI_Group_Adjutant_Btn_Achieve_Click = function(btn, str)
    Controller:ExitTo("UI/Achievement/Achievement")
  end,
  MainUI_Group_Adjutant_Btn_TrainOverview_Click = function(btn, str)
    if PlayerData:GetRoleById(DataModel.roleId).resonance_lv == 5 and DataModel.RoleData.current_skin[2] == 1 then
      Controller:ExitTo("UI/DriveLog/DriveLog")
    else
      View.self:SetEnableAnimator(true)
      View.self:PlayAnim("OutMove")
      UIManager:Open("UI/DriveLog/DriveLog", "isMainUI")
    end
    View.timer:Pause()
  end,
  MainUI_Group_Adjutant_Btn_DrivingLog_Click = function(btn, str)
    Net:SendProto("plot.info", function(json)
      Controller:ExitTo("UI/PlotReview/PlotReview", Json.encode(json.plot_paragraph))
    end)
  end,
  MainUI_Group_Common_Btn_Enter_Click = function(btn, str)
    Net:SendProto("station.arrive", function(json)
      DataModel.justArrived = true
      PlayerData:GetHomeInfo().station_info = json.station_info
      DataModel.GetCurShowSceneInfo()
      TrainCameraManager:SetPostProcessing(1, DataModel.CurShowSceneInfo.postProcessingPath)
      if json.station_info and json.station_info.distance then
        PlayerData:GetHomeInfo().station_info.station_info = json.station_info.station_info
        TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.Refresh)
      else
        PlayerData.ServerData.user_home_info.station_info.stop_info = json.station_info.stop_info
        TrainManager:TravelOver()
        TradeDataModel.CurRemainDistance = 0
        PlayerData.showPosterGirl = 1
        Controller.SetSpeedShow(0)
        Controller.ArriveRefreshShow(json)
      end
      PlayerData:ClearPollute()
      Controller.ShowEndActive(false)
      View.Group_Common.Img_DialogBox:SetActive(false)
      MapNeedleData.ResetData()
    end, TradeDataModel.EndCity)
  end,
  MainUI_Group_Common_Btn_Leave_Click = function(btn, str)
    MapController:ShowDetailMap(true)
  end,
  MainUI_Btn_City_Click = function(btn, str)
    if TradeDataModel.GetIsTravel() then
      return
    end
    local homeCommon = require("Common/HomeCommon")
    homeCommon.TimeCheckRefreshStationInfo(nil, function()
      local t = {}
      t.stationId = TradeDataModel.EndCity
      Controller:ExitTo("UI/CityMap/CityMap", Json.encode(t))
    end)
  end,
  MainUI_Btn_Dungeon_Click = function(btn, str)
    local HomeCommon = require("Common/HomeCommon")
    local stateInfo = HomeCommon.GetCityStateInfo(TradeDataModel.EndCity)
    if stateInfo ~= nil and stateInfo.dungeonId > 0 then
      local status = {}
      status.chapterId = stateInfo.dungeonId
      status.startNew = true
      PlayerData.Last_Chapter_Parms = {
        chapterId = status.chapterId,
        Current = "MainUI"
      }
      PlayerData.BattleCallBackPage = "UI/InsZone/InsZone"
      UIManager:Open("UI/InsZone/InsZone", Json.encode(status))
    end
  end,
  MainUI_Group_OutSide_Group_Running_Btn_Camera_Click = function(btn, str)
    DataModel.SetCamera()
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_Loadage_Btn_Icon_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_Loadage_Btn_Add_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_HomeEnergy_Btn_Icon_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_HomeEnergy_Btn_Add_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.OpenMoveEnergyUseItem(function()
      homeCommon.SetMoveEnergyElement(View.Group_Common.SoftMask_HomeMap.Group_HomeMap.Group_HomeEnergy)
    end)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  MainUI_Group_Coach_Group_QuickJump_Btn_DecorateOFF_Click = function(btn, str)
    if View.Group_Coach.Img_Control.self.IsActive then
      View.Group_Coach.Btn_Manager:SetBtnInteractable(false)
      View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(false)
      View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(false)
      View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(false)
      Controller.ShowManagerTool(false, function()
        Controller.ShowCoachQuickJump(true, function()
          View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(true)
          View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(true)
          View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(true)
          View.Group_Coach.Btn_Manager:SetBtnInteractable(true)
        end)
      end)
      return
    end
    Controller.ShowCoachQuickJump(true)
  end,
  MainUI_Group_Coach_Group_QuickJump_Btn_Close_Click = function(btn, str)
    View.Group_Coach.Btn_Manager:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(false)
    Controller.ShowCoachQuickJump(false, function()
      View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(true)
      View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(true)
      View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(true)
      View.Group_Coach.Btn_Manager:SetBtnInteractable(true)
    end)
  end,
  MainUI_Group_Coach_Group_QuickJump_Btn_DecorateON_Click = function(btn, str)
    View.Group_Coach.Btn_Manager:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(false)
    Controller.ShowCoachQuickJump(false, function()
      View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(true)
      View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(true)
      View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(true)
      View.Group_Coach.Btn_Manager:SetBtnInteractable(true)
    end)
  end,
  MainUI_Group_Coach_Group_QuickJump_Group_Windows_Group_train_Btn_train_Click = function(btn, str)
  end,
  MainUI_Group_Coach_Group_QuickJump_Group_Windows_Img_Base_StaticGrid_Train_SetGrid = function(element, elementIndex)
    if elementIndex > DataModel.MaxCoachNum then
      element:SetActive(false)
      return
    end
    element:SetActive(true)
    local isEmpty = not PlayerData:GetHomeInfo().coach[elementIndex]
    table.insert(DataModel.JumpRoomCtrList, element)
    if not isEmpty then
      local beforeCantEnterRoomCount = DataModel.GetBeforeCantEnterRoomCount(elementIndex)
      local roomIndex = elementIndex - beforeCantEnterRoomCount - 1
      if roomIndex == HomeManager.camRoom then
        DataModel.SelectJumpRoomCtr = element
      end
      local id = PlayerData:GetHomeInfo().coach[elementIndex].id
      local coachCA = PlayerData:GetFactoryData(id, "HomeCoachFactory")
      local typeCA = PlayerData:GetFactoryData(coachCA.coachType, "TagFactory")
      if typeCA.stopCarriage then
        DataModel.CurBanEnterCoachCount = DataModel.CurBanEnterCoachCount + 1
        element.Btn_train:SetClickParam(-1)
      else
        element.Btn_train:SetClickParam(elementIndex)
      end
      element.Btn_train.Img_Select:SetActive(roomIndex == HomeManager.camRoom and not typeCA.stopCarriage)
      element.Btn_train.Img_UnSelect:SetActive(roomIndex ~= HomeManager.camRoom or typeCA.stopCarriage)
      element.Btn_train.Img_Select.Img_Icon:SetSprite(typeCA.skipJumpIcon)
      element.Btn_train.Img_UnSelect.Img_Icon:SetSprite(typeCA.skipJumpIcon)
      local showTxt = string.format("%02d", elementIndex)
      element.Btn_train.Img_Empty.Txt_Empty:SetText(showTxt)
      element.Btn_train.Img_Select.Txt_Select:SetText(showTxt)
      element.Btn_train.Img_UnSelect.Txt_UnSelect:SetText(showTxt)
      element.Btn_train.Img_Empty:SetActive(false)
    else
      element.Btn_train.Img_Empty:SetActive(true)
      element.Btn_train.Img_Select:SetActive(false)
      element.Btn_train.Img_UnSelect:SetActive(false)
      element.Btn_train:SetClickParam(elementIndex)
    end
  end,
  MainUI_Group_Coach_Group_QuickJump_Group_Windows_Img_Base_StaticGrid_Train_Group_train_Btn_train_Click = function(btn, str)
    local idx = tonumber(str)
    if idx == -1 then
      CommonTips.OpenTips(80601145)
      return
    end
    if idx > #PlayerData:GetHomeInfo().coach then
      return
    end
    local beforeCantEnterRoomCount = DataModel.GetBeforeCantEnterRoomCount(idx)
    if idx - beforeCantEnterRoomCount - 1 == HomeManager.camRoom then
      return
    end
    MainManager:SetTrainViewFilter(30, false)
    HomeManager:OpenHome(idx - beforeCantEnterRoomCount - 1)
    if DataModel.SelectJumpRoomCtr then
      DataModel.SelectJumpRoomCtr.Btn_train.Img_Select:SetActive(false)
      DataModel.SelectJumpRoomCtr.Btn_train.Img_UnSelect:SetActive(true)
    end
    if DataModel.JumpRoomCtrList[idx] then
      DataModel.JumpRoomCtrList[idx].Btn_train.Img_Select:SetActive(true)
      DataModel.JumpRoomCtrList[idx].Btn_train.Img_UnSelect:SetActive(false)
      DataModel.SelectJumpRoomCtr = DataModel.JumpRoomCtrList[idx]
    end
  end,
  MainUI_Group_Common_Group_MB_BtnPolygon_Adjutant_Click = function(btn, str)
    Controller.StopPosterGirlAudioSource()
    if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.OutSide then
      View.self:PlayAnim("OToA")
    elseif PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Coach then
      View.self:PlayAnim("CToA")
    end
    Controller:SwitchTab(DataModel.UIShowEnum.Adjutant, true)
  end,
  MainUI_Group_Common_Group_MB_BtnPolygon_OutSide_Click = function(btn, str)
    Controller.StopPosterGirlAudioSource()
    if DataModel.CurSceneName == DataModel.SceneNameEnum.Main then
      if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Adjutant then
        View.self:PlayAnim("AToO")
      end
      Controller:SwitchTab(DataModel.UIShowEnum.OutSide, true)
      return
    else
      PlayerData.TempCache.MainUIShowState = DataModel.UIShowEnum.OutSide
    end
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
      CommonTips.OpenLoadingCB(function()
        UIManager:Pause(false)
        CBus:ChangeScene("Main")
      end)
    end))
  end,
  MainUI_Group_Common_Group_MB_BtnPolygon_Coach_Click = function(btn, str)
    local funcCommon = require("Common/FuncCommon")
    if not funcCommon.FuncActiveCheck(106, true) then
      return
    end
    Controller.StopPosterGirlAudioSource()
    if DataModel.CurSceneName == DataModel.SceneNameEnum.Home then
      if PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Adjutant then
        View.self:PlayAnim("AToC")
      end
      Controller:SwitchTab(DataModel.UIShowEnum.Coach, true)
      return
    else
      PlayerData.TempCache.MainUIShowState = DataModel.UIShowEnum.Coach
    end
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.5))
      local cb = function()
        SafeReleaseScene(false)
        CBus:ChangeScene("Home")
        GameSetting:LoadPlayerSetting()
        PlayerData:ResetCharacterFilter()
        PlayerData:ResetSuaqsFilter()
        PlayerData:ResetDepotFilter()
      end
      local loadingConfig = PlayerData:GetFactoryData(99900036, "ConfigFactory")
      local randomNum = math.random(1, #loadingConfig.enterHomeUIList)
      CommonTips.OpenLoading(nil, "", loadingConfig.enterHomeUIList[randomNum].imagePath, cb)
    end))
    DataModel.IsGoHomeCoach = true
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Group_Goods_ScrollGrid_GoodsList_SetGrid = function(element, elementIndex)
    local info = MapDataModel.CurShowList[elementIndex]
    local goodsCA = PlayerData:GetFactoryData(info.id, "HomeGoodsFactory")
    element.Img_Item:SetSprite(goodsCA.imagePath)
    element.Btn_Item:SetClickParam(elementIndex)
    element.Img_Bottom:SetSprite(UIConfig.BottomConfig[goodsCA.qualityInt + 1])
    element.Img_Mask:SetSprite(UIConfig.MaskConfig[goodsCA.qualityInt + 1])
    element.Img_Specialty:SetActive(info.isSpecial)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Group_Goods_ScrollGrid_GoodsList_Group_Item_Btn_Item_Click = function(btn, str)
    local info = MapDataModel.CurShowList[tonumber(str)]
    local data = {}
    data.goodsId = info.id
    data.goodsType = 1
    UIManager:Open("UI/Common/GoodsTips", Json.encode(data))
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_Go_Click = function(btn, str)
    Controller.GoToNewCity()
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_BuyRush_Click = function(btn, str)
    local cfg = PlayerData:GetFactoryData("99900007")
    local max = PlayerData.GetMaxFuelNum()
    if PlayerData:GetHomeInfo().readiness.fuel.fuel_num == max then
      CommonTips.OpenTips(80600795)
    else
      UIManager:Open("UI/Common/BuyRushTips")
    end
  end,
  MainUI_Group_Common_Btn_Help_Click = function(btn, str)
    local curr
    for i = TrainManager.TrainCtrl.FirstTrain.PathIndex + 1, 1, -1 do
      local v = TradeDataModel.Path[i]
      if PlayerData:GetHomeInfo().stations[tostring(v.beginId)].is_unlock == 1 then
        curr = v
        break
      end
    end
    if curr then
      local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
      local trainHelpCost = homeConfig.trainHelpCost
      local passDistance
      if curr.isForward then
        passDistance = TrainManager.TrainCtrl.FirstTrain.Position
      else
        passDistance = curr.length - TrainManager.TrainCtrl.FirstTrain.Position
      end
      DataModel.TrailerCityId = curr.beginId
      CommonTips.OnPrompt(string.format(GetText(80601304), math.floor(passDistance * trainHelpCost)), GetText(80600068), GetText(80600067), function()
        local t = {
          [1] = homeConfig.trainHelpLook
        }
        PlayerData.TempCache.IsHelp = true
        local cfg = PlayerData:GetFactoryData(DataModel.TrailerCityId, "HomeStationFactory")
        
        function PlayerData.TempCache.TrailerFinishCb()
          Train.TrailerStop()
        end
        
        View.Group_Common.Btn_Help.self:SetActive(false)
        Controller.BackShow(false)
        UIManager:Open(UIPath.UIDialog, Json.encode({
          id = cfg.trainHelpChat
        }))
      end, function()
        print_r("cancel")
      end, true)
    end
  end,
  MainUI_Group_Common_Btn_HideUI_Click = function(btn, str)
    Controller:HideAll()
  end,
  MainUI_Group_Common_Btn_HidePosterGirl_Click = function(btn, str)
    local isShow = View.Group_Common.Group_PosterGirl.self.IsActive
    if PlayerData.TempCache.MainUIShowState ~= DataModel.UIShowEnum.Adjutant then
      PlayerData.showPosterGirl = not isShow and 1 or -1
    end
    Controller:ShowPosterGirl(not isShow, PlayerData.TempCache.MainUIShowState == DataModel.UIShowEnum.Adjutant)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_PassengerCapacity_Btn_Add_Click = function(btn, str)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_PassengerCapacity_Btn_Icon_Click = function(btn, str)
  end,
  MainUI_Group_OutSide_Group_Running_Btn_Light_Click = function(btn, str)
    Controller:OpenLight()
  end,
  MainUI_Group_Common_Group_Back_Btn_Fight_Click = function(btn, str)
    Controller.BackFunction()
  end,
  MainUI_Group_Common_Group_TopLeft_Group_Buff_Img_BuffSpeed_Btn__Click = function(btn, str)
    DataModel.ShowHomeBuffTips()
  end,
  MainUI_Group_Common_Group_TopLeft_Group_Buff_Img_Buff_Btn__Click = function(btn, str)
    DataModel.ShowHomeBuffTips()
  end,
  MainUI_Group_Park_Btn_Park_Click = function(btn, str)
  end,
  MainUI_Group_Park_Btn_Start_Click = function(btn, str)
  end,
  MainUI_Group_Coach_Btn_Manager_Click = function(btn, str)
    if View.Group_Coach.Group_QuickJump.Btn_Close.IsActive then
      View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(false)
      View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(false)
      View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(false)
      View.Group_Coach.Btn_Manager:SetBtnInteractable(false)
      Controller.ShowCoachQuickJump(false, function()
        Controller.ShowManagerTool(not View.Group_Coach.Img_Control.self.IsActive, function()
          View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(true)
          View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(true)
          View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(true)
          View.Group_Coach.Btn_Manager:SetBtnInteractable(true)
        end)
      end)
      return
    end
    View.Group_Coach.Btn_Manager:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(false)
    View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(false)
    Controller.ShowManagerTool(not View.Group_Coach.Img_Control.self.IsActive, function()
      View.Group_Coach.Group_QuickJump.Btn_DecorateON:SetBtnInteractable(true)
      View.Group_Coach.Group_QuickJump.Btn_DecorateOFF:SetBtnInteractable(true)
      View.Group_Coach.Group_QuickJump.Btn_Close:SetBtnInteractable(true)
      View.Group_Coach.Btn_Manager:SetBtnInteractable(true)
    end)
  end,
  MainUI_Group_Coach_Img_Control_Btn_PetManage_Click = function(btn, str)
    UIManager:Open("UI/HomePet/PetManage")
  end,
  MainUI_Group_Coach_Img_Control_Btn_Passenger_Click = function(btn, str)
    if not PlayerData.IsPassageFunOpen() then
      CommonTips.OpenTips(80601642)
      return
    end
    UIManager:Open("UI/Passenger/Passenger")
  end,
  MainUI_Group_Common_Group_PosterGirl_Btn_FestivalGift_Click = function(btn, str)
    local index = PlayerData:GetCurFestivalIndex()
    PlayerData:GetFestivalRewards(index)
  end,
  MainUI_Group_Common_Group_Event_Group_Fight_BtnPolygon_Fight_Click = function(btn, str)
    Controller.Battle()
  end,
  MainUI_Group_Common_Group_Event_Group_Strike_BtnPolygon_Strike_Click = function(btn, str)
    if PlayerData.IsEnergyEnough() then
      TrainManager:ChangeStrikeState(StrikeState.Start)
    else
      CommonTips.OpenTips(80600541)
    end
  end,
  MainUI_Group_Common_Group_Event_Group_Buy_BtnPolygon_Buy_Click = function(btn, str)
    Controller.SpendMoneyBuyRoad()
  end,
  MainUI_Group_Common_Group_Event_Group_Balloon_BtnPolygon_Balloon_Click = function(btn, str)
    if DataModel.TrainEventAreaId then
      UIManager:Open("UI/MainUI/BalloonChoose", Json.encode({
        eventId = DataModel.TrainEventId,
        lineId = DataModel.TrainLineId,
        areaId = DataModel.TrainEventAreaId
      }))
    else
      UIManager:Open("UI/MainUI/BalloonChoose", Json.encode({
        eventId = DataModel.TrainEventId,
        lineId = DataModel.TrainLineId
      }))
    end
  end,
  MainUI_Group_Common_Group_MB_Btn_Electric_Click = function(btn, str)
    Controller:ExitTo("UI/Home/HomeElectric")
  end,
  MainUI_Group_Common_Btn_ClickFight_Click = function(btn, str)
    Train.CloseLevelEventIndexUI()
    if PlayerData.IsQuestComplete(81000001) == false or PlayerData.IsQuestComplete(81000712) == false then
      PlayerData.TempCache.EventIndex = nil
      CommonTips.OpenTips(80601979)
      return
    end
    Controller.ImmediatelyStop()
    Controller.Battle()
  end,
  MainUI_Group_Common_Group_TopRight_Btn_Activity_Click = function(btn, str)
    UIManager:Open("UI/SignIn/SignIn")
  end,
  MainUI_Group_Common_Group_TopRight_Btn_ActivityNew_Click = function(btn, str)
    UIManager:Open("UI/Activity/ActivityMain")
  end,
  MainUI_Group_Common_Group_Event_Group_Back_Btn_Fight_Click = function(btn, str)
    Controller.BackFunction()
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_Trailer_Click = function(btn, str)
    local trailerUnlock = PlayerData:GetFactoryData(99900060, "ConfigFactory").trailerUnlock
    if trailerUnlock > PlayerData:GetUserInfo().lv then
      CommonTips.OpenTips(80602348)
      return
    end
    local max = PlayerData.GetMaxTrailerNum()
    if PlayerData:GetHomeInfo().req_back_num == 0 then
      CommonTips.OpenTips(80602289)
    else
      local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
      local distance = math.ceil(MapDataModel.GetTargetStationDistance(MapDataModel.CurSelectedId) * homeConfig.disRatio)
      UIManager:Open("UI/MainUI/TrailerPrompt", tostring(distance))
    end
  end,
  MainUI_Group_Common_Group_TopLeft_Group_Buff_Img_BuffBattle_Btn__Click = function(btn, str)
    DataModel.ShowHomeBuffTips()
  end,
  MainUI_Btn_AdBoard_Click = function(btn, str)
    local a, b = PlayerData:OpenStoreCondition()
    if a == false then
      CommonTips.OpenTips(b[1].txt)
      return
    end
    Net:SendProto("shop.info", function(json)
      local recharge = PlayerData.RechargeGoods[tostring(40300008)]
      if recharge and recharge[tostring(82100027)] and recharge[tostring(82100027)].num > 0 then
        if View.Group_Common.Group_TopRight.Btn_Headhunt.self.IsActive then
          Controller:ExitTo("UI/Gacha/GachaNew")
        end
      elseif View.Group_Common.Group_TopRight.Btn_Store.self.IsActive then
        json.index = 3
        json.subIndex = 82100027
        Controller:ExitTo("UI/Store/Store", Json.encode(json))
      end
    end)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_StationInfo_Btn_DriveSetup_Click = function(btn, str)
    UIManager:Open("UI/MainUI/DriveSetup")
  end,
  MainUI_Group_Common_Group_PosterGirl_Btn_ChangeAnimation2_Click = function(btn, str)
    if PlayerData:GetHomeInfo().station_info.is_arrived == 2 or PlayerData:GetHomeInfo().station_info.is_arrived == 0 then
      Controller:RandomPlayRoleSound()
    end
  end,
  MainUI_Group_Common_Group_BroadCast_Group_BG_Group_Upper_Group_TopRight_Btn_Close_Click = function(btn, str)
  end,
  MainUI_Group_Common_Group_Fight_Btn_Mask_Click = function(btn, str)
    View.self:PlayAnimOnce("BattleEnd", function()
      Controller:TrainEvent()
    end)
  end,
  MainUI_Group_Common_SoftMask_HomeMap_Group_HomeMap_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end,
  MainUI_Group_Common_Group_TopLeft_Img_Buff_Btn__Click = function(btn, str)
    local drinkBuff = PlayerData:GetCurDrinkBuff()
    if drinkBuff ~= nil then
      local t = {}
      t.posX = -479
      t.posY = -322
      t.drinkBuff = drinkBuff
      UIManager:Open("UI/Common/HomeBuff", Json.encode(t))
    end
  end,
  MainUI_Group_Common_Btn_Fight_Click = function(btn, str)
    Controller.Battle()
  end,
  MainUI_Group_Resources_Group_Energy_Btn_ResourceEnergy_Click = function(btn, str)
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local homeCommon = require("Common/HomeCommon")
    local t = {}
    t.refreshTime = PlayerData:GetUserInfo().move_energy_time
    t.maxValue = homeCommon.GetMaxHomeEnergy()
    t.curValue = PlayerData:GetUserInfo().move_energy
    t.onceTime = homeConfig.homeEnergyAddCD
    t.onceAdd = homeConfig.homeEnergyAdd
    t.textId = 80600412
    CommonTips.OpenExplain(homeConfig.homeEnergyItemId, {x = 540, y = 290}, t)
  end,
  MainUI_Btn_Adv_Click = function(btn, str)
    Net:SendProto("adventure.adv_info", function(json)
      local levelCA = PlayerData:GetFactoryData(json.advId, "AdvLevelFactory")
      PlayerPrefs.SetString("MapName", levelCA.mapPath)
      AdvDataModel:Reset()
      AdvDataModel.digItem = json.digItem
      print_r("挖掘数据")
      print_r(DataModel.digItem)
      local cb = function()
        CBus:ChangeScene("Endless")
      end
      CommonTips.OpenLoading(cb, "UI/Home/HomeLoading")
    end)
  end
}
return ViewFunction
