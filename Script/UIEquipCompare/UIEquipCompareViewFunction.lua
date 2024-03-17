local View = require("UIEquipCompare/UIEquipCompareView")
local DataModel = require("UIEquipCompare/UIEquipCompareDataModel")
local ViewFunction = {
  EquipCompare_Group_Btn_Btn_Change_Click = function(btn, str)
    Net:SendProto("hero.set_equips", function(json)
      UIManager:GoBack()
    end, tostring(DataModel.RoleId), tostring(DataModel.ReplaceEid), DataModel.Index - 1)
  end,
  EquipCompare_Group_Btn_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack()
  end
}
return ViewFunction
