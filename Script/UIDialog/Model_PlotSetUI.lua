local base = require("UIDialog/Model_PlotBase")
local PlotSetUI = Class.New("PlotSetUI", base)
local plotCA

function PlotSetUI:Ctor()
end

function PlotSetUI:OnStart(ca)
  plotCA = ca
  if plotCA.isActive then
    UIManager:Open(plotCA.path)
  else
    UIManager:ClosePanel(false, plotCA.path)
  end
end

function PlotSetUI.GetState()
  return true
end

function PlotSetUI:Dtor()
end

return PlotSetUI
