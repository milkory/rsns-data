local View = require("UITenPulls/UITenPullsView")
local DataModel = require("UITenPulls/UITenPullsDataModel")
local ViewFunction = require("UITenPulls/UITenPullsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel:SetData(data)
    DataModel.isShow = true
    local maxLv = 1
    for i, v in pairs(DataModel.Roles) do
      local detail = PlayerData:GetFactoryData(v.ca.id, "UnitFactory")
      if maxLv < detail.qualityInt then
        maxLv = detail.qualityInt
      end
    end
    if maxLv < 4 then
      View.Btn_BG:SetSprite("UI\\Common\\showcharacter_bg")
    else
      View.Btn_BG:SetSprite("UI\\ShowCharacter\\showcharacter_bg2")
    end
    View.StaticGrid_Role.grid.self:SetDataCount(#DataModel.Roles)
    View.StaticGrid_Role.grid.self:RefreshAllElement()
    ViewFunction.PlaySound(6)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
