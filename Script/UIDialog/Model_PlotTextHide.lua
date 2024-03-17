local view = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local PlotTextHide = Class.New("PlotTextHide", base)

function PlotTextHide:Ctor()
end

function PlotTextHide:OnStart(ca)
  view.Img_Bg:SetActive(false)
  view.Btn_Dialog.self:SetActive(false)
  view.Img_Speaker.self:SetActive(false)
end

function PlotTextHide.GetState()
  return true
end

function PlotTextHide:Dtor()
end

return PlotTextHide
