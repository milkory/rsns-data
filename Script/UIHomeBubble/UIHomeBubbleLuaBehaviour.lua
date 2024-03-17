local View = require("UIHomeBubble/UIHomeBubbleView")
local DataModel = require("UIHomeBubble/UIHomeBubbleDataModel")
local Controller = require("UIHomeBubble/UIHomeBubbleController")
local ViewFunction = require("UIHomeBubble/UIHomeBubbleViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil then
      local data = Json.decode(initParams)
      DataModel.curFurUfid = data.ufid
      local t = PlayerData.ServerData.user_home_info.furniture
      local info = t[data.ufid]
      if info == nil then
        return
      end
      DataModel.curFurServerInfo = info
      DataModel.curFurId = info.id
      DataModel.CurHomeFurniture = nil
      DataModel.ListVerticalLayout = View.Group_Panel.Img_Glass.Img_BubbleBG.Group_List.self:GetComponent(typeof(UI.VerticalLayoutGroup))
      Controller:Init()
      local width = View.Group_Panel.self.Rect.rect.width
      local rightBound = width * 0.9
      local delta = data.posX + rightBound - View.gameObject.transform.rect.width * 0.5
      if 0 <= delta then
        data.posX = data.posX - delta
      end
      LayoutRebuilder.ForceRebuildLayoutImmediate(View.Group_Panel.Img_Glass.Rect)
      delta = data.posY + View.Group_Panel.Img_Glass.self.Rect.rect.height * 0.5 - View.gameObject.transform.rect.height * 0.5
      if 0 <= delta then
        data.posY = data.posY - delta - 10
      end
      local vec = Vector2(data.posX, data.posY)
      View.Group_Panel.self:SetAnchoredPosition(vec)
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.UpdateLayout then
      DataModel.ListVerticalLayout.enabled = false
      DataModel.ListVerticalLayout.enabled = true
      DataModel.UpdateLayout = false
    end
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
