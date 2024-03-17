local view = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local PlotTextShow = Class.New("PlotTextShow", base)

function PlotTextShow:Ctor()
end

function PlotTextShow:OnStart(ca)
  view.Img_Bg:SetActive(true)
  view.Btn_Dialog.self:SetActive(true)
  view.Img_Speaker.self:SetActive(true)
end

function PlotTextShow.GetState()
  return true
end

function PlotTextShow:Dtor()
end

return PlotTextShow
