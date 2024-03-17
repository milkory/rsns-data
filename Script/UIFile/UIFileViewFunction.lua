local View = require("UIFile/UIFileView")
local DataModel = require("UIFile/UIFileDataModel")
local sound, coroutineSound, lastProcessBar, nowProcessBar, lastSelectPanel, nowsoundId, lastVoiceBg, img_VoiceBg
local SetSliderValue = function(processBar, value)
  local width = DataModel.processBarWidth
  if processBar then
    processBar:SetWidth(value * width)
  end
end
local ClearLuaObj = function()
  View.Group_Audio.Img_AudioTextBg:SetActive(false)
  if DataModel.soundIsExist == false then
    if coroutineSound then
      View.self:StopC(coroutineSound)
    end
    return
  end
  SetSliderValue(nowProcessBar, 0)
  if coroutineSound then
    View.self:StopC(coroutineSound)
  end
  if sound and sound.audioSource then
    sound:Stop()
  end
  sound = nil
  coroutineSound = nil
  lastProcessBar = nil
  nowProcessBar = nil
  lastSelectPanel = nil
  nowsoundId = nil
  img_VoiceBg = nil
  lastVoiceBg = nil
end
local PlayRoleSound = function(soundId, data)
  if sound ~= nil and sound.audioSource then
    sound:Stop()
  end
  if coroutineSound then
    View.self:StopC(coroutineSound)
  end
  nowsoundId = soundId
  View.Group_Audio.Img_AudioTextBg:SetActive(true)
  local StoryText = data.StoryText
  View.Group_Audio.Img_AudioTextBg.Txt_Text:SetText(StoryText)
  local txtHeight = View.Group_Audio.Img_AudioTextBg.Txt_Text:GetHeight()
  View.Group_Audio.Img_AudioTextBg:SetHeight(txtHeight + 80)
  View.Group_Audio.Img_AudioTextBg.Txt_Text:SetHeight(txtHeight)
  View.Group_Audio.Img_AudioTextBg.Txt_Text:SetTweenContent(StoryText)
  if DataModel.soundIsExist == false then
    coroutineSound = View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(3))
      View.Group_Audio.Img_AudioTextBg:SetActive(false)
    end))
    return
  end
  sound = SoundManager:CreateSound(soundId)
  if sound ~= nil then
    sound:Play()
    if lastVoiceBg and img_VoiceBg ~= lastVoiceBg then
      lastVoiceBg.gameObject:SetActive(false)
    end
    SetSliderValue(lastProcessBar, 0)
    coroutineSound = View.self:StartC(LuaUtil.cs_generator(function()
      local time = 0
      local soundTime = sound.audioSource.clip.length
      while time < soundTime do
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
        time = time + 0.05
        SetSliderValue(nowProcessBar, time / soundTime)
      end
      SetSliderValue(nowProcessBar, 1)
      coroutine.yield(CS.UnityEngine.WaitForSeconds(1))
      SetSliderValue(nowProcessBar, 0)
      View.Group_Audio.Img_AudioTextBg:SetActive(false)
      img_VoiceBg.gameObject:SetActive(false)
      nowsoundId = nil
    end))
  end
