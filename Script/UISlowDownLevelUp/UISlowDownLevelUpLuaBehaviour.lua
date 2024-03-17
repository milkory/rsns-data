local View = require("UISlowDownLevelUp/UISlowDownLevelUpView")
local DataModel = require("UISlowDownLevelUp/UISlowDownLevelUpDataModel")
local ViewFunction = require("UISlowDownLevelUp/UISlowDownLevelUpViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local info = Json.decode(initParams)
    View.Group_Down.Img_TextBg.Txt_LvOld:SetText("LV " .. info.oldLv)
    View.Group_Down.Img_TextBg.Txt_LvNew:SetText("LV " .. info.newLv)
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
