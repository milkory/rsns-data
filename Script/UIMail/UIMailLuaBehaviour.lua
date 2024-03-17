local View = require("UIMail/UIMailView")
local DataModel = require("UIMail/UIMailDataModel")
local ViewFunction = require("UIMail/UIMailViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel:RefreshData(1)
    DataModel.ChooseIndex = 1
    DataModel:Init()
    DataModel:CloseMailInfo()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    for k, v in pairs(DataModel.Mails) do
      if v.now_time >= 0 then
        v.now_time = v.now_time - Time.fixedDeltaTime
      end
    end
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
