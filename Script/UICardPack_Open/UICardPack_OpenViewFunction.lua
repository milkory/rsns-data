local View = require("UICardPack_Open/UICardPack_OpenView")
local DataModel = require("UICardPack_Open/UICardPack_OpenDataModel")
local ViewFunction = {
  CardPack_Open_Btn_Return_Click = function(btn, str)
    View.self:Confirm()
    View.self:PlayAnim("CardPack_OpenOut", function()
      UIManager:GoBack(false)
    end)
  end,
  CardPack_Open_Group_OtherCards_ScrollGrid_CardList_SetGrid = function(element, elementIndex)
    local cardId = DataModel.cardList[elementIndex].id
    local data = PlayerData:GetFactoryData(cardId)
    element.Btn_Card:SetClickParam(cardId)
    local isOwn = DataModel.CardIsOwn(cardId)
    element.Btn_Card:SetActive(isOwn)
    element.Btn_Back:SetActive(not isOwn)
    if isOwn then
      element.Btn_Card.Img_CardFront:SetSprite(data.iconPath)
    else
      element.Btn_Back.Img_CardBack:SetSprite(DataModel.cardBackBg)
    end
  end,
  CardPack_Open_Group_OtherCards_ScrollGrid_CardList_Group_Item_Btn_Back_Click = function(btn, str)
    local cfg = PlayerData:GetFactoryData(DataModel.cardPackId)
    CommonTips.OpenTips(cfg.clue)
  end,
  CardPack_Open_Group_OtherCards_ScrollGrid_CardList_Group_Item_Btn_Card_Click = function(btn, str)
    local cardId = tonumber(str)
    UIManager:Open("UI/CollectionCard/CollectionCard_Tips", Json.encode({cardId = cardId}))
  end,
  CardPack_Open_Group_TopCard_Btn_CardGet_Click = function(btn, str)
    Net:SendProto("book.top_card", function(json)
      for k, v in pairs(json.act_card or {}) do
        PlayerData.ServerData.books.card_pack[k] = v
      end
      UIManager:Open("UI/CollectionCard/CardDrawing", Json.encode({
        cardId = DataModel.extraCardId
      }), function()
        local data = DataModel.GetCardPackInfo(DataModel.cardPackId)
        View.Group_TopCard.Btn_Card:SetActive(data.extraCardStatus == 2)
        View.Group_TopCard.Btn_CardGet:SetActive(data.extraCardStatus == 1)
        View.Group_TopCard.Group_CardBackCommon.Img_Tips:SetActive(data.extraCardStatus ~= 2)
        View.Group_TopCard.Txt_Tips:SetActive(data.extraCardStatus == 0)
        local extraCardCfg = PlayerData:GetFactoryData(DataModel.extraCardId)
        View.Group_TopCard.Btn_Card.Img_Card:SetSprite(extraCardCfg.iconPath)
      end)
    end, DataModel.cardPackId)
  end,
  CardPack_Open_Group_TopCard_Btn_Card_Click = function(btn, str)
    UIManager:Open("UI/CollectionCard/CollectionCard_Tips", Json.encode({
      cardId = DataModel.extraCardId
    }))
  end
}
return ViewFunction
