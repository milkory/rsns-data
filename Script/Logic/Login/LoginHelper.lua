local Controller = require("UILogin/UILoginController")
LoginGV = require("Logic/Login/LoginGV")
local LoginHelper = {}

function LoginHelper.StartChannelLogin()
  print("[Login]LoginHelper.StartChannelLogin")
  PhoneIDLogin = false
  GameSetting.AdministrationsAddictionFeature = false
  SdkHelper.Login(function(jsonStr)
    Debug.Log("[Login]LoginHelper.StartChannelLogin jsonStr=" .. jsonStr)
    UIManager:CloseTip("UI/Common/Waiting")
    local data = Json.decode(jsonStr)
    if data == nil or data.status ~= 0 then
      Debug.Log("[Login]Login Cancel")
      return
    end
    LoginGV.OnChannelLogin(data)
    LoginHelper.ReqChannelInfoIndex()
  end)
end

function LoginHelper.ReqChannelInfoIndex()
  print("[Login]LoginHelper.ReqChannelEnterGame")
  local args = {
    accessToken = LoginGV.GetAccessToken(),
    platform = SdkHelper.GetPlatformFlag(),
    username = LoginGV.GetUsername()
  }
  LoginHelper.ReqInfoAndIndex(args)
end

function LoginHelper.ReqInfoAndIndex(args)
  if args == nil then
    print("[Login]ReqInfoAndIndex Return args == nil")
    return
  end
  local accessToken = args.accessToken
  local platform = args.platform
  local username = args.username
  local info = ProtocolFactory:CreateProtocol(ProtocolType.Info)
  info.accessToken = accessToken
  info.openId = 0
  info:SetCallback(function(res3)
    print("[Login]LoginHelper.ReqEnterGame OnRecv Info json=" .. res3)
    local json3 = Json.decode(res3)
    PlayerData.ServerData = {}
    PlayerData.ServerData.server_now = json3.server_now
    if PlayerData:GetNoPrompt("logintNotice", 1) == false then
      PlayerData:SetNoPrompt("logintNotice", 1, true)
    end
    local rc = json3.rc
    if rc and rc ~= "" then
      SdkReporter.TrackLogin(false)
      Controller.Tip2(json3.msg, "80600068", function()
        if PhoneIDLogin then
          OpenNewLogin("showPhoneID")
          return
        end
        CBus:Logout(1)
      end)
      return
    end
    local index = ProtocolFactory:CreateProtocol(ProtocolType.Index)
    PlayerData.serverTimeOffset = TimeTool.UnixTimeStamp() - json3.server_now
    index.accessToken = accessToken
    index.openId = 0
    index.timestamp = TimeTool.UnixTimeStamp() - PlayerData.serverTimeOffset
    index.platform = platform
    index.autoLogin = 0
    index.deviceId = DeviceHelper.GetDeviceId()
    index:SetCallback(function(res4)
      print("[Login]LoginHelper.ReqEnterGame OnRecv Index json=" .. res4)
      local json4 = Json.decode(res4)
      Controller:OnRecvIndex(json4)
      rc = json4.rc
      if rc and rc ~= "" then
        SdkReporter.TrackLogin(false)
        Controller.Tip2(json4.msg, "80600068", function()
          if PhoneIDLogin then
            OpenNewLogin("showPhoneID")
            return
          end
          CBus:Logout(1)
        end)
        return
      end
      SdkReporter.TrackLogin(true)
      local timezone = string.sub(json4.timezone, 4, 6)
      PlayerData.TimeZone = tonumber(timezone)
      PlayerData.RemoteId = json4.remote_id
      PlayerData.platform = platform
      PlayerData.pid = json4.pid
      Controller.Enter(username)
      CommonTips.CheckOpenNoticeLogin()
    end)
    ServerConnectManager:Add(index)
  end)
  print("[Login]ReqInfoAndIndex")
  ServerConnectManager:Add(info)
end

function LoginHelper.ReqChannelMainIndex()
  if LoginGV.IsLogin() then
    LoginHelper.ReqMainIndex()
  else
    LoginHelper.StartChannelLogin()
  end
end

