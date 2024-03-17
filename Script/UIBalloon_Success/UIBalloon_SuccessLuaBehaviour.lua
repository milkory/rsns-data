local View = require("UIBalloon_Success/UIBalloon_SuccessView")
local DataModel = require("UIBalloon_Success/UIBalloon_SuccessDataModel")
local ViewFunction = require("UIBalloon_Success/UIBalloon_SuccessViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    View.Group_Show.SpineNode_Boy:SetActive(PlayerData.ServerData.user_info.gender ~= EnumDefine.Sex.Female)
    View.Group_Show.SpineNode_Girl:SetActive(PlayerData.ServerData.user_info.gender == EnumDefine.Sex.Female)
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
    if PlayerData.TempCache.balloonReward then
      CoroutineManager:Reg("UIBalloonSuccess", LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        CommonTips.OpenShowItem(PlayerData.TempCache.balloonReward)
        PlayerData.TempCache.balloonReward = nil
        CoroutineManager:UnReg("UIBalloonSuccess")
      end))
    end
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
