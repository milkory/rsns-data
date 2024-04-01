local View = require("UINewLogin/UINewLoginView")
local DataModel = require("UINewLogin/UINewLoginDataModel")
local LoginController = require("UILogin/UILoginController")
local PopTips = function(tipsId, iscontent)
  View.Btn_Tips3:SetActive(true)
  local content = iscontent and tipsId or GetText(tipsId)
  View.Btn_Tips3.Img_BG.Txt_Warm:SetText(content)
  local width = View.Btn_Tips3.Img_BG.Txt_Warm:GetWidth()
  View.Btn_Tips3.Img_BG.Txt_Warm:SetWidth(width)
end
local ShowLoginPanel = function(isShowGoBack)
  View.Group_NewLoginAndJoin.Group_Switch:SetActive(false)
  View.Group_NewLoginAndJoin.Group_Login:SetActive(true)
  View.Group_NewLoginAndJoin.Group_Login.Btn_Back:SetActive(isShowGoBack)
  View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode.Txt_Get:SetActive(true)
  View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode.Txt_Count:SetActive(false)
  View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode:SetBtnInteractable(true)
  View.Group_NewLoginAndJoin.Group_Login.InputField_Account:SetText("")
  View.Group_NewLoginAndJoin.Group_Login.InputField_PassWord:SetText("")
  View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode.Txt_Count:SetText(60)
  View.Group_NewLoginAndJoin.Group_Toggle:SetAnchoredPositionY(49)
end
local OpenPanel = function(panelType)
  View.Group_NewLoginAndJoin.Group_Login:SetActive(panelType == 1)
  if panelType == 1 then
    View.Group_NewLoginAndJoin.Group_Login.InputField_Account:SetText("")
    View.Group_NewLoginAndJoin.Group_Login.InputField_PassWord:SetText("")
    View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode.Txt_Get:SetActive(true)
    View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode.Txt_Count:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode:SetBtnInteractable(true)
    View.timer:Pause()
  end
  View.Group_NewLoginAndJoin.Group_Switch:SetActive(panelType == 2)
  View.Group_NewLoginAndJoin.Group_Login2:SetActive(panelType == 3)
  if panelType == 3 then
    View.Group_NewLoginAndJoin.Img_BG.Img_BG:SetActive(true)
    View.Group_NewLoginAndJoin.Img_BG.Img_BG2:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Toggle:SetAnchoredPositionY(49)
    View.Group_NewLoginAndJoin.Group_Login2.InputField_Account:SetText("")
    View.Group_NewLoginAndJoin.Group_Login2.InputField_PassWord:SetText("")
  end
  View.Group_NewLoginAndJoin.Group_Join:SetActive(panelType == 4)
  if panelType == 4 then
    View.Group_NewLoginAndJoin.Img_BG.Img_BG:SetActive(false)
    View.Group_NewLoginAndJoin.Img_BG.Img_BG2:SetActive(true)
    View.Group_NewLoginAndJoin.Group_Toggle:SetAnchoredPositionY(-90)
    View.Group_NewLoginAndJoin.Group_Join.InputField_Account:SetText("")
    View.Group_NewLoginAndJoin.Group_Join.InputField_Code:SetText("")
    View.Group_NewLoginAndJoin.Group_Join.InputField_PassWord:SetText("")
    View.Group_NewLoginAndJoin.Group_Join.Btn_GetCode.Txt_Get:SetActive(true)
    View.Group_NewLoginAndJoin.Group_Join.Btn_GetCode.Txt_Count:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Join.Btn_GetCode:SetBtnInteractable(true)
    View.timer:Pause()
  end
  View.Group_NewLoginAndJoin.Group_Change:SetActive(panelType == 5)
  if panelType == 5 then
    View.Group_NewLoginAndJoin.Group_Change.InputField_Account:SetText("")
    View.Group_NewLoginAndJoin.Group_Change.InputField_Code:SetText("")
    View.Group_NewLoginAndJoin.Group_Change.InputField_PassWord:SetText("")
    View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Get:SetActive(true)
    View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode.Txt_Count:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Change.Btn_GetCode:SetBtnInteractable(true)
    View.timer:Pause()
  end
