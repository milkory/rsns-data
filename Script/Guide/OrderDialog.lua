local PlotController = require("UIDialog/Model_PlotController")
local Order = {}

function Order:OnStart(ca)
  UIManager:Open(UIPath.UIDialog, Json.encode({
    id = ca.paragraphId
  }))
end

function Order:IsFinish()
  return PlotController:IsFinish()
end

return Order
