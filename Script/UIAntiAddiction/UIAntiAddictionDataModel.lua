local DataModel = {}
DataModel.IndexAndSelect = {
  [1] = "Group_CheckIn",
  [2] = "Group_CheckInTip",
  [3] = "Group_NoLoginTip",
  [4] = "Group_TimeTip",
  [5] = "Group_TimeUpTip",
  [6] = "Group_TimeOutTip",
  [7] = "Group_NoPayTip",
  [8] = "Group_SinglePayTip",
  [9] = "Group_CumulativePayTip"
}
DataModel.param = {}

function DataModel.GetUserYears()
  return math.random(6, 19)
end

DataModel.grow = 0
return DataModel
