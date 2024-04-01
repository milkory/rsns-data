local View = require("UIBlack_tip/UIBlack_tipView")
local DataModel = require("UIBlack_tip/UIBlack_tipDataModel")
local ViewFunction = require("UIBlack_tip/UIBlack_tipViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.openTime = 0
    View.Txt_trainName:SetText(string.format(GetText(80601635), PlayerData:GetHomeInfo().home_name))
    local dt = os.date("*t", TimeUtil:GetServerTimeStamp())
    local hour = dt.hour < 10 and "0" .. dt.hour or dt.hour
    local min = 10 > dt.min and "0" .. dt.min or dt.min
    View.Txt_Time:SetText(hour .. ":" .. min)
    local name = PlayerData:GetFactoryData(PlayerData:GetHomeInfo().station_info.sid).name
    View.Txt_city:SetText(name)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if LoadingManager.autoCloseLoading == true and LoadingManager.loadingPercent >= 1 then
      LoadingManager:CloseLoading()
    end
  end,
  ondestroy = function()
    PlayerData.TempCache.IsBlackOver = true
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
