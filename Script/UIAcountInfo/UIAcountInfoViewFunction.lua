local View = require("UIAcountInfo/UIAcountInfoView")
local DataModel = require("UIAcountInfo/UIAcountInfoDataModel")
local NewLoginDataModel = require("UINewLogin/UINewLoginDataModel")
local PopTips = function(tipsId, iscontent)
  View.Btn_Tips3:SetActive(true)
  local content = iscontent and tipsId or GetText(tipsId)
  View.Btn_Tips3.Img_BG.Txt_Warm:SetText(content)
  local width = View.Btn_Tips3.Img_BG.Txt_Warm:GetWidth()
  View.Btn_Tips3.Img_BG.Txt_Warm:SetWidth(width)
end
local VaildPhoneID = function(phoneId)
  local isPass, tipId = NewLoginDataModel.ValidatePhoneNumber(phoneId)
  if isPass == false then
    PopTips(tipId)
    return false
  end
  return true
end
local VaildCode = function(codeLength)
  if codeLength ~= 6 then
    PopTips(80601832)
    return false
  end
end
local VaildPassword = function(password)
  local isPass, tipId = NewLoginDataModel.IsPasswordValid(password)
  if isPass == false then
    PopTips(tipId)
    return false
  end
  return true
end
local ViewFunction = {
  AcountInfo_Group_NewLoginAndJoin_Group_Main_Btn_Change_Click = function(btn, str)
    View.Group_NewLoginAndJoin.Group_Change:SetActive(true)
    View.Group_NewLoginAndJoin.Group_Main:SetActive(false)
    DataModel.codeTimer = 0
    View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Get:SetActive(true)
    View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Count:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode:SetBtnInteractable(true)
    View.Group_NewLoginAndJoin.Group_Change.InputField_Code:SetText("")
    View.Group_NewLoginAndJoin.Group_Change.InputField_PassWord:SetText("")
  end,
  AcountInfo_Group_NewLoginAndJoin_Group_Main_Btn_Touchwith_Click = function(btn, str)
    CommonTips.OpenTips("暂无功能")
  end,
  AcountInfo_Group_NewLoginAndJoin_Btn_Close_Click = function(btn, str)
    UIManager:CloseTip("UI/Login/AcountInfo")
  end,
  AcountInfo_Group_NewLoginAndJoin_Group_Change_Btn_Back_Click = function(btn, str)
    View.Group_NewLoginAndJoin.Group_Change:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Main:SetActive(true)
  end,
  AcountInfo_Group_NewLoginAndJoin_Group_Change_Btn_Join_Click = function(btn, str)
    local phoneId = View.Group_NewLoginAndJoin.Group_Change.InputField_Account:GetText()
    if VaildPhoneID(phoneId) == false then
      return
    end
    local codeLength = View.Group_NewLoginAndJoin.Group_Change.InputField_Code:GetLength()
    if VaildCode(codeLength) == false then
      return
    end
    local password = View.Group_NewLoginAndJoin.Group_Change.InputField_PassWord:GetText() or ""
    if VaildPassword(password) == false then
      return
    end
    local changePassword = ProtocolFactory:CreateProtocol(ProtocolType.ChangePassword)
    changePassword.username = phoneId
    changePassword.code = View.Group_NewLoginAndJoin.Group_Change.InputField_Code:GetText()
    changePassword.new_password = password
    changePassword:SetCallback(function(res2)
      local json2 = Json.decode(res2)
      if json2.rc and json2.rc ~= "" then
        PopTips(json2.msg, true)
        return
      end
      CommonTips.OpenTips(80601993)
      UIManager:CloseTip("UI/Login/AcountInfo")
      local accoutInfo = NewLoginDataModel.GetPhoneIDByUsername(phoneId)
      if accoutInfo then
        NewLoginDataModel.SavePhoneIdList(accoutInfo.username, " ", " ", accoutInfo.lastLoginTs)
      end
    end)
    ServerConnectManager:Add(changePassword)
  end,
  AcountInfo_Group_NewLoginAndJoin_Group_Change_Btn_GetCode_Click = function(btn, str)
    local phoneId = View.Group_NewLoginAndJoin.Group_Change.InputField_Account:GetText()
    local isPass, tipId = NewLoginDataModel.ValidatePhoneNumber(phoneId)
    if isPass then
      local getSecurityCode = ProtocolFactory:CreateProtocol(ProtocolType.GetSecurityCode)
      getSecurityCode.phone_number = phoneId
      getSecurityCode:SetCallback(function(res2)
        local json2 = Json.decode(res2)
        if json2.rc and json2.rc ~= "" then
          PopTips(json2.msg, true)
          return
        end
        DataModel.codeTimer = 60
        View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Get:SetActive(false)
        View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Count:SetActive(true)
        View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Count:SetText(60)
        View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode:SetBtnInteractable(false)
        View.timer:Start()
      end)
      ServerConnectManager:Add(getSecurityCode)
    else
      PopTips(tipId)
    end
  end,
  AcountInfo_Btn_Tips3_Click = function(btn, str)
    View.Btn_Tips3:SetActive(false)
  end
}
return ViewFunction
