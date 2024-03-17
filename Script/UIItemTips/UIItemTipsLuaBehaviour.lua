local View = require("UIItemTips/UIItemTipsView")
local ViewFunction = require("UIItemTips/UIItemTipsViewFunction")
local DataModel = require("UIItemTips/UIItemTipsDataModel")
local Controller = require("UIItemTips/UIItemTipsController")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.Back)
  end,
  deserialize = function(initParams)
    if initParams == nil or initParams == "" then
      Controller.RefreshMain()
      return
    end
    local params = Json.decode(initParams)
    DataModel.Id = tonumber(params.itemId)
    DataModel.isHomeGoods = params.isHomeGoods
    DataModel.Source = params.type
    DataModel.SaleData = params.saleData or PlayerData:GetSaleItem(DataModel.Id, EnumDefine.Depot.Material)
    DataModel.LimitedTimeData = params.limitedTimeData
    DataModel.Back = {}
    DataModel.Back.itemId = DataModel.Id
    DataModel.Back.type = params.type and params.type or 0
    Controller.RefreshMain()
    local getwayList = PlayerData:GetFactoryData(params.itemId).Getway
    View.Group_Show.Btn_Access:SetActive(next(getwayList or {}))
    View.Group_Show.Btn_Access.Img_On:SetActive(false)
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
