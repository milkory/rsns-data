local View = require("UIItemPreTips/UIItemPreTipsView")
local DataModel = require("UIItemPreTips/UIItemPreTipsDataModel")
local ViewFunction = require("UIItemPreTips/UIItemPreTipsViewFunction")
local Init = function()
  local factoryName = DataManager:GetFactoryNameById(DataModel.Id)
  DataModel.ItemInfo = PlayerData:GetGoodsById(DataModel.Id)
  local data = PlayerData:GetFactoryData(DataModel.Id, factoryName)
  DataModel.Data = data
  View.Group_Show.Txt_Name:SetText(data.name)
  View.Group_Show.ScrollView_Describe.Viewport.Group_Describe.self:SetActive(true)
  View.Group_Show.ScrollView_Describe.Viewport.Group_Describe.Txt_Describe:SetText(data.des or data.describe)
  View.Group_Show.ScrollView_Describe:SetVerticalNormalizedPosition(1)
  local txtHeight = View.Group_Show.ScrollView_Describe.Viewport.Group_Describe.Txt_Describe:GetHeight()
  View.Group_Show.ScrollView_Describe:SetContentHeight(txtHeight)
  View.Group_Show.Img_Icon:SetSprite(data.tipsPath)
  if data.qualityInt ~= nil then
    View.Group_Show.Img_Rarity:SetSprite(UIConfig.TipConfig[data.qualityInt + 1])
    View.Group_Show.Img_Quality:SetSprite(UIConfig.ItemTipQuality[data.qualityInt + 1])
  elseif data.rarityInt ~= nil then
    View.Group_Show.Img_Rarity:SetSprite(UIConfig.TipConfig[data.rarityInt + 1])
    View.Group_Show.Img_Quality:SetSprite(UIConfig.ItemTipQuality[data.rarityInt + 1])
  end
  local isShowNum = data.isShowNum
  if isShowNum == nil then
    isShowNum = true
  end
  View.Group_Show.Group_Num.self:SetActive(isShowNum)
  if data.isNotDisplayInBag == true then
    View.Group_Show.Group_Num.self:SetActive(false)
  end
  View.Group_Show.Group_Num.Txt_Num:SetText(DataModel.ItemInfo.num)
  View.Group_Show.ScrollView_Describe.Viewport.Group_Describe.Group_DropList.self:SetActive(false)
  if DataModel.isDrop then
    View.Group_Show.ScrollView_Describe.Viewport.Group_Describe.Group_DropList.self:SetActive(true)
    View.Group_Show.ScrollView_Describe.Viewport.Group_Describe.Group_DropList.StaticGrid_List.grid.self:SetDataCount(table.count(DataModel.Data.dropList))
    View.Group_Show.ScrollView_Describe.Viewport.Group_Describe.Group_DropList.StaticGrid_List.grid.self:RefreshAllElement()
  end
  if DataModel.isShowGetWay then
    local getwayList = PlayerData:GetFactoryData(DataModel.Id).Getway
    View.Group_Show.Btn_Access:SetActive(next(getwayList or {}))
    View.Group_Show.Btn_Access.Img_On:SetActive(false)
  else
    View.Group_Show.Btn_Access:SetActive(false)
  end
end
local Luabehaviour = {
  serialize = function()
    DataModel.Back.type = 1
    return Json.encode(DataModel.Back)
  end,
  deserialize = function(initParams)
    local params = Json.decode(initParams)
    DataModel.Id = tonumber(params.itemId)
    DataModel.Data = PlayerData:GetFactoryData(DataModel.Id, "ItemFactory")
    DataModel.Source = params.type
    DataModel.SaleData = params.saleData or {}
    DataModel.Back = {}
    DataModel.Back.itemId = DataModel.Id
    DataModel.isDrop = false
    DataModel.isShowGetWay = params.isShowGetWay
    if DataModel.Data.dropList and table.count(DataModel.Data.dropList) > 0 then
      DataModel.isDrop = true
    end
    Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
    if DataModel.TimeFunc then
      EventManager:RemoveOnSecondEvent(DataModel.TimeFunc)
      DataModel.TimeFunc = nil
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
