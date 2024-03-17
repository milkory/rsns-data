local View = require("UIHomeFishTank/UIHomeFishTankView")
local DataModel = require("UIHomeFishTank/UIHomeFishTankDataModel")
local Controller = require("UIHomeFishTank/UIHomeFishTankController")
local ViewFunction = require("UIHomeFishTank/UIHomeFishTankViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams == nil then
      return
    end
    local data = Json.decode(initParams)
    View.Group_yugangUI.self:SetActive(not data.onlyShow)
    View.Btn_Setting.self:SetActive(data.onlyShow)
    DataModel.curFurUfid = data.ufid
    DataModel.skinData = nil
    DataModel.changeSkinUId = ""
    if not data.onlyShow then
      local t = PlayerData.ServerData.user_home_info.furniture
      local info = t[data.ufid]
      if info == nil then
        return
      end
      DataModel.curFurId = info.id
      DataModel.InitData()
      Controller:InitUI()
    end
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
