local View = require("UIInsZone/UIInsZoneView")
local DataModel = require("UIInsZone/UIInsZoneDataModel")
local DataController = require("UIInsZone/UIInsZoneDataController")
local ViewFunction = {
  InsZone_Btn_Start_Click = function(btn, str)
    DataController.StartBattle(DataModel.nextLevelId, "Chapter")
  end,
  InsZone_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if MapNeedleEventData.openInsZone then
      local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
      local driveLine = TradeDataModel.GetDriveLine(PlayerData:GetHomeInfo().station_info)
      local stationCfg = PlayerData:GetFactoryData(driveLine[table.count(driveLine)].id, "HomeStationFactory")
      CommonTips.OnPrompt(string.format(GetText(80601975), stationCfg.name), "80600068", "80600067", function()
        local MainController = require("UIMainUI/UIMainUIController")
        local MainDataModel = require("UIMainUI/UIMainUIDataModel")
        Net:SendProto("station.arrive", function(json)
          MainDataModel.justArrived = true
          TradeDataModel.EndCity = TradeDataModel.StartCity
          PlayerData.FreeCameraIndex = 1
          PlayerData:GetHomeInfo().station_info = json.station_info
          MainDataModel.GetCurShowSceneInfo()
          TrainCameraManager:SetPostProcessing(1, MainDataModel.CurShowSceneInfo.postProcessingPath)
          TrainManager:TravelOver()
          PlayerData.showPosterGirl = 1
          TradeDataModel.CurRemainDistance = 0
          CommonTips.OpenLoadingCB(function()
            UIManager:Pause(false)
            CBus:ChangeScene("Main", function()
              UIManager:Open("UI/MainUI/MainUI")
              MainController.ShowAutoDriveTxt(false)
              MainController.BackShow(false)
              if json.fatigue then
                CommonTips.OpenFatigueTip(json.fatigue)
              end
            end)
          end)
          if json.drive_distance then
            PlayerData:GetHomeInfo().drive_distance = json.drive_distance
          end
          if json.drive_time then
            PlayerData:GetHomeInfo().drive_time = json.drive_time
          end
          MapNeedleEventData.ResetData()
          MapNeedleData.ResetData()
        end, TradeDataModel.StartCity, 2)
      end, nil)
      return
    end
    local ca = PlayerData:GetFactoryData(DataModel.chapterId, "ChapterFactory")
    if ca ~= nil and ca.saveProgress then
      DataController.GobackFunction()
    else
      local callBack = function()
        PlayerData:RefreshChapterSeverData()
        DataController.GobackFunction()
      end
      CommonTips.OnPrompt(80600206, nil, nil, callBack)
    end
  end,
  InsZone_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    local ca = PlayerData:GetFactoryData(DataModel.chapterId, "ChapterFactory")
    if ca ~= nil and ca.saveProgress then
      DataController.GoHomeFunction()
    else
      local callBack = function()
        PlayerData:RefreshChapterSeverData()
        DataController.GoHomeFunction()
      end
      CommonTips.OnPrompt(80600206, nil, nil, callBack)
    end
  end,
  InsZone_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  InsZone_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  InsZone_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end,
  InsZone_Prefab_Btn001_Click = function(btn, str)
    local BtnClueEnabled = View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_01.IsActive
    View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_01:SetActive(not BtnClueEnabled)
  end,
  InsZone_Prefab_Btn002_Click = function(btn, str)
    local BtnClueEnabled = View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_02.IsActive
    View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_02:SetActive(not BtnClueEnabled)
  end,
  InsZone_Prefab_Btn003_Click = function(btn, str)
    local BtnClueEnabled = View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_03.IsActive
    View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_03:SetActive(not BtnClueEnabled)
  end,
  InsZone_Prefab_Btn004_Click = function(btn, str)
    local BtnClueEnabled = View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_04.IsActive
    View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_04:SetActive(not BtnClueEnabled)
  end,
  InsZone_Prefab_Btn005_Click = function(btn, str)
    local BtnClueEnabled = View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_05.IsActive
    View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_05:SetActive(not BtnClueEnabled)
  end,
  InsZone_Prefab_Btn011_Click = function(btn, str)
    local BtnClueEnabled = View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_01.IsActive
    View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_01:SetActive(not BtnClueEnabled)
  end,
  InsZone_Prefab_Btn012_Click = function(btn, str)
    local BtnClueEnabled = View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_02.IsActive
    View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_02:SetActive(not BtnClueEnabled)
  end,
  InsZone_Prefab_Btn013_Click = function(btn, str)
    local BtnClueEnabled = View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_03.IsActive
    View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_03:SetActive(not BtnClueEnabled)
  end,
  InsZone_Prefab_Btn014_Click = function(btn, str)
    local BtnClueEnabled = View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_04.IsActive
    View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_04:SetActive(not BtnClueEnabled)
  end,
  InsZone_Prefab_Btn015_Click = function(btn, str)
    local BtnClueEnabled = View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_05.IsActive
    View.Prefab_Bg.Group_CommonTable.Btn_ClueBG_05:SetActive(not BtnClueEnabled)
  end
}
return ViewFunction
