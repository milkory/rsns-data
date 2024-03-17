local View = require("UIBuildWindow/UIBuildWindowView")
local DataModel = require("UIBuildWindow/UIBuildWindowDataModel")
local Controller = require("UIBuildWindow/UIBuildWindowController")
local ViewFunction = {
  BuildWindow_Btn_Black_Click = function(btn, str)
    Controller:Exit()
  end,
  BuildWindow_Group_UseMaterial_StaticGrid_Material_SetGrid = function(element, elementIndex)
    Controller:RefreshMaterialElement(element, elementIndex)
  end,
  BuildWindow_Group_UseMaterial_StaticGrid_Material_Group_Consume_Group_Item_Btn_Item_Click = function(btn, str)
    local id = tonumber(str)
    CommonTips.OpenPreRewardDetailTips(id)
  end,
  BuildWindow_Group_UseMaterial_Group_Consume_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  BuildWindow_Group_Three_Btn_Startbuild_Click = function(btn, str)
    Controller:ConfirmBuild()
  end,
  BuildWindow_Group_Three_Btn_StartbuildNO_Click = function(btn, str)
  end,
  BuildWindow_Group_Three_Btn_Jumptime_Click = function(btn, str)
    Controller:ConfirmSkipBuilding()
  end,
  BuildWindow_ScrollGrid_Type_SetGrid = function(element, elementIndex)
    Controller:RefreshMainTypeElement(element, elementIndex)
  end,
  BuildWindow_ScrollGrid_Type_Group_Item_Btn_Carriage_Click = function(btn, str)
    Controller:SelectMainType(tonumber(str))
  end,
  BuildWindow_Group_Three_Btn_Built_Click = function(btn, str)
    Controller:ConfirmGetCoach()
  end,
  BuildWindow_Group_VerticalLayout_Group_BtnList_StaticGrid_Type_SetGrid = function(element, elementIndex)
    Controller:RefreshChildTypeElement(element, elementIndex)
  end,
  BuildWindow_Group_VerticalLayout_Group_BtnList_StaticGrid_Type_Group_Btn_Btn_Type_Click = function(btn, str)
    Controller:SelectChildType(tonumber(str), false)
  end,
  BuildWindow_Group_VerticalLayout_Group_BtnList_Group_Btn_Btn_Type_Click = function(btn, str)
  end
}
return ViewFunction
