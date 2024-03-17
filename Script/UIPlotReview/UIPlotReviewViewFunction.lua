local View = require("UIPlotReview/UIPlotReviewView")
local DataModel = require("UIPlotReview/UIPlotReviewDataModel")
local Controller = require("UIPlotReview/UIPlotReviewController")
local ViewFunction = {
  PlotReview_Img_Bg1_Group_Video_Btn_Item_Click = function(btn, str)
    Controller.OpenChapter(true)
  end,
  PlotReview_Img_Bg1_Group_Video_Btn_Item_Video_Main_Skip_Click = function(btn, str)
  end,
  PlotReview_Img_Bg1_Group_Tab_ScrollGrid__SetGrid = function(element, elementIndex)
    Controller.SetChapterElement(element, elementIndex)
    element.Btn_:SetClickParam(elementIndex)
  end,
  PlotReview_Img_Bg1_Group_Tab_ScrollGrid__Group_Item_Btn__Click = function(btn, str)
    Controller.ChapterBtn(tonumber(str))
  end,
  PlotReview_Img_Bg1_Group_PlotList_Img_Frame_ScrollGrid__SetGrid = function(element, elementIndex)
    Controller.SetSectionElement(element, elementIndex)
    element.Btn_Play:SetClickParam(elementIndex)
    element.Btn_Detail:SetClickParam(elementIndex)
  end,
  PlotReview_Img_Bg1_Group_PlotList_Img_Frame_ScrollGrid__Group_Item_Btn_Play_Click = function(btn, str)
    Controller.SectionPlayBtn(tonumber(str))
  end,
  PlotReview_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if DataModel.Level == 1 then
      UIManager:GoBack()
      SoundManager:PauseBGM(false)
    elseif DataModel.Level == 2 then
      Controller.OpenChapter(false)
    end
  end,
  PlotReview_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
    SoundManager:PauseBGM(false)
  end,
  PlotReview_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  PlotReview_Img_Bg1_Group_PlotList_Img_Frame_ScrollGrid__Group_Item_Btn_Detail_Click = function(btn, str)
    Controller.SectionDetailBtn(tonumber(str))
  end,
  PlotReview_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end
}
return ViewFunction
