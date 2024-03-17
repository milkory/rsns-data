local Order = {}

function Order:OnStart(ca)
  for k, v in pairs(ca.paramList) do
    Net.SetGuideNoUpdateLimit(v.paramEnum, v.paramVal)
  end
end

function Order:IsFinish()
  return Net.updateGuideNoLimit == nil
end

return Order
