local TrackingIO2Reporter = {}

function TrackingIO2Reporter.Register(account, params)
  local _account = account or TrackingIO2Reporter.GetDeviceId()
  CS.TrackingIO2Luaface.Register(_account)
end

function TrackingIO2Reporter.Login(account, serverId, params)
  CS.TrackingIO2Luaface.Login(account, "1")
end

function TrackingIO2Reporter.Setryzf(ryTID, ryzfType, hbType, hbAmount, params)
  CS.TrackingIO2Luaface.Setryzf(ryTID, ryzfType, hbType, hbAmount)
end

function TrackingIO2Reporter.SetEvent(eventName, params)
  CS.TrackingIO2Luaface.SetEvent(eventName)
end

function TrackingIO2Reporter.SetDD(ryTID, hbType, hbAmount, params)
  CS.TrackingIO2Luaface.SetDD(ryTID, hbType, hbAmount)
end

function TrackingIO2Reporter.SetTrackAdShow(adPlatform, adId, playSuccess, params)
  CS.TrackingIO2Luaface.SetTrackAdShow(adPlatform, adId, playSuccess)
end

function TrackingIO2Reporter.SetTrackAdClick(adPlatform, adId, params)
  CS.TrackingIO2Luaface.SetTrackAdClick(adPlatform, adId)
end

function TrackingIO2Reporter.SetTrackAppDuration(duration, params)
  CS.TrackingIO2Luaface.SetTrackAppDuration(duration)
end

function TrackingIO2Reporter.SetTrackViewDuration(pageID, duration, params)
  CS.TrackingIO2Luaface.SetTrackViewDuration(pageID, duration)
end

function TrackingIO2Reporter.GetDeviceId()
  return CS.TrackingIO2Luaface.GetDeviceId()
end

return TrackingIO2Reporter
