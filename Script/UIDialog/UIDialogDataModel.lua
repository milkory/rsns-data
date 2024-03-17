local View = require("UIDialog/UIDialogView")
local DataModel = {}
DataModel.PlotPos = {}

function DataModel.InitPlotPosData()
  DataModel.PlotPos = {}
  local width = Screen.width / 4
  local index = 0
  for i = -3, 3 do
    DataModel.PlotPos[index] = width * i
    index = index + 1
  end
  DataModel.PlotPos[1] = -700
  DataModel.PlotPos[2] = -400
  DataModel.PlotPos[4] = 400
  DataModel.PlotPos[5] = 700
end

DataModel.PaintData = {}
DataModel.EnumSetPaintData = {
  Remove = 1,
  Modify = 2,
  Find = 3
}

function DataModel.InitPaintData()
  DataModel.PaintData = {}
  for i = 1, 3 do
    local temp = {}
    temp.image = View.Group_Shake.Group_Img["Img_Paint0" .. tostring(i)]
    temp.spine = View.Group_Shake.Group_Spines["SpineAnimation_Role0" .. tostring(i)]
    temp.face = temp.image.Img_Face
    temp.posIndex = -1
    temp.unitViewID = 0
    temp.isBright = false
    temp.faceData = {}
    DataModel.PaintData[i] = temp
  end
end

local GetSpineOrder = function(spineData)
  return spineData.posIndex
end

function DataModel.SetPaintData(enum, index)
  for k, v in pairs(DataModel.PaintData) do
    if v.posIndex == index then
      if enum == DataModel.EnumSetPaintData.Remove then
        DataModel.PaintData[k].posIndex = -1
        break
      elseif enum == DataModel.EnumSetPaintData.Modify then
        DataModel.PaintData[k].posIndex = index
        break
      elseif enum == DataModel.EnumSetPaintData.Find then
        local order = 9
        if v.alwaysTop ~= true then
          order = GetSpineOrder(v)
        end
        return v, order
      end
    end
  end
  return nil
end

function DataModel.SetDefaultData()
  for k, v in pairs(DataModel.PaintData) do
    DataModel.PaintData[k].posIndex = -1
    if v.spine.IsActive then
      v.spine:ReleaseRes()
      v.spine:SetActive(false)
    end
  end
end

function DataModel.AddPaintData(ca, index, isSpine, alwaysTop)
  local face = {}
  local unitViewID = 0
  if isSpine then
    unitViewID = ca.unitViewID
  else
    face.X = ca.faceX
    face.Y = ca.faceY
    face.faces = ca.faces
  end
  for k, v in pairs(DataModel.PaintData) do
    if v.posIndex == index then
      DataModel.PaintData[k].posIndex = index
      DataModel.PaintData[k].faceData = face
      DataModel.PaintData[k].unitViewID = unitViewID
      DataModel.PaintData[k].alwaysTop = alwaysTop
      if isSpine then
        local order = 9
        if alwaysTop ~= true then
          order = GetSpineOrder(v)
        end
        return v, order
      else
        return v.image
      end
    end
  end
  for k, v in pairs(DataModel.PaintData) do
    if v.posIndex == -1 then
      DataModel.PaintData[k].posIndex = index
      DataModel.PaintData[k].faceData = face
      DataModel.PaintData[k].unitViewID = unitViewID
      DataModel.PaintData[k].alwaysTop = alwaysTop
      if isSpine then
        local order = 9
        if alwaysTop ~= true then
          order = GetSpineOrder(v)
        end
        return v, order
      else
        return v.image
      end
    end
  end
  if isSpine then
    return nil, nil
  else
    return nil
  end
end

DataModel.Ca = {}
DataModel.duration = 0
DataModel.perCharSpeed = 0.02
DataModel.intervalTime = 2
DataModel.isAuto = false
DataModel.isPause = false
DataModel.isSliding = false
DataModel.Speed = 1
local isSkipCurrentNode = false
DataModel.lastPower = 0
DataModel.UploadingParagraphId = 0
DataModel.CurrentParagraphId = 0
DataModel.ReviewList = {}

function DataModel:InitAutoBtn()
  if not View.Btn_Auto.self.IsActive then
    return
  end
  local isAuto, speed = PlayerData:GetAutoDialog()
  DataModel.isAuto = isAuto
  if DataModel.TimeLine.isPlaying and isAuto and speed == 1 then
    speed = 2
  end
  DataModel.SetAutoSpeed(speed, true)
  if not DataModel.isAuto then
    View.self:PlayAnim("Empty")
  elseif DataModel.Speed == 1 then
    View.self:PlayAnim("Auto")
  elseif DataModel.Speed == 2 then
    View.self:PlayAnim("Auto2X")
  elseif DataModel.Speed == 4 then
    View.self:PlayAnim("Auto4X")
  end
end

