local View = require("UIBook/UIBookView")
local DataModel = require("UIBook/UIBookDataModel")
local Controller = {}
local Data = {}
local GotData = {}
local allCount = 0
local getCount = 0
local playView, currentMusicData, currentTimeView, barView, bookMusic
local isPlaying = false
local isDrag = false
local currentSec = 0
local TimeShift = function(time)
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
local IsUnlock = function(data, id)
  if data then
    for k, v in pairs(data) do
      if tonumber(v) == id then
        return true
      end
    end
  end
  return false
end
local InitData = function()
  getCount = 0
  local index = 0
  local gotData = PlayerData.ServerData.music
  local all = PlayerData:GetFactoryData(80900002, "BookFactory")
  if all ~= nil and all.musicList ~= nil then
    local tab = {}
    for k, v in pairs(all.musicList) do
      local id = tonumber(v.id)
      local info = {}
      local data = PlayerData:GetFactoryData(id, "SoundFactory")
      info.id = id
      info.name = data.name
      local sec = data.time
      info.timeStr = TimeShift(sec)
      info.sec = sec
      info.condition = data.condition
      local isUnlock = IsUnlock(gotData, id)
      info.isUnlock = isUnlock
      info.isSelect = false
      index = index + 1
      info.index = index
      if isUnlock then
        getCount = getCount + 1
        GotData[index] = info
      end
      tab[index] = info
    end
    Data = tab
    allCount = index
  end
end
local InitView = function()
  local result = getCount / allCount
  local Btn = View.Group_BookMain.Btn_Music
  Btn.Txt_RoleNum:SetText(getCount .. "/" .. allCount)
  Btn.Txt_Progress:SetText(tostring(PlayerData:GetPreciseDecimalFloor(result * 100, 1)) .. "%")
  Btn.Img_bar:SetFilledImgAmount(result)
  View.Group_Music:SetActive(false)
end
local SetTitle = function()
  local text
  if currentMusicData then
    text = currentMusicData.name
  else
    text = GetText(80600200)
  end
  View.Group_Music.Group_Play.Group_Record.Txt_Music:SetText(text)
end
local SetCurrentTime = function(time)
  currentSec = time
  currentTimeView:SetText(TimeShift(time))
end
local SetAllTime = function()
  local timeStr
  if currentMusicData then
    timeStr = TimeShift(currentMusicData.sec)
  else
    timeStr = TimeShift(0)
  end
  playView.Group_Time.Txt_TimeAll:SetText(timeStr)
end
local SetBarMinMax = function()
  local max = 0
  if currentMusicData then
    max = currentMusicData.sec
  end
  barView:SetMinAndMaxValue(0, max)
end
local SetBar = function(value)
  barView:SetSliderValue(value)
end
local SetPlayBtn = function(isPlay)
  playView.Btn_Pause.Img_Pause:SetActive(isPlay)
  playView.Btn_Pause.Img_Play:SetActive(not isPlay)
end
local InitPlayView = function(isPlay)
  SetTitle()
  SetCurrentTime(currentSec)
  SetBar(currentSec)
  SetAllTime()
  SetBarMinMax()
  SetPlayBtn(isPlay)
end
local Play = function()
  if currentMusicData then
    local bm = SoundManager:CreateBM(currentMusicData.id)
    if bm then
      bookMusic = bm
    end
    currentMusicData.sec = math.floor(bookMusic:GetLength())
    SetBar(currentSec)
    SetAllTime()
    SetBarMinMax()
    bookMusic:Play(currentSec)
    isPlaying = true
  end
end
local Pause = function()
  if bookMusic then
    if isPlaying then
      bookMusic:Pause(false, currentSec)
    else
      bookMusic:Pause(true)
    end
  else
    Play()
  end
end
local Stop = function()
  if bookMusic then
    bookMusic:Stop()
  end
  bookMusic = nil
  isPlaying = false
  isDrag = false
end
local lastValue = 0

function Controller.RefreshValue()
  if bookMusic and not isDrag and isPlaying then
    local value = math.floor(bookMusic.audioSource.time)
    if value ~= lastValue then
      SetBar(value)
      lastValue = value
      if lastValue >= currentMusicData.sec then
        currentSec = 0
        Controller.Pause()
      end
    end
  end
