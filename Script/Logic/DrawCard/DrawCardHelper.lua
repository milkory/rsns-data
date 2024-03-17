local DrawCardHelper = {}

function DrawCardHelper.ConvertRewardTableToList(rewardTable)
  local ret = {}
  for key, value in pairs(rewardTable) do
    for k1, v1 in pairs(value) do
      table.insert(ret, k1)
    end
  end
  return ret
end

return DrawCardHelper
