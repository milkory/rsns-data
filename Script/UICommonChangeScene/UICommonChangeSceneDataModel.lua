local View = require("UICommonChangeScene/UICommonChangeSceneView")
local DataModel = {}

function DataModel.ShowMask()
  View.self:PlayAnim("ChangeScenesAnime")
end

function DataModel.HideMask()
  View.self:PlayAnim("ChangeScenesAnimeOut")
end

return DataModel
