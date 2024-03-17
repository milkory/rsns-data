local View = require("UIPlotReview/UIPlotReviewView")
local DataModel = require("UIPlotReview/UIPlotReviewDataModel")
local DialogDataModel = require("UIDialog/UIDialogDataModel")
local Controller = {}

function Controller.InitView(completeList)
  local data = PlayerData:GetFactoryData(99900046, "ConfigFactory")
  if data ~= nil and data.PlotReviewList ~= nil then
    DataModel.Level = 1
    DataModel.ChapterIndex = 1
    DataModel.LastChapterIndex = 0
    View.Img_Bg1.Group_PlotList:SetActive(false)
    DataModel.isMale = true
    local serverData = PlayerData.ServerData
    if serverData ~= nil and serverData.user_info ~= nil and serverData.user_info.gender == 0 then
      DataModel.isMale = false
    end
    DataModel.Data = {}
    local index = 0
    for k, v in pairs(data.PlotReviewList) do
      local list = {}
      local tempData = PlayerData:GetFactoryData(v.ChapterList, "PlotFactory")
      list.MainTitle = tempData.MainTitle
      list.TitleEN = tempData.TitleEN
      list.CoverPage = tempData.CoverPage
      list.MaleVideo = tempData.MaleVideo
      list.FemaleVideo = tempData.FemaleVideo
      local isUnlockChapter = false
      local tList = {}
      local optionCount = 0
      local optionSum = 0
      local sortIndex = 0
      for k1, v1 in pairs(tempData.IncludeStories) do
        local temp = {}
        sortIndex = sortIndex + 1
        temp.sortIndex = sortIndex
        temp.SecTitle = v1.SecTitle
        temp.Picture = v1.Picture
        temp.SecTitleDesc = v1.SecTitleDesc
        local tempList = {}
        if 0 < v1.IncludeParagraph then
          local IncludeParagraph = {}
          IncludeParagraph = PlayerData:GetFactoryData(v1.IncludeParagraph, "ListFactory").IncludeParagraph
          for k2, v2 in pairs(IncludeParagraph) do
            tempList[k2] = v2.id
          end
        end
        temp.reviewList = tempList
        local isUnlock = false
        local unlockId = tostring(v1.UnlockOption)
        for k2, v2 in pairs(completeList) do
          if v2 == unlockId then
            isUnlockChapter = true
            isUnlock = true
            optionCount = optionCount + 1
            break
          end
        end
        temp.isUnlock = isUnlock
        tList[k1] = temp
        optionSum = optionSum + 1
      end
      list.optionCount = optionCount
      list.optionSum = optionSum
      list.isUnlock = isUnlockChapter
      table.sort(tList, function(a, b)
        if a.isUnlock == b.isUnlock then
          return a.sortIndex < b.sortIndex
        end
        if a.isUnlock and not b.isUnlock then
          return true
        end
        return false
      end)
      list.IncludeStories = tList
      index = index + 1
      DataModel.Data[index] = list
    end
    SoundManager:PauseBGM(true)
    View.Img_Bg1.Group_Tab.ScrollGrid_.grid.self:SetDataCount(#DataModel.Data)
    View.Img_Bg1.Group_Tab.ScrollGrid_.grid.self:RefreshAllElement()
  end
end

local PlayVideo = function(data)
  local view = View.Img_Bg1.Group_Video
  view:SetActive(true)
  if data ~= nil then
    if DataModel.LastChapterIndex == DataModel.ChapterIndex then
      if data.isUnlock then
        view.Btn_Item.Video_Main:PlayAgain()
      else
        view.Btn_Item.Video_Main:Pause()
      end
      return
    end
    DataModel.LastChapterIndex = DataModel.ChapterIndex
    local videoId = data.FemaleVideo
    if DataModel.isMale then
      videoId = data.MaleVideo
    end
    if 0 < videoId then
      local videoData = PlayerData:GetFactoryData(videoId, "VideoFactory")
      if videoData ~= nil and videoData.videoPath ~= nil and videoData.videoPath ~= "" then
        view.Btn_Item.Video_Main:Play(videoData.videoPath, true, not data.isUnlock, true, nil)
      end
    end
    view.Btn_Item.Img_Mask:SetActive(not data.isUnlock)
    view.Btn_Item.Img_MaskBlack:SetActive(not data.isUnlock)
    view.Btn_Item.Group_Unlock:SetActive(data.isUnlock)
  else
    view.Btn_Item.Video_Main:Pause()
  end
end

function Controller.SetChapterElement(element, index)
  local data = DataModel.Data[index]
  element.Btn_.Txt_:SetText(data.MainTitle)
  element.Img_Mask:SetActive(not data.isUnlock)
  element.Btn_.Img_Off:SetActive(data.isUnlock)
  if data.isUnlock then
    element.Btn_.Img_Off:SetSprite(data.CoverPage)
  end
  local isActive = DataModel.ChapterIndex == index
  element.Btn_.Img_Select:SetActive(isActive)
  if DataModel.Level == 1 and isActive then
    PlayVideo(data)
  end
  if isActive then
    local view = View.Img_Bg1.Group_Video.Btn_Item
    view.Txt_ChapterNameCN:SetText(data.MainTitle)
    view.Txt_ChapterNameEN:SetText(data.TitleEN)
    view.Img_ProcessBg.Txt_Num:SetText(tostring(data.optionCount) .. "/" .. tostring(data.optionSum))
  end
end

function Controller.ChapterBtn(index)
  DataModel.ChapterIndex = index
  View.Img_Bg1.Group_Tab.ScrollGrid_.grid.self:RefreshAllElement()
  if DataModel.Level == 2 then
    local data = DataModel.Data[index]
    if data.isUnlock then
      local view = View.Img_Bg1.Group_PlotList.Img_Frame.ScrollGrid_.grid.self
      view:SetDataCount(#data.IncludeStories)
      view:RefreshAllElement()
      view:MoveToTop()
      View.Img_Bg1.Group_PlotList.Img_ProcessBg.Txt_Num:SetText(string.format("%d/%d", data.optionCount, data.optionSum))
    else
      Controller.OpenChapter(false)
    end
  end
end

function Controller.OpenChapter(isOpen)
  local data = DataModel.Data[DataModel.ChapterIndex]
  if isOpen and data.isUnlock == false then
    return
  end
  local view = View.Img_Bg1.Group_PlotList
  view:SetActive(isOpen)
  if isOpen then
    DataModel.Level = 2
    view.Img_Frame.ScrollGrid_.grid.self:SetDataCount(#data.IncludeStories)
    view.Img_Frame.ScrollGrid_.grid.self:RefreshAllElement()
    view.Img_Frame.ScrollGrid_.grid.self:MoveToTop()
    view.Img_ProcessBg.Txt_Num:SetText(tostring(data.optionCount) .. "/" .. tostring(data.optionSum))
  else
    DataModel.Level = 1
    PlayVideo(data)
  end
end

function Controller.SetSectionElement(element, index)
  local data = DataModel.Data[DataModel.ChapterIndex].IncludeStories[index]
  element.Img_PicBg.Img_:SetSprite(data.Picture)
  element.Txt_Title:SetText(data.SecTitle)
  element.Txt_Desc:SetText(data.SecTitleDesc)
  element.Img_Mask:SetActive(not data.isUnlock)
  PlayVideo()
end

function Controller.SectionPlayBtn(index)
  local data = DataModel.Data[DataModel.ChapterIndex].IncludeStories[index]
  if #data.reviewList > 0 then
    DialogDataModel.ReviewList = data.reviewList
    View.Img_Bg1.Group_Video.Btn_Item.Video_Main.self.IsNotRelease = true
    View.self.gameObject:SetActive(false)
    UIManager:Open(UIPath.UIDialog, Json.encode({
      id = data.reviewList[1]
    }))
  end
end

function Controller.SectionDetailBtn(index)
end

return Controller
