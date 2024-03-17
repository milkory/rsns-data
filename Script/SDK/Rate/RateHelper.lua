local RateHelper = {}

function RateHelper.TryOpenRatePop()
  local newbiewPoolId = GachaHelper.GetNewbiePoolId()
  local lastPullPoolId = GachaGV:GetLastTenPullPollId()
  if lastPullPoolId ~= newbiewPoolId then
    return
  end
  if GachaHelper.GetNewbiePoolLeftNum() > 0 then
    return
  end
  if DeviceHelper.IsDeviceIOS() then
    RateHelper.RequestAppleStoreReview()
  end
end

function RateHelper.RequestAppleStoreReview()
end

return RateHelper
