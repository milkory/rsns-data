local View = require("UIPassenger/UIPassengerView")
local DataModel = require("UIPassenger/UIPassengerDataModel")
local ViewFunction = require("UIPassenger/UIPassengerViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.SetPassengerElement(View.Group_TopRight.Group_PassengerCapacity)
    DataModel.SetPassengerListByDistance()
    View.Group_noPassenger:SetActive(table.count(DataModel.passengerList) == 0)
    View.Group_TopRight.Btn_Star.Img_Select:SetActive(false)
    View.Group_TopRight.Btn_Star.Img_UnSelect:SetActive(true)
    View.Group_TopRight.Btn_Place.Img_Select:SetActive(true)
    View.Group_TopRight.Btn_Place.Img_UnSelect:SetActive(false)
    View.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.passengerList))
    View.ScrollGrid_List.grid.self:RefreshAllElement()
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