end

local SetMusicState = function(element, data)
  local name = data.name
  local time = data.timeStr
  local on = element.Group_On
  local off = element.Group_Off
  local lock = element.Group_Lock
  on:SetActive(false)
  off:SetActive(false)
  lock:SetActive(false)
  if data.isUnlock then
    if data.isSelect then
      on:SetActive(true)
      on.Txt_Music:SetText(name)
      on.Txt_Time:SetText(time)
    else
      off:SetActive(true)
      off.Txt_Music:SetText(name)
      off.Txt_Time:SetText(time)
    end
  else
    lock:SetActive(true)
    lock.Txt_Music:SetText(name)
    lock.Txt_Time:SetText(time)
    lock.Img_Lock.Txt_Des:SetText(data.condition)
  end
end
local RefreshCatalog = function(index, isPlay)
  local data = GotData[index]
  if data.isSelect and isPlay then
    return
  end
  for k, v in pairs(GotData) do
    v.isSelect = k == index
  end
  currentMusicData = data
  if isPlay then
    currentSec = 0
    Play()
  end
  InitPlayView(isPlay)
  View.Group_Music.Group_MusicList.ScrollGrid_List.grid.self:RefreshAllElement()
end
local RecoverMusic = function()
  if table.count(GotData) == 0 then
    InitPlayView(false)
    View.Group_Music.Group_MusicList.ScrollGrid_List.grid.self:RefreshAllElement()
  else
    local index = PlayerPrefs.GetInt("MusicIndex")
    local isGot = false
    for k, v in pairs(GotData) do
      if k == index then
        isGot = true
        break
      end
    end
    if not isGot then
      for k, v in pairs(GotData) do
        index = k
        break
      end
    end
    RefreshCatalog(index, false)
  end
end
local OpenBGM = function(isOpen)
  SoundManager:PauseBGM(not isOpen)
end

function Controller.SetElement(element, elementIndex)
  element.Btn_Music:SetClickParam(elementIndex)
  SetMusicState(element, Data[tonumber(elementIndex)])
end

function Controller.Init()
  Stop()
  currentSec = 0
  currentMusicData = nil
  playView = View.Group_Music.Group_Play.Group_Player
  currentTimeView = playView.Group_Time.Txt_TimeNow
  barView = playView.Group_Time.Slider_Time
  InitData()
  InitView()
end

function Controller.Open()
  DataModel.CurrentPage = DataModel.EnumPage.Music
  View.Group_Music:SetActive(true)
  View.Group_Music.Group_MusicList.ScrollGrid_List.grid.self:SetDataCount(table.count(Data))
  OpenBGM(false)
  RecoverMusic()
end

function Controller.Close()
  DataModel.CurrentPage = DataModel.EnumPage.Main
  if currentMusicData then
    PlayerPrefs.SetInt("MusicIndex", currentMusicData.index)
  end
  View.Group_Music:SetActive(false)
  Stop()
  OpenBGM(true)
end

function Controller.OnClickBtn(elementIndex)
  local data = GotData[elementIndex]
  if not data then
    return
  end
  RefreshCatalog(elementIndex, true)
end

function Controller.OnValueChange(value)
  SetCurrentTime(value)
end

function Controller.Last()
  if currentMusicData then
    local index = currentMusicData.index
    local lastIndex = 0
    for k, v in pairs(GotData) do
      lastIndex = k
    end
    for k, v in pairs(GotData) do
      if k == index then
        break
      end
      lastIndex = k
    end
    RefreshCatalog(lastIndex, true)
  end
end

function Controller.Pause()
  isPlaying = not isPlaying
  SetPlayBtn(isPlaying)
  Pause()
end

function Controller.Next()
  if currentMusicData then
    local index = currentMusicData.index
    local nextIndex = 0
    for k, v in pairs(GotData) do
      nextIndex = k
      break
    end
    local isCurrent = false
    for k, v in pairs(GotData) do
      if isCurrent then
        nextIndex = k
        break
      end
      if k == index then
        isCurrent = true
      end
    end
    RefreshCatalog(nextIndex, true)
  end
end

function Controller.OnPoint(isDown)
  isDrag = isDown
  if isDown == false and isPlaying then
    Pause()
  end
end

return Controller
