local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local Order = {}

function Order:OnStart(ca)
  UIGuidanceController.CloseTipView()
end

function Order:IsFinish()
  return true
end

return Order
