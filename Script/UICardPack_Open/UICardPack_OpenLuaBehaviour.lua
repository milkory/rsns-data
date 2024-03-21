local View = require("UICardPack_Open/UICardPack_OpenView")
local DataModel = require("UICardPack_Open/UICardPack_OpenDataModel")
local ViewFunction = require("UICardPack_Open/UICardPack_OpenViewFunction")
local params
local Luabehaviour = {
  serialize = function()
    return params
  end,
  deserialize = function(initParams)
    params = initParams
    local data = Json.decode(initParams)
    DataModel.Init(data)
    local cfg = PlayerData:GetFactoryData(data.cardPackId)
    View.Group_OtherCards.ScrollGrid_CardList.grid.self:SetDataCount(#DataModel.cardList)
    View.Group_OtherCards.ScrollGrid_CardList.grid.self:RefreshAllElement()
    View.Group_BackGround.Img_Left:SetSprite(cfg.leftPage)
    View.Group_BackGround.Img_Middle:SetSprite(cfg.middlePage)
    View.Group_BackGround.Img_Right:SetSprite(cfg.rightPage)
    View.Group_TopCard.Group_CardBackCommon.Img_Back:SetSprite(cfg.topCardBack)
    View.Group_TopCard.Group_CardBackCommon.Img_Tips:SetSprite(cfg.tipsBg)
    View.Group_Decoration.Img_Pic:SetSprite(cfg.pageDeco)
    local nowX = View.Group_Decoration.Img_Pic:GetAnchoredPositionX()
    local nowY = View.Group_Decoration.Img_Pic:GetAnchoredPositionY()
    View.Group_Decoration.Img_Pic:SetLocalPositionX(nowX + cfg.decoX)
    View.Group_Decoration.Img_Pic:SetLocalPositionY(nowY + cfg.decoY)
    View.Group_Cover.Btn_Cover.Img_Cover:SetSprite(cfg.cover)
    local data = DataModel.GetCardPackInfo(DataModel.cardPackId)
    View.Group_TopCard.Btn_Card:SetActive(data.extraCardStatus == 2)
    View.Group_TopCard.Btn_CardGet:SetActive(data.extraCardStatus == 1)
    View.Group_TopCard.Group_CardBackCommon.Img_Tips:SetActive(data.extraCardStatus ~= 2)
    View.Group_TopCard.Txt_Tips:SetActive(data.extraCardStatus == 0)
    local extraCardCfg = PlayerData:GetFactoryData(DataModel.extraCardId)
    View.Group_TopCard.Btn_Card.Img_Card:SetSprite(extraCardCfg.iconPath)
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
