local View = require("UIStoryItemTip/UIStoryItemTipView")
local DataModel = {}
DataModel.isDrag = false
DataModel.isPlaying = false

function DataModel.TimeShift(time)
  local sec = tonumber(time)
  if sec then
    local minute = tostring(math.floor(sec // 60))
    if #minute == 1 then
      minute = "0" .. minute
    end
    sec = tostring(math.floor(sec % 60))
    if #sec == 1 then
      sec = "0" .. sec
    end
    return minute .. ":" .. sec
  else
    return ""
  end
end

local SetCurrentTime = function(value)
  DataModel.currentSec = value
  View.Group_tape.Group_Time.Txt_TimeNow:SetText(DataModel.TimeShift(value))
end
local SetBar = function(value)
  View.Group_tape.Group_Time.Slider_Time:SetSliderValue(value)
end
local lastValue = 0

function DataModel.RefreshValue()
  if DataModel.CA.id == 11400027 and DataModel.Music and DataModel.isPlaying and not DataModel.isDrag then
    local value = math.floor(DataModel.Music.audioSource.time)
    if value ~= lastValue then
      SetBar(value)
      SetCurrentTime(value)
      lastValue = value
      if lastValue >= DataModel.Sound.sec then
        DataModel.currentSec = 0
        DataModel.Music:Pause(true)
      end
    end
  end
end

function DataModel.OnValueChange(value)
  SetCurrentTime(value)
end

function DataModel.Play()
  View.Group_tape.Group_Time.Txt_TimeAll:SetText(DataModel.Sound.timeStr)
  View.Group_tape.Group_Time.Txt_TimeNow:SetText(DataModel.TimeShift(DataModel.currentSec))
  local bm = SoundManager:CreateBM(30000704)
  if bm then
    DataModel.Music = bm
  end
  local max = 0
  if DataModel.Sound then
    max = DataModel.Sound.sec
  end
  View.Group_tape.Group_Time.Slider_Time:SetSliderValue(DataModel.currentSec)
  View.Group_tape.Group_Time.Slider_Time:SetMinAndMaxValue(0, max)
  DataModel.Music:Play(DataModel.currentSec)
  DataModel.isPlaying = true
end

local Pause = function()
  if DataModel.Music then
    if DataModel.isPlaying then
      DataModel.Music:Pause(false, DataModel.currentSec)
    else
      DataModel.Music:Pause(true)
    end
  else
    DataModel.Play()
  end
end

function DataModel.OnPoint(state)
  DataModel.isDrag = state
  if state == false and DataModel.isPlaying then
    Pause()
  end
end

return DataModel
