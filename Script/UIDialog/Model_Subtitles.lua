local view = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local Subtitles = Class.New("PlotSubtitles", base)
local DataModel = require("UIDialog/UIDialogDataModel")
local finishFade = false
local finishContent = false
local finish = false
local pause = false
local Txt, data
local currentDelay = 0
local timer = 0

function Subtitles:Ctor()
  Txt = view.Txt_Subtitles
end

local ExchangeEffect = function()
  local effect = data.exchangeEffect
  local fadeDuration = DataModel.GetCurrentScaleValue(data.fadeDuration)
  if effect == "Null" then
    Txt:SetTextAlpha(1)
    finishFade = true
  elseif effect == "Fadein" then
    Txt:SetTextAlpha(0)
    Txt:SetTweenFade(1, fadeDuration, function()
      finishFade = true
    end)
  elseif effect == "FadeOut" then
    Txt:SetTextAlpha(1)
    Txt:SetTweenFade(0, fadeDuration, function()
      finishFade = true
    end)
  end
end

function Subtitles:PauseTween()
  if Txt ~= nil and not finishContent then
    Txt:PauseTween()
    pause = true
  end
end

function Subtitles:ContinueTween()
  if Txt ~= nil and not finishContent then
    Txt:PlayTween()
    pause = false
  end
end

function Subtitles:OnStart(ca)
  finishFade = false
  finishContent = false
  pause = false
  finish = false
  timer = 0
  currentDelay = DataModel.GetCurrentScaleValue(DataModel.intervalTime)
  data = ca
  local content = data.content
  if Txt == nil or content == nil or content == "" then
    finish = true
    Txt:SetActive(false)
  else
    Txt:SetActive(true)
    Txt:SetLocalPosition(Vector3(data.X, data.Y, 0))
    Txt:SetTweenContent(data.content, function()
      finishContent = true
    end, DataModel.GetCurrentScaleValue(DataModel.perCharSpeed))
    ExchangeEffect()
  end
end

function Subtitles.OnUpdate()
  if pause then
    return
  end
  if Input.GetMouseButtonDown(0) then
    if finishFade and finishContent then
      finish = true
    else
      Txt:CompleteTween()
    end
  end
  if DataModel.GetIsAuto() and not finish and finishFade and finishContent then
    timer = timer + Time.deltaTime
    if timer > currentDelay then
      finish = true
    end
  end
  if finish and DataModel.isAutoCloseSubtitles then
    Txt:SetActive(false)
  end
  DataModel.SkipCurrentNode(function()
    if not finish then
      currentDelay = DataModel.GetCurrentScaleValue(DataModel.intervalTime)
      if Txt ~= nil and not finishContent then
        Txt:CompleteTween()
      end
    end
  end)
end

function Subtitles.GetState()
  return finish
end

function Subtitles:Dtor()
end

return Subtitles
