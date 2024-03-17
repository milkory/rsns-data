local View = require("UISetting/UISettingView")
local DataModel = require("UISetting/UISettingDataModel")
local CtrlCdk = require("UISetting/Cdk/UISettingCdkController")
local SwitchSoundLanguage = function(selectLanguage)
  local CVList = PlayerData:GetFactoryData(99900012).CVList
  local nowLanguage = PlayerData:GetPlayerPrefs("int", "soundLanguage")
  if nowLanguage ~= selectLanguage then
    nowLanguage = selectLanguage
    PlayerData:SetPlayerPrefs("int", "soundLanguage", nowLanguage)
    SoundManager:SetRoleCVReplacePath(CVList[nowLanguage].replacePath)
    View.Group_Sound.Group_DubbingOptions.Img_Box.Group_Chinese.Group_Language.Img_On:SetActive(nowLanguage == 1)
    View.Group_Sound.Group_DubbingOptions.Img_Box.Group_Japanese.Group_Language.Img_On:SetActive(nowLanguage == 2)
  end
end
local ViewFunction = {
  Setting_Btn_Close_Click = function(btn, str)
    UIManager:GoBack()
    PlayerPrefs.SetInt("bg", DataModel.Now_Bg)
    PlayerPrefs.SetInt("music", DataModel.Now_Music)
    PlayerPrefs.SetInt("roleCV", DataModel.Now_RoleCV)
  end,
  Setting_Group_Slider1_Slider_Value1_Slider = function(slider, value)
    local s_value = math.floor(value)
    DataModel:SetSliderBG(s_value)
  end,
  Setting_Group_Slider1_Slider_Value1_SliderDown = function(slider)
  end,
  Setting_Group_Slider1_Slider_Value1_SliderUp = function(slider)
    DataModel:UpdateSound(1)
  end,
  Setting_Group_Slider2_Slider_Value2_Slider = function(slider, value)
    local s_value = math.floor(value)
    DataModel:SetSliderMusic(s_value)
  end,
  Setting_Group_Slider2_Slider_Value2_SliderDown = function(slider)
  end,
  Setting_Group_Slider2_Slider_Value2_SliderUp = function(slider)
    DataModel:UpdateSound(2)
  end,
  Setting_Group_ImageQuality_Btn_VeryLow_Click = function(btn, str)
    GameSetting:SetVisualQuality(0)
    DataModel:SetImageQuality(0)
  end,
  Setting_Group_ImageQuality_Btn_Low_Click = function(btn, str)
    GameSetting:SetVisualQuality(1)
    DataModel:SetImageQuality(1)
  end,
  Setting_Group_ImageQuality_Btn_Medium_Click = function(btn, str)
    GameSetting:SetVisualQuality(2)
    DataModel:SetImageQuality(2)
  end,
  Setting_Group_ImageQuality_Btn_High_Click = function(btn, str)
    GameSetting:SetVisualQuality(3)
    DataModel:SetImageQuality(3)
  end,
  Setting_Group_ImageQuality_Btn_VeryHigh_Click = function(btn, str)
    GameSetting:SetVisualQuality(4)
    DataModel:SetImageQuality(4)
  end,
  Setting_Group_FPS_Btn_30_Click = function(btn, str)
    GameSetting:SetVisualFPS(0)
    DataModel:SetFPS(0)
  end,
  Setting_Group_FPS_Btn_60_Click = function(btn, str)
    GameSetting:SetVisualFPS(1)
    DataModel:SetFPS(1)
  end,
  Setting_Group_Shadow_Btn_On_Click = function(btn, str)
    GameSetting:SetShadowQuality(1)
    DataModel:SetShadow(1)
  end,
  Setting_Group_Shadow_Btn_Off_Click = function(btn, str)
    GameSetting:SetShadowQuality(0)
    DataModel:SetShadow(0)
  end,
  Setting_Group_TextureQuality_Btn_Low_Click = function(btn, str)
    GameSetting:SetTextureLimit(0)
    DataModel:SetTextureLimit(0)
  end,
  Setting_Group_TextureQuality_Btn_Medium_Click = function(btn, str)
    GameSetting:SetTextureLimit(1)
    DataModel:SetTextureLimit(1)
  end,
  Setting_Group_TextureQuality_Btn_High_Click = function(btn, str)
    GameSetting:SetTextureLimit(2)
    DataModel:SetTextureLimit(2)
  end,
  Setting_Group_Horizon_Btn_Far_Click = function(btn, str)
    GameSetting:SetFarValue(3)
    DataModel:SetFar(3)
  end,
  Setting_Group_Horizon_Btn_Medium_Click = function(btn, str)
    GameSetting:SetFarValue(2)
    DataModel:SetFar(2)
  end,
  Setting_Group_Horizon_Btn_Close_Click = function(btn, str)
    GameSetting:SetFarValue(1)
    DataModel:SetFar(1)
  end,
  Setting_Group_Horizon_Btn_VeryClose_Click = function(btn, str)
    GameSetting:SetFarValue(0)
    DataModel:SetFar(0)
  end,
  Setting_Group_Bloom_Btn_On_Click = function(btn, str)
    GameSetting:SetVisualbloom(1)
    DataModel:SetBloom(1)
  end,
  Setting_Group_Bloom_Btn_Off_Click = function(btn, str)
    GameSetting:SetVisualbloom(0)
    DataModel:SetBloom(0)
  end,
  Setting_Group_Tabs_StaticGrid_Tabs_SetGrid = function(element, elementIndex)
    element.Img_On:SetActive(false)
    element.Btn_Off:SetActive(true)
    local row = DataModel.TopRightConfig[tonumber(elementIndex)]
    element.Img_On.Img_Black:SetSprite(row.on_img)
    element.Img_On.Txt_Title:SetText(row.txt)
    element.Btn_Off.Img_White:SetSprite(row.off_img)
    element.Btn_Off.Txt_Title:SetText(row.txt)
    element.Btn_Off:SetClickParam(elementIndex)
  end,
  Setting_Group_Tabs_StaticGrid_Tabs_Group_Tabs_Btn_Off_Click = function(btn, str)
    DataModel:SelectRightTop(tonumber(str))
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Btn_RestoreImage_Click = function(btn, str)
    DataModel:ResetImgValue()
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_PictureQuality_StaticGrid_Quality_SetGrid = function(element, elementIndex)
    element.Btn_Off:SetClickParam(elementIndex)
    element.Img_Selection:SetActive(false)
    element.Btn_Off:SetActive(true)
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_PictureQuality_StaticGrid_Quality_Group_Quality_Btn_Off_Click = function(btn, str)
    DataModel:SetNewImageQuality(tonumber(str))
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_CityFPS_Img_Box_Group_30Fps_Btn_Off_Click = function(btn, str)
    DataModel:SetCityFPS(0)
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_CityFPS_Img_Box_Group_60Fps_Btn_Off_Click = function(btn, str)
    DataModel:SetCityFPS(1)
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_DriveFPS_Img_Box_Group_30Fps_Btn_Off_Click = function(btn, str)
    DataModel:SetTrainMapFPS(0)
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_DriveFPS_Img_Box_Group_60Fps_Btn_Off_Click = function(btn, str)
    DataModel:SetTrainMapFPS(1)
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_DriveHorizon_Img_Box_StaticGrid_DriveHorizon_SetGrid = function(element, elementIndex)
    element.Btn_Off:SetClickParam(elementIndex)
    element.Img_On:SetActive(false)
    element.Btn_Off:SetActive(true)
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_DriveHorizon_Img_Box_StaticGrid_DriveHorizon_Group_SettingSelection_Btn_Off_Click = function(btn, str)
    DataModel:SetNewFar(tonumber(str))
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_DriveShadow_Img_Switch_Btn_Click_Click = function(btn, str)
    local index = 0
    if GameSetting.currentVisualShadow == 0 then
      index = 1
    end
    if GameSetting.currentVisualShadow == 1 then
      index = 0
    end
    DataModel:SetShadow(index)
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_Bloom_Img_Switch_Btn_Click_Click = function(btn, str)
    local index = 0
    if GameSetting.currentVisualBloom == 0 then
      index = 1
    end
    if GameSetting.currentVisualBloom == 1 then
      index = 0
    end
    DataModel:SetBloom(index)
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_TextureQuality_Img_Box_StaticGrid_TextureQuality_SetGrid = function(element, elementIndex)
    element.Btn_Off:SetClickParam(elementIndex)
    element.Img_On:SetActive(false)
    element.Btn_Off:SetActive(true)
    local row = DataModel.CA.textureQualityList[tonumber(elementIndex)]
    element.Img_On.Txt_Title:SetText(row.optionName)
    element.Btn_Off.Txt_Title:SetText(row.optionName)
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_TextureQuality_Img_Box_StaticGrid_TextureQuality_Group_SettingSelection_Btn_Off_Click = function(btn, str)
    DataModel:SetNewTextureLimit(tonumber(str))
  end,
  Setting_Group_Sound_Group_MusicVolume_Img_Box_Slider_MusicVolume_Slider = function(slider, value)
    local s_value = math.floor(value)
    DataModel:SetSliderBG(s_value)
  end,
  Setting_Group_Sound_Group_MusicVolume_Img_Box_Slider_MusicVolume_SliderDown = function(slider)
  end,
  Setting_Group_Sound_Group_MusicVolume_Img_Box_Slider_MusicVolume_SliderUp = function(slider)
    DataModel:UpdateSound(1)
  end,
  Setting_Group_Sound_Btn_RestoreImage_Click = function(btn, str)
    DataModel:ResetMusicValue()
    SwitchSoundLanguage(GameSetting.defaultSoundLanguage)
  end,
  Setting_Group_Sound_Group_EffectVolume_Img_Box_Slider_MusicVolume_Slider = function(slider, value)
    local s_value = math.floor(value)
    DataModel:SetSliderMusic(s_value)
  end,
  Setting_Group_Sound_Group_EffectVolume_Img_Box_Slider_MusicVolume_SliderDown = function(slider)
  end,
  Setting_Group_Sound_Group_EffectVolume_Img_Box_Slider_MusicVolume_SliderUp = function(slider)
    DataModel:UpdateSound(2)
  end,
  Setting_Group_Image_ScrollView_Image_Viewport_Content_Group_Anti_Aliasing_Img_Switch_Btn_Click_Click = function(btn, str)
  end,
  Setting_Group_Sound_Group_DubbingOptions_Img_Box_Group_Chinese_Group_Language_Btn_Off_Click = function(btn, str)
    SwitchSoundLanguage(1)
  end,
  Setting_Group_Sound_Group_DubbingOptions_Img_Box_Group_Japanese_Group_Language_Btn_Off_Click = function(btn, str)
    SwitchSoundLanguage(2)
  end,
  Setting_Group_Cdk_Btn_RestoreImage_Click = function(btn, str)
  end,
  Setting_Group_Cdk_Img_Input_Btn_Clean_Click = function(btn, str)
    CtrlCdk:CleanInput()
  end,
  Setting_Group_Cdk_Btn_Convert_Click = function(btn, str)
    CtrlCdk:Convert()
  end,
  Setting_Group_Sound_Group_CvVolume_Img_Box_Slider_MusicVolume_Slider = function(slider, value)
    local s_value = math.floor(value)
    DataModel:SetSliderRoleCV(s_value)
  end,
  Setting_Group_Sound_Group_CvVolume_Img_Box_Slider_MusicVolume_SliderDown = function(slider)
  end,
  Setting_Group_Sound_Group_CvVolume_Img_Box_Slider_MusicVolume_SliderUp = function(slider)
    DataModel:UpdateSound(3)
  end
}
return ViewFunction
