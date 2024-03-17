local DataModel = {
  CostCache = 0,
  CostId = 0,
  oilOneCostCache = 0,
  oilBuyCount = 0,
  oilRemainBuyCount = 0,
  TagType = {Oil = 1, SpeedChange = 2},
  CurSelectType = 0,
  CacheInstantDivideLine = {}
}

function DataModel.ClearCacheObject()
  local len = #DataModel.CacheInstantDivideLine
  while 0 < len do
    local object = DataModel.CacheInstantDivideLine[len]
    Object.Destroy(object)
    DataModel.CacheInstantDivideLine[len] = nil
    len = len - 1
  end
end

return DataModel
