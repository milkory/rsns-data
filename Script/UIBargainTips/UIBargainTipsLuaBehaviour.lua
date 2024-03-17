local View = require("UIBargainTips/UIBargainTipsView")
local DataModel = require("UIBargainTips/UIBargainTipsDataModel")
local Controller = require("UIBargainTips/UIBargainTipsController")
local ViewFunction = require("UIBargainTips/UIBargainTipsViewFunction")
local Luabehaviour = {
  serialize = function()
    if DataModel.data then
      return Json.encode(DataModel.data)
    end
  end,
  deserialize = function(initParams)
    DataModel.data = Json.decode(initParams)
    Controller:DoSpineAni()
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
