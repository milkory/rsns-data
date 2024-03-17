local View = require("UIAttractions/UIAttractionsView")
local DataModel = require("UIAttractions/UIAttractionsDataModel")
local ViewFunction = require("UIAttractions/UIAttractionsViewFunction")
local Controller = require("UIAttractions/UIAttractionsController")
local Luabehaviour = {
  serialize = function()
    local param = {}
    param.index = DataModel.curIdx - 1
    param.id = DataModel.attrictionId
    return Json.encode(param)
  end,
  deserialize = function(initParams)
    local param = Json.decode(initParams)
    Controller.Init(param)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    Controller.Update()
  end,
  ondestroy = function()
    Controller.ClearUseableList()
  end,
  enable = function()
  end,
  disenable = function()
    Controller.ClearUseableList()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
