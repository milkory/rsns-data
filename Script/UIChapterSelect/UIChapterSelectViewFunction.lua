local View = require("UIChapterSelect/UIChapterSelectView")
local AssessmentViewFunction = require("UIChapterSelect/UIAssessment/UIAssessmentViewFunction")
local GridController = require("UIChapterSelect/Controller_Grid")
local DataModel = require("UIChapterSelect/UIChapterSelectDataModel")
local DataController = require("UIChapterSelect/UIChapterSelectDataController")
local imgBgWidth = 1400
local imgBgHeight = 788
local OpenResourceMap = function(index)
  local row = DataModel.Resources[index]
  if row.isOpenTime == false then
    CommonTips.OpenTips(80600140)
    return
  end
  if row.isOpen == false then
    CommonTips.OpenTips(80600050)
    return
  end
  if row.isFinshNum == 0 then
    CommonTips.OpenTips(80600143)
    return
  end
  local params = {
    chapterId = row.resource.id,
    resources = row,
    Current = "MainUI"
  }
  PlayerData.Last_Chapter_Parms = params
  PlayerData.ChooseChapterType = 2
  PlayerData.BattleCallBackPage = "UI/Chapter/Chapter"
  View.self:PlayAnim("R0" .. index .. "In")
  UIManager:Open("UI/Chapter/Chapter", Json.encode(params))
