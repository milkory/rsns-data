local Time = {}

function Time:TimeStamp(timeStr)
  return TimeTool.TimeStamp(timeStr) - PlayerData.TimeZone * 3600
end

function Time:IsActive(startTime, endTime)
  if startTime == "" then
    return true
  end
  if endTime == "" then
    if self:TimeStamp(startTime) <= self:GetServerTimeStamp() then
      return true
    else
      return false
    end
  end
  if self:TimeStamp(startTime) <= self:GetServerTimeStamp() and self:GetServerTimeStamp() < self:TimeStamp(endTime) then
    return true
  end
  return false
end

function Time:GetTimeTable(timeStr)
  local t = {}
  for w in string.gmatch(timeStr, "%d+") do
    table.insert(t, w)
  end
  return {
    year = t[1],
    month = tonumber(t[2]),
    day = t[3],
    hour = t[4],
    minute = t[5],
    second = t[6]
  }
end

function Time:LastTime(timeStr)
  return self:TimeStamp(timeStr) - self:GetServerTimeStamp()
end

function Time:SecondToTable(second)
  if second < 0 then
    return {
      day = 0,
      hour = 0,
      minute = 0,
      second = 0
    }
  end
  local day = math.floor(second / 86400)
  local lastSecond = math.floor(second % 86400)
  local hour = math.floor(lastSecond / 3600)
  lastSecond = math.floor(lastSecond % 3600)
  local minute = math.floor(lastSecond / 60)
  lastSecond = math.floor(lastSecond % 60)
  return {
    day = day,
    hour = hour,
    minute = minute,
    second = lastSecond
  }
end

function Time:GetCommonDesc(timeTable)
  if timeTable.day > 0 then
    return string.format(GetText(80600014), timeTable.day, timeTable.hour)
  end
  if 0 < timeTable.hour then
    return string.format(GetText(80600016), timeTable.hour, timeTable.minute)
  end
  if 0 < timeTable.minute then
    return string.format(GetText(80600016), timeTable.hour, timeTable.minute)
  end
  if 0 < timeTable.second then
    return string.format(GetText(80600017), timeTable.second)
  end
  return GetText(80600019)
end

function Time:GetGachaDesc(timeTable)
  if timeTable.day > 0 then
    return string.format(GetText(80600006), timeTable.day, timeTable.hour, timeTable.minute)
  end
  if 0 < timeTable.hour then
    return string.format(GetText(80600007), timeTable.hour, timeTable.minute)
  end
  if 0 < timeTable.minute then
    return string.format(GetText(80600008), timeTable.minute)
  end
  if 0 < timeTable.second then
    return string.format(GetText(80600009), timeTable.second)
  end
  return "0"
end

function Time:GetServerTimeStamp(changeLocalTimeZone)
  local serverTimeStamp = TimeTool.UnixTimeStamp() - PlayerData.serverTimeOffset
  if changeLocalTimeZone then
    serverTimeStamp = serverTimeStamp - (PlayerData.TimeZone - Time:GetLocalTimeZone()) * 3600
    serverTimeStamp = math.modf(serverTimeStamp)
  end
  return serverTimeStamp
end

function Time:GetLocalTimeZone()
  local now = os.time()
  local diffTime = os.difftime(now, os.time(os.date("!*t", now)))
  local timeZone, temp = math.modf(diffTime / 3600)
  if 0.9999 < temp then
    timeZone = timeZone + 1
  elseif temp < -0.9999 then
    timeZone = timeZone - 1
  end
  return timeZone
end

function Time:GetMailCommonDesc(second)
  local timeTable = Time:SecondToTable(second)
  if timeTable.day > 0 then
    return string.format(GetText(80600080), timeTable.day)
  end
  if 0 < timeTable.hour then
    return string.format(GetText(80600081), timeTable.hour)
  end
  if 0 < timeTable.minute then
    return string.format(GetText(80600082), timeTable.minute)
  end
  if 0 < timeTable.second then
    return string.format(GetText(80600083), timeTable.second)
  end
  return GetText(80600019)
end

function Time:GetFriendDesc(logintime)
  local now_time = PlayerData.ServerData.server_now
  local login_time = logintime
  local timeTable = Time:SecondToTable(now_time - login_time)
  if timeTable.day > 30 then
    return GetText(80600122), false
  end
  if timeTable.day <= 30 and timeTable.day > 1 then
    return string.format(GetText(80600121), timeTable.day), false
  end
  if 1 < timeTable.hour and timeTable.hour <= 24 then
    return GetText(80600125), false
  end
  if 1 >= timeTable.hour and timeTable.minute > 0 then
    return GetText(80600124), false
  end
  if timeTable.second == 0 and timeTable.minute == 0 then
    return GetText(80600123), true
  end
  return "", false
end

