local View = require("UIMoveEnergy/UIMoveEnergyView")
local ViewFunction = require("UIMoveEnergy/UIMoveEnergyViewFunction")
local Controller = require("UIMoveEnergy/UIMoveEnergyController")
local DataModel = require("UIMoveEnergy/UIMoveEnergyDataModel")
local Timer = require("Common/Timer")
local Luabehaviour = {
  serialize = function()
    local param = {}
    local idList = {}
    for i = 1, #DataModel.itemList do
      idList[i] = DataModel.itemList[i].id
    end
    param.idList = idList
    return Json.encode(param)
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.init()
    Controller:Init(data)
    View.Img_BG.Group_Recovery:SetActive(true)
    View.Img_BG.Group_Recovery.Img_Next.Txt_Time:SetText(DataModel.FormatTime(DataModel.remain_ts))
    View.Img_BG.Group_Recovery.Img_Full.Txt_Time:SetText(DataModel.FormatTime(DataModel.all_remain_ts))
    View.timer:Start()
  end,
  awake = function()
    View.timer = Timer.New(1, function()
      if DataModel.remain_ts <= 0 then
        DataModel.ResetTimer()
        local index, statusInfo = DataModel.GetNowStatus()
        if DataModel.nowstatus ~= index then
          DataModel.nowstatus = index
          View.Img_BG.Img_BGStatement:SetSprite(statusInfo.bg)
          View.Img_BG.Spine_:SetAction(statusInfo.faceSpine, true, true)
          View.Img_BG.Img_Arrow:SetSprite(statusInfo.arrow)
          View.Img_BG.Txt_Statement:SetText(GetText(statusInfo.stateText))
          View.Img_BG.Group_Tip:SetActive(5 <= index)
          for i = 1, 6 do
            View.Img_BG.Img_StatementIcon["Img_" .. i]:SetActive(i == index)
          end
        end
        local nowNum = PlayerData:GetUserInfo().move_energy
        local homeCommon = require("Common/HomeCommon")
        local maxEnergy = homeCommon.GetMaxHomeEnergy()
        View.Img_BG.Txt_Num:SetText(string.format("%d<size=38>/%d</size>", nowNum, maxEnergy))
      end
      DataModel.remain_ts = DataModel.remain_ts - 1
      DataModel.all_remain_ts = DataModel.all_remain_ts - 1
      if 0 <= DataModel.all_remain_ts then
        View.Img_BG.Group_Recovery.Img_Next.Txt_Time:SetText(DataModel.FormatTime(DataModel.remain_ts))
        View.Img_BG.Group_Recovery.Img_Full.Txt_Time:SetText(DataModel.FormatTime(DataModel.all_remain_ts))
      end
    end)
  end,
  start = function()
  end,
  update = function()
    if DataModel.all_remain_ts >= 0 then
      View.timer:Update()
    end
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
