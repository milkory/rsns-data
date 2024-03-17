local Order = {}
local isFinish = false

function Order:OnStart(ca)
  isFinish = false
  PlayerData.TempCache.GuideTriggerKey = nil
  isFinish = true
end

function Order:IsFinish()
  return isFinish
end

return Order
