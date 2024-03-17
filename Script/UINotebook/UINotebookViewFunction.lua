local View = require("UINotebook/UINotebookView")
local DataModel = require("UINotebook/UINotebookDataModel")
local ViewFunction = {
  Notebook_Group_Page_Btn_Trading_Click = function(btn, str)
    DataModel.ClickMenuRefresh(tonumber(str))
  end,
  Notebook_Group_Page_Btn_Bargain_Click = function(btn, str)
    DataModel.ClickMenuRefresh(tonumber(str))
  end,
  Notebook_Group_Page_Btn_Quotes_Click = function(btn, str)
    DataModel.ClickMenuRefresh(tonumber(str))
  end,
  Notebook_Group_Page_Btn_Tips_Click = function(btn, str)
    DataModel.ClickMenuRefresh(tonumber(str))
  end,
  Notebook_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Notebook_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  Notebook_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Notebook_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Notebook_Drag_area_BeginDrag = function(direction, dragPos)
    DataModel.dragMouseStartPos = dragPos
  end,
  Notebook_Drag_area_EndDrag = function(direction, dragPos)
    if DataModel.dragMouseStartPos then
      local deltaX = dragPos.x - DataModel.dragMouseStartPos.x
      local menuType = DataModel.curMenu
      if 0 < deltaX then
        if 1 < menuType then
          DataModel.ClickMenuRefresh(menuType - 1)
        end
      elseif deltaX < 0 and menuType < DataModel.menuNum then
        DataModel.ClickMenuRefresh(menuType + 1)
      end
    end
    DataModel.dragMouseStartPos = nil
  end,
  Notebook_Drag_area_OnDrag = function(direction, dragPos)
  end,
  Notebook_Group_Progress_StaticGrid__SetGrid = function(element, elementIndex)
    element.Img_Completed:SetActive(elementIndex <= DataModel.completedCount)
    element.Img_Incompleted:SetActive(elementIndex > DataModel.completedCount)
  end,
  Notebook_Group_Progress_Btn__Click = function(btn, str)
  end
}
return ViewFunction
