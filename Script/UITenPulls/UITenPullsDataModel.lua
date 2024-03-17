local DataModel = {
  Roles = {},
  isShow = false,
  Reward = {}
}

function DataModel:SetData(data)
  self.Roles = {}
  for k, v in ipairs(data.cards) do
    table.insert(self.Roles, {
      ca = PlayerData:GetFactoryData(v.id, "UnitFactory"),
      isNew = v.isNew
    })
  end
  if data.reward then
    self.Reward = data.reward
  else
    self.Reward = nil
  end
end

return DataModel
