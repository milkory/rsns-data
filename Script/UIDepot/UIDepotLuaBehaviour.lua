local View = require("UIDepot/UIDepotView")
local DataModel = require("UIDepot/UIDepotDataModel")
local ViewFunction = require("UIDepot/UIDepotViewFunction")
local Controller = require("UIDepot/UIDepotController")
local Luabehaviour = {
  serialize = function()
    return DataModel.Index
  end,
  deserialize = function(initParams)
    DataModel.isBack = false
    if initParams ~= nil then
      DataModel.isBack = true
      Controller.Init()
      DataModel:Reset()
      DataModel:InitRoleTrustData()
      Controller:ChangeTab(tonumber(initParams), true)
      UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Filter")
      local StaticGrid_Type = View.Group_Filter.Group_Type.StaticGrid_Type.grid.self
      StaticGrid_Type:SetDataCount(#DataModel.EquipType)
      StaticGrid_Type:RefreshAllElement()
      local StaticGrid_Rarity = View.Group_Filter.Group_Rarity.StaticGrid_Rarity.grid.self
      StaticGrid_Rarity:SetDataCount(#PlayerData:GetFactoryData(99900017, "ConfigFactory").commonRareList)
      StaticGrid_Rarity:RefreshAllElement()
      return
    end
    View.self:PlayAnim("In", function()
      View.self:SetEnableAnimator(false)
    end)
    Controller.Init()
    DataModel:Reset()
    if PlayerData.DepotSort == nil then
      PlayerData.DepotSort = EnumDefine.Sort.Level
    end
    DataModel.Sort = PlayerData.DepotSort
    UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_TopRight")
    Controller:SortRefresh()
    UIManager:LoadSplitPrefab(View, "UI/Depot/Depot", "Group_Filter")
    local StaticGrid_Type = View.Group_Filter.Group_Type.StaticGrid_Type.grid.self
    StaticGrid_Type:SetDataCount(#DataModel.EquipType)
    StaticGrid_Type:RefreshAllElement()
    local StaticGrid_Rarity = View.Group_Filter.Group_Rarity.StaticGrid_Rarity.grid.self
    StaticGrid_Rarity:SetDataCount(#PlayerData:GetFactoryData(99900017, "ConfigFactory").commonRareList)
    StaticGrid_Rarity:RefreshAllElement()
    if PlayerData.DepotFilter ~= nil then
      for k, v in pairs(PlayerData.DepotFilter) do
        if k == 1 then
          for c, d in pairs(v) do
            if d == true then
              ViewFunction.Depot_Group_Filter_Group_Type_StaticGrid_Type_Group_BtnType_Btn_Type_Click(nil, c)
            end
          end
        end
        if k == 2 then
          for c, d in pairs(v) do
            if d == true then
              ViewFunction.Depot_Group_Filter_Group_Rarity_StaticGrid_Rarity_Group_BtnRarity_Btn_Rarity_Click(nil, c)
            end
          end
        end
        if k == 3 then
          for c, d in pairs(v) do
            if d == true then
              if c == 1 then
                ViewFunction.Depot_Group_Filter_Group_State_Btn_S01_Click(nil, c)
              end
              if c == 2 then
                ViewFunction.Depot_Group_Filter_Group_State_Btn_S02_Click(nil, c)
              end
              if c == 0 then
                ViewFunction.Depot_Group_Filter_Group_State_Btn_All_Click()
              end
            end
          end
        end
      end
    else
      ViewFunction.Depot_Group_Filter_Group_Type_Btn_All_Click()
      ViewFunction.Depot_Group_Filter_Group_Rarity_Btn_All_Click()
      ViewFunction.Depot_Group_Filter_Group_State_Btn_All_Click()
    end
    Controller:ChangeTab(EnumDefine.Depot.Item, true)
    Controller:FilterButtonType()
    DataModel:InitRoleTrustData()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.Index == EnumDefine.Depot.Item then
      local curTime = TimeUtil:GetServerTimeStamp()
      if curTime >= DataModel.NextRefreshLimitedItemTime then
        DataModel:RefreshNextRefreshLimitedItemTime()
        Controller:ChangeTab(EnumDefine.Depot.Item, true)
      end
    end
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
