local View = require("UIRepLevelUp/UIRepLevelUpView")
local DataModel = require("UIRepLevelUp/UIRepLevelUpDataModel")
local ViewFunction = require("UIRepLevelUp/UIRepLevelUpViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local info = Json.decode(initParams)
    local stationCA = PlayerData:GetFactoryData(info.stationId, "HomeStationFactory")
    local name = stationCA.name
    if stationCA.force > 0 then
      local tagCA = PlayerData:GetFactoryData(stationCA.force, "TagFactory")
      name = tagCA.tagName
    end
    View.Group_City.Txt_Name:SetText(name)
    View.Txt_LevelPre:SetText(info.preLevel)
    View.Txt_Level:SetText(info.level)
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
