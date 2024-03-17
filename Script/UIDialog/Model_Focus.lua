local base = require("UIDialog/Model_PlotBase")
local Focus = Class.New("Focus", base)
local View = require("UIDialog/UIDialogView")
local DataModel = require("UIDialog/UIDialogDataModel")
local moveDoTween
local isMoveFinish = false
local scaleDoTween
local isScaleFinish = false

function Focus.Ctor()
  isMoveFinish = false
  isScaleFinish = false
end

function Focus:OnStart(ca)
  moveDoTween = nil
  scaleDoTween = nil
  local shake = View.Group_Shake
  local index = ca.index
  local scale = ca.zoomRate
  local duration = DataModel.GetCurrentScaleValue(ca.duration)
  local easeInt = ca.easeInt
  if 5 < index then
    index = 5
  elseif index < 1 then
    index = 1
  end
  local posX = -DataModel.PlotPos[index] * scale
  moveDoTween = DOTweenTools.DOLocalMoveCallback(shake.transform, posX - ca.offsetX, -ca.offsetY, 0, duration, function()
    isMoveFinish = true
  end, easeInt, true)
  scaleDoTween = DOTweenTools.DOScaleCallback(shake.transform, scale, duration, function()
    isScaleFinish = true
  end, easeInt, true)
end

function Focus:OnUpdate()
  DataModel.SkipCurrentNode(function()
    if not isMoveFinish and moveDoTween ~= nil then
      DOTweenTools.Complete(moveDoTween)
    end
    if not isScaleFinish and scaleDoTween ~= nil then
      DOTweenTools.Complete(scaleDoTween)
    end
  end)
end

function Focus.GetState()
  return isMoveFinish and isScaleFinish
end

function Focus:Dtor()
end

return Focus
