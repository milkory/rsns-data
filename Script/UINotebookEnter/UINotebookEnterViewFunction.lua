local View = require("UINotebookEnter/UINotebookEnterView")
local DataModel = require("UINotebookEnter/UINotebookEnterDataModel")
local ViewFunction = {
  NotebookEnter_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  NotebookEnter_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  NotebookEnter_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  NotebookEnter_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  NotebookEnter_ScrollGrid__SetGrid = function(element, elementIndex)
    local tab = DataModel.dataTab[elementIndex]
    local cfg = PlayerData:GetFactoryData(tab.id, "ListFactory")
    element.Img_Cover:SetSprite(cfg.icon)
    element.Btn_:SetClickParam(elementIndex)
    local noteBookDataMode = require("UINotebook/UINotebookDataModel")
    local count, completedCount = noteBookDataMode.GetCountInfo(tab)
    element.Img_BGProgress.Txt_Num:SetText(string.format("%d/%d", completedCount, count))
    element.Img_BGProgress.Img_Bar.Img_Yellow:SetFilledImgAmount(completedCount / count)
    element.Img_RemindOut:SetActive(noteBookDataMode.GetNewNum(tab) > 0)
  end,
  NotebookEnter_ScrollGrid__Group_Item_Btn__Click = function(btn, str)
    CommonTips.OpenNoteBook(tonumber(str))
  end
}
return ViewFunction
