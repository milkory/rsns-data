local DataModel = {
  IsBuy = false,
  StationId = 0,
  GoodsInfo = {},
  CurAniFrame = {},
  RecordFrame = 0,
  FrameEnd = false,
  AniFrameFunc = {},
  AniData = {},
  BuyAniFrame = {
    PieInfo = {
      {startFrame = 35, endFrame = 50},
      {startFrame = 35, endFrame = 50},
      {startFrame = 35, endFrame = 50},
      {startFrame = 35, endFrame = 50}
    },
    Rep = {startFrame = 0, endFrame = 50},
    Tax = {startFrame = 0, endFrame = 120},
    Price = {startFrame = 0, endFrame = 120}
  },
  SaleAniFrame = {
    PBProfit = {
      {startFrame = 35, endFrame = 55},
      {startFrame = 40, endFrame = 60},
      {startFrame = 45, endFrame = 65},
      {startFrame = 50, endFrame = 70}
    },
    PBCost = {
      {startFrame = 37, endFrame = 57},
      {startFrame = 42, endFrame = 62},
      {startFrame = 47, endFrame = 67},
      {startFrame = 52, endFrame = 72}
    },
    PieInfo = {
      {startFrame = 50, endFrame = 60},
      {startFrame = 50, endFrame = 60},
      {startFrame = 50, endFrame = 60},
      {startFrame = 50, endFrame = 60}
    },
    Profit = {startFrame = 0, endFrame = 120}
  }
}

function DataModel.ResetAniData()
  DataModel.RecordFrame = 0
  DataModel.FrameEnd = false
  DataModel.CurAniFrame = {}
  DataModel.AniFrameFunc = {}
  DataModel.AniData = {}
end

return DataModel
