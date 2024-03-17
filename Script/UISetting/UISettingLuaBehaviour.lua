local View = require("UISetting/UISettingView")
local DataModel = require("UISetting/UISettingDataModel")
local ViewFunction = require("UISetting/UISettingViewFunction")
local Init = function()
  DataModel.CA = PlayerData:GetFactoryData(99900012)
  DataModel.InitUpdate = 0
  DataModel.defaultSetParams = nil
  if GameSetting.platform == "Android" then
    DataModel.defaultSetParams = DataModel.CA.everyAndroidDefaultSetList[GameSetting.defaultIndex + 1]
  end
  if GameSetting.platform == "IOS" then
    DataModel.defaultSetParams = DataModel.CA.everyIosDefaultSetList[GameSetting.defaultIndex + 1]
  end
  DataModel.IsGrey = DataModel.defaultSetParams and DataModel.defaultSetParams.isGrey or false
  DataModel.greyQualityMin = table.count(DataModel.CA.resolutionList) - 1
  DataModel.greyDriveHorizonMin = table.count(DataModel.CA.driveHorizonList) - 1
  DataModel.greyTextureQualityMin = table.count(DataModel.CA.textureQualityList) - 1
  if DataModel.defaultSetParams then
    DataModel.greyQualityMin = DataModel.defaultSetParams.greyQualityMin
    DataModel.greyDriveHorizonMin = DataModel.defaultSetParams.greyDriveHorizonMin
    DataModel.greyTextureQualityMin = DataModel.defaultSetParams.greyTextureQualityMin
  end
  DataModel.lastBg = nil
  DataModel.lastMusic = nil
  DataModel.lastRoleCV = nil
  DataModel.Max_Bg = 10
  DataModel.Max_Music = 10
  DataModel.Max_RoleCV = 10
  DataModel.SoundList = {
    [0] = -80,
    [1] = -17,
    [2] = -15,
    [3] = -13,
    [4] = -11,
    [5] = -9,
    [6] = -7,
    [7] = -5,
    [8] = -3,
    [9] = -1,
    [10] = 0
  }
  DataModel.Now_Bg = PlayerPrefs.GetInt("bg")
  DataModel.Now_Music = PlayerPrefs.GetInt("music")
  DataModel.Now_RoleCV = PlayerPrefs.GetInt("roleCV")
  View.Group_Sound.Group_MusicVolume.Img_Box.Slider_MusicVolume:SetMinAndMaxValue(0, DataModel.Max_Bg)
  View.Group_Sound.Group_EffectVolume.Img_Box.Slider_MusicVolume:SetMinAndMaxValue(0, DataModel.Max_Music)
  View.Group_Sound.Group_CvVolume.Img_Box.Slider_MusicVolume:SetMinAndMaxValue(0, DataModel.Max_RoleCV)
  View.Group_Sound.Group_MusicVolume.Img_Box.Slider_MusicVolume:SetSliderValue(DataModel.Now_Bg)
  View.Group_Sound.Group_EffectVolume.Img_Box.Slider_MusicVolume:SetSliderValue(DataModel.Now_Music)
  View.Group_Sound.Group_CvVolume.Img_Box.Slider_MusicVolume:SetSliderValue(DataModel.Now_RoleCV)
  DataModel.lastBg = DataModel.Now_Bg
  DataModel.lastMusic = DataModel.Now_Music
  DataModel.lastRoleCV = DataModel.Now_RoleCV
  View.Group_Sound.Group_MusicVolume.Img_Box.Slider_MusicVolume.Group_Base.Img_SoundValue.Txt_:SetText(math.floor(DataModel.Now_Bg))
  View.Group_Sound.Group_EffectVolume.Img_Box.Slider_MusicVolume.Group_Base.Img_SoundValue.Txt_:SetText(math.floor(DataModel.Now_Music))
  View.Group_Sound.Group_CvVolume.Img_Box.Slider_MusicVolume.Group_Base.Img_SoundValue.Txt_:SetText(math.floor(DataModel.Now_RoleCV))
  View.Group_Tabs.StaticGrid_Tabs.grid.self:SetDataCount(table.count(DataModel.TopRightConfig))
  View.Group_Tabs.StaticGrid_Tabs.grid.self:RefreshAllElement()
  View.Group_Image.self:SetActive(false)
  View.Group_Sound.self:SetActive(false)
  DataModel.TopRightIndex = nil
  DataModel:SelectRightTop(1)
  local nowLanguage = PlayerData:GetPlayerPrefs("int", "soundLanguage")
  if nowLanguage == 0 then
    nowLanguage = GameSetting.defaultSoundLanguage
  end
  View.Group_Sound.Group_DubbingOptions.Img_Box.Group_Chinese.Group_Language.Img_On:SetActive(nowLanguage == 1)
  View.Group_Sound.Group_DubbingOptions.Img_Box.Group_Japanese.Group_Language.Img_On:SetActive(nowLanguage == 2)
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.InitUpdate then
      DataModel.InitUpdate = DataModel.InitUpdate + 1
      if DataModel.InitUpdate == 20 then
        if DataModel.lastBg ~= DataModel.Now_Bg then
          DataModel:UpdateSound(1)
        end
        if DataModel.lastMusic ~= DataModel.Now_Music then
          DataModel:UpdateSound(2)
        end
        if DataModel.lastRoleCV ~= DataModel.Now_RoleCV then
          DataModel:UpdateSound(3)
        end
        DataModel.InitUpdate = 0
      end
    end
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
