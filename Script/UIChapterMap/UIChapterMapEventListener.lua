local DataModel = require("UIChapterMap/UIChapterMapDataModel")
local View = require("UIChapterMap/UIChapterMapView")
local ViewChapter = require("UIChapter/UIChapterView")
local mathEx = require("vendor/mathEx")
local precisionError = 12
local _offset
local nextClickFrame = 0
local nextClickInterval = 5
local prevMousePosX = 0
local prevMousePosY = 0
local totalDistance = 0
local doubleClickFrame = 0
local doubleClickInterval = 16
local mapTransform
local isMouseDown = false
local TransformMapPos = function(position, mousePos)
  local z = View.camera:WorldToScreenPoint(position).z
  local pos = View.camera:ScreenToWorldPoint(Vector3(mousePos.x, mousePos.y, z))
  return pos
end
local module = {
  isMouseDrag = false,
  isTweening = false,
  enabled = false,
  doubleClick = false
}

function module.SetupMapTransform()
  mapTransform = View.Group_Map.self.transform
end

function module.Clear()
  prevMousePosX = 0
  prevMousePosY = 0
  totalDistance = 0
  doubleClickFrame = 0
  nextClickFrame = 0
  _offset = 0
  isMouseDown = false
  mapTransform = nil
end

function module:OnListener()
  if PlayerData.LevelChain.OnLevelChain == true then
    return
  end
  if self.isTweening == true then
    return
  end
  if self.enabled == false then
    return
  end
  local mousePos = Input.mousePosition
  if isMouseDown == true then
    self:GetMouseDrag(mousePos)
  end
  if isMouseDown ~= true and self:GetMouseDown(mousePos) == true then
    isMouseDown = true
  end
end

function module:GetMouseDown(mousePos)
  if Input.GetMouseButton(0) then
    if ViewChapter.self.IsPlayAnimator == true then
      return
    end
    if View.Group_Map.self:CheckGUIRay() == true then
      return false
    end
    nextClickFrame = CBus.currentFrame + nextClickInterval
    prevMousePosX = mousePos.x
    prevMousePosY = mousePos.y
    totalDistance = 0
    local pos = TransformMapPos(mapTransform.position, mousePos)
    _offset = mapTransform.position - pos
    return true
  end
  return false
end

function module:GetMouseDrag(mousePos)
  if Input.GetMouseButton(0) then
    totalDistance = totalDistance + math.abs(mousePos.x - prevMousePosX) + math.abs(mousePos.y - prevMousePosY)
    prevMousePosX = mousePos.x
    prevMousePosY = mousePos.y
    local worldPos = TransformMapPos(mapTransform.position, mousePos) + _offset
    worldPos.x = mathEx.Clamp(worldPos.x, DataModel.Edge.left, DataModel.Edge.right)
    worldPos.y = mathEx.Clamp(worldPos.y, DataModel.Edge.bottom, DataModel.Edge.top)
    mapTransform.position = Vector3(worldPos.x, worldPos.y, mapTransform.position.z)
    if CBus.currentFrame > nextClickFrame and DataModel.curState == DataModel.Enum.Normal and totalDistance > precisionError then
      self.isMouseDrag = true
    end
  else
    isMouseDown = false
    if self.isMouseDrag == true then
      DataModel.curMapPosition = mapTransform.position
      self.isMouseDrag = false
    elseif DataModel.levelChainUnlocked ~= true and DataModel.curState ~= DataModel.Enum.Focus then
      if CBus.currentFrame - doubleClickFrame <= doubleClickInterval then
        DataModel.selectedLevel = DataModel.lastClearedLevel
        doubleClickFrame = CBus.currentFrame
        self.doubleClick = true
      end
      doubleClickFrame = CBus.currentFrame
    end
  end
end

function module:IsFinish()
  return self.isTweening == false
end

function module:EnableListener()
  self.enabled = true
end

function module:DisableListener()
  self.enabled = false
end

return module
