local DataModel = {
  isInitialized = false,
  maxCost = false,
  unlimitedLeaderCondition = false,
  refreshCardNoDelay = false,
  totalDamage = 0,
  curSkillDamage = 0,
  largestRecordedSkillDamage = 0,
  usedCost = 0,
  usedCards = 0,
  cardUniqueIds = {},
  perFrameDamageListCount = 600,
  perFrameDamageList = {},
  sum_perFrameDamageList = 0,
  perFrameDamage = 0,
  limitDamage = 100000000
}
DataModel.RecordDetail = {
  duration = 0,
  damageTotal = 0,
  getHitTotal = 0,
  skillDamageNow = 0,
  skillDamageMax = 0,
  damageTotalAt10s = 0,
  usedCards = 0,
  usedCost = 0,
  cardList = {},
  roles = {}
}

function DataModel.InitData()
  DataModel.RecordDetail.duration = 0
  DataModel.RecordDetail.damageTotal = 0
  DataModel.RecordDetail.getHitTotal = 0
  DataModel.RecordDetail.skillDamageNow = 0
  DataModel.RecordDetail.skillDamageMax = 0
  DataModel.RecordDetail.damageTotalAt10s = 0
  DataModel.RecordDetail.usedCards = 0
  DataModel.RecordDetail.usedCost = 0
  DataModel.RecordDetail.cardList = {}
  DataModel.RecordDetail.roles = {}
end

return DataModel
