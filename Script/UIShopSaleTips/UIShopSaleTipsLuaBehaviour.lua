local View = require("UIShopSaleTips/UIShopSaleTipsView")
local DataModel = require("UIShopSaleTips/UIShopSaleTipsDataModel")
local Controller = require("UIShopSaleTips/UIShopSaleTipsController")
local ViewFunction = require("UIShopSaleTips/UIShopSaleTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.Data = data.data
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
