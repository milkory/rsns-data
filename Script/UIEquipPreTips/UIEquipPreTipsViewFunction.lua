local View = require("UIEquipPreTips/UIEquipPreTipsView")
local DataModel = require("UIEquipPreTips/UIEquipPreTipsDataModel")
local ViewFunction = {
  EquipPreTips_Btn_Shade_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  EquipPreTips_Group_Show_Btn_Lock_Click = function(btn, str)
  end,
  EquipPreTips_Group_Show_Btn_Access_Click = function(btn, str)
  end,
  EquipPreTips_Group_Show_Btn_Details_Click = function(btn, str)
  end,
  EquipPreTips_Group_Show_Group_Details_Btn_Close_Click = function(btn, str)
  end
}
return ViewFunction
