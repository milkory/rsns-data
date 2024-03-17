local base = require("UIDialog/Model_PlotBase")
local DataModel = require("UIDialog/UIDialogDataModel")
local RoleSpine = Class.New("RoleSpineBase", base)

function RoleSpine.Ctor(thisClass)
  thisClass.finishFade = false
  thisClass.finishMove = false
  thisClass.finish = false
  thisClass.finishPrepare = true
  thisClass.curPrepareAniIndex = 0
  thisClass.fadeDoTween = nil
  thisClass.moveDoTween = nil
end

local SetFade = function(thisClass)
  local startA = 0
  local endA = 0
  local isAni = true
  if thisClass.spineCA.exchangeEffect == "Fadein" then
    endA = 1
  elseif thisClass.spineCA.exchangeEffect == "FadeOut" then
    startA = 1
  elseif thisClass.spineCA.exchangeEffect == "Null" then
    isAni = false
  end
  if isAni then
    thisClass.fadeDoTween = DOTweenTools.DOFadeSpineCallback(thisClass.spine, thisClass.spineCA.colorStr, startA, endA, DataModel.GetCurrentScaleValue(thisClass.spineCA.fadeDuration), function()
      if endA == 0 then
        DataModel.SetPaintData(DataModel.EnumSetPaintData.Remove, thisClass.spineCA.toIndex)
        thisClass.spine:ReleaseRes()
        thisClass.spine:SetActive(false)
      end
      thisClass.finishFade = true
    end)
  else
    thisClass.finishFade = true
  end
end
local Move = function(thisClass)
  local pos = DataModel.PlotPos
  local fromIndex = thisClass.spineCA.fromIndex
  local toIndex = thisClass.spineCA.toIndex
  if thisClass.spineCA.duration < 0.001 then
    thisClass.spine:SetPos(pos[toIndex] + thisClass.spineCA.toOffsetX, thisClass.spineCA.toOffsetY)
    thisClass.finishMove = true
  else
    thisClass.spine:SetPos(pos[fromIndex] + thisClass.spineCA.fromOffsetX, thisClass.spineCA.fromOffsetY)
    thisClass.moveDoTween = DOTweenTools.DOLocalMoveCallback(thisClass.spine.transform, pos[toIndex] + thisClass.spineCA.toOffsetX, thisClass.spineCA.toOffsetY, 0, DataModel.GetCurrentScaleValue(thisClass.spineCA.duration), function()
      thisClass.finishMove = true
    end, thisClass.spineCA.easeInt, true)
  end
end
local SetSpine = function(order, thisClass, is_load)
  if thisClass.spineCA.unitViewID > 0 then
    local data = PlayerData:GetFactoryData(thisClass.spineCA.unitViewID, "UnitViewFactory")
    if data and data.spineUrl and data.spineUrl ~= "" then
      thisClass.spine:SetData(data.spineUrl)
      thisClass.spine:SetLocalScale(Vector3(thisClass.spineCA.scaleX, thisClass.spineCA.scaleY, 1))
      thisClass.spine:SetActive(true)
      thisClass.finishPrepare = true
      if thisClass.spineCA.prepareAniName ~= nil and thisClass.spineCA.prepareAniName ~= "" then
        if thisClass.spineCA.prepareAniDuration == 0 then
          local aniName = thisClass.spineCA.aniName
          local isLoop = thisClass.spineCA.isLoop
          local isChangeImmediately = thisClass.spineCA.isChangeImmediately
          thisClass.spine:SetPrepareAniAction(thisClass.spineCA.prepareAniName, function()
            if thisClass ~= nil and thisClass.spine ~= nil then
              thisClass.spine:SetAction(aniName, isLoop, isChangeImmediately)
            end
          end)
        elseif 0 < thisClass.spineCA.prepareAniDuration then
          thisClass.spine:SetAction(thisClass.spineCA.prepareAniName, thisClass.spineCA.isLoop, thisClass.spineCA.isChangeImmediately)
          thisClass.finishPrepare = false
          thisClass.curPrepareAniIndex = thisClass.spineCA.prepareAniDuration
        end
      else
        thisClass.spine:SetAction(thisClass.spineCA.aniName, thisClass.spineCA.isLoop, thisClass.spineCA.isChangeImmediately)
      end
    end
  end
  if is_load then
    local pos = DataModel.PlotPos
    local toIndex = thisClass.spineCA.toIndex
    thisClass.spine:SetPos(pos[toIndex] + thisClass.spineCA.toOffsetX, thisClass.spineCA.toOffsetY)
    return
  end
  SetFade(thisClass)
  if thisClass.spineCA.onlySetFadeOut == true and thisClass.spineCA.exchangeEffect == "FadeOut" then
    thisClass.finishMove = true
    return
  end
  Move(thisClass)
end

function RoleSpine:OnStart(ca, plotIndex)
  self.fadeDoTween = nil
  self.moveDoTween = nil
  self.finish = false
  self.spineCA = ca
  local order = 0
  if self.spineCA.exchangeEffect == "FadeOut" then
    self.spine, order = DataModel.SetPaintData(DataModel.EnumSetPaintData.Find, self.spineCA.fromIndex)
  else
    self.spine, order = DataModel.AddPaintData(self.spineCA, self.spineCA.toIndex, true, self.spineCA.alwaysTop)
  end
  if self.spine == nil then
    self.finishPrepare = true
    self.finishMove = true
    self.finishFade = true
  else
    self.spine.isBright = true
    self.spine = self.spine.spine
    SetSpine(order, self)
    self.spine:SetOrder(order + self.spine.order + 5)
  end
  return true
end

function RoleSpine:LoadRole(ca)
  self.spineCA = ca
  local order = 0
  if self.spineCA.exchangeEffect == "FadeOut" then
    self.spine, order = DataModel.SetPaintData(DataModel.EnumSetPaintData.Find, self.spineCA.fromIndex)
  else
    self.spine, order = DataModel.AddPaintData(self.spineCA, self.spineCA.toIndex, true)
    order = ca.now_order or order
  end
  if self.spine == nil then
    self.finishPrepare = true
    self.finishMove = true
    self.finishFade = true
  else
    self.spine.isBright = true
    self.spine = self.spine.spine
    SetSpine(order, self, true)
    self.spine:SetOrder(order + self.spine.order + 5)
  end
end

function RoleSpine:OnUpdate()
  self.finish = self.finishFade and self.finishMove and self.finishPrepare
  if self.finish then
    return
  end
  if self.finishPrepare == false then
    if self.curPrepareAniIndex < 0 then
      self.finishPrepare = true
      self.spine:SetAction(self.spineCA.aniName, self.spineCA.isLoop, self.spineCA.isChangeImmediately)
    end
    self.curPrepareAniIndex = self.curPrepareAniIndex - 1
  end
  DataModel.SkipCurrentNode(function()
    if not self.finishFade and self.fadeDoTween ~= nil then
      DOTweenTools.Complete(self.fadeDoTween)
    end
    if not self.finishMove and self.moveDoTween ~= nil then
      DOTweenTools.Complete(self.moveDoTween)
    end
    if not self.finishPrepare then
      self.curPrepareAniIndex = -1
    end
  end)
end

function RoleSpine.GetState(thisClass)
  return thisClass.finish
end

function RoleSpine:Dtor()
  DataModel.SetDefaultData()
  self.spine = nil
  self.moveDoTween = nil
end

return RoleSpine
