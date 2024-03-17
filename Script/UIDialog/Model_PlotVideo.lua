local base = require("UIDialog/Model_PlotBase")
local Video = Class.New("PlotVideo", base)
local View = require("UIDialog/UIDialogView")
local DataModel = require("UIDialog/UIDialogDataModel")
local isFinish = false
local isContinueBGMAfterPlayOver = true

function Video.Ctor()
  isFinish = false
end

function Video:OnStart(ca)
  isFinish = false
  isContinueBGMAfterPlayOver = ca.isContinueBGMAfterPlayOver
  DataModel.HideView(true)
  View.Video_BG:SetActive(true)
  DataModel.Video.isSkip = ca.isSkip
  if DataModel.isReview == true then
    DataModel.Video.isSkip = true
  end
  View.Btn_Skip:SetActive(DataModel.Video.isSkip)
  DataModel.Video.isOnlySkipVideo = ca.isOnlySkipVideo
  DataModel.Video.isPlaying = not ca.isLoop
  if not ca.isLoop then
    DataModel.SetSkipAndAutoBtn(ca.isSkip)
    if DataModel.isReview == true then
      View.Btn_Skip:SetActive(true)
    end
  end
  local pathList = string.split(ca.path, "|")
  local videoPath = pathList[1]
  if DataModel.isBoy == false and pathList[2] and pathList[2] ~= "" then
    videoPath = pathList[2]
  end
  View.Video_BG:SetIsContinueBGM(isContinueBGMAfterPlayOver)
  View.Video_BG:Play(videoPath, ca.isLoop, false, ca.isPauseBGM, function()
    DataModel.Video.isPlaying = false
    View.Btn_Skip:SetActive(not DataModel.Video.isSkip)
    if DataModel.isReview == true then
      View.Btn_Skip:SetActive(true)
    end
    DataModel.HideView(false)
    isFinish = true
  end)
end

function Video.GetState()
  return isFinish
end

function Video:Dtor()
  if not isFinish then
    View.Video_BG:VideoOver(isContinueBGMAfterPlayOver)
  end
end

return Video
