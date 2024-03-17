local Controller = require("UIHome_MachiningLathe/HomeMakeFurController")
local DataModel = require("UIHome_MachiningLathe/HomeMakeFurModel")
local View = require("UIHome_MachiningAnita/UIHome_MachiningAnitaView")
local ViewFunction = {
  Home_MachiningAnita_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    Controller.Goback()
  end,
  Home_MachiningAnita_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Home_MachiningAnita_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Home_MachiningAnita_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Home_MachiningAnita_Group_TopRight_Group_Loadage_Btn_Add_Click = function(btn, str)
  end,
  Home_MachiningAnita_Group_TopRight_Group_Loadage_Btn_Icon_Click = function(btn, str)
  end,
  Home_MachiningAnita_Group_TopRight_Group_HomeEnergy_Btn_Add_Click = function(btn, str)
    Controller.OpenMoveEnergyPanel()
  end,
  Home_MachiningAnita_Group_TopRight_Group_HomeEnergy_Btn_Icon_Click = function(btn, str)
  end,
  Home_MachiningAnita_Group_TopRight_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  Home_MachiningAnita_Group_TopRight_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  Home_MachiningAnita_Group_CoreLevel_Img_Contain_Btn_Levelup_Click = function(btn, str)
    UIManager:Open("UI/EngineCore/EngineCore")
  end,
  Home_MachiningAnita_Img_Right_Group_Make_Img_Count_Group_Plus_Btn_Plus_Click = function(btn, str)
    Controller.RefreshMakePanel(DataModel.selectNum + 1)
  end,
  Home_MachiningAnita_Img_Right_Group_Make_Img_Count_Group_Plus_Btn_Max_Click = function(btn, str)
    Controller.RefreshMakePanel(DataModel.maxCompoundNum)
  end,
  Home_MachiningAnita_Img_Right_Group_Make_Img_Count_Group_Minus_Btn_Minus_Click = function(btn, str)
    Controller.RefreshMakePanel(DataModel.selectNum - 1)
  end,
  Home_MachiningAnita_Img_Right_Group_Make_Img_Count_Group_Minus_Btn_Min_Click = function(btn, str)
    Controller.RefreshMakePanel(1)
  end,
  Home_MachiningAnita_Img_Right_Group_Make_Img_Count_Group_Plus_Btn_Plus_LongPress = function(btn, str)
    Controller.LongPress(true, btn)
  end,
  Home_MachiningAnita_Img_Right_Group_Make_Img_Count_Group_Minus_Btn_Minus_LongPress = function(btn, str)
    Controller.LongPress(false, btn)
  end,
  Home_MachiningAnita_Img_Right_Group_Make_Btn_Start_Click = function(btn, str)
    Controller.StartMake()
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_Img_Top_ScrollGrid_Toplist_SetGrid = function(element, elementIndex)
    Controller.UpdateFormulaGroupInfo(element, elementIndex)
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_Img_Top_ScrollGrid_Toplist_Group_Item_Btn_Choose_Click = function(btn, str)
    Controller.SelectFormulaGroup(tonumber(str))
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_ScrollGrid_LevelList_SetGrid = function(element, elementIndex)
    Controller.UpdateFormulaInfo(element, elementIndex)
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_ScrollGrid_LevelList_Group_Item_Group_Able_Btn_Start_Click = function(btn, str)
    local pormulaId = tonumber(str)
    Controller.OpenMakePanel(pormulaId)
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_ScrollGrid_LevelList_Group_Item_Btn_Get_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenRewardDetail(itemId)
  end,
  Home_MachiningAnita_Group_CoreLevel_Img_Contain_StaticGrid_Corelist_SetGrid = function(element, elementIndex)
    Controller.UpdateCoreInfo(element, elementIndex, 1)
  end,
  Home_MachiningAnita_Img_Right_Group_Make_Img_Extra_Group_Enging_StaticGrid_Corelist_SetGrid = function(element, elementIndex)
    Controller.UpdateCoreInfo(element, elementIndex, 3)
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_ScrollGrid_LevelList_Group_Item_StaticGrid_Material_SetGrid = function(element, elementIndex)
    Controller.UpdateFormulaMaterialInfo(element, elementIndex, 1)
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_ScrollGrid_LevelList_Group_Item_StaticGrid_Material_Group_Item1_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenRewardDetail(itemId)
  end,
  Home_MachiningAnita_Img_Right_Group_Make_Group_Material_StaticGrid_Material_SetGrid = function(element, elementIndex)
    Controller.UpdateFormulaMaterialInfo(element, elementIndex, 2)
  end,
  Home_MachiningAnita_Img_Right_Group_Make_Group_Material_StaticGrid_Material_Group_Item2_Group_ON_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenRewardDetail(itemId)
  end,
  Home_MachiningAnita_Img_Right_Group_Make_Group_Product_Img_Contain_Btn_Staff_Click = function(btn, str)
    local pormulaCfg = PlayerData:GetFactoryData(DataModel.nowPormulaId)
    DataModel.nowCoreList = pormulaCfg.unlockenergyCondition
    local getInfo = pormulaCfg.draw[1]
    CommonTips.OpenRewardDetail(getInfo.id)
  end,
  Home_MachiningAnita_Group_TopRight_Btn_Energy_Click = function(btn, str)
    UIManager:Open("UI/Energy/Energy")
  end,
  Home_MachiningAnita_Group_TopRight_Btn_Energy_Btn_Add_Click = function(btn, str)
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_Img_Top_ScrollGrid_Toplist_Group_Item_Group_Lock_Btn_Getway_Click = function(btn, str)
    local scalex = UIManager:GetCanvas().transform.localScale.x
    local posx = btn.transform.position.x / scalex
    Controller.OpenGetWayPanel(tonumber(str), posx)
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_ScrollGrid_LevelList_Group_Item_Img_Core_Btn_UpCore_Click = function(btn, str)
    UIManager:Open("UI/EngineCore/EngineCore")
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_ScrollGrid_LevelList_Group_Item_Group_unAble_Btn_AddCM_Click = function(btn, str)
    UIManager:Open("UI/Energy/Energy")
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_ScrollGrid_LevelList_Group_Item_Group_unAble_Btn_AddPL_Click = function(btn, str)
    Controller.OpenMoveEnergyPanel()
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_ScrollGrid_LevelList_Group_Item_Img_Core_StaticGrid_Core_SetGrid = function(element, elementIndex)
    Controller.UpdateCoreInfo(element, elementIndex, 2)
  end,
  Home_MachiningAnita_Img_Right_Group_Choose_ScrollGrid_LevelList_Group_Item_Img_Lock_Btn_Upgrade_Click = function(btn, str)
    local t = {}
    t.furUfid = DataModel.ufid
    t.furId = PlayerData:GetHomeInfo().furniture[DataModel.ufid].id
    UIManager:Open("UI/HomeUpgrade/HomeUpgrade", Json.encode(t), function()
      DataModel.furLevel = DataModel.furLevel + 1
      View.Img_Right.Group_Choose.ScrollGrid_LevelList.grid.self:RefreshAllElement()
    end)
  end
}
return ViewFunction
