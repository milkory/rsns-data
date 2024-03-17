local View = require("UISkin/UISkinView")
local DataModel_Info = require("UICharacterInfo/DataModel")
local BackgroundLoader = require("UICharacterInfo/ViewBackground")
local DataModel = {}
local Btn_Sort = {
  ["精二"] = "Group_Buy",
  ["商店"] = "Group_Buy",
  ["通行证"] = "Group_Bp"
}

function DataModel:ClickLeftSkin(index, isFirst)
  if DataModel.ChooseIndex == nil or index == nil or DataModel.ChooseIndex == index and isFirst == nil then
    return
  end
  local row = DataModel.SkinList[tonumber(index)]
  View.Img_Bg.Group_Left.Group_Spine.Img_MinionBg.Spine_MiniSize:SetData(row.ca.resDir, "stand")
  local Group_Bottom = View.Img_Bg.Group_Left.Group_Bottom
  Group_Bottom.Txt_SkinName:SetText(row.SkinName)
  Group_Bottom.Txt_SkinNameEN:SetText(DataModel.RoleCA.EnglishName)
  if row.isSpine2 == 1 then
    Group_Bottom.Txt_SkinName:SetText(row.ca.State2Name)
  end
  Group_Bottom.Txt_SkinDesc:SetText(row.SkinDesc)
  local Btn_On = View.Img_Bg.Group_Right.Group_HoldingStatus.Btn_On
  Btn_On.Group_Bp.self:SetActive(false)
  Btn_On.Group_Buy.self:SetActive(false)
  Btn_On.Group_Wear.self:SetActive(false)
  Btn_On.Img_Off.self:SetActive(false)
  Btn_On.Img_Off.Group_InUsing.self:SetActive(false)
  Btn_On.Img_Off.Group_NotOwned.self:SetActive(false)
  Btn_On.Img_Off.Group_Awake.self:SetActive(false)
  local GetWay = row.ca.GetWay
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
  Btn_On.Img_Bg:SetAlpha(1)
  if Btn_On.Img_Off.self.IsActive == false then
    Btn_On.Img_Bg:SetAlpha(0)
  end
  local element = row.element
  element.Img_Selected:SetActive(true)
  element.Img_Selected2:SetActive(true)
  element.Btn_SkinBg.Img_Selected:SetActive(true)
  local old = {}
  if DataModel.ChooseIndex and isFirst == nil then
    old = DataModel.SkinList[tonumber(DataModel.ChooseIndex)]
    old.isSelect = false
    old.element.Img_Selected:SetActive(false)
    old.element.Img_Selected2:SetActive(false)
    old.element.Btn_SkinBg.Img_Selected:SetActive(false)
  end
  DataModel.ChooseIndex = index
  local state = false
  if DataModel_Info.NowSkin.portraitId ~= row.unitViewId then
    state = true
  elseif row.isSpine2 ~= DataModel_Info.NowSkin.isSpine2 then
    state = true
  end
  if (isFirst == nil or state == true) and (row.isSpine2 ~= old.isSpine2 or row.unitViewId ~= old.unitViewId) then
    BackgroundLoader:Load(row.unitViewId, row.isSpine2 == 1)
  end
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
    BackgroundLoader:Load(row.unitViewId, row.isSpine2 == 1)
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

return DataModel
