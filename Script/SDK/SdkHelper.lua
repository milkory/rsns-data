local SdkHelper = {}
SdkConst = require("SDK/Const/SdkConst")
SdkTrackConst = require("SDK/Const/SdkTrackConst")
SdkReporter = require("SDK/SdkReporter")
TrackingIO2Reporter = require("SDK/Track/TrackingIO2Reporter")
JuLiangEngineHelper = require("SDK/Track/JuLiangEngineReporter")
RateHelper = require("SDK/Rate/RateHelper")
DeepLinkMgr = require("SDK/DeepLink/DeepLinkMgr")
SdkHelper.IsNotifyed = false

function SdkHelper.Init()
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.start_menu)
end

function SdkHelper.GetDictStrObj()
  local dict = CsHelper.NewLuaDictStrObj()
  return dict
end

function SdkHelper.ConvertTableToDictStrObj(t)
  local d = SdkHelper.GetDictStrObj()
  if t ~= nil then
    for key, value in pairs(t) do
      d:Add(key, value)
    end
  end
  return d:GetCsDict()
end

function SdkHelper.ConvertTableToListStr(t)
  local d = CsHelper.NewLuaListStr()
  if t ~= nil then
    for key, value in pairs(t) do
      d:Add(value)
    end
  end
  return d:GetCsList()
end

function SdkHelper.ConvertTableToArrayStr(t)
  local d = SdkHelper.ConvertTableToListStr(t)
  return d:ToArray()
end

function SdkHelper.GetSdkLuaface()
  return CS.SdkLuaface
end

function SdkHelper.GetTKIO()
  return CS.TrackingIO2Luaface
end

function SdkHelper.GetStatusFromBool(isSuccess)
  if isSuccess then
    return SdkConst.success
  end
  return SdkConst.failed
end

function SdkHelper.TrackRegister(registerAttributesTable, propertiesDict)
  SdkHelper.GetSdkLuaface().TrackRegister(registerAttributesTable, propertiesDict)
end

function SdkHelper.TrackRegister2(propertiesDict, registerType, isSuccess)
end

function SdkHelper.TrackRegister3(args)
  local bSuccess = args.isSuccess
  local registerStatus = SdkHelper.GetStatusFromBool(args.isSuccess)
  SdkHelper.GetSdkLuaface().TrackRegister(args.propertiesDict, args.registerType, registerStatus)
  TrackingIO2Reporter.Register(args.account)
  JuLiangEngineHelper.OnEventRegister("Offical", bSuccess)
end

function SdkHelper.TrackLogin(LoginAttributesTable, propertiesDict)
  SdkHelper.GetSdkLuaface().TrackLogin(LoginAttributesTable, propertiesDict)
end

function SdkHelper.TrackLogin2(propertiesDict, loginType, isSuccess)
end

function SdkHelper.TrackLogin3(args)
  local loginStatus = SdkHelper.GetStatusFromBool(args.isSuccess)
  SdkHelper.GetSdkLuaface().TrackLogin(args.propertiesDict, args.loginType, loginStatus)
  TrackingIO2Reporter.Login(args.account)
end

function SdkHelper.TrackCustom(eventName, propertiesTable)
  local dict = SdkHelper.ConvertTableToDictStrObj(propertiesTable)
  CS.SdkLuaface.TrackCustom(eventName, dict)
end

function SdkHelper.ProcessTrackPropValueType(propertiesTable)
  if propertiesTable == nil then
    return
  end
  for key, value in pairs(propertiesTable) do
    local vt = SdkTrackConst.EvtPropValueType[key]
    if value ~= nil and vt ~= nil and vt == "number" and not SdkHelper.IsTypeNumber(value) then
      propertiesTable[key] = SdkHelper.TryToNumber(value)
    end
  end
end

function SdkHelper.TryToNumber(v)
  if SdkHelper.IsTypeNumber(v) then
    return v
  elseif SdkHelper.IsTypeString(v) then
    return tonumber(v)
  end
  return v
end

function SdkHelper.IsTypeNumber(v)
  return type(v) == "number"
end

function SdkHelper.IsTypeString(v)
  return type(v) == "string"
end

function SdkHelper.Login(callback)
  CS.GameSdkLuaface.Login(callback)
end

function SdkHelper.TryLogout()
  if SdkHelper.IsNotChannelDefault() then
    SdkHelper.Logout()
    LoginHelper.ChannelLogout()
  end
end

function SdkHelper.Logout()
  SdkHelper.IsNotifyed = false
  CS.GameSdkLuaface.Logout()
end

function SdkHelper.CreateRole(roleId, roleName)
  Debug.Log("[SDK]CreateRole roldId=" .. roleId .. ",roleName=" .. roleName)
  CS.GameSdkLuaface.CreateRole(roleId, roleName)
end

function SdkHelper.NotifyZone()
  if SdkHelper.IsNotifyed == true then
    return
  end
  SdkHelper.IsNotifyed = true
  if SdkHelper.IsBilibiliSelfTest() then
    SdkHelper.CreateRole(PlayerData:GetUserInfo().uid, LoginGV.GetUsername())
  end
  local jsonData = {}
  jsonData.roleId = PlayerData:GetUserInfo().uid
  jsonData.roleName = LoginGV.GetUsername()
  local jsonStr = Json.encode(jsonData)
  Debug.Log("[SDK]NotifyZone")
  CS.GameSdkLuaface.NotifyZone(jsonStr)
end

function SdkHelper.AccountUnregister(jsonStr)
  CS.GameSdkLuaface.AccountUnregister(jsonStr)
end

function SdkHelper.IsBilibiliSelfTest()
  return CS.GameSdkLuaface.IsBilibiliSelfTest()
end

function SdkHelper.GetChannelType()
  return CS.GameSdkLuaface.GetChannelType()
end

function SdkHelper.GetChannelFlag()
  local r, flag = CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.CurChannelIDLower)
  return flag or "official"
end

function SdkHelper.IsNotChannelDefault()
  return SdkHelper.GetChannelType() ~= SdkConst.ChannelType.Default
end

function SdkHelper.IsChannelBilibili()
  return SdkHelper.GetChannelType() == SdkConst.ChannelType.Bilibili
end

function SdkHelper.GetPlatformFlag()
  if SdkHelper.IsChannelBilibili() then
    return "biligame"
  end
  return "oc"
end

function SdkHelper.OpenWaiting()
  UIManager:Open("UI/Common/SDKWaiting")
end

function SdkHelper.CloseWaiting()
  UIManager:CloseTip("UI/Common/SDKWaiting")
end

function SdkHelper.GetPackageName()
  local a, b = CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.GetPackageName)
  return b or ""
end

SdkHelper.Init()
return SdkHelper
