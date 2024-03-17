local DataModel = require("UIAttractions/UIAttractionsDataModel")
local View = require("UIAttractions/UIAttractionsView")
local useableViewList = {}
local usedViewList = {}
local GetViewHeight = function(viewTF)
  local viewTxt = viewTF:Find("desc_bg/Txt_Desc"):GetComponent(typeof(CS.Seven.UITxt))
  local viewBg = viewTF:Find("desc_bg"):GetComponent("HorizontalLayoutGroup").padding
  return viewTxt:GetHeight() + viewBg.top + viewBg.bottom
end
local ShowDescView = function(data)
  local viewObj = table.remove(useableViewList, 1)
  if viewObj == nil then
    return
  end
  viewObj:SetActive(true)
  table.insert(usedViewList, 1, viewObj)
  local viewTF = viewObj.transform
  local isHalfSprite = data.isHalfSprite
  local imgAvatar = viewTF:Find("avatar_bg/SoftMask_avatar/Img_avatar")
  local imgAvatarSmall = viewTF:Find("avatar_bg/SoftMask_avatar/Img_avatar_small")
  imgAvatar.gameObject:SetActive(isHalfSprite)
  imgAvatarSmall.gameObject:SetActive(not isHalfSprite)
  if isHalfSprite then
    imgAvatar:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(data.avatarPath)
  else
    imgAvatarSmall:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(data.avatarPath)
  end
  local txtDes = viewTF:Find("desc_bg/Txt_Desc"):GetComponent(typeof(CS.Seven.UITxt))
  txtDes:SetText(data.descStr)
  local txtHeight = txtDes:GetHeight()
  txtDes:SetHeight(txtHeight)
  viewTF:Find("desc_bg/Txt_Name"):GetComponent(typeof(CS.Seven.UITxt)):SetText(data.characterName)
  viewTF.localPosition = Vector3(DataModel.offsetX, DataModel.offsetY, 0)
  viewTF:Find("avatar_bg/SoftMask_avatar"):GetComponent(typeof(CS.Seven.UISoftMask)):MaskAllManaged()
  viewObj:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 0
  DOTweenTools.DOFade(viewTF, 1, DataModel.descDataList[DataModel.curIdx].fadeInFrame * CS.GameSetting.Instance.frameTime)
end
local TryHideDescView = function()
  local usedCount = #usedViewList
  if usedCount >= DataModel.maxDescNum then
    local viewObj = table.remove(usedViewList, usedCount)
    DOTweenTools.DOFade(viewObj.transform, 0, DataModel.descDataList[DataModel.curIdx].fadeOutFrame * CS.GameSetting.Instance.frameTime)
    useableViewList[#useableViewList + 1] = viewObj
  end
end
local RefreshUsedSoftMask = function()
  if #usedViewList <= 0 then
    return
  end
  local viewObj = usedViewList[#usedViewList]
  viewObj.transform:Find("avatar_bg/SoftMask_avatar"):GetComponent(typeof(CS.Seven.UISoftMask)):RefreshMaskPosition()
end
local UpdateDescView = function()
  local data = DataModel.descDataList[DataModel.curIdx]
  ShowDescView(data)
end
local Controller = {useableViewList = useableViewList, usedViewList = usedViewList}

function Controller.Init(param)
  DataModel.Init(param)
  local nowCount = #useableViewList
  local viewTemp = "UI/Attraction/Group_Item"
  View.Group_Item.gameObject:SetActive(false)
  for i = nowCount + 1, DataModel.maxDescNum + 1 do
    local viewObj = View.self:GetRes(viewTemp, View.Img_Bg.transform)
    viewObj:SetActive(false)
    useableViewList[i] = viewObj
  end
  Controller.isEnd = nil
  Controller.isFadeOut = nil
end

function Controller.ClearUseableList()
  for i = #usedViewList, 1, -1 do
    Object.Destroy(usedViewList[i])
  end
  for i = 1, #useableViewList do
    Object.Destroy(useableViewList[i])
  end
  useableViewList = {}
  usedViewList = {}
end

function Controller.Update()
  if PlayerData:GetHomeInfo().station_info.is_arrived ~= 0 or UIManager:IsPanelOpened("UI/Common/DialogBox_Tip") then
    UIManager:ClosePanel(true, "UI/Attraction/Attractions")
  end
  local curFrame = DataModel.curFrame - 1
  if 0 < curFrame and curFrame <= DataModel.descDataList[DataModel.curIdx].fadeOutFrame then
    if Controller.isFadeOut == nil then
      Controller.isFadeOut = true
      TryHideDescView()
    end
  elseif curFrame <= 0 then
    if Controller.isFadeOut then
      Controller.isFadeOut = nil
    end
    local curIdx = DataModel.curIdx + 1
    DataModel.curIdx = curIdx
    PlayerData:SetAttractionTipIndex(curIdx)
    local data = DataModel.descDataList[curIdx]
    if data then
      curFrame = data.fadeInFrame + data.keepFrame + data.fadeOutFrame
    elseif Controller.isEnd == nil then
      Controller.isEnd = true
      PlayerData:ClearAttractionTipHistory()
      UIManager:ClosePanel(true, "UI/Attraction/Attractions")
    end
    UpdateDescView()
  end
  RefreshUsedSoftMask()
  DataModel.curFrame = curFrame
end

return Controller
