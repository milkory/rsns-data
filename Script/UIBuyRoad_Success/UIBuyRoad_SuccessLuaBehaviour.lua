local View = require("UIBuyRoad_Success/UIBuyRoad_SuccessView")
local DataModel = require("UIBuyRoad_Success/UIBuyRoad_SuccessDataModel")
local ViewFunction = require("UIBuyRoad_Success/UIBuyRoad_SuccessViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.Group_Show.SpineNode_Boy:SetActive(PlayerData.ServerData.user_info.gender ~= EnumDefine.Sex.Female)
    View.Group_Show.SpineNode_Girl:SetActive(PlayerData.ServerData.user_info.gender == EnumDefine.Sex.Female)
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
