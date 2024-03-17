local View = require("UILogin/UILoginView")
local Controller = {}

function Controller:InitView()
  local btnCanel = View.Group_Account.Btn_Cancel
  local sw = GameSetting.SWAccountDestroy
  if sw ~= nil and btnCanel ~= nil then
    btnCanel:SetActive(sw)
  end
end

return Controller
