local View = require("UIEnemy_Detail/UIEnemy_DetailView")
local DataModel = require("UIEnemy_Detail/UIEnemy_DetailDataModel")
local Controller = require("UIEnemy_Detail/UIEnemy_DetailController")
local ViewFunction = require("UIEnemy_Detail/UIEnemy_DetailViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.Content = data.content
    DataModel.IsGoback = data.isGoback or false
    Controller:Init(data.id)
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
