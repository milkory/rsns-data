local View = require("UIWaiting/UIWaitingView")
local DataModel = require("UIWaiting/UIWaitingDataModel")
local ViewFunction = require("UIWaiting/UIWaitingViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = GetCA(99900001).LoadingTextList
    if data ~= nil and 0 < #data then
      View.Img_Frame.Group_Tip.Txt_Tips:SetText(GetText(data[math.random(1, #data)].textId))
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
