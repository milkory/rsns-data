local View = require("UIStoryItemTip/UIStoryItemTipView")
local DataModel = require("UIStoryItemTip/UIStoryItemTipDataModel")
local ViewFunction = require("UIStoryItemTip/UIStoryItemTipViewFunction")
local InitVideo = function()
  View.Group_video.Txt_Name:SetText(DataModel.CA.name)
  View.Group_video.Txt_Describe:SetText(DataModel.CA.des)
  local video_ca = PlayerData:GetFactoryData(DataModel.CA.videoId)
  View.Group_video.Video_video.IsPlay = true
  View.Group_video.Video_video:Play(video_ca.videoPath, true, false)
end
local InitTape = function()
  DataModel.isPlaying = false
  DataModel.isDrag = false
  DataModel.currentSec = 0
  View.Group_tape.Txt_Name:SetText(DataModel.CA.name)
  View.Group_tape.Txt_Describe:SetText(DataModel.CA.des)
  local sound_ca = PlayerData:GetFactoryData(DataModel.CA.soundId)
  local sound_list = {}
  sound_list.id = DataModel.CA.soundId
  sound_list.name = sound_ca.name
  sound_list.timeStr = DataModel.TimeShift(sound_ca.time)
  sound_list.sec = sound_ca.time
  DataModel.Sound = sound_list
  SoundManager:PauseBGM(true)
  DataModel.Play()
end
local InitPicture = function()
  View.Group_picture.Txt_Name:SetText(DataModel.CA.name)
  View.Group_picture.ScrollView_picture.Viewport.Content.Txt_Content:SetText(DataModel.Data.text)
  View.Group_picture.ScrollView_picture.Viewport.Content.Img_Discription.Txt_Title:SetText(DataModel.CA.name)
  View.Group_picture.ScrollView_picture.Viewport.Content.Img_Discription.Txt_Describe:SetText(DataModel.CA.des)
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Img_date:SetActive(true)
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Txt_Tip:SetActive(true)
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Txt_Title:SetText(DataModel.Data.title)
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Txt_Addresser:SetText(DataModel.Data.from)
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Img_pictureIcon:SetSprite(DataModel.CA.iconPath)
  View.Group_picture.ScrollView_picture.Viewport.Content.Img_pic:SetSprite(PlayerData:GetFactoryData(DataModel.CA.pictureId).picturePath)
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Txt_Date:SetText(os.date("%Y/%m/%d", DataModel.Data.gen_time))
  View.Group_picture.ScrollView_picture.Viewport.Content.self:SetLocalPositionY(0)
end
local InitBookPicture = function()
  View.Group_picture.Txt_Name:SetText(DataModel.CA.name)
  View.Group_picture.ScrollView_picture.Viewport.Content.Txt_Content:SetText(DataModel.CA.mailContent)
  View.Group_picture.ScrollView_picture.Viewport.Content.Img_Discription.Txt_Title:SetText(DataModel.CA.name)
  View.Group_picture.ScrollView_picture.Viewport.Content.Img_Discription.Txt_Describe:SetText(DataModel.CA.des)
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Txt_Date:SetText("")
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Txt_Tip:SetActive(false)
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Img_date:SetActive(false)
  View.Group_picture.ScrollView_picture.Viewport.Content.Img_pic:SetSprite(DataModel.CA.picturePath)
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Txt_Title:SetText(DataModel.CA.mailName)
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Txt_Addresser:SetText(DataModel.CA.mailSender)
  View.Group_picture.ScrollView_picture.Viewport.Content.Group_Above.Img_pictureIcon:SetSprite(DataModel.CA.iconPath)
  View.Group_picture.ScrollView_picture.Viewport.Content.self:SetLocalPositionY(0)
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local data = Json.decode(initParams)
      print_r(data)
      DataModel.Data = data
      DataModel.CA = PlayerData:GetFactoryData(data.id)
      local StoryItemConfig = {
        ["录像"] = {
          obj = View.Group_video,
          func = InitVideo
        },
        ["磁带"] = {
          obj = View.Group_tape,
          func = InitTape
        },
        ["照片"] = {
          obj = View.Group_picture,
          func = InitPicture
        },
        ["基础插图"] = {
          obj = View.Group_picture,
          func = InitBookPicture
        }
      }
      for k, v in pairs(StoryItemConfig) do
        v.obj.self:SetActive(false)
      end
      StoryItemConfig[DataModel.CA.mod].obj.self:SetActive(true)
      StoryItemConfig[DataModel.CA.mod].func()
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    DataModel.RefreshValue()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
