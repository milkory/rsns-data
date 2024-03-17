local View = require("UIPrompt/UIPromptView")
local DataModel = require("UIPrompt/UIPromptDataModel")
local ViewFunction = {
  Prompt_Btn_BG_Click = function(str)
    if DataModel.isBgClick then
      View.self:CloseUI()
    end
  end,
  Prompt_Btn_Confirm_Click = function(str)
    View.self:CloseUI()
    View.self:Confirm()
    PlayerData:ResetCharacterFilter()
    PlayerData:ResetSuaqsFilter()
    PlayerData:ResetDepotFilter()
    if DataModel.checkTipKey ~= nil then
      PlayerData:SetNoPrompt(DataModel.checkTipKey, DataModel.checkTipType, DataModel.isOn)
    end
  end,
  Prompt_Btn_Cancel_Click = function(str)
    View.self:CloseUI()
    View.self:Cancel()
  end,
  Prompt_Group_Tip_Txt_Tip_Btn_Tip_Click = function(btn, str)
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
