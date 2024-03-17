local base = require("UIDialog/Model_PlotBase")
local Mask = Class.New("Mask", base)
local View = require("UIDialog/UIDialogView")
local DataModel = require("UIDialog/UIDialogDataModel")
local isFinish = false
local doTween, mask

function Mask.Ctor()
  isFinish = false
  mask = View.Img_Transit
  mask:SetActive(true)
end

function Mask:OnStart(ca)
  doTween = nil
  local resPath = ca.resPath
  local r = ca.r
  local g = ca.g
  local b = ca.b
  if resPath == nil or resPath == "" then
    mask:ClearSprite()
  else
    r = 1
    g = 1
    b = 1
    mask:SetSprite(resPath)
  end
  doTween = DOTweenTools.ImageDOFadeCallback(mask.transform, r, g, b, ca.aStart, ca.aEnd, DataModel.GetCurrentScaleValue(ca.duration), function()
    isFinish = true
  end, ca.easeInt, true)
end

function Mask:OnUpdate()
  DataModel.SkipCurrentNode(function()
    if not isFinish and doTween ~= nil then
      DOTweenTools.Complete(doTween)
    end
  end)
end

function Mask.GetState()
  return isFinish
end

function Mask:Dtor()
end

return Mask
