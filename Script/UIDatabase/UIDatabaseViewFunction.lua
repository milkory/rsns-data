local View = require("UIDatabase/UIDatabaseView")
local DataModel = require("UIDatabase/UIDatabaseDataModel")
local OpenDatabaseInfo = function(database_type)
  View.Group_Inside:SetActive(true)
  DataModel.GetDatabaseInfolist(0, database_type)
  View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:SetDataCount(#DataModel.databae_info_list)
  View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:RefreshAllElement()
  View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:MoveToTop()
  View.Group_Inside.Group_Right.Group_Top.Group_Num.Txt_GotNum:SetText(DataModel.unlockcnt)
  View.Group_Inside.Group_Right.Group_Top.Group_Num.Txt_TotalNum:SetText(DataModel.allcnt)
  View.Group_Inside.Group_Right.Group_Top.Group_Bar.Img_Top:SetFilledImgAmount(DataModel.unlockcnt / DataModel.allcnt)
  View.Group_Inside.Group_Right.Group_Bot.Group_Owned.Txt_Num:SetText(DataModel.unlockcnt)
  View.Group_Inside.Group_Right.Group_Bot.Group_UnOwned.Txt_Num:SetText(DataModel.allcnt - DataModel.unlockcnt)
  View.Group_Inside.Group_Left:SetActive(false)
  View.Group_Inside.Group_Right.Group_Bot.Group_Owned.Btn_Off.Img_On:SetActive(false)
  View.Group_Inside.Group_Right.Group_Bot.Group_UnOwned.Btn_Off.Img_On:SetActive(false)
  local name = DataModel.database_list[database_type].name
  local cfg_id = DataModel.database_list[database_type].id
  local icon = PlayerData:GetFactoryData(cfg_id).icon
  View.Group_Inside.Group_Right.Group_Top.Img_TitleIcon:SetSprite(icon)
  View.Group_Inside.Group_Right.Group_Top.Txt_Title:SetText(name)
  local value = 0
  if 0 < DataModel.allcnt then
    value = DataModel.FormatNum(DataModel.unlockcnt / DataModel.allcnt * 100)
  end
  View.Group_Inside.Group_Right.Group_Top.Txt_Percentage:SetText(value .. "%")
  View.Group_Inside.Group_Left.Img_LeftBg.Img_Categories.Txt_Content:SetText(name)
  View.self:PlayAnim("in_list")
  View.ScrollGrid_Outside.grid.self:SetActive(false)
end
local ViewFunction = {
  Database_Group_Inside_Group_Right_Group_Mid_ScrollGrid_FirstTabs_SetGrid = function(element, elementIndex)
    local data = DataModel.databae_info_list[elementIndex]
    if data.level == 2 then
      element.Group_FirstTabs.Btn_FirstTab.Txt_Title:SetText(data.name)
      element.Group_FirstTabs:SetActive(true)
      element.Group_SecondTabs:SetActive(false)
      element.Group_FirstTabs.Btn_FirstTab:SetClickParam(elementIndex)
      element.Group_FirstTabs.Btn_FirstTab.Img_Folding:SetActive(not data.expand)
      element.Group_FirstTabs.Btn_FirstTab.Img_Unfold:SetActive(data.expand)
      element.Group_FirstTabs.Btn_FirstTab.Img_FirstSelection:SetActive(DataModel.select1_indx == data.id)
      element.Group_FirstTabs.Btn_FirstTab.Img_New:SetActive(data.new_cnt > 0)
    elseif data.level == 3 then
      element.Group_SecondTabs.Btn_SecondTab.Txt_Title:SetText(data.name)
      element.Group_FirstTabs:SetActive(false)
      element.Group_SecondTabs:SetActive(true)
      element.Group_SecondTabs.Btn_SecondTab:SetClickParam(elementIndex)
      if DataModel.unlock_list[tostring(data.id)] then
        element.Group_SecondTabs.Btn_SecondTab.Img_Locked:SetActive(false)
        element.Group_SecondTabs.Btn_SecondTab.Img_SecondSelection.Txt_TitleBlack:SetText(data.name)
        element.Group_SecondTabs.Btn_SecondTab.Img_SecondSelection:SetActive(DataModel.select2_indx == data.id)
        element.Group_SecondTabs.Btn_SecondTab.Img_New:SetActive(PlayerData:GetPlayerPrefs("int", data.id) == 0)
      else
        element.Group_SecondTabs.Btn_SecondTab.Img_Locked:SetActive(true)
        element.Group_SecondTabs.Btn_SecondTab.Img_Locked.Img_Frame:SetActive(DataModel.select2_indx == data.id)
        element.Group_SecondTabs.Btn_SecondTab.Img_SecondSelection:SetActive(false)
        element.Group_SecondTabs.Btn_SecondTab.Img_New:SetActive(false)
      end
    end
  end,
  Database_Group_Inside_Group_Right_Group_Mid_ScrollGrid_FirstTabs_Group_Item_Group_FirstTabs_Btn_FirstTab_Click = function(btn, str)
    local indx = tonumber(str)
    local data = DataModel.databae_info_list[indx]
    if data.level == 2 then
      local operate_type = data.expand and -1 or 1
      DataModel.select1_indx = nil
      if operate_type == 1 then
        DataModel.select1_indx = data.id
      end
      DataModel.RefreshDatabaseInfoList(indx, operate_type)
      View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:SetDataCount(#DataModel.databae_info_list)
      View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:RefreshAllElement()
      if DataModel.select2_indx == nil then
        View.Group_Inside.Group_Left.Group_Owned:SetActive(false)
        View.Group_Inside.Group_Left.Group_UnOwned:SetActive(true)
      end
    end
  end,
  Database_Group_Inside_Group_Right_Group_Mid_ScrollGrid_FirstTabs_Group_Item_Group_SecondTabs_Btn_SecondTab_Click = function(btn, str)
    local indx = tonumber(str)
    local data = DataModel.databae_info_list[indx]
    if data.level == 3 then
      View.Group_Inside.Group_Left:SetActive(true)
      DataModel.select2_indx = data.id
      DataModel.select1_indx = data.front
      if DataModel.unlock_list[tostring(data.id)] then
        View.Group_Inside.Group_Left.Group_Owned:SetActive(true)
        View.Group_Inside.Group_Left.Group_UnOwned:SetActive(false)
        local info = PlayerData:GetFactoryData(data.id)
        View.Group_Inside.Group_Left.Group_Owned.Txt_Title:SetText(info.name)
        View.Group_Inside.Group_Left.Group_Owned.ScrollView_Content.Viewport.Content.Txt_Data:SetText(info.desc)
        View.Group_Inside.Group_Left.Group_Owned.ScrollView_Content:SetVerticalNormalizedPosition(1)
        DataModel.UpdateFirstNewCnt(indx, data.front)
      else
        View.Group_Inside.Group_Left.Group_Owned:SetActive(false)
        View.Group_Inside.Group_Left.Group_UnOwned:SetActive(true)
      end
      View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:RefreshAllElement()
    end
  end,
  Database_Group_Inside_Group_Right_Group_Mid_Group_SiftList_Img_SiftMaterial_Btn_Refresh_Click = function(btn, str)
  end,
  Database_Group_Inside_Group_Right_Group_Mid_Group_SiftList_ScrollGrid_SiftList_SetGrid = function(element, elementIndex)
  end,
  Database_Group_Inside_Group_Right_Group_Mid_Group_SiftList_ScrollGrid_SiftList_Group_Item_Btn_On_Click = function(btn, str)
  end,
  Database_Group_Inside_Group_Right_Group_Mid_Group_SiftList_Btn_Confirm_Click = function(btn, str)
  end,
  Database_Group_Inside_Group_Right_Group_Mid_Group_SiftList_Btn_Cancel_Click = function(btn, str)
  end,
  Database_Group_Inside_Group_Right_Group_Bot_Group_Owned_Btn_Off_Click = function(btn, str)
    local select_type
    if DataModel.select_type ~= 1 then
      select_type = 1
      View.Group_Inside.Group_Right.Group_Bot.Group_Owned.Btn_Off.Img_On:SetActive(true)
      View.Group_Inside.Group_Right.Group_Bot.Group_UnOwned.Btn_Off.Img_On:SetActive(false)
    else
      select_type = 0
      View.Group_Inside.Group_Right.Group_Bot.Group_Owned.Btn_Off.Img_On:SetActive(false)
    end
    View.Group_Inside.Group_Right.Group_Bot.Group_Owned.Txt_Num:SetText(DataModel.unlockcnt)
    DataModel.GetDatabaseInfolist(select_type, DataModel.data_type)
    View.Group_Inside.Group_Left.Group_Owned:SetActive(false)
    View.Group_Inside.Group_Left.Group_UnOwned:SetActive(true)
    View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:SetDataCount(#DataModel.databae_info_list)
    View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:RefreshAllElement()
    View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:MoveToTop()
  end,
  Database_Group_Inside_Group_Right_Group_Bot_Group_UnOwned_Btn_Off_Click = function(btn, str)
    local select_type
    if DataModel.select_type ~= 2 then
      select_type = 2
      View.Group_Inside.Group_Right.Group_Bot.Group_Owned.Btn_Off.Img_On:SetActive(false)
      View.Group_Inside.Group_Right.Group_Bot.Group_UnOwned.Btn_Off.Img_On:SetActive(true)
    else
      select_type = 0
      View.Group_Inside.Group_Right.Group_Bot.Group_UnOwned.Btn_Off.Img_On:SetActive(false)
    end
    DataModel.GetDatabaseInfolist(select_type, DataModel.data_type)
    View.Group_Inside.Group_Left.Group_Owned:SetActive(false)
    View.Group_Inside.Group_Left.Group_UnOwned:SetActive(true)
    View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:SetDataCount(#DataModel.databae_info_list)
    View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:RefreshAllElement()
    View.Group_Inside.Group_Right.Group_Mid.ScrollGrid_FirstTabs.grid.self:MoveToTop()
  end,
  Database_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.ScrollGrid_Outside.grid.self.IsActive then
      UIManager:GoBack()
    else
      View.Group_Inside:SetActive(false)
      View.ScrollGrid_Outside.grid.self:SetActive(true)
      View.ScrollGrid_Outside.grid.self:SetDataCount(table.count(DataModel.database_list))
      View.ScrollGrid_Outside.grid.self:RefreshAllElement()
      View.self:PlayAnim("in")
    end
  end,
  Database_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Database_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Database_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Database_ScrollGrid_Outside_SetGrid = function(element, elementIndex)
    local row = DataModel.database_list[tonumber(elementIndex)]
    local Btn_Guide = element.Btn_Guide
    Btn_Guide:SetSprite(row.coverPage)
    Btn_Guide.Group_Top.Img_TitleIcon:SetSprite(row.icon)
    Btn_Guide.Group_Top.Txt_Title:SetText(row.name)
    element.Btn_Guide:SetClickParam(elementIndex)
    local unlockcnt = row.unlockcnt
    local allcnt = row.allcnt
    Btn_Guide.Group_Top.Group_Num.Txt_GotNum:SetText(unlockcnt)
    Btn_Guide.Group_Top.Group_Num.Txt_TotalNum:SetText(allcnt)
    Btn_Guide.Group_Top.Group_Bar.Img_Top:SetFilledImgAmount(unlockcnt / allcnt)
    local value = 0
    if 0 < allcnt then
      value = DataModel.FormatNum(unlockcnt / allcnt * 100)
    end
    Btn_Guide.Group_Top.Txt_Percentage:SetText(value .. "%")
    local new_cnt = row.new_cnt
    Btn_Guide.Img_New:SetActive(0 < new_cnt)
  end,
  Database_ScrollGrid_Outside_Group_Item_Btn_Guide_Click = function(btn, str)
    local index = tonumber(str)
    local row = DataModel.database_list[index]
    if row.name == "运营笔记" then
      local cfg = PlayerData:GetFactoryData(row.id, "ListFactory")
      UIManager:Open("UI/Notebook/NotebookEnter", Json.encode({
        dataTab = cfg.dataTab
      }))
      return
    end
    if row.interfaceUrl ~= "" then
      UIManager:Open(row.interfaceUrl)
      return
    end
    OpenDatabaseInfo(index)
  end
}
return ViewFunction
