Class = require("UIDialog/MetatableClass")
local Timer = Class.New("Timer")
local Time = require("Common/Time")
local Ctor = function(self, delay, func, obj, one_shot, use_frame, unscaled)
  self.target = {}
  if delay and func then
    self:Init(delay, func, obj, one_shot, use_frame, unscaled)
  end
end
local Init = function(self, delay, func, obj, one_shot, use_frame, unscaled)
  assert(type(delay) == "number" and 0 <= delay)
  assert(func ~= nil)
  self.delay = delay
  self.target.func = func
  self.target.obj = obj
  self.one_shot = one_shot
  self.use_frame = use_frame
  self.unscaled = unscaled
  self.started = false
  self.left = delay
  self.over = false
  self.obj_not_nil = obj and true or false
  self.start_frame_count = Time.frameCount
end
local Update = function(self, is_fixed)
  if not self.started or self.over then
    return
  end
  Time:SetDeltaTime(Time.unity_time.deltaTime, Time.unity_time.unscaledDeltaTime)
  local timeup = false
  if self.use_frame then
    timeup = Time.frameCount >= self.start_frame_count + self.delay
  else
    local delta
    if is_fixed then
      delta = Time.fixedDeltaTime
    else
      delta = not self.unscaled and Time.deltaTime or Time.unscaledDeltaTime
    end
    self.left = self.left - delta
    timeup = self.left <= 0
  end
  if timeup then
    if self.target.func ~= nil then
      if not self.one_shot then
        if not self.use_frame then
          self.left = self.delay + self.left
        end
        self.start_frame_count = Time.frameCount
      else
        self.over = true
      end
      local status, err
      if self.obj_not_nil then
        status, err = pcall(self.target.func, self.target.obj)
      else
        status, err = pcall(self.target.func)
      end
      if not status then
        self.over = true
        CS.UnityEngine.Debug.LogError(err)
      end
    else
      self.over = true
    end
  end
end
local Start = function(self)
  if self.over then
  end
  if not self.started then
    self.left = self.delay
    self.started = true
    self.start_frame_count = Time.frameCount
  end
end
local Pause = function(self)
  self.started = false
end
local Resume = function(self)
  self.started = true
end
local Stop = function(self)
  self.left = 0
  self.one_shot = false
  self.target.func = nil
  self.target.obj = nil
  self.use_frame = false
  self.unscaled = false
  self.started = false
  self.over = true
end
local Reset = function(self)
  self.left = self.delay
  self.start_frame_count = Time.frameCount
end
local ReTimer = function(self, delay)
  self.delay = delay
  self.left = self.delay
  self.start_frame_count = Time.frameCount
end
local IsOver = function(self)
  if self.target.func == nil then
    return true
  end
  if self.obj_not_nil and self.target.func == nil then
    return true
  end
  return self.over
end
Timer.Ctor = Ctor
Timer.Init = Init
Timer.Update = Update
Timer.Start = Start
Timer.Pause = Pause
Timer.Resume = Resume
Timer.Stop = Stop
Timer.Reset = Reset
Timer.ReTimer = ReTimer
Timer.IsOver = IsOver
return Timer
