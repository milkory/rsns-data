local module = {}

function module:OnStart(ca)
  if UIManager:IsPanelOpened(ca.uiPath) then
    local pos = {x = 0, y = 0}
    local scrollViewObj = GuideManager:GetPanelUI(ca.uiPath, ca.scrollViewPath)
    local nodeObj = GuideManager:GetPanelUI(ca.uiPath, ca.nodePath)
    if nodeObj then
      pos = nodeObj.transform.localPosition
    end
    if scrollViewObj then
      local scrollView = scrollViewObj:GetComponent(typeof(CS.Seven.UIScrollView))
      scrollView.ScrollRect.content:GetComponent(typeof(CS.Seven.UIGroup)):SetAnchoredPosition(Vector2(-pos.x, -pos.y))
    end
  end
end

function module:IsFinish()
  return true
end

return module