end
local InfoAndIndex = function(username, auto_login)
  local info = ProtocolFactory:CreateProtocol(ProtocolType.Info)
  info.accessToken = PlayerData.access_token
  info.openId = PlayerData.pid
  info:SetCallback(function(res3)
    local json3 = Json.decode(res3)
    print_r(json3)
    local rc = json3.rc
    if rc and rc ~= "" then
      PopTips(json3.msg, true)
      ShowLoginPanel(false)
      View.Group_NewLoginAndJoin.Group_Login.InputField_Account:SetText(username)
      return
    end
    PlayerData.ServerData = {}
    PlayerData.ServerData.server_now = json3.server_now
    local index = ProtocolFactory:CreateProtocol(ProtocolType.Index)
    PlayerData.serverTimeOffset = TimeTool.UnixTimeStamp() - json3.server_now
    index.accessToken = PlayerData.access_token
    index.openId = PlayerData.pid
    index.timestamp = TimeTool.UnixTimeStamp() - PlayerData.serverTimeOffset
    index.platform = PlayerData.platform
    index.autoLogin = auto_login
    index.deviceId = DeviceHelper.GetDeviceId()
    index:SetCallback(function(res4)
      local json4 = Json.decode(res4)
      LoginController:OnRecvIndex(json4)
      rc = json4.rc
      if rc and rc ~= "" then
        PopTips(json4.msg, true)
        ShowLoginPanel(false)
        View.Group_NewLoginAndJoin.Group_Login.InputField_Account:SetText(username)
        return
      end
      local timezone = string.sub(json4.timezone, 4, 6)
      PlayerData.TimeZone = tonumber(timezone)
      PlayerData.RemoteId = json4.remote_id
      DataModel.SavePhoneIdList(username, PlayerData.access_token, PlayerData.pid, TimeUtil.GetServerTimeStamp())
      UIManager:CloseTip("UI/Login/NewLogin")
      View.self:Confirm()
      if GameSetting.AdministrationsAddictionFeature and table.count(json4.real_info) == 0 then
        CommonTips.OpenAntiAddiction({index = 1})
        return
      end
      if PlayerData:GetNoPrompt("logintNotice", 1, false) == false then
        CommonTips.OpenNoticeLogin()
        PlayerData:SetNoPrompt("logintNotice", 1, true, false)
      end
    end)
    ServerConnectManager:Add(index)
  end)
  ServerConnectManager:Add(info)
end
local VaildPhoneID = function(phoneId)
  local isPass, tipId = DataModel.ValidatePhoneNumber(phoneId)
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
  local isPass, tipId = DataModel.IsPasswordValid(password)
  if isPass == false then
    PopTips(tipId)
    return false
  end
  return true
