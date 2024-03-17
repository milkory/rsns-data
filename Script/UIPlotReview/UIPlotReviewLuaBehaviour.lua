local View = require("UIPlotReview/UIPlotReviewView")
local DataModel = require("UIPlotReview/UIPlotReviewDataModel")
local ViewFunction = require("UIPlotReview/UIPlotReviewViewFunction")
local Controller = require("UIPlotReview/UIPlotReviewController")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      Controller.InitView(Json.decode(initParams))
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
