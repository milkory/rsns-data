local Order = {}
local isFinish = false

function Order:OnStart(ca)
  isFinish = GuideManager:SetGuide(ca.panelName, ca.btnName, function()
    isFinish = true
  end)
  if ca.autoCompletedTime > 0 then
    GuideManager:Delay(ca.autoCompletedTime, function()
      GuideManager:StopPanelGuide()
      isFinish = true
    end)
  end
end

function Order:IsFinish()
  return isFinish
end

return Order
