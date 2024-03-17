local View = require("UIGachaNew/UIGachaNewView")
local DataModel = require("UIGachaNew/UIGachaNewDataModel")
local ViewFunction = require("UIGachaNew/UIGachaNewViewFunction")
local Controller = require("UIGachaNew/UIGachaNewController")
local Luabehaviour = {
  serialize = function()
    return DataModel.Index
  end,
  deserialize = function(initParams)
    View.Img_Mask:SetActive(false)
    View.self:PlayAnim("In")
    Controller:Init()
    if initParams == nil or tonumber(Json.decode(initParams)) == nil then
      if PlayerData.Last_Gacha_Index ~= nil then
        Controller:RefreshMain(PlayerData.Last_Gacha_Index)
        PlayerData.Last_Gacha_Index = nil
      else
        Controller:RefreshMain(1)
      end
    else
      local index = tonumber(Json.decode(initParams))
      Controller:RefreshMain(index)
    end
    View.NewPage_PoolList.grid.self:LocatElementImmediate(DataModel.Index - 1)
    Controller:PlayAnimeByIndex(DataModel.Index)
    View.Group_BuyItem.self:SetActive(false)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    for i, v in pairs(DataModel.CardPool) do
      if v.detail.timeFunc ~= nil then
        EventManager:RemoveOnSecondEvent(v.detail.timeFunc)
        v.detail.timeFunc = nil
      end
      if v.detail.timeFunc1 ~= nil then
        EventManager:RemoveOnSecondEvent(v.detail.timeFunc1)
        v.detail.timeFunc1 = nil
      end
    end
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
