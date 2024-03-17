local View = require("UINewFuncActivated/UINewFuncActivatedView")
local DataModel = require("UINewFuncActivated/UINewFuncActivatedDataModel")
local Controller = {}

function Controller:ShowUnlock()
  if #DataModel.ShowInfo == 0 then
    return
  end
  local info = DataModel.ShowInfo[1]
  table.remove(DataModel.ShowInfo, 1)
  View.Img_Icon:SetSprite(info.iconPath)
  View.Txt_Name:SetText(info.name)
  View.self:PlayAnimOnce("In")
end

return Controller
