local TimerHelper = {}

function TimerHelper.Start(timerName, interval, func)
  TimerMgr:Start(timerName, interval, func)
end

function TimerHelper.Stop(timerName)
  TimerMgr:Stop(timerName)
end

function TimerHelper.Pause(timerName)
  TimerMgr:Pause(timerName)
end

function TimerHelper.Resume(timerName)
  TimerMgr:Resume(timerName)
end

return TimerHelper
