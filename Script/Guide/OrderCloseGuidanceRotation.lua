local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local Order = {}

function Order:OnStart(ca)
  UIGuidanceController.CloseRotation()
end

function Order:IsFinish()
  return true
end

return Order
