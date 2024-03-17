local View = require("UIFlier/UIFlierView")
local DataModel = require("UIFlier/UIFlierDataModel")
local ViewFunction = require("UIFlier/UIFlierViewFunction")
local Controller = require("UIFlier/UIFlierController")
local Luabehaviour = {
  serialize = function()
    return Json.encode({
      stationId = DataModel.stationId
    })
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      DataModel.SetJsonData(initParams)
      Controller.RefreshOnShow()
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if View.GroupCopyPanel.self.IsActive or View.GroupTopPanel.self.IsActive then
      Controller.TimeRefresh()
    end
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    if View.coroutine then
      View.self:StopC(View.coroutine)
      View.coroutine = nil
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
