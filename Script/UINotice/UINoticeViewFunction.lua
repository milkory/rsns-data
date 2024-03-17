local Controller = require("UINotice/UINoticeController")
local View = require("UINotice/UINoticeView")
local DataModel = require("UINotice/UINoticeDataModel")
local ViewFunction = {
  Notice_Btn_Close_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    View.self:Confirm()
  end,
  Notice_ScrollGrid_Choice_SetGrid = function(element, elementIndex)
    Controller.SetElement(element, elementIndex)
  end,
  Notice_ScrollGrid_Choice_Group_Btn_Btn_Check_Click = function(btn, str)
    local index = tonumber(str)
    DataModel.CurrentIndex = index
    View.ScrollGrid_Choice.grid.self:RefreshAllElement()
    Controller.RefreshGrid(index)
  end,
  Notice_Img_Content_Btn_URL_Click = function(btn, str)
    Controller.OpenURL()
  end,
  Notice_Btn_Mask_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    View.self:Confirm()
  end
}
return ViewFunction
