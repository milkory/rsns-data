local View = require("UIStrike_Tip/UIStrike_TipView")
local DataModel = require("UIStrike_Tip/UIStrike_TipDataModel")
local ViewFunction = require("UIStrike_Tip/UIStrike_TipViewFunction")
local Timer = require("Common/Timer")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local t = Json.decode(initParams)
    print_r(GetText(t.textId), t.textId, t)
    if DataModel.Coroutine then
      View.self:StopC(DataModel.Coroutine)
      DataModel.Coroutine = nil
    end
    if t.textParam then
      if type(t.textParam) == "table" then
        View.Txt_Context:SetText(string.format(GetText(t.textId), table.unpack(t.textParam)))
      else
        View.Txt_Context:SetText(string.format(GetText(t.textId), t.textParam))
      end
    else
      View.Txt_Context:SetText(GetText(t.textId))
    end
    if t.isAutoClose then
      DataModel.Coroutine = View.self:StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(1.5))
        UIManager:CloseTip("UI/MainUI/Strike_Tip")
        if DataModel.Coroutine then
          View.self:StopC(DataModel.Coroutine)
          DataModel.Coroutine = nil
        end
      end))
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
    if DataModel.Coroutine then
      View.self:StopC(DataModel.Coroutine)
      DataModel.Coroutine = nil
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
