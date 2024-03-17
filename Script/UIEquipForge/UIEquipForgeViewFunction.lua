local View = require("UIEquipForge/UIEquipForgeView")
local DataModel = require("UIEquipForge/UIEquipForgeDataModel")
local CommonItem = require("Common/BtnItem")
local RefreshRight = function(data)
  if data == nil then
    View.Group_Right.self:SetActive(false)
    return
  end
  View.Group_Right.self:SetActive(true)
  CommonItem:SetItem(View.Group_Right.Group_Target.Group_Item, data)
  View.Group_Right.Group_Target.Group_Item.Img_Item:SetSprite(data.iconPath)
  View.Group_Right.Group_Material.StaticGrid_Material.grid.self:SetDataCount(#data.materialList)
  View.Group_Right.Group_Material.StaticGrid_Material.grid.self:RefreshAllElement()
end
local ViewFunction = {
  EquipForge_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  EquipForge_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  EquipForge_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  EquipForge_Group_Screen_Btn_Screen_Click = function(btn, str)
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
  EquipForge_Group_Screen_Group_ScreenList_StaticGrid_ScreenList_SetGrid = function(btn, str)
    local forgeType = DataModel.ForgeType
    btn.Btn_Item.self:SetClickParam(tostring(str))
    btn.Img_Item.Txt_Item:SetText(forgeType[str].name)
  end,
  EquipForge_Group_Screen_Group_ScreenList_StaticGrid_ScreenList_Group_Item_Btn_Item_Click = function(btn, str)
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
    View.Group_ForgeList.ScrollGrid_Forge.grid.self:SetDataCount(#forgeType[index].detail)
    View.Group_ForgeList.ScrollGrid_Forge.grid.self:RefreshAllElement()
  end,
  EquipForge_Group_ForgeList_ScrollGrid_Forge_SetGrid = function(btn, str)
    local index = tonumber(str)
    btn.Btn_Item:SetClickParam(tostring(str))
    local forgeType = DataModel.ForgeType
    local data = forgeType[DataModel.ScreenIndex].detail[index]
    CommonItem:SetItem(btn.Group_Item, data)
    btn.Group_Item.Img_Item:SetSprite(data.iconPath)
    btn.Txt_Name:SetText(data.name)
    if tonumber(str) == DataModel.NewForgeIndex then
      btn.Img_Bg:SetColor(UIConfig.Color.Red)
      RefreshRight(data)
    else
      btn.Img_Bg:SetColor(UIConfig.Color.White)
    end
  end,
  EquipForge_Group_Screen_Group_ScreenList_Btn_Mask_Click = function(btn, str)
    if View.Group_Screen.Group_ScreenList.self.IsActive then
      View.Group_Screen.Group_ScreenList.self:SetActive(false)
      View.Group_Screen.Btn_Screen.Group_On.self:SetActive(true)
      View.Group_Screen.Btn_Screen.Group_Off.self:SetActive(false)
    end
  end,
  EquipForge_Group_ForgeList_ScrollGrid_Forge_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  EquipForge_Group_ForgeList_ScrollGrid_Forge_Group_Item_Btn_Item_Click = function(btn, str)
    local index = tonumber(str)
    DataModel.OldForgeIndex = DataModel.NewForgeIndex
    DataModel.NewForgeIndex = index
    local old = View.Group_ForgeList.ScrollGrid_Forge.grid[DataModel.OldForgeIndex]
    old.Img_Bg:SetColor(UIConfig.Color.White)
    local new = View.Group_ForgeList.ScrollGrid_Forge.grid[DataModel.NewForgeIndex]
    new.Img_Bg:SetColor(UIConfig.Color.Red)
    local forgeType = DataModel.ForgeType
    local data = forgeType[DataModel.ScreenIndex].detail[index]
    RefreshRight(data)
  end,
  EquipForge_Group_Right_Group_Target_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  EquipForge_Group_Right_Group_Material_StaticGrid_Material_SetGrid = function(element, elementIndex)
    local forgeType = DataModel.ForgeType
    local data = forgeType[DataModel.ScreenIndex].detail[DataModel.NewForgeIndex]
    local material = data.materialList[tonumber(elementIndex)]
    local itemData = PlayerData:GetFactoryData(material.id, "SourceMaterialFactory")
    local needNum = material.num
    local haveItem = PlayerData:GetMaterialById(material.id)
    local haveNum = haveItem.num
    local group = element.Group_Item02
    group.Txt_Need:SetText(needNum)
    group.Txt_Have:SetText(haveNum)
    if needNum <= haveNum then
      group.Txt_Need:SetColor(UIConfig.Color.White)
    else
      group.Txt_Need:SetColor(UIConfig.Color.Red)
    end
    group.Group_Item.Img_Item:SetSprite(itemData.iconPath)
    group.Group_Item.Img_Bottom:SetSprite(UIConfig.FrameConfig[itemData.qualityInt])
  end,
  EquipForge_Group_Right_Group_Material_StaticGrid_Material_Group_Item_Group_Item02_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  EquipForge_Group_Right_Btn_Forge_Click = function(btn, str)
    local forgeType = DataModel.ForgeType
    local data = forgeType[DataModel.ScreenIndex].detail[DataModel.NewForgeIndex]
    local materialList = data.materialList
    local isEnough = true
    local items = {}
    for i = 1, #materialList do
      local item = materialList[i]
      local needNum = item.num
      local haveNum = PlayerData:GetMaterialById(item.id).num
      if needNum > haveNum and isEnough then
        isEnough = false
      end
      items[item.id] = needNum
    end
    if not isEnough then
      print("材料不足")
      return
    end
    Net:SendProto("equip.forging", function(json)
      PlayerData:RefreshMaterials(items)
      RefreshRight(data)
    end, tostring(data.id))
  end
}
return ViewFunction
