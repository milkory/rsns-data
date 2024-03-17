local View = require("UIDialogTips/UIDialogTipsView")
local DataModel = require("UIDialogTips/UIDialogTipsDataModel")
local Controller = require("UIDialogTips/UIDialogTipsController")
local ViewFunction = require("UIDialogTips/UIDialogTipsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Controller.PopUpTips(Json.decode(initParams))
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.HasOpenOnlyTip then
      DataModel.timer = DataModel.timer + Time.deltaTime
      if DataModel.timer > DataModel.OnlyTipsTime then
        DataModel.HasOpenOnlyTip = false
        View.self:PlayAnim("tipsOut2", function()
          UIManager:CloseTip("UI/Dialog/Tips/DialogTips")
        end)
      end
    end
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    DataModel.HasOpenOnlyTip = false
    DataModel.HasOpenTips = false
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
