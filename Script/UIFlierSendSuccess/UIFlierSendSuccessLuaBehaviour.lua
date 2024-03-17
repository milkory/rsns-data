local View = require("UIFlierSendSuccess/UIFlierSendSuccessView")
local DataModel = require("UIFlierSendSuccess/UIFlierSendSuccessDataModel")
local ViewFunction = require("UIFlierSendSuccess/UIFlierSendSuccessViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      DataModel.InitData(initParams)
    end
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
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
