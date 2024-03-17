local View = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local PlotBoxCallBack = Class.New("PlotBoxCallBack", base)

function PlotBoxCallBack:Ctor()
end

function PlotBoxCallBack:OnStart(ca)
  require("UI" .. ca.prefabName .. "/UI" .. ca.prefabName .. "Controller")[ca.callBackName]()
end

function PlotBoxCallBack.GetState()
  return true
end

function PlotBoxCallBack:Dtor()
end

return PlotBoxCallBack
