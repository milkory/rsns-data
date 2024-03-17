local View = require("UISquads/UISquadsView")
local StartBattle = require("UISquads/View_StartBattle")
local SquadElement = require("UISquads/Model_Element")
local SquadController = require("UISquads/Controller_Squad")
local DataModel = require("UISquads/UISquadsDataModel")
local DataDetail = require("UISquads/UISquadsDetail")
local DataController = require("UISquads/UISquadsDataController")
local CharacterSelectController = require("UISquads/UISquadsCharacterSelectController")
local CardPollController = require("UISquads/UISquadsCardPoolController")
local SquadLevelChain = require("UISquads/UISquadsLevelChain")
local SelectData = {}

function SelectData:InitEquipPage(data)
  UIManager:LoadSplitPrefab(View, "UI/Squads/Squads", "Group_EquipSelected")
  View.Group_EquipSelected.self:SetActive(true)
  DataModel.SquadEquip = {}
  DataModel.Equipments = {}
  DataModel.SquadEquip.Data = data
  DataModel.SquadEquip.Type = tonumber(data.Type)
  DataModel.SquadEquip.Index = tonumber(data.Index)
  DataModel.SquadEquip.RoleId = tonumber(data.RoleId)
  DataModel.SquadEquip.ResidueNum = tonumber(data.residueNum)
  DataModel.SquadEquip.Effect = data.effect or 1
  DataModel.SquadEquip.IsCompare = data.IsCompare == true
  DataModel.SquadEquip.Squads = data.Squads
  local equips = DataModel:GetEquipmentType(true)
  View.Group_EquipSelected.ScrollGrid_Equipment.grid.self:MoveToTop()
  View.Group_EquipSelected.ScrollGrid_Equipment.grid.self:SetDataCount(#equips)
  View.Group_EquipSelected.ScrollGrid_Equipment.grid.self:RefreshAllElement()
end

function SelectData:AddEquip(equip)
  local Data = DataModel.SquadEquip.Data
  if Data.DefultIndex then
    local obj = "Group_Preset_0" .. Data.DefultIndex
    if equip.eid ~= DataModel.RoleData.equips[Data.DefultIndex][Data.Index] then
      DataModel.RoleData.equips[Data.DefultIndex][Data.Index] = equip.eid
      PlayerData:GetRoleById(DataModel.RoleData.id).equips[Data.DefultIndex][Data.Index] = equip.eid
      View.Group_Preset[obj].Group_Equip.StaticGrid_Equip.grid.self:RefreshAllElement()
    end
  elseif equip.eid ~= DataModel.RoleData.Squads.equips[Data.Index] then
    local equips = PlayerData.ServerData.squad[Data.SquadIndex].role_list[Data.SelectIndex].equips
    equips[Data.Index] = equip.eid
    DataModel.RoleData.Squads.equips[Data.Index] = equip.eid
    View.Group_Detail.Group_Equip.StaticGrid_Equip.grid.self:RefreshAllElement()
  end
  DataModel:SetEquipHaveList()
  View.Group_EquipSelected.self:SetActive(false)
end

function SelectData:RemoveEquip(data)
  print_r(data)
  print_r(" function SelectData:RemoveEquip(data) function SelectData:RemoveEquip(data) function SelectData:RemoveEquip(data)")
  if data.DefultIndex then
    local obj = "Group_Preset_0" .. data.DefultIndex
    DataModel.RoleData.equips[data.DefultIndex][data.Index] = ""
    PlayerData:GetRoleById(DataModel.RoleData.id).equips[data.DefultIndex][data.Index] = ""
    View.Group_Preset[obj].Group_Equip.StaticGrid_Equip.grid.self:RefreshAllElement()
  else
    local equips = PlayerData.ServerData.squad[data.SquadIndex].role_list[data.SelectIndex].equips
    equips[data.Index] = ""
    DataModel.RoleData.Squads.equips[data.Index] = ""
    View.Group_Detail.Group_Equip.StaticGrid_Equip.grid.self:RefreshAllElement()
  end
  DataModel:SetEquipHaveList()
end

return SelectData
