local Order = {}
local isFinish = false

function Order:OnStart(ca)
  isFinish = false
  GuideManager:CloseUIDrag(ca.uiPath, ca.nodeName, ca.isClose)
  isFinish = true
end

function Order:IsFinish()
  return isFinish
end

return Order
