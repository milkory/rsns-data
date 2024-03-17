Controller_UISignln = {}
local View = require("UISignIn/UISignInView")
local left_tag_grid, day_grid, month_grid
Controller_UISignln.signin_xml_data = {}
Controller_UISignln.Xml_Data = {
  [1] = {
    key = "dailySigninList",
    title = "每日签到"
  },
  [2] = {
    key = "activeSigninList",
    title = "活动签到"
  }
}
Controller_UISignln.Get_Xml_Month_Index = {
  [1] = "janSigninId",
  [2] = "febSigninId",
  [3] = "marSigninId",
  [4] = "aprSigninId",
  [5] = "maySigninId",
  [6] = "juneSigninId",
  [7] = "julySigninId",
  [8] = "augSigninId",
  [9] = "septSigninId",
  [10] = "octSigninId",
  [11] = "novSigninId",
  [12] = "decSigninId"
}
Controller_UISignln.Tag_Left_Table = {
  content = {},
  choose_index = nil,
  old = {},
  choose = {}
}
Controller_UISignln.Day_Table = {
  {
    index = 1,
    isSign = false,
    isNew = false,
    element = {},
    reward_num = 100
  },
  {
    index = 2,
    isSign = false,
    isNew = false,
    element = {},
    reward_num = 1000
  },
  {
    index = 3,
    isSign = false,
    isNew = false,
    element = {},
    reward_num = 1000
  },
  {
    index = 4,
    isSign = false,
    isNew = false,
    element = {},
    reward_num = 1000
  },
  {
    index = 5,
    isSign = false,
    isNew = false,
    element = {},
    reward_num = 100
  },
  {
    index = 6,
    isSign = false,
    isNew = false,
    element = {},
    reward_num = 100
  },
  {
    index = 7,
    isSign = false,
    isNew = false,
    element = {},
    reward_num = 100
  }
}
Controller_UISignln.Month_Table = {}
local get_tag_grid = function()
  if not left_tag_grid then
    left_tag_grid = View.Group_Left_Tag.StaticGrid_Tag.self
  end
  return left_tag_grid
end
local get_day_grid = function()
  if not day_grid then
    day_grid = View.Group_DailySignIn.ScrollGrid_Daily.grid.self
  end
  return day_grid
end
local get_month_grid = function()
  if not month_grid then
    month_grid = View.Group_EventSignIn.StaticGrid_Board.self
  end
  return month_grid
end

function Controller_UISignln.InitLeftTag(callback)
  get_tag_grid():RefreshAllElement()
  if callback then
    callback()
  end
end

function Controller_UISignln.InitDayGrid(list, callback)
  get_day_grid():SetDataCount(table.count(list))
  get_day_grid():RefreshAllElement()
  if callback then
    callback()
  end
end

function Controller_UISignln.InitActiveGrid(callback)
  get_month_grid():RefreshAllElement()
  if callback then
    callback()
  end
end
