local View = require("UITradeSettlement/UITradeSettlementView")
local DataModel = require("UITradeSettlement/UITradeSettlementDataModel")
local ViewFunction = {
  TradeSettlement_Btn_Close_Click = function(btn, str)
    UIManager:GoBack(false)
    View.self:Confirm()
  end,
  TradeSettlement_Group_Sell_Btn_Ranking_Click = function(btn, str)
    local t = {}
    t.stationId = DataModel.StationId
    UIManager:Open("UI/RankList/RankList", Json.encode(t))
  end,
  TradeSettlement_Group_Sell_Img_Top3_Img_Goods_StaticGrid_Goods_SetGrid = function(element, elementIndex)
    local info = DataModel.GoodsInfo[elementIndex]
    element:SetActive(info ~= nil)
    if info ~= nil then
      local goodsQuoCA = PlayerData:GetFactoryData(info.id)
      local goodsCA = PlayerData:GetFactoryData(goodsQuoCA.goodsId, "HomeGoodsFactory")
      element.Img_Goods:SetSprite(goodsCA.imagePath)
    end
  end,
  TradeSettlement_Group_Sell_Img_ROI_Btn_ROI_Click = function(btn, str)
    View.Group_Sell.Img_Help:SetActive(true)
  end,
  TradeSettlement_Group_Buy_Img_Top3_Img_Goods_StaticGrid_Goods_SetGrid = function(element, elementIndex)
    local info = DataModel.GoodsInfo[elementIndex]
    element:SetActive(info ~= nil)
    if info ~= nil then
      local goodsQuoCA = PlayerData:GetFactoryData(info.id)
      local goodsCA = PlayerData:GetFactoryData(goodsQuoCA.goodsId, "HomeGoodsFactory")
      element.Img_Goods:SetSprite(goodsCA.imagePath)
    end
  end,
  TradeSettlement_Group_Sell_Img_Help_Btn_Close_Click = function(btn, str)
    View.Group_Sell.Img_Help:SetActive(false)
  end
}
return ViewFunction
