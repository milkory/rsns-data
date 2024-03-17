local View = require("UICoreGradeUp/UICoreGradeUpView")
local DataModel = require("UICoreGradeUp/UICoreGradeUpDataModel")
local ViewFunction = require("UICoreGradeUp/UICoreGradeUpViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    View.Img_Bottom:SetSprite(DataModel.prePath .. "bottom_" .. data.coreId)
    View.Img_Icon:SetSprite(DataModel.prePath .. "icon_" .. data.coreId)
    View.Img_Light:SetSprite(DataModel.prePath .. "light_" .. data.coreId)
    View.Img_Frame:SetSprite(DataModel.prePath .. "frame_" .. data.coreId)
    local coreCA = PlayerData:GetFactoryData(data.coreId)
    View.Txt_Name:SetText(GetText(coreCA.name))
    View.Txt_LevelPre:SetText(data.oldLv)
    View.Txt_Level:SetText(data.newLv)
    View.Img_B:SetDynamicGameObject(coreCA.upEffects, 0, 0)
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
