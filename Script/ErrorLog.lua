local ErrorLog = {}
local SendList = {}
local ProtocolList = {}
local BattleList = ""
local ErrorFrame
local HandleList = {}
local GameSetting = {}
local UIList = {}
local clickMax = 50
local protocolMax = 30

function ErrorLog.AddClickLog(frame, callbackname)
  local position = CS.UnityEngine.Input.mousePosition
  table.insert(UIList, {
    f = frame,
    n = callbackname,
    x = math.floor(position.x),
    y = math.floor(position.y)
  })
  if table.count(UIList) > clickMax then
    table.remove(UIList, 1)
  end
  ErrorLog.UIList = Json.encode(UIList)
end

function ErrorLog.AddProtocolLog(frame, protocolname)
  table.insert(ProtocolList, {f = frame, n = protocolname})
  if table.count(ProtocolList) > protocolMax then
    table.remove(ProtocolList, 1)
  end
end

function ErrorLog.AddHandleLog(logString, stackTrace, type, extension)
  HandleList.logString = logString
  HandleList.stackTrace = stackTrace
  HandleList.type = type
  HandleList.extension = extension
end

function ErrorLog.AddBattleInfo(initParams, errorFrame)
  BattleList = initParams
  ErrorFrame = errorFrame
end

function ErrorLog.AddGameSettingLog(info)
  GameSetting = Json.decode(info)
end

function ErrorLog.InitList()
  UIList = {}
  SendList = {}
  HandleList = {}
  GameSetting = {}
  BattleList = ""
  ErrorFrame = nil
end

function ErrorLog.GetSendList()
  ErrorLog.SortSendList()
  print_r(SendList)
  print_r("获取报错信息表 lua 处组装的结果")
  UIManager:SendLuaErrorLog(Json.encode(SendList))
end

function ErrorLog.SortSendList()
  SendList.UIList = UIList
  SendList.ProtocolList = ProtocolList
  SendList.BattleList = BattleList
  SendList.HandleList = HandleList
  SendList.GameSetting = GameSetting
  local row = {}
  local summary = {}
  SendList.summary = summary
  summary.errorFrame = ErrorFrame
  summary.time = os.date("%Y-%m-%d %H:%M:%S", PlayerData:GetSeverTime())
  SendList.UserInfo = row
  row.uid = PlayerData:GetUserInfo() ~= nil and PlayerData:GetUserInfo().uid or PlayerData.uid
  row.role_name = PlayerData:GetUserInfo() ~= nil and PlayerData:GetUserInfo().role_name or PlayerPrefs.GetString("username")
  row.level = PlayerData:GetUserInfo() ~= nil and PlayerData:GetUserInfo().lv or 1
  row.platform = PlayerData.platform
end

function ErrorLog.OpenLuaErrorLog()
end

function ErrorLog.SendManyHero()
  local isNext = true
  local maxTime = 100
  CoroutineManager:Reg("lua", LuaUtil.cs_generator(function()
    while isNext and 0 < maxTime do
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
      Net:SendProto("recruit.do_recruit", function(json)
        if json.new_hero and json.new_hero.role then
          local num = 0
          for k, v in pairs(json.new_hero.role) do
            num = v.num + num
          end
          if num ~= 10 then
            isNext = false
          end
        end
      end, 80500010, 10, function(json)
        isNext = false
      end)
      maxTime = maxTime - 1
    end
  end))
end

return ErrorLog
