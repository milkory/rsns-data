local View = require("UIBroadCast/UIBroadCastView")
local Timer = require("Common/Timer")
local Controller = {}

function Controller:InitView()
  self.timer = nil
  self.timer = Timer.New(10, function()
    if self.timer == nil then
      return
    end
    self.timer:Stop()
    View.self:CloseUI()
  end)
  self.timer:Start()
  local title = BroadCastMgr:GetTitle()
  local content = BroadCastMgr:GetContent()
  local Group_Broad = View.Group_BG.ScrollView_Content.Viewport.Content.Group_Broad
  Group_Broad.Txt_Title:SetText(title)
  Group_Broad.Txt_Content:SetText(content)
end

function Controller:UpdateView()
  if self.timer ~= nil then
    self.timer:Update()
  end
end

return Controller
