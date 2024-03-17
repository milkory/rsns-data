local View = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local PlotItemHide = Class.New("PlotItemHide", base)

function PlotItemHide:Ctor()
end

function PlotItemHide:OnStart(ca)
  DOTweenTools.DOFadeCallback(View.Group_Item.Img_Item.transform, 1, 0, ca.duration, function()
    View.Group_Item:SetActive(false)
  end, ca.easeInt)
end

function PlotItemHide.GetState()
  return true
end

function PlotItemHide:Dtor()
end

return PlotItemHide
