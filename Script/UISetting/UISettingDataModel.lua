local View = require("UISetting/UISettingView")
local CtrlCdk = require("UISetting/Cdk/UISettingCdkController")
local DataModel = {}
DataModel.TopRightConfig = {
  [1] = {
    txt = "图像",
    on_img = "UI/Setting/resource/Image_B",
    off_img = "UI/Setting/resource/Image_W",
    ui = "Group_Image"
  },
  [2] = {
    txt = "声音",
    on_img = "UI/Setting/resource/Sound_B",
    off_img = "UI/Setting/resource/Sound_W",
    ui = "Group_Sound"
  },
  [3] = {
    txt = "其他",
    on_img = "UI/Setting/resource/Other_B",
    off_img = "UI/Setting/resource/Other_W",
    ui = "Group_Cdk",
    init = function()
      CtrlCdk:Init()
    end
  }
}

function DataModel:SelectRightTop(index)
  if DataModel.TopRightIndex then
    if index == DataModel.TopRightIndex then
      return
    end
    local config = DataModel.TopRightConfig[index]
    local old_element = View.Group_Tabs.StaticGrid_Tabs.grid[DataModel.TopRightIndex]
    old_element.Img_On:SetActive(false)
    View[DataModel.TopRightConfig[DataModel.TopRightIndex].ui]:SetActive(false)
    if config ~= nil then
      local funcInit = config.init
      if funcInit ~= nil then
        pcall(funcInit)
      end
    end
  end
  self:HideAllTaps()
  local element = View.Group_Tabs.StaticGrid_Tabs.grid[index]
  element.Img_On:SetActive(true)
  View[DataModel.TopRightConfig[index].ui]:SetActive(true)
  DataModel.TopRightIndex = index
  if index == 1 then
    View.Group_Image.ScrollView_Image.Viewport.Content.self:SetLocalPositionY(0)
    View.Group_Image.ScrollView_Image.Viewport.Content.Group_PictureQuality.StaticGrid_Quality.grid.self:SetDataCount(table.count(DataModel.CA.resolutionList))
    View.Group_Image.ScrollView_Image.Viewport.Content.Group_PictureQuality.StaticGrid_Quality.grid.self:RefreshAllElement()
    DataModel:SetNewImageQuality(GameSetting.currentVisualQuality, 1)
    DataModel:SetCityFPS(GameSetting.currentVisualFPS)
    DataModel:SetTrainMapFPS(GameSetting.currentVisualTrainFPS)
    View.Group_Image.ScrollView_Image.Viewport.Content.Group_DriveHorizon.Img_Box.StaticGrid_DriveHorizon.grid.self:SetDataCount(table.count(DataModel.CA.driveHorizonList))
    View.Group_Image.ScrollView_Image.Viewport.Content.Group_DriveHorizon.Img_Box.StaticGrid_DriveHorizon.grid.self:RefreshAllElement()
    DataModel:SetNewFar(GameSetting.currentVisualFar, 1)
    DataModel:SetShadow(GameSetting.currentVisualShadow, 1)
    DataModel:SetBloom(GameSetting.currentVisualBloom, 1)
    View.Group_Image.ScrollView_Image.Viewport.Content.Group_TextureQuality.Img_Box.StaticGrid_TextureQuality.grid.self:SetDataCount(table.count(DataModel.CA.textureQualityList))
    View.Group_Image.ScrollView_Image.Viewport.Content.Group_TextureQuality.Img_Box.StaticGrid_TextureQuality.grid.self:RefreshAllElement()
    DataModel:SetNewTextureLimit(GameSetting.currentTextureLimit, 1)
  end
end

function DataModel:SetImageQuality(quality)
  if quality == 0 then
    View.Group_ImageQuality.Btn_VeryLow:SetColor("#FFFFFF")
    View.Group_ImageQuality.Btn_Low:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_Medium:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_High:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_VeryHigh:SetColor("#6F6F6F")
  elseif quality == 1 then
    View.Group_ImageQuality.Btn_VeryLow:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_Low:SetColor("#FFFFFF")
    View.Group_ImageQuality.Btn_Medium:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_High:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_VeryHigh:SetColor("#6F6F6F")
  elseif quality == 2 then
    View.Group_ImageQuality.Btn_VeryLow:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_Low:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_Medium:SetColor("#FFFFFF")
    View.Group_ImageQuality.Btn_High:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_VeryHigh:SetColor("#6F6F6F")
  elseif quality == 3 then
    View.Group_ImageQuality.Btn_VeryLow:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_Low:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_Medium:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_High:SetColor("#FFFFFF")
    View.Group_ImageQuality.Btn_VeryHigh:SetColor("#6F6F6F")
  else
    View.Group_ImageQuality.Btn_VeryLow:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_Low:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_Medium:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_High:SetColor("#6F6F6F")
    View.Group_ImageQuality.Btn_VeryHigh:SetColor("#FFFFFF")
  end
