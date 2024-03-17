local TimerMgr = {}
local TimerClass = require("Common/Timer")
TimerHelper = require("Common/Timer/TimerHelper")

function TimerMgr:Init()
  self.timers = {}
end

function TimerMgr:Update(realtime, deltatime)
  for key, timer in pairs(self.timers) do
    if timer ~= nil then
      timer:Update()
    end
  end
end

function TimerMgr:Create(timerName, interval, func)
  self:Start(timerName, interval, func)
  self:Pause(timerName)
end

function TimerMgr:Start(timerName, interval, func)
  if self:IsExist(timerName) then
    return
  end
  local timer = TimerClass.New(interval, func)
  self.timers[timerName] = timer
  timer:Start()
end

function TimerMgr:Stop(timerName)
  if not self:IsExist(timerName) then
    return
  end
  local timer = self:Get(timerName)
  timer:Stop()
  self.timers[timerName] = nil
end

function TimerMgr:Pause(timerName)
  local timer = self:Get(timerName)
  if timer ~= nil then
    timer:Pause()
  end
end

function TimerMgr:Resume(timerName)
  local timer = self:Get(timerName)
  if timer ~= nil then
    timer:Resume()
  end
end

function TimerMgr:Get(timerName)
  return self.timers[timerName]
end

function TimerMgr:IsExist(timerName)
  return self.timers[timerName] ~= nil
end

TimerMgr:Init()
return TimerMgr
