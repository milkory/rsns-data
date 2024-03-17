local View = require("UIEquipSelected/UIEquipSelectedView")
local DataModel = require("UIEquipSelected/UIEquipSelectedDataModel")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  EquipSelected_ScrollGrid_Equipment_SetGrid = function(element, elementIndex)
    local equip = DataModel:GetEquipmentType(false)[elementIndex]
    element.Btn_Item:SetClickParam(tostring(elementIndex))
    CommonItem:SetEquipment(element, equip.data, equip.owner ~= nil, equip.type)
  end,
  EquipSelected_ScrollGrid_Equipment_Group_Equipment_Btn_Item_Click = function(btn, str)
  end,
  EquipSelected_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("EquipSelectedOut")
    UIManager:GoBack(true, DataModel.Effect)
  end,
  EquipSelected_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("EquipSelectedOut")
    UIManager:GoHome()
  end,
  EquipSelected_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  EquipSelected_Group_TopLeft_Btn_TabEquipment_Click = function(btn, str)
  end,
  EquipSelected_Group_TopRight_Btn_Decompose_Click = function(btn, str)
  end,
  EquipSelected_Group_TopRight_Btn_Rarity_Click = function(btn, str)
  end,
  EquipSelected_Group_TopRight_Btn_Screen_Click = function(btn, str)
  end,
  EquipSelected_Group_TopRight_Btn_Time_Click = function(btn, str)
  end
}
return ViewFunction
