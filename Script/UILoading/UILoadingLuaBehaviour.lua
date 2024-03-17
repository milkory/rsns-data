local View = require("UILoading/UILoadingView")
local DataModel = require("UILoading/UILoadingDataModel")
local ViewFunction = require("UILoading/UILoadingViewFunction")
local targetLoadingPercent, currentLoadingPercent, lastProgress
local loadingPercentMaxPerframe = 1
local r2y = 0.7
local y2g = 1
local delayFrame = 1
local delayIndex, isUseSpine
local PlaySound = function(no)
  if no == 0 then
    View.Group_Spine.Group_Sounds.Sound_Red:SetActive(true)
  elseif no == 1 then
    View.Group_Spine.Group_Sounds.Sound_Yellow:SetActive(true)
  else
    View.Group_Spine.Group_Sounds.Sound_Green:SetActive(true)
  end
end
local SetProgress = function(progress)
  targetLoadingPercent = progress
end
local ShowProgress = function(progress)
  if 1 < progress then
    progress = 1
  end
  if lastProgress == progress then
    return
  end
  if isUseSpine then
    if progress < r2y and 1 <= lastProgress then
      View.Group_Spine.Spine_BG:SetAction("jiazai6", false, true)
      View.Group_Spine.Spine_BG:SetAction("jiazai1", true)
      PlaySound(0)
    end
    if lastProgress < r2y and progress >= r2y then
      View.Group_Spine.Spine_BG:SetAction("jiazai2", false, true)
      View.Group_Spine.Spine_BG:SetAction("jiazai3", true)
      PlaySound(1)
    end
    if lastProgress < y2g and progress >= y2g then
      View.Group_Spine.Spine_BG:SetAction("jiazai4", false, true)
      View.Group_Spine.Spine_BG:SetAction("jiazai5", true, true)
      PlaySound(2)
    end
    if progress < 0.1 then
      View.Group_Spine.Group_Percent.Img_P1:SetActive(false)
      View.Group_Spine.Group_Percent.Img_P2:SetActive(false)
      View.Group_Spine.Group_Percent.Img_P3:SetActive(true)
      View.Group_Spine.Group_Percent.Img_P4:SetActive(true)
    elseif progress < 1 then
      View.Group_Spine.Group_Percent.Img_P1:SetActive(false)
      View.Group_Spine.Group_Percent.Img_P2:SetActive(true)
      View.Group_Spine.Group_Percent.Img_P3:SetActive(true)
      View.Group_Spine.Group_Percent.Img_P4:SetActive(true)
    else
      View.Group_Spine.Group_Percent.Img_P1:SetActive(true)
      View.Group_Spine.Group_Percent.Img_P2:SetActive(true)
      View.Group_Spine.Group_Percent.Img_P3:SetActive(true)
      View.Group_Spine.Group_Percent.Img_P4:SetActive(true)
    end
    local numRes = "UI/UIEffect/UI_jiazai_shuzi/SZ_"
    if progress < r2y then
      numRes = numRes .. "r_"
    elseif progress < y2g then
      numRes = numRes .. "y_"
    else
      numRes = numRes .. "g_"
    end
    local p = math.floor(progress * 100)
    local num1 = math.floor(p % 10)
    local num2 = math.floor(p / 10 % 10)
    local num3 = math.floor(p / 100)
    View.Group_Spine.Group_Percent.Img_P4:SetSprite(numRes .. "%")
    View.Group_Spine.Group_Percent.Img_P3:SetSprite(numRes .. tostring(num1))
    View.Group_Spine.Group_Percent.Img_P2:SetSprite(numRes .. tostring(num2))
    View.Group_Spine.Group_Percent.Img_P1:SetSprite(numRes .. tostring(num3))
  else
    View.Group_Png.Img_PB:SetFilledImgAmount(progress)
    local num = math.floor(progress * 100)
    local txt = tostring(num) .. "%"
    View.Group_Png.Txt_Percent:SetText(txt)
  end
  lastProgress = progress
