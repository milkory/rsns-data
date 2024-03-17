local View = require("UILanguageOptions/UILanguageOptionsView")
local DataModel = require("UILanguageOptions/UILanguageOptionsDataModel")
local SwitchSoundLanguage = function(selectLanguage)
  local CVList = PlayerData:GetFactoryData(99900012).CVList
  local nowLanguage = PlayerData:GetPlayerPrefs("int", "soundLanguage")
  if nowLanguage ~= selectLanguage then
    nowLanguage = selectLanguage
    PlayerData:SetPlayerPrefs("int", "soundLanguage", nowLanguage)
    SoundManager:SetRoleCVReplacePath(CVList[nowLanguage].replacePath)
  end
  View.Img_Mask.Btn_Chinese.Group_unSelected:SetActive(nowLanguage ~= 1)
  View.Img_Mask.Btn_Chinese.Group_Selected:SetActive(nowLanguage == 1)
  View.Img_Mask.Btn_Japanese.Group_unSelected:SetActive(nowLanguage ~= 2)
  View.Img_Mask.Btn_Japanese.Group_Selected:SetActive(nowLanguage == 2)
end
local ViewFunction = {
  LanguageOptions_Img_Mask_Btn_Chinese_Click = function(btn, str)
    SwitchSoundLanguage(1)
  end,
  LanguageOptions_Img_Mask_Btn_Japanese_Click = function(btn, str)
    SwitchSoundLanguage(2)
  end,
  LanguageOptions_Img_Mask_Btn_Sure_Click = function(btn, str)
    UIManager:GoBack(false)
    View.self:Confirm()
  end
}
return ViewFunction
