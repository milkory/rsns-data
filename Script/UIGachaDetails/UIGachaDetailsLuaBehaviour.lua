local View = require("UIGachaDetails/UIGachaDetailsView")
local DataModel = require("UIGachaDetails/UIGachaDetailsDataModel")
local Controller = require("UIGachaDetails/UIGachaDetailsController")
local ViewFunction = require("UIGachaDetails/UIGachaDetailsViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.param)
  end,
  deserialize = function(initParams)
    DataModel.param = Json.decode(initParams)
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
