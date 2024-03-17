local View = require("UICardYard/UICardYardView")
local ViewFunction = require("UICardYard/UICardYardViewFunction")
local DataController = require("UICardYard/UICardYardDataController")
local GridController = require("UICardYard/UICardYardGridController")
local UIController = require("UICardYard/UICardYardUIController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.lastSeletImg = nil
    View.nowSeletImg = nil
    DataController.Deserialize()
    GridController.RefreshGrids()
    UIController.RefreshUI()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    DataController.Destroy()
    View.lastSeletImg = nil
    View.nowSeletImg = nil
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
