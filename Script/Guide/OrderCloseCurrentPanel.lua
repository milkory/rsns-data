local Order = {}
local isFinish

function Order:OnStart(ca)
  isFinish = false
  if ca.childNodePath and ca.childNodePath ~= "" then
    local tran = GuideManager:GetPanelUI(ca.uiPath, ca.childNodePath)
    if tran then
      tran.gameObject:SetActive(false)
    end
  else
    GuideManager:ClosePanel(ca.uiPath, ca.isInit)
  end
  isFinish = true
end

function Order:IsFinish()
  return isFinish
end

return Order
