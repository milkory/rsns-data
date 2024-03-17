local EventMgr = {}
local EA = require("Logic/Common/Event/EventAction")

function EventMgr:Init()
  self.events = {}
end

function EventMgr:AddEvent(eventName, calback)
  if calback == nil then
    return
  end
  if type(calback) ~= "function" then
    return
  end
  if not self.events[eventName] then
    self.events[eventName] = EA.Create()
  end
  self.events[eventName]:AddListener(calback)
end

function EventMgr:RemoveEvent(eventName, calback)
  if calback == nil then
    return
  end
  if type(calback) ~= "function" then
    return
  end
  if not self.events[eventName] then
    return
  end
  self.events[eventName]:RemoveListener(calback)
end

function EventMgr:SendEvent(eventName, ...)
  local e = self.events[eventName]
  if e ~= nil then
    self.events[eventName]:SendEvent(...)
  end
end

EventMgr:Init()
return EventMgr
