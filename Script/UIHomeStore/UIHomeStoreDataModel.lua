local DataModel = {
  List = {},
  itemList = {},
  Now_List = {},
  curIndex = 1
}

function DataModel:Clear()
  DataModel.lastElement = nil
  DataModel = {}
end

return DataModel
