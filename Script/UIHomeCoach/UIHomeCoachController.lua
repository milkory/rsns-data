local mathEx = require("vendor/mathEx")
local View = require("UIHomeCoach/UIHomeCoachView")
local DataModel = require("UIHomeCoach/UIHomeCoachDataModel")
local HomeDataModel = require("UIMainUI/UIMainUIDataModel")
local MapDataModel = require("UIHome/UIHomeMapDataModel")
local Controller = {}
local ResetAllSelect = function()
  local grid = {
    View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Floor.Img_Selected,
    View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Wall.Img_Selected,
    View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Theme.Img_Selected,
    View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Preset.Img_Selected
  }
  for i, v in pairs(grid) do
    v.self:SetActive(false)
  end
end
local CloseAllGrids = function()
  local WareHouseGrids = {
    View.Group_Decorate.Group_Warehouse.NewScrollGrid_FurnitureList,
    View.Group_Decorate.Group_Warehouse.NewScrollGrid_ThemeList,
    View.Group_Decorate.Group_Warehouse.NewScrollGrid_PresetList,
    View.Group_Decorate.Group_Warehouse.Group_ThemeFurniture,
    View.Group_Decorate.Group_Warehouse.Btn_PutAway
  }
  for i, v in pairs(WareHouseGrids) do
    v.self:SetActive(false)
  end
end
local CloseTypeGrids = function()
  local grid = {
    View.Group_Decorate.Group_Warehouse.Group_Tab.ScrollGrid_FurnitureTypeList_Floor,
    View.Group_Decorate.Group_Warehouse.Group_Tab.ScrollGrid_FurnitureTypeList_Wall
  }
  for i, v in pairs(grid) do
    v.self:SetActive(false)
  end
end
local TypeContains = function(type, typeList)
  for i, v in pairs(typeList) do
    if v.id == type then
      return true
    end
  end
  return false
end

function Controller:Init()
  local cfg = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  View.Group_Decorate.Group_Warehouse.Group_FurnitureNum.Txt_Max:SetText(cfg.furnitureBag)
  local curHave = 0
  for i, v in pairs(DataModel.furnitureData) do
    curHave = curHave + v.max
  end
  View.Group_Decorate.Group_Warehouse.Group_FurnitureNum.Txt_Own:SetText(curHave)
  Controller.InitFloorFurnitureTypeGrid()
  DataModel.powerCostRecord = PlayerData:GetHomeInfo().electric_used
  DataModel.powerCostRecordChange = PlayerData:GetHomeInfo().electric_used
  DataModel.roomIndex = HomeManager:DesignMode()
  DataModel.revertData = Clone(HomeDataModel.roomFurnitureData[DataModel.roomIndex + 1])
  DataModel.revertJson = HomeManager:GetRoomJson(DataModel.roomIndex)
  Controller:SetFloorLock(true)
  Controller:SetWallLock(true)
  Controller:OnReleaseFurniture()
  Controller:OnReleaseSpecialFurniture()
  Controller.InitDecorateRoomInfo()
  HomeCharacterManager:HideAll()
  HomeCharacterManager:StopAll()
end

function Controller:ShowFurnitureTip(id)
  CommonTips.OpenFurnitureTip(id, DataModel.GetFurnitureData(id).max)
end

function Controller:ShowThemeTip(id)
  CommonTips.OpenThemeTip(id, DataModel.GetFurnitureData(id).max)
end

local SortByDefault = function(a, b)
  local aId = tonumber(a.id)
  local bId = tonumber(b.id)
  if aId > bId then
    return DataModel.sortDown
  elseif aId == bId then
    return false
  elseif aId < bId then
    return not DataModel.sortDown
  end
end
local SortByDevelopmentDegree = function(a, b)
  if a.developmentDegree > b.developmentDegree then
    return DataModel.sortDown
  elseif a.developmentDegree == b.developmentDegree then
    if a.rarity > b.rarity then
      return true
    elseif a.rarity == b.rarity then
      return a.id > b.id
    elseif a.rarity < b.rarity then
      return false
    end
  elseif a.developmentDegree < b.developmentDegree then
    return not DataModel.sortDown
  end
