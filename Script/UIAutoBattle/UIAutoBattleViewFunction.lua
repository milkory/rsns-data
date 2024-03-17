local View = require("UIAutoBattle/UIAutoBattleView")
local DataModel = require("UIAutoBattle/UIAutoBattleDataModel")
local IsAutoBattleAvailable = function()
  local levelCA = PlayerData:GetFactoryData(PlayerData.BattleInfo.battleStageId, "LevelFactory")
  local rt = true
  if levelCA ~= nil and levelCA.isBanAutoBattle then
    rt = false
  end
  return rt
end
local Reset = function()
  Data = DataModel.CurrentData
  Data.isLeaderCardOn = DataModel.DefaultValue.isLeaderCardOn
  Data.discardType = DataModel.DefaultValue.discardType
  Data.keepCardNum = DataModel.DefaultValue.keepCardNum
  Data.weightRed = DataModel.DefaultValue.weightRed
  Data.weightBlue = DataModel.DefaultValue.weightBlue
  Data.weightYellow = DataModel.DefaultValue.weightYellow
  Data.weightGreen = DataModel.DefaultValue.weightGreen
  Data.weightPurple = DataModel.DefaultValue.weightPurple
end
local SetConfigSetView = function()
  View.Group_Header.Group_Header_Right.Btn_Pre1.Group_On:SetActive(false)
  View.Group_Header.Group_Header_Right.Btn_Pre1.Group_Off:SetActive(false)
  View.Group_Header.Group_Header_Right.Btn_Pre2.Group_On:SetActive(false)
  View.Group_Header.Group_Header_Right.Btn_Pre2.Group_Off:SetActive(false)
  View.Group_Header.Group_Header_Right.Btn_Pre3.Group_On:SetActive(false)
  View.Group_Header.Group_Header_Right.Btn_Pre3.Group_Off:SetActive(false)
  if DataModel.DataIndex == 1 then
    View.Group_Header.Group_Header_Right.Btn_Pre1.Group_On:SetActive(true)
    View.Group_Header.Group_Header_Right.Btn_Pre2.Group_Off:SetActive(true)
    View.Group_Header.Group_Header_Right.Btn_Pre3.Group_Off:SetActive(true)
  elseif DataModel.DataIndex == 2 then
    View.Group_Header.Group_Header_Right.Btn_Pre2.Group_On:SetActive(true)
    View.Group_Header.Group_Header_Right.Btn_Pre1.Group_Off:SetActive(true)
    View.Group_Header.Group_Header_Right.Btn_Pre3.Group_Off:SetActive(true)
  else
    View.Group_Header.Group_Header_Right.Btn_Pre3.Group_On:SetActive(true)
    View.Group_Header.Group_Header_Right.Btn_Pre1.Group_Off:SetActive(true)
    View.Group_Header.Group_Header_Right.Btn_Pre2.Group_Off:SetActive(true)
  end
end
local ChangeSet = function(index)
  if index < 1 then
    index = 1
  end
  if 3 < index then
    index = 3
  end
  DataModel.DataIndex = index
  DataModel.CurrentData = DataModel.Data[index]
  index = PlayerData:SetPlayerPrefs("int", "CardAIIndex", index, true)
