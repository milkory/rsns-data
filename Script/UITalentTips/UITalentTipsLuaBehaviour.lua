local View = require("UITalentTips/UITalentTipsView")
local DataModel = require("UITalentTips/UITalentTipsDataModel")
local ViewFunction = require("UITalentTips/UITalentTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local list = Json.decode(initParams)
    local Group_Show = View.Group_Show
    Group_Show.Txt_Des:SetText(list.desc)
    Group_Show.Txt_Name:SetText(list.name)
    Group_Show.Img_Icon:SetSprite(list.path)
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
