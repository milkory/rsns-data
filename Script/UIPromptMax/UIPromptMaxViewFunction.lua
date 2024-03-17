local View = require("UIPromptMax/UIPromptMaxView")
local DataModel = require("UIPromptMax/UIPromptMaxDataModel")
local ViewFunction = {
  PromptMax_Btn_BG_Click = function(btn, str)
    if DataModel.isBgClick then
      View.self:CloseUI()
    end
  end,
  PromptMax_Btn_Cancel_Click = function(btn, str)
    View.self:CloseUI()
    View.self:Cancel()
  end,
  PromptMax_Btn_Confirm_Click = function(btn, str)
    View.self:CloseUI()
    View.self:Confirm()
    PlayerData:ResetCharacterFilter()
    PlayerData:ResetSuaqsFilter()
    PlayerData:ResetDepotFilter()
    if DataModel.checkTipKey ~= nil then
      PlayerData:SetNoPrompt(DataModel.checkTipKey, DataModel.checkTipType, DataModel.isOn)
    end
  end,
  PromptMax_Group_Tip_Txt_Tip_Btn_Tip_Click = function(btn, str)
    local key = DataModel.checkTipKey
    local checkTipType = DataModel.checkTipType
    local isOn = not DataModel.isOn
    DataModel.isOn = isOn
    local Group_Tip = View.Group_Tip
    Group_Tip.Img_Off:SetActive(not isOn)
    Group_Tip.Img_On:SetActive(isOn)
  end
}
return ViewFunction