end
local LoadData = function()
  index = PlayerData:GetPlayerPrefs("int", "CardAIIndex", true) or 1
  ChangeSet(index)
  if PlayerData:GetPlayerPrefs("int", "CardAIOn", true) == 0 then
    DataModel.IsAutoBattleOn = false
  else
    DataModel.IsAutoBattleOn = true
  end
  str = PlayerData:GetPlayerPrefs("string", "CardAIData", true)
  if str == nil or 1 > string.getLength(str) then
    Data = {}
    Data.isLeaderCardOn = DataModel.DefaultValue.isLeaderCardOn
    Data.discardType = DataModel.DefaultValue.discardType
    Data.keepCardNum = DataModel.DefaultValue.keepCardNum
    Data.weightRed = DataModel.DefaultValue.weightRed
    Data.weightBlue = DataModel.DefaultValue.weightBlue
    Data.weightYellow = DataModel.DefaultValue.weightYellow
    Data.weightGreen = DataModel.DefaultValue.weightGreen
    Data.weightPurple = DataModel.DefaultValue.weightPurple
    DataModel.Data[1] = Data
    Data = {}
    Data.isLeaderCardOn = DataModel.DefaultValue.isLeaderCardOn
    Data.discardType = DataModel.DefaultValue.discardType
    Data.keepCardNum = DataModel.DefaultValue.keepCardNum
    Data.weightRed = DataModel.DefaultValue.weightRed
    Data.weightBlue = DataModel.DefaultValue.weightBlue
    Data.weightYellow = DataModel.DefaultValue.weightYellow
    Data.weightGreen = DataModel.DefaultValue.weightGreen
    Data.weightPurple = DataModel.DefaultValue.weightPurple
    DataModel.Data[2] = Data
    Data = {}
    Data.isLeaderCardOn = DataModel.DefaultValue.isLeaderCardOn
    Data.discardType = DataModel.DefaultValue.discardType
    Data.keepCardNum = DataModel.DefaultValue.keepCardNum
    Data.weightRed = DataModel.DefaultValue.weightRed
    Data.weightBlue = DataModel.DefaultValue.weightBlue
    Data.weightYellow = DataModel.DefaultValue.weightYellow
    Data.weightGreen = DataModel.DefaultValue.weightGreen
    Data.weightPurple = DataModel.DefaultValue.weightPurple
    DataModel.Data[3] = Data
  else
    DataModel.Data = Json.decode(str)
  end
  ChangeSet(DataModel.DataIndex)
end
local SaveData = function()
  if DataModel.IsChanged == true then
    str = Json.encode(DataModel.Data)
    PlayerData:SetPlayerPrefs("string", "CardAIData", str, true)
  end
end
local ApplyAICoreSet = function()
  local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
  local core = BattleControlManager.playerCardAICore
  core:ClearCommonActionEx()
  core:ClearCommonCardAvailableConditionEx()
  core:ClearCommonCardAdjustWeightEx()
  if DataModel.CurrentData.isLeaderCardOn then
    core:AddCommonCardAdjustWeightEx(96200002, 10)
  else
    core:AddCommonCardAdjustWeightEx(96200002, -999)
  end
  if DataModel.CurrentData.discardType == 1 then
  elseif DataModel.CurrentData.discardType == 2 then
    core:AddCommonActionEx(96300006, 10, 96200003)
  else
    core:AddCommonActionEx(96300006, 10, 96200016)
  end
  core:AddCommonCardAvailableConditionEx(96200010, true, DataModel.CurrentData.keepCardNum)
  core:AddCommonCardAdjustWeightEx(96200004, DataModel.CurrentData.weightRed)
  core:AddCommonCardAdjustWeightEx(96200005, DataModel.CurrentData.weightBlue)
  core:AddCommonCardAdjustWeightEx(96200007, DataModel.CurrentData.weightYellow)
  core:AddCommonCardAdjustWeightEx(96200006, DataModel.CurrentData.weightGreen)
  core:AddCommonCardAdjustWeightEx(96200008, DataModel.CurrentData.weightPurple)
end
local SetDiscardBtnView = function()
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_1.Img_Off:SetActive(false)
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_1.Img_On:SetActive(false)
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_2.Img_Off:SetActive(false)
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_2.Img_On:SetActive(false)
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_3.Img_Off:SetActive(false)
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_3.Img_On:SetActive(false)
  if DataModel.CurrentData.discardType == 1 then
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_1.Img_On:SetActive(true)
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_2.Img_Off:SetActive(true)
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_3.Img_Off:SetActive(true)
  elseif DataModel.CurrentData.discardType == 2 then
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_2.Img_On:SetActive(true)
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_1.Img_Off:SetActive(true)
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_3.Img_Off:SetActive(true)
  else
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_3.Img_On:SetActive(true)
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_1.Img_Off:SetActive(true)
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_2.Group_Btn.Btn_Discard_2.Img_Off:SetActive(true)
  end