end

function DataModel:SetNewImageQuality(index, isFirst)
  local num
  if isFirst then
    num = index
    local element = View.Group_Image.ScrollView_Image.Viewport.Content.Group_PictureQuality.StaticGrid_Quality.grid[index + 1]
    element.Img_Selection:SetActive(true)
  else
    num = index - 1
    if DataModel.IsGrey == true and num > DataModel.greyQualityMin then
      CommonTips.OpenTips(80601958)
      return
    end
    if GameSetting.currentVisualQuality then
      if num == GameSetting.currentVisualQuality then
        return
      end
      if PlayerData:GetHomeInfo().station_info.is_arrived ~= 2 then
        CommonTips.OpenTips("进入站点后才可以更改画质选项")
        return
      end
      local old_element = View.Group_Image.ScrollView_Image.Viewport.Content.Group_PictureQuality.StaticGrid_Quality.grid[GameSetting.currentVisualQuality + 1]
      old_element.Img_Selection:SetActive(false)
    end
    local element = View.Group_Image.ScrollView_Image.Viewport.Content.Group_PictureQuality.StaticGrid_Quality.grid[index]
    element.Img_Selection:SetActive(true)
  end
  GameSetting:SetVisualQuality(num)
end

function DataModel:SetCityFPS(fps)
  local cityFPS = View.Group_Image.ScrollView_Image.Viewport.Content.Group_CityFPS.Img_Box
  if fps == 0 then
    cityFPS.Group_30Fps.Img_On.self:SetActive(true)
    cityFPS.Group_60Fps.Img_On.self:SetActive(false)
  elseif fps == 1 then
    cityFPS.Group_30Fps.Img_On.self:SetActive(false)
    cityFPS.Group_60Fps.Img_On.self:SetActive(true)
  end
  GameSetting:SetVisualFPS(fps)
end

function DataModel:SetTrainMapFPS(fps)
  local trainMapFPS = View.Group_Image.ScrollView_Image.Viewport.Content.Group_DriveFPS.Img_Box
  if fps == 0 then
    trainMapFPS.Group_30Fps.Img_On.self:SetActive(true)
    trainMapFPS.Group_60Fps.Img_On.self:SetActive(false)
  elseif fps == 1 then
    trainMapFPS.Group_30Fps.Img_On.self:SetActive(false)
    trainMapFPS.Group_60Fps.Img_On.self:SetActive(true)
  end
  GameSetting:SetVisualFPS(fps, false, true)
end

function DataModel:SetShadow(isShadow, isFirst)
  local switch = View.Group_Image.ScrollView_Image.Viewport.Content.Group_DriveShadow.Img_Switch
  if isFirst then
    if isShadow == 0 then
      switch:SetSprite("UI/Setting/resource/slide_off")
      switch.Img_On:SetLocalPositionX(-43)
    elseif isShadow == 1 then
      switch:SetSprite("UI/Setting/resource/slide_on")
      switch.Img_On:SetLocalPositionX(43)
    end
    return
  end
  if isShadow == 0 then
    DOTweenTools.DOLocalMoveXCallback(switch.Img_On.transform, -43, 0.25, function()
      switch:SetSprite("UI/Setting/resource/slide_off")
      GameSetting:SetShadowQuality(isShadow)
    end)
  elseif isShadow == 1 then
    DOTweenTools.DOLocalMoveXCallback(switch.Img_On.transform, 43, 0.25, function()
      switch:SetSprite("UI/Setting/resource/slide_on")
      GameSetting:SetShadowQuality(isShadow)
    end)
  end
end

