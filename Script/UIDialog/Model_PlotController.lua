local View = require("UIDialog/UIDialogView")
local PlotChangeBg = require("UIDialog/Model_ChangeBg")
local PlotChangeRoleImg = require("UIDialog/Model_ChangeRoleImg")
local PlotRoleImgStatus = require("UIDialog/Model_RoleImgStatus")
local PlotCheckBox = require("UIDialog/Model_CheckBox")
local PlotJumpOrder = require("UIDialog/Model_JumpOrder")
local PlotText = require("UIDialog/Model_PlotText")
local PlotTree = require("UIDialog/Model_PlotTree")
local PlotTextShow = require("UIDialog/Model_PlotTextShow")
local PlotTextHide = require("UIDialog/Model_PlotTextHide")
local PlotShake = require("UIDialog/Model_Shake")
local PlotFocus = require("UIDialog/Model_Focus")
local PlotSound = require("UIDialog/Model_Sound")
local PlotMask = require("UIDialog/Model_Mask")
local DataModel = require("UIDialog/UIDialogDataModel")
local PlotChangeFace = require("UIDialog/Model_PlotChangeFace")
local RoleSpine = require("UIDialog/Model_RoleSpine")
local ChangeSpine = require("UIDialog/Model_ChangeSpine")
local Subtitles = require("UIDialog/Model_Subtitles")
local SubtitlesHide = require("UIDialog/Model_SubtitlesHide")
local Gender = require("UIDialog/Model_SelectGender")
local MaskController = require("UIDialog/Model_MaskController")
local Video = require("UIDialog/Model_PlotVideo")
local VideoHide = require("UIDialog/Model_PlotVideoHide")
local PlotImgMove = require("UIDialog/Model_PlotImgMove")
local PlotTimeLine = require("UIDialog/Model_PlotTimeLine")
local PlotSetUI = require("UIDialog/Model_PlotSetUI")
local PlotSetMaskAndBg = require("UIDialog/Model_SetMaskAndBg")
local AddSpeedController = require("UIDialog/UIDialog_AddSpeedController")
local PlotItem = require("UIDialog/Model_PlotItem")
local PlotItemHide = require("UIDialog/Model_PlotItemHide")
local PlotBoxCallBack = require("UIDialog/Model_BoxCallBack")
local WordTips = require("UIDialog/Model_WordTips")
local DialogReviewDataModel = require("UIDialogReview/UIDialogReviewDataModel")
local PlotAddSpeedReview = require("UIDialog/Model_PlotAddSpeedReview")
local classModName = {
  ["背景"] = function()
    return PlotChangeBg.New()
  end,
  ["角色"] = function()
    return PlotChangeRoleImg.New()
  end,
  ["主角立绘"] = function()
    return RoleSpine.New()
  end,
  ["立绘状态"] = function()
    return PlotRoleImgStatus.New()
  end,
  ["立绘移动"] = function()
    return PlotImgMove.New()
  end,
  ["复选框"] = function()
    return PlotCheckBox.New()
  end,
  ["跳跃命令"] = function()
    return PlotJumpOrder.New()
  end,
  ["文本剧情"] = function()
    return PlotText.New()
  end,
  ["剧情树"] = function()
    return PlotTree.New()
  end,
  ["显示文本"] = function()
    return PlotTextShow.New()
  end,
  ["隐藏文本"] = function()
    return PlotTextHide.New()
  end,
  ["震动"] = function()
    return PlotShake.New()
  end,
  ["聚焦"] = function()
    return PlotFocus.New()
  end,
  ["声音"] = function()
    return PlotSound.New()
  end,
  ["全屏遮罩"] = function()
    return PlotMask.New()
  end,
  ["切换表情"] = function()
    return PlotChangeFace.New()
  end,
  ["角色动画"] = function()
    return RoleSpine.New()
  end,
  ["切换动画"] = function()
    return ChangeSpine.New()
  end,
  ["字幕"] = function()
    return Subtitles.New()
  end,
  ["隐藏字幕"] = function()
    return SubtitlesHide.New()
  end,
  ["性别选择"] = function()
    return Gender.New()
  end,
  ["幕布开关"] = function()
    return MaskController.New()
  end,
  ["视屏播放"] = function()
    return Video.New()
  end,
  ["关闭视屏"] = function()
    return VideoHide.New()
  end,
  ["播放TimeLine"] = function()
    return PlotTimeLine.New()
  end,
  ["设置UI"] = function()
    return PlotSetUI.New()
  end,
  ["设置遮罩与背景"] = function()
    return PlotSetMaskAndBg.New()
  end,
  ["道具展示"] = function()
    return PlotItem.New()
  end,
  ["关闭道具"] = function()
    return PlotItemHide.New()
  end,
  ["复选框按钮回调"] = function()
    return PlotBoxCallBack.New()
  end,
  ["词条提示"] = function()
    return WordTips.New()
  end,
  ["加速回顾"] = function()
    return PlotAddSpeedReview.New()
  end
}
local plotIndex = 0
local continue = false
local classMod, allMod, isStopUpdate, isFinish, CA, count
local AddPlotIndex = function(addNum)
  plotIndex = plotIndex + addNum
  continue = true
