local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = require("UICharacterInfo/DataModel")
local UICache = {}
local UITable
local module = {
  Init = function(self)
    UICache = {}
  end,
  Load = function(self)
    if _Assert(UICache, {
      roleId = DataModel.RoleData.id,
      bklevel = DataModel.RoleData.awakeLevel
    }) and DataModel.InitState == false then
      return
    end
    UITable = View.Group_TabTalent
    local grid = UITable.Group_TTRight.StaticGrid_Awake.grid.self
    grid:RefreshAllElement()
  end
}
return module
