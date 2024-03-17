local DataModel = {}

function DataModel.Init()
  DataModel.inputPhoneNumber = ""
  DataModel.codeTimer = 0
  DataModel.phoneIDMaxNum = 6
  DataModel.phoneIDList = {}
  local phoneIDParams = PlayerPrefs.GetString("PhoneIDList")
  if phoneIDParams ~= "" then
    DataModel.nowSelectId = 1
    DataModel.phoneIDList = Json.decode(PlayerPrefs.GetString("PhoneIDList"))
  end
  DataModel.delId = nil
end

function DataModel.ValidatePhoneNumber(phone_number)
  PlayerData.ShowCMD(phone_number)
  if string.nilorempty(phone_number) then
    return false, 80601829
  end
  local pattern = "[1][3,4,5,6,7,8,9]%d%d%d%d%d%d%d%d%d"
  if string.match(phone_number, pattern) and #phone_number == 11 then
    return true
  end
  return false, 80601826
end

function DataModel.IsPasswordValid(password)
  local length = #password
  local tipId
  if length < 8 or 12 < length then
    tipId = 80600028
    return false, tipId
  end
  local hasNumber = false
  local hasLetter = false
  local hasOther = false
  for i = 1, length do
    local char = password:sub(i, i)
    if tonumber(char) then
      hasNumber = true
    elseif string.match(char, "%a") ~= nil then
      hasLetter = true
    else
      hasOther = true
    end
  end
  if hasNumber == false or hasLetter == false or hasOther then
    tipId = 80601990
    return false, tipId
  end
  return true
end

function DataModel.GetPhoneID(index)
  if DataModel.phoneIDList then
    return DataModel.phoneIDList[index]
  end
  return nil
end

function DataModel.GetPhoneIDByUsername(username)
  if DataModel.phoneIDList == nil then
    DataModel.phoneIDList = {}
    local phoneIDParams = PlayerPrefs.GetString("PhoneIDList")
    if phoneIDParams ~= "" then
      DataModel.phoneIDList = Json.decode(PlayerPrefs.GetString("PhoneIDList"))
    end
  end
  if next(DataModel.phoneIDList) then
    for i, v in ipairs(DataModel.phoneIDList) do
      if v.username == username then
        return v
      end
    end
  end
  return nil
end

function DataModel.SavePhoneIdList(username, access_token, openid, lastLoginTs)
  local row = {
    username = username,
    access_token = access_token,
    openid = openid,
    lastLoginTs = lastLoginTs
  }
  local needInsert = true
  local phoneIDCount = 0
  if DataModel.phoneIDList == nil then
    DataModel.phoneIDList = {}
    local phoneIDParams = PlayerPrefs.GetString("PhoneIDList")
    if phoneIDParams ~= "" then
      DataModel.phoneIDList = Json.decode(PlayerPrefs.GetString("PhoneIDList"))
    end
  end
  if next(DataModel.phoneIDList) then
    for i, v in ipairs(DataModel.phoneIDList) do
      if v.username == username then
        DataModel.phoneIDList[i] = DataModel.phoneIDList[1]
        DataModel.phoneIDList[1] = row
        needInsert = false
        break
      end
      phoneIDCount = i
    end
    if needInsert then
      if phoneIDCount == DataModel.phoneIDMaxNum then
        table.remove(DataModel.phoneIDList, phoneIDCount)
      end
      table.insert(DataModel.phoneIDList, 1, row)
    end
  else
    DataModel.phoneIDList[1] = row
  end
  PlayerPrefs.SetString("PhoneIDList", Json.encode(DataModel.phoneIDList))
end

function DataModel.DelPhoneID()
  if DataModel.phoneIDList[DataModel.delId] then
    if DataModel.delId == DataModel.nowSelectId then
      DataModel.nowSelectId = 1
    end
    local nowPhoneID = DataModel.phoneIDList[DataModel.nowSelectId].username
    table.remove(DataModel.phoneIDList, DataModel.delId)
    DataModel.delId = nil
    for i, v in ipairs(DataModel.phoneIDList) do
      if v.username == nowPhoneID then
        DataModel.nowSelectId = i
        break
      end
    end
  end
  if next(DataModel.phoneIDList) then
    PlayerPrefs.SetString("PhoneIDList", Json.encode(DataModel.phoneIDList))
  else
    PlayerPrefs.SetString("PhoneIDList", "")
  end
end

function DataModel.FormatPhoneID(phone_number)
  local formatted_number = ""
  if type(phone_number) == "string" then
    phone_number = phone_number:gsub("[^%d]", "")
    if 11 <= #phone_number then
      local prefix = phone_number:sub(1, 3)
      local middle = "****"
      local suffix = phone_number:sub(-4)
      formatted_number = prefix .. middle .. suffix
    end
  else
    formatted_number = phone_number
  end
  return formatted_number
end

function DataModel.FormatTime(seconds)
  if seconds < 60 then
    return GetText(80601855)
  elseif seconds < 3600 then
    local minutes = math.floor(seconds / 60)
    return string.format(GetText(80601856), minutes)
  elseif seconds < 86400 then
    local hours = math.floor(seconds / 3600)
    return string.format(GetText(80601857), hours)
  else
    local days = math.floor(seconds / 86400)
    if 30 <= days then
      return GetText(80600122)
    end
    return string.format(GetText(80601858), days)
  end
end

return DataModel
