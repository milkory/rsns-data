local View = require("UIDictionary/UIDictionaryView")
local DataModel = require("UIDictionary/UIDictionaryDataModel")
local ViewFunction = require("UIDictionary/UIDictionaryViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    ViewFunction.SwitchTopTab(3)
    View.Group_Mechanism.ScrollView_:SetVerticalNormalizedPosition(1)
    View.Group_Tab.Btn_Card:SetLocalPositionY(140, 0)
    local data = initParams ~= nil and Json.decode(initParams) or {}
    View.Img_BG.Group_CommonTopLeft.Btn_Home:SetActive(data.hideHomeBtn == nil)
  end,
  awake = function()
    DataModel:init()
    DataModel.tabList = {
      {
        panel = View.Group_Card,
        selectImg = View.Group_Tab.Btn_Card.Img_On
      },
      {
        panel = View.Group_Tag,
        selectImg = View.Group_Tab.Btn_Tag.Img_On
      },
      {
        panel = View.Group_Mechanism,
        selectImg = View.Group_Tab.Btn_Mechanism.Img_On
      }
    }
    DataModel.affixTabList = {
      View.Group_Tag.Btn_Tech,
      View.Group_Tag.Btn_Control,
      View.Group_Tag.Btn_Defence
    }
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
