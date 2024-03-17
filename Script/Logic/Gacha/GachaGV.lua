local GachaGV = {}

function GachaGV:SetLastTenPullPollId(poolId)
  if type(poolId) ~= "number" then
    self.lastTenPullPoolId = tonumber(poolId)
  else
    self.lastTenPullPoolId = poolId
  end
end

function GachaGV:GetLastTenPullPollId()
  return self.lastTenPullPoolId or 0
end

return GachaGV
