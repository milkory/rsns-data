local View = require("UIFlierCopySuccess/UIFlierCopySuccessView")
local DataModel = require("UIFlierCopySuccess/UIFlierCopySuccessDataModel")
local ViewFunction = require("UIFlierCopySuccess/UIFlierCopySuccessViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local params = Json.decode(initParams)
      View.Group_Item.Txt_Num:SetText(params.num)
      local maxCopyFlierNum = PlayerData:GetFactoryData(99900061, "ConfigFactory").leafletAddMax
      View.Group_Top.Txt_Remain:SetText(string.format("本周剩余加印数量:%d/%d", PlayerData.GetRemainCopyLeafLetNum(), maxCopyFlierNum))
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
