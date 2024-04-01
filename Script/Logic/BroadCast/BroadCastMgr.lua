local BroadCastMgr = {}
BroadCastEnum = require("Logic/BroadCast/BroadCastEnum")
BroadCastInfo = require("Logic/BroadCast/BroadCastInfo")

function BroadCastMgr:OnStartup()
  self.isInit = false
  self.isStartTimer = false
  TimerMgr:Create("timer_broadcastmgr_startup", 1, function()
    TimerMgr:Pause("timer_broadcastmgr_startup")
    self:OnMainUIEnable()
  end)
  EventMgr:AddEvent("event_uimainui_enable", function()
    TimerMgr:Resume("timer_broadcastmgr_startup")
  end)
  EventMgr:AddEvent("event_uimainui_disable", function()
    self:OnMainUIDisable()
  end)
end

function BroadCastMgr:Init()
  if self.isInit == true then
    return
  end
  self.isInit = true
  self.eState = BroadCastEnum.State.None
  self.info = nil
  self.iUIShowTimeLeft = 0
  self.bShowUI = false
  self.isMainUIEnable = false
  local tsNow = TimeUtil:GetServerTimeStamp()
  local sMsg = PlayerData:GetPlayerPrefs("string", "ServerBroadCast")
  if sMsg ~= "" then
    local info = BroadCastInfo.Create(sMsg)
    if tsNow >= info.tsEnd then
    else
      self.info = info
      local loopTime = math.floor((info.tsEnd - info.tsStart) / info.interval) + 1
      for i = 1, loopTime do
        local endTime = info.tsStart + info.interval * i
        if tsNow >= endTime then
          info.iPlayTime = i
          info.tsNextPlay = endTime
        end
      end
      info.iPlayTime = info.iPlayTime + 1
      info.tsNextPlay = info.tsNextPlay + info.interval
      self.bShowUI = true
      self.iUIShowTimeLeft = 10
    end
  end
end

function BroadCastMgr:Update()
  local info = self.info
  if info == nil then
    return
  end
  local tsNow = TimeUtil:GetServerTimeStamp()
  if tsNow >= info.tsEnd then
    self.info = nil
    self:StopUI()
    return
  end
  if tsNow >= info.tsNextPlay then
    info.iPlayTime = info.iPlayTime + 1
    info.tsNextPlay = info.tsStart + info.interval * info.iPlayTime
    self:PlayUI()
    return
  end
  if self.isMainUIEnable and self.bShowUI then
    self.iUIShowTimeLeft = self.iUIShowTimeLeft - 2
    if self.iUIShowTimeLeft <= 0 then
      self:StopUI()
      self.iUIShowTimeLeft = 0
    end
  end
end

function BroadCastMgr:ReqServerBroadCast()
  Net:SendProto("main.notice", function(msg)
    local return_notice = msg.return_notice
    local firstNotice
    local tsNow = TimeUtil:GetServerTimeStamp()
    if return_notice ~= nil and return_notice ~= "" then
      for k, v in pairs(return_notice) do
        firstNotice = v
      end
      if firstNotice == nil then
        return
      end
      local sMsg = Json.encode(firstNotice)
      local info = BroadCastInfo.Create(sMsg)
      self.info = info
      local loopTime = math.floor((info.tsEnd - info.tsStart) / info.interval) + 1
      for i = 1, loopTime do
        local endTime = info.tsStart + info.interval * i
        if tsNow >= endTime then
          info.iPlayTime = i
          info.tsNextPlay = endTime
        end
      end
      self:PlayUI()
      return
    end
  end)
end

function BroadCastMgr:IsFuncUsable()
  if FuncUnlockHelper.IsFuncUnlock(FuncUnlockConst.FUNCID_BROADCAST) then
    return true
  end
  return false
end

function BroadCastMgr:OnMainUIEnable()
  if not self:IsFuncUsable() then
    return
  end
  if not self.isStartTimer then
    self:Init()
    self.isStartTimer = true
  end
  self.isMainUIEnable = true
  self:ReqServerBroadCast()
end

function BroadCastMgr:OnMainUIDisable()
  self.isMainUIEnable = false
end

function BroadCastMgr:ResumeUI()
  if self.info == nil then
    return
  end
  if self.iUIShowTimeLeft <= 0 then
    return
  end
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  if UIManager:IsPanelOpened("UI/BroadCast/BroadCast") then
    return
  end
end

function BroadCastMgr:PlayUI()
  if self.info == nil then
    return
  end
  self.bShowUI = true
  self.iUIShowTimeLeft = string.getLength(self:GetContent()) / 5 * 1
  if self.iUIShowTimeLeft < 5 then
    self.iUIShowTimeLeft = 5
  end
  if not UIManager:IsPanelOpened("UI/MainUI/MainUI") then
    return
  end
  UIManager:Open("UI/BroadCast/BroadCast")
end

function BroadCastMgr:StopUI()
end

function BroadCastMgr:GetContent()
  if self.info == nil then
    return ""
  end
  return self.info.content
end

function BroadCastMgr:GetTitle()
  if self.info == nil then
    return ""
  end
  return self.info.title
end

BroadCastMgr:OnStartup()
return BroadCastMgr