end
local InitPlot = function(index)
  local data = PlayerData.ServerData
  if data ~= nil and data.user_info ~= nil and data.user_info.gender == 0 then
    DataModel.isBoy = false
  end
  DataModel.plotIndex = index
  DialogReviewDataModel.paragraphId = index
  DialogReviewDataModel.contentId = 1
  DialogReviewDataModel.paragraphContent = DataModel.plotList
  CA = DataModel.plotList[index]
  if CA.mod == "字幕" and plotIndex + 1 <= #DataModel.plotList then
    DataModel.isAutoCloseSubtitles = false
    local ca = DataModel.plotList[index + 1]
    if ca.mod == "文本剧情" then
      DataModel.isAutoCloseSubtitles = true
    end
  end
  classMod = classModName[CA.mod]()
  count = count + 1
  allMod[count] = classMod
  if next(DataModel.ReviewList) and CA.mod == "复选框按钮回调" then
    return
  end
  if CA.mod == "主角立绘" then
    local caID = PlayerData.IsMale() and CA.BoyID or CA.GirlID
    CA = PlayerData:GetFactoryData(caID)
  end
  classMod:OnStart(CA, AddPlotIndex)
end
local End = function(isSkip)
  if DataModel.UploadingParagraphId > 0 then
    if Net ~= nil then
      Net:SendProto("plot.note", nil, DataModel.UploadingParagraphId)
    end
    PlayerData.plot_paragraph[tostring(DataModel.UploadingParagraphId)] = DataModel.UploadingParagraphId
    MapNeedleData.NeedleCompletedSendServer()
    if MapNeedleEventData.EventCompletedSendServer() then
      local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
      TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.Refresh)
      MapNeedleEventData.ResetEventData()
    end
  end
  isStopUpdate = true
  isFinish = true
  continue = false
  if allMod == nil then
    CS.UnityEngine.Debug.LogError("段落配置错误,需要策划解决!!!\n段落勾选了不返回上个界面,会卡在最后一段剧情\n\n解决方式:\n方式1.勾选段落-返回上个界面,方式\n2.引导工厂+引导+引导命令工厂")
    UIManager:GoBack()
  else
    for k, v in pairs(allMod) do
      v:Dtor(v)
    end
    allMod = nil
    local id = tonumber(DataModel.Ca.id)
    local idCN = DataModel.Ca.idCN
    if isSkip then
      ReportTrackEvent.Story_play(1, id, idCN, plotIndex, 1, 511003, TimeUtil:GetServerTimeStamp() - DataModel.duration)
    else
      ReportTrackEvent.Story_play(1, id, idCN, -1, 1, 511002, 0)
    end
    if isSkip then
      local gotWord = {}
      local index = 0
      for i = plotIndex, #DataModel.plotList do
        local ca = DataModel.plotList[i]
        if ca.mod == "词条提示" then
          local hasGot = false
          if 0 < ca.tip01 then
            for k, v in pairs(PlayerData.gotWord) do
              if tonumber(v) == ca.tip01 then
                hasGot = true
                break
              end
            end
            if hasGot == false then
              index = index + 1
              gotWord[index] = ca.tip01
            end
          end
          if 0 < ca.tip02 and ca.tip01 ~= ca.tip02 then
            hasGot = false
            for k, v in pairs(PlayerData.gotWord) do
              if tonumber(v) == ca.tip02 then
                hasGot = true
                break
              end
            end
            if hasGot == false then
              index = index + 1
              gotWord[index] = ca.tip02
            end
          end
        end
      end
      if next(gotWord) ~= nil then
        if Net ~= nil then
          Net:SendProto("plot.note_noun", function(json)
            UIManager:Open("UI/Dialog/Tips/DialogTips", Json.encode({isOpen = false}))
          end, table.concat(gotWord, ","))
        else
          UIManager:Open("UI/Dialog/Tips/DialogTips", Json.encode({isOpen = false}))
        end
      end
    end
    DOTweenTools.KillAll()
    AddSpeedController.Destroy()
    View.Img_Transit:SetActive(false)
    local nextParagraphId = -1
    local index = 1
    for k, v in pairs(DataModel.ReviewList) do
      index = index + 1
      if DataModel.CurrentParagraphId == v then
        break
      end
    end
    if nextParagraphId == -1 then
      nextParagraphId = DataModel.Ca.nextParagraph or -1
    end
    if next(DataModel.ReviewList) then
      nextParagraphId = DataModel.ReviewList[index] or -1
    end
    isFinish = true
    if 0 < nextParagraphId and DataModel.ClosePanel then
      UIManager:Open(UIPath.UIDialog, Json.encode({id = nextParagraphId}))
      isFinish = false
    elseif (DataModel.Ca.isGoBack or next(DataModel.ReviewList) ~= nil) and DataModel.ClosePanel then
      UIManager:GoBack(next(DataModel.ReviewList) == nil)
    end
    if nextParagraphId < 0 then
      DataModel.ReviewList = {}
    end
  end
  PlotManager:SetPlotStatus(isFinish)
  if isSkip == true then
    View.self:Cancel()
  else
    View.self:Confirm()
  end
