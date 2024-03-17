local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local Order = {}
local isFinish = false

function Order:OnStart(ca)
  isFinish = false
  if UIGuidanceController.IsOpen == false then
    UIManager:Open(UIPath.UIGuide)
  end
  UIGuidanceController.ShowRotation()
  if ca.autoCompletedTime > 0 then
    GuideManager:Delay(ca.autoCompletedTime, function()
      isFinish = true
    end)
  end
end

function Order:IsFinish()
  local isMoving = TrainCameraManager:IsCurCameraMoving()
  return isFinish or isMoving
end

return Order
