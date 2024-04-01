local DataModel = {
  param = {},
  SelectType = {ViewDetail = 1, GachaRecord = 2},
  curSelect = 0,
  extractCA = nil,
  gachaRecordTable = {},
  maxPageNum = 100000,
  curSelectPage = 0,
  defaultClientPageNum = 5,
  defaultToServerPageNum = 25
}
return DataModel
