local View = require("UIPassengerReward/UIPassengerRewardView")
local DataModel = require("UIPassengerReward/UIPassengerRewardDataModel")
local ViewFunction = require("UIPassengerReward/UIPassengerRewardViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local info = Json.decode(initParams)
      if info then
        local serverData = info.serverData
        DataModel.psgConsume = serverData.psgConsume
        local endStationId
        for destination, v in pairs(PlayerData:GetHomeInfo().passenger) do
          if not serverData.passenger[destination] then
            DataModel.outPsgDataList = v
            DataModel.destination = destination
            endStationId = destination
            break
          end
        end
        if endStationId then
          local totalWaste = 0
          local psgDataModel = require("UIPassenger/UIPassengerDataModel")
          local config = PlayerData:GetFactoryData(99900061, "ConfigFactory")
          for psgUid, data in pairs(DataModel.outPsgDataList) do
            local psgCA = PlayerData:GetFactoryData(data.id, "PassageFactory")
            local distance = psgDataModel.GetNearestLineDistance(tonumber(data.origin), tonumber(endStationId))
            totalWaste = config.passengeWaste * psgCA.waste * distance * config.runDistance * config.lineWaste + totalWaste
          end
          View.Group_center.Group_upper.Group_title.Group_waste.Img_bg.Txt_num:SetText(math.floor(totalWaste))
        end
        DataModel.RefreshConsume()
        DataModel.RefreshSitNum()
        DataModel.RefreshDetail(false)
        View.RewardGroup.Group_bottom.Group_profit.GroupTicketReward.Txt_RewardNum:SetText(0)
        View.RewardGroup.Group_bottom.Group_profit.GroupOtherReward.Txt_RewardNum:SetText(0)
        View.RewardGroup.Group_bottom.Group_profit.Txt_totalNum:SetText(0)
        DataModel.curFrame = 0
      end
      local sound = SoundManager:CreateSound(30002762)
      if sound ~= nil then
        sound:Play()
      end
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.curFrame >= DataModel.profitFrameStart and DataModel.curFrame <= DataModel.profitFrameEnd then
      local rate = (DataModel.curFrame - DataModel.profitFrameStart) / (DataModel.profitFrameEnd - DataModel.profitFrameStart)
      View.RewardGroup.Group_bottom.Group_profit.GroupTicketReward.Txt_RewardNum:SetText(DataModel.NumThousandsSplit(DataModel.ticketNum * rate))
      View.RewardGroup.Group_bottom.Group_profit.GroupOtherReward.Txt_RewardNum:SetText(DataModel.NumThousandsSplit(DataModel.psgConsumeTotalNum * rate))
      View.RewardGroup.Group_bottom.Group_profit.Txt_totalNum:SetText(DataModel.NumThousandsSplit((DataModel.ticketNum + DataModel.psgConsumeTotalNum) * rate))
    end
    for i, v in ipairs(DataModel.circleAnim) do
      if DataModel.curFrame >= v.frame.frameStart and DataModel.curFrame <= v.frame.frameEnd then
        local rate = (DataModel.curFrame - v.frame.frameStart) / (v.frame.frameEnd - v.frame.frameStart)
        if 1 < i then
          local beforeNum = 0
          for index = 1, i - 1 do
            beforeNum = beforeNum + DataModel.circleAnim[index].num
          end
          v.ctrl:SetFilledImgAmount(beforeNum / DataModel.psgConsumeTotalNum + v.num / DataModel.psgConsumeTotalNum * rate)
        else
          v.ctrl:SetFilledImgAmount(v.num / DataModel.psgConsumeTotalNum * rate)
        end
      end
    end
    DataModel.curFrame = DataModel.curFrame + 1
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
