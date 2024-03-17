local View = require("UILanguageOptions/UILanguageOptionsView")
local DataModel = require("UILanguageOptions/UILanguageOptionsDataModel")
local ViewFunction = require("UILanguageOptions/UILanguageOptionsViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local nowLanguage = PlayerData:GetPlayerPrefs("int", "soundLanguage")
    if nowLanguage == 0 then
      nowLanguage = GameSetting.defaultSoundLanguage
    end
    View.Img_Mask.Btn_Chinese.Group_unSelected:SetActive(nowLanguage ~= 1)
    View.Img_Mask.Btn_Chinese.Group_Selected:SetActive(nowLanguage == 1)
    View.Img_Mask.Btn_Japanese.Group_unSelected:SetActive(nowLanguage ~= 2)
    View.Img_Mask.Btn_Japanese.Group_Selected:SetActive(nowLanguage == 2)
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
