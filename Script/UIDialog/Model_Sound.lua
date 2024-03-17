local base = require("UIDialog/Model_PlotBase")
local Sound = Class.New("Sound", base)
local DataModel = require("UIDialog/UIDialogDataModel")

function Sound.Ctor()
end

function Sound:OnStart(ca)
  local sound
  local fadeOutDuration = DataModel.GetCurrentScaleValue(ca.duration)
  local fadeInDuration = DataModel.GetCurrentScaleValue(ca.fadeInDuration)
  local fadeOutVolume = ca.minVolume
  local fadeInVolume = ca.fadeInVolume
  Sound.isEnd = true
  if ca.switchTypeInt == 0 then
    if 0 < ca.soundId then
      sound = SoundManager:CreateSound(ca.soundId)
      if sound ~= nil then
        Sound.isEnd = false
        sound:SetEndCallBack(function()
          Sound.isEnd = true
        end)
        sound:Play()
      end
    end
  elseif ca.switchTypeInt == 1 then
    local BGM = SoundManager:GetBgmSource()
    if BGM ~= nil then
      Sound.isEnd = false
      DOTweenTools.DOFadeSound(BGM, fadeOutDuration, fadeOutVolume, function()
        Sound.isEnd = true
      end, true)
    end
  elseif ca.switchTypeInt == 2 then
    local BGM = SoundManager:GetBgmSource()
    if BGM ~= nil then
      DOTweenTools.DOFadeSound(BGM, fadeOutDuration, fadeOutVolume, function()
        if ca.soundId > 0 then
          sound = SoundManager:CreateSound(ca.soundId)
          if sound ~= nil then
            Sound.isEnd = false
            sound:SetEndCallBack(function()
              Sound.isEnd = true
            end)
            sound:Play()
            DOTweenTools.DOFadeSound(sound.audioSource, fadeInDuration, fadeInVolume, nil, true)
          end
        end
      end, true)
    elseif ca.soundId > 0 then
      sound = SoundManager:CreateSound(ca.soundId)
      if sound ~= nil then
        Sound.isEnd = false
        sound:SetEndCallBack(function()
          Sound.isEnd = true
        end)
        sound:Play()
        DOTweenTools.DOFadeSound(sound.audioSource, fadeInDuration, fadeInVolume, nil, true)
      end
    end
  end
end

function Sound:OnUpdate()
end

function Sound.GetState()
  return Sound.isEnd
end

function Sound:Dtor()
end

return Sound
