local Order = {}
local isFinish

function Order:OnStart(ca)
  isFinish = false
  UIManager:GoHome()
  isFinish = true
end

function Order:IsFinish()
  return isFinish
end

return Order