end
local controller = {
  Init = function()
    for k, v in pairs(View.Group_Option) do
      if v ~= View.Group_Option.self then
        v.self:SetActive(false)
      end
    end
    View.Btn_Dialog.self:SetActive(false)
    View.Img_Speaker.self:SetActive(false)
    View.Group_Shake.Group_Img.Img_Paint01:SetActive(false)
    View.Group_Shake.Group_Img.Img_Paint02:SetActive(false)
    View.Group_Shake.Group_Img.Img_Paint03:SetActive(false)
    View.Group_Shake.Group_Spines.SpineAnimation_Role01:SetActive(false)
    View.Group_Shake.Group_Spines.SpineAnimation_Role02:SetActive(false)
    View.Group_Shake.Group_Spines.SpineAnimation_Role03:SetActive(false)
    View.Txt_Subtitles:SetActive(false)
    View.Group_Gender:SetActive(false)
    DataModel.ForceAutoPlay(DataModel.Ca.isAuto)
    DataModel.SetSkipAndAutoBtn(not DataModel.Ca.isBanSkip)
    if DataModel.isReview then
      View.Btn_Skip:SetActive(true)
    end
    View.Video_BG:SetActive(false)
    DataModel.InitAutoSpeed()
    View.Group_Item:SetActive(false)
    View.Img_Face:SetActive(false)
    allMod = {}
    DialogReviewDataModel.ClearCoachData()
    continue = true
    plotIndex = 1
    isStopUpdate = false
    isFinish = false
    count = 0
    DataModel.Video.isPlaying = false
    DataModel.TimeLine.isPlaying = false
  end,
  OnEnd = function(self)
    End(true)
  end,
  Update = function()
    if isStopUpdate then
      return
    end
    if continue then
      continue = false
      if plotIndex <= #DataModel.plotList then
        InitPlot(plotIndex)
        plotIndex = plotIndex + 1
      else
        End()
      end
    end
    if isStopUpdate then
      return
    end
    classMod:OnUpdate()
    DataModel.SkipCurrentNode()
    if not continue then
      if CA.isWaitFinish then
        continue = classMod.GetState(classMod)
      else
        continue = true
      end
    end
    if DataModel.SpeedChanged == true then
      DataModel.SpeedChanged = false
      if CA.mod == "播放TimeLine" and classMod.GetState() ~= true then
        classMod.SetSpeed(DataModel.Speed)
      end
    end
    AddSpeedController.Update()
  end,
  JumpPlot = function(index)
    if index <= #DataModel.plotList then
      DataModel.RunSkipCurrentNodeCb()
      plotIndex = index
      InitPlot(plotIndex)
      plotIndex = plotIndex + 1
      continue = false
    end
  end
}

function controller:IsFinish()
  return isFinish
end

function controller.resetPlotList(resetList)
  if resetList == nil then
    return
  end
  DataModel.plotList = resetList
  plotIndex = 0
end

function controller.InsertPlotList(insertList)
  if insertList == nil then
    return
  end
  for k, v in pairs(insertList) do
    table.insert(DataModel.plotList, plotIndex + k - 1, v)
  end
end

function controller.GetClassModName(mod)
  return classModName[mod]()
end

return controller