function DataModel.SetAutoBtn()
  if DataModel.isAuto == false then
    DataModel.isAuto = true
    if DataModel.TimeLine.isPlaying then
      DataModel.SetAutoSpeed(1)
      View.self:PlayAnim("Auto2X")
    else
      DataModel.SetAutoSpeed(0)
      View.self:PlayAnim("Auto")
    end
  elseif DataModel.isAuto then
    if DataModel.Speed == 1 then
      DataModel.SetAutoSpeed(1)
      View.self:PlayAnim("Auto2X")
    elseif DataModel.Speed == 2 then
      DataModel.SetAutoSpeed(2)
      View.self:PlayAnim("Auto4X")
    elseif DataModel.Speed == 4 then
      DataModel.SetAutoSpeed(0)
      DataModel.isAuto = false
      View.self:PlayAnim("Empty")
    end
  end
  PlayerData:SetAutoDialog(DataModel.isAuto, DataModel.Speed)
end

function DataModel.Pause(isPause)
  if isPause and DataModel.isAuto then
    DataModel.isPause = isPause
    DataModel.isAuto = false
    View.self:PlayAnim("Empty")
  elseif DataModel.isPause and isPause == false then
    DataModel.isAuto = true
    if DataModel.Speed == 1 then
      View.self:PlayAnim("Auto")
    elseif DataModel.Speed == 2 then
      View.self:PlayAnim("Auto2X")
    elseif DataModel.Speed == 4 then
      View.self:PlayAnim("Auto4X")
    end
  end
end

function DataModel.InitAutoSpeed()
  if DataModel.isAuto then
    if DataModel.Speed == 1 then
      View.self:PlayAnim("Auto")
    elseif DataModel.Speed == 2 then
      View.self:PlayAnim("Auto2X")
    elseif DataModel.Speed == 4 then
      View.self:PlayAnim("Auto4X")
    end
  else
    DataModel.SetAutoSpeed(0)
    View.self:PlayAnim("Empty")
  end
end

function DataModel.SetAutoSpeed(power, isNotPower)
  if isNotPower then
    DataModel.Speed = power
  else
    DataModel.Speed = 2 ^ power
  end
  if DataModel.Speed ~= DataModel.lastSpeed then
    DataModel.lastSpeed = DataModel.Speed
    DataModel.SpeedChanged = true
  end
  if 0 < power and power ~= DataModel.lastPower then
    DataModel.lastPower = power
    isSkipCurrentNode = true
  end
end

local skip_cb

function DataModel.SkipCurrentNode(cb)
  if cb then
    skip_cb = cb
  end
  if isSkipCurrentNode then
    isSkipCurrentNode = false
    if cb ~= nil then
      cb()
      skip_cb = nil
    end
  end
end

function DataModel.RunSkipCurrentNodeCb()
  if skip_cb ~= nil then
    skip_cb()
    skip_cb = nil
  end
end

function DataModel.GetIsAuto()
  return DataModel.isAuto or DataModel.isSliding
end

function DataModel.GetCurrentScaleValue(value)
  if DataModel.Speed <= 0 then
    DataModel.Speed = 1
  end
  return value * 1.0 / DataModel.Speed * 1.0
end

function DataModel.SetSkipAndAutoBtn(isActive)
  if DataModel.Ca.isBanSkip then
    isActive = false
  end
  if DataModel.Ca.isAuto then
    return
  end
  View.Btn_Skip:SetActive(isActive)
end

function DataModel.ForceAutoPlay(isAutoPlay)
  if isAutoPlay then
    DataModel.SetAutoSpeed(0)
    DataModel.isAuto = true
  end
  View.Btn_Auto:SetActive(not isAutoPlay)
  View.Btn_Skip:SetActive(not isAutoPlay)
  View.Btn_Hide:SetActive(not isAutoPlay)
  View.Btn_Log:SetActive(not isAutoPlay)
end

local objectState

function DataModel.HideView(isHide)
  local transform = View.self.transform
  local count = transform.childCount - 1
  local gameObject
  if isHide then
    objectState = {}
    for i = 0, count do
      gameObject = transform:GetChild(i).gameObject
      if gameObject.activeInHierarchy then
        objectState[i] = i
        gameObject:SetActive(false)
      end
    end
    if View.Img_TpMask ~= nil then
      View.Img_TpMask:SetActive(true)
    end
  else
    for k, v in pairs(objectState) do
      transform:GetChild(v).gameObject:SetActive(true)
    end
  end
end

DataModel.isBoy = true
DataModel.isAutoCloseSubtitles = false
DataModel.Video = {
  isPlaying = false,
  isSkip = false,
  isOnlySkipVideo = false
}
DataModel.TimeLine = {
  id = 0,
  isPlaying = false,
  isSkip = false,
  isOnlySkipTimeLine = false
}
DataModel.TimeLineEventID = -1
return DataModel
