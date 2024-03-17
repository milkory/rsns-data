local View = require("UITrustSettlement/UITrustSettlementView")
local DataModel = require("UITrustSettlement/UITrustSettlementDataModel")
local ViewFunction = require("UITrustSettlement/UITrustSettlementViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local params = Json.decode(initParams)
    DataModel.roleList = params.roleList
    DataModel.curFrame = 0
    DataModel.bgmId = params.bgmId
    DataModel.mealId = params.mealId
    local meal_cfg = PlayerData:GetFactoryData(params.mealId) or {}
    View.Img_Food:SetSprite(meal_cfg.foodSettlementImagePath)
    View.Group_CharacterExp.StaticGrid_Character.self:RefreshAllElement()
    local placeId = HomeStationStoreManager:GetCurStationPlace()
    local stationPlaceCA = PlayerData:GetFactoryData(placeId, "HomeStationPlaceFactory")
    View.Img_BGSettle.self:SetSprite(stationPlaceCA.bgSettlement)
    View.Group_Title.Img_Title:SetSprite(stationPlaceCA.iconSettlement)
    View.Group_Title.Txt_Title:SetText(GetText(stationPlaceCA.textTitle))
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    DataModel.curFrame = DataModel.curFrame + 1
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
