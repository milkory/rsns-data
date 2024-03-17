local Order = {}
local isFinish = false

function Order:OnStart(ca)
  isFinish = false
  local questId = ca.questId
  local findKey = ""
  local quests = PlayerData.ServerData.quests
  for k, v in pairs(quests) do
    if v ~= nil and v[tostring(questId)] ~= nil then
      findKey = k
      break
    end
  end
  Net:SendProto("quest.recv_rewards", function(json)
    PlayerData.ServerData.quests[findKey][tostring(questId)] = nil
    if json.current_quests ~= nil then
      for k, v in pairs(json.current_quests) do
        questCA = PlayerData:GetFactoryData(k, "QuestFactory")
        local serverKey = ""
        if questCA.questType == "Main" then
          serverKey = "mq_quests"
        elseif questCA.questType == "Side" then
          serverKey = "branch_quests"
        end
        if serverKey ~= "" then
          PlayerData.ServerData.quests[serverKey][k] = v
        end
      end
    end
    GuideManager:CompleteQuestCallBack({
      [1] = questId
    })
    QuestTrace.CompleteQuestOne(questId)
    CommonTips.OpenQuestsCompleteTip({
      [1] = questId
    })
    isFinish = true
  end, questId)
end

function Order:IsFinish()
  return isFinish
end

return Order
