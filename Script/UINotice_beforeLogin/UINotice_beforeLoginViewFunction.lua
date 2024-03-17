local View = require("UINotice_beforeLogin/UINotice_beforeLoginView")
local DataModel = require("UINotice_beforeLogin/UINotice_beforeLoginDataModel")
local ViewFunction = {
  Notice_beforeLogin_Btn_Close_Click = function(btn, str)
    View.self:CloseUI()
  end,
  Notice_beforeLogin_ScrollGrid__SetGrid = function(element, elementIndex)
    local row = DataModel.RightList[tonumber(elementIndex)]
    local Btn_Tab = element.Btn_Tab
    Btn_Tab.Txt_Title:SetText(row.title)
    Btn_Tab.Txt_Title:SetTxtFontSize(row.size)
    Btn_Tab.Txt_Title:SetColor(row.color)
    Btn_Tab.Img_Time.Txt_Time:SetText(row.time)
    Btn_Tab.Img_On:SetActive(false)
    Btn_Tab.Img_Tab:SetSprite(row.img)
    Btn_Tab:SetClickParam(elementIndex)
  end,
  Notice_beforeLogin_ScrollGrid__Group_Item_Btn_Tab_Click = function(btn, str)
    DataModel.ClickRightTab(tonumber(str))
  end,
  Notice_beforeLogin_Group_main_Group_details_Btn_Goto_Click = function(btn, str)
  end
}
return ViewFunction
