local RateHelper = {}
RateHelper.CondPlayerLevel = 30

function RateHelper.Init()
  EventMgr:AddEvent("event_uimainui_enable", function()
    RateHelper.RequestAppleStoreWhenEnterMainMenu()
  end)
end

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

function RateHelper.OpenAppleStoreReview()
  local isIOS = DeviceHelper.IsDeviceIOS()
  if not isIOS then
    return
  end
  local status = PlayerData:GetPlayerPrefs("int", "AppleStoreReviewPopStatus")
  if status == nil or status == 1 then
    return
  end
  local s = CommonHelper.SafeCallCsFunc(CS.RateLuaface.RequestAppleStoreReview)
  if s then
    PlayerData:SetPlayerPrefs("int", "AppleStoreReviewPopStatus", 1)
  end
end

function RateHelper.RequestAppleStoreWhenEnterMainMenu()
  local playerLevel = PlayerData:GetPlayerLevel()
  if playerLevel >= RateHelper.CondPlayerLevel then
    RateHelper.OpenAppleStoreReview()
  end
end

RateHelper.Init()
return RateHelper
