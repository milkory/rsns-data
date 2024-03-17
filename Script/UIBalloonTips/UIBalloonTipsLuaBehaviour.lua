local View = require("UIBalloonTips/UIBalloonTipsView")
local DataModel = require("UIBalloonTips/UIBalloonTipsDataModel")
local ViewFunction = require("UIBalloonTips/UIBalloonTipsViewFunction")
local CommonItem = require("Common/BtnItem")
local Controller = require("UIBalloonTips/UIBalloonTipsController")
local Luabehaviour = {
  serialize = function()
    DataModel:ResetData()
  end,
  deserialize = function(initParams)
    DataModel:InitData(initParams)
    Controller:InitSlider()
    CommonItem:SetItem(View.Group_Item, {
      id = DataModel.BalloonItemId,
      num = DataModel.ServerNum
    })
    Controller:RefreshShow(true)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