function DataModel:SetBloom(isBloom, isFirst)
  local switch = View.Group_Image.ScrollView_Image.Viewport.Content.Group_Bloom.Img_Switch
  if isFirst then
    if isBloom == 0 then
      switch:SetSprite("UI/Setting/resource/slide_off")
      switch.Img_On:SetLocalPositionX(-43)
    elseif isBloom == 1 then
      switch:SetSprite("UI/Setting/resource/slide_on")
      switch.Img_On:SetLocalPositionX(43)
    end
    return
  end
  if isBloom == 0 then
    DOTweenTools.DOLocalMoveXCallback(switch.Img_On.transform, -43, 0.25, function()
      switch:SetSprite("UI/Setting/resource/slide_off")
      GameSetting:SetVisualbloom(isBloom)
    end)
  elseif isBloom == 1 then
    DOTweenTools.DOLocalMoveXCallback(switch.Img_On.transform, 43, 0.25, function()
      switch:SetSprite("UI/Setting/resource/slide_on")
      GameSetting:SetVisualbloom(isBloom)
    end)
  end
end

function DataModel:SetFar(isHorizon)
  if isHorizon == 0 then
    View.Group_Horizon.Btn_VeryClose:SetColor("#FFFFFF")
    View.Group_Horizon.Btn_Close:SetColor("#6F6F6F")
    View.Group_Horizon.Btn_Medium:SetColor("#6F6F6F")
    View.Group_Horizon.Btn_Far:SetColor("#6F6F6F")
  elseif isHorizon == 1 then
    View.Group_Horizon.Btn_VeryClose:SetColor("#6F6F6F")
    View.Group_Horizon.Btn_Close:SetColor("#FFFFFF")
    View.Group_Horizon.Btn_Medium:SetColor("#6F6F6F")
    View.Group_Horizon.Btn_Far:SetColor("#6F6F6F")
  elseif isHorizon == 2 then
    View.Group_Horizon.Btn_VeryClose:SetColor("#6F6F6F")
    View.Group_Horizon.Btn_Close:SetColor("#6F6F6F")
    View.Group_Horizon.Btn_Medium:SetColor("#FFFFFF")
    View.Group_Horizon.Btn_Far:SetColor("#6F6F6F")
  elseif isHorizon == 3 then
    View.Group_Horizon.Btn_VeryClose:SetColor("#6F6F6F")
    View.Group_Horizon.Btn_Close:SetColor("#6F6F6F")
    View.Group_Horizon.Btn_Medium:SetColor("#6F6F6F")
    View.Group_Horizon.Btn_Far:SetColor("#FFFFFF")
  end
end

function DataModel:SetNewFar(index, isFirst)
  local num
  if isFirst then
    num = index
    local element = View.Group_Image.ScrollView_Image.Viewport.Content.Group_DriveHorizon.Img_Box.StaticGrid_DriveHorizon.grid[index + 1]
    element.Img_On:SetActive(true)
  else
    num = index - 1
    if DataModel.IsGrey == true and num > DataModel.greyDriveHorizonMin then
      CommonTips.OpenTips(80601958)
      return
    end
    if GameSetting.currentVisualFar then
      if num == GameSetting.currentVisualFar then
        return
      end
      local old_element = View.Group_Image.ScrollView_Image.Viewport.Content.Group_DriveHorizon.Img_Box.StaticGrid_DriveHorizon.grid[GameSetting.currentVisualFar + 1]
      old_element.Img_On:SetActive(false)
    end
    local element = View.Group_Image.ScrollView_Image.Viewport.Content.Group_DriveHorizon.Img_Box.StaticGrid_DriveHorizon.grid[index]
    element.Img_On:SetActive(true)
  end
  GameSetting:SetFarValue(num)
end

function DataModel:SetTextureLimit(limit)
  if limit == 0 then
    View.Group_TextureQuality.Btn_Low:SetColor("#FFFFFF")
    View.Group_TextureQuality.Btn_Medium:SetColor("#6F6F6F")
    View.Group_TextureQuality.Btn_High:SetColor("#6F6F6F")
  elseif limit == 1 then
    View.Group_TextureQuality.Btn_Low:SetColor("#6F6F6F")
    View.Group_TextureQuality.Btn_Medium:SetColor("#FFFFFF")
    View.Group_TextureQuality.Btn_High:SetColor("#6F6F6F")
  elseif limit == 2 then
    View.Group_TextureQuality.Btn_Low:SetColor("#6F6F6F")
    View.Group_TextureQuality.Btn_Medium:SetColor("#6F6F6F")
    View.Group_TextureQuality.Btn_High:SetColor("#FFFFFF")
  end
end

