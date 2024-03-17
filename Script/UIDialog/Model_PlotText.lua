local View = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local DataModel = require("UIDialog/UIDialogDataModel")
local DialogReviewDataModel = require("UIDialogReview/UIDialogReviewDataModel")
local Controller
local PlotText = Class.New("PlotText", base)

function PlotText:Ctor()
end

local plotCA, dialogObj, finish, finishTween, textList, textCount, curIndex, time, timer, pause
local ReplaceName = function(content)
  if content ~= nil and plotCA.isReplaceName then
    local userInfo = PlayerData:GetUserInfo()
    local playerName = ""
    if userInfo ~= nil then
      playerName = userInfo.role_name
    end
    content = string.gsub(content, plotCA.replaceType, playerName)
  end
  return content
end
local OpenDialogView = function()
  View.Btn_Dialog.self:SetActive(true)
  View.Img_Bg:SetActive(true)
end

function PlotText.Ctor()
  timer = 0
  pause = false
  finish = false
  finishTween = false
  View.Btn_Dialog.Img_Continue:SetActive(false)
  OpenDialogView()
  dialogObj = View.Btn_Dialog.Txt_Dialog
  if not Controller then
    Controller = require("UIDialog/Model_PlotController")
  end
end

local lastFaceID
local SetImgOrSpine = function()
  View.Img_Face:SetActive(true)
  local spine = View.Img_Face.SpineAnimation_Role
  local role = View.Img_Face.Img_Paint
  local localPosition = spine.transform.localPosition
  local faceID = -1
  if textList[curIndex] ~= nil and textList[curIndex].faceID ~= nil then
    faceID = textList[curIndex].faceID
  end
  if faceID == 0 then
    spine:SetActive(false)
    role:SetActive(false)
  elseif faceID == -1 and 0 < lastFaceID then
    return
  elseif 0 < faceID then
    lastFaceID = faceID
    local faceIDCA = PlayerData:GetFactoryData(faceID, "PlotFactory")
    if faceIDCA.roleSpine ~= nil and 0 < faceIDCA.roleSpine then
      local roleSpineCA = PlayerData:GetFactoryData(faceIDCA.roleSpine, "PlotFactory")
      local data = PlayerData:GetFactoryData(roleSpineCA.unitViewID, "UnitViewFactory")
      if data and data.spineUrl and data.spineUrl ~= "" then
        spine:SetData(data.spineUrl)
        spine:SetLocalScale(Vector3(faceIDCA.scaleX, faceIDCA.scaleY, 1))
        spine:SetLocalPosition(Vector3(faceIDCA.offsetX, faceIDCA.offsetY, localPosition.z))
        spine:SetActive(true)
        if roleSpineCA.prepareAniName ~= nil and roleSpineCA.prepareAniName ~= "" then
          if roleSpineCA.prepareAniDuration == 0 then
            local unitViewID = roleSpineCA.unitViewID
            local aniName = roleSpineCA.aniName
            local isLoop = roleSpineCA.isLoop
            local isChangeImmediately = roleSpineCA.isChangeImmediately
            spine:SetPrepareAniAction(roleSpineCA.prepareAniName, function()
              if unitViewID == roleSpineCA.unitViewID and aniName == roleSpineCA.aniName and isLoop == roleSpineCA.isLoop and isChangeImmediately == roleSpineCA.isChangeImmediately then
                spine:SetAction(aniName, isLoop, isChangeImmediately)
              end
            end)
          elseif 0 < roleSpineCA.prepareAniDuration then
            spine:SetAction(roleSpineCA.prepareAniName, roleSpineCA.isLoop, roleSpineCA.isChangeImmediately)
          end
        else
          spine:SetAction(roleSpineCA.aniName, roleSpineCA.isLoop, roleSpineCA.isChangeImmediately)
        end
      end
    elseif faceIDCA.role ~= nil and 0 < faceIDCA.role then
      local roleCA = PlayerData:GetFactoryData(faceIDCA.role, "PlotFactory")
      local faceIndex = roleCA.faceIndex
      local faces = roleCA.faces
      local imageFace = role.Img_Face
      if 0 < faceIndex and faceIndex <= table.count(faces) then
        imageFace:SetPos(roleCA.faceX, roleCA.faceY)
        imageFace:SetSprite(faces[faceIndex].face)
      elseif roleCA.exchangeEffect ~= "FadeOut" then
        imageFace:ClearSprite()
      end
      if 0 < roleCA.unitID then
        local portraitId = PlayerData:GetFactoryData(roleCA.unitID, "UnitFactory").viewId
        local portraitData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
        if portraitData.plotResList ~= nil then
          local resName = portraitData.plotResList[roleCA.portraitIndex]
          if roleCA.portraitIndex > #portraitData.plotResList then
            resName = portraitData.plotResList[#portraitData.plotResList]
          end
          if resName == nil or resName == "" then
            role:SetActive(false)
          else
            localPosition = role.transform.localPosition
            role:SetSprite(resName.plotResUrl)
            role:SetLocalScale(Vector3(faceIDCA.scaleX, faceIDCA.scaleY, 1))
            role:SetLocalPosition(Vector3(localPosition.x + faceIDCA.offsetX, localPosition.y + faceIDCA.offsetY, localPosition.z))
            role:SetActive(true)
          end
        end
      end
    end
  elseif plotCA.roleSpine ~= nil and 0 < plotCA.roleSpine then
    local roleSpineCA = PlayerData:GetFactoryData(plotCA.roleSpine, "PlotFactory")
    if 0 < roleSpineCA.unitViewID then
      do
        local data = PlayerData:GetFactoryData(roleSpineCA.unitViewID, "UnitViewFactory")
        if data and data.spineUrl and data.spineUrl ~= "" then
          spine:SetData(data.spineUrl)
          spine:SetLocalScale(Vector3(plotCA.scaleX, plotCA.scaleY, 1))
          spine:SetLocalPosition(Vector3(plotCA.offsetX, plotCA.offsetY, localPosition.z))
          spine:SetActive(true)
          if roleSpineCA.prepareAniName ~= nil and roleSpineCA.prepareAniName ~= "" then
            if roleSpineCA.prepareAniDuration == 0 then
              local unitViewID = roleSpineCA.unitViewID
              local aniName = roleSpineCA.aniName
              local isLoop = roleSpineCA.isLoop
              local isChangeImmediately = roleSpineCA.isChangeImmediately
              spine:SetPrepareAniAction(roleSpineCA.prepareAniName, function()
                if unitViewID == roleSpineCA.unitViewID and aniName == roleSpineCA.aniName and isLoop == roleSpineCA.isLoop and isChangeImmediately == roleSpineCA.isChangeImmediately then
                  spine:SetAction(aniName, isLoop, isChangeImmediately)
                end
              end)
            elseif 0 < roleSpineCA.prepareAniDuration then
              spine:SetAction(roleSpineCA.prepareAniName, roleSpineCA.isLoop, roleSpineCA.isChangeImmediately)
            end
          else
            spine:SetAction(roleSpineCA.aniName, roleSpineCA.isLoop, roleSpineCA.isChangeImmediately)
          end
        end
      end
    end
  elseif plotCA.role ~= nil and 0 < plotCA.role then
    local roleCA = PlayerData:GetFactoryData(plotCA.role, "PlotFactory")
    local faceIndex = roleCA.faceIndex
    local faces = roleCA.faces
    local imageFace = role.Img_Face
    if 0 < faceIndex and faceIndex <= table.count(faces) then
      imageFace:SetPos(roleCA.faceX, roleCA.faceY)
      imageFace:SetSprite(faces[faceIndex].face)
    elseif roleCA.exchangeEffect ~= "FadeOut" then
      imageFace:ClearSprite()
    end
    if 0 < roleCA.unitID then
      local portraitId = PlayerData:GetFactoryData(roleCA.unitID, "UnitFactory").viewId
      local portraitData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
      if portraitData.plotResList ~= nil then
        local resName = portraitData.plotResList[roleCA.portraitIndex]
        if roleCA.portraitIndex > #portraitData.plotResList then
          resName = portraitData.plotResList[#portraitData.plotResList]
        end
        if resName == nil or resName == "" then
          role:SetActive(false)
        else
          localPosition = role.transform.localPosition
          role:SetSprite(resName.plotResUrl)
          role:SetLocalScale(Vector3(plotCA.scaleX, plotCA.scaleY, 1))
          role:SetLocalPosition(Vector3(localPosition.x + plotCA.offsetX, localPosition.y + plotCA.offsetY, localPosition.z))
          role:SetActive(true)
        end
      end
    end
  end
end
local SetSpeakerName = function()
  if textCount == 0 or textList[curIndex].speakerName == nil or textList[curIndex].speakerName == "" then
    View.Img_Speaker.self:SetActive(false)
  else
    View.Img_Speaker.self:SetActive(true)
    View.Img_Speaker.Txt_Speaker:SetText(ReplaceName(textList[curIndex].speakerName))
  end
end
local SetContent = function()
  finishTween = false
  if textCount == 0 then
    finishTween = true
    dialogObj:SetActive(false)
    return
  end
  if not DataModel.GetIsAuto() then
    local uiSoundConfig = PlayerData:GetFactoryData(99900002, "ConfigFactory")
    local soundId = uiSoundConfig.PlotTextChange
    if 0 < soundId then
      local sound = SoundManager:CreateSound(soundId)
      if sound ~= nil then
        sound:Play()
      end
    end
  end
  dialogObj:SetActive(true)
  dialogObj:SetTweenContent(ReplaceName(textList[curIndex].content), function()
    finishTween = true
  end, DataModel.GetCurrentScaleValue(DataModel.perCharSpeed))
end
local SetValue = function()
  timer = 0
  curIndex = curIndex + 1
  DialogReviewDataModel.contentId = curIndex
  SetSpeakerName()
  SetContent()
  SetImgOrSpine()
end

function PlotText:OnStart(ca)
  time = DataModel.GetCurrentScaleValue(DataModel.intervalTime)
  plotCA = ca
  textList = plotCA.contextList
  textCount = #textList
  lastFaceID = -1
  curIndex = 0
  if plotCA.textTypeInt == 1 and DataModel.isBoy == false or plotCA.textTypeInt == 2 and DataModel.isBoy then
    finish = true
    return
  end
  dialogObj:SetAlignment(ca.alignmentInt)
  SetValue()
  if textCount == 0 then
    finish = true
  end
end

function PlotText:OnUpdate()
  if finish then
    return
  end
  DataModel.SkipCurrentNode(function()
    time = DataModel.GetCurrentScaleValue(DataModel.intervalTime)
    if dialogObj:IsNull() == false and not finishTween then
      dialogObj:CompleteTween()
    end
  end)
  View.Btn_Dialog.Img_Continue:SetActive(DataModel.GetIsAuto() == false and finishTween)
  if DataModel.GetIsAuto() and finishTween and curIndex < textCount and not pause then
    timer = timer + Time.deltaTime
    if timer >= time then
      SetValue()
    end
  end
  if (textCount == 0 or curIndex == textCount) and finishTween then
    if 0 < plotCA.keepTime then
      timer = timer + Time.deltaTime
      if timer >= plotCA.keepTime then
      else
        return
      end
    end
    if DataModel.GetIsAuto() then
      timer = timer + Time.deltaTime
      if timer >= time then
        finish = true
      end
    end
  end
  if Input.GetMouseButtonDown(0) and not pause then
    local obj = PlotManager:GetRaycastHitObj(Input.mousePosition)
    if obj ~= nil and obj == View.Btn_Dialog.self.gameObject then
      if curIndex < textCount then
        SetValue()
      elseif textCount == 0 or finishTween then
        finish = true
      else
        dialogObj:CompleteTween()
      end
    end
  end
end

function PlotText:PauseTween()
  if dialogObj ~= nil and dialogObj:IsNull() == false and not finishTween then
    dialogObj:PauseTween()
  end
  pause = true
end

function PlotText:ContinueTween()
  if dialogObj ~= nil and dialogObj:IsNull() == false and not finishTween then
    dialogObj:PlayTween()
  end
  pause = false
end

function PlotText.GetState()
  if finish then
    View.Btn_Dialog.Img_Continue:SetActive(false)
    require("UIDialogTips/UIDialogTipsController").CloseTips(1.0 / DataModel.GetCurrentScaleValue(1))
  end
  return finish
end

function PlotText.SetLastValue(ca)
  textList = ca.contextList
  textCount = #textList
  if dialogObj:IsNull() == false then
    dialogObj:SetActive(true)
  end
  plotCA = ca
  dialogObj:SetText(ReplaceName(textList[textCount].content))
  curIndex = textCount
  SetSpeakerName()
end

function PlotText:Dtor()
  dialogObj = nil
end

return PlotText
