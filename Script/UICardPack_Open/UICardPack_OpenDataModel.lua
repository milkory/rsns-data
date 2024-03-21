local DataModel = {}

function DataModel.Init(data)
  DataModel.cardPackId = data.cardPackId
  DataModel.activityName = data.activityName
  local cfg = PlayerData:GetFactoryData(data.cardPackId)
  DataModel.cardBackBg = cfg.cardBack
  DataModel.cardList = cfg.otherCardList
  DataModel.extraCardId = cfg.topCard
end

function DataModel.CardIsOwn(cardId)
  local isOwn = false
  local cardList = PlayerData.ServerData.books.card_pack or {}
  if cardList[tostring(cardId)] then
    isOwn = true
  end
  return isOwn
end

function DataModel.GetCardPackInfo(cardPackId)
  local ownCount = 0
  local allCount = 0
  local cfg = PlayerData:GetFactoryData(cardPackId)
  for i, v in ipairs(cfg.otherCardList) do
    if DataModel.CardIsOwn(v.id) then
      ownCount = ownCount + 1
    end
    allCount = allCount + 1
  end
  allCount = allCount + 1
  if DataModel.CardIsOwn(cfg.topCard) then
    ownCount = ownCount + 1
  end
  local extraCardStatus = 0
  if 1 < allCount - ownCount then
    extraCardStatus = 0
  elseif allCount - ownCount == 1 then
    extraCardStatus = 1
  else
    extraCardStatus = 2
  end
  local info = {
    ownCount = ownCount,
    allCount = allCount,
    extraCardStatus = extraCardStatus
  }
  return info
end

return DataModel
