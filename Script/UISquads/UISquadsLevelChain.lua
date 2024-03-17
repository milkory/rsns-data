local DataController = require("UISquads/UISquadsDataController")
local SquadController = require("UISquads/Controller_Squad")
local DataModel = require("UISquads/UISquadsDataModel")
local View = require("UISquads/UISquadsView")
local module = {}

function module.LevelChainRefreshAll(level_chainId)
  DataModel.levelChainId = level_chainId
  PlayerData.currentSquad = {}
  local curRoleList = PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list
  for i = 1, 5 do
    local temp = {}
    temp = curRoleList[i]
    if temp ~= nil and temp.id == "" then
      temp.id = nil
    end
    table.insert(PlayerData.currentSquad, temp)
  end
  DataModel.hasLevelRole = false
  DataController:SetSquad(PlayerData.currentSquad, #View.StaticGrid_List.grid)
  View.Group_Tab.self:SetActive(false)
  SquadController.RefreshTab(1)
  View.Group_Detail.self:SetActive(false)
  SquadController.SetStartActive(DataModel.Current)
  SquadController.ShowDetail(DataModel.curSquadIndex)
  SquadController.RefreshRoles()
end

function module.StartDiscover()
  local callback = function()
    PlayerData.ServerData.level_chain.levelIndex = 0
    PlayerData.ServerData.level_chain.levelChainId = tostring(DataModel.levelChainId)
    PlayerData.LevelChain.invokeAnimation = true
    View.self:PlayAnim("Out")
    UIManager:GoBack()
  end
  Net:SendProto("level_chain.open", callback, tostring(DataModel.levelChainId))
end

return module