end
local SortByPrimeAttrType = function(a, b)
  if a.primeAttr > b.primeAttr then
    return DataModel.sortDown
  elseif a.primeAttr == b.primeAttr then
    if a.rarity > b.rarity then
      return true
    elseif a.rarity == b.rarity then
      return a.id > b.id
    elseif a.rarity < b.rarity then
      return false
    end
  elseif a.primeAttr < b.primeAttr then
    return not DataModel.sortDown
  end
end

function Controller.SortCurShowGrid(placeType, furType)
  if placeType == nil or furType == nil then
    return
  end
  local sortFunc
  if DataModel.sortRuleRecord[placeType] == nil then
    DataModel.sortRuleRecord[placeType] = {}
  end
  if DataModel.sortRuleRecord[placeType][furType] == nil then
    DataModel.sortRuleRecord[placeType][furType] = {}
    DataModel.sortRuleRecord[placeType][furType].curSort = DataModel.sortRule.default
  end
  if DataModel.sortRuleRecord[placeType][furType].curSort == DataModel.sortRule.default then
    sortFunc = SortByDefault
    if DataModel.sortRuleRecord[placeType][furType][DataModel.sortRule.default] == nil then
      DataModel.sortRuleRecord[placeType][furType][DataModel.sortRule.default] = true
    end
    DataModel.sortDown = DataModel.sortRuleRecord[placeType][furType][DataModel.sortRule.default]
  elseif DataModel.sortRuleRecord[placeType][furType].curSort == DataModel.sortRule.developmentDegree then
    sortFunc = SortByDevelopmentDegree
    if DataModel.sortRuleRecord[placeType][furType][DataModel.sortRule.developmentDegree] == nil then
      DataModel.sortRuleRecord[placeType][furType][DataModel.sortRule.developmentDegree] = true
    end
    DataModel.sortDown = DataModel.sortRuleRecord[placeType][furType][DataModel.sortRule.developmentDegree]
  elseif DataModel.sortRuleRecord[placeType][furType].curSort == DataModel.sortRule.primeAttrType then
    sortFunc = SortByPrimeAttrType
    if DataModel.sortRuleRecord[placeType][furType][DataModel.sortRule.primeAttrType] == nil then
      DataModel.sortRuleRecord[placeType][furType][DataModel.sortRule.primeAttrType] = true
    end
    DataModel.sortDown = DataModel.sortRuleRecord[placeType][furType][DataModel.sortRule.primeAttrType]
  end
  if sortFunc ~= nil then
    table.sort(DataModel.furGridData, sortFunc)
  end
end

