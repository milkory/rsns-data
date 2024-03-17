local View = require("UIPlantEdition/UIPlantEditionView")
local DataModel = require("UIPlantEdition/UIPlantEditionDataModel")
local Controller = require("UIPlantEdition/UIPlantEditionController")
local ViewFunction = {
  PlantEdition_Group_Top_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    local goback = function()
      UIManager:GoBack()
      local mainUIView = require("UIMainUI/UIMainUIView")
      mainUIView.self:SetRaycastBlock(false)
      HomeManager:CamFocusEnd(function()
        mainUIView.self:SetRaycastBlock(true)
      end)
    end
    goback()
  end,
  PlantEdition_Group_Top_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  PlantEdition_Group_Top_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  PlantEdition_Group_Top_Btn_Mood_Click = function(btn, str)
    if DataModel.IsTabing then
      return
    end
    DataModel.IsOpenTab = not DataModel.IsOpenTab
    DOTweenTools.DOLocalMoveXCallback(View.Group_Top.Btn_Mood.self.transform, DataModel.IsOpenTab and 855 or 1115, 0.3, function()
      DataModel.IsTabing = true
    end, function()
      DataModel.IsTabing = false
    end, 1)
  end,
  PlantEdition_Group_Edition_StaticGrid_AddAndDelete_SetGrid = function(element, elementIndex)
    element.Btn_Add:SetClickParam(elementIndex)
    element.Btn_Delete:SetClickParam(elementIndex)
    local index = tonumber(elementIndex)
    if DataModel.Seeds[index] and DataModel.Seeds[index] ~= "" then
      element.Btn_Add:SetActive(false)
      element.Btn_Delete:SetActive(true)
    elseif DataModel.Index ~= 0 then
      element.Btn_Add:SetActive(true)
      element.Btn_Delete:SetActive(false)
    else
      element.Btn_Add:SetActive(false)
      element.Btn_Delete:SetActive(false)
    end
  end,
  PlantEdition_Group_Edition_StaticGrid_AddAndDelete_Group_AddAndDelete_Btn_Add_Click = function(btn, str)
    if DataModel.Index == 0 then
      print_r("没有选择种子")
      return
    elseif DataModel.Plants[DataModel.Index].serverData.num == 0 then
      print_r("没有种子")
      return
    end
    local index = tonumber(str)
    DataModel.Seeds[index] = tostring(DataModel.Plants[DataModel.Index].config.id)
    View.Group_Edition.StaticGrid_AddAndDelete.grid.self:RefreshAllElement()
    Net:SendProto("creature.plant", function(json)
      PlayerData.ServerData.user_home_info.furniture[DataModel.UID] = json.furniture[DataModel.UID]
      DataModel.Plants[DataModel.Index].use = DataModel.Plants[DataModel.Index].use + 1
      local creatures = PlayerData.ServerData.user_home_info.creatures
      local furniture = HomeManager:GetFurnitureByUfid(DataModel.UID)
      creatures[DataModel.Seeds[index]].num = creatures[DataModel.Seeds[index]].num - 1
      furniture:AddCreature(tonumber(DataModel.Seeds[index]), index - 1)
      DataModel.FurnitureServerData = json.furniture[DataModel.UID]
      View.Group_Edition.Group_Bottom.ScrollGrid_PlantList.grid[DataModel.Index].Btn_Plant.Txt_Surplus:SetText(creatures[DataModel.Seeds[index]].num)
    end, DataModel.UID, DataModel.Seeds[index], index - 1)
  end,
  PlantEdition_Group_Edition_StaticGrid_AddAndDelete_Group_AddAndDelete_Btn_Delete_Click = function(btn, str)
    CommonTips.OnPrompt(80600365, 80600068, 80600067, function()
      local index = tonumber(str)
      DataModel.Seeds[index] = ""
      Net:SendProto("creature.remove_plant", function(json)
        PlayerData.ServerData.user_home_info.furniture[DataModel.UID].plants[index] = ""
        DataModel.FurnitureServerData = PlayerData.ServerData.user_home_info.furniture[DataModel.UID]
        HomeCreatureManager:RemoveFurCreatureByIndex(DataModel.UID, index - 1)
      end, DataModel.UID, index - 1, 0)
      View.Group_Edition.StaticGrid_AddAndDelete.grid.self:RefreshAllElement()
    end)
  end,
  PlantEdition_Group_Edition_Group_Bottom_ScrollGrid_PlantList_SetGrid = function(element, elementIndex)
    element.Btn_Plant:SetClickParam(elementIndex)
    element.Btn_Plant.Btn_Tips:SetClickParam(elementIndex)
    local data = DataModel.Plants[tonumber(elementIndex)]
    element.Btn_Plant.Img_Icon:SetSprite(data.config.iconPath)
    element.Btn_Plant.Txt_Mood:SetText(data.config.PlantMood)
    element.Btn_Plant.Txt_Name:SetText(data.config.name)
    element.Btn_Plant.Txt_Surplus:SetText(data.serverData.num)
    if DataModel.Index == tonumber(elementIndex) then
      element.Btn_Plant.Img_Select:SetActive(true)
    else
      element.Btn_Plant.Img_Select:SetActive(false)
    end
  end,
  PlantEdition_Group_Edition_Group_Bottom_ScrollGrid_PlantList_Group_Item_Btn_Plant_Click = function(btn, str)
    local index = tonumber(str)
    if DataModel.Index == index then
      DataModel.Index = 0
      View.Group_Edition.Group_Bottom.ScrollGrid_PlantList.grid[index].Btn_Plant.Img_Select:SetActive(false)
    else
      DataModel.Index = index
      View.Group_Edition.Group_Bottom.ScrollGrid_PlantList.grid[index].Btn_Plant.Img_Select:SetActive(true)
    end
    View.Group_Edition.StaticGrid_AddAndDelete.grid.self:RefreshAllElement()
    View.Group_Edition.Group_Bottom.ScrollGrid_PlantList.grid.self:RefreshAllElement()
  end,
  PlantEdition_Group_Edition_Group_Bottom_ScrollGrid_PlantList_Group_Item_Btn_Plant_Btn_Tips_Click = function(btn, str)
    local data = DataModel.Plants[tonumber(str)]
    local json = Json.encode({
      id = data.config.id,
      num = data.serverData.num
    })
    UIManager:Open("UI/Home_plant/PlantTips", json)
  end,
  PlantEdition_Group_Edition_Group_Bottom_Btn_PlantSort_Click = function(btn, str)
    View.Group_Edition.Group_Bottom.Btn_PlantSort.Group_PlantSort.self:SetActive(true)
    Controller:SortRuleView()
    View.Group_Edition.StaticGrid_AddAndDelete.grid.self:RefreshAllElement()
  end,
  PlantEdition_Group_Edition_Group_Bottom_Btn_PlantSort_Group_PlantSort_Btn_Close_Click = function(btn, str)
    View.Group_Edition.Group_Bottom.Btn_PlantSort.Group_PlantSort.self:SetActive(false)
  end,
  PlantEdition_Group_Edition_Group_Bottom_Btn_PlantSort_Group_PlantSort_Btn_Mood_Click = function(btn, str)
    if DataModel.CurrSort.Type == DataModel.SortType.Mood then
      DataModel.CurrSort.IsDown = not DataModel.CurrSort.IsDown
    elseif DataModel.CurrSort.Type == DataModel.SortType.Num then
      DataModel.CurrSort.IsDown = true
      DataModel.CurrSort.Type = DataModel.SortType.Mood
    end
    DataModel:SortRule()
    Controller:SortRuleView()
    View.Group_Edition.Group_Bottom.ScrollGrid_PlantList.grid.self:RefreshAllElement()
  end,
  PlantEdition_Group_Edition_Group_Bottom_Btn_PlantSort_Group_PlantSort_Btn_Num_Click = function(btn, str)
    if DataModel.CurrSort.Type == DataModel.SortType.Num then
      DataModel.CurrSort.IsDown = not DataModel.CurrSort.IsDown
    elseif DataModel.CurrSort.Type == DataModel.SortType.Mood then
      DataModel.CurrSort.IsDown = true
      DataModel.CurrSort.Type = DataModel.SortType.Num
    end
    DataModel:SortRule()
    Controller:SortRuleView()
    View.Group_Edition.Group_Bottom.ScrollGrid_PlantList.grid.self:RefreshAllElement()
  end,
  PlantEdition_Group_Edition_Group_Bottom_Btn_Empty_Click = function(btn, str)
    CommonTips.OnPrompt(80600365, 80600068, 80600067, function()
      Net:SendProto("creature.remove_plant", function(json)
        HomeCreatureManager:RemoveFurAllCreatures(DataModel.UID)
        for i = 1, 5 do
          PlayerData.ServerData.user_home_info.furniture[DataModel.UID].plants[i] = ""
          DataModel.Seeds[i] = ""
        end
        DataModel.FurnitureServerData = PlayerData.ServerData.user_home_info.furniture[DataModel.UID]
        View.Group_Edition.StaticGrid_AddAndDelete.grid.self:RefreshAllElement()
        View.Group_Edition.Group_Bottom.ScrollGrid_PlantList.grid.self:RefreshAllElement()
      end, DataModel.UID, 0, 1)
    end)
  end,
  PlantEdition_Group_Edition_Btn_Mask_Click = function(btn, str)
  end
}
return ViewFunction
