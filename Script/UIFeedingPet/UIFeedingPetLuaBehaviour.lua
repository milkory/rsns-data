local View = require("UIFeedingPet/UIFeedingPetView")
local DataModel = require("UIFeedingPet/UIFeedingPetDataModel")
local ViewFunction = require("UIFeedingPet/UIFeedingPetViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    print_r(PlayerData.ServerData.user_home_info)
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