function Controller.SortCurShowGridByBtnIdx(sortType)
  if DataModel.curPlaceType == nil or DataModel.curFurnitureType == nil then
    return
  end
  local t = DataModel.sortRuleRecord[DataModel.curPlaceType][DataModel.curFurnitureType]
  local curSort = t.curSort
  local sortDown = t[curSort]
  if curSort == sortType then
    DataModel.sortRuleRecord[DataModel.curPlaceType][DataModel.curFurnitureType][curSort] = not sortDown
  else
    DataModel.sortRuleRecord[DataModel.curPlaceType][DataModel.curFurnitureType].curSort = sortType
  end
  Controller.RefreshSortGroup()
  Controller.SortCurShowGrid(DataModel.curPlaceType, DataModel.curFurnitureType)
  View.Group_Decorate.Group_Warehouse.NewScrollGrid_FurnitureList.grid.self:SetDataCount(#DataModel.furGridData)
  View.Group_Decorate.Group_Warehouse.NewScrollGrid_FurnitureList.grid.self:RefreshAllElement()
end

function Controller.RefreshSortGroup()
  if DataModel.curPlaceType == nil or DataModel.curFurnitureType == nil then
    return
  end
  local group_Sort = View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Sort.Group_Sort
  local t = DataModel.sortRuleRecord[DataModel.curPlaceType][DataModel.curFurnitureType]
  local curSort = t.curSort
  for i = 1, 3 do
    group_Sort["Btn_Rule0" .. i].Img_Selected.self:SetActive(i == curSort)
    if i == curSort then
      group_Sort["Btn_Rule0" .. i].Img_Arrow:SetSprite("UI\\Home\\home_icon_sort02")
    else
      group_Sort["Btn_Rule0" .. i].Img_Arrow:SetSprite("UI\\Common\\home_icon_sort01")
    end
    local sortDown = t[i]
    if sortDown == true or sortDown == nil then
      group_Sort["Btn_Rule0" .. i].Img_Arrow:SetLocalEulerAngles(0)
    else
      group_Sort["Btn_Rule0" .. i].Img_Arrow:SetLocalEulerAngles(180)
    end
  end
end

function Controller.RefreshGrid(idx, data)
  DataModel.curGridName = idx
  local preGridData = DataModel.curGridData
  DataModel.curGridData = data
  if idx == "floor" then
    if preGridData == DataModel.curGridData then
      for i, v in pairs(DataModel.furGridData) do
        local t = DataModel.furnitureData[v.id]
        if t ~= nil then
          v.use = t.use
          v.max = t.max
        end
      end
    else
      DataModel.furGridData = {}
      if data == DataModel.floorType or data == DataModel.wallType then
        View.Group_Decorate.Group_Warehouse.Btn_PutAway.self:SetActive(true)
      end
      local id = DataModel.GetRoomID()
      local coachConfig = PlayerData:GetFactoryData(id, "HomeCoachFactory")
      local placeType
      for i, v in pairs(DataModel.furnitureData) do
        local furnitureConfig = PlayerData:GetFactoryData(i, "HomeFurnitureFactory")
        local furSkinCA = PlayerData:GetFactoryData(PosClickHandler.GetFurnitureSkinId(v.data[1].server.u_fid), "HomeFurnitureSkinFactory")
        if furnitureConfig and furnitureConfig.type == data then
          local row = {}
          table.insert(DataModel.furGridData, row)
          row.id = i
          row.data = v.data
          row.use = v.use
          row.max = v.max
          row.name = furnitureConfig.name
          if tonumber(i) == 81300192 then
            row.icon = PlayerData:GetUserInfo().gender == 1 and furSkinCA.iconPath or furSkinCA.SecondiconPath
          else
            row.icon = furSkinCA.iconPath
          end
          row.type = data
          row.electricCost = furnitureConfig.electricCost
          row.rarity = furnitureConfig.rarity
          placeType = furnitureConfig.place
        end
      end
      DataModel.curPlaceType = placeType
      DataModel.curFurnitureType = data
      Controller.SortCurShowGrid(placeType, data)
    end
    View.Group_Decorate.Group_Warehouse.NewScrollGrid_FurnitureList.grid.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      View.Group_Decorate.Group_Warehouse.NewScrollGrid_FurnitureList.grid.self:SetDataCount(#DataModel.furGridData)
      View.Group_Decorate.Group_Warehouse.NewScrollGrid_FurnitureList.grid.self:RefreshAllElement()
    end))
  elseif idx == "theme" then
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    DataModel.themeGridData = {}
    DataModel.furUseTable = {}
    local id = DataModel.GetRoomID()
    local coachConfig = PlayerData:GetFactoryData(id, "HomeCoachFactory")
    for i, v in pairs(homeConfig.themeList) do
      local row = {}
      table.insert(DataModel.themeGridData, row)
      row.id = v.id
      local templateConfig = PlayerData:GetFactoryData(v.id, "HomeTemplateFactory")
      row.name = templateConfig.name
      row.furnitures = {}
      row.iconPath = templateConfig.iconPath
      local json = "{"
      local furGridDataIndex = {}
      for i, dv in pairs(templateConfig.furnitures) do
        local fur = {}
        fur.id = dv.id
        fur.x = dv.x
        fur.y = dv.y
        local data = DataModel.GetFurnitureData(dv.id)
        local cnt = DataModel.furUseTable[dv.id] or 0
        if cnt < data.max - data.use then
          json = json .. "\"" .. i .. "\":[{\"id\":" .. dv.id .. ",\"x\":" .. dv.x .. ",\"y\":" .. dv.y .. "}],"
        end
        DataModel.furUseTable[dv.id] = cnt + 1
        table.insert(row.furnitures, fur)
        if furGridDataIndex[dv.id] == nil then
          furGridDataIndex[dv.id] = 1
        end
      end
      local have = 0
      local max = 0
      for i, v in pairs(furGridDataIndex) do
        local data = DataModel.GetFurnitureData(i)
        have = have + MathEx.Clamp(data.max - data.use, 0, v)
        max = max + v
      end
      row.have = have
      row.max = max
      json = json .. "}"
      row.json = json
    end
    View.Group_Decorate.Group_Warehouse.NewScrollGrid_ThemeList.grid.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      View.Group_Decorate.Group_Warehouse.NewScrollGrid_ThemeList.grid.self:SetDataCount(#DataModel.furGridData)
      View.Group_Decorate.Group_Warehouse.NewScrollGrid_ThemeList.grid.self:RefreshAllElement()
    end))
  elseif idx == "themeItem" then
    local id = DataModel.GetRoomID()
    local coachConfig = PlayerData:GetFactoryData(id, "HomeCoachFactory")
    DataModel.furGridData = {}
    local furGridDataIndex = {}
    for i, v in pairs(data.furnitures) do
      if furGridDataIndex[v.id] == nil then
        local furnitureConfig = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
        local row = {}
        table.insert(DataModel.furGridData, row)
        local data = DataModel.GetFurnitureData(v.id)
        row.id = v.id
        row.name = furnitureConfig.name
        row.iconPath = furnitureConfig.iconPath
        row.use = data.use
        row.haveMax = data.max
        row.max = 1
        furGridDataIndex[v.id] = row
      else
        local row = furGridDataIndex[v.id]
        row.max = row.max + 1
      end
    end
    View.Group_Decorate.Group_Warehouse.Group_ThemeFurniture.NewScrollGrid_FurnitureList.grid.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      View.Group_Decorate.Group_Warehouse.Group_ThemeFurniture.NewScrollGrid_FurnitureList.grid.self:SetDataCount(#DataModel.furGridData)
      View.Group_Decorate.Group_Warehouse.Group_ThemeFurniture.NewScrollGrid_FurnitureList.grid.self:RefreshAllElement()
    end))
  elseif idx == "preset" then
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local maxNum = homeConfig.CustomTemplateNum
    View.Group_Decorate.Group_Warehouse.NewScrollGrid_PresetList.grid.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      View.Group_Decorate.Group_Warehouse.NewScrollGrid_PresetList.grid.self:SetDataCount(maxNum)
      View.Group_Decorate.Group_Warehouse.NewScrollGrid_PresetList.grid.self:RefreshAllElement()
    end))
  end
