local View = require("UISkinPreview/UISkinPreviewView")
local DataModel = {}
DataModel.InfoInitPos = {
  isRecord = true,
  x = 0,
  y = 0,
  scale = 1,
  offsetX = 0,
  offsetY = 1
}

function DataModel:Reset()
  View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.transform.localScale = Vector3(1, 1, 1)
  View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Character.transform.localScale = Vector3(1, 1, 1)
  View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.self:SetLocalPosition(Vector3(0, 0, 0))
  View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = false
end

function DataModel:ClickLeftSkin(index, isFirst)
  if DataModel.ChooseIndex == nil or index == nil or DataModel.ChooseIndex == index and isFirst == nil then
    return
  end
  local row = DataModel.SkinList[tonumber(index)]
  View.Img_Bg.Group_Left.Group_Spine.Img_MinionBg.Spine_MiniSize:SetData(row.ca.resDir, "stand")
  local Group_Bottom = View.Img_Bg.Group_Left.Group_Bottom
  Group_Bottom.Txt_SkinName:SetText(row.SkinName)
  Group_Bottom.Txt_SkinNameEN:SetText(PlayerData:GetFactoryData(DataModel.RoleId).EnglishName)
  if row.isSpine2 == 1 then
    Group_Bottom.Txt_SkinName:SetText(row.ca.State2Name)
    View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = false
  end
  Group_Bottom.Txt_SkinDesc:SetText(row.SkinDesc)
  if DataModel.isSkinView == false then
    local Btn_On = View.Img_Bg.Group_Right.Group_HoldingStatus.Btn_On
    Btn_On.Group_Bp.self:SetActive(false)
    Btn_On.Group_Buy.self:SetActive(false)
    Btn_On.Group_Wear.self:SetActive(false)
    Btn_On.Img_Off.self:SetActive(false)
    Btn_On.Img_Off.Group_InUsing.self:SetActive(false)
    Btn_On.Img_Off.Group_NotOwned.self:SetActive(false)
    Btn_On.Img_Off.Group_Awake.self:SetActive(false)
    row.Btn_Index = 0
    row.isSelect = true
    if row.isHave == true then
      if row.isWear == true then
        Btn_On.Img_Off.self:SetActive(true)
        Btn_On.Img_Off.Group_InUsing.self:SetActive(true)
      else
        Btn_On.Group_Wear.self:SetActive(true)
        row.Btn_Index = 1
      end
    else
      Btn_On.Img_Off.self:SetActive(true)
      if row.isSpine2 == 1 then
        Btn_On.Img_Off.Group_Awake.self:SetActive(true)
      else
        Btn_On.Img_Off.Group_NotOwned.self:SetActive(true)
      end
    end
  end
  local element = row.element
  element.Img_Selected:SetActive(true)
  element.Img_Selected2:SetActive(true)
  local old = {}
  if DataModel.ChooseIndex and isFirst == nil then
    old = DataModel.SkinList[tonumber(DataModel.ChooseIndex)]
    old.isSelect = false
    old.element.Img_Selected:SetActive(false)
    old.element.Img_Selected2:SetActive(false)
  end
  local state = false
  if DataModel.NowSkin then
    if DataModel.NowSkin.portraitId ~= row.unitViewId then
      state = true
    elseif row.isSpine2 ~= DataModel.NowSkin.isSpine2 then
      state = true
    end
  end
  if (isFirst == true or state == true) and (row.isSpine2 ~= old.isSpine2 or row.unitViewId ~= old.unitViewId) then
    DataModel.CharacterLoad(row.unitViewId, row.isSpine2 == 1)
  end
  DataModel.ChooseIndex = index
  DataModel.LoadSpineBg(row.unitViewId)
end

function DataModel:RefreshPage()
  local old_index = 0
  for k, v in pairs(DataModel.SkinList) do
    if v.isWear == true then
      old_index = k
    end
  end
  if old_index ~= 0 then
    local old_row = DataModel.SkinList[old_index]
    old_row.isWear = false
    local old_element = old_row.element
    old_element.Btn_SkinBg.Img_SkinFrame.Img_InUsingBg:SetActive(false)
  end
  local now_row = DataModel.SkinList[DataModel.ChooseIndex]
  now_row.isWear = true
  now_row.element.Btn_SkinBg.Img_SkinFrame.Img_InUsingBg:SetActive(true)
  DataModel:ClickLeftSkin(DataModel.ChooseIndex, true)
