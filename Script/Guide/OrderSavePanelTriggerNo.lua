local Order = {}
local isFinish = false

function Order:OnStart(ca)
  isFinish = false
  local firstGuideConfig = PlayerData:GetFactoryData(99900049, "ConfigFactory")
  local idx = -1
  for k, v in pairs(firstGuideConfig.guideList) do
    if v.id == ca.guideNo then
      idx = k
      break
    end
  end
  if idx == -1 then
    return
  end
  local methodName = "main.newbie_step"
  if ca.apiName ~= "" then
    methodName = ca.apiName
  end
  Net.SetFirstGuideUpdateData(methodName, idx - 1, ca.guideNo)
  if ca.apiName == "" then
    Net:SendProto("main.newbie_step", function()
      isFinish = true
    end)
  else
    isFinish = true
  end
end

function Order:IsFinish()
  return isFinish
end

return Order
