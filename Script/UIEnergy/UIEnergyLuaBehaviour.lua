local View = require("UIEnergy/UIEnergyView")
local DataModel = require("UIEnergy/UIEnergyDataModel")
local ViewFunction = require("UIEnergy/UIEnergyViewFunction")
local Timer = require("Common/Timer")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel:init()
    ViewFunction.RefreshSelectPanel(DataModel.isClickAccess and 1 or DataModel.SelectType())
    DataModel.isClickAccess = false
    View.Group_Page2:SetActive(false)
    View.timer:Start()
    View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG2.Txt_NextRecoveryTime:SetText(DataModel.FormatTime(DataModel.remain_ts))
    View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG2.Txt_FullRecoveryTime:SetText(DataModel.FormatTime(DataModel.all_remain_ts))
  end,
  awake = function()
    View.timer = Timer.New(1, function()
      if DataModel.remain_ts <= 0 then
        DataModel.ResetTimer()
        local energy_content = string.format("%d/%d", PlayerData:GetUserInfo().energy, PlayerData:GetUserInfo().max_energy)
        View.Group_PickEnergyWay.Group_Energy.Txt_Energy:SetText(energy_content)
        View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG1.Txt_Num:SetText(energy_content)
      end
      DataModel.remain_ts = DataModel.remain_ts - 1
      DataModel.all_remain_ts = DataModel.all_remain_ts - 1
      if 0 <= DataModel.all_remain_ts then
        View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG2.Txt_NextRecoveryTime:SetText(DataModel.FormatTime(DataModel.remain_ts))
        View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG2.Txt_FullRecoveryTime:SetText(DataModel.FormatTime(DataModel.all_remain_ts))
      end
    end)
  end,
  start = function()
    DataModel.start_posx = View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG1.Group_Mask.Rect.sizeDelta.x
    DataModel.now_posx = DataModel.start_posx
  end,
  update = function()
    if DataModel.all_remain_ts >= 0 then
      View.timer:Update()
    end
    if DataModel.now_posx < -DataModel.scroll_content_width then
      DataModel.now_posx = DataModel.start_posx
    end
    DataModel.now_posx = DataModel.now_posx - 0.8
    View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG1.Group_Mask.Txt_Scroll:SetAnchoredPositionX(DataModel.now_posx)
  end,
  ondestroy = function()
    DataModel.start_posx = View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG1.Group_Mask.Rect.sizeDelta.x
    DataModel.now_posx = DataModel.start_posx
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
