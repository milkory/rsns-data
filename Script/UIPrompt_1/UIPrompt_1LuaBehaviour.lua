local View = require("UIPrompt_1/UIPrompt_1View")
local DataModel = require("UIPrompt_1/UIPrompt_1DataModel")
local ViewFunction = require("UIPrompt_1/UIPrompt_1ViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams == nil then
      UIManager:GoBack(false, 1)
      View.self:Confirm()
      return
    end
    local parms = Json.decode(initParams)
    local baseHeight = 290
    DataModel.param = CommonTips.parms
    local len = string.len(parms.content)
    if 2000 < len then
      parms.content = parms.content:sub(1, 2000)
    end
    View.ScrollView_Prompt.Viewport.Content.Txt_Prompt:SetText(parms.content)
    View.Txt_Prompt:SetText(parms.content)
    local height = View.ScrollView_Prompt.Viewport.Content.Txt_Prompt:GetHeight()
    if baseHeight < height then
      View.ScrollView_Prompt.self:SetActive(true)
      View.ScrollView_Prompt:SetContentHeight(height)
      View.ScrollView_Prompt.Viewport.Content.self:SetLocalPositionY(0)
      View.Txt_Prompt:SetText("")
    else
      View.ScrollView_Prompt.self:SetActive(false)
    end
    if parms.yesTxt then
      View.Btn_Confirm.Txt_Confirm:SetText(parms.yesTxt)
    end
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