end

function DataModel:ClickLive2D(state)
  local Img_Live2dBg = View.Img_Bg.Group_Left.Group_Bottom.Img_Live2dBg
  DataModel.live2D = not DataModel.live2D
  local state_n = 0
  if DataModel.live2D == false then
    state_n = 1
  end
  PlayerData:SetPlayerPrefs("int", DataModel.RoleId .. "live2d", state_n)
  if DataModel.live2D ~= state then
    local row = DataModel.SkinList[tonumber(DataModel.ChooseIndex)]
    DataModel.CharacterLoad(row.unitViewId, row.isSpine2 == 1)
    DataModel.LoadSpineBg(row.unitViewId)
  end
  if DataModel.live2D == true then
    DOTweenTools.DOLocalMoveXCallback(Img_Live2dBg.Img_On.transform, 24, 0.25, function()
      Img_Live2dBg:SetSprite("UI/CharacterInfo/Skin/onbg")
    end)
  else
    DOTweenTools.DOLocalMoveXCallback(Img_Live2dBg.Img_On.transform, -24, 0.25, function()
      Img_Live2dBg:SetSprite("UI/CharacterInfo/Skin/offbg")
    end)
  end
end

local SetMissingConfig = function(isSpine2, receptionistData)
  local Group_CharacterSkin = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content
  Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(false)
  Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(false)
  if isSpine2 == true then
    Group_CharacterSkin.Group_Character2.self:SetActive(true)
    Group_CharacterSkin.Group_Character2.Img_Character2:SetSprite(receptionistData.State2Res)
  else
    Group_CharacterSkin.Group_Character.self:SetActive(true)
    Group_CharacterSkin.Group_Character.Img_Character:SetSprite(receptionistData.resUrl)
  end
  Group_CharacterSkin.Group_Character.Img_Character:SetNativeSize()
  Group_CharacterSkin.Group_Character2.Img_Character2:SetNativeSize()
  DataModel.InfoInitPos.isRecord = true
  if DataModel.InfoInitPos.isRecord then
    DataModel.InfoInitPos.isRecord = false
    local transform = Group_CharacterSkin.transform
    DataModel.InfoInitPos.y = transform.localPosition.y
    DataModel.InfoInitPos.scale = transform.localScale.x
  end
  DataModel.InfoInitPos.offsetX = receptionistData.offsetX
  DataModel.InfoInitPos.offsetY = receptionistData.offsetY
end
local isSpine2

