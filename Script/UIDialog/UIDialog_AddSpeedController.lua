local View = require("UIDialog/UIDialogView")
local DataModel = require("UIDialog/UIDialogDataModel")
local Controller = {}
local PopupTips = function()
  View.Img_FastTips:SetActive(true)
end
local SetAutoSpeed = function(posY)
  local power = 0
  if -165 <= posY and posY < -55 then
    power = 2
  elseif -55 <= posY and posY < 55 then
    power = 3
  elseif 55 <= posY and posY < 165 then
    power = 4
  elseif 165 <= posY then
    power = 5
  else
    power = 1
  end
  DataModel.SetAutoSpeed(power)
end
local longPressTimer = 0
local isPlaying = false
local camera, parentRect, cursor
local cursorPosX = 0
local cursorOriginY = 0
local range = 166
local AddSpeed = function(isAddSpeed)
  if isAddSpeed then
    if isPlaying == false then
      DataModel.isSliding = false
      View.self:PlayAnim("CaliperFill", function()
        DataModel.SetAutoSpeed(1)
        DataModel.isSliding = true
        camera = UIManager.UICamera
        parentRect = View.Group_Speed.Rect
        cursor = View.Group_Speed.Img_Cursor
        cursorPosX = cursor.transform.localPosition.x
        cursorOriginY = DOTweenTools.ScreenPointToLocalPointInRectangle(parentRect, camera) + range
      end)
    end
    isPlaying = true
    if DataModel.isSliding and camera ~= nil then
      local posY = (DOTweenTools.ScreenPointToLocalPointInRectangle(parentRect, camera) - cursorOriginY) * 2
      if posY < -range then
        posY = -range
      elseif posY > range then
        posY = range
      end
      cursor:SetLocalPosition(Vector3(cursorPosX, posY, 0))
      SetAutoSpeed(posY)
    end
  elseif isPlaying then
    longPressTimer = 0
    isPlaying = false
    DataModel.isSliding = false
    View.self:PlayAnim("Empty")
    DataModel.SetAutoSpeed(0)
    View.Group_Speed:SetActive(false)
    View.Group_Caliper:SetActive(false)
  else
    isPlaying = false
  end
end
local timer = 0
local isFinishTimer = false
local duration = 5
local clickTimes = 10
local times = 0
local longPressDuration = 0.75

function Controller.Update()
  if DataModel.isAuto or DataModel.isPause or DataModel.Video.isPlaying then
    AddSpeed(false)
    return
  end
  if Input.GetMouseButtonDown(0) and isFinishTimer == false then
    isFinishTimer = true
    times = 0
    timer = 0
  end
  if isFinishTimer then
    timer = timer + Time.deltaTime
    if timer > duration then
      isFinishTimer = false
      timer = 0
      times = 0
    elseif Input.GetMouseButtonDown(0) then
      times = times + 1
      if times >= clickTimes then
        PopupTips()
      end
    end
  end
  if Input.GetMouseButton(0) then
    longPressTimer = longPressTimer + Time.deltaTime
    if longPressTimer > longPressDuration then
      AddSpeed(true)
    end
  else
    AddSpeed(false)
  end
end

function Controller.Destroy()
  AddSpeed(false)
end

return Controller