end
local ViewFunction = {
  NewLogin_Group_NewLoginAndJoin_Img_BG_Btn_Cmd_Click = function(btn, str)
  end,
  NewLogin_Group_NewLoginAndJoin_Img_BG_Btn_Visitor_Click = function(btn, str)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_DirectLogin_Btn_Login_Click = function(btn, str)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_DirectLogin_Btn_Switch_Click = function(btn, str)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Login_Btn_Back_Click = function(btn, str)
    View.Group_NewLoginAndJoin.Group_Switch:SetActive(true)
    View.Group_NewLoginAndJoin.Group_Login:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Switch.Btn_off:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Switch.ScrollGrid_AccountList.grid.self:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Toggle:SetAnchoredPositionY(0)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Login_Btn_Join_Click = function(btn, str)
    local phoneId = View.Group_NewLoginAndJoin.Group_Login.InputField_Account:GetText()
    if VaildPhoneID(phoneId) == false then
      return
    end
    local codeLength = View.Group_NewLoginAndJoin.Group_Login.InputField_PassWord:GetLength()
    if VaildCode(codeLength) == false then
      return
    end
    if PlayerPrefs.GetInt("IsAgree") ~= 1 then
      PopTips(80601758)
      return
    end
    local phoneLogin = ProtocolFactory:CreateProtocol(ProtocolType.PhoneLogin)
    phoneLogin.username = phoneId
    phoneLogin.code = View.Group_NewLoginAndJoin.Group_Login.InputField_PassWord:GetText()
    phoneLogin:SetCallback(function(res2)
      local json2 = Json.decode(res2)
      if json2.rc and json2.rc ~= "" then
        PopTips(json2.msg, true)
        return
      end
      PlayerData.access_token = json2.access_token
      PlayerData.pid = json2.openid
      if json2.is_register == 1 then
        UIManager:Open("UI/Setting/LanguageOptions", nil, function()
          InfoAndIndex(phoneId, 0)
        end)
        return
      end
      InfoAndIndex(phoneId, 0)
    end)
    ServerConnectManager:Add(phoneLogin)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Login_Btn_GetCode_Click = function(btn, str)
    local phoneId = View.Group_NewLoginAndJoin.Group_Login.InputField_Account:GetText()
    local isPass, tipId = DataModel.ValidatePhoneNumber(phoneId)
    if isPass then
      local getSecurityCode = ProtocolFactory:CreateProtocol(ProtocolType.GetSecurityCode)
      getSecurityCode.phone_number = phoneId
      print_r("ProtocolType.GetSecurityCode")
      getSecurityCode:SetCallback(function(res2)
        local json2 = Json.decode(res2)
        if json2.rc and json2.rc ~= "" then
          PopTips(json2.msg, true)
          return
        end
        DataModel.codeTimer = 60
        DataModel.timerType = 1
        View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode.Txt_Get:SetActive(false)
        View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode.Txt_Count:SetActive(true)
        View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode.Txt_Count:SetText(60)
        View.Group_NewLoginAndJoin.Group_Login.Btn_GetCode:SetBtnInteractable(false)
        View.timer:Start()
      end)
      ServerConnectManager:Add(getSecurityCode)
    else
      PopTips(tipId)
    end
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Switch_Btn_Show_Click = function(btn, str)
    View.Group_NewLoginAndJoin.Group_Switch.Btn_off:SetActive(true)
    View.Group_NewLoginAndJoin.Group_Switch.ScrollGrid_AccountList.grid.self:SetActive(true)
    View.Group_NewLoginAndJoin.Group_Switch.ScrollGrid_AccountList.grid.self:SetDataCount(#DataModel.phoneIDList)
    View.Group_NewLoginAndJoin.Group_Switch.ScrollGrid_AccountList.grid.self:RefreshAllElement()
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Switch_Btn_Login_Click = function(btn, str)
    if PlayerPrefs.GetInt("IsAgree") ~= 1 then
      PopTips(80601758)
      return
    end
    local data = DataModel.phoneIDList[DataModel.nowSelectId]
    PlayerData.access_token = data.access_token
    PlayerData.pid = data.openid
    InfoAndIndex(data.username, 1)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Switch_Btn_Switch_Click = function(btn, str)
    ShowLoginPanel(true)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Switch_Btn_off_Click = function(btn, str)
    View.Group_NewLoginAndJoin.Group_Switch.Btn_off:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Switch.ScrollGrid_AccountList.grid.self:SetActive(false)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Switch_ScrollGrid_AccountList_SetGrid = function(element, elementIndex)
    local phoneId = DataModel.FormatPhoneID(DataModel.phoneIDList[elementIndex].username)
    element.Btn_Choose.Txt_Account:SetText(phoneId)
    local severTs = TimeUtil.GetServerTimeStamp()
    local formatTs = DataModel.FormatTime(severTs - DataModel.phoneIDList[elementIndex].lastLoginTs)
    element.Btn_Choose.Group_Time.Txt_Time:SetText(formatTs)
    element.Btn_Choose:SetClickParam(elementIndex)
    element.Btn_Close:SetClickParam(elementIndex)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Switch_ScrollGrid_AccountList_Group_Item_Btn_Choose_Click = function(btn, str)
    DataModel.nowSelectId = tonumber(str)
    View.Group_NewLoginAndJoin.Group_Switch.Btn_off:SetActive(false)
    View.Group_NewLoginAndJoin.Group_Switch.ScrollGrid_AccountList.grid.self:SetActive(false)
    local phoneId = DataModel.FormatPhoneID(DataModel.phoneIDList[DataModel.nowSelectId].username)
    View.Group_NewLoginAndJoin.Group_Switch.Img_Account.Txt_Account:SetText(phoneId)
    local severTs = TimeUtil.GetServerTimeStamp()
    local formatTs = DataModel.FormatTime(severTs - DataModel.phoneIDList[DataModel.nowSelectId].lastLoginTs)
    View.Group_NewLoginAndJoin.Group_Switch.Group_Time.Txt_Time:SetText(formatTs)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Switch_ScrollGrid_AccountList_Group_Item_Btn_Close_Click = function(btn, str)
    DataModel.delId = tonumber(str)
    View.Group_tip4:SetActive(true)
  end,
  NewLogin_Btn_Tips3_Click = function(btn, str)
    View.Btn_Tips3:SetActive(false)
  end,
  NewLogin_Group_tip4_Btn_Cancel_Click = function(btn, str)
    View.Group_tip4:SetActive(false)
  end,
  NewLogin_Group_tip4_Btn_Sure_Click = function(btn, str)
    DataModel.DelPhoneID()
    View.Group_tip4:SetActive(false)
    if next(DataModel.phoneIDList) then
      View.Group_NewLoginAndJoin.Group_Switch.ScrollGrid_AccountList.grid.self:SetDataCount(#DataModel.phoneIDList)
      View.Group_NewLoginAndJoin.Group_Switch.ScrollGrid_AccountList.grid.self:RefreshAllElement()
      local phoneId = DataModel.FormatPhoneID(DataModel.phoneIDList[DataModel.nowSelectId].username)
      View.Group_NewLoginAndJoin.Group_Switch.Img_Account.Txt_Account:SetText(phoneId)
    else
      ShowLoginPanel(false)
    end
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Toggle_Btn_toggle_Click = function(btn, str)
    local param = PlayerPrefs.GetInt("IsAgree") == 1 and 0 or 1
    PlayerPrefs.SetInt("IsAgree", param)
    View.Group_NewLoginAndJoin.Group_Toggle.Btn_toggle.Img_On:SetActive(PlayerPrefs.GetInt("IsAgree") == 1)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Toggle_Group_Text_Btn_UserAgreement_Click = function(btn, str)
    CS.UnityEngine.Application.OpenURL("https://reso.gameduchy.com/lsns/pc/userAgreement.html")
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Toggle_Group_Text_Btn_PrivacyPolicy_Click = function(btn, str)
    CS.UnityEngine.Application.OpenURL("https://reso.gameduchy.com/lsns/pc/policy.html")
  end,
  NewLogin_Group_NewLoginAndJoin_Btn_Close_Click = function(btn, str)
    UIManager:CloseTip("UI/Login/NewLogin")
    View.self:Confirm()
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Login_Btn_Switch_Click = function(btn, str)
    OpenPanel(3)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Login2_Btn_Back_Click = function(btn, str)
    OpenPanel(1)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Login2_Btn_Login_Click = function(btn, str)
    local phoneId = View.Group_NewLoginAndJoin.Group_Login2.InputField_Account:GetText() or ""
    if VaildPhoneID(phoneId) == false then
      return
    end
    local password = View.Group_NewLoginAndJoin.Group_Login2.InputField_PassWord:GetText() or ""
    if VaildPassword(password) == false then
      return
    end
    if PlayerPrefs.GetInt("IsAgree") ~= 1 then
      PopTips(80601758)
      return
    end
    local phoneLogin = ProtocolFactory:CreateProtocol(ProtocolType.PhoneLogin)
    phoneLogin.username = phoneId
    phoneLogin.password = View.Group_NewLoginAndJoin.Group_Login2.InputField_PassWord:GetText()
    phoneLogin:SetCallback(function(res2)
      local json2 = Json.decode(res2)
      if json2.rc and json2.rc ~= "" then
        PopTips(json2.msg, true)
        return
      end
      PlayerData.access_token = json2.access_token
      PlayerData.pid = json2.openid
      InfoAndIndex(phoneId, 0)
    end)
    ServerConnectManager:Add(phoneLogin)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Login2_Btn_ShowandHide_Click = function(btn, str)
    local isShow = View.Group_NewLoginAndJoin.Group_Login2.Btn_ShowandHide.Img_Show.IsActive == false
    View.Group_NewLoginAndJoin.Group_Login2.InputField_PassWord:ShowPassword(isShow)
    View.Group_NewLoginAndJoin.Group_Login2.Btn_ShowandHide.Img_Hide:SetActive(not isShow)
    View.Group_NewLoginAndJoin.Group_Login2.Btn_ShowandHide.Img_Show:SetActive(isShow)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Login2_Btn_Forget_Click = function(btn, str)
    OpenPanel(5)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Login2_Btn_Join_Click = function(btn, str)
    OpenPanel(4)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Join_Btn_Back_Click = function(btn, str)
    OpenPanel(3)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Join_Btn_Join_Click = function(btn, str)
    local phoneId = View.Group_NewLoginAndJoin.Group_Join.InputField_Account:GetText()
    if VaildPhoneID(phoneId) == false then
      return
    end
    local codeLength = View.Group_NewLoginAndJoin.Group_Join.InputField_Code:GetLength()
    if VaildCode(codeLength) == false then
      return
    end
    local password = View.Group_NewLoginAndJoin.Group_Join.InputField_PassWord:GetText() or ""
    if VaildPassword(password) == false then
      return
    end
    if PlayerPrefs.GetInt("IsAgree") ~= 1 then
      PopTips(80601758)
      return
    end
    local phoneRegister = ProtocolFactory:CreateProtocol(ProtocolType.PhoneRegister)
    phoneRegister.username = phoneId
    phoneRegister.code = View.Group_NewLoginAndJoin.Group_Join.InputField_Code:GetText()
    phoneRegister.password = password
    phoneRegister:SetCallback(function(res2)
      local json2 = Json.decode(res2)
      if json2.rc and json2.rc ~= "" then
        PopTips(json2.msg, true)
        return
      end
      PlayerData.access_token = json2.access_token
      PlayerData.pid = json2.openid
      UIManager:Open("UI/Setting/LanguageOptions", nil, function()
        InfoAndIndex(phoneId, 0)
      end)
    end)
    ServerConnectManager:Add(phoneRegister)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Join_Btn_GetCode_Click = function(btn, str)
    local phoneId = View.Group_NewLoginAndJoin.Group_Join.InputField_Account:GetText()
    local isPass, tipId = DataModel.ValidatePhoneNumber(phoneId)
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
        DataModel.timerType = 2
        View.Group_NewLoginAndJoin.Group_Join.Btn_GetCode.Txt_Get:SetActive(false)
        View.Group_NewLoginAndJoin.Group_Join.Btn_GetCode.Txt_Count:SetActive(true)
        View.Group_NewLoginAndJoin.Group_Join.Btn_GetCode.Txt_Count:SetText(60)
        View.Group_NewLoginAndJoin.Group_Join.Btn_GetCode:SetBtnInteractable(false)
        View.timer:Start()
      end)
      ServerConnectManager:Add(getSecurityCode)
    else
      PopTips(tipId)
    end
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Change_Btn_Back_Click = function(btn, str)
    OpenPanel(3)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Change_Btn_Join_Click = function(btn, str)
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
      OpenPanel(3)
      local accoutInfo = DataModel.GetPhoneIDByUsername(phoneId)
      if accoutInfo then
        if accoutInfo.openid == PlayerData.pid then
          PlayerData.pid = " "
        end
        DataModel.SavePhoneIdList(accoutInfo.username, " ", " ", accoutInfo.lastLoginTs)
      end
    end)
    ServerConnectManager:Add(changePassword)
  end,
  NewLogin_Group_NewLoginAndJoin_Group_Change_Btn_GetCode_Click = function(btn, str)
    local phoneId = View.Group_NewLoginAndJoin.Group_Change.InputField_Account:GetText()
    local isPass, tipId = DataModel.ValidatePhoneNumber(phoneId)
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
        DataModel.timerType = 3
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
  ShowLoginPanel = ShowLoginPanel
}
return ViewFunction
