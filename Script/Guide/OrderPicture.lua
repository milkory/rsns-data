local Order = {}
local isFinish = false

function Order:OnStart(ca)
  isFinish = false
  UIManager:Open("UI/Battle/Tutorial/Battle_tutorial", tostring(ca.guildanceOrderId), function()
    isFinish = true
  end)
end

function Order:IsFinish()
  return isFinish
end

return Order
