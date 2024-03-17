local View = require("UIBargainBuff/UIBargainBuffView")
local DataModel = require("UIBargainBuff/UIBargainBuffDataModel")
local Controller = require("UIBargainBuff/UIBargainBuffController")
local ViewFunction = require("UIBargainBuff/UIBargainBuffViewFunction")
local Luabehaviour = {
  serialize = function()
    if DataModel.Data then
      return Json.encode(DataModel.Data)
    end
  end,
  deserialize = function(initParams)
    DataModel.Data = Json.decode(initParams)
    Controller:Init()
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
