local View = require("UIGachaDetails/UIGachaDetailsView")
local DataModel = require("UIGachaDetails/UIGachaDetailsDataModel")
local Controller = require("UIGachaDetails/UIGachaDetailsController")
local ViewFunction = {
  GachaDetails_Btn_Close_Click = function(btn, str)
    View.self:CloseUI()
  end,
  GachaDetails_Btn_Details_Click = function(btn, str)
    Controller:Select(DataModel.SelectType.ViewDetail)
  end,
  GachaDetails_Btn_Record_Click = function(btn, str)
    Controller:Select(DataModel.SelectType.GachaRecord)
  end,
  GachaDetails_Group_Record_Group_Data_StaticGrid_List_SetGrid = function(element, elementIndex)
    Controller:ShowRecordElement(element, elementIndex)
  end,
  GachaDetails_Group_Record_Group_Data_Btn_Previous_Click = function(btn, str)
    Controller:ShowGachaRecord(DataModel.curSelectPage - 1)
  end,
  GachaDetails_Group_Record_Group_Data_Btn_Next_Click = function(btn, str)
    Controller:ShowGachaRecord(DataModel.curSelectPage + 1)
  end
}
return ViewFunction
