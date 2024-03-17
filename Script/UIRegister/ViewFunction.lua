local View = require("UIRegister/View")
local RegisterCallBack = function(d)
  CBus:ChangeScene("Main")
end
local ViewFunction = {
  Btn_Register_click = function(str)
    local username = View.InputField_Username.self:GetText()
    local passwd = View.InputField_Password.self:GetText()
    local passwd2 = View.InputField_Password2.self:GetText()
    local email = View.InputField_Email.self:GetText()
    local p = ProtocolFactory:CreateProtocol(ProtocolType.Register)
    p.username = username
    p.password1 = passwd
    p.password2 = passwd2
    p.email = email
    p.phone = ""
    p:SetCallback(RegisterCallBack)
    ServerConnectManager:Add(p)
  end
}
return ViewFunction
