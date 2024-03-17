local View = require("UITradeHelp/UITradeHelpView")
local DataModel = require("UITradeHelp/UITradeHelpDataModel")
local ViewFunction = require("UITradeHelp/UITradeHelpViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.ScrollView_Help.Viewport.Txt_Help:SetText(GetText(80600777))
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
