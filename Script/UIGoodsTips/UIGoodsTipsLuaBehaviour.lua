local View = require("UIGoodsTips/UIGoodsTipsView")
local DataModel = require("UIGoodsTips/UIGoodsTipsDataModel")
local ViewFunction = require("UIGoodsTips/UIGoodsTipsViewFunction")
local back_params
local Luabehaviour = {
  serialize = function()
    return back_params
  end,
  deserialize = function(initParams)
    back_params = initParams
    local data = Json.decode(initParams)
    DataModel.Id = data.goodsId
    local goodsConfig = PlayerData:GetFactoryData(data.goodsId)
    local rarityPath = UIConfig.TipConfig[goodsConfig.qualityInt + 1]
    local qualityPath = UIConfig.ItemTipQuality[goodsConfig.qualityInt + 1]
    View.Group_Show.Img_speciality:SetActive(goodsConfig.isSpeciality)
    View.Group_Show.Img_Rarity:SetSprite(rarityPath)
    View.Group_Show.Img_Quality:SetSprite(qualityPath)
    View.Group_Show.Img_Icon:SetSprite(goodsConfig.tipsPath)
    View.Group_Show.Txt_Name:SetText(goodsConfig.name)
    View.Group_Show.ScrollView_Describe.Viewport.Txt_Describe:SetText(goodsConfig.des)
    if data.goodsType == 1 then
      View.Group_Show.Group_Num.Txt_Num:SetText(PlayerData:GetGoodsById(data.goodsId).num)
      View.Group_Show.Group_UnitPrice:SetActive(false)
      View.Group_Show.Group_Num:SetActive(true)
    elseif data.goodsType == 2 then
      View.Group_Show.Group_UnitPrice.Txt_Num:SetText(math.floor(PlayerData:GetGoodsById(data.goodsId).avg_price + 0.5))
      View.Group_Show.Group_UnitPrice:SetActive(true)
      View.Group_Show.Group_Num:SetActive(false)
    end
    local getwayList = goodsConfig.Getway
    View.Group_Show.Group_GetWay.Btn_Access:SetActive(next(getwayList or {}))
    View.Group_Show.Group_GetWay.Group_Num.Txt_Num:SetText(PlayerData:GetGoodsById(data.goodsId).num)
    View.Group_Show.Group_GetWay:SetActive(true)
    View.Group_Show.Group_GetWay.Btn_Access.Img_On:SetActive(false)
    View.Group_Show.ScrollView_Describe:SetContentHeight(View.Group_Show.ScrollView_Describe.Viewport.Txt_Describe:GetHeight())
    View.Group_Show.ScrollView_Describe:SetVerticalNormalizedPosition(1)
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