end

function Controller:RefreshCurGrid()
  Controller.RefreshGrid(DataModel.curGridName, DataModel.curGridData)
end

function Controller:CloseDesign()
  DataModel.curGridData = nil
  HomeManager:FreeMode()
  local liveDataModel = require("UINewHomeLive/UINewHomeLiveDataModel")
  local liveController = require("UINewHomeLive/UINewHomeLiveController")
  liveDataModel.InitLiveFurData()
  liveController.InitSleep()
  local emergencyDataModel = require("UIHomeEmergency/UIHomeEmergencyDataModel")
  emergencyDataModel.InitEmergency()
  local homeFoodController = require("UIHomeFood/UIHomeFoodController")
  homeFoodController.InitFoodCook()
  UIManager:GoBack()
end

function Controller:InitWallFurnitureTypeGrid()
  DataModel.oneLevelIndex = 0
  CloseAllGrids()
  ResetAllSelect()
  CloseTypeGrids()
  DataModel.typeSelectIdx = 0
  DataModel.ResetFurnitureTypeData()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  DataModel.furnitureTypeGridData = {}
  for i, v in pairs(homeConfig.wallTypeList) do
    local row = {}
    table.insert(DataModel.furnitureTypeGridData, row)
    row.id = v.id
    local td = DataModel.furnitureTypeData[v.id] or {
      use = 0,
      max = 0,
      data = {}
    }
    row.use = td.use
    row.max = td.max
    local furnitureConfig = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    row.name = furnitureConfig.typeName
    row.icon = furnitureConfig.iconPath
  end
  View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Wall.Img_Selected.self:SetActive(true)
  local typeList = View.Group_Decorate.Group_Warehouse.Group_Tab.ScrollGrid_FurnitureTypeList_Wall
  typeList.self:SetActive(true)
  typeList.grid.self:MoveToTop()
  typeList.grid.self:SetDataCount(#DataModel.furnitureTypeGridData)
  Controller:FurnitureTypeSelect(1, typeList)
  typeList.grid.self:RefreshAllElement()
end

function Controller:InitFloorFurnitureTypeGrid()
  DataModel.oneLevelIndex = 0
  CloseAllGrids()
  ResetAllSelect()
  CloseTypeGrids()
  DataModel.ResetFurnitureTypeData()
  DataModel.typeSelectIdx = 0
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  DataModel.furnitureTypeGridData = {}
  for i, v in pairs(homeConfig.floorTypeList) do
    local row = {}
    table.insert(DataModel.furnitureTypeGridData, row)
    row.id = v.id
    local td = DataModel.furnitureTypeData[v.id] or {
      use = 0,
      max = 0,
      data = {}
    }
    row.use = td.use
    row.max = td.max
    local furnitureConfig = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    row.name = furnitureConfig.typeName
    row.icon = furnitureConfig.iconPath
    row.data = td.data
  end
  View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Floor.Img_Selected.self:SetActive(true)
  local typeList = View.Group_Decorate.Group_Warehouse.Group_Tab.ScrollGrid_FurnitureTypeList_Floor
  typeList.self:SetActive(true)
  typeList.grid.self:MoveToTop()
  typeList.grid.self:SetDataCount(#DataModel.furnitureTypeGridData)
  Controller:FurnitureTypeSelect(1, typeList)
  typeList.grid.self:RefreshAllElement()
end

function Controller:FurnitureTypeSelect(idx)
  DataModel.typeSelectIdx = idx
  local furData = DataModel.furnitureTypeGridData[idx]
  Controller:InitFloorFurnitureGrid(furData.id)
end

function Controller:InitFloorFurnitureGrid(type)
  DataModel.furnitureType = type
  CloseAllGrids()
  View.Group_Decorate.Group_Warehouse.NewScrollGrid_FurnitureList.self:SetActive(true)
  Controller.RefreshGrid("floor", type)
end

function Controller:InitPresetGrid(type)
  DataModel.oneLevelIndex = 0
  DataModel.furnitureType = type
  CloseAllGrids()
  ResetAllSelect()
  CloseTypeGrids()
  View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Preset.Img_Selected.self:SetActive(true)
  View.Group_Decorate.Group_Warehouse.NewScrollGrid_PresetList.self:SetActive(true)
  Controller.RefreshGrid("preset", type)
end

function Controller:InitThemeItemGrid(data)
  CloseAllGrids()
  ResetAllSelect()
  CloseTypeGrids()
  View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Theme.Img_Selected.self:SetActive(true)
  View.Group_Decorate.Group_Warehouse.Group_ThemeFurniture.self:SetActive(true)
  Controller.RefreshGrid("themeItem", data)
end

function Controller:InitThemeGrid()
  DataModel.oneLevelIndex = 0
  CloseAllGrids()
  ResetAllSelect()
  CloseTypeGrids()
  DataModel.furGridData = {}
  View.Group_Decorate.Group_Warehouse.Group_Tab.Btn_Theme.Img_Selected.self:SetActive(true)
  View.Group_Decorate.Group_Warehouse.NewScrollGrid_ThemeList.self:SetActive(true)
  Controller.RefreshGrid("theme")
end

function Controller.InitDecorateRoomInfo()
  local data = DataModel.GetRoomInfo()
  View.Group_Decorate.Group_Attr.Txt_DevelopmentDegree:SetText(DataModel.powerCostRecordChange .. "/" .. PlayerData.GetMaxElectric())
end

function Controller.SetItem(element, data, have, need)
  local qualityInt = data.qualityInt + 1
  element.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[qualityInt])
  element.Group_Item.Img_Item:SetSprite(data.iconPath)
  element.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[qualityInt])
  if need == nil then
    element.Group_Num.Txt_Num:SetText(have)
  else
    element.Group_Num.Txt_Num1:SetText(have)
    element.Group_Num.Txt_Num2:SetText(need)
  end
