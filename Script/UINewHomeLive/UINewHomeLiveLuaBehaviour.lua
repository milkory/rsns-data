local View = require("UINewHomeLive/UINewHomeLiveView")
local DataModel = require("UINewHomeLive/UINewHomeLiveDataModel")
local ViewFunction = require("UINewHomeLive/UINewHomeLiveViewFunction")
local Controller = require("UINewHomeLive/UINewHomeLiveController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local data = Json.decode(initParams)
      DataModel.curFurUfid = data.ufid
      local t = PlayerData.ServerData.user_home_info.furniture
      local info = t[data.ufid]
      if info == nil then
        return
      end
      DataModel.curFurId = info.id
    end
    Controller.Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].roles then
      for i, v in pairs(PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid].roles) do
        local ctr = View.Group_Details.Group_Bed["Group_Bed" .. i]
        Controller.RefreshSleep(ctr, v)
      end
    end
    Controller.RefreshCurFurAutoSleep()
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