end
local SwitchRoleSoundPanel = function(soundType, gridController)
  local data
  if soundType == 1 then
    View.Group_Audio.Group_Audio1:SetActive(true)
    View.Group_Audio.Btn_Audio1.Img_Off:SetActive(false)
    View.Group_Audio.Group_Audio2:SetActive(false)
    View.Group_Audio.Btn_Audio2.Img_Off:SetActive(true)
    data = DataModel.trustAudioList
  else
    View.Group_Audio.Group_Audio1:SetActive(false)
    View.Group_Audio.Btn_Audio1.Img_Off:SetActive(true)
    View.Group_Audio.Group_Audio2:SetActive(true)
    View.Group_Audio.Btn_Audio2.Img_Off:SetActive(false)
    data = DataModel.BattleAudio
  end
  gridController:SetDataCount(#data)
  gridController:RefreshAllElement()
  gridController.ScrollRect.verticalNormalizedPosition = 1
end
local SelectFileOrSound = function(status)
  if status == 1 then
    View.Group_Story.Group_Story1:SetActive(true)
    View.Group_Story.Group_Story2:SetActive(false)
    View.Group_Story:SetActive(true)
    View.Group_Audio:SetActive(false)
    View.Group_TIBottomLeft.Btn_Information.Group_On:SetActive(true)
    View.Group_TIBottomLeft.Btn_Information.Group_Off:SetActive(false)
    View.Group_TIBottomLeft.Btn_Show.Group_On:SetActive(false)
    View.Group_TIBottomLeft.Btn_Show.Group_Off:SetActive(true)
    View.Group_Story.Btn_Story1.Img_Off:SetActive(false)
    View.Group_Story.Btn_Story2.Img_Off:SetActive(true)
    View.Group_Story.Group_Story1.ScrollView_Text:SetVerticalNormalizedPosition(1)
    View.Group_Story.Img_select:SetLocalPositionX(View.Group_Story.Btn_Story1.CachedTransform.localPosition.x)
  elseif status == 2 then
    View.Group_Audio.Group_Audio1:SetActive(true)
    View.Group_Audio.Btn_Audio1.Img_Off:SetActive(false)
    View.Group_Audio.Group_Audio2:SetActive(false)
    View.Group_Audio.Btn_Audio2.Img_Off:SetActive(true)
    View.Group_Story:SetActive(false)
    View.Group_Audio:SetActive(true)
    View.Group_TIBottomLeft.Btn_Information.Group_On:SetActive(false)
    View.Group_TIBottomLeft.Btn_Information.Group_Off:SetActive(true)
    View.Group_TIBottomLeft.Btn_Show.Group_On:SetActive(true)
    View.Group_TIBottomLeft.Btn_Show.Group_Off:SetActive(false)
    View.Group_Audio.Group_Audio1.ScrollGrid_Audio1.grid.self:SetDataCount(#DataModel.trustAudioList)
    View.Group_Audio.Group_Audio1.ScrollGrid_Audio1.grid.self:RefreshAllElement()
    View.Group_Audio.Group_Audio1.ScrollGrid_Audio1.grid.self.ScrollRect.verticalNormalizedPosition = 1
    View.Group_Audio.Img_select:SetLocalPositionX(View.Group_Audio.Btn_Audio1.CachedTransform.localPosition.x)
  end
  lastSelectPanel = status
end
local InitInfoFile = function()
  ClearLuaObj()
  local Group_Detail = View.Group_Story.Group_Story1.Group_TITop.Group_Detail
  local RoleCA = DataModel.RoleCA
  local TemporaryText = ""
  Group_Detail.Group_Name.Txt_NameCH:SetText(RoleCA.name)
  Group_Detail.Group_Name.Txt_NameEN:SetText(RoleCA.EnglishName)
  Group_Detail.Group_Camp.Img_Camp:SetSprite(UIConfig.RoleCamp[tonumber(PlayerData:SearchRoleCampInt(RoleCA.sideId))])
  Group_Detail.Group_Age.Txt_Age:SetText(RoleCA.age or TemporaryText)
  Group_Detail.Group_Birthday.Txt_Birthday:SetText(RoleCA.birthday or TemporaryText)
  Group_Detail.Group_Gender.Txt_Gender:SetText(RoleCA.gender)
  Group_Detail.Group_Height.Txt_Height:SetText(RoleCA.height or TemporaryText)
  Group_Detail.Group_Birthplace.Txt_Birthplace:SetText(RoleCA.birthplace or TemporaryText)
  Group_Detail.Group_Identity.Txt_Identity:SetText(RoleCA.identity or TemporaryText)
  Group_Detail.Group_Ability.Txt_Ability:SetText(RoleCA.ability)
  local Scroll_Content = View.Group_Story.Group_Story1.ScrollView_Text
  Scroll_Content.Viewport.Content.Txt_Des:SetText(RoleCA.ResumeList[1] ~= nil and RoleCA.ResumeList[1].des or TemporaryText)
  Scroll_Content:SetContentHeight(View.Group_Story.Group_Story1.ScrollView_Text.Viewport.Content.Txt_Des:GetHeight())
  Scroll_Content:SetVerticalNormalizedPosition(1)
  Group_Detail.Group_Des.Txt_Des:SetText(RoleCA.Basic or TemporaryText)
  local Group_TIBottomLeft = View.Group_TIBottomLeft
  Group_TIBottomLeft.Txt_NameCH:SetText(DataModel.RoleCA.name)
  local nowLanguage = PlayerData:GetPlayerPrefs("int", "soundLanguage")
  nowLanguage = nowLanguage == 0 and GameSetting.defaultSoundLanguage or nowLanguage
  View.Img_CvName.Txt_:SetText(DataModel.file_cfg["CvName" .. nowLanguage])
  Group_TIBottomLeft.Btn_Trust.Txt_TrustLevel:SetText("LV" .. DataModel.roleTrustLv)
  local width = Group_TIBottomLeft.Btn_Trust.Img_Bottom.Rect.sizeDelta.x
  if DataModel.roleTrustLv >= 10 then
    Group_TIBottomLeft.Btn_Trust.Img_Top:SetWidth(width)
  else
    Group_TIBottomLeft.Btn_Trust.Img_Top:SetWidth(width * DataModel.roleTrustLvExp / DataModel.trustExpList[DataModel.roleTrustLv].exp)
  end
  View.Group_TIBottomLeft.Btn_Trust.Img_Bonus:SetActive(false)
  View.Group_TIBottomLeft.Img_select:SetLocalPositionX(View.Group_TIBottomLeft.Btn_Information.CachedTransform.localPosition.x)
end
local ViewFunction = {
  File_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    ClearLuaObj()
    UIManager:GoBack(false)
    View.self:Cancel()
  end,
  File_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    ClearLuaObj()
    MapNeedleData.GoHome()
  end,
  File_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  File_Group_TIBottomLeft_Btn_Information_Click = function(btn, str)
    if lastSelectPanel ~= 1 then
      if sound and sound.audioSource then
        sound:Stop()
        SetSliderValue(nowProcessBar, 0)
        View.self:StopC(coroutineSound)
        View.Group_Audio.Img_AudioTextBg:SetActive(false)
        nowsoundId = nil
      end
      SelectFileOrSound(1)
      local posx = View.Group_TIBottomLeft.Btn_Information.CachedTransform.localPosition.x
      DOTweenTools.DOLocalMoveXCallback(View.Group_TIBottomLeft.Img_select.transform, posx, 0.25, function()
      end)
    end
  end,
  File_Group_TIBottomLeft_Btn_Show_Click = function(btn, str)
    if lastSelectPanel ~= 2 then
      SelectFileOrSound(2)
      local posx = View.Group_TIBottomLeft.Btn_Show.CachedTransform.localPosition.x
      DOTweenTools.DOLocalMoveXCallback(View.Group_TIBottomLeft.Img_select.transform, posx, 0.25, function()
      end)
    end
  end,
  File_Group_TIBottomLeft_Btn_Trust_Click = function(btn, str)
    local growthCfg = PlayerData:GetFactoryData(DataModel.RoleCA.growthId)
    local atk_SN = math.floor(growthCfg.gAtk_SN * math.floor(DataModel.roleTrustLv / 2))
    local hp_SN = math.floor(growthCfg.gHp_SN * math.floor(DataModel.roleTrustLv / 2))
    local def_SN = math.floor(growthCfg.gDef_SN * math.floor(DataModel.roleTrustLv / 2))
    local Img_Bonus = View.Group_TIBottomLeft.Btn_Trust.Img_Bonus
    Img_Bonus:SetActive(true)
    Img_Bonus.Txt_Atk1:SetText("+" .. atk_SN)
    Img_Bonus.Txt_Def1:SetText("+" .. def_SN)
    Img_Bonus.Txt_Hp1:SetText("+" .. hp_SN)
  end,
  File_Group_TIBottomLeft_Btn_Trust_Img_Bonus_Btn_CloseBonus_Click = function(btn, str)
    View.Group_TIBottomLeft.Btn_Trust.Img_Bonus:SetActive(false)
  end,
  File_Btn_Close_Click = function(btn, str)
    ClearLuaObj()
    UIManager:GoBack()
  end,
  File_Group_Story_Btn_Story1_Click = function(btn, str)
    if View.Group_Story.Btn_Story1.Img_Off.Img.gameObject.activeInHierarchy then
      View.Group_Story.Group_Story1:SetActive(true)
      View.Group_Story.Group_Story2:SetActive(false)
      View.Group_Story.Btn_Story1.Img_Off:SetActive(false)
      View.Group_Story.Btn_Story2.Img_Off:SetActive(true)
      View.Group_Story.Group_Story1.ScrollView_Text:SetVerticalNormalizedPosition(1)
      local posx = View.Group_Story.Btn_Story1.CachedTransform.localPosition.x
      DOTweenTools.DOLocalMoveXCallback(View.Group_Story.Img_select.transform, posx, 0.25, nil)
    end
  end,
  File_Group_Story_Btn_Story2_Click = function(btn, str)
    if View.Group_Story.Btn_Story2.Img_Off.Img.gameObject.activeInHierarchy then
      View.Group_Story.Group_Story1:SetActive(false)
      View.Group_Story.Group_Story2:SetActive(true)
      View.Group_Story.Btn_Story1.Img_Off:SetActive(true)
      View.Group_Story.Btn_Story2.Img_Off:SetActive(false)
      local storyList = DataModel.file_cfg.StoryList
      local storyCount = #storyList
      local roleStorySV = View.Group_Story.Group_Story2.transform:Find("RoleStorySV/Viewport/Content")
      for i = 0, storyCount - 1 do
        local obj = roleStorySV.transform:GetChild(i)
        local desDiGroup = obj.transform:Find("Img_DesDi"):GetComponent(typeof(CS.Seven.UIImg))
        if desDiGroup.IsActive then
          local btn = obj:GetComponent(typeof(CS.Seven.UIBtn))
          local diGroup = btn.transform:Find("Img_Di"):GetComponent(typeof(CS.Seven.UIImg))
          btn:SetHeight(diGroup.Rect.sizeDelta.y)
          desDiGroup:SetActive(false)
          local selectGroup = btn.transform:Find("Img_SelectIcon"):GetComponent(typeof(CS.Seven.UIImg))
          selectGroup:SetLocalEulerAngles(-90)
        end
      end
      local posx = View.Group_Story.Btn_Story2.CachedTransform.localPosition.x
      DOTweenTools.DOLocalMoveXCallback(View.Group_Story.Img_select.transform, posx, 0.25, nil)
    end
  end,
  File_Group_Audio_Btn_Audio1_Click = function(btn, str)
    if View.Group_Audio.Btn_Audio1.Img_Off.Img.gameObject.activeInHierarchy then
      local gridController = View.Group_Audio.Group_Audio1.ScrollGrid_Audio1.grid.self
      SwitchRoleSoundPanel(1, gridController)
      local posx = View.Group_Audio.Btn_Audio1.CachedTransform.localPosition.x
      DOTweenTools.DOLocalMoveXCallback(View.Group_Audio.Img_select.transform, posx, 0.25, nil)
    end
  end,
  File_Group_Audio_Btn_Audio2_Click = function(btn, str)
    if View.Group_Audio.Btn_Audio2.Img_Off.Img.gameObject.activeInHierarchy then
      local gridController = View.Group_Audio.Group_Audio2.ScrollGrid_Audio2.grid.self
      SwitchRoleSoundPanel(2, gridController)
      local posx = View.Group_Audio.Btn_Audio2.CachedTransform.localPosition.x
      DOTweenTools.DOLocalMoveXCallback(View.Group_Audio.Img_select.transform, posx, 0.25, nil)
    end
  end,
  File_Group_Audio_Group_Audio1_ScrollGrid_Audio1_SetGrid = function(element, elementIndex)
    local data = DataModel.trustAudioList[elementIndex]
    element.Img_Lock:SetActive(false)
    element.Img_New:SetActive(false)
    if DataModel.roleTrustLv < data.UnlockLevel then
      element.Img_Lock:SetActive(true)
      element.Img_Lock.Txt_:SetText(string.format(GetText(80600765), data.UnlockLevel))
    else
      element.Btn_PlayAudio.Txt_:SetText(data.AudioName)
      if PlayerData:GetPlayerPrefs("int", DataModel.roleId .. data.Audio2) == 0 then
        element.Img_New:SetActive(true)
      end
    end
    element.Btn_PlayAudio.Img_VoiceBg:SetActive(false)
    element.Btn_PlayAudio:SetClickParam(elementIndex)
    if DataModel.soundIsExist then
      element.Btn_PlayAudio.Img_VoiceBg:SetActive(nowsoundId == data.Audio2)
      if nowsoundId == data.Audio2 then
        nowProcessBar = element.Btn_PlayAudio.Img_VoiceBg.Img_Processbar
        img_VoiceBg = element.Btn_PlayAudio.Img_VoiceBg.transform
      end
    end
    element.Btn_PlayAudio.Img_None:SetActive(not DataModel.soundIsExist)
    element.Btn_PlayAudio.Img_Play:SetActive(DataModel.soundIsExist)
  end,
  File_Group_Audio_Group_Audio1_ScrollGrid_Audio1_Group_Item_Btn_PlayAudio_Click = function(btn, str)
    local data = DataModel.trustAudioList[tonumber(str)]
    if DataModel.roleTrustLv >= data.UnlockLevel then
      if DataModel.soundIsExist then
        lastProcessBar = nowProcessBar
        lastVoiceBg = img_VoiceBg
        img_VoiceBg = btn.transform:Find("Img_VoiceBg")
        img_VoiceBg.gameObject:SetActive(true)
        nowProcessBar = img_VoiceBg:Find("Img_Processbar"):GetComponent(typeof(CS.Seven.UIImg))
      end
      local soudId = data.Audio2
      PlayRoleSound(soudId, data)
      if PlayerData:GetPlayerPrefs("int", DataModel.roleId .. data.Audio2) == 0 then
        PlayerData:SetPlayerPrefs("int", DataModel.roleId .. data.Audio2, 1)
        btn.transform.parent.transform:Find("Img_New").gameObject:SetActive(false)
      end
    end
  end,
  File_Group_Audio_Group_Audio2_ScrollGrid_Audio2_SetGrid = function(element, elementIndex)
    local data = DataModel.BattleAudio[elementIndex]
    element.Btn_PlayAudio.Txt_:SetText(data.AudioName)
    element.Btn_PlayAudio:SetClickParam(elementIndex)
    element.Btn_PlayAudio.Img_VoiceBg:SetActive(false)
    if DataModel.soundIsExist then
      element.Btn_PlayAudio.Img_VoiceBg:SetActive(nowsoundId == data.id2)
      if nowsoundId == data.id2 then
        nowProcessBar = element.Btn_PlayAudio.Img_VoiceBg.Img_Processbar
        img_VoiceBg = element.Btn_PlayAudio.Img_VoiceBg.transform
      end
    end
    element.Btn_PlayAudio.Img_None:SetActive(not DataModel.soundIsExist)
    element.Btn_PlayAudio.Img_Play:SetActive(DataModel.soundIsExist)
  end,
  File_Group_Audio_Group_Audio2_ScrollGrid_Audio2_Group_Item_Btn_PlayAudio_Click = function(btn, str)
    local data = DataModel.BattleAudio[tonumber(str)]
    if DataModel.soundIsExist then
      lastProcessBar = nowProcessBar
      lastVoiceBg = img_VoiceBg
      img_VoiceBg = btn.transform:Find("Img_VoiceBg")
      img_VoiceBg.gameObject:SetActive(true)
      nowProcessBar = img_VoiceBg:Find("Img_Processbar"):GetComponent(typeof(CS.Seven.UIImg))
    end
    PlayRoleSound(data.id2, data)
  end,
  InitInfoFile = InitInfoFile,
  SelectFileOrSound = SelectFileOrSound
}
return ViewFunction
