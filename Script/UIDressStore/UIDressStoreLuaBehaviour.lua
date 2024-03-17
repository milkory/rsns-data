local View = require("UIDressStore/UIDressStoreView")
local DataModel = require("UIDressStore/UIDressStoreDataModel")
local ViewFunction = require("UIDressStore/UIDressStoreViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      DataModel.SetJsonData(initParams)
    end
    DataModel.InitData()
    DataModel.RefreshOnShow()
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
    if DataModel.sound then
      DataModel.sound:Stop()
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
