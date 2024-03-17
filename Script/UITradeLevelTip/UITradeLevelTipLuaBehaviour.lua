local View = require("UITradeLevelTip/UITradeLevelTipView")
local DataModel = require("UITradeLevelTip/UITradeLevelTipDataModel")
local ViewFunction = require("UITradeLevelTip/UITradeLevelTipViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local curTradeLv = PlayerData:GetHomeInfo().trade_lv
    View.Img_PlayerInfo.Group_LV.Txt_Num:SetText(curTradeLv)
    local tradeExpConfig = PlayerData:GetFactoryData(99900016, "ConfigFactory")
    local maxExpLv = tradeExpConfig.levelMax
    local curHadExp = PlayerData:GetHomeInfo().exp
    if curTradeLv <= maxExpLv then
      local maxExp = tradeExpConfig.expList[curTradeLv].needExp
      View.Img_PlayerInfo.Txt_Profit:SetText(curHadExp .. "/" .. maxExp)
      View.Img_PlayerInfo.Img_BP:SetFilledImgAmount(curHadExp / maxExp)
    else
      View.Img_PlayerInfo.Txt_Profit:SetText("-/-")
      View.Img_PlayerInfo.Img_BP:SetFilledImgAmount(1)
    end
    local curTradeInfo = tradeExpConfig.expList[curTradeLv]
    View.Group_Now.Txt_Rise:SetText("+" .. curTradeInfo.riseRange * 100 .. "%")
    View.Group_Now.Txt_Bargain:SetText("+" .. curTradeInfo.bargainRange * 100 .. "%")
    if maxExpLv < curTradeLv + 1 then
      View.Group_Next.Txt_Rise:SetText("-")
      View.Group_Next.Txt_Bargain:SetText("-")
    else
      local nextTradeInfo = tradeExpConfig.expList[curTradeLv + 1]
      View.Group_Next.Txt_Rise:SetText("+" .. nextTradeInfo.riseRange * 100 .. "%")
      View.Group_Next.Txt_Bargain:SetText("+" .. nextTradeInfo.bargainRange * 100 .. "%")
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
