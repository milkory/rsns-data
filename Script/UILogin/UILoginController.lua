local View = require("UILogin/UILoginView")
local DataModel = require("UILogin/UILoginDataModel")
local Controller = {}
local CtrlAccountDestroy = require("UILogin/Controller/UILogin_AccountDestroyController")
local CtrlQQGroup = require("UILogin/Controller/UILogin_QQGroupController")

function Controller:InitView()
  CtrlAccountDestroy:InitView()
  CtrlQQGroup:InitView()
end

function Controller.Tip1(contentID, yesTxtID, noTxtID, yesFunc, noFunc)
  local tip = View.Group_Tip1
  tip.Txt_Prompt:SetText(GetText(contentID))
  tip.Btn_Confirm.Txt_Confirm:SetText(GetText(yesTxtID))
  tip.Btn_Cancel.Txt_Cancel:SetText(GetText(noTxtID))
  DataModel.yesFunc = yesFunc
  DataModel.noFunc = noFunc
  
  function DataModel.CloseTip()
    tip:SetActive(false)
  end
  
  tip:SetActive(true)
end

function Controller.Tip2(content, yesTxtID, yesFunc)
  local tip = View.Group_Tip2
  tip.Txt_Prompt:SetText(content)
  tip.Btn_Confirm.Txt_Confirm:SetText(GetText(yesTxtID))
  DataModel.yesFunc = yesFunc
  
  function DataModel.CloseTip()
    tip:SetActive(false)
  end
  
  tip:SetActive(true)
end

function Controller.ChangeScene2Main()
  MapNeedleData.SetNeedleData()
  MapNeedleEventData.SetEventData()
  if MapNeedleEventData.IsLoginChangeNeedleEventScene() then
    MapSessionManager:InvokeNeedleEvent(MapNeedleEventData.event)
    return
  end
  local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
  TradeDataModel.Refresh3DTravelInfoNew(EnumDefine.TrainStateEnter.FirstLogin)
  CommonTips.OpenLoadingCB(function()
    CBus:ChangeScene("Main")
  end)
end

function Controller.Enter(username)
  if CBus.currentScene == "Login" then
    View.Btn_Enter.self:SetActive(true)
    local Group_Account = View.Group_Account
    Group_Account.self:SetActive(true)
    Group_Account.Group_Text.Txt_Account:SetText(username)
  end
end

function Controller.SetBtnUserCenterAndServices(active)
  View.Group_Account.Btn_UserCenter:SetActive(active)
  View.Group_Account.Btn_Service:SetActive(active)
end

function Controller:GetPlayerUID()
  return PlayerData:GetUserInfo().uid
end

function Controller.OnBtnAccountUnregister()
  CommonTips.OnPrompt(80602043, 80600068, 80600067, function()
    LoginHelper.RegAccountUnregister()
  end, nil, false)
end

function Controller:OnRecvIndex(json)
  local isFail = json.rc and json.rc ~= ""
  if isFail then
    return
  end
  if json.is_register and json.is_register == 1 then
    SdkHelper.TrackRegister3({
      propertiesDict = nil,
      registerType = SdkConst.default,
      isSuccess = not isFail,
      account = nil
    })
  end
end

function Controller:OnRecvMainIndexCheck(json)
  if json.server_close and json.server_close == 1 then
    CommonTips.OpenTips(json.msg)
    return false
  end
  return true
end

function Controller:OnRecvMainIndex(json)
  local isFailed = json.rc and json.rc ~= ""
  if isFailed then
    return
  end
  local uid = self:GetPlayerUID()
  SdkReporter.TrackEnterGame(uid)
  SdkHelper.TrackLogin3({
    propertiesDict = nil,
    loginType = SdkConst.default,
    isSuccess = not isFailed,
    account = uid
  })
  PayHelper.InitCsMgr()
end

return Controller
