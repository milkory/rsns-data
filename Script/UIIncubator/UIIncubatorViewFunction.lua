local View = require("UIIncubator/UIIncubatorView")
local Controller = require("UIIncubator/UIIncubatorController")
local DataModel = require("UIIncubator/UIIncubatorDataModel")
local ViewFunction = {
  Incubator_Group_PurificationInterface_Btn_Stop_Click = function(btn, str)
    CommonTips.OnPrompt("终止拉", "好的", "算了", function()
      Net:SendProto("creature.rec_rewards", function(json)
        PlayerData.ServerData.user_home_info.furniture[DataModel.UID] = json.furniture[DataModel.UID]
        HomeCreatureManager:RemoveFurAllCreatures(DataModel.UID)
        UIManager:GoBack()
      end, DataModel.UID, 1)
    end)
  end,
  Incubator_Group_PurificationEmpty_Btn_Start_Click = function(btn, str)
    if DataModel.SendStr == "" then
      return
    end
    Net:SendProto("creature.place", function(json)
      PlayerData.ServerData.user_home_info.furniture[DataModel.UID] = json.furniture[DataModel.UID]
      local ids = Split(DataModel.SendStr, ",")
      local creatures = PlayerData.ServerData.user_home_info.creatures
      local furniture = HomeManager:GetFurnitureByUfid(DataModel.UID)
      for i, v in ipairs(ids) do
        creatures[v].num = creatures[v].num - 1
        furniture:AddCreature(tonumber(v), i - 1)
      end
      DataModel.FurnitureServerData = json.furniture[DataModel.UID]
      View.Group_PurificationEmpty.self:SetActive(false)
      View.Group_SelectionInterface.self:SetActive(false)
    end, DataModel.UID, DataModel.SendStr)
  end,
  Incubator_Group_PurificationEmpty_Btn_Add_Click = function(btn, str)
    View.Group_SelectionInterface.self:SetActive(true)
    Controller:ChangeIndex(1)
  end,
  Incubator_Group_SelectionInterface_Btn_Time_Click = function(btn, str)
    Controller:ChangeIndex(1)
  end,
  Incubator_Group_SelectionInterface_Btn_Time_1_Click = function(btn, str)
    Controller:ChangeIndex(2)
  end,
  Incubator_Group_SelectionInterface_Btn_Time_2_Click = function(btn, str)
    Controller:ChangeIndex(3)
  end,
  Incubator_Group_SelectionInterface_Btn_Time_3_Click = function(btn, str)
    Controller:ChangeIndex(4)
  end,
  Incubator_Group_SelectionInterface_ScrollGrid_Choice_SetGrid = function(element, elementIndex)
    local data = DataModel.Type[DataModel.Index].data[elementIndex]
    element.Btn_Add:SetSprite(data.config.iconPath)
    element.Btn_Add:SetClickParam(tostring(elementIndex))
    element.Btn_Delete:SetClickParam(tostring(elementIndex))
    element.Txt_Num:SetText(data.serverData.num)
    element.Img_Select:SetActive(false)
    if data.use == 0 then
      element.Img_Select:SetActive(false)
    else
      element.Img_Select:SetActive(true)
    end
    if data.use > 0 and #DataModel.CurrFurnitureConfig.PurificationsiloList > 1 then
      element.Btn_Delete:SetActive(true)
      element.Txt_SelectNum:SetActive(true)
      element.Txt_SelectNum:SetText(data.use)
    else
      element.Btn_Delete:SetActive(false)
      element.Txt_SelectNum:SetActive(false)
    end
  end,
  Incubator_Group_PurificationInterface_Btn_Close_Click = function(btn, str)
    UIManager:GoBack()
    local mainUIView = require("UIMainUI/UIMainUIView")
    mainUIView.self:SetRaycastBlock(false)
    HomeManager:CamFocusEnd(function()
      mainUIView.self:SetRaycastBlock(true)
    end)
  end,
  Incubator_Group_SelectionInterface_ScrollGrid_Choice_Group_Item_Btn_Delete_Click = function(btn, str)
    local grid = View.Group_SelectionInterface.ScrollGrid_Choice.grid
    local data = DataModel.Type[DataModel.Index].data[tonumber(str)]
    local element = grid[tonumber(str)]
    DataModel.TotalUse = DataModel.TotalUse - 1
    data.use = data.use - 1
    element.Txt_SelectNum:SetText(data.use)
    if data.use == 0 then
      element.Img_Select:SetActive(false)
      element.Txt_SelectNum:SetActive(false)
      element.Btn_Delete:SetActive(false)
    else
      element.Img_Select:SetActive(true)
      element.Txt_SelectNum:SetActive(true)
      if 1 < #DataModel.CurrFurnitureConfig.PurificationsiloList then
        element.Btn_Delete:SetActive(true)
      else
        element.Btn_Delete:SetActive(false)
      end
    end
    Controller:RefreshRight()
  end,
  Incubator_Group_SelectionInterface_ScrollGrid_Choice_Group_Item_Btn_Add_Click = function(btn, str)
    local grid = View.Group_SelectionInterface.ScrollGrid_Choice.grid
    local element = grid[tonumber(str)]
    local data = DataModel.Type[DataModel.Index].data[tonumber(str)]
    if #DataModel.CurrFurnitureConfig.PurificationsiloList == 1 then
      if DataModel.SelectData[data.config.id] and DataModel.SelectData[data.config.id].use > 0 then
        DataModel.SelectData[data.config.id].use = 0
        element.Img_Select:SetActive(false)
        element.Btn_Delete:SetActive(false)
        element.Txt_SelectNum:SetActive(false)
        DataModel.TotalUse = 0
        DataModel.SelectData = {}
      else
        for i, v in pairs(DataModel.SelectData) do
          v.use = 0
        end
        DataModel.TotalUse = 0
        DataModel.SelectData = {}
        element.Img_Select:SetActive(true)
        data.use = data.use + 1
        DataModel.TotalUse = DataModel.TotalUse + 1
        element.Txt_SelectNum:SetText(data.use)
        element.Btn_Delete:SetActive(false)
        element.Txt_SelectNum:SetActive(false)
        DataModel.SelectData[data.config.id] = data
      end
    else
      if DataModel.TotalUse == #DataModel.CurrFurnitureConfig.PurificationsiloList then
        print_r("不允许添加")
        return
      end
      element.Img_Select:SetActive(true)
      data.use = data.use + 1
      DataModel.TotalUse = DataModel.TotalUse + 1
      element.Txt_SelectNum:SetText(data.use)
      if data.use > 0 then
        element.Btn_Delete:SetActive(true)
        element.Txt_SelectNum:SetActive(true)
      else
        element.Btn_Delete:SetActive(false)
        element.Txt_SelectNum:SetActive(false)
      end
      DataModel.SelectData[data.config.id] = data
    end
    Controller:RefreshRight()
  end
}
return ViewFunction
