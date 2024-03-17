local View = require("UIGuidance_Tips/UIGuidance_TipsView")
local DataModel = require("UIGuidance_Tips/UIGuidance_TipsDataModel")
local ViewFunction = require("UIGuidance_Tips/UIGuidance_TipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local info = Json.decode(initParams)
    local text = info.text
    if info.textId then
      local idText = PlayerData:GetFactoryData(info.textId, "TextFactory")
      text = idText.text
      if idText.pfp and idText.pfp ~= "" then
        View.Group_Tip.Img_Guide.Img_Head:SetSprite(idText.pfp)
      end
    end
    if text then
      View.Group_Tip.Txt_Context:SetTweenContent(text, nil, 0.02)
    end
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
