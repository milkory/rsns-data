local base = require("UIDialog/Model_PlotBase")
local DataModel = require("UIDialog/UIDialogDataModel")
local PlotRoleImgStatus = Class.New("PlotRoleImgStatus", base)

function PlotRoleImgStatus:Ctor()
end

local data, sequence, posIndex, duration, isSpine
local finish = false
local order = 0
local spineDoTween, imgDoTween, faceDoTween, shakeDoTween
local SetDark = function()
  finish = true
  local colorStr = "#9D9D9D"
  if isSpine then
    data.isBright = false
    data.spine:SetOrder(data.spine.order + order)
    spineDoTween = DOTweenTools.SpineAnimationDOColorCallback(data.spine, colorStr, duration, function()
      finish = true
    end)
  else
    imgDoTween = DOTweenTools.ImageDOColorCallback(data.image.self, colorStr, duration, function()
      finish = true
    end)
    faceDoTween = DOTweenTools.ImageDOColorCallback(data.face, colorStr, duration)
  end
end
local SetBright = function()
  local colorStr = "#FFFFFF"
  if isSpine then
    data.isBright = true
    data.spine:SetOrder(data.spine.order + order + 5)
    spineDoTween = DOTweenTools.SpineAnimationDOColorCallback(data.spine, colorStr, duration, function()
      finish = true
    end)
  else
    imgDoTween = DOTweenTools.ImageDOColorCallback(data.image.self, colorStr, duration, function()
      finish = true
    end)
    faceDoTween = DOTweenTools.ImageDOColorCallback(data.face, colorStr, duration)
    data.image.CachedTransform:SetAsLastSibling()
  end
end
local AroundShake = function()
  local trans = data.image.transform
  if isSpine then
    trans = data.spine.transform
  end
  shakeDoTween = DOTweenTools.DOShakePosition(trans, DataModel.GetCurrentScaleValue(1), 30, 0, 0, 0, function()
    finish = true
  end, 10, 90, false, false)
end
local UpAndDownShake = function()
  local trans = data.image.transform
  if isSpine then
    trans = data.spine.transform
  end
  local origin = trans.localPosition
  if sequence ~= nil then
    DOTweenTools.KillSequence(sequence)
  end
  sequence = DOTweenTools.NewSequence()
  sequence:Append(DOTweenTools.DOLocalMoveY(trans, origin.y + 50, DataModel.GetCurrentScaleValue(0.2), true)):Append(DOTweenTools.DOLocalMoveY(trans, origin.y, DataModel.GetCurrentScaleValue(0.1), true)):OnComplete(function()
    finish = true
  end)
end
local effectFunc = {
  Darken = function()
    SetDark()
  end,
  Brighten = function()
    SetBright()
  end,
  ShakeLeftRight = function()
    AroundShake()
  end,
  ShakeUpDown = function()
    UpAndDownShake()
  end
}

function PlotRoleImgStatus:OnStart(ca)
  spineDoTween = nil
  imgDoTween = nil
  faceDoTween = nil
  shakeDoTween = nil
  posIndex = ca.index
  duration = DataModel.GetCurrentScaleValue(ca.duration)
  isSpine = ca.isSpine
  finish = false
  data, order = DataModel.SetPaintData(DataModel.EnumSetPaintData.Find, posIndex)
  if data ~= nil then
    effectFunc[ca.status]()
  else
    finish = true
  end
end

function PlotRoleImgStatus.GetState()
  return finish
end

function PlotRoleImgStatus:OnUpdate()
  DataModel.SkipCurrentNode(function()
    if not finish then
      if spineDoTween ~= nil then
        DOTweenTools.Complete(spineDoTween)
      end
      if imgDoTween ~= nil then
        DOTweenTools.Complete(imgDoTween)
      end
      if faceDoTween ~= nil then
        DOTweenTools.Complete(faceDoTween)
      end
      if shakeDoTween ~= nil then
        DOTweenTools.Complete(shakeDoTween)
      end
      if sequence ~= nil then
        DOTweenTools.Complete(sequence)
      end
    end
  end)
end

function PlotRoleImgStatus:Dtor()
  data = nil
  DataModel.SetPaintData(DataModel.EnumSetPaintData.Remove, posIndex)
  if sequence ~= nil then
    DOTweenTools.KillSequence(sequence)
    sequence = nil
  end
end

return PlotRoleImgStatus
