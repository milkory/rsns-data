local View = require("UIBattlePass_Quest/UIBattlePass_QuestView")
local DataModel = require("UIBattlePass_Quest/UIBattlePass_QuestDataModel")
local ViewFunction = require("UIBattlePass_Quest/UIBattlePass_QuestViewFunction")
local PassData = require("UIBattlePass_Quest/UIBattlePass")
local QuestData = require("UIBattlePass_Quest/UIBattleQuest")
local Luabehaviour = {
  serialize = function()
    return Json.encode(DataModel.Serialize())
  end,
  deserialize = function(initParams)
    DataModel.SerializeList = {}
    DataModel.diffTime = -1
    if initParams then
      DataModel.SerializeList = Json.decode(initParams)
    end
    DataModel.isActive = false
    DataModel.Init()
    DataModel.diffTime = TimeUtil:GetFutureTime(1, 0) - TimeUtil:GetServerTimeStamp()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.CA then
      local lastTime = TimeUtil:LastTime(DataModel.CA.PassEndTime)
      local Group_Common = View.Group_Reward_Quest.Group_Common
      if 0 < lastTime then
        DataModel.isActive = true
        local time = TimeUtil:SecondToTable(lastTime)
        if 0 < time.second then
          Group_Common.Group_Left.Txt_LeftTime2a:SetText(string.format(GetText(80600155), time.second))
        end
        if 0 < time.minute then
          Group_Common.Group_Left.Txt_LeftTime2a:SetText(string.format(GetText(80600154), time.minute))
        end
        if 0 < time.hour then
          Group_Common.Group_Left.Txt_LeftTime2a:SetText(string.format(GetText(80600152), time.hour, time.minute))
        end
        if 0 < time.day then
          Group_Common.Group_Left.Txt_LeftTime2a:SetText(string.format(GetText(80600150), time.day, time.hour))
        end
        if View.Group_Pay.self.IsActive then
          local Group_Right = View.Group_Pay.Group_Right
          Group_Right.Group_TimeLeft.Img_TimeLeft.Txt_TimeLeft:SetText(TimeUtil:GetBattlePassTime(time))
        end
      else
        DataModel.isActive = false
        Group_Common.Group_Left.Txt_LeftTime2a:SetText("活动已过期！！！")
      end
    end
    if 0 < DataModel.diffTime then
      DataModel.diffTime = DataModel.diffTime - Time.fixedDeltaTime
      local time = TimeUtil:SecondToTable(DataModel.diffTime)
      View.Group_Reward_Quest.Group_BattlePassQuest.Btn_Bp2.Group_Time.Txt_Time:SetText(string.format(GetText(80600153), time.hour))
    else
      Net:SendProto("quest.list", function(json)
        PlayerData.ServerData.quests = json.quests
        PlayerData.ServerData.liveness_rewards = {}
        DataModel.isActive = false
        DataModel.Init()
        DataModel.diffTime = TimeUtil:GetFutureTime(1, 0) - TimeUtil:GetServerTimeStamp()
      end, EnumDefine.QuestListDefine.BattlePassQuest)
    end
  end,
  ondestroy = function()
    DataModel.Clear()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
