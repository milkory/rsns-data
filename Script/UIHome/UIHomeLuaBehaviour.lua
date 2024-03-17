local View = require("UIHome/UIHomeView")
local ViewFunction = require("UIHome/UIHomeViewFunction")
local Controller = require("UIHome/UIHomeController")
local DataModel = require("UIHome/UIHomeDataModel")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    MainManager:SetTrainViewFilter(30, false)
    Controller.RefreshTrains()
    LoadingManager:CloseLoading()
    DataModel.RefreshData(PlayerData.ServerData.user_home_info.coach)
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      HomeManager:OpenHome(0)
    end))
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
