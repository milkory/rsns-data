local View = require("UICityMap/UICityMapView")
local DataModel = require("UICityMap/UICityMapDataModel")
local Controller = require("UICityMap/UICityMapController")
local ViewFunction = require("UICityMap/UICityMapViewFunction")
local listenerFunc = function(url)
  if url == "UI/CityMap/CityMap" or url == "UI/Common/Tips" or url == "UI/Common/QuestComplete" then
    return
  end
  for i = 1, DataModel.showCount do
    local element = View.ScrollView_Map.Viewport.Group_BG["Group_Build" .. i]
    if element then
      element.Btn_Build.Group_Anim.Group_Effect.self:SetActive(false)
    end
  end
end
local RefreshSelf = function()
  Controller:Init()
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local t = Json.decode(initParams)
      if t.stationId ~= nil then
        DataModel.StationId = t.stationId
      end
    end
    Controller:PlayBgm()
    View.self:PlayAnim("In")
    Controller:Init()
    Controller:FuncActive()
  end,
  awake = function()
  end,
  start = function()
    View.ScrollView_Map.self:SetContentAncoredPosValueChanged(function(pos)
      View.ScrollView_Map.Img_BG:SetAnchoredPosition(pos)
    end)
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
    ListenerManager.AddListener(ListenerManager.Enum.StationStateChange, RefreshSelf)
    ListenerManager.AddListener(ListenerManager.Enum.CompleteQuest, RefreshSelf)
  end,
  disenable = function()
    ListenerManager.RemoveListener(ListenerManager.Enum.StationStateChange, RefreshSelf)
    ListenerManager.RemoveListener(ListenerManager.Enum.CompleteQuest, RefreshSelf)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
