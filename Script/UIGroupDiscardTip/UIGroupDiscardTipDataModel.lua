local View = require("UIGroupDiscardTip/UIGroupDiscardTipView")
local DataModel = {}

function DataModel:SetClick()
  local group_on = View.Group_Tip.Btn_Tip.Group_On
  if group_on.self.IsActive == true then
    DataModel.isTrue = false
    group_on.self:SetActive(false)
  else
    DataModel.isTrue = true
    group_on.self:SetActive(true)
  end
end

return DataModel
