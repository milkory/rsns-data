local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local Order = {}

function Order:OnStart(ca)
  if UIGuidanceController.IsOpen == false then
    UIManager:Open(UIPath.UIGuide)
  end
  UIGuidanceController.SetFocus(ca.x, ca.y, ca.w, ca.h, ca.left, ca.top)
  UIGuidanceController.ShowFinger(ca.isShowFinger)
  UIGuidanceController.SetBgAlpha(ca.alpha)
end

function Order:IsFinish()
  return true
end

return Order
