local view = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local VideoHide = Class.New("Model_PlotVideoHide", base)

function VideoHide:Ctor()
end

function VideoHide:OnStart(ca)
  view.Video_BG:VideoOver()
end

function VideoHide.GetState()
  return true
end

function VideoHide:Dtor()
end

return VideoHide
