local View = require("UIDriveSetup/UIDriveSetupView")
local DataModel = require("UIDriveSetup/UIDriveSetupDataModel")
local ViewFunction = require("UIDriveSetup/UIDriveSetupViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local trainCfg = PlayerData:GetFactoryData(99900064)
    local playerLv = PlayerData:GetUserInfo().lv
    local buyRoadLv = trainCfg.autoBuyRoadLv
    View.Group_BuyRoad.Group_UnLock.Txt_UnLock:SetText(string.format(GetText(80603018), buyRoadLv))
    View.Group_BuyRoad.Group_UnLock.self:SetActive(PlayerData:GetUserInfo().functional_status.money ~= 1)
    View.Group_BuyRoad.Btn_BuyRoad.Group_On.self:SetActive(PlayerData:GetPlayerPrefs("int", "IsAutoBuyRoad") == 1)
    local rushLv = trainCfg.autoRushLv
    View.Group_Rush.Group_UnLock.Txt_UnLock:SetText(string.format(GetText(80603018), rushLv))
    View.Group_Rush.Group_UnLock.self:SetActive(PlayerData:GetUserInfo().functional_status.rush ~= 1)
    View.Group_Rush.Btn_Rush.Group_On.self:SetActive(PlayerData:GetPlayerPrefs("int", "autoUseBullet") == 1)
    local strikeLv = trainCfg.autoStrikeLv
    View.Group_Strike.Group_UnLock.Txt_UnLock:SetText(string.format(GetText(80603018), strikeLv))
    View.Group_Strike.Group_UnLock.self:SetActive(PlayerData:GetUserInfo().functional_status.assault ~= 1)
    View.Group_Strike.Btn_Strike.Group_On.self:SetActive(PlayerData:GetPlayerPrefs("int", "IsAutoStrike") == 1)
    local fightLv = trainCfg.autoFightLv
    View.Group_Fight.Group_UnLock.Txt_UnLock:SetText(string.format(GetText(80603018), fightLv))
    View.Group_Fight.Group_UnLock.self:SetActive(PlayerData:GetUserInfo().functional_status.bar ~= 1)
    View.Group_Fight.Btn_Fight.Group_On.self:SetActive(PlayerData:GetPlayerPrefs("int", "IsAutoFight") == 1)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