end

function Controller:OnFurnitureClick(pos, typeid, uid)
  View.Group_Decorate.Group_ControlPanel.self:SetActive(true)
  local t = PlayerData.ServerData.user_home_info.furniture
  local info = t[uid]
  if info == nil then
    return
  end
  local furnitureCA = PlayerData:GetFactoryData(info.id, "HomeFurnitureFactory")
  local canPutaway = furnitureCA.beStored
  View.Group_Decorate.Group_ControlPanel.Img_CantPutAway.self:SetActive(not canPutaway)
  local sta = typeid == DataModel.ReceptionID
  View.Group_Decorate.Group_ControlPanel.Btn_Replace.self:SetActive(sta and canPutaway)
  local isPileUp = false
  if HomeManager.selectFurniture ~= nil then
    isPileUp = HomeManager.selectFurniture:IsPileUp()
  end
  View.Group_Decorate.Group_ControlPanel.Btn_PutAway.self:SetActive(not sta and not isPileUp and canPutaway)
  View.Group_Decorate.Group_ControlPanel.Btn_Split.self:SetActive(not sta and isPileUp)
  local vec = Vector2(pos.x, pos.y)
  View.Group_Decorate.Group_ControlPanel.self:SetAnchoredPosition(vec)
  pos = View.Group_Decorate.Group_ControlPanel.self.transform.localPosition
  pos.x = pos.x + 200
  pos.z = 0
  View.Group_Decorate.Group_ControlPanel.self:SetLocalPosition(pos)
  DataModel.curDecoFurUFId = uid
