local date = {}
local RefeshTime = function()
  PlayerData.online_time = PlayerData.online_time + 1
  local time = tonumber(os.date("%H", TimeUtil:GetServerTimeStamp()))
  if 21 <= time or time < 20 then
    CommonTips.OpenAntiAddiction({index = 3}, function()
      CBus:Logout()
      date.MoveSecondEvent()
    end)
  else
    local residue_time
    residue_time = 3600 - PlayerData.online_time
    if PlayerData.online_time == 1800 then
      CommonTips.OpenAntiAddiction({index = 4, time = residue_time}, function()
        CBus:ChangeScene("Main")
      end)
    end
    if residue_time <= 0 then
      CommonTips.OpenAntiAddiction({index = 6}, function()
        CBus:Logout()
      end)
      return
    end
  end
end

function date.AddOnSecondEvent()
  if GameSetting.AdministrationsAddictionFeature then
    EventManager:AddOnSecondEvent(RefeshTime)
  end
end

function date.MoveSecondEvent()
  if GameSetting.AdministrationsAddictionFeature then
    EventManager:RemoveOnSecondEvent(RefeshTime)
  end
end

return date
