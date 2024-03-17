local Order = {}

function Order:OnStart(ca)
  UIManager:Open(ca.panelName, ca.params)
end

function Order:IsFinish()
  return true
end

return Order