end
local ViewFunction = {
  ChapterSelect_Group_Topright_Btn_Subline_Click = function(btn, str)
  end,
  ChapterSelect_Group_Topright_Btn_Activity1_Click = function(btn, str)
  end,
  ChapterSelect_Group_Topright_Btn_Activity2_Click = function(btn, str)
  end,
  ChapterSelect_Group_Topright_Btn_Activity3_Click = function(btn, str)
  end,
  ChapterSelect_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("Out")
    if DataModel.IsJump == true then
      local list = Json.encode(DataModel.Jump)
      UIManager:Open(DataModel.Jump.URL, list)
    else
      UIManager:GoHome()
    end
    PlayerData.selectedRightIndex = nil
  end,
  ChapterSelect_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoHome()
    PlayerData.selectedRightIndex = nil
  end,
  ChapterSelect_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ChapterSelect_Group_ResourceLevel_Group_C01_Btn_C_Click = function(btn, str)
    OpenResourceMap(1)
  end,
  ChapterSelect_Group_ResourceLevel_Group_C02_Btn_C_Click = function(btn, str)
    OpenResourceMap(2)
  end,
  ChapterSelect_Group_ResourceLevel_Group_C03_Btn_C_Click = function(btn, str)
    OpenResourceMap(3)
  end,
  ChapterSelect_Group_ResourceLevel_Group_C04_Btn_C_Click = function(btn, str)
    OpenResourceMap(4)
  end,
  ChapterSelect_Group_ResourceLevel_Group_C05_Btn_C_Click = function(btn, str)
    OpenResourceMap(5)
  end,
  ChapterSelect_Group_ResourceLevel_Group_C06_Btn_C_Click = function(btn, str)
    OpenResourceMap(6)
  end,
  ChapterSelect_Group_Assessment_Group_Top_ScrollGrid_First_SetGrid = function(element, elementIndex)
    AssessmentViewFunction.Assessment_Group_Left_ScrollGrid_First_SetGrid(element, elementIndex)
  end,
  ChapterSelect_Group_Assessment_Group_Top_ScrollGrid_First_Group_Item_Btn_Inspection_Click = function(btn, str)
    AssessmentViewFunction.Assessment_Group_Left_ScrollGrid_First_Group_Item_Btn_Inspection_Click(btn, str)
  end,
  ChapterSelect_Group_Assessment_Group_Left_ScrollGrid_Second_SetGrid = function(element, elementIndex)
    AssessmentViewFunction.Assessment_Group_Middle_ScrollGrid_Second_SetGrid(element, elementIndex)
  end,
  ChapterSelect_Group_Assessment_Group_Left_ScrollGrid_Second_Group_Item_Btn_Inspection_Click = function(btn, str)
    AssessmentViewFunction.Assessment_Group_Middle_ScrollGrid_Second_Group_Item_Btn_Inspection_Click(btn, str)
  end,
  ChapterSelect_Group_Assessment_Group_Right_Group_Pre_ScrollGrid_Lunbo_SetGrid = function(element, elementIndex)
  end,
  ChapterSelect_Group_Assessment_Group_Right_Btn_Start_Click = function(btn, str)
    AssessmentViewFunction.Assessment_Group_Right_Btn_Start_Click(btn, str)
  end,
  ChapterSelect_Group_Assessment_Group_Right_Group_Bonus_Btn_Bonus_Click = function(btn, str)
    AssessmentViewFunction.Assessment_Group_Right_Group_Bonus_Btn_Bonus_Click(btn, str)
  end,
  ChapterSelect_Group_Bonus_Btn_BMask_Click = function(btn, str)
    AssessmentViewFunction.Assessment_Group_Bonus_Btn_BMask_Click(btn, str)
  end,
  ChapterSelect_Group_Bonus_Img_win_Group_Item_01_Group_Item_Btn_Item_Click = function(btn, str)
    AssessmentViewFunction.Assessment_Group_Right_Group_Bonus_Group_Drop_Group_Item_00_Btn_Item_Click(btn, str)
  end,
  ChapterSelect_Group_Bonus_Img_win_Group_Item_02_Group_Item_Btn_Item_Click = function(btn, str)
    AssessmentViewFunction.Assessment_Group_Right_Group_Bonus_Group_Drop_Group_Item_01_Btn_Item_Click(btn, str)
  end,
  ChapterSelect_Group_Bonus_Img_win_Group_Item_03_Group_Item_Btn_Item_Click = function(btn, str)
    AssessmentViewFunction.Assessment_Group_Right_Group_Bonus_Group_Drop_Group_Item_02_Btn_Item_Click(btn, str)
  end,
  ChapterSelect_Group_Topright_BtnPolygon_Assess_Click = function(btn, str)
    PlayerData.selectedRightIndex = 3
    DataModel.ChangeOpenChapter()
  end,
  ChapterSelect_Group_Topright_BtnPolygon_Resource_Click = function(btn, str)
    PlayerData.selectedRightIndex = 2
    DataModel.ChangeOpenChapter()
  end,
  ChapterSelect_Group_Topright_BtnPolygon_Mainline_Click = function(btn, str)
    PlayerData.selectedRightIndex = 1
    DataModel.ChangeOpenChapter()
  end,
  ChapterSelect_Group_middle_Page_Chapter_SetPage = function(element, elementIndex)
    local row = GridController.currentGridList[elementIndex]
    local Btn_Item = element.Btn_Item
    Btn_Item.self:SetClickParam(elementIndex)
    Btn_Item.Txt_ChapterNameCN:SetText("")
    Btn_Item.Txt_ChapterNameEN:SetText("")
    Btn_Item.Txt_Time:SetText(row.time)
    Btn_Item.Txt_PlaceCN:SetText(row.placeCN)
    Btn_Item.Txt_PlaceEN:SetText(row.placeEN)
    local isLock = elementIndex > DataController:GetUnlockChapter()
    element.Img_Mask:SetActive(isLock)
    Btn_Item.Img_Mask:SetActive(isLock)
    Btn_Item.Group_Unlock.self:SetActive(not isLock)
    GridController.RefreshChapterNum(Btn_Item, elementIndex, 1, #GridController.currentGridList)
    if elementIndex > #GridController.currentGridList then
      element.self:SetActive(false)
      return
    end
    local chapterData = PlayerData:GetFactoryData(GridController.currentGridList[elementIndex].chapterId, "ChapterFactory")
    local userInfo = PlayerData:GetUserInfo()
    Btn_Item.Video_Main:SetActive(false)
    element.Btn_Item.self:SetSprite(chapterData.mainPath)
    local now_progress = PlayerData:GetCustomsChapterLevelNum(GridController.currentGridList[elementIndex].chapterId)
    local max_progress = PlayerData:GetChpterCountMax(GridController.currentGridList[elementIndex].chapterId)
    element.Btn_Item.Txt_Percentage:SetText(math.floor(now_progress / max_progress * 100) .. "%")
    local x_a = -230
    local x_limt = 460
    local x = x_a + math.floor(now_progress / max_progress * x_limt)
    local y = element.Btn_Item.Group_Progress.Img_Target.transform.localPosition.y
    element.Btn_Item.Group_Progress.Img_Target.transform.localPosition = Vector3(x, y, 0)
  end,
  ChapterSelect_Group_middle_Page_Chapter_PageDrag = function(dragOffsetPos)
    View.Group_middle.Page_LeftChapter.grid.self:SetSyncProgress(GridController.currentGrid.grid.self:GetSyncProgress(), 40)
    View.Group_middle.Page_LeftChapterName.grid.self:SetSyncProgress(GridController.currentGrid.grid.self:GetSyncProgress(), 40)
    local index, offSetRation = math.modf(dragOffsetPos)
    if 0.5 < offSetRation then
      DataModel.selectedIndex = index + 2
    else
      DataModel.selectedIndex = index + 1
    end
    if 0 < offSetRation and DataModel.BeforeOffset and View.Group_middle.Page_Chapter.grid[index + 2] then
      if 0 > DataModel.BeforeOffset - dragOffsetPos then
        View.Group_middle.Page_Chapter.grid[index + 1].Btn_Item:SetColor(Color(1.0, 1.0, 1.0, 1 - offSetRation))
        View.Group_middle.Page_Chapter.grid[index + 2].Btn_Item:SetColor(Color(1.0, 1.0, 1.0, offSetRation))
      else
        View.Group_middle.Page_Chapter.grid[index + 2].Btn_Item:SetColor(Color(1.0, 1.0, 1.0, offSetRation))
        View.Group_middle.Page_Chapter.grid[index + 1].Btn_Item:SetColor(Color(1.0, 1.0, 1.0, 1 - offSetRation))
      end
    end
  end,
  ChapterSelect_Group_middle_Page_Chapter_PageDragComplete = function(index)
    DataModel.PageDragComplete(index)
    View.Group_middle.Page_LeftChapter.grid.self:SetSyncProgress(GridController.currentGrid.grid.self:GetSyncProgress(), 40)
    View.Group_middle.Page_LeftChapterName.grid.self:SetSyncProgress(GridController.currentGrid.grid.self:GetSyncProgress(), 40)
    View.Group_middle.Group_Label.Btn_Down:SetAlpha(1)
    View.Group_middle.Group_Label.Btn_Up:SetAlpha(1)
  end,
  ChapterSelect_Group_middle_Page_Chapter_PageDragBegin = function(dragOffsetPos)
    local grid = GridController.currentGrid.grid.self
    DataModel.IsDrag = true
    DataModel.OldGridIndex = grid.Index
    DataModel.BeforeOffset = dragOffsetPos
    View.Group_middle.Group_Label.Btn_Down:SetAlpha(0)
    View.Group_middle.Group_Label.Btn_Up:SetAlpha(0)
  end,
  ChapterSelect_Group_middle_Page_Chapter_Group_ChapterList_Btn_Item_Click = function(btn, str)
    local id = GridController.currentGridList[tonumber(str)].chapterId
    local params = {chapterId = id, Current = "MainUI"}
    if DataModel.IsJump == true then
      params.TableOutSideIndex = DataModel.Jump.TableOutSideIndex
      params.TableIndex = DataModel.Jump.TableIndex
      params.UI = DataModel.Jump.UI
      params.URL = DataModel.Jump.URL
    end
    PlayerData.Last_Chapter_Parms = params
    PlayerData.ChooseChapterType = 1
    PlayerData.BattleCallBackPage = "UI/Chapter/Chapter"
    View.self:PlayAnim("Out")
    UIManager:Open("UI/Chapter/Chapter", Json.encode(params))
  end,
  ChapterSelect_Group_middle_Page_Chapter_Group_ChapterList_Btn_Item_Video_Main_Skip_Click = function(btn, str)
  end,
  ChapterSelect_Group_middle_Page_LeftChapter_SetPage = function(element, elementIndex)
    local row = GridController.currentGridList[elementIndex]
    local txt = "0" .. elementIndex
    element.Group_Item.Txt_Chapter:SetText(txt)
  end,
  ChapterSelect_Group_middle_Page_LeftChapter_PageDrag = function(dragOffsetPos)
  end,
  ChapterSelect_Group_middle_Page_LeftChapter_PageDragComplete = function(index)
  end,
  ChapterSelect_Group_middle_Page_LeftChapter_PageDragBegin = function(dragOffsetPos)
  end,
  ChapterSelect_Group_middle_Group_Label_Btn_Up_Click = function(btn, str)
  end,
  ChapterSelect_Group_middle_Group_Label_Btn_Down_Click = function(btn, str)
  end,
  ChapterSelect_Group_middle_Page_LeftChapterName_SetPage = function(element, elementIndex)
    local row = GridController.currentGridList[elementIndex]
    element.Group_Txt.Txt_ChapterNameCN:SetText(row.nameCN)
    element.Group_Txt.Txt_ChapterNameEN:SetText(row.nameEN)
  end,
  ChapterSelect_Group_middle_Page_LeftChapterName_PageDrag = function(dragOffsetPos)
  end,
  ChapterSelect_Group_middle_Page_LeftChapterName_PageDragComplete = function(index)
  end,
  ChapterSelect_Group_middle_Page_LeftChapterName_PageDragBegin = function(dragOffsetPos)
  end,
  ChapterSelect_Group_middle_Page_LeftChapter_Group_Label_Btn_Up_Click = function(btn, str)
  end,
  ChapterSelect_Group_middle_Page_LeftChapter_Group_Label_Btn_Down_Click = function(btn, str)
  end
}
return ViewFunction
