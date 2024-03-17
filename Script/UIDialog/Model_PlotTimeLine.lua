local base = require("UIDialog/Model_PlotBase")
local TimeLine = require("Common/TimeLine")
local DataModel = require("UIDialog/UIDialogDataModel")
local PlotTimeLine = Class.New("PlotTimeLine", base)
local View = require("UIDialog/UIDialogView")
local isFinish = false

function PlotTimeLine:Ctor()
end

function PlotTimeLine:OnStart(ca)
  isFinish = false
  DataModel.HideView(true)
  View.Btn_Auto.self:SetActive(true)
  DataModel.TimeLineEventID = -1
  local tCA = PlayerData:GetFactoryData(ca.TimeLine, "TimeLineFactory")
  if tCA ~= nil then
    TimeLineCameraManager:SetActive(true, tCA.processPath, tCA.camX, tCA.camY, tCA.camZ, tCA.rotationX, tCA.fOV, tCA.skyColorStr, tCA.equatorColorStr, tCA.groundColorStr, "TimeLine/TimeLineCamera", tCA.cubemap, tCA.isChangeLighting)
    View.Btn_TimeLine:SetActive(tCA.showBtn)
    if tCA.showBtn then
      View.Btn_TimeLine:SetLocalPosition(Vector3(tCA.btnX, tCA.btnY, 0))
      DataModel.TimeLineEventID = tCA.eventId
    end
  end
  DataModel.TimeLine.id = ca.TimeLine
  DataModel.TimeLine.isSkip = ca.isSkip
  View.Btn_Skip:SetActive(DataModel.TimeLine.isSkip)
  DataModel.TimeLine.isOnlySkipTimeLine = ca.isOnlySkipTimeLine
  TimeLine.LoadTimeLine(DataModel.TimeLine.id, function()
    DataModel.TimeLine.isPlaying = false
    TimeLineCameraManager:SetActive(false)
    View.Btn_Skip:SetActive(not DataModel.TimeLine.isSkip)
    DataModel.HideView(false)
    isFinish = true
  end, true)
  local timeLineCA = PlayerData:GetFactoryData(DataModel.TimeLine.id, "TimeLineFactory")
  if timeLineCA ~= nil then
    local isLoop = timeLineCA.isLoop or false
    DataModel.TimeLine.isPlaying = not isLoop
    DataModel.InitAutoBtn()
    TimelineManager:AddTimelineSpeed(timeLineCA.timeLinePath, math.max(DataModel.Speed, 1))
  end
end

function PlotTimeLine.GetState()
  return isFinish
end

function PlotTimeLine:Dtor()
  local timeLineCA = PlayerData:GetFactoryData(DataModel.TimeLine.id, "TimeLineFactory")
  if timeLineCA and timeLineCA.timeLinePath ~= nil then
    TimelineManager:CompleteRemoveTimeLine(timeLineCA.timeLinePath)
  end
end

function PlotTimeLine.SetSpeed(sp)
  local timeLineCA = PlayerData:GetFactoryData(DataModel.TimeLine.id, "TimeLineFactory")
  TimelineManager:AddTimelineSpeed(timeLineCA.timeLinePath, math.max(sp, 1))
end

return PlotTimeLine
