local DeviceHelper = {}

function DeviceHelper.GetDeviceId()
  local deviceId = CS.GameSdkLuaface.GetDeviceId()
  return deviceId
end

function DeviceHelper.IsDeviceIOS()
  return PayHelper.IsPayPlatformIOS()
end

return DeviceHelper