function DataModel.CharacterLoad(id, isSkin2)
  local Group_CharacterSkin = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content
  local receptionistData = PlayerData:GetFactoryData(id, "UnitViewFactory")
  local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d")
  isSpine2 = isSkin2
  Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(false)
  Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(false)
  Group_CharacterSkin.Group_Character.self:SetActive(false)
  Group_CharacterSkin.Group_Character2.self:SetActive(false)
  Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetLocalScale(Vector3(1, 1, 1))
  local spineUrl = receptionistData.spineUrl
  if spineUrl ~= nil and spineUrl ~= "" then
    View.Img_Bg.Group_Left.Group_Bottom.Img_Live2dBg:SetActive(true)
    View.Img_Bg.Group_Left.Group_Bottom.Txt_Live2D:SetActive(true)
    Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(true)
    Group_CharacterSkin.Group_Spine.SpineAnimation_Fade:SetActive(true)
    Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(not isSpine2)
    Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(isSpine2)
    if live2D == 1 then
      SetMissingConfig(isSpine2, receptionistData)
    elseif isSpine2 then
      spineUrl = receptionistData.spine2Url
      if spineUrl ~= nil and spineUrl ~= "" then
        Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetPrefab(spineUrl)
        Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetData("")
        Group_CharacterSkin.Group_Spine.SpineSecondMode_Character.transform.localPosition = Vector3(receptionistData.spine2X, receptionistData.spine2Y, 0)
        if receptionistData.state2Overturn == true then
          Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetLocalScale(Vector3(-1, 1, 1))
        end
        DataModel.Spine2PosX = receptionistData.spine2X
      else
        SetMissingConfig(isSpine2, receptionistData)
        View.Img_Bg.Group_Left.Group_Bottom.Img_Live2dBg:SetActive(false)
        View.Img_Bg.Group_Left.Group_Bottom.Txt_Live2D:SetActive(false)
      end
    else
      Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetActive(false)
      Group_CharacterSkin.Group_Spine.SpineSecondMode_Character:SetPrefab("")
      Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetActive(true)
      Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetData(spineUrl)
      Group_CharacterSkin.Group_Spine.SpineAnimation_Character:SetLocalScale(Vector3(100, 100, 1))
      Group_CharacterSkin.Group_Spine.SpineAnimation_Character.transform.localPosition = Vector3(-275 + receptionistData.spineX, -1200 + receptionistData.spineY, 0)
    end
  else
    SetMissingConfig(isSpine2, receptionistData)
    View.Img_Bg.Group_Left.Group_Bottom.Img_Live2dBg:SetActive(false)
    View.Img_Bg.Group_Left.Group_Bottom.Txt_Live2D:SetActive(false)
  end
  View.Img_IpadBtm:SetActive(false)
  View.Img_IpadTop:SetActive(false)
  if isSpine2 == true then
    View.Img_IpadBtm:SetActive(true)
    View.Img_IpadTop:SetActive(true)
  end
  if DataModel.InfoInitPos.isRecord == false then
    local pos = DataModel.InfoInitPos
    local posX = pos.x + receptionistData.offsetX * pos.scale
    local posY = pos.y + receptionistData.offsetY * pos.scale
    if isSpine2 == true then
      posX = pos.x + receptionistData.offsetX2 * pos.scale
      posY = pos.y + receptionistData.offsetY2 * pos.scale
    end
    Group_CharacterSkin.Group_Character.Img_Character:SetLocalPosition(Vector3(-275 + receptionistData.offsetX, receptionistData.offsetY, 0))
    Group_CharacterSkin.Group_Character2.Img_Character2:SetLocalPosition(Vector3(receptionistData.offsetX2, receptionistData.offsetY2, 0))
    Group_CharacterSkin.Group_Character.Img_Character:SetLocalScale(Vector3(receptionistData.offsetScale, receptionistData.offsetScale, receptionistData.offsetScale))
  end
  DataModel.NowSkin = {}
  DataModel.NowSkin.portraitId = tonumber(id)
  DataModel.NowSkin.isSpine2 = isSpine2 == true and 1 or 0
end

function DataModel:MoveSpine2Live2D(type)
  View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled = false
  local posX = DataModel.Spine2PosX
  if type == 1 then
    posX = 0
  end
  local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d")
  if live2D == 1 then
    DOTweenTools.DOLocalMoveXCallback(View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Character2.Img_Character2.transform, posX, 0.25, function()
    end)
  else
    DOTweenTools.DOLocalMoveXCallback(View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.SpineSecondMode_Character.transform, posX, 0.25, function()
    end)
  end
end

function DataModel.LoadSpineBg(viewId)
  local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d")
  if live2D == 1 then
    View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.Img_SpineBG:SetActive(false)
    return
  end
  local viewCfg = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  if viewCfg.SpineBackground and viewCfg.SpineBackground ~= "" then
    View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.Img_SpineBG:SetSprite(viewCfg.SpineBackground)
    DataModel.offsetX = viewCfg.SpineBGX and viewCfg.SpineBGX or 0
    DataModel.offsetY = viewCfg.SpineBGY and viewCfg.SpineBGY or 0
    local x = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.SpineAnimation_Character.transform.localPosition.x - DataModel.offsetX
    local y = viewCfg.SpineBGY and viewCfg.SpineBGY or 0
    View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.Img_SpineBG.transform.localPosition = Vector3(x, y, 0)
    local scale = viewCfg.SpineBGScale or 1
    View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.Img_SpineBG.transform.localScale = Vector3(scale, scale, 0)
  end
  View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.Img_SpineBG:SetActive(viewCfg.SpineBackground and viewCfg.SpineBackground ~= "")
end

return DataModel
