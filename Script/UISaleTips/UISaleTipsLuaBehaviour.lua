local View = require("UISaleTips/UISaleTipsView")
local DataModel = require("UISaleTips/UISaleTipsDataModel")
local ViewFunction = require("UISaleTips/UISaleTipsViewFunction")
local Controller = require("UISaleTips/UISaleTipsController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil and initParams ~= "" then
      Controller:OpenSaleTips(true, Json.decode(initParams).data)
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
