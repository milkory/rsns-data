local View = require("UISpeedSettlement/UISpeedSettlementView")
local DataModel = require("UISpeedSettlement/UISpeedSettlementDataModel")
local ViewFunction = {
  SpeedSettlement_Btn_Close_Click = function(btn, str)
    UIManager:GoBack(false)
    if DataModel.bgmId and DataModel.bgmId > 0 then
      local sound = SoundManager:CreateSound(DataModel.bgmId)
      if sound ~= nil then
        sound:Play()
      end
    end
    HomeStationStoreManager:AfterStorePlay()
  end
}
return ViewFunction
