local View = require("UIDatabase/UIDatabaseView")
local DataModel = require("UIDatabase/UIDatabaseDataModel")
local ViewFunction = require("UIDatabase/UIDatabaseViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.initData()
    DataModel.RefreshUI()
    View.Group_Inside:SetActive(false)
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