end
local SetLeaderCardBtnView = function()
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_1.Btn_Switch.Bg01_On:SetActive(false)
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_1.Btn_Switch.Bg02_Off:SetActive(false)
  if DataModel.CurrentData.isLeaderCardOn then
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_1.Btn_Switch.Bg01_On:SetActive(true)
  else
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_1.Btn_Switch.Bg02_Off:SetActive(true)
  end
end
local ShowKeepCardNum = function()
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_3.Group_KeepBorder.Group_NumBox.Group_Num.Txt_Num:SetText(tostring(DataModel.CurrentData.keepCardNum))
  if DataModel.CurrentData.keepCardNum == DataModel.sKeepCardNumMax then
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_3.Group_KeepBorder.Group_NumBox.Btn_Add.Img_On:SetActive(false)
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_3.Group_KeepBorder.Group_NumBox.Btn_Add.Img_Off:SetActive(true)
  else
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_3.Group_KeepBorder.Group_NumBox.Btn_Add.Img_On:SetActive(true)
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_3.Group_KeepBorder.Group_NumBox.Btn_Add.Img_Off:SetActive(false)
  end
  if DataModel.CurrentData.keepCardNum == 0 then
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_3.Group_KeepBorder.Group_NumBox.Btn_Sub.Img_On:SetActive(false)
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_3.Group_KeepBorder.Group_NumBox.Btn_Sub.Img_Off:SetActive(true)
  else
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_3.Group_KeepBorder.Group_NumBox.Btn_Sub.Img_On:SetActive(true)
    View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_3.Group_KeepBorder.Group_NumBox.Btn_Sub.Img_Off:SetActive(false)
  end
end
local SetKeepCardNum = function(num)
  if num < 0 then
    DataModel.CurrentData.keepCardNum = 0
  elseif num > DataModel.sKeepCardNumMax then
    DataModel.CurrentData.keepCardNum = DataModel.sKeepCardNumMax
  else
    DataModel.CurrentData.keepCardNum = num
  end
  ShowKeepCardNum()
end
local ShowColorWeightImportLevel = function(group, level)
  group.Txt_5:SetActive(false)
  group.Txt_4:SetActive(false)
  group.Txt_3:SetActive(false)
  group.Txt_2:SetActive(false)
  group.Txt_1:SetActive(false)
  if level == 1 then
    group.Txt_1:SetActive(true)
  elseif level == 2 then
    group.Txt_2:SetActive(true)
  elseif level == 3 then
    group.Txt_3:SetActive(true)
  elseif level == 4 then
    group.Txt_4:SetActive(true)
  else
    group.Txt_5:SetActive(true)
  end
end
local ShowColorWeightView = function()
  weight = DataModel.CurrentData.weightRed
  if weight < 1 then
    weight = 1
  end
  if weight > 5 then
    weight = 5
  end
  posX = DataModel.weightPosX["w" .. tostring(weight)]
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_4.Group_Import_Color_Box.Group_Import_Color_Row_1.Group_Import_Slider.Img_Import_Active:SetAnchoredPositionX(posX)
  ShowColorWeightImportLevel(View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_4.Group_Import_Color_Box.Group_Import_Color_Row_1.Group_Import_Level, weight)
  weight = DataModel.CurrentData.weightBlue
  if weight < 1 then
    weight = 1
  end
  if weight > 5 then
    weight = 5
  end
  posX = DataModel.weightPosX["w" .. tostring(weight)]
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_4.Group_Import_Color_Box.Group_Import_Color_Row_2.Group_Import_Slider.Img_Import_Active:SetAnchoredPositionX(posX)
  ShowColorWeightImportLevel(View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_4.Group_Import_Color_Box.Group_Import_Color_Row_2.Group_Import_Level, weight)
  weight = DataModel.CurrentData.weightYellow
  if weight < 1 then
    weight = 1
  end
  if weight > 5 then
    weight = 5
  end
  posX = DataModel.weightPosX["w" .. tostring(weight)]
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_4.Group_Import_Color_Box.Group_Import_Color_Row_3.Group_Import_Slider.Img_Import_Active:SetAnchoredPositionX(posX)
  ShowColorWeightImportLevel(View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_4.Group_Import_Color_Box.Group_Import_Color_Row_3.Group_Import_Level, weight)
  weight = DataModel.CurrentData.weightGreen
  if weight < 1 then
    weight = 1
  end
  if weight > 5 then
    weight = 5
  end
  posX = DataModel.weightPosX["w" .. tostring(weight)]
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_4.Group_Import_Color_Box.Group_Import_Color_Row_4.Group_Import_Slider.Img_Import_Active:SetAnchoredPositionX(posX)
  ShowColorWeightImportLevel(View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_4.Group_Import_Color_Box.Group_Import_Color_Row_4.Group_Import_Level, weight)
  weight = DataModel.CurrentData.weightPurple
  if weight < 1 then
    weight = 1
  end
  if weight > 5 then
    weight = 5
  end
  posX = DataModel.weightPosX["w" .. tostring(weight)]
  View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_4.Group_Import_Color_Box.Group_Import_Color_Row_5.Group_Import_Slider.Img_Import_Active:SetAnchoredPositionX(posX)
  ShowColorWeightImportLevel(View.ScrollView_Group_Main.Viewport.Content.Group_Main.Group_Row_4.Group_Import_Color_Box.Group_Import_Color_Row_5.Group_Import_Level, weight)
