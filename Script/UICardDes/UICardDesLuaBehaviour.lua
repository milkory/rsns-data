local View = require("UICardDes/UICardDesView")
local DataModel = require("UICardDes/UICardDesDataModel")
local ViewFunction = require("UICardDes/UICardDesViewFunction")
local tPos
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.data = Json.decode(initParams)
    local pos = {
      [1] = Vector3(-440, -185, 0),
      [2] = Vector3(-286, -106, 0),
      [3] = Vector3(-100, -170, 0),
      [4] = Vector3(-24, -170, 0)
    }
    local tType = DataModel.data.type or 1
    local position = pos[tType]
    tPos = Vector3(position.x + DataModel.data.offsetX, position.y + DataModel.data.offsetY, position.z)
    View.transform.localPosition = tPos
    DataModel:Init()
    if not GuildanceManager.isGuild and tType == 1 then
      local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
      BattleControlManager:Pause(true)
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    View.transform.localPosition = tPos
  end,
  ondestroy = function()
    local tType = DataModel.data.type or 1
    if not GuildanceManager.isGuild and tType == 1 then
      local BattleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
      BattleControlManager:Pause(false)
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
