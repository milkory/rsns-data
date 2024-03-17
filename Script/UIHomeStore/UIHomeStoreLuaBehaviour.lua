local View = require("UIHomeStore/UIHomeStoreView")
local DataModel = require("UIHomeStore/UIHomeStoreDataModel")
local ViewFunction = require("UIHomeStore/UIHomeStoreViewFunction")
local Controller = require("UIHomeStore/UIHomeStoreController")
local Luabehaviour = {
  serialize = function()
    local param = {}
    param.index = DataModel.curIndex
    return Json.encode(param)
  end,
  deserialize = function(initParams)
    DataModel.curIndex = 1
    if initParams then
      local json = Json.decode(initParams)
      DataModel.curIndex = json.index
    end
    Controller.InitStore()
    Controller.InitButtomGrid()
    Controller:ChooseTab(DataModel.curIndex)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    DataModel.lastElement = nil
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
