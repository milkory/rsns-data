local View = require("UISquads/UISquadsView")
local ViewFunction = require("UISquads/UISquadsViewFunction")
local DataController = require("UISquads/UISquadsDataController")
local CharacterSelectController = require("UISquads/UISquadsCharacterSelectController")
local CardPollController = require("UISquads/UISquadsCardPoolController")
local DataModel = require("UISquads/UISquadsDataModel")
local LevelChainController = require("UISquads/UISquadsLevelChain")
local SquadController = require("UISquads/Controller_Squad")
local DataDetail = require("UISquads/UISquadsDetail")
local Luabehaviour = {
  serialize = function()
    DataController:ClearGridProperty(View.StaticGrid_List.grid)
    DataModel.hasOpenThreeView = false
    local status = {}
    if PlayerData.SquadsTempData then
      status = PlayerData.SquadsTempData
    end
    status.curSquadIndex = DataModel.curSquadIndex
    if DataModel.curLevelId ~= nil then
      local levelCA = PlayerData:GetFactoryData(DataModel.curLevelId)
      if levelCA ~= nil and levelCA.paragraphId > 0 then
        status.dialogueEnd = true
      end
    end
    return Json.encode(status)
  end,
  deserialize = function(initParams)
    DataController:ClearGridProperty(View.StaticGrid_List.grid)
    local MainDataModel = require("UIMainUI/UIMainUIDataModel")
    if MainDataModel.TrainEventId then
      local event = PlayerData:GetFactoryData(MainDataModel.TrainEventId, "AFKEventFactory")
      if event.isStoryStart then
        View.Group_CommonTopLeft.self:SetActive(false)
      else
        View.Group_CommonTopLeft.self:SetActive(true)
      end
    else
      View.Group_CommonTopLeft.self:SetActive(true)
    end
    View.Group_Detail.self:SetActive(false)
    View.Group_EquipSelected.self:SetActive(false)
    View.Group_ProvingGround.self:SetActive(false)
    View.Btn_Mask:SetActive(false)
    DataModel.RoleExpList = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
    DataModel.LastRoleIndex = nil
    local status
    PlayerData.currentSquad = {}
    PlayerData.SquadsTempData = nil
    DataModel.InitParams = {}
    if initParams ~= nil and initParams ~= "" then
      status = Json.decode(initParams)
      DataModel.InitParams = status
      DataModel.InitParams.EventIndex = PlayerData.TempCache.EventIndex or status.EventIndex
      DataModel.InitParams.NextDistance = PlayerData.TempCache.NextDistance or status.NextDistance
      DataModel.InitParams.Sid = PlayerData.TempCache.Sid or status.Sid
      PlayerData.SquadsTempData = DataModel.InitParams
    end
    if status ~= nil and status.levelId ~= nil then
      PlayerData.BattleInfo.battleStageId = status.levelId
    end
    if status ~= nil and status.callbackPage ~= nil then
      PlayerData.BattleCallBackPage = status.callbackPage
    end
    DataModel.curSelectIndex = status ~= nil and status.curSelectIndex or 1
    DataController:Deserialize(status)
    DataModel.curSquadIndex = status ~= nil and status.curSquadIndex or PlayerData.BattleInfo.squadIndex or 1
    if DataModel.curSquadIndex == 0 then
      DataModel.curSquadIndex = 1
    end
    if UISquadsGlobalData:GetSelectSquadIndex() ~= 1 then
      DataModel:SetCurSquadIndex(UISquadsGlobalData:GetResetSelectSquadIndex())
    end
    if DataModel.curLevelId ~= nil and type(status) == "table" and status.dialogueEnd ~= true then
      local levelCA = PlayerData:GetFactoryData(DataModel.curLevelId)
      if levelCA ~= nil and 0 < levelCA.paragraphId then
        UIManager:Open(UIPath.UIDialog, Json.encode({
          id = levelCA.paragraphId
        }))
        return
      end
    end
    if status == nil or status.curDetailIndex ~= 2 then
      View.self:PlayAnim("In")
    end
    if DataModel.Current == DataModel.Enum.LevelChain then
      LevelChainController.LevelChainRefreshAll(status.levelChainId or DataModel.levelChainId)
    else
      DataController:RefreshAll()
    end
    if DataModel.hasOpenThreeView ~= true then
      CharacterSelectController:Init()
      CardPollController:OpenView(false)
      View.Group_ChangeName.self:SetActive(false)
    else
      CharacterSelectController:OpenView(true)
    end
    DataModel.hasOpenThreeView = false
    if DataModel.curDetailIndex == 2 then
      DataModel.curDetailIndex = 2
      CharacterSelectController:OpenView(true, DataModel.currentIndex, DataModel.state, false)
      for k, v in pairs(DataModel.Squads[DataModel.curSquadIndex]) do
        if v.id then
          local id = tonumber(v.id)
          DataModel.HaveSquads[id] = id
        end
      end
      local currentSquad = {}
      local curRoleList = DataModel.Squads[DataModel.curSquadIndex]
      for i = 1, 5 do
        local temp = {}
        temp = curRoleList[i]
        if temp and temp.id == "" then
          temp.id = nil
        end
        table.insert(currentSquad, temp)
      end
      PlayerData.currentSquad = currentSquad
    else
      DataModel.Squads = {}
      DataModel:RefreshSquadsInit()
    end
    if DataModel.curSquadIndex ~= 1 and DataModel.curDetailIndex ~= 2 then
      SquadController.SetTabElement(DataModel.curSquadIndex, DataController)
    end
    View.Btn_Start.Group_Clarity.self:SetActive(false)
    if DataModel.curLevelId ~= "" and DataModel.curLevelId ~= nil then
      local levelCA = PlayerData:GetFactoryData(DataModel.curLevelId, "LevelFactory")
      View.Btn_Start.Group_Clarity.self:SetActive(true)
      local difficulty = DataModel.difficulty
      local costEnergyNum = levelCA.energyStart + levelCA.energyEnd + levelCA.extraEnergy * (difficulty - 1)
      if DataModel.level_key then
        local uid = string.split(DataModel.level_key, ":")[1]
        if uid ~= PlayerData:GetUserInfo().uid then
          costEnergyNum = PlayerData:GetFactoryData(99900014).shareEnergyEnd
        end
      end
      View.Btn_Start.Group_Clarity.Txt_Num:SetText("-" .. costEnergyNum)
    end
    DataModel.homeSafeData = nil
    if status ~= nil then
      if status.homeSafeData then
        DataModel.homeSafeData = status.homeSafeData
        if PlayerData.Last_Chapter_Parms == nil then
          PlayerData.Last_Chapter_Parms = {}
        end
        for k, v in pairs(status.homeSafeData) do
          PlayerData.Last_Chapter_Parms[k] = v
        end
      end
      if status.isBattleCenter then
        PlayerData.Last_Chapter_Parms = {}
        for k, v in pairs(status) do
          PlayerData.Last_Chapter_Parms[k] = v
        end
      end
    end
    DataModel.CloseCardDes()
    if status and status.enterTest then
      SquadController:EnterTest()
    end
    if MapNeedleEventData.event then
      View.Group_CommonTopLeft.Btn_Home:SetActive(false)
    end
  end,
  awake = function()
    DataModel.playAni = true
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    DataController:ClearGridProperty(View.StaticGrid_List.grid)
    DataModel.levelChainId = nil
    DataModel.curSquadIndex = 1
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
