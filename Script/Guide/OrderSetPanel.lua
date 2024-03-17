local Order = {}

function Order:OnStart(ca)
  GuideManager:BlocksRaycasts(ca.panelName, ca.isActive)
end

function Order:IsFinish()
  return true
end

return Order
