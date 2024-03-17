local View = require("UIGroup_InputNote/UIGroup_InputNoteView")
local Controller = {}
local characterLimit = 120

function Controller:InitView()
  View.InputField_Note.self:SetText("")
  View.InputField_Note.self:SetCharacterLimit(characterLimit)
end

function Controller:ModifyNote()
  if View.InputField_Note.self:GetText() == "" then
    CommonTips.OpenTips(GetText(80600225))
    return
  end
  local result = View.InputField_Note.self:CheckText(characterLimit)
  if result == 0 or result == 1 then
    Net:SendProto("main.set_sign", function(json)
      UIManager:GoBack()
    end, View.InputField_Note.self:GetText())
  elseif result == 2 or result == 3 then
    CommonTips.OpenTips(GetText(80600087))
  end
end

return Controller
