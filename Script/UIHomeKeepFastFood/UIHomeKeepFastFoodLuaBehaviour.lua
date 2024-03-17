local View = require("UIHomeKeepFastFood/UIHomeKeepFastFoodView")
local DataModel = require("UIHomeKeepFastFood/UIHomeKeepFastFoodDataModel")
local ViewFunction = require("UIHomeKeepFastFood/UIHomeKeepFastFoodViewFunction")
local Luabehaviour = {
  serialize = function()
    return DataModel.stationId
  end,
  deserialize = function(initParams)
    DataModel.init(initParams)
    ViewFunction.InitStationPlace()
    local posx = View.Group_PickMeal.Btn_single.CachedTransform.localPosition.x
    View.Group_PickMeal.Img_Picked:SetLocalPositionX(posx)
    View.Group_Single:SetActive(false)
    View.Group_Team:SetActive(false)
    View.Btn_Confirm:SetActive(false)
    View.Group_Top.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
    local refresh_time = PlayerData:GetFactoryData(99900001).dailyRefreshTime
    View.Group_Top.Group_Tips.Txt_Tips:SetText(string.format(GetText(80601052), refresh_time))
    View.Img_TipsUnpicked:SetActive(true)
    View.Img_FrameMemberList:SetActive(false)
    View.Group_Des:SetActive(false)
    View.Group_Des.Img_Tip:SetActive(false)
    View.Btn_TipMask:SetActive(false)
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
