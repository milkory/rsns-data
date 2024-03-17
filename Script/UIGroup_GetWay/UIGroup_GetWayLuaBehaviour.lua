local View = require("UIGroup_GetWay/UIGroup_GetWayView")
local DataModel = require("UIGroup_GetWay/UIGroup_GetWayDataModel")
local ViewFunction = require("UIGroup_GetWay/UIGroup_GetWayViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel:init(initParams)
    View.Img_WayBg.ScrollGrid_.grid.self:SetDataCount(#DataModel.getwayList)
    View.Img_WayBg.ScrollGrid_.grid.self:RefreshAllElement()
    View.Img_WayBg.ScrollGrid_.grid.self:MoveToTop()
    View.Img_WayBg:SetAnchoredPosition(Vector2(DataModel.posX, DataModel.posY))
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
