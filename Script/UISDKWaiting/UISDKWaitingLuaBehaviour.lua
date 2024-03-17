local View = require("UISDKWaiting/UISDKWaitingView")
local DataModel = require("UISDKWaiting/UISDKWaitingDataModel")
local ViewFunction = require("UISDKWaiting/UISDKWaitingViewFunction")
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
