local View = require("UIRankList/UIRankListView")
local DataModel = require("UIRankList/UIRankListDataModel")
local Controller = require("UIRankList/UIRankListController")
local ViewFunction = {
  RankList_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  RankList_Group_Tab_ScrollGrid_Tab_SetGrid = function(element, elementIndex)
    Controller:RefreshTabElement(element, elementIndex)
  end,
  RankList_Group_Tab_ScrollGrid_Tab_Group_Item_Btn__Click = function(btn, str)
    Controller:TabElementClick(btn, str)
  end,
  RankList_Group_Rank_Group_Top_Group_Select_Group_Week_Btn__Click = function(btn, str)
    Controller:SelectTab(DataModel.CurTabIndex, DataModel.TimeType.weekly, DataModel.CurRankLvIdx)
  end,
  RankList_Group_Rank_Group_Top_Group_Select_Group_Day_Btn__Click = function(btn, str)
    Controller:SelectTab(DataModel.CurTabIndex, DataModel.TimeType.daily, DataModel.CurRankLvIdx)
  end,
  RankList_Group_Rank_Group_Top_Group_Select_Group_LocalDay_Btn__Click = function(btn, str)
    Controller:SelectTab(DataModel.CurTabIndex, DataModel.TimeType.localDaily, DataModel.CurRankLvIdx)
  end,
  RankList_Group_Rank_Group_List_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:RefreshRankElement(element, elementIndex)
  end,
  RankList_Group_Rank_Group_List_ScrollGrid_List_Group_Item_Btn_ProfilePhoto_Click = function(btn, str)
    Controller:ProfilePhotoClick(btn, str)
  end,
  RankList_Group_Rank_Group_List_Group_Oneself_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  RankList_Group_Rank_Group_Top_Group_Section_Btn_Click_Click = function(btn, str)
    Controller:ShowRankLvToggleArea(true)
  end,
  RankList_Group_Rank_Group_Top_Btn_CloseToggleArea_Click = function(btn, str)
    Controller:ShowRankLvToggleArea(false)
  end,
  RankList_Group_Rank_Group_Top_Group_ToggleArea_Group_Toggle_Btn_Click_Click = function(btn, str)
  end,
  RankList_Group_Rank_Group_Top_Group_ToggleArea_StaticGrid_Toggle_SetGrid = function(element, elementIndex)
    Controller:RefreshLvToggleElement(element, elementIndex)
  end,
  RankList_Group_Rank_Group_Top_Group_ToggleArea_StaticGrid_Toggle_Group_Toggle_Btn_Click_Click = function(btn, str)
    Controller:ClickLvToggle(str)
  end,
  RankList_Group_TopTips_Btn_Tips_Click = function(btn, str)
    View.Group_Tips:SetActive(true)
  end,
  RankList_Group_Tips_Btn_Close_Click = function(btn, str)
    View.Group_Tips:SetActive(false)
  end
}
return ViewFunction
