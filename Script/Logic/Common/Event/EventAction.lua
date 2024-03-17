local EventAction = {}
EventAction.__index = EventAction

function EventAction.Create()
  local obj = {}
  setmetatable(obj, EventAction)
  obj:Init()
  return obj
end

function EventAction:Init()
  self.callback = {}
end

function EventAction:AddListener(callback)
  local cb = self.callback[callback]
  if cb ~= nil then
    return
  end
  self.callback[callback] = true
end

function EventAction:RemoveListener(callback)
  self.callback[callback] = nil
end

function EventAction:RemoveAll()
  self.callback = {}
end

function EventAction:SendEvent(...)
  for k, _ in pairs(self.callback) do
    pcall(k, ...)
  end
end

return EventAction
