local View = require("UIStoryFragment/UIStoryFragmentView")
local DataModel = require("UIStoryFragment/UIStoryFragmentDataModel")
local ViewFunction = require("UIStoryFragment/UIStoryFragmentViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.StationId = data.stationId
    DataModel.DialogId = data.dialogId
    DataModel.NpcId = data.npcId
    local NPCDialog = require("Common/NPCDialog")
    NPCDialog.SetNPC(View.Group_NPCPos.Group_NPC, DataModel.NpcId)
    local npcConfig = PlayerData:GetFactoryData(DataModel.NpcId, "NPCFactory")
    local textTable = npcConfig.enterText
    NPCDialog.SetNPCText(View.Group_NPCPos.Group_NPC, textTable, "enterText")
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
