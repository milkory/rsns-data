local Order = {}
local isFinish = false

function Order:OnStart(ca)
  isFinish = false
  GuideManager:Delay(ca.sec, function()
    isFinish = true
  end)
end

function Order:IsFinish()
  return isFinish
end

return Order
