local View = require("UIGroup_InvestTip/UIGroup_InvestTipView")
local DataModel = {}
DataModel.txtId = 0

function DataModel.SetJsonData(json)
  if not json then
    return
  end
  local data = Json.decode(json)
  DataModel.txtId = data.txtId
end

function DataModel.RefreshOnShow()
  if DataModel.txtId and DataModel.txtId > 0 then
    local txt = PlayerData:GetFactoryData(DataModel.txtId, "TextFactory").text
    View.Txt_Prompt:SetText(txt)
  end
  View.Group_Tip.Btn_Tip.Group_On:SetActive(false)
  View.Group_Tip.Btn_Tip.Group_Off:SetActive(true)
end

return DataModel
