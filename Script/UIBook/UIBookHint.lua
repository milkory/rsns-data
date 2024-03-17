local View = require("UIBook/UIBookView")
local DataModel = require("UIBook/UIBookDataModel")
local Controller = {}
local GetHintPhoto = function()
  local count = 0
  local pic = PlayerData:GetFactoryData(80900006).postcardList
  count = count + table.count(pic)
  return count
end
local GetHintVideo = function()
  local count = 0
  local video = PlayerData:GetFactoryData(80900007).videoList
  count = count + table.count(video)
  return count
end
local GetHintSound = function()
  local count = 0
  local sound = PlayerData:GetFactoryData(80900008).soundList
  count = count + table.count(sound)
  return count
end
local GetHintMax = function()
  local count = 0
  count = count + GetHintPhoto() + GetHintVideo() + GetHintSound()
  return count
end
local GetPhoto = function()
  local count = 0
  count = count + table.count(PlayerData.ServerData.photo or {})
  return count
end
local GetVideo = function()
  local count = 0
  count = count + table.count(PlayerData.ServerData.video or {})
  return count
end
local GetSound = function()
  local count = 0
  count = count + table.count(PlayerData.ServerData.sound or {})
  return count
end
local GetNowHintNum = function()
  local count = 0
  count = count + GetPhoto() + GetVideo() + GetSound()
  return count
end

function Controller:Init()
  local max = GetHintMax()
  local now_num = GetNowHintNum()
  local result = now_num / max
  View.Group_BookMain.Btn_Hint.Txt_RoleNum:SetText(now_num .. "/" .. max)
  View.Group_BookMain.Btn_Hint.Txt_Progress:SetText(tostring(PlayerData:GetPreciseDecimalFloor(result * 100, 1)) .. "%")
  View.Group_BookMain.Btn_Hint.Img_bar:SetFilledImgAmount(result)
end

local InitPhoto = function()
  local max = GetHintPhoto()
  local now_num = GetPhoto()
  local result = now_num / max
  View.Group_Hint.Btn_Postcard.Txt_RoleNum:SetText(now_num .. "/" .. max)
  View.Group_Hint.Btn_Postcard.Txt_Progress:SetText(tostring(PlayerData:GetPreciseDecimalFloor(result * 100, 1)) .. "%")
  View.Group_Hint.Btn_Postcard.Img_bar:SetFilledImgAmount(result)
end
local InitVideo = function()
  local max = GetHintVideo()
  local now_num = GetVideo()
  local result = now_num / max
  View.Group_Hint.Btn_Video.Txt_RoleNum:SetText(now_num .. "/" .. max)
  View.Group_Hint.Btn_Video.Txt_Progress:SetText(tostring(PlayerData:GetPreciseDecimalFloor(result * 100, 1)) .. "%")
  View.Group_Hint.Btn_Video.Img_bar:SetFilledImgAmount(result)
end
local InitSound = function()
  local max = GetHintSound()
  local now_num = GetSound()
  local result = now_num / max
  View.Group_Hint.Btn_Tape.Txt_RoleNum:SetText(now_num .. "/" .. max)
  View.Group_Hint.Btn_Tape.Txt_Progress:SetText(tostring(PlayerData:GetPreciseDecimalFloor(result * 100, 1)) .. "%")
  View.Group_Hint.Btn_Tape.Img_bar:SetFilledImgAmount(result)
end

function Controller:OpenInitHint()
  DataModel.CurrentPage = DataModel.EnumPage.Hint
  InitPhoto()
  InitVideo()
  InitSound()
  View.Group_Hint.self:SetActive(true)
end

function Controller:Close()
  DataModel.CurrentPage = DataModel.EnumPage.Main
  View.Group_Hint.self:SetActive(false)
end

local OnlyPostCard = function(element, data)
  element.Img_pic:SetSprite(data.picturePath)
  element.Txt_name:SetText(data.name)
  element.Img_locked:SetActive(data.isLock)
end

function Controller:RefreshPostCard(element, index)
  local row = DataModel.PostCardList[index]
  for i = 1, 8 do
    local obj = "Group_picture_00" .. i - 1
    element[obj].self:SetActive(false)
    if row[i] then
      element.Txt_Title:SetText(row[i].storyName)
      OnlyPostCard(element[obj], row[i])
      element[obj].self:SetActive(true)
    end
  end
end

local ScreenPostcard = function()
  DataModel.PostCardList = {}
  local list = {}
  local postcardList = PlayerData:GetFactoryData(80900006).postcardList
  for k, v in pairs(postcardList) do
    local ca = PlayerData:GetFactoryData(v.id)
    ca.isLock = true
    for c, d in pairs(PlayerData.ServerData.photo) do
      if tonumber(d) == tonumber(v.id) then
        ca.isLock = false
      end
    end
    local story = tonumber(ca.story)
    if story then
      if list[story] == nil then
        list[story] = {}
        list[story][1] = ca
      else
        table.insert(list[story], ca)
      end
    end
  end
  DataModel.PostCardList = list
end

function Controller:ClickPostCard(row)
  CommonTips.OpenStoryItemTip(row.id, row)
end

function Controller:OpenGroupPostcard()
  View.Group_Postcard.self:SetActive(true)
  ScreenPostcard()
  View.Group_Postcard.ScrollGrid_Hint.grid.self:SetActive(false)
  if table.count(DataModel.PostCardList) > 0 then
    View.Group_Postcard.ScrollGrid_Hint.grid.self:SetActive(true)
    View.Group_Postcard.ScrollGrid_Hint.grid.self:SetDataCount(table.count(DataModel.PostCardList))
    View.Group_Postcard.ScrollGrid_Hint.grid.self:RefreshAllElement()
  end
end

function Controller:CloseGroupPostcard()
  View.Group_Postcard.self:SetActive(false)
end

function Controller:RefreshVideo(element, index)
  local row = DataModel.VideoList[index]
end

local ScreenVideo = function()
  DataModel.VideoList = {}
  local list = {}
  local videoList = PlayerData:GetFactoryData(80900007).videoList
  for k, v in pairs(videoList) do
    local ca = PlayerData:GetFactoryData(v.id)
    list[k] = ca
  end
  DataModel.VideoList = list
end

function Controller:OpenVideo()
  View.Group_Video.self:SetActive(true)
  ScreenVideo()
end

function Controller:CloseVideo()
  View.Group_Video.self:SetActive(false)
end

function Controller:RefreshTape(element, index)
  local row = DataModel.TapeList[index]
end

local ScreenTape = function()
  DataModel.TapeList = {}
  local list = {}
  local soundList = PlayerData:GetFactoryData(80900008).soundList
  for k, v in pairs(soundList) do
    local ca = PlayerData:GetFactoryData(v.id)
    list[k] = ca
  end
  DataModel.TapeList = list
end

function Controller:OpenTape()
  View.Group_Tape.self:SetActive(true)
  ScreenTape()
end

function Controller:CloseTape()
  View.Group_Tape.self:SetActive(false)
end

return Controller
