local View = require("UIEquipResolve/UIEquipResolveView")
local DataModel = require("UIEquipResolve/UIEquipResolveDataModel")
local ViewFunction = require("UIEquipResolve/UIEquipResolveViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.Group_Screen.Group_ScreenList.StaticGrid_ScreenList.grid.self:SetDataCount(#DataModel:GetForgeType(true))
    ViewFunction.EquipResolve_Group_Screen_Group_ScreenList_StaticGrid_ScreenList_Group_Item_Btn_Item_Click(nil, DataModel.ScreenIndex)
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
