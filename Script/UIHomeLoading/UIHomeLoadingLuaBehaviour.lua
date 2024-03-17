local View = require("UIHomeLoading/UIHomeLoadingView")
local DataModel = require("UIHomeLoading/UIHomeLoadingDataModel")
local ViewFunction = require("UIHomeLoading/UIHomeLoadingViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.fillNum = 0
    View.Group_PB.Img_PB:SetFilledImgAmount(0)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    DataModel.fillNum = LoadingManager.loadingPercent
    View.Group_PB.Img_PB:SetActive(true)
    View.Group_PB.Img_PB:SetFilledImgAmount(DataModel.fillNum)
    if DataModel.fillNum >= 1 then
      local HomeController = require("UIHome/UIHomeController")
      LoadingManager:CloseLoading(function()
      end)
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
