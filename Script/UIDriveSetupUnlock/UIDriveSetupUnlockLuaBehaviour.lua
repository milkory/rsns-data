local View = require("UIDriveSetupUnlock/UIDriveSetupUnlockView")
local DataModel = require("UIDriveSetupUnlock/UIDriveSetupUnlockDataModel")
local ViewFunction = require("UIDriveSetupUnlock/UIDriveSetupUnlockViewFunction")
local Init = function()
  View.Txt_Des:SetText(GetText(DataModel.TextId))
  View.Img_Icon:SetSprite(DataModel.IconPath)
  View.Group_Cost.StaticGrid_Cost.grid.self:RefreshAllElement()
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local params = Json.decode(initParams)
    DataModel.TextId = tonumber(params.textId)
    DataModel.Cost = params.cost
    DataModel.IconPath = params.iconPath
    DataModel.SetUpType = params.setUpType
    Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
