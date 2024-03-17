local View = require("UINotice/UINoticeView")
local ViewFunction = require("UINotice/UINoticeViewFunction")
local Controller = require("UINotice/UINoticeController")
local DataModel = require("UINotice/UINoticeDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.IsDestroy = false
    Controller.InitView()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    CoroutineManager:UnReg("notice")
    DataModel.IsDestroy = true
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
