local View = require("UIEquipForge/UIEquipForgeView")
local ViewFunction = require("UIEquipForge/UIEquipForgeViewFunction")
local DataModel = require("UIEquipForge/UIEquipForgeDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.Group_Screen.Group_ScreenList.StaticGrid_ScreenList.grid.self:SetDataCount(#DataModel:GetForgeType(true))
    ViewFunction.EquipForge_Group_Screen_Group_ScreenList_StaticGrid_ScreenList_Group_Item_Btn_Item_Click(nil, DataModel.ScreenIndex)
    ViewFunction.EquipForge_Group_ForgeList_ScrollGrid_Forge_Group_Item_Btn_Item_Click(nil, DataModel.NewForgeIndex)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
