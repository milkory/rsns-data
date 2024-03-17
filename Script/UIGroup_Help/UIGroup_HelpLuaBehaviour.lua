local View = require("UIGroup_Help/UIGroup_HelpView")
local DataModel = require("UIGroup_Help/UIGroup_HelpDataModel")
local ViewFunction = require("UIGroup_Help/UIGroup_HelpViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.initData(data.helpId)
    View.Group_window.Group_title.Txt_title:SetText(DataModel.title)
    View.Group_window.Group_tabList.ScrollGrid_list.grid.self:SetDataCount(#DataModel.helpList)
    View.Group_window.Group_tabList.ScrollGrid_list.grid.self:RefreshAllElement()
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
