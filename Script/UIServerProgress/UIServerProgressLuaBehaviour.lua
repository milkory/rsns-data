local View = require("UIServerProgress/UIServerProgressView")
local DataModel = require("UIServerProgress/UIServerProgressDataModel")
local ViewFunction = require("UIServerProgress/UIServerProgressViewFunction")
local Controller = require("UIActivityMain/BlackTeaActivityController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Net:SendProto("quest.list", function(Json)
      DataModel.InitData()
      Controller.RefreshServerStage()
    end, 6)
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