end

function Controller:RefreshControllerPanel()
  if HomeManager.selectFurniture ~= nil then
    local isPileUp = HomeManager.selectFurniture:IsPileUp()
    View.Group_Decorate.Group_ControlPanel.Btn_PutAway.self:SetActive(not isPileUp)
    View.Group_Decorate.Group_ControlPanel.Btn_Split.self:SetActive(isPileUp)
  end
end

function Controller:OnFurnitureTipShow(id, ufid)
  local furnitureCA = PlayerData:GetFactoryData(id, "HomeFurnitureFactory")
end

function Controller:OnSpecialFurnitureClick(pos, uid, cid)
  local t = PlayerData.ServerData.user_home_info.furniture
  local info = t[uid]
  if info == nil then
    local CityStoreDataModel = require("UICityStore/UICityStoreDataModel")
    if cid == 81300136 then
      if CityStoreDataModel.forbidReturn ~= true then
        UIManager:Open("UI/HomeSticker/HomeSticker", Json.encode(t))
      end
    elseif cid == 81300160 or cid == 81300002 or cid == 81300179 or cid == 81300296 then
      CityStoreDataModel:FastFoodClick()
    end
    if cid == 81300289 then
      local gender = PlayerData:GetUserInfo().gender or 1
      local characterId = gender == 1 and 70000067 or 70000063
      local shopCA = PlayerData:GetFactoryData(40300016, "StoreFactory")
      local shopItems = {}
      for i, v in pairs(shopCA.shopList) do
        table.insert(shopItems, v.id)
      end
      UIManager:Open("UI/ChangeSkin/DressStore", Json.encode({
        characterId = characterId,
        shopId = 40300016,
        shopItems = shopItems
      }))
    end
    return
  end
  local caId = info.id
  local furnitureCA = PlayerData:GetFactoryData(caId, "HomeFurnitureFactory")
  if furnitureCA.type == 12600176 or furnitureCA.type == 12600182 or furnitureCA.type == 12600204 then
    return
  end
  if not furnitureCA.isShowBubble then
    return
  end
  local t = {}
  t.ufid = uid
  t.posX = pos.x
  t.posY = pos.y
  UIManager:Open("UI/HomeUpgrade/HomeBubble", Json.encode(t))
