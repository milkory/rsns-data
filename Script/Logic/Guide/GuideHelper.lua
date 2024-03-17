local GuideHelper = {}

function GuideHelper.HasGuide()
  return GuideOrderController:CurrentOrderNotNil()
end

function GuideHelper.GetCurrentClientGuideNO()
  return GuideManager:GetCurrentClientGuideNO()
end

function GuideHelper.GetCurrentGuideCAId()
  return GuideOrderController:GetCurrentGuideCAId()
end

function GuideHelper.GetCurrentGuideCA()
  local id = GuideHelper.GetCurrentGuideCAId()
  if id == nil or id <= 0 then
    return nil
  end
  local ca = PlayerData:GetFactoryData(id)
  return ca
end

function GuideHelper.GetCurrentGuideCAPropTriggerPanelName()
  local ca = GuideHelper.GetCurrentGuideCA()
  if ca == nil then
    return nil
  end
  return ca.triggerPanelName
end

function GuideHelper.IsInMainUIForceGuide()
  if GuideHelper.HasGuide() == false then
    return false
  end
  local triggerPanelName = GuideHelper.GetCurrentGuideCAPropTriggerPanelName()
  if triggerPanelName ~= nil and triggerPanelName == "UI/MainUI/MainUI" then
    return true
  end
  return false
end

function GuideHelper.IsInForceGuide()
  if GuideHelper.HasGuide() == false then
    return false
  end
  return true
end

return GuideHelper
