local CardPackDataModel = require("UICardPack_Open/UICardPack_OpenDataModel")
local ServerProgressDataModel = require("UIServerProgress/UIServerProgressDataModel")
local PersonalProgressDataModel = require("UIPersonalProgress/UIPersonalProgressDataModel")
local AchievementDataModel = require("UIActivityAchievement/UIActivityAchievementDataModel")
local DataModel = {
  NotJoinReward = {},
  LeftList = {},
  LeftActivityCA = {},
  BlackTeaType = 1,
  BlackTeaTypeList = {
    NotEnabled = 1,
    Finish = 2,
    NotFinish = 3,
    Lock = 4
  },
  CoinId = 11400231,
  ClosePageList = {},
  ActivityCA = {},
  SignInConfig = {},
  CardPackInfo = {},
  ChooseLeftIndex = 1,
  Plot1NowQuestId = nil,
  Plot2NowQuestId = nil,
  Plot1Type = 1,
  Plot2Type = 1,
  PlotType = {
    Enabled = 1,
    NotEnabled = 2,
    Lock = 3,
    AllNotFinish = 4,
    AllFinish = 5,
    Quest = 6
  }
}

function DataModel.GetAchievementRed()
  local typeList = AchievementDataModel.AchieveType
  for k, v in pairs(typeList) do
    if AchievementDataModel.GetRedPointStateByType(v) then
      return true
    end
  end
  return false
end

function DataModel.GetLeftListRedState(type)
  if type == "七日签到" then
    return PlayerData:GetSignInfoRedState()
  end
  if type == "红茶战争" then
    return DataModel.GetAllRedState()
  end
end

function DataModel.GetAllRedState()
  if DataModel.ActivityCA.activityCardPack > 0 then
    DataModel.CardPackInfo = CardPackDataModel.GetCardPackInfo(DataModel.ActivityCA.activityCardPack)
    if DataModel.CardPackInfo.extraCardStatus == 1 then
      return true
    end
  end
  local activeList = PlayerData:GetFactoryData(99900059).activeList
  for k, v in pairs(activeList) do
    if TimeUtil:IsActive(v.startTime, v.endTime) then
      local activeCA = PlayerData:GetFactoryData(v.id)
      local tagCA = PlayerData:GetFactoryData(v.tag)
      if PlayerData.ServerData.all_activities.ing and PlayerData.ServerData.all_activities.ing[tostring(activeCA.id)] == nil then
        return true
      end
    end
  end
  if ServerProgressDataModel.GetRedPointState() then
    return true
  end
  if PersonalProgressDataModel.GetRedPointState() then
    return true
  end
  if DataModel.GetAchievementRed() then
    return true
  end
  return false
end

function DataModel.GetMainAllRedState()
  local ActivityCA = PlayerData:GetFactoryData(99900059).activeList
  DataModel.ActivityCA = {}
  for k, v in pairs(ActivityCA) do
    if TimeUtil:IsActive(v.startTime, v.endTime) then
      local tagCA = PlayerData:GetFactoryData(v.tag)
      local activeCA = PlayerData:GetFactoryData(v.id)
      DataModel.ActivityCA = activeCA
      if DataModel.GetLeftListRedState(tagCA.tagName) then
        return true
      end
    end
  end
  return false
end

return DataModel
