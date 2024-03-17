local LuaUpdate = {}

function LuaUpdate.Update(realtimeSinceStartup, deltaTime)
  TimerMgr:Update(realtimeSinceStartup, deltaTime)
end

TimerMgr = require("Common/Timer/TimerMgr")
return LuaUpdate
