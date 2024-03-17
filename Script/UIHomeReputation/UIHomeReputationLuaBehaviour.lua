local View = require("UIHomeReputation/UIHomeReputationView")
local DataModel = require("UIHomeReputation/UIHomeReputationDataModel")
local Controller = require("UIHomeReputation/UIHomeReputationController")
local ViewFunction = require("UIHomeReputation/UIHomeReputationViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local t = Json.decode(initParams)
      DataModel.StationId = t.stationId
      if t.posX ~= nil and t.posY ~= nil then
        DataModel.PosX = t.posX
        DataModel.PosY = t.posY
      end
    end
    DataModel.InitData()
    Controller:FirstInit()
  end,
  awake = function()
  end,
  start = function()
    Controller:SetScrollViewValueChanged()
  end,
  update = function()
  end,
  ondestroy = function()
    DataModel.PosX = 0
    DataModel.PosY = 0
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
