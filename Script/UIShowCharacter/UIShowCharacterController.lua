local UIShowCharacterController = {}

function UIShowCharacterController:GetSpineUrl(unitView)
  if unitView == nil then
    return ""
  end
  if unitView.gachaPerformUrl ~= nil and unitView.gachaPerformUrl ~= "" then
    return unitView.gachaPerformUrl
  elseif unitView.spine2Url ~= nil and unitView.spine2Url ~= "" then
    return unitView.spine2Url
  else
    return ""
  end
end

return UIShowCharacterController
