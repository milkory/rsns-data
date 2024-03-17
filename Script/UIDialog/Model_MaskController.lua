local view = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local MaskController = Class.New("MaskController", base)

function MaskController:Ctor()
end

function MaskController:OnStart(ca)
  view.Img_Bg:SetActive(ca.isOpenMask)
end

function MaskController.GetState()
  return true
end

function MaskController:Dtor()
end

return MaskController
