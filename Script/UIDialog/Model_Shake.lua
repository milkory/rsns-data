local base = require("UIDialog/Model_PlotBase")
local Shake = Class.New("Shake", base)
local View = require("UIDialog/UIDialogView")
local DataModel = require("UIDialog/UIDialogDataModel")
local isFinish = false
local doTween

function Shake.Ctor()
  isFinish = false
end

function Shake:OnStart(ca)
  doTween = nil
  local duration = DataModel.GetCurrentScaleValue(ca.duration)
  if ca.isView then
    doTween = DOTweenTools.DOShakePosition(View.Group_Shake.transform, duration, ca.x, ca.y, 0, ca.easeInt, function()
      isFinish = true
    end, ca.vibrato, 90, false, false)
  else
    doTween = DOTweenTools.CameraDOShakePosition(duration, ca.x, ca.y, 0, ca.easeInt, function()
      isFinish = true
    end, ca.vibrato, 90, false)
  end
end

function Shake:OnUpdate()
  DataModel.SkipCurrentNode(function()
    if not isFinish and doTween ~= nil then
      DOTweenTools.Complete(self.doTween)
    end
  end)
end

function Shake.GetState()
  return isFinish
end

function Shake:Dtor()
end

return Shake
