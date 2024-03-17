local BroadCastInfo = {}
BroadCastInfo.__index = BroadCastInfo

function BroadCastInfo.Create(sMsg)
  if sMsg == "" then
    return nil
  end
  local t = setmetatable({}, BroadCastInfo)
  t:Init(sMsg)
  return t
end

function BroadCastInfo:Init(sMsg)
  local t = Json.decode(sMsg)
  self.title = t.title
  self.content = t.content
  self.tsStart = t.start_time
  self.tsEnd = t.end_time
  self.interval = t.interval
  self.iPlayTime = 0
  self.tsNextPlay = 0
end

return BroadCastInfo
