local View = require("UIGacha/UIGachaView")
local DataModel = require("UIGacha/UIGachaDataModel")
local ViewFunction = require("UIGacha/UIGachaViewFunction")
local Controller = require("UIGacha/UIGachaController")
local Luabehaviour = {
  serialize = function()
    return DataModel.Index
  end,
  deserialize = function(initParams)
    View.Img_Mask:SetActive(false)
    View.self:PlayAnim("In")
    Controller:Init()
    if not initParams or initParams == "" then
      Controller:RefreshMain(1)
    else
      local index = tonumber(Json.decode(initParams))
      Controller:RefreshMain(index)
    end
    View.Page_PoolList.grid.self:LocatElementImmediate(DataModel.Index - 1)
    View.R_Particle.self:SetActive(true)
    View.Group_BuyItem.self:SetActive(false)
    View.Group_Sign:SetActive(false)
    if GameSetting.scaleFactor > 0 then
      View.Group_Sign.Group_Show.Img_:SetWidth(Screen.width / GameSetting.scaleFactor)
    end
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
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
