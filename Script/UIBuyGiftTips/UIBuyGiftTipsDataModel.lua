local DataModel = {}

function DataModel.PurchaseTypeList(type)
  local id
  if type == "Forever" then
    id = 80600430
  elseif type == "Daily" then
    id = 80600798
  elseif type == "Weekly" then
    id = 80600800
  elseif type == "Monthly" then
    id = 80600801
  end
  return id
end

function DataModel.OpenRewardDetail(index)
  local showList = DataModel.Data.commoditData.showList
  local row = showList[index]
  CommonTips.OpenPreRewardDetailTips(row.id)
end

return DataModel
