local View = require("UIHomeElectricUp/UIHomeElectricUpView")
local DataModel = require("UIHomeElectricUp/UIHomeElectricUpDataModel")
local ViewFunction = require("UIHomeElectricUp/UIHomeElectricUpViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local info = Json.decode(initParams)
    local type = DataModel.EnumType[info.type]
    View.Group_ElectricBuyTips.self:SetActive(false)
    View.Group_ElectricUpTips.self:SetActive(false)
    if type ~= nil then
      local uiSoundConfig = PlayerData:GetFactoryData(99900002, "ConfigFactory")
      local sound
      if info.type == 1 then
        sound = SoundManager:CreateSound(uiSoundConfig.electricUp)
      elseif info.type == 2 then
        sound = SoundManager:CreateSound(uiSoundConfig.electricBuy)
      end
      if sound ~= nil then
        sound:Play()
      end
      if View[type].Txt_LevelPre then
        View[type].Txt_LevelPre:SetText(info.level - 1)
      end
      View[type].Txt_Level:SetText(info.level)
      View[type].self:SetActive(true)
      View.self:PlayAnimOnce(DataModel.EnumAnimationName[type], function()
        View[type].self:SetActive(false)
        UIManager:GoBack(false)
      end)
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
