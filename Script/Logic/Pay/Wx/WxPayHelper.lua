local WxPayHelper = {}

function WxPayHelper.Init()
  if not WxPayHelper.IsEnableWxPay() then
    return
  end
  WxPayHelper.ReqQueryWxAppId()
end

function WxPayHelper.IsEnableWxPay()
  if PayHelper.IsPayPlatformChannel() then
    if SdkHelper.IsChannelBilibili() then
      return false
    end
    return true
  elseif PayHelper.IsPayPlatformAndroid() then
    return true
  end
  return false
end

function WxPayHelper.ReqQueryWxAppId()
  local channelFlag = WxPayHelper.GetChannelFlag()
  Net:SendProto("pay.wx_query_appid", function(json)
    local app_id = json.app_id
    local merchant_id = json.merchant_id
    Debug.Log(string.format("WxPayHelper.ReqQueryWxAppId appId=%s,merchant_id=%s", app_id, merchant_id))
    CommonHelper.SafeCallCsFunc(CS.PayLuaface.InitWxPay, app_id, merchant_id)
  end, channelFlag)
end

function WxPayHelper.GetChannelFlag()
  local packageName = SdkHelper.GetPackageName()
  if packageName == "com.hermes.goda.toutiaoad" then
    return "toutiaoad"
  end
  return "official"
end

return WxPayHelper
