local view = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local SetMaskAndBg = Class.New("Model_SetMaskAndBg", base)

function SetMaskAndBg:Ctor()
end

function SetMaskAndBg:OnStart(ca)
  view.Group_Shake.Img_TEMP:SetActive(ca.isActiveMask)
  view.Group_Shake.Img_Mask:SetActive(ca.isActiveBg)
end

function SetMaskAndBg.GetState()
  return true
end

function SetMaskAndBg:Dtor()
end

return SetMaskAndBg
