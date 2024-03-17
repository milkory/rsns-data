local View = require("UIGroup_AreaTip/UIGroup_AreaTipView")
local DataModel = require("UIGroup_AreaTip/UIGroup_AreaTipDataModel")
local ViewFunction = require("UIGroup_AreaTip/UIGroup_AreaTipViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local textId = tonumber(initParams)
    View.Txt_Name:SetText(GetText(textId))
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
