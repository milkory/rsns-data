local UIGuidanceController = require("UIGuidance/UIGuidanceController")
local isWait = false
local Order = {}

function Order:OnStart(ca)
  local cb = function()
    local tranUI = GuideManager:GetPanelUI(ca.uiPath, ca.nodeName)
    if tranUI ~= nil then
      if UIGuidanceController.IsOpen == false then
        UIManager:Open(UIPath.UIGuide)
      end
      local pos = tranUI.position
      pos = UIGuidanceController.GetLocalPos(pos)
      UIGuidanceController.SetFocus(pos.x, pos.y, ca.w, ca.h, 0, 0)
      UIGuidanceController.PosOffset(ca.offsetX, ca.offsetY)
      UIGuidanceController.ShowFinger(ca.isShowFinger)
      UIGuidanceController.SetBgAlpha(ca.alpha)
    end
  end
  if ca.delay then
    isWait = true
    CoroutineManager:Reg("OrderUIFocus", LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      isWait = false
      cb()
      CoroutineManager:UnReg("OrderUIFocus")
    end))
  else
    isWait = false
    cb()
  end
end

function Order:IsFinish()
  if isWait then
    return false
  end
  return true
end

return Order