function LoginHelper.ReqMainIndex()
  local main = ProtocolHelper.CreateProtocolMainIndex()
  Debug.Log("[Login]LoginHelper.ReqMainIndex rty=" .. main.rty)
  main:SetCallback(function(res)
    Debug.Log("[Login]LoginHelper.ReqMainIndex Recv MainIndex json =" .. res)
    local json = Json.decode(res)
    PlayerData.MissionRefreshState = true
    PlayerData.RechargeGoods = nil
    if json.rc and json.rc ~= "" then
      Controller.Tip2(json.msg, "80600068", function()
        CBus:Logout(1)
      end)
      return
    end
    if Controller:OnRecvMainIndexCheck(json) == false then
      return
    end
    json.rc = nil
    PlayerData.ServerData = json
    local time = TimeUtil:GetFutureTime(0, 20)
    PlayerData.online_time = json.server_now - time
    PlayerData:GetAllRoleAwakeRed()
    PlayerData:GetAwakeEquipRed()
    Net.Callback(res, nil)
    PlayerData:ResetTempCache()
    local coachInfos = PlayerData:GetHomeInfo().coach_template
    PlayerData:GetHomeInfo().coach = {}
    for k, v in pairs(coachInfos) do
      local uid = v
      local coachInfo = PlayerData:GetHomeInfo().coach_store[uid]
      table.insert(PlayerData:GetHomeInfo().coach, coachInfo)
    end
    PlayerData:SetPanelTriggerGuide()
    local QuestTrace = require("Common/QuestTrace")
    QuestTrace.AddOpenPanelCallBack()
    PlayerData.HandleMainIndex()
    PlayerData:SetChapterLevelTable()
    PlayerData:SetSortChapterLevelTable()
    GameSetting:LoadPlayerSetting()
    EventMgr:SendEvent("event_mainindex_receive", 1)
    Controller:OnRecvMainIndex(json)
    SdkHelper.NotifyZone()
    if UseGSDK then
      local info = PlayerData:GetGameUploadInfo()
      GSDKManager:EnterGameUpload(info.RoleName, info.RoleLevel, info.Balance, info.Chapter)
      local order = tonumber(PlayerData:GetUserInfo().older or 1)
      local is_user_first = 0
      if order == 0 then
        local info = PlayerData:GetGameUploadInfo()
        GSDKManager:CreateNewRoleUpload(info.RoleName, info.RoleLevel, info.Balance, info.Chapter)
        is_user_first = 1
      end
    end
    if GameSetting.AdministrationsAddictionFeature then
      if table.count(PlayerData:GetUserInfo().real_info) == 0 then
        CommonTips.OpenAntiAddiction({index = 1})
        return
      end
      local grow = PlayerData:IsCheckYearOld(PlayerData:GetUserInfo().real_info.id_card)
      local time = tonumber(os.date("%H", PlayerData.ServerData.server_now))
      print_r(time)
      local date_time = tostring(os.date("%Y-%m-%d", PlayerData.ServerData.server_now))
      PlayerData.AdministrationsAddictionHolidays = false
      for k, v in pairs(PlayerData:GetFactoryData(99900013).holidayList) do
        if date_time == v.day then
          PlayerData.AdministrationsAddictionHolidays = true
        end
      end
      if grow < 18 then
        if PlayerData.AdministrationsAddictionHolidays == true then
          if 21 <= time or time < 20 then
            CommonTips.OpenAntiAddiction({index = 2}, function()
              CommonTips.OpenAntiAddiction({index = 3})
            end)
            return
          else
            CommonTips.OpenAntiAddiction({index = 2}, function()
              local residue_time
              residue_time = 3600 - PlayerData.online_time
              if 0 < residue_time then
                CommonTips.OpenAntiAddiction({index = 4, time = residue_time}, function()
                  Controller.ChangeScene2Main()
                  require("UIAntiAddiction/AntiaddictionTime").AddOnSecondEvent()
                end)
              end
              if residue_time <= 0 then
                CommonTips.OpenAntiAddiction({index = 6}, function()
                  CBus:NewLogout()
                end)
              end
            end)
            return
          end
        else
          CommonTips.OpenAntiAddiction({index = 2}, function()
            CommonTips.OpenAntiAddiction({index = 3})
          end)
          return
        end
      end
    end
    if UseGSDK and GSDKManager.AppService.ChannelOp == "bsdk" then
      PlayerData:VerifyRealName(function()
        Controller.ChangeScene2Main()
      end)
    else
      Controller.ChangeScene2Main()
    end
    return
  end)
  ServerConnectManager:Add(main)
end

function LoginHelper.RegAccountUnregister()
  if SdkHelper.IsNotChannelDefault() then
    LoginHelper.RegChanneAccountUnregister()
    return
  end
  local api = ProtocolHelper.CreateProtocolApi(ProtocolType.MainCancel, function()
    LoginHelper.DefaultLogout()
  end)
  ProtocolHelper.SendProtocolApi(api)
end

function LoginHelper.RegChanneAccountUnregister()
  local jsonData = {
    {
      role_name = LoginGV.GetUsername(),
      server_name = "bilibili区",
      level = 1,
      time = "2021-01-01"
    }
  }
  local jsonStr = Json.encode(jsonData)
  SdkHelper.AccountUnregister(function(jsonStr2)
    local jsonData2 = Json.decode(jsonStr2)
    if jsonData2.status == 0 then
      LoginHelper.Logout()
      LoginHelper.StartChannelLogin()
    end
  end, jsonStr)
end

function LoginHelper.DefaultLogout()
  CBus:Logout(1)
end

function LoginHelper.Logout()
  CBus:Logout()
  LoginGV.SetIsLogin(false)
  SdkHelper.Logout()
end

function LoginHelper.ChannelLogout()
  LoginHelper.Logout()
end

return LoginHelper