function DataModel:SetNewTextureLimit(index, isFirst)
  local num
  if isFirst then
    num = index
    local element = View.Group_Image.ScrollView_Image.Viewport.Content.Group_TextureQuality.Img_Box.StaticGrid_TextureQuality.grid[index + 1]
    element.Img_On:SetActive(true)
  else
    num = index - 1
    if DataModel.IsGrey == true and num > DataModel.greyTextureQualityMin then
      CommonTips.OpenTips(80601958)
      return
    end
    if GameSetting.currentTextureLimit then
      if num == GameSetting.currentTextureLimit then
        return
      end
      if PlayerData:GetHomeInfo().station_info.is_arrived ~= 2 then
        CommonTips.OpenTips("进入站点后才可以更改贴图选项")
        return
      end
      local old_element = View.Group_Image.ScrollView_Image.Viewport.Content.Group_TextureQuality.Img_Box.StaticGrid_TextureQuality.grid[GameSetting.currentTextureLimit + 1]
      old_element.Img_On:SetActive(false)
    end
    local element = View.Group_Image.ScrollView_Image.Viewport.Content.Group_TextureQuality.Img_Box.StaticGrid_TextureQuality.grid[index]
    element.Img_On:SetActive(true)
  end
  GameSetting:SetTextureLimit(num)
end

function DataModel:ResetImgValue()
  local callback = function()
    DataModel:SetNewImageQuality(GameSetting.defaultQuality + 1)
    DataModel:SetCityFPS(1)
    DataModel:SetTrainMapFPS(1)
    DataModel:SetNewFar(GameSetting.defaultDriveHorizon + 1)
    DataModel:SetShadow(GameSetting.defaultShadow)
    DataModel:SetBloom(GameSetting.defaultBloom)
    DataModel:SetNewTextureLimit(GameSetting.defaultTextureQuality + 1)
  end
  CommonTips.OnPrompt("是否恢复图像默认设置", nil, nil, callback)
end

function DataModel:ResetMusicValue()
  DataModel:SetSliderBG(8)
  DataModel:SetSliderMusic(8)
  DataModel:SetSliderRoleCV(8)
end

function DataModel:SetSliderBG(value)
  DataModel.Now_Bg = value
  View.Group_Sound.Group_MusicVolume.Img_Box.Slider_MusicVolume:SetSliderValue(DataModel.Now_Bg)
  View.Group_Sound.Group_MusicVolume.Img_Box.Slider_MusicVolume.Group_Base.Img_SoundValue.Txt_:SetText(math.floor(DataModel.Now_Bg))
end

function DataModel:SetSliderMusic(value)
  DataModel.Now_Music = value
  View.Group_Sound.Group_EffectVolume.Img_Box.Slider_MusicVolume:SetSliderValue(DataModel.Now_Music)
  View.Group_Sound.Group_EffectVolume.Img_Box.Slider_MusicVolume.Group_Base.Img_SoundValue.Txt_:SetText(math.floor(DataModel.Now_Music))
end

function DataModel:SetSliderRoleCV(value)
  DataModel.Now_RoleCV = value
  View.Group_Sound.Group_CvVolume.Img_Box.Slider_MusicVolume:SetSliderValue(DataModel.Now_RoleCV)
  View.Group_Sound.Group_CvVolume.Img_Box.Slider_MusicVolume.Group_Base.Img_SoundValue.Txt_:SetText(math.floor(DataModel.Now_RoleCV))
end

function DataModel:UpdateSound(index)
  if index == 1 then
    local value = DataModel.SoundList[DataModel.Now_Bg]
    SoundManager:SetBGMVolumePercent(value)
    DataModel.lastBg = DataModel.Now_Bg
    PlayerPrefs.SetInt("bg", DataModel.Now_Bg)
  end
  if index == 2 then
    local value = DataModel.SoundList[DataModel.Now_Music]
    SoundManager:SetSoundVolumePercent(value)
    DataModel.lastMusic = DataModel.Now_Music
    PlayerPrefs.SetInt("music", DataModel.Now_Music)
  end
  if index == 3 then
    local value = DataModel.SoundList[DataModel.Now_RoleCV]
    SoundManager:SetRoleVolumePercent(value)
    DataModel.lastRoleCV = DataModel.Now_RoleCV
    PlayerPrefs.SetInt("roleCV", DataModel.Now_RoleCV)
  end
end

function DataModel:GetTapUI(index)
  return View[DataModel.TopRightConfig[index].ui]
end

function DataModel:HideAllTaps()
  for k, v in pairs(DataModel.TopRightConfig) do
    self:GetTapUI(k):SetActive(false)
  end
end

return DataModel
