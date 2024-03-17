local base = require("UIDialog/Model_PlotBase")
local PlotImgMove = Class.New("Model_PlotImgMove", base)
local DataModel = require("UIDialog/UIDialogDataModel")
local finish = false
local doTween

function PlotImgMove:Ctor()
  finish = false
end

function PlotImgMove:OnStart(ca)
  doTween = nil
  local data = DataModel.SetPaintData(DataModel.EnumSetPaintData.Find, ca.portraitIndex)
  if data ~= nil then
    local obj = data.image
    if ca.isSpine then
      obj = data.spine
    end
    local pos = obj.transform.localPosition
    local targetPosX = DataModel.PlotPos[ca.targetPortraitIndex]
    if ca.portraitIndex ~= ca.targetPortraitIndex then
      data.posIndex = -2
    end
    doTween = DOTweenTools.DOLocalMoveCallback(obj.transform, targetPosX + ca.offsetX, pos.y + ca.offsetY, 0, DataModel.GetCurrentScaleValue(ca.duration), function()
      DataModel.SetPaintData(DataModel.EnumSetPaintData.Remove, ca.targetPortraitIndex)
      data.posIndex = ca.targetPortraitIndex
      if data.isBright == true then
        data.spine:SetOrder(data.spine.order + data.posIndex + 5)
      else
        data.spine:SetOrder(data.spine.order + data.posIndex)
      end
      finish = true
    end, ca.easeInt, true)
  end
end

function PlotImgMove.Move2TargetPos(ca)
  local data = DataModel.SetPaintData(DataModel.EnumSetPaintData.Find, ca.portraitIndex)
  if data ~= nil then
    local obj = data.image
    if ca.isSpine then
      obj = data.spine
    end
    local pos = obj.transform.localPosition
    local targetPosX = DataModel.PlotPos[ca.targetPortraitIndex]
    obj.transform.localPosition = Vector3(targetPosX + ca.offsetX, pos.y + ca.offsetY, 0)
    data.posIndex = ca.targetPortraitIndex
    finish = true
  end
end

function PlotImgMove.GetState()
  return finish
end

function PlotImgMove:OnUpdate()
  DataModel.SkipCurrentNode(function()
    if not finish and doTween ~= nil then
      DOTweenTools.Complete(doTween)
    end
  end)
end

function PlotImgMove:Dtor()
end

return PlotImgMove
