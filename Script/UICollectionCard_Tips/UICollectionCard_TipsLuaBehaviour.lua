local View = require("UICollectionCard_Tips/UICollectionCard_TipsView")
local DataModel = require("UICollectionCard_Tips/UICollectionCard_TipsDataModel")
local ViewFunction = require("UICollectionCard_Tips/UICollectionCard_TipsViewFunction")
local params
local Luabehaviour = {
  serialize = function()
    return params
  end,
  deserialize = function(initParams)
    params = initParams
    local cardId = Json.decode(initParams).cardId
    local cfg = PlayerData:GetFactoryData(cardId)
    View.Img_Card:SetSprite(cfg.iconPath)
    View.Group_Left.Txt_Name:SetText(cfg.name)
    View.Group_Left.Txt_NameEnglish:SetText(cfg.englishName)
    local info = View.Group_Left.ScrollView_Content.Viewport.Content
    local getTime = PlayerData.ServerData.books.card_pack[tostring(cardId)].obtain_time
    local date = os.date("%Y.%m.%d", getTime)
    info.Group_Time.Txt_Content:SetText(date)
    info.Group_Description.Txt_Content:SetText(cfg.des)
    info.Group_Way.Txt_Content:SetText(cfg.getMethod)
    local tagCfg = PlayerData:GetFactoryData(cfg.cardTypeId)
    info.Group_CardType.Img_TypeIcon:SetSprite(tagCfg.icon)
    info.Group_CardType.Txt_TypeName:SetText(tagCfg.cardTypeName)
    local packCfg = PlayerData:GetFactoryData(cfg.correspondingPack)
    View.Group_Left.Img_Banner:SetSprite(packCfg.banner)
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
