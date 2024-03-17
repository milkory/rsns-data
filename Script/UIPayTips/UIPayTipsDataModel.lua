local DataModel = {}
DataModel.name = ""
DataModel.price = ""

function DataModel:SetData(data)
  if data == nil then
    return
  end
  self.name = data.name
  self.price = data.price
end

function DataModel:GetName()
  return self.name or ""
end

function DataModel:GetPriceStr()
  return self.price or ""
end

return DataModel
