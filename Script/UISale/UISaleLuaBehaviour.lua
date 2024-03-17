local View = require("UISale/UISaleView")
local DataModel = require("UISale/UISaleDataModel")
local ViewFunction = require("UISale/UISaleViewFunction")
local Controller = require("UISale/UISaleController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.Group_SaleTips.Group_Slider.Slider_Value:SetMinAndMaxValue(0, 100)
    local status = {}
    if initParams ~= nil and initParams ~= "" then
      status = Json.decode(initParams)
      Controller:RefreshGrid(status.Select)
    end
    Controller:OpenSaleTips(false)
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
