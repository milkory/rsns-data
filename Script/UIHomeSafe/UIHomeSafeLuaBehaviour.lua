local View = require("UIHomeSafe/UIHomeSafeView")
local DataModel = require("UIHomeSafe/UIHomeSafeDataModel")
local rewardDataModel = require("UIHomeSafe/UIRewardDataModel")
local Controller = require("UIHomeSafe/UIHomeSafeController")
local RewardController = require("UIHomeSafe/UIRewardController")
local RouteLevelController = require("UIHomeSafe/UIRouteLevelController")
local ViewFunction = require("UIHomeSafe/UIHomeSafeViewFunction")
local Timer = require("Common/Timer")
local RouteLevelDataModel = require("UIHomeSafe/UIRouteLevelDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local t = Json.decode(initParams)
      DataModel.BuildingId = t.buildingId
      DataModel.IsCityMapIn = t.isCityMapIn
      local buildingCA = PlayerData:GetFactoryData(DataModel.BuildingId, "BuildingFactory")
      DataModel.StationId = buildingCA.stationId
      DataModel.NpcId = buildingCA.npcId
      DataModel.BgPath = buildingCA.bgPath
      DataModel.BgColor = buildingCA.bgColor or "FFFFFF"
      DataModel.BgColor = "#" .. DataModel.BgColor
      DataModel.InitDayRefreshTime()
      DataModel.CheckRefreshChecked()
      Controller:Init(true)
      if t.autoShowLevel == 1 then
        Controller:ClickShowLevelPanel()
      elseif t.autoShowLevel == 2 then
        RewardController:ClickShowRewardPanel()
      elseif t.autoShowLevel == 3 then
        RouteLevelController.OpenReportPanel()
      else
        DataModel.curLevelSelectIdx = 1
        View.self:PlayAnim("In")
        View.Group_Ding:SetActive(false)
        View.Group_Zhu:SetActive(false)
      end
    else
      Controller:Init()
      if View.Group_Level.self.IsActive then
        Controller:ShowLevelPanel()
      elseif View.Group_XS.self.IsActive then
        RewardController:SelectIdx(rewardDataModel.CurSelectIdx, true)
      elseif View.Group_Report.self.IsActive then
        if View.Group_Report.Group_OnlineList.self.IsActive then
          RouteLevelController.ShowOnlineInfo()
        elseif View.Group_Report.Group_PersonalList.self.IsActive then
          RouteLevelController.ShowPersonalInfo()
        end
      else
        View.self:PlayAnim("In")
      end
    end
  end,
  awake = function()
    View.timer = Timer.New(1, function()
      if View.Group_Report.self ~= nil then
        RouteLevelDataModel.refreshTimer = RouteLevelDataModel.refreshTimer - 1
        View.Group_Report.Group_OnlineList.Group_Bottom.Group_Refresh.Group_Unable.Txt_Time:SetText(RouteLevelDataModel.refreshTimer)
        if RouteLevelDataModel.refreshTimer == 0 then
          View.Group_Report.Group_OnlineList.Group_Bottom.Group_Refresh.Group_Able:SetActive(true)
          View.Group_Report.Group_OnlineList.Group_Bottom.Group_Refresh.Group_Unable:SetActive(false)
          RouteLevelDataModel.refreshOnlienData = true
          View.timer:Pause()
          RouteLevelDataModel.refreshTimer = 3
        end
      end
    end)
  end,
  start = function()
  end,
  update = function()
    Controller:Update()
    if View.timer then
      View.timer:Update()
    end
    Controller:UpdateSliderView()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    QuestProcess.RemoveQuestCallBack(View.self.url)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