function Time:GetAntiAddicitionCommonDesc(timeTable)
  if timeTable.day > 0 then
    return string.format(GetText(80600014), timeTable.day, timeTable.hour)
  end
  if 0 < timeTable.hour then
    return string.format(GetText(80600138), timeTable.hour, timeTable.minute)
  end
  if 0 < timeTable.minute then
    return string.format(GetText(80600138), timeTable.hour, timeTable.minute)
  end
  if 0 < timeTable.second then
    return string.format(GetText(80600139), timeTable.second)
  end
  return GetText(80600019)
end

function Time:GetBattlePassTime(timeTable)
  if timeTable.day > 0 then
    return string.format(GetText(80601195), timeTable.day, timeTable.hour)
  end
  if 0 < timeTable.hour then
    return string.format(GetText(80601230), timeTable.hour, timeTable.minute)
  end
  if 0 < timeTable.minute then
    return string.format(GetText(80601231), timeTable.hour, timeTable.minute)
  end
  return GetText(80600019)
end

function Time:GetFutureTime(futureDays, hour)
  local curTimestamp = PlayerData:GetSeverTime()
  local dayTimestamp = 86400
  local newTime = curTimestamp + dayTimestamp * futureDays
  local newDate = os.date("*t", newTime)
  return os.time({
    year = newDate.year,
    month = newDate.month,
    day = newDate.day,
    hour = hour,
    minute = newDate.minute,
    second = newDate.second
  })
end

function Time:GetFutureTimeByTimeZone(futureDays, hour)
  local curTimestamp = PlayerData:GetSeverTime()
  local dayTimestamp = 86400
  local newTime = curTimestamp + dayTimestamp * futureDays
  local newDate = os.date("*t", newTime)
  newTime = os.time({
    year = newDate.year,
    month = newDate.month,
    day = newDate.day,
    hour = hour,
    minute = newDate.minute,
    second = newDate.second
  })
  newTime = newTime - (PlayerData.TimeZone - self:GetLocalTimeZone() + (newDate.isdst and -1 or 0)) * 3600
  return newTime
end

function Time:GetStandardTime(timeTable)
  local hour = 0
  if 0 < timeTable.day then
    hour = hour + timeTable.day * 24
  end
  if 0 < timeTable.hour then
    hour = hour + timeTable.hour
  end
  return string.format("%02d:%02d:%02d", hour, timeTable.minute, timeTable.second)
end

function Time:FormatUnixTime2Date(unixTime)
  if unixTime and 0 <= unixTime then
    local tb = {}
    tb.year = tonumber(os.date("%Y", unixTime))
    tb.month = tonumber(os.date("%m", unixTime))
    tb.day = tonumber(os.date("%d", unixTime))
    tb.hour = tonumber(os.date("%H", unixTime))
    tb.minute = tonumber(os.date("%M", unixTime))
    tb.second = tonumber(os.date("%S", unixTime))
    return tb
  end
end

function Time:GetNextSpecialTimeStamp(h, m, s, compareTime)
  local nextTime = 0
  if h ~= nil then
    nextTime = nextTime + h * 3600
  end
  if m ~= nil then
    nextTime = nextTime + m * 60
  end
  if s ~= nil then
    nextTime = nextTime + s
  end
  local curTime = compareTime or Time:GetServerTimeStamp()
  local timeZoneTime = PlayerData.TimeZone * 3600
  local dayTimeStamp = 86400
  local days = math.modf((curTime + timeZoneTime) / dayTimeStamp)
  local targetTimeStamp = days * dayTimeStamp + nextTime - timeZoneTime
  if curTime >= targetTimeStamp then
    targetTimeStamp = targetTimeStamp + dayTimeStamp
  end
  if curTime >= targetTimeStamp then
    targetTimeStamp = targetTimeStamp + dayTimeStamp
  end
  return targetTimeStamp
end

function Time:GetNextWeekTime(wDay, h, compareTime)
  local t = os.date("*t", compareTime)
  local wDayTable = {
    [1] = 7,
    [2] = 1,
    [3] = 2,
    [4] = 3,
    [5] = 4,
    [6] = 5,
    [7] = 6
  }
  local wDayToLuaWDay = {
    [1] = 2,
    [2] = 3,
    [3] = 4,
    [4] = 5,
    [5] = 6,
    [6] = 7,
    [7] = 1
  }
  local remainDay = 0
  if t.wday == wDayToLuaWDay[wDay] then
    if h > t.hour then
      remainDay = 0
    else
      remainDay = 7
    end
  else
    remainDay = 8 - wDayTable[t.wday]
  end
  local dayTimeStamp = 86400
  local newTime = compareTime + remainDay * dayTimeStamp
  local newDate = os.date("*t", newTime)
  return os.time({
    year = newDate.year,
    month = newDate.month,
    day = newDate.day,
    hour = h,
    minute = newDate.minute,
    second = newDate.second
  })
end

function Time:GetTimeStampTotalDays(timeStamp)
  local day = math.modf((timeStamp + PlayerData.TimeZone * 3600) / 86400)
  return day
end

return Time