end
local RefreshAll = function()
  SetConfigSetView()
  SetDiscardBtnView()
  ShowKeepCardNum()
  SetLeaderCardBtnView()
  ShowColorWeightView()
end
local ViewFunction = {
  IsAutoBattleAvailable = function()
    return IsAutoBattleAvailable()
  end,
  IsAutoBattle = function()
    return DataModel.IsAutoBattleOn
  end,
  LoadData = function()
    LoadData()
  end,
  SaveData = function()
    SaveData()
  end,
  ApplyAICoreSet = function()
    ApplyAICoreSet()
  end,
  SetConfigSetView = function()
    SetConfigSetView()
  end,
  AutoBattle_Group_Header_Group_Header_Right_Btn_Pre1_Click = function(btn, str)
    ChangeSet(1)
    RefreshAll()
  end,
  AutoBattle_Group_Header_Group_Header_Right_Btn_Pre2_Click = function(btn, str)
    ChangeSet(2)
    RefreshAll()
  end,
  AutoBattle_Group_Header_Group_Header_Right_Btn_Pre3_Click = function(btn, str)
    ChangeSet(3)
    RefreshAll()
  end,
  SetLeaderCardBtnView = function()
    SetLeaderCardBtnView()
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_1_Btn_Switch_Click = function(btn, str)
    if DataModel.CurrentData.isLeaderCardOn == true then
      DataModel.CurrentData.isLeaderCardOn = false
    else
      DataModel.CurrentData.isLeaderCardOn = true
    end
    SetLeaderCardBtnView()
    DataModel.IsChanged = true
  end,
  SetDiscardBtnView = function()
    SetDiscardBtnView()
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_2_Group_Btn_Btn_Discard_1_Click = function(btn, str)
    DataModel.CurrentData.discardType = 1
    SetDiscardBtnView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_2_Group_Btn_Btn_Discard_2_Click = function(btn, str)
    DataModel.CurrentData.discardType = 2
    SetDiscardBtnView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_2_Group_Btn_Btn_Discard_3_Click = function(btn, str)
    DataModel.CurrentData.discardType = 3
    SetDiscardBtnView()
    DataModel.IsChanged = true
  end,
  ShowKeepCardNum = function()
    ShowKeepCardNum()
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_3_Group_KeepBorder_Group_NumBox_Btn_Sub_Click = function(btn, str)
    SetKeepCardNum(DataModel.CurrentData.keepCardNum - 1)
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_3_Group_KeepBorder_Group_NumBox_Btn_Add_Click = function(btn, str)
    SetKeepCardNum(DataModel.CurrentData.keepCardNum + 1)
    DataModel.IsChanged = true
  end,
  ShowColorWeightView = function()
    ShowColorWeightView()
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_1_Group_Import_Slider_Btn_Import_Slider_1_Click = function(btn, str)
    DataModel.CurrentData.weightRed = 1
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_1_Group_Import_Slider_Btn_Import_Slider_2_Click = function(btn, str)
    DataModel.CurrentData.weightRed = 2
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_1_Group_Import_Slider_Btn_Import_Slider_3_Click = function(btn, str)
    DataModel.CurrentData.weightRed = 3
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_1_Group_Import_Slider_Btn_Import_Slider_4_Click = function(btn, str)
    DataModel.CurrentData.weightRed = 4
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_1_Group_Import_Slider_Btn_Import_Slider_5_Click = function(btn, str)
    DataModel.CurrentData.weightRed = 5
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_2_Group_Import_Slider_Btn_Import_Slider_1_Click = function(btn, str)
    DataModel.CurrentData.weightBlue = 1
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_2_Group_Import_Slider_Btn_Import_Slider_2_Click = function(btn, str)
    DataModel.CurrentData.weightBlue = 2
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_2_Group_Import_Slider_Btn_Import_Slider_3_Click = function(btn, str)
    DataModel.CurrentData.weightBlue = 3
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_2_Group_Import_Slider_Btn_Import_Slider_4_Click = function(btn, str)
    DataModel.CurrentData.weightBlue = 4
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_2_Group_Import_Slider_Btn_Import_Slider_5_Click = function(btn, str)
    DataModel.CurrentData.weightBlue = 5
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_3_Group_Import_Slider_Btn_Import_Slider_1_Click = function(btn, str)
    DataModel.CurrentData.weightYellow = 1
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_3_Group_Import_Slider_Btn_Import_Slider_2_Click = function(btn, str)
    DataModel.CurrentData.weightYellow = 2
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_3_Group_Import_Slider_Btn_Import_Slider_3_Click = function(btn, str)
    DataModel.CurrentData.weightYellow = 3
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_3_Group_Import_Slider_Btn_Import_Slider_4_Click = function(btn, str)
    DataModel.CurrentData.weightYellow = 4
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_3_Group_Import_Slider_Btn_Import_Slider_5_Click = function(btn, str)
    DataModel.CurrentData.weightYellow = 5
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_4_Group_Import_Slider_Btn_Import_Slider_1_Click = function(btn, str)
    DataModel.CurrentData.weightGreen = 1
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_4_Group_Import_Slider_Btn_Import_Slider_2_Click = function(btn, str)
    DataModel.CurrentData.weightGreen = 2
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_4_Group_Import_Slider_Btn_Import_Slider_3_Click = function(btn, str)
    DataModel.CurrentData.weightGreen = 3
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_4_Group_Import_Slider_Btn_Import_Slider_4_Click = function(btn, str)
    DataModel.CurrentData.weightGreen = 4
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_4_Group_Import_Slider_Btn_Import_Slider_5_Click = function(btn, str)
    DataModel.CurrentData.weightGreen = 5
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_5_Group_Import_Slider_Btn_Import_Slider_1_Click = function(btn, str)
    DataModel.CurrentData.weightPurple = 1
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_5_Group_Import_Slider_Btn_Import_Slider_2_Click = function(btn, str)
    DataModel.CurrentData.weightPurple = 2
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_5_Group_Import_Slider_Btn_Import_Slider_3_Click = function(btn, str)
    DataModel.CurrentData.weightPurple = 3
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_5_Group_Import_Slider_Btn_Import_Slider_4_Click = function(btn, str)
    DataModel.CurrentData.weightPurple = 4
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_4_Group_Import_Color_Box_Group_Import_Color_Row_5_Group_Import_Slider_Btn_Import_Slider_5_Click = function(btn, str)
    DataModel.CurrentData.weightPurple = 5
    ShowColorWeightView()
    DataModel.IsChanged = true
  end,
  RefreshAll = function()
    RefreshAll()
  end,
  AutoBattle_ScrollView_Group_Main_Viewport_Content_Group_Main_Group_Row_5_Group_ResetBorder_Btn_Reset_Click = function(btn, str)
    Reset()
    RefreshAll()
    DataModel.IsChanged = true
  end,
  AutoBattle_Btn_BG_Click = function(btn, str)
    UIManager:ClosePanel()
    SaveData()
    ApplyAICoreSet()
    local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
    BattleControlManager:Pause(false)
  end
}
return ViewFunction
