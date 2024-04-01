local CommonHelper = {}
EventMgr = require("Logic/Common/Event/EventMgr")
DeviceHelper = require("Common/Device/DeviceHelper")

function CommonHelper.SafeCallCsFunc(csFunc, ...)
  if csFunc ~= nil and type(csFunc) == "function" then
    return pcall(csFunc, ...)
  end
  return nil, nil
end

return CommonHelper
