local View = require("UILogin/UILoginView")
local Controller = require("UILogin/UILoginController")
local ViewFunction = require("UILogin/UILoginViewFunction")
local DataModel = require("UILogin/UILoginDataModel")
local Listener = require("UILogin/UILoginListener")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Controller:InitView()
    Listener:Start()
    PlayerData:SetSound()
    local text = GameSetting.version
    if CS.GameSetting.channel == "CN_DEBUG" then
      text = GameSetting.serverAdress .. ":" .. GameSetting.serverPort .. "\n" .. CS.GameSetting.channel .. "\n" .. text .. "\n" .. GameSetting.RandomUID
    end
    View.Txt_Version:SetText(text)
    if SdkHelper.IsNotChannelDefault() then
      PhoneIDLogin = false
      View.Group_LoginAndJoin:SetActive(false)
      Controller.SetBtnUserCenterAndServices(false)
      LoginHelper.StartChannelLogin()
    else
      ViewFunction.Login_Btn_Login_Click()
    end
    View.Video_Login:Play("Video/Login/Login")
    local bgSoundId
    for k, v in pairs(PlayerData:GetFactoryData(99900002).uiBgmList) do
      if v.PrefabUrl == "UI\\Login\\Login" then
        bgSoundId = v.soundId
      end
    end
    if bgSoundId ~= nil then
      local sound = SoundManager:CreateSound(bgSoundId)
      if sound ~= nil then
        sound:Play()
      end
    end
    View.Btn_AgeTip:SetActive(true)
    DataModel.IsDown = true
    DataModel.IsMaxData = 6
    DataModel.ChangeButtonState()
    PlayerData:RestData()
  end,
  awake = function()
  end,
  start = function()
    LoadingManager:CloseLoading()
  end,
  update = function()
  end,
  ondestroy = function()
    Listener:Stop()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