end

function Controller:PetClick(pos, petId)
end

function Controller:OnReleaseFurniture()
  HomeManager:ReleaseSelectFurniture()
  View.Group_Decorate.Group_ControlPanel.self:SetActive(false)
end

function Controller:OnReleaseSpecialFurniture()
  if DataModel.tempPanel ~= nil then
    DataModel.tempPanel.self:SetActive(false)
    DataModel.tempPanel = nil
    DataModel.tempFurUfid = nil
  end
end

function Controller:OnHomeRoomIndex(index)
  DataModel.roomIndex = index
  index = index + 1
end

function Controller:ModifyPresetName(inputField)
  if inputField.self:GetText() == "" then
    CommonTips.OpenTips(GetText(80600225))
    return false
  end
  local result = inputField.self:CheckText(DataModel.characterMaxLimit)
  if result == 0 then
    return true
  elseif result == 1 then
    CommonTips.OpenTips(GetText(80600088))
  elseif result == 2 or result == 3 then
    CommonTips.OpenTips(GetText(80600087))
  end
  return false
end

function Controller:GetCurThumbnail()
  local roomJson = HomeManager:GetRoomJson(DataModel.roomIndex)
  if DataModel.curPresetThumbnail == nil or roomJson ~= DataModel.curPresetRoomJson then
    print_r("create new texture")
    DataModel.curPresetRoomJson = roomJson
    local texture = HomeManager:GetThumbnailByRoomIdx(DataModel.roomIndex, HomeDataModel.screenshot.x, HomeDataModel.screenshot.y, HomeDataModel.camOffsetX, HomeDataModel.camOffsetY)
    DataModel.curPresetThumbnail = texture
  end
  return DataModel.curPresetThumbnail
end

function Controller:OpenFurnitureStore()
  local a, b = PlayerData:OpenStoreCondition()
  if a == false then
    CommonTips.OpenTips(b[1].txt)
    return
  end
  Net:SendProto("shop.info", function(json)
    UIManager:Open("UI/Store/HomeStore")
  end)
end

function Controller:GetServerRoomThumbnail(data)
  local json = data
  if type(data) == "table" then
    json = Controller:ServerTableToRoomJson(data)
  end
  local texture = HomeManager:GetThumbnailByRoomJson(json, HomeDataModel.screenshot.x, HomeDataModel.screenshot.y, HomeDataModel.camOffsetX, HomeDataModel.camOffsetY)
  return texture
end

function Controller:ServerTableToRoomJson(data)
  local json = "{"
  for i, v in pairs(data) do
    local furId = PlayerData.ServerData.user_home_info.furniture[v.id].id
    local furConfig = PlayerData:GetFactoryData(furId, "HomeFurnitureFactory")
    if furConfig.type == DataModel.ReceptionID then
      x = v.x
      y = v.y
    end
    local z = 0
    json = json .. "\"" .. i .. "\":[{ \"id\":" .. tostring(furId) .. ", \"ufid\":" .. v.id .. ", \"x\":" .. tostring(v.x) .. ",\"y\":" .. tostring(v.y) .. ", \"z\":" .. tostring(z) .. "}],"
  end
  json = json .. "}"
  return json
end

function Controller:PreLoadPresetThumbnail()
  local needCoroutine = false
  for i, v in pairs(DataModel.presetGridData) do
    if v.texture == nil and v.furData ~= nil and next(v.furData) ~= nil then
      needCoroutine = true
      break
    end
  end
  if needCoroutine == true then
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      for i, v in pairs(DataModel.presetGridData) do
        if v.texture == nil and v.furData ~= nil and next(v.furData) ~= nil then
          v.texture = Controller:GetServerRoomThumbnail(v.furData)
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        end
      end
    end))
  end
end

