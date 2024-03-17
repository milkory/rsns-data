local View = require("UIPromptMax/UIPromptMaxView")
local DataModel = require("UIPromptMax/UIPromptMaxDataModel")
local ViewFunction = require("UIPromptMax/UIPromptMaxViewFunction")
local Timer = require("Common/Timer")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams ~= nil and initParams ~= "" then
      local parms = Json.decode(initParams)
      DataModel.param = CommonTips.parms
      DataModel.isBgClick = parms.isBgClick
      View.Group_Prompt.TextIcon_Prompt:SetActive(false)
      View.Group_Prompt.TextIcon_Prompt:SetText(parms.content)
      View.timer = Timer.New(0.3, function()
        View.Group_Prompt.TextIcon_Prompt:SetActive(true)
        View.timer:Stop()
        View.timer = nil
      end)
      View.timer:Start()
      if parms.yesTxt then
        View.Btn_Confirm.Group_.Txt_Confirm:SetText(parms.yesTxt)
      end
      if parms.noTxt then
        View.Btn_Cancel.Group_.Txt_Cancel:SetText(parms.noTxt)
      end
      View.Group_Tips.self:SetActive(DataModel.isBgClick)
      local checkTipParam = parms.checkTipParam
      local isCheckTip = checkTipParam and checkTipParam.isCheckTip or false
      local Group_Tip = View.Group_Tip
      Group_Tip.self:SetActive(isCheckTip)
      if isCheckTip then
        local checkTipKey = checkTipParam.checkTipKey
        DataModel.checkTipKey = checkTipKey
        local checkTipType = checkTipParam.checkTipType
        local str
        if checkTipType == 1 then
          str = GetText(80601112)
        elseif checkTipType == 2 then
          str = GetText(80601185)
        else
          str = GetText(80601185)
        end
        Group_Tip.Txt_Tip:SetText(str)
        DataModel.checkTipType = checkTipType
        local isOn = PlayerData:GetNoPrompt(checkTipKey, checkTipType)
        Group_Tip.Img_Off:SetActive(not isOn)
        Group_Tip.Img_On:SetActive(isOn)
        DataModel.isOn = isOn
      end
      local isShowDanger = checkTipParam and checkTipParam.showDanger or false
      View.Group_Prompt.Img_Icon:SetActive(isShowDanger)
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if View.timer then
      View.timer:Update()
    end
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
