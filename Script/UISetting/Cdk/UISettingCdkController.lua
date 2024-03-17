local View = require("UISetting/UISettingView")
local UISettingCdkController = {}

function UISettingCdkController:Init()
  local sw = GameSetting.SWCdKey
  if sw ~= nil then
    self:SetFuncActive(sw)
  end
  self:CleanInput()
  self:SetActiveNoticeTip(false)
end

function UISettingCdkController:SetFuncActive(active)
  View.Group_Cdk.Img_Bg:SetActive(active)
  View.Group_Cdk.Img_Dot:SetActive(active)
  View.Group_Cdk.Txt_Title:SetActive(active)
  View.Group_Cdk.Img_Input:SetActive(active)
  View.Group_Cdk.Btn_Convert:SetActive(active)
  View.Group_Cdk.Img_EnglishBg:SetActive(active)
end

function UISettingCdkController:CleanInput()
  View.Group_Cdk.Img_Input.InputField_Cdk:SetText("")
end

function UISettingCdkController:Convert()
  local numberStr = View.Group_Cdk.Img_Input.InputField_Cdk:GetText()
  if numberStr == nil or numberStr == "" then
    self:Tip(GetText(80602049))
    return
  end
  local success = function(json)
    self:OnGetCdkRewards(json, numberStr)
  end
  local fail = function(json)
    self:OnGetCdkRewards(json, numberStr)
  end
  Net:SendProto("main.use_code", success, numberStr, fail)
end

function UISettingCdkController:Tip(str)
  CommonTips.OpenTips(str, true)
  self:SetActiveNoticeTip(true)
  View.Group_Cdk.Group_Nocite.Txt_Nocite:SetText(str)
end

function UISettingCdkController:OnGetCdkRewards(json, code)
  if json.rc and json.rc ~= "" then
    self:Tip(json.msg)
    return
  end
  SdkReporter.TrackExchangeCode(code)
  self:SetActiveNoticeTip(false)
  CommonTips.OpenShowItem(json.reward)
end

function UISettingCdkController:SetActiveNoticeTip(a)
  View.Group_Cdk.Group_Nocite:SetActive(a)
end

return UISettingCdkController
