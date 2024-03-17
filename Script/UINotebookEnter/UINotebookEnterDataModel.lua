local View = require("UINotebookEnter/UINotebookEnterView")
local DataModel = {}
DataModel.dataTab = {}

function DataModel.SetJsonData(json)
  if not json then
    return
  end
  local data = Json.decode(json)
  DataModel.dataTab = data.dataTab
end

function DataModel.InitData()
end

function DataModel.RefreshOnShow()
  View.ScrollGrid_.grid.self:SetDataCount(#DataModel.dataTab)
  View.ScrollGrid_.grid.self:RefreshAllElement()
end

return DataModel
