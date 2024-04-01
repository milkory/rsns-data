local View = require("UIHomeCoach/UIHomeCoachView")
local DataModel = require("UIHomeCoach/UIHomeCoachDataModel")
local HomeDataModel = require("UIMainUI/UIMainUIDataModel")
local HomeStoreDataModel = require("UIHomeStore/UIHomeStoreDataModel")
local Controller = require("UIHomeCoach/UIHomeCoachController")
local HomeController = require("UIHome/UIHomeController")
local ViewFunction = {
  HomeCoach_Group_Decorate_Group_ControlPanel_Btn_PutAway_Click = function(btn, str)
    if DataModel.curDecoFurUFId then
      local furniture = PlayerData.ServerData.user_home_info.furniture[DataModel.curDecoFurUFId]
      if furniture and furniture.passenger then
        for i, v in pairs(furniture.passenger) do
          if v ~= " " then
            CommonTips.OpenTips("乘客使用中")
            return
          end
        end
      end
    end
    if DataModel.curDecoFurUFId then
      local furniture = PlayerData.ServerData.user_home_info.furniture[DataModel.curDecoFurUFId]
      if furniture and furniture.u_cid ~= "" then
        local furCA = PlayerData:GetFactoryData(furniture.id, "HomeFurnitureFactory")
        if furCA.functionType == 12600294 and PlayerData:GetUserInfo().space_info.now_food_material_num > PlayerData:GetUserInfo().space_info.max_food_material_num - furCA.FridgeNum then
          CommonTips.OpenTips(80601377)
          return
        end
      end
      local curPower = PlayerData.GetMaxElectric()
      if furniture and furniture.u_cid ~= "" then
        local skillData = PlayerData.ServerData.user_home_info.f_skills
        local furCA = PlayerData:GetFactoryData(furniture.id, "HomeFurnitureFactory")
        if furCA.FurnitureSkillList then
          for i, v in pairs(furCA.FurnitureSkillList) do
            local skillCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureSkillFactory")
            if skillCA.SkillRange == EnumDefine.EFurSkillRangeType.Train and skillCA.SkillType == EnumDefine.HomeSkillEnum.RiseElectricMax then
              local skills = skillData[skillCA.SkillType] and skillData[skillCA.SkillType].train
              if skills and skills[tostring(v.id)] then
                curPower = curPower - skillCA.param
              end
            end
          end
        end
        if curPower < DataModel.powerCostRecordChange then
          CommonTips.OpenTips(80602115)
          return
        end
      end
    end
    local furUfids = HomeManager:RemoveSelectFurniture(DataModel.roomIndex)
    if furUfids == "" or furUfids == nil then
      print_r("这个家具没有furUfid")
      return
    end
    local t = Json.decode(furUfids)
    local isHavePlant = false
    for k, v in pairs(t) do
      local furniture = PlayerData.ServerData.user_home_info.furniture[v]
      if furniture ~= nil then
        local ca = PlayerData:GetFactoryData(furniture.id, "HomeFurnitureFactory")
        local tag = PlayerData:GetFactoryData(ca.functionType, "TagFactory")
        if tag ~= nil and tag.typeName == "植物培养仓" then
          if furniture.plants then
            for i, id in ipairs(furniture.plants) do
              if id and id ~= "" then
                isHavePlant = true
                break
              end
            end
          end
          if isHavePlant then
            break
          end
        end
      end
    end
    local removeFuniture = function(t)
      local electricCost = 0
      for k, v in pairs(t) do
        DataModel.RemoveFurnitureByID(v)
        HomeDataModel.RemoveFurniture(DataModel.roomIndex + 1, v)
        local furniture = PlayerData.ServerData.user_home_info.furniture[v]
        if furniture ~= nil then
          local ca = PlayerData:GetFactoryData(furniture.id, "HomeFurnitureFactory")
          electricCost = electricCost + ca.electricCost
        end
      end
      View.Group_Decorate.Group_ControlPanel.self:SetActive(false)
      DataModel.powerCostRecordChange = DataModel.powerCostRecordChange - electricCost
      Controller.InitDecorateRoomInfo()
      Controller.RefreshCurGrid()
    end
    if isHavePlant then
      CommonTips.OnPrompt("80600406", "80600068", "80600067", function()
        for i, v in pairs(t) do
          local furniture = PlayerData.ServerData.user_home_info.furniture[v]
          if furniture ~= nil then
            local ca = PlayerData:GetFactoryData(furniture.id, "HomeFurnitureFactory")
            local tag = PlayerData:GetFactoryData(ca.functionType, "TagFactory")
            if tag ~= nil and tag.typeName == "植物培养仓" then
              furniture.plants = {}
            end
          end
        end
        removeFuniture(t)
      end)
    else
      removeFuniture(t)
    end
  end,
  HomeCoach_Group_Decorate_Group_ControlPanel_Btn_Replace_Click = function(btn, str)
    Controller:InitFloorFurnitureGrid(DataModel.ReceptionID)
  end,
  HomeCoach_Group_Decorate_Group_ControlPanel_Btn_Reset_Click = function(btn, str)
    HomeManager:ResetSelectFurniturePos(DataModel.roomIndex)
    if HomeManager.selectFurniture ~= nil then
      local pos = HomeManager.selectFurniture:GetTran().transform.position
      local panelPos = HomeManager.cam.homeCamera:WorldToScreenPoint(pos)
      panelPos.x = panelPos.x + 200
      View.Group_Decorate.Group_ControlPanel.self:SetPosition(panelPos)
    end
  end,
  HomeCoach_Group_Decorate_Group_ControlPanel_Btn_OK_Click = function(btn, str)
    Controller:OnReleaseFurniture()
  end,
  HomeCoach_Group_Decorate_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if DataModel.oneLevelIndex == 1 then
      Controller.InitFloorFurnitureTypeGrid()
    elseif DataModel.oneLevelIndex == 2 then
      Controller.InitWallFurnitureTypeGrid()
    elseif DataModel.oneLevelIndex == 3 then
      Controller.InitThemeGrid()
    elseif DataModel.oneLevelIndex == 4 then
      Controller.InitPresetGrid()
    elseif DataModel.oneLevelIndex == 0 then
      local cancelCallback = function()
        Controller:OnReleaseFurniture()
        HomeManager:LoadJson(DataModel.roomIndex, DataModel.revertJson)
        HomeManager:RefreshSpecialRoomPileUpData(DataModel.roomIndex)
        local rdx = DataModel.roomIndex + 1
        HomeController.UpdateFoodBoxNum()
        HomeController.InitRoomFurnitureExtraData(rdx)
        DataModel.CleanRoomFurnitureData(rdx)
        HomeDataModel.roomFurnitureData[rdx] = Clone(DataModel.revertData)
        DataModel.LoadRoomFurnitureData(rdx)
        Controller:CloseDesign()
      end
      local confirmCallback = function()
        if HomeManager:RefreshTiles(DataModel.roomIndex) then
          CommonTips.OpenTips(80600146)
        else
          Controller:DoDecorate(function()
            Controller:CloseDesign()
          end)
        end
      end
      if HomeManager:GetRoomJson(DataModel.roomIndex) == DataModel.revertJson then
        Controller:CloseDesign()
      else
        CommonTips.OnPrompt(80600202, nil, nil, confirmCallback, cancelCallback, nil, true)
      end
    end
    DataModel.curPresetThumbnail = nil
  end,
  HomeCoach_Group_Decorate_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  HomeCoach_Group_Decorate_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomeCoach_Group_Decorate_Btn_ResetCamera_Click = function(btn, str)
    HomeManager:ResetCameraPos()
  end,
  HomeCoach_Group_Decorate_Btn_Floor_Click = function(btn, str)
    Controller:SetFloorLock(not DataModel.floorLock)
  end,
  HomeCoach_Group_Decorate_Btn_Wall_Click = function(btn, str)
    Controller:SetWallLock(not DataModel.wallLock)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_ThemeFurniture_Btn_ApplyTheme_Click = function(btn, str)
    if DataModel.selectFur ~= nil then
      local repID = DataModel.GetCurRep()
      local x, y, z = 0, 0, 0
      DataModel.CleanRoomFurnitureData(DataModel.roomIndex + 1)
      Controller:OnReleaseFurniture()
      local json = "{"
      for i, v in pairs(DataModel.selectFur) do
        if DataModel.CheckFurnitureUseAble(v.id) == true then
          local furConfig = PlayerData:GetFactoryData(tonumber(v.id), "HomeFurnitureFactory")
          if furConfig.type == DataModel.ReceptionID then
            x = v.x
            y = v.y
          end
          local ufid = DataModel.AddFurnitureByID(v.id)
          local skinId = PosClickHandler.GetFurnitureSkinId(ufid)
          json = json .. "\"" .. i .. "\":[{ \"id\":" .. tostring(v.id) .. ", \"ufid\":" .. ufid .. ", \"skinId\":" .. skinId .. ", \"x\":" .. tostring(v.x) .. ",\"y\":" .. tostring(v.y) .. ", \"z\":" .. tostring(z) .. "}],"
          HomeDataModel.AddFurniture(DataModel.roomIndex + 1, {
            ufid = ufid,
            id = v.id
          })
        end
      end
      json = json .. "}"
      HomeManager:LoadJson(DataModel.roomIndex, json)
      local sta = HomeManager:SetReception(repID, x, y)
      if sta == true then
        if repID ~= 0 then
          local ufid = DataModel.AddFurnitureByID(repID)
          HomeDataModel.AddFurniture(DataModel.roomIndex + 1, {ufid = ufid, id = repID})
        end
        HomeManager:RefreshTiles(DataModel.roomIndex)
      end
      Controller:RefreshCurGrid()
    end
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_Btn_Floor_Click = function(btn, str)
    DataModel.oneLevelIndex = 1
    Controller.InitFloorFurnitureTypeGrid()
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_Btn_Wall_Click = function(btn, str)
    DataModel.oneLevelIndex = 2
    Controller.InitWallFurnitureTypeGrid()
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_Btn_Theme_Click = function(btn, str)
    CommonTips.OpenTips(80600368)
    return
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_Btn_Preset_Click = function(btn, str)
    CommonTips.OpenTips(80600368)
    return
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Btn_Save_Click = function(btn, str)
    if HomeManager:RefreshTiles(DataModel.roomIndex) then
      CommonTips.OpenTips(80600146)
    else
      Controller:DoDecorate(function()
        Controller:OnReleaseFurniture()
        HomeManager:ShowAllFurnitureTip()
        Controller:CloseDesign()
      end)
    end
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Btn_Reset_Click = function(btn, str)
    local callback = function()
      Controller:OnReleaseFurniture()
      HomeManager:LoadJson(DataModel.roomIndex, DataModel.revertJson)
      HomeManager:RefreshSpecialRoomPileUpData(DataModel.roomIndex)
      local rdx = DataModel.roomIndex + 1
      HomeController.UpdateFoodBoxNum()
      HomeController.InitRoomFurnitureExtraData(rdx)
      DataModel.CleanRoomFurnitureData(rdx)
      HomeDataModel.roomFurnitureData[rdx] = Clone(DataModel.revertData)
      DataModel.AddFurnitureByTable(DataModel.revertData)
      Controller:RefreshCurGrid()
      DataModel.powerCostRecordChange = DataModel.powerCostRecord
      Controller:InitDecorateRoomInfo()
    end
    CommonTips.OnPrompt(80600203, nil, nil, callback)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Btn_Empty_Click = function(btn, str)
    local callback = function()
      local electricCost = 0
      local afterEmptyFridgeNum = PlayerData:GetUserInfo().space_info.max_food_material_num
      local furAry = HomeDataModel.roomFurnitureData[DataModel.roomIndex + 1]
      for k, v in pairs(furAry) do
        local furniture = PlayerData.ServerData.user_home_info.furniture[v.ufid]
        if furniture and furniture.u_cid ~= "" then
          local ca = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
          if ca.functionType == 12600294 then
            afterEmptyFridgeNum = afterEmptyFridgeNum - ca.FridgeNum
          end
          if ca.beStored then
            electricCost = electricCost + ca.electricCost
          end
        end
      end
      if afterEmptyFridgeNum < PlayerData:GetUserInfo().space_info.now_food_material_num then
        CommonTips.OpenTips(80601377)
        return
      end
      DataModel.CleanRoomFurnitureDataWithoutRep(DataModel.roomIndex + 1)
      Controller:OnReleaseFurniture()
      HomeManager:CleanRoomWithoutRep(DataModel.roomIndex)
      Controller:RefreshCurGrid()
      DataModel.powerCostRecordChange = DataModel.powerCostRecordChange - electricCost
      Controller:InitDecorateRoomInfo()
    end
    CommonTips.OnPrompt(80600204, nil, nil, callback)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetSave_Btn_Close_Click = function(btn, str)
    View.Group_Decorate.Group_Warehouse.Group_PresetSave.self:SetActive(false)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetSave_Btn_Cancel_Click = function(btn, str)
    View.Group_Decorate.Group_Warehouse.Group_PresetSave.self:SetActive(false)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetSave_Btn_Save_Click = function(btn, str)
    local nameOk = Controller:ModifyPresetName(View.Group_Decorate.Group_Warehouse.Group_PresetSave.InputField_Name)
    if not nameOk then
      return
    end
    local roomJson = HomeManager:GetServerRoomJson(DataModel.roomIndex)
    local furData = Json.decode(roomJson)
    if #furData == 0 then
      CommonTips.OpenTips(80600358)
      return
    end
    local table = {}
    local name = View.Group_Decorate.Group_Warehouse.Group_PresetSave.InputField_Name.self:GetText()
    Net:SendProto("home.rename", function(json)
      table.name = name
      PlayerData.ServerData.user_home_info.pre_dress_up[DataModel.curPresetIdx].name = name
      Net:SendProto("home.save_template", function(json)
        table.furData = furData
        table.texture = Controller:GetCurThumbnail()
        DataModel.presetGridData[DataModel.curPresetIdx] = table
        PlayerData.ServerData.user_home_info.pre_dress_up[DataModel.curPresetIdx].template = table.furData
        Controller:InitPresetGrid()
        View.Group_Decorate.Group_Warehouse.Group_PresetSave.self:SetActive(false)
        CommonTips.OpenTips(80600209)
      end, DataModel.curPresetIdx - 1, roomJson)
    end, DataModel.curPresetIdx - 1, name)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetTips_Btn_Close_Click = function(btn, str)
    View.Group_Decorate.Group_Warehouse.Group_PresetTips.self:SetActive(false)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetTips_Btn_ChangeName_Click = function(btn, str)
    local panel = View.Group_Decorate.Group_Warehouse.Group_PresetTips.Group_ChangeName
    local data = DataModel.presetGridData[DataModel.curPresetIdx]
    panel.InputField_ChangeName.self:SetText(data.name)
    panel.self:SetActive(true)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetTips_Btn_Replace_Click = function(btn, str)
    local sta = HomeManager:IsRoomTileError(DataModel.roomIndex)
    if sta == true then
      CommonTips.OpenTips(80600245)
      return
    end
    Controller:OnReleaseFurniture()
    local data = DataModel.presetGridData[DataModel.curPresetIdx]
    View.Group_Decorate.Group_Warehouse.Group_PresetReplace.RawImg_Before:SetTexture2D(data.texture)
    View.Group_Decorate.Group_Warehouse.Group_PresetReplace.RawImg_After:SetTexture2D(Controller:GetCurThumbnail())
    View.Group_Decorate.Group_Warehouse.Group_PresetReplace.self:SetActive(true)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetTips_Btn_Use_Click = function(btn, str)
    View.Group_Decorate.Group_Warehouse.Group_PresetTips.self:SetActive(false)
    local data = DataModel.presetGridData[DataModel.curPresetIdx].furData
    if data ~= nil then
      local repID = DataModel.GetCurRep()
      local x, y = 0
      DataModel.CleanRoomFurnitureData(DataModel.roomIndex + 1)
      Controller:OnReleaseFurniture()
      local json = "{"
      print_r(data)
      for i, v in pairs(data) do
        local id = PlayerData:GetHomeInfo().furniture[v.id].id
        if DataModel.CheckFurnitureUseAble(id) == true then
          local furConfig = PlayerData:GetFactoryData(tonumber(id), "HomeFurnitureFactory")
          if furConfig.type == DataModel.ReceptionID then
            x = v.x
            y = v.y
          end
          local ufid = DataModel.AddFurnitureByID(id)
          local skinId = PosClickHandler.GetFurnitureSkinId(ufid)
          HomeDataModel.AddFurniture(DataModel.roomIndex + 1, {ufid = ufid, id = id})
          json = json .. "\"" .. i .. "\":[{\"id\":" .. id .. ",\"x\":" .. v.x .. ",\"y\":" .. v.y .. ",\"z\":" .. (v.z or 0) .. ",\"ufid\":" .. ufid .. ",\"skinId\":" .. skinId .. "}],"
        end
      end
      json = json .. "}"
      HomeManager:LoadJson(DataModel.roomIndex, json)
      local sta = HomeManager:SetReception(repID, x, y)
      if sta == true then
        local ufid = DataModel.AddFurnitureByID(repID)
        HomeDataModel.AddFurniture(DataModel.roomIndex + 1, {ufid = ufid, id = repID})
        HomeManager:RefreshTiles(DataModel.roomIndex)
      end
      Controller:RefreshCurGrid()
    end
    View.Group_Decorate.Group_ControlPanel.self:SetActive(false)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetTips_Group_ChangeName_Btn_Close_Click = function(btn, str)
    View.Group_Decorate.Group_Warehouse.Group_PresetTips.Group_ChangeName.self:SetActive(false)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetTips_Group_ChangeName_Btn_Confirm_Click = function(btn, str)
    local panel = View.Group_Decorate.Group_Warehouse.Group_PresetTips.Group_ChangeName
    local nameOk = Controller:ModifyPresetName(panel.InputField_ChangeName)
    if not nameOk then
      return
    end
    local newName = panel.InputField_ChangeName.self:GetText()
    Net:SendProto("home.rename", function(json)
      DataModel.presetGridData[DataModel.curPresetIdx].name = newName
      View.Group_Decorate.Group_Warehouse.Group_PresetTips.Txt_Name:SetText(newName)
      PlayerData.ServerData.user_home_info.pre_dress_up[DataModel.curPresetIdx].name = newName
      Controller:InitPresetGrid()
      panel.self:SetActive(false)
    end, DataModel.curPresetIdx - 1, newName)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetTips_Group_ChangeName_Btn_Cancel_Click = function(btn, str)
    View.Group_Decorate.Group_Warehouse.Group_PresetTips.Group_ChangeName.self:SetActive(false)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetReplace_Btn_Close_Click = function(btn, str)
    View.Group_Decorate.Group_Warehouse.Group_PresetReplace.self:SetActive(false)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetReplace_Btn_Cancel_Click = function(btn, str)
    View.Group_Decorate.Group_Warehouse.Group_PresetReplace.self:SetActive(false)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_PresetReplace_Btn_Replace_Click = function(btn, str)
    View.Group_Decorate.Group_Warehouse.Group_PresetReplace.self:SetActive(false)
    local serverRoomJson = HomeManager:GetServerRoomJson(DataModel.roomIndex)
    Net:SendProto("home.save_template", function(json)
      local table = DataModel.presetGridData[DataModel.curPresetIdx]
      table.furData = Json.decode(serverRoomJson)
      table.texture = Controller:GetCurThumbnail()
      DataModel.presetGridData[DataModel.curPresetIdx] = table
      PlayerData.ServerData.user_home_info.pre_dress_up[DataModel.curPresetIdx].template = table.furData
      View.Group_Decorate.Group_Warehouse.Group_PresetTips.self:SetActive(false)
      Controller:InitPresetGrid()
      CommonTips.OpenTips(80600209)
    end, DataModel.curPresetIdx - 1, serverRoomJson)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_ScrollGrid_FurnitureTypeList_Floor_SetGrid = function(element, elementIndex)
    local furData = DataModel.furnitureTypeGridData[elementIndex]
    element.Btn_Type.self:SetClickParam(elementIndex)
    local isSelect = DataModel.typeSelectIdx == elementIndex
    element.Btn_Type.Group_N.self:SetActive(not isSelect)
    element.Btn_Type.Group_S.self:SetActive(isSelect)
    local showGroup
    if isSelect then
      showGroup = element.Btn_Type.Group_S.Group_Type
    else
      showGroup = element.Btn_Type.Group_N.Group_Type
    end
    showGroup.Img_Icon:SetSprite(furData.icon)
    showGroup.Txt_Type:SetText(furData.name)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_ScrollGrid_FurnitureTypeList_Floor_Group_Item_Btn_Type_Click = function(btn, str)
    local idx = tonumber(str)
    if DataModel.typeSelectIdx and DataModel.typeSelectIdx == idx then
      return
    end
    DataModel.typeSelectIdx = idx
    local furData = DataModel.furnitureTypeGridData[idx]
    Controller:InitFloorFurnitureGrid(furData.id)
    View.Group_Decorate.Group_Warehouse.Group_Tab.ScrollGrid_FurnitureTypeList_Floor.grid.self:RefreshAllElement()
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_ScrollGrid_FurnitureTypeList_Wall_SetGrid = function(element, elementIndex)
    local furData = DataModel.furnitureTypeGridData[elementIndex]
    element.Btn_Type.self:SetClickParam(elementIndex)
    element.Btn_Type.Group_Num.Txt_Num1:SetText(furData.max - furData.use)
    element.Btn_Type.Group_Num.Txt_Num2:SetText(furData.max)
    element.Btn_Type.Group_Tpye.Txt_Tpye:SetText(furData.name)
    element.Btn_Type.Group_Tpye.Img_Icon:SetSprite(furData.icon)
    local isSelect = DataModel.typeSelectIdx == elementIndex
    element.Btn_Type.Img_Selected:SetActive(isSelect)
    if isSelect then
      DataModel.preSelectImg = element.Btn_Type.Img_Selected.gameObject
    end
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_ScrollGrid_FurnitureTypeList_Wall_Group_Item_Btn_Type_Click = function(btn, str)
    local idx = tonumber(str)
    if DataModel.preSelectImg ~= nil then
      DataModel.preSelectImg:SetActive(false)
    end
    local imgObj = btn.transform:Find("Img_Selected").gameObject
    imgObj:SetActive(true)
    DataModel.preSelectImg = imgObj
    DataModel.typeSelectIdx = idx
    local furData = DataModel.furnitureTypeGridData[idx]
    Controller:InitFloorFurnitureGrid(furData.id)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_Btn_Sort_Click = function(btn, str)
    if DataModel.curPlaceType == nil or DataModel.curFurnitureType == nil then
      return
    end
    local group_Sort = View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Sort.Group_Sort
    group_Sort.self:SetActive(true)
    Controller.RefreshSortGroup()
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Btn_PutAway_Click = function(btn, str)
    local id = HomeManager:RemoveSelectFurnitureByType(DataModel.roomIndex, tonumber(DataModel.curGridData))
    if id == "" then
      return
    end
    DataModel.RemoveFurnitureByID(id)
    HomeDataModel.RemoveFurniture(DataModel.roomIndex + 1, id)
    local furniture = PlayerData:GetHomeInfo().furniture[id]
    local ca = PlayerData:GetFactoryData(furniture.id, "HomeFurnitureFactory")
    DataModel.powerCostRecordChange = DataModel.powerCostRecordChange - ca.electricCost
    Controller.InitDecorateRoomInfo()
    Controller:RefreshCurGrid()
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_Btn_Sort_Group_Sort_Btn_Close_Click = function(btn, str)
    View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Sort.Group_Sort.self:SetActive(false)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_Btn_Sort_Group_Sort_Btn_Rule01_Click = function(btn, str)
    Controller.SortCurShowGridByBtnIdx(DataModel.sortRule.default)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_Btn_Sort_Group_Sort_Btn_Rule02_Click = function(btn, str)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_Tab_Btn_Sort_Group_Sort_Btn_Rule03_Click = function(btn, str)
  end,
  HomeCoach_Group_Decorate_Group_ControlPanel_Btn_Split_Click = function(btn, str)
    local furUfid = HomeManager:SplitSelectFurnitureTop(DataModel.roomIndex)
    if furUfid == "" or furUfid == nil then
      return
    end
    Controller:RefreshControllerPanel()
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_NewScrollGrid_FurnitureList_SetGrid = function(element, elementIndex)
    element.Btn_Furniture.self:SetClickParam(elementIndex)
    element.Btn_Furniture.Btn_Tips:SetClickParam(elementIndex)
    local row = DataModel.furGridData[elementIndex]
    element.Btn_Furniture.self:SetActive(true)
    element.Btn_Furniture.Group_Name.Txt_Name:SetText(row.name)
    LayoutRebuilder.ForceRebuildLayoutImmediate(element.Btn_Furniture.Group_Name.Txt_Name.Rect)
    if element.Btn_Furniture.Group_Name.Txt_Name.Rect.rect.width > element.Btn_Furniture.Group_Name.Rect.rect.width then
      element.Btn_Furniture.Group_Name.Txt_Name1:SetText(row.name)
      element.Btn_Furniture.Group_Name.Txt_Name1:SetActive(true)
      if not DataModel.rollText[element.gameObject.name] then
        DataModel.rollText[element.gameObject.name] = {
          element.Btn_Furniture.Group_Name.Txt_Name,
          element.Btn_Furniture.Group_Name.Txt_Name1
        }
      end
    else
      DataModel.rollText[element.gameObject.name] = nil
      element.Btn_Furniture.Group_Name.Txt_Name1:SetActive(false)
    end
    element.Btn_Furniture.Img_Mask.Img_Icon:SetSprite(row.icon)
    local canUseNum = row.max - row.use
    element.Btn_Furniture.Txt_Surplus:SetText(canUseNum)
    element.Btn_Furniture.Txt_DevelopmentDegree:SetText(row.electricCost)
    element.Btn_Furniture.Img_Used.self:SetActive(canUseNum == 0)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_NewScrollGrid_FurnitureList_Group_Item_Btn_Furniture_Click = function(btn, str)
    local furData = DataModel.furGridData[tonumber(str)]
    if furData == nil then
      print_r("data is nil" .. str)
      return
    end
    local furCA = PlayerData:GetFactoryData(furData.id, "HomeFurnitureFactory")
    if furCA.functionType == 12600199 and not DataModel.CheckCanPutLiveBed(DataModel.roomIndex + 1, furData.id) then
      local txtCA = PlayerData:GetFactoryData("80601364", "TextFactory")
      CommonTips.OpenTips(txtCA.text)
      return
    end
    local electricCost = 0
    if DataModel.CheckFurnitureUseAble(furData.id) == true and DataModel.CheckFurniturePosType(DataModel.roomIndex, furData.id) then
      local ca = PlayerData:GetFactoryData(furData.id, "HomeFurnitureFactory")
      electricCost = electricCost + ca.electricCost
      local ufid = DataModel.AddFurnitureByID(furData.id)
      HomeDataModel.AddFurniture(DataModel.roomIndex + 1, {
        ufid = ufid,
        id = furData.id
      })
      View.Group_Decorate.Group_ControlPanel.self:SetActive(false)
      local removeFurID = HomeManager:AddFurniture(DataModel.roomIndex, furData.id, ufid, true)
      if removeFurID ~= "" then
        DataModel.RemoveFurnitureByID(removeFurID)
        HomeDataModel.RemoveFurniture(DataModel.roomIndex + 1, removeFurID)
      end
      DataModel.powerCostRecordChange = DataModel.powerCostRecordChange + electricCost
      local serverFurData = PlayerData:GetHomeInfo().furniture[ufid]
      HomeController.InitFurnitureExtraData(serverFurData)
      Controller.InitDecorateRoomInfo()
      Controller:RefreshCurGrid()
    end
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_NewScrollGrid_FurnitureList_Group_Item_Btn_Furniture_Btn_Tips_Click = function(btn, str)
    local furData = DataModel.furGridData[tonumber(str)]
    Controller:ShowFurnitureTip(furData.id)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_NewScrollGrid_ThemeList_SetGrid = function(element, elementIndex)
    element.Btn_Theme.self:SetClickParam(elementIndex)
    element.Btn_Theme.Btn_Tips:SetClickParam(elementIndex)
    local row = DataModel.themeGridData[elementIndex]
    element.Btn_Theme.Txt_Tpye:SetText(row.name)
    element.Btn_Theme.Group_Num.Txt_Num1:SetText(row.have)
    element.Btn_Theme.Group_Num.Txt_Num2:SetText(row.max)
    element.Btn_Theme.Img_Icon:SetSprite(row.iconPath)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_NewScrollGrid_ThemeList_Group_Item_Btn_Theme_Click = function(btn, str)
    local row = DataModel.themeGridData[tonumber(str)]
    DataModel.selectJson = row.json
    DataModel.selectFur = row.furnitures
    Controller:InitThemeItemGrid(row)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_NewScrollGrid_ThemeList_Group_Item_Btn_Theme_Btn_Tips_Click = function(btn, str)
    local row = DataModel.themeGridData[tonumber(str)]
    Controller:ShowThemeTip(row.id)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_ThemeFurniture_NewScrollGrid_FurnitureList_SetGrid = function(element, elementIndex)
    element.Btn_Furniture.self:SetClickParam(elementIndex)
    element.Btn_Furniture.Btn_Tips:SetClickParam(elementIndex)
    local row = DataModel.furGridData[elementIndex]
    element.Btn_Furniture.Txt_Name:SetText(row.name)
    element.Btn_Furniture.Img_Icon:SetSprite(row.iconPath)
    element.Btn_Furniture.Txt_DevelopmentDegree:SetText(row.electricCost)
    element.Btn_Furniture.Group_Num.Txt_Num1:SetText(row.haveMax - row.use)
    element.Btn_Furniture.Group_Num.Txt_Num2:SetText(row.max)
    element.Btn_Furniture.Img_Unusable:SetActive(false)
    element.Btn_Furniture.Img_Used:SetActive(false)
    element.Btn_Furniture.Img_NotHave:SetActive(false)
    if row.haveMax == 0 then
      element.Btn_Furniture.Img_NotHave:SetActive(true)
    elseif row.haveMax - row.use == 0 then
      element.Btn_Furniture.Img_Used:SetActive(true)
    end
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_ThemeFurniture_NewScrollGrid_FurnitureList_Group_Item_Btn_Furniture_Click = function(btn, str)
    local furData = DataModel.furGridData[tonumber(str)]
    local electricCost = 0
    if DataModel.CheckFurnitureUseAble(furData.id) == true then
      local ca = PlayerData:GetFactoryData(furData.id, "HomeFurnitureFactory")
      electricCost = electricCost + ca.electricCost
      local ufid = DataModel.AddFurnitureByID(furData.id)
      HomeDataModel.AddFurniture(DataModel.roomIndex + 1, {
        ufid = ufid,
        id = furData.id
      })
      local removeFurID = HomeManager:AddFurniture(DataModel.roomIndex, furData.id, ufid, false)
      if removeFurID ~= 0 then
        DataModel.RemoveFurnitureByID(removeFurID)
        HomeDataModel.RemoveFurniture(DataModel.roomIndex + 1, removeFurID)
      end
      DataModel.powerCostRecordChange = DataModel.powerCostRecordChange + electricCost
      Controller.InitDecorateRoomInfo()
      Controller:RefreshCurGrid()
    end
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_Group_ThemeFurniture_NewScrollGrid_FurnitureList_Group_Item_Btn_Furniture_Btn_Tips_Click = function(btn, str)
    local furData = DataModel.furGridData[tonumber(str)]
    Controller:ShowFurnitureTip(furData.id)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_NewScrollGrid_PresetList_SetGrid = function(element, elementIndex)
    local data = DataModel.presetGridData[elementIndex]
    if data == nil or data.furData == nil or #data.furData <= 0 then
      element.Btn_Save.self:SetClickParam(elementIndex)
      element.Btn_Save.self:SetActive(true)
      element.Btn_Preset.self:SetActive(false)
    elseif type(data) == "table" then
      element.Btn_Preset.self:SetClickParam(elementIndex)
      if data.texture == nil and data.furData ~= nil and next(data.furData) ~= nil then
        print_r("分帧还未加载出来，直接加载")
        data.texture = Controller:GetServerRoomThumbnail(data.furData)
      end
      element.Btn_Preset.RawImg_Icon:SetTexture2D(data.texture)
      element.Btn_Preset.Txt_Name:SetText(data.name)
      element.Btn_Save.self:SetActive(false)
      element.Btn_Preset.self:SetActive(true)
    end
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_NewScrollGrid_PresetList_Group_Item_Btn_Preset_Click = function(btn, str)
    local sta = HomeManager:IsRoomTileError(DataModel.roomIndex)
    if sta == true then
      CommonTips.OpenTips(80600245)
      return
    end
    local idx = tonumber(str)
    DataModel.curPresetIdx = idx
    local panel = View.Group_Decorate.Group_Warehouse.Group_PresetSave
    panel.InputField_Name.self:SetText(string.format(GetText(80600227), idx))
    local roomFurData = HomeDataModel.roomFurnitureData[DataModel.roomIndex + 1]
    local electricCost = 0
    local txtDelicious = 0
    local txtEfficiency = 0
    local txtComfort = 0
    for i, v in pairs(roomFurData) do
      local furnitureConfig = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
      if furnitureConfig then
        electricCost = electricCost + furnitureConfig.electricCost
        txtComfort = txtComfort + furnitureConfig.comfort
      end
    end
    panel.Txt_DevelopmentDegree:SetText(electricCost)
    panel.Txt_Delicious:SetText(txtDelicious)
    panel.Txt_Comfort:SetText(txtComfort)
    Controller:OnReleaseFurniture()
    panel.RawImg_Icon:SetTexture2D(Controller:GetCurThumbnail())
    panel.self:SetActive(true)
  end,
  HomeCoach_Group_Decorate_Group_Warehouse_NewScrollGrid_PresetList_Group_Item_Btn_Save_Click = function(btn, str)
    local idx = tonumber(str)
    DataModel.curPresetIdx = idx
    local data = DataModel.presetGridData[idx]
    local panel = View.Group_Decorate.Group_Warehouse.Group_PresetTips
    local furTable = data.furData
    local electricCost = 0
    local txtDelicious = 0
    local txtComfort = 0
    panel.Txt_Name:SetText(data.name)
    panel.RawImg_Icon:SetTexture2D(data.texture)
    for k, v in pairs(furTable) do
      local id = PlayerData:GetHomeInfo().furniture[v.id].id
      local furnitureConfig = PlayerData:GetFactoryData(id, "HomeFurnitureFactory")
      electricCost = electricCost + furnitureConfig.electricCost
      txtComfort = txtComfort + furnitureConfig.comfort
    end
    panel.Txt_DevelopmentDegree:SetText(electricCost)
    panel.Txt_Delicious:SetText(txtDelicious)
    panel.Txt_Comfort:SetText(txtComfort)
    panel.Group_ChangeName.self:SetActive(false)
    panel.self:SetActive(true)
  end,
  HomeCoach_Group_Decorate_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end
}
return ViewFunction
