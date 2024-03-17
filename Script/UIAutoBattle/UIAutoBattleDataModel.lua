local DataModel = {
  sKeepCardNumMax = 12,
  weightPosX = {
    w1 = -290,
    w2 = -145,
    w3 = 0,
    w4 = 145,
    w5 = 290
  },
  DefaultValue = {
    isLeaderCardOn = true,
    discardType = 1,
    keepCardNum = 0,
    weightRed = 1,
    weightBlue = 2,
    weightYellow = 3,
    weightGreen = 5,
    weightPurple = 4
  },
  CurrentData = {},
  Data = {},
  DataIndex = 1,
  IsAutoBattleOn = false,
  IsChanged = false
}
return DataModel
