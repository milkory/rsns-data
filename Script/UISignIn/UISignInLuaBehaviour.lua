local View = require("UISignIn/UISignInView")
local DataModel = require("UISignIn/UISignInDataModel")
local ViewFunction = require("UISignIn/UISignInViewFunction")
local ChooseNowMonthList = function(list)
  local data = {}
  for k, v in pairs(Controller_UISignln.Xml_Data) do
    if list[v.key] and table.count(list[v.key]) ~= 0 then
      for c, d in pairs(list[v.key]) do
        if v.key == "dailySigninList" then
          local index = Controller_UISignln.Get_Xml_Month_Index[tonumber(os.date("%m"))]
          local count = 1
          if index then
            local row = {}
            data[v.key] = row
            row[count] = {
              [index] = d[index]
            }
            count = count + 1
          end
        else
          data[v.key] = list[v.key]
        end
      end
    end
  end
  return data
end
local SetXmlData = function(key, table)
  local list = {}
  for k, v in pairs(table) do
    local SigninFactory = PlayerData:GetFactoryData(v, "SigninFactory")
    local row = {}
    if SigninFactory then
      list = row
      for c, d in pairs(SigninFactory) do
        row[c] = d
      end
      row.signinid = v
      row.key = k
    end
  end
  return list
end
local Init = function()
  View.Group_EventSignIn.ScrollGrid_Board.grid.self:SetDataCount(table.count(DataModel.Config.SigninAwardList))
  View.Group_EventSignIn.ScrollGrid_Board.grid.self:RefreshAllElement()
  if DataModel.Config.Sever.count >= table.count(DataModel.Config.SigninAwardList) - 2 then
    View.Group_EventSignIn.ScrollGrid_Board.grid.self:MoveToPos(table.count(DataModel.Config.SigninAwardList) - 2)
  else
    View.Group_EventSignIn.ScrollGrid_Board.grid.self:MoveToPos(DataModel.Config.Sever.count + 1)
  end
  local timeStart = TimeUtil:GetTimeTable(DataModel.Config.startTime)
  local timeEnd = TimeUtil:GetTimeTable(DataModel.Config.endTime)
  local a_1 = timeStart.year .. "/" .. timeStart.month .. "/" .. timeStart.day
  local a_2 = timeEnd.year .. "/" .. timeEnd.month .. "/" .. timeEnd.day
  local b_2 = timeEnd.hour .. ":" .. timeEnd.minute
  local str = string.format(GetText(80600193), a_1, a_2, b_2)
  View.Group_EventSignIn.Txt_EndTime:SetText(str)
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    for k, v in pairs(PlayerData:GetSignInfo()) do
      DataModel.Config = PlayerData:GetFactoryData(k)
      DataModel.Config.Sever = v
    end
    Init()
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
