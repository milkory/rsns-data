local DataModel = {
  Data = {},
  QuestIds = {},
  QuestInfo = {}
}

function DataModel.InitQuestInfo()
  DataModel.QuestInfo = {}
  for k, v in pairs(DataModel.QuestIds) do
    local t = {}
    t.id = v
    local questCA = PlayerData:GetFactoryData(v, "QuestFactory")
    if questCA.client > 0 then
      local photoFactory = PlayerData:GetFactoryData(questCA.client, "ProfilePhotoFactory")
      t.clientImagePath = photoFactory.imagePath
      t.clientName = photoFactory.name
    end
    t.questName = questCA.name
    t.reward = {}
    if questCA.rewardsList ~= nil then
      for k1, v1 in pairs(questCA.rewardsList) do
        table.insert(t.reward, v1)
      end
    end
    if questCA.reputationList ~= nil then
      for k1, v1 in pairs(questCA.reputationList) do
        table.insert(t.reward, v1)
      end
    end
    table.insert(DataModel.QuestInfo, t)
  end
end

return DataModel