function Controller:SetWallLock(sta)
  DataModel.wallLock = sta
  HomeManager:WallFurniture(DataModel.wallLock)
  View.Group_Decorate.Btn_Wall.Img_Selected:SetActive(sta)
end

function Controller:SetFloorLock(sta)
  DataModel.floorLock = sta
  HomeManager:FloorFuniture(DataModel.floorLock)
  View.Group_Decorate.Btn_Floor.Img_Selected:SetActive(sta)
end

function Controller:ShowOrHideAllUI(isShow)
  View.Group_Base.self:SetActive(isShow)
  View.Group_SUI.self:SetActive(isShow)
  View.Btn_ShowUI:SetActive(not isShow)
end

function Controller:InitEnvironment()
  local t = {}
  local isTravel, id = MapDataModel.GetTrainCurPos(t)
  if isTravel then
    local homeLineCA = PlayerData:GetFactoryData(id, "HomeLineFactory")
    if homeLineCA ~= nil then
      HomeSceneManager:InitEnvironment(homeLineCA.sceneGroup)
      HomeSceneManager:LoadOutSceneEffect(PlayerData.TempCache.TrainRoadMsgId or 0)
      return
    end
  else
    HomeSceneManager:InitEnvironment(HomeDataModel.CurShowSceneInfo.sceneGroup)
  end
end

function Controller:DoDecorate(callback)
  local roomJson = HomeManager:GetRoomJson(DataModel.roomIndex)
  if roomJson == DataModel.revertJson then
    callback()
    CommonTips.OpenTips(80600209)
    return
  end
  local roomStr = HomeManager:GetServerRoomJson(DataModel.roomIndex)
  local curTime = TimeUtil:GetServerTimeStamp()
  local duration = curTime - PlayerData.TempCache.BeginDecorateTimeStamp
  local roomId = HomeDataModel.roomID[DataModel.roomIndex + 1]
  local mainUIDataModel = require("UIMainUI/UIMainUIDataModel")
  local serverIdx
  for k, v in pairs(PlayerData:GetHomeInfo().coach) do
    if v.id == roomId then
      serverIdx = HomeManager.camRoom + mainUIDataModel.GetBeforeCantEnterRoomCount(k)
      break
    end
  end
  if not serverIdx then
    return
  end
  Net:SendProto("home.decorate", function(json)
    PlayerData.TempCache.BeginDecorateTimeStamp = curTime
    PlayerData:GetHomeInfo().electric_used = DataModel.powerCostRecordChange
    DataModel.revertJson = roomJson
    local cacheOldUsedFur = {}
    for i, v in ipairs(DataModel.revertData) do
      cacheOldUsedFur[v.ufid] = 0
    end
    DataModel.revertData = Clone(HomeDataModel.roomFurnitureData[DataModel.roomIndex + 1])
    local location = Json.decode(roomStr)
    local u_cid = PlayerData:GetHomeInfo().coach_template[serverIdx + 1]
    PlayerData:GetHomeInfo().coach_store[u_cid].location = location
    local addFurTable = {}
    local serverFurniture = PlayerData:GetHomeInfo().furniture
    for i, v in ipairs(location) do
      serverFurniture[v.id].u_cid = u_cid
      if cacheOldUsedFur[v.id] == nil then
        addFurTable[v.id] = 0
      else
        cacheOldUsedFur[v.id] = nil
      end
    end
    for k, v in pairs(addFurTable) do
      HomeFurnitureCollection.FurDecorate(u_cid, k)
      PlayerData.RefreshFurSkillData(serverFurniture[k])
    end
    for k, v in pairs(cacheOldUsedFur) do
      PlayerData.RefreshFurSkillData(serverFurniture[k], true)
      serverFurniture[k].u_cid = ""
      DataModel.GeneralHandleFurnitureServerData(serverFurniture[k])
      HomeFurnitureCollection.FurRemove(u_cid, k)
    end
    mainUIDataModel.RefreshData(PlayerData.ServerData.user_home_info.coach)
    callback()
    CommonTips.OpenTips(80600209)
  end, roomStr, serverIdx, duration)
end

return Controller
