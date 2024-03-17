local View = require("UIHomeInvest/UIHomeInvestView")
local DataModel = require("UIHomeInvest/UIHomeInvestDataModel")
local Controller = require("UIHomeInvest/UIHomeInvestController")
local ViewFunction = require("UIHomeInvest/UIHomeInvestViewFunction")
local Luabehaviour = {
  serialize = function()
    local t = {}
    t.stationId = DataModel.StationId
    t.npcId = DataModel.NpcId
    t.bgPath = DataModel.BgPath
    t.bgColor = string.sub(DataModel.BgColor, 2)
    return Json.encode(t)
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local info = Json.decode(initParams)
      DataModel.StationId = info.stationId
      DataModel.NpcId = info.npcId
      DataModel.BgPath = info.bgPath
      DataModel.BgColor = info.bgColor or "FFFFFF"
      DataModel.BgColor = "#" .. DataModel.BgColor
      local serverStation = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)]
      DataModel.CurRepLv = serverStation.rep_lv or 0
      Controller:Init()
    end
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
