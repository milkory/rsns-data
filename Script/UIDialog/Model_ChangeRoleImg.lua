local base = require("UIDialog/Model_PlotBase")
local DataModel = require("UIDialog/UIDialogDataModel")
local PlotChangeRoleImg = Class.New("PlotChangeRoleImg", base)
local plotCA, imageObj, resName, fadeDoTween, fadeFaceDoTween
local finishFade = false
local moveDoTween
local finishMove = false
local Move = function()
  local pos = DataModel.PlotPos
  local fromIndex = plotCA.fromIndex
  local toIndex = plotCA.toIndex
  imageObj:SetLocalScale(Vector3(plotCA.scaleX, plotCA.scaleY, 1))
  if plotCA.duration < 0.001 then
    imageObj:SetPos(pos[toIndex] + plotCA.toOffsetX, plotCA.toOffsetY)
    finishMove = true
  else
    imageObj:SetPos(pos[fromIndex] + plotCA.fromOffsetX, plotCA.fromOffsetY)
    moveDoTween = DOTweenTools.DOLocalMoveCallback(imageObj.transform, pos[toIndex] + plotCA.toOffsetX, plotCA.toOffsetY, 0, DataModel.GetCurrentScaleValue(plotCA.duration), function()
      finishMove = true
    end, plotCA.easeInt, true)
  end
end
local SetImageShow = function()
  local faceIndex = plotCA.faceIndex
  local faces = plotCA.faces
  local imageFace = imageObj.Img_Face
  if 0 < faceIndex and faceIndex <= table.count(faces) then
    imageFace:SetPos(plotCA.faceX, plotCA.faceY)
    imageFace:SetSprite(faces[faceIndex].face)
  elseif plotCA.exchangeEffect ~= "FadeOut" then
    imageFace:ClearSprite()
  end
  local fadeDuration = DataModel.GetCurrentScaleValue(plotCA.fadeDuration)
  if plotCA.exchangeEffect == "Fadein" and 0 < plotCA.unitID then
    local portraitId = PlayerData:GetFactoryData(plotCA.unitID, "UnitFactory").viewId
    local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    if portrailData.plotResList ~= nil then
      if plotCA.portraitIndex > #portrailData.plotResList then
        resName = portrailData.plotResList[#portrailData.plotResList]
      else
        resName = portrailData.plotResList[plotCA.portraitIndex]
      end
      if resName == nil or resName == "" then
        imageObj:SetActive(false)
      else
        imageObj:SetSprite(resName.plotResUrl)
        imageObj:SetActive(true)
        imageObj.CachedTransform:SetAsLastSibling()
        Move()
        fadeDoTween = DOTweenTools.DOFadeCallback(imageObj.transform, 0, 1, fadeDuration, function()
          finishFade = true
        end, plotCA.fadeEaseInt, false, plotCA.colorStr)
        fadeFaceDoTween = DOTweenTools.DOFadeCallback(imageFace.transform, 0, 1, fadeDuration, nil, plotCA.fadeEaseInt, false, plotCA.colorStr)
      end
    end
  elseif plotCA.exchangeEffect == "FadeOut" then
    Move()
    fadeFaceDoTween = DOTweenTools.DOFadeCallback(imageFace.transform, 1, 0, fadeDuration, nil, plotCA.fadeEaseInt, true)
    fadeDoTween = DOTweenTools.DOFadeCallback(imageObj.transform, 1, 0, fadeDuration, function()
      finishFade = true
      DataModel.SetPaintData(DataModel.EnumSetPaintData.Remove, plotCA.toIndex)
      imageObj:SetActive(false)
    end, plotCA.fadeEaseInt, true)
  elseif plotCA.exchangeEffect == "Null" and 0 < plotCA.unitID then
    local portraitId = PlayerData:GetFactoryData(plotCA.unitID, "UnitFactory").viewId
    local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    if portrailData.plotResList ~= nil then
      if plotCA.portraitIndex > #portrailData.plotResList then
        resName = portrailData.plotResList[#portrailData.plotResList]
      else
        resName = portrailData.plotResList[plotCA.portraitIndex]
      end
      if resName == nil or resName == "" then
        imageObj:SetActive(false)
      else
        imageObj:SetSprite(resName.plotResUrl)
        imageObj:SetActive(true)
        imageObj.CachedTransform:SetAsLastSibling()
        finishFade = true
      end
    end
    finishMove = true
  end
end

function PlotChangeRoleImg:Ctor()
  resName = nil
  finishFade = false
  finishMove = false
end

function PlotChangeRoleImg:OnStart(ca)
  plotCA = ca
  imageObj = DataModel.AddPaintData(ca, plotCA.toIndex)
  fadeDoTween = nil
  fadeFaceDoTween = nil
  moveDoTween = nil
  if imageObj == nil then
    finishFade = true
    finishMove = true
  else
    SetImageShow()
  end
  return true
end

function PlotChangeRoleImg.GetState()
  return finishFade and finishMove
end

function PlotChangeRoleImg.OnUpdate()
  DataModel.SkipCurrentNode(function()
    if not finishFade then
      if fadeDoTween ~= nil then
        DOTweenTools.Complete(fadeDoTween)
      end
      if fadeFaceDoTween ~= nil then
        DOTweenTools.Complete(fadeFaceDoTween)
      end
    end
    if not finishMove and moveDoTween ~= nil then
      DOTweenTools.Complete(moveDoTween)
    end
  end)
end

function PlotChangeRoleImg:Dtor()
  imageObj = nil
  DataModel.SetPaintData(DataModel.EnumSetPaintData.Remove, plotCA.toIndex)
end

return PlotChangeRoleImg
