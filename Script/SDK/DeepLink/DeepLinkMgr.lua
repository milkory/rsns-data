local DeepLinkMgr = {}

function DeepLinkMgr:Init()
  EventMgr:AddEvent("event_uimainui_enable", function()
    self:ProcessDeepLink()
  end)
end

function DeepLinkMgr:ProcessDeepLink()
  TimerMgr:Start("timer_deeplinkmgr_processdeeplink", 1, function()
    TimerMgr:Pause("timer_deeplinkmgr_processdeeplink")
    local url = self:GetDeepLinkUrl()
    if url == nil or url == "" then
      return
    end
    if not BroadCastMgr:IsFuncUsable() then
      return
    end
    UIManager:Open("UI/Activity/ActivityMain")
    CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.ClearDeepLinkUrl)
  end)
end

function DeepLinkMgr:GetDeepLinkUrl()
  local s, r = CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.GetDeepLinkUrl)
  return r or ""
end

DeepLinkMgr:Init()
return DeepLinkMgr
