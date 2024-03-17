local Order = {}
local trigger, waitKey

function Order:OnStart(ca)
  trigger = false
  waitKey = ca.eventString
  if waitKey == PlayerData.TempCache.GuideTriggerKey then
    trigger = true
    PlayerData.TempCache.GuideTriggerKey = nil
  end
end

function Order:AnimatorTrigger(triggerKey)
  trigger = triggerKey == waitKey
  return trigger
end

function Order:IsFinish()
  return trigger
end

return Order
