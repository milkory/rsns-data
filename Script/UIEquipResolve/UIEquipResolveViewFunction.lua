local View = require("UIEquipResolve/UIEquipResolveView")
local DataModel = require("UIEquipResolve/UIEquipResolveDataModel")
local CommonItem = require("Common/BtnItem")
local RefreshRight = function(equip)
  if equip == nil then
    View.Group_Right.self:SetActive(false)
    return
  end
  DataModel.Equip = equip
  View.Group_Right.self:SetActive(true)
  CommonItem:SetEquipment(View.Group_Right.Group_Target.Group_Equipment, equip.data, false)
  local resolve = PlayerData:GetFactoryData(equip.data.ResolveId, "ResolveFactory")
  View.Group_Right.Group_Material.StaticGrid_Material.grid.self:SetDataCount(#resolve.materialList)
  View.Group_Right.Group_Material.StaticGrid_Material.grid.self:RefreshAllElement()
end
local ViewFunction = {
  EquipResolve_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  EquipResolve_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  EquipResolve_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  EquipResolve_Group_Screen_Btn_Screen_Click = function(btn, str)
    if View.Group_Screen.Group_ScreenList.self.IsActive then
      View.Group_Screen.Group_ScreenList.self:SetActive(false)
      View.Group_Screen.Btn_Screen.Group_On.self:SetActive(true)
      View.Group_Screen.Btn_Screen.Group_Off.self:SetActive(false)
    else
      View.Group_Screen.Group_ScreenList.self:SetActive(true)
      View.Group_Screen.Btn_Screen.Group_On.self:SetActive(false)
      View.Group_Screen.Btn_Screen.Group_Off.self:SetActive(true)
    end
    View.Group_Screen.Group_ScreenList.StaticGrid_ScreenList.grid.self:SetDataCount(#DataModel.ForgeType)
    View.Group_Screen.Group_ScreenList.StaticGrid_ScreenList.grid.self:RefreshAllElement()
  end,
  EquipResolve_Group_Screen_Group_ScreenList_StaticGrid_ScreenList_Group_Item_Btn_Item_Click = function(btn, str)
    local index = tonumber(str)
    local forgeType = DataModel.ForgeType
    local Btn_Screen = View.Group_Screen.Btn_Screen
    View.Group_Screen.Group_ScreenList.self:SetActive(false)
    Btn_Screen.Group_On.self:SetActive(true)
    Btn_Screen.Group_Off.self:SetActive(false)
    DataModel.ScreenIndex = index
    local screenData = forgeType[DataModel.ScreenIndex]
    DataModel.OldForgeIndex = 1
    DataModel.NewForgeIndex = 1
    View.Group_Right.self:SetActive(#screenData.detail ~= 0)
    Btn_Screen.Group_On.Img_Screen.Txt_Screen:SetText(screenData.name)
    Btn_Screen.Group_Off.Img_Screen.Txt_Screen:SetText(screenData.name)
    View.Group_Equipment.ScrollGrid_Equipment.grid.self:SetDataCount(#forgeType[index].detail)
    View.Group_Equipment.ScrollGrid_Equipment.grid.self:RefreshAllElement()
  end,
  EquipResolve_Group_Screen_Group_ScreenList_StaticGrid_ScreenList_SetGrid = function(element, elementIndex)
    local forgeType = DataModel:GetForgeType()
    element.Btn_Item:SetClickParam(tostring(elementIndex))
    element.Img_Item.Txt_Item:SetText(forgeType[elementIndex].name)
  end,
  EquipResolve_Group_Screen_Btn_Mask_Click = function(btn, str)
    if View.Group_Screen.Group_ScreenList.self.IsActive then
      View.Group_Screen.Group_ScreenList.self:SetActive(false)
      View.Group_Screen.Btn_Screen.Group_On.self:SetActive(true)
      View.Group_Screen.Btn_Screen.Group_Off.self:SetActive(false)
    end
  end,
  EquipResolve_Group_Right_Group_Target_Group_Equipment_Btn_Item_Click = function(btn, str)
  end,
  EquipResolve_Group_Right_Btn_Resolve_Click = function(btn, str)
    Net:SendProto("equip.resolve", function(json)
      PlayerData:DeleteEquipById(DataModel.Equip.eid)
      local resolve = PlayerData:GetFactoryData(DataModel.Equip.data.ResolveId, "ResolveFactory")
      local materialList = resolve.materialList
      local items = {}
      for i, v in ipairs(materialList) do
        items[v.materialId] = v.numMax
      end
      PlayerData:RefreshMaterials(items, "add")
      View.Group_Screen.Group_ScreenList.StaticGrid_ScreenList.grid.self:SetDataCount(#DataModel:GetForgeType(true))
      local index = DataModel.ScreenIndex
      local forgeType = DataModel.ForgeType
      local Btn_Screen = View.Group_Screen.Btn_Screen
      View.Group_Screen.Group_ScreenList.self:SetActive(false)
      Btn_Screen.Group_On.self:SetActive(true)
      Btn_Screen.Group_Off.self:SetActive(false)
      DataModel.ScreenIndex = index
      local screenData = forgeType[DataModel.ScreenIndex]
      DataModel.OldForgeIndex = 1
      DataModel.NewForgeIndex = 1
      View.Group_Right.self:SetActive(#screenData.detail ~= 0)
      Btn_Screen.Group_On.Img_Screen.Txt_Screen:SetText(screenData.name)
      Btn_Screen.Group_Off.Img_Screen.Txt_Screen:SetText(screenData.name)
      View.Group_Equipment.ScrollGrid_Equipment.grid.self:SetDataCount(#forgeType[index].detail)
      View.Group_Equipment.ScrollGrid_Equipment.grid.self:RefreshAllElement()
    end, DataModel.Equip.eid)
  end,
  EquipResolve_Group_Right_Group_Material_StaticGrid_Material_SetGrid = function(element, elementIndex)
    local forgeType = DataModel.ForgeType
    local equip = forgeType[DataModel.ScreenIndex].detail[DataModel.NewForgeIndex]
    local resolve = PlayerData:GetFactoryData(equip.data.ResolveId, "ResolveFactory")
    local material = resolve.materialList[tonumber(elementIndex)]
    local itemData = PlayerData:GetFactoryData(material.materialId, "SourceMaterialFactory")
    element.Txt_Have:SetText(material.numMax)
    element.Group_Item.Img_Item:SetSprite(itemData.iconPath)
    element.Group_Item.Img_Bottom:SetSprite(UIConfig.FrameConfig[itemData.qualityInt])
  end,
  EquipResolve_Group_Equipment_ScrollGrid_Equipment_SetGrid = function(element, elementIndex)
    local index = tonumber(elementIndex)
    element.Btn_Item:SetClickParam(tostring(elementIndex))
    local forgeType = DataModel.ForgeType
    local equip = forgeType[DataModel.ScreenIndex].detail[index]
    CommonItem:SetEquipment(element.Group_Equipment, equip.data, false)
    element.Txt_Name:SetText(equip.data.name)
    if index == DataModel.NewForgeIndex then
      element.Img_Bg:SetColor(UIConfig.Color.Red)
      RefreshRight(equip)
    else
      element.Img_Bg:SetColor(UIConfig.Color.White)
    end
  end,
  EquipResolve_Group_Equipment_ScrollGrid_Equipment_Group_Item_Group_Equipment_Btn_Item_Click = function(btn, str)
  end,
  EquipResolve_Group_Equipment_ScrollGrid_Equipment_Group_Item_Btn_Item_Click = function(btn, str)
    local index = tonumber(str)
    DataModel.OldForgeIndex = DataModel.NewForgeIndex
    DataModel.NewForgeIndex = index
    local old = View.Group_Equipment.ScrollGrid_Equipment.grid[DataModel.OldForgeIndex]
    old.Img_Bg:SetColor(UIConfig.Color.White)
    local new = View.Group_Equipment.ScrollGrid_Equipment.grid[DataModel.NewForgeIndex]
    new.Img_Bg:SetColor(UIConfig.Color.Red)
    local forgeType = DataModel.ForgeType
    local data = forgeType[DataModel.ScreenIndex].detail[index]
    RefreshRight(data)
  end
}
return ViewFunction
