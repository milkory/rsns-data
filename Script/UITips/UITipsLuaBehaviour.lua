local View = require("UITips/UITipsView")
local DataModel = require("UITips/UITipsDataModel")
local ViewFunction = require("UITips/UITipsViewFunction")
local count
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      View.Txt_Tips:SetText(Json.decode(initParams))
    else
      View.Txt_Tips:SetText("")
    end
    count = 0
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    count = count + 1
    if 90 < count then
      UIManager:CloseTip("UI/Common/Tips")
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
