local Order = {}
local setComplete = false

function Order:OnStart(ca)
  setComplete = false
  if ca.skipOrderIdNum ~= 0 then
    local guideNo = GuideManager:GetNextStepGuideNo(ca.skipOrderIdNum)
    if guideNo ~= 0 then
      Net.sendGuideNO = guideNo
    end
  end
  Net:SendProto("main.newbie_step", function(json)
    setComplete = true
  end)
end

function Order:IsFinish()
  return setComplete
end

return Order
