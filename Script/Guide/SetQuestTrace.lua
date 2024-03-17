local module = {}

function module:OnStart(ca)
  local t = {}
  t.id = ca.questId
  t.endTime = -1
  PlayerData:SetQuestTrace({
    [1] = t
  })
end

function module:IsFinish()
  return true
end

return module
