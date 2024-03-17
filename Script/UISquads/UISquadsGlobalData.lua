local UISquadsGlobalData = {}
UISquadsGlobalData.SelectSquadIndex = 1

function UISquadsGlobalData:SetSelectSquadIndex(v)
  self.SelectSquadIndex = v
end

function UISquadsGlobalData:GetSelectSquadIndex()
  return self.SelectSquadIndex
end

function UISquadsGlobalData:GetResetSelectSquadIndex()
  local index = self.SelectSquadIndex
  self.SelectSquadIndex = 1
  return index
end

function UISquadsGlobalData:ResetSelectSquadIndex()
  self.SelectSquadIndex = 1
end

return UISquadsGlobalData
