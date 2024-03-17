local view = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local SubtitlesHide = Class.New("Subtitles", base)

function SubtitlesHide:Ctor()
end

function SubtitlesHide:OnStart(ca)
  view.Txt_Subtitles:SetActive(false)
end

function SubtitlesHide.GetState()
  return true
end

function SubtitlesHide:Dtor()
end

return SubtitlesHide
