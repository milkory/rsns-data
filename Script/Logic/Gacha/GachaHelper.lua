local GachaHelper = {}
GachaGV = require("Logic/Gacha/GachaGV")

function GachaHelper.GetNewbiePoolId()
  return 80500008
end

function GachaHelper.GetSeverCardsData()
  if PlayerData.ServerData == nil then
    return nil
  end
  return PlayerData.ServerData.cards
end

function GachaHelper.GetServerCardPoolData(poolId)
  local datas = GachaHelper.GetSeverCardsData()
  if datas == nil then
    return nil
  end
  local strPoolId = poolId
  if type(poolId) ~= "string" then
    strPoolId = tostring(poolId)
  end
  return datas[strPoolId]
end

function GachaHelper.GetPoolCloseNum(id)
  local cfg = PlayerData:GetFactoryData(id)
  if cfg == nil then
    return -1
  end
  return cfg.closeNum or 0
end

function GachaHelper.GetPoolNowNum(poolId)
  local data = GachaHelper.GetServerCardPoolData(poolId)
  if data == nil then
    return 0
  end
  return data.pool_num or 0
end

function GachaHelper.GetPoolLeftNum(id)
  local closeNum = GachaHelper.GetPoolCloseNum(id)
  if closeNum == nil then
    return -1
  end
  if closeNum == -1 then
    return -1
  end
  local num = GachaHelper.GetPoolNowNum(id)
  return closeNum - num
end

function GachaHelper.GetNewbiePoolLeftNum()
  local poolId = GachaHelper.GetNewbiePoolId()
  return GachaHelper.GetPoolLeftNum(poolId) or 0
end

return GachaHelper
