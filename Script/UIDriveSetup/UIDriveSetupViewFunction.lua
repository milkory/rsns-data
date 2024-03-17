local View = require("UIDriveSetup/UIDriveSetupView")
local DataModel = require("UIDriveSetup/UIDriveSetupDataModel")
local ViewFunction = {
  DriveSetup_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  DriveSetup_Group_BuyRoad_Btn_BuyRoad_Click = function(btn, str)
    local trainCfg = PlayerData:GetFactoryData(99900064)
    if PlayerData:GetUserInfo().lv < trainCfg.autoBuyRoadLv then
      CommonTips.OpenTips(string.format(GetText(80602796), trainCfg.autoBuyRoadLv))
      return
    end
    PlayerData:SetPlayerPrefs("int", "IsAutoBuyRoad", PlayerData:GetPlayerPrefs("int", "IsAutoBuyRoad") == 0 and 1 or 0)
    View.Group_BuyRoad.Btn_BuyRoad.Group_On.self:SetActive(PlayerData:GetPlayerPrefs("int", "IsAutoBuyRoad") == 1)
  end,
  DriveSetup_Group_Fight_Btn_Fight_Click = function(btn, str)
    local trainCfg = PlayerData:GetFactoryData(99900064)
    if PlayerData:GetUserInfo().lv < trainCfg.autoFightLv then
      CommonTips.OpenTips(string.format(GetText(80602796), trainCfg.autoFightLv))
      return
    end
    PlayerData:SetPlayerPrefs("int", "IsAutoFight", PlayerData:GetPlayerPrefs("int", "IsAutoFight") == 0 and 1 or 0)
    View.Group_Fight.Btn_Fight.Group_On.self:SetActive(PlayerData:GetPlayerPrefs("int", "IsAutoFight") == 1)
  end,
  DriveSetup_Group_Balloon_Btn_Balloon_Click = function(btn, str)
    PlayerData:SetPlayerPrefs("int", "IsAutoBalloon", PlayerData:GetPlayerPrefs("int", "IsAutoBalloon") == 0 and 1 or 0)
    View.Group_Balloon.Btn_Balloon.Group_On.self:SetActive(PlayerData:GetPlayerPrefs("int", "IsAutoBalloon") == 1)
  end,
  DriveSetup_Group_Strike_Btn_Strike_Click = function(btn, str)
    local trainCfg = PlayerData:GetFactoryData(99900064)
    if PlayerData:GetUserInfo().lv < trainCfg.autoStrikeLv then
      CommonTips.OpenTips(string.format(GetText(80602796), trainCfg.autoStrikeLv))
      return
    end
    PlayerData:SetPlayerPrefs("int", "IsAutoStrike", PlayerData:GetPlayerPrefs("int", "IsAutoStrike") == 0 and 1 or 0)
    View.Group_Strike.Btn_Strike.Group_On.self:SetActive(PlayerData:GetPlayerPrefs("int", "IsAutoStrike") == 1)
  end,
  DriveSetup_Group_Rush_Btn_Rush_Click = function(btn, str)
    local trainCfg = PlayerData:GetFactoryData(99900064)
    if PlayerData:GetUserInfo().lv < trainCfg.autoRushLv then
      CommonTips.OpenTips(string.format(GetText(80602796), trainCfg.autoRushLv))
      return
    end
    PlayerData:SetPlayerPrefs("int", "autoUseBullet", PlayerData:GetPlayerPrefs("int", "autoUseBullet") == 0 and 1 or 0)
    View.Group_Rush.Btn_Rush.Group_On.self:SetActive(PlayerData:GetPlayerPrefs("int", "autoUseBullet") == 1)
    local MainUIDataModel = require("UIMainUI/UIMainUIDataModel")
    MainUIDataModel.autoUseBullet = PlayerData:GetPlayerPrefs("int", "autoUseBullet") ~= 0
  end,
  DriveSetup_Group_BuyRoad_Group_UnLock_Btn_UnLock_Click = function(btn, str)
    local trainCfg = PlayerData:GetFactoryData(99900064)
    if PlayerData:GetUserInfo().lv < trainCfg.autoBuyRoadLv then
      CommonTips.OpenTips(string.format(GetText(80602931), trainCfg.autoBuyRoadLv))
      return
    end
    local t = {}
    t.textId = 80602920
    t.cost = "autoBuyRoadUnLock"
    t.iconPath = PlayerData:GetFactoryData(99900064).autoBuyRoadPath
    t.setUpType = "money"
    UIManager:Open("UI/MainUI/DriveSetupUnlock", Json.encode(t))
  end,
  DriveSetup_Group_Rush_Group_UnLock_Btn_UnLock_Click = function(btn, str)
    local trainCfg = PlayerData:GetFactoryData(99900064)
    if PlayerData:GetUserInfo().lv < trainCfg.autoRushLv then
      CommonTips.OpenTips(string.format(GetText(80602931), trainCfg.autoRushLv))
      return
    end
    local t = {}
    t.textId = 80602609
    t.cost = "autoRushUnLock"
    t.iconPath = PlayerData:GetFactoryData(99900064).autoRushPath
    t.setUpType = "rush"
    UIManager:Open("UI/MainUI/DriveSetupUnlock", Json.encode(t))
  end,
  DriveSetup_Group_Strike_Group_UnLock_Btn_UnLock_Click = function(btn, str)
    local trainCfg = PlayerData:GetFactoryData(99900064)
    if PlayerData:GetUserInfo().lv < trainCfg.autoStrikeLv then
      CommonTips.OpenTips(string.format(GetText(80602931), trainCfg.autoStrikeLv))
      return
    end
    local t = {}
    t.textId = 80602921
    t.cost = "aautoStrikeUnLock"
    t.iconPath = PlayerData:GetFactoryData(99900064).autoStrikePath
    t.setUpType = "assault"
    UIManager:Open("UI/MainUI/DriveSetupUnlock", Json.encode(t))
  end,
  DriveSetup_Group_Fight_Group_UnLock_Btn_UnLock_Click = function(btn, str)
    local trainCfg = PlayerData:GetFactoryData(99900064)
    if PlayerData:GetUserInfo().lv < trainCfg.autoFightLv then
      CommonTips.OpenTips(string.format(GetText(80602931), trainCfg.autoFightLv))
      return
    end
    local t = {}
    t.textId = 80602919
    t.cost = "autoFightUnLock"
    t.iconPath = PlayerData:GetFactoryData(99900064).autoFightPath
    t.setUpType = "bar"
    UIManager:Open("UI/MainUI/DriveSetupUnlock", Json.encode(t))
  end
}
return ViewFunction
