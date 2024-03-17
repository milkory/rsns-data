local View = require("UIUseTips/UIUseTipsView")
local DataModel = require("UIUseTips/UIUseTipsDataModel")
local ViewFunction = require("UIUseTips/UIUseTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil and initParams ~= "" then
      local data = Json.decode(initParams)
      DataModel.Data = data
      DataModel.CA = PlayerData:GetFactoryData(data.id)
      DataModel.ItemInfo = PlayerData:GetGoodsById(data.id)
      DataModel.LimitedTimeData = data.limitedTimeData
      if DataModel.LimitedTimeData then
        DataModel.ItemInfo.num = DataModel.LimitedTimeData.num
      end
      DataModel.isChangeMax = false
      DataModel.ChangeMaxNum = DataModel.ItemInfo.num
      DataModel.ChangeNum = nil
      if DataModel.CA.exchangeList ~= nil and #DataModel.CA.exchangeList > 0 then
        local info = DataModel.CA.exchangeList[1]
        DataModel.ChangeNum = info.num
        local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
        if info.itemId == homeConfig.homeEnergyItemId and 0 < PlayerData:GetGoodsById(homeConfig.homeEnergyItemId).num then
          DataModel.isChangeMax = true
          local maxNum = math.ceil(PlayerData:GetGoodsById(homeConfig.homeEnergyItemId).num / info.num)
          DataModel.ChangeMaxNum = maxNum > DataModel.ChangeMaxNum and DataModel.ChangeMaxNum or maxNum
          DataModel.ChangeNum = info.num
        end
      end
      View.Group_Energy.self:SetActive(false)
      View.Group_Other.self:SetActive(false)
      if DataModel.CA.batchUsetype == "Energy" or DataModel.CA.batchUsetype == "Tired" then
        DataModel.Index = 1
        View.Group_Energy.self:SetActive(true)
        DataModel:OpenEnergyTips(true, DataModel.ItemInfo)
      end
      if DataModel.CA.batchUsetype == "Other" then
        DataModel.Index = 2
        View.Group_Other.self:SetActive(true)
        DataModel:OpenOtherBuyTips(true, DataModel.ItemInfo)
      end
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