end
local SetText = function(loadingText)
  View.Group_Spine.Txt_Tips:SetText(loadingText)
  View.Group_Png.Txt_Tips:SetText(loadingText)
end
local UsePNG = function(pngPath)
  View.Group_Png:SetActive(true)
  View.Group_Spine:SetActive(false)
  View.Group_Png.Img_PBBG:SetSprite("OriginPack/UI/Loading/pb2")
  View.Group_Png.Img_PB:SetSprite("OriginPack/UI/Loading/pb")
  isUseSpine = false
  if pngPath ~= nil and pngPath ~= "" then
    View.Group_Png.Img_BG:SetSprite(pngPath)
  end
  SetProgress(0)
end
local UseSpine = function()
  View.Group_Png:SetActive(false)
  View.Group_Spine:SetActive(true)
  View.Group_Spine.Spine_BG:SetData("UI/UIEffect/UI_jiazai/UI_jiazai_SkeletonData")
  View.Group_Spine.Spine_BG:SetMaterial("Shader/Spine/SkeletonGraphicDefault")
  View.Group_Spine.Group_Percent.Img_P1:SetSprite("UI/UIEffect/UI_jiazai_shuzi/SZ_r_1")
  View.Group_Spine.Group_Percent.Img_P2:SetSprite("UI/UIEffect/UI_jiazai_shuzi/SZ_r_0")
  View.Group_Spine.Group_Percent.Img_P3:SetSprite("UI/UIEffect/UI_jiazai_shuzi/SZ_r_0")
  View.Group_Spine.Group_Percent.Img_P4:SetSprite("UI/UIEffect/UI_jiazai_shuzi/SZ_r_%")
  View.Group_Spine.Group_Sounds.Sound_Red:SetSoundPrefab("Sound/UI/Loading/Ui_Loading_TrafficLights_Red")
  View.Group_Spine.Group_Sounds.Sound_Green:SetSoundPrefab("Sound/UI/Loading/Ui_Loading_TrafficLights_Green")
  View.Group_Spine.Group_Sounds.Sound_Yellow:SetSoundPrefab("Sound/UI/Loading/Ui_Loading_TrafficLights_Yellow")
  View.Group_Spine.Spine_BG:SetAction("jiazai1", true, true)
  PlaySound(0)
  isUseSpine = true
  SetProgress(0)
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    lastProgress = -1
    currentLoadingPercent = 0
    targetLoadingPercent = 0
    View.Group_Spine.Group_Sounds.Sound_Red:SetActive(false)
    View.Group_Spine.Group_Sounds.Sound_Yellow:SetActive(false)
    View.Group_Spine.Group_Sounds.Sound_Green:SetActive(false)
    SetText("")
    ShowProgress(currentLoadingPercent)
    delayIndex = 0
    if initParams ~= "" and initParams ~= nil then
      UsePNG(initParams)
    else
      UseSpine()
    end
    if CBus.currentScene ~= "Entrance" and LoadingManager.loadingText == "" then
      local data = GetCA(99900036).tipsList
      if data ~= nil and 0 < #data then
        LoadingManager.loadingText = data[math.random(1, #data)].tips
      end
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    SetProgress(LoadingManager.loadingPercent)
    SetText(LoadingManager.loadingText)
    if LoadingManager.isLoadingInitAniFinish == true then
      if currentLoadingPercent < targetLoadingPercent then
        currentLoadingPercent = currentLoadingPercent + loadingPercentMaxPerframe
      end
      if currentLoadingPercent > targetLoadingPercent then
        currentLoadingPercent = targetLoadingPercent
      end
    end
    ShowProgress(currentLoadingPercent)
    if LoadingManager.autoCloseLoading == true and 1 <= lastProgress then
      delayIndex = delayIndex + 1
      if delayIndex > delayFrame then
        LoadingManager:CloseLoading()
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
