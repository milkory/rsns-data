local View = require("UIGroup_Help/UIGroup_HelpView")
local DataModel = require("UIGroup_Help/UIGroup_HelpDataModel")
local ViewFunction = {
  Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
    local data = DataModel.helpList[elementIndex]
    local title = GetText(data.tadId)
    local content = GetText(data.txtId)
    element.Group_on.Txt_:SetText(title)
    element.Group_off.Txt_:SetText(title)
    element.Group_off:SetActive(DataModel.selectIndex ~= elementIndex)
    element.Group_on:SetActive(DataModel.selectIndex == elementIndex)
    if DataModel.selectIndex == elementIndex then
      View.Group_window.Group_txt.ScrollView_Dec.Viewport.Txt_:SetText(content)
      local height = View.Group_window.Group_txt.ScrollView_Dec.Viewport.Txt_:GetHeight()
      View.Group_window.Group_txt.ScrollView_Dec:SetContentHeight(height)
      View.Group_window.Group_txt.ScrollView_Dec:SetVerticalNormalizedPosition(1)
    end
    element.Btn_:SetClickParam(elementIndex)
  end,
  Group_Help_Btn__Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  Group_Help_Group_window_Group_tabList_ScrollGrid_list_Group_Tab_Btn__Click = function(btn, str)
    local nowIndex = tonumber(str)
    if DataModel.selectIndex ~= nowIndex then
      DataModel.selectIndex = nowIndex
      View.Group_window.Group_tabList.ScrollGrid_list.grid.self:RefreshAllElement()
    end
  end
}
return ViewFunction
