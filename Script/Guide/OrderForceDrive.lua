local module = {}
local isFinish = false

function module:OnStart(ca)
  isFinish = false
  local mainUIController = require("UIMainUI/UIMainUIController")
  mainUIController.GoToNewCity(ca.stationId, function()
    isFinish = true
  end)
end

function module:IsFinish()
  return isFinish
end

return module
