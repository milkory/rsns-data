local View = require("UIBarStore/UIBarStoreView")
local DataModel = require("UIBarStore/UIBarStoreDataModel")
local Controller = require("UIBarStore/UIBarStoreController")
local ViewFunction = require("UIBarStore/UIBarStoreViewFunction")
local Luabehaviour = {
  serialize = function()
    local t = {}
    t.stationId = DataModel.StationId
    t.npcId = DataModel.NpcId
    t.bgPath = DataModel.BgPath
    t.noInit = true
    return Json.encode(t)
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local t = Json.decode(initParams)
      DataModel.StationId = t.stationId
      DataModel.NpcId = t.npcId
      DataModel.BgPath = t.bgPath
      DataModel.BgColor = t.bgColor or "FFFFFF"
      DataModel.BgColor = "#" .. DataModel.BgColor
      Controller:Init()
      View.self:PlayAnim("In")
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    Controller:TimeAutoRefresh()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
