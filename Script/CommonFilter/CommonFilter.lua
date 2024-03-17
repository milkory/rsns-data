local DataModel = require("CommonFilter/FilterData")
local Controller = require("CommonFilter/FilterController")
local Filter = {}
local SetSortState = function(sortType, state)
  local fromView = DataModel.FromView
  local view = DataModel.View.Group_TabBtn
  if fromView == EnumDefine.CommonFilterType.SquadView then
    local btn = view.Btn_Screen
    local color = "#000000"
    if sortType == EnumDefine.SortType.filter then
      btn.Img_bg:SetSprite(UIConfig.SortIcon[state])
      if state == 2 then
        color = "#646464"
      end
      btn.Img_bg.Txt_Content:SetColor(color)
      return
    end
    local bgState = 1
    local angle = 0
    if state == 1 or state == 3 then
      color = "#646464"
      bgState = 2
    end
    if sortType == EnumDefine.SortType.level then
      btn = view.Btn_Level
    elseif sortType == EnumDefine.SortType.rarity then
      btn = view.Btn_Rarity
      if state == 1 or state == 3 then
        bgState = 4
      else
        bgState = 3
      end
    elseif sortType == EnumDefine.SortType.time then
      btn = view.Btn_Time
      if state == 1 or state == 3 then
        bgState = 4
      else
        bgState = 3
      end
    end
    if state == 3 or state == 4 then
      angle = 180
    end
    btn.Img_bg:SetSprite(UIConfig.SortIcon[bgState])
    btn.Img_bg.Txt_Content:SetColor(color)
    btn.Img_bg.Img_Arrow:SetColor(color)
    btn.Img_bg.Img_Arrow:SetRotate(angle)
  else
  end
end
local InitFilters = function()
  local enumJobList = PlayerData:GetFactoryData(99900017).enumJobList
  DataModel.RoleFilter[1].filters = {}
  DataModel.RoleFilter[1].filters[1] = "全部"
  for k, v in pairs(enumJobList) do
    local row = PlayerData:GetFactoryData(v.tagId)
    table.insert(DataModel.RoleFilter[1].filters, row.tagName)
  end
  local enumSideList = PlayerData:GetFactoryData(99900017).enumSideList
  DataModel.RoleFilter[2].filters = {}
  DataModel.RoleFilter[2].filters[1] = "全部"
  for k, v in pairs(enumSideList) do
    local row = PlayerData:GetFactoryData(v.tagId)
    table.insert(DataModel.RoleFilter[2].filters, row.sideName)
  end
end
local RefreshView = function()
  SetSortState(EnumDefine.SortType.level, DataModel.SortData[1].state)
  SetSortState(EnumDefine.SortType.rarity, DataModel.SortData[2].state)
  SetSortState(EnumDefine.SortType.time, DataModel.SortData[3].state)
  SetSortState(EnumDefine.SortType.filter, DataModel.SortData[4].state)
end
local FromView = function()
  local fromView = DataModel.FromView
  if fromView == EnumDefine.CommonFilterType.SquadView then
    Controller:SquadFilter()
    Controller:SquadSort()
  elseif fromView == EnumDefine.CommonFilterType.OtherView then
  end
end

function Filter.InitView(enum, view, data, callback, hasRecover)
  InitFilters()
  if not hasRecover then
    DataModel.View = {}
    DataModel.SortData = {}
    DataModel.FilterData = {}
    DataModel.isInit = true
    DataModel.FromView = enum
    DataModel.tempData = data
    DataModel.temp_Filter_Sort_Data = data
    DataModel.callback = callback
    local sort = {}
    local filter = {}
    if enum == EnumDefine.CommonFilterType.SquadView then
      sort = DataModel.RoleSort
      filter = DataModel.RoleFilter
    elseif enum == EnumDefine.CommonFilterType.OtherView then
    end
    for k, v in pairs(sort) do
      local isFirst = k == 1
      local temp = {}
      temp.type = v
      temp.isActive = isFirst
      if v == EnumDefine.SortType.filter then
        temp.state = isFirst and DataModel.EnumFilter.open or DataModel.EnumFilter.close
      else
        temp.state = isFirst and DataModel.EnumSort.down_on or DataModel.EnumSort.down_off
      end
      DataModel.SortData[k] = temp
    end
    for k, v in pairs(filter) do
      local temp = {}
      temp.name = v.name
      if v.name == "职业" then
        temp.name = "站位"
      end
      temp.isImg = v.isImg
      temp.filters = {}
      for k1, v1 in pairs(v.filters) do
        local filters = {}
        filters.content = v1
        filters.state = k1 == 1
        temp.filters[k1] = filters
      end
      DataModel.FilterData[k] = temp
    end
  end
  DataModel.View = view
  DataModel.View.Group_Filter:SetActive(false)
  RefreshView()
  view:SetActive(true)
  FromView()
end

function Filter:SetRoleData(data)
  DataModel.tempData = data
end

function Filter.OpenFilter(hasOpen)
  local length = #DataModel.FilterData
  if hasOpen then
    if DataModel.isInit then
      DataModel.View.Group_Filter.StaticGrid_Title.grid.self:SetDataCount(length)
      DataModel.View.Group_Filter.StaticGrid_Title.grid.self:RefreshAllElement()
    end
    for k, v in pairs(DataModel.FilterData) do
      local view = DataModel.View.Group_Filter["StaticGrid_" .. tostring(k)]
      view.self:SetActive(k <= length)
      if k <= length then
        view.grid.self:SetDataCount(#v.filters)
        view.grid.self:RefreshAllElement()
      end
    end
    DataModel.isInit = false
  else
    local count = 0
    for k, v in pairs(DataModel.FilterData) do
      if v.filters[1].state then
        count = count + 1
      end
    end
    local state = DataModel.EnumFilter.open
    if count == length then
      state = DataModel.EnumFilter.close
    end
    DataModel.SortData[#DataModel.SortData].state = state
    RefreshView()
  end
  DataModel.View.Group_Filter:SetActive(hasOpen)
end

function Filter.FilterElementTitle(element, index)
  element:SetText(DataModel.FilterData[index].name)
end

function Filter.FilterElementBtn(page, element, index)
  local pageData = DataModel.FilterData[page]
  local data = pageData.filters[index]
  local Txt = element.Btn_Item.Txt_Content
  local Img = element.Btn_Item.Img_Content
  if DataModel.isInit then
    if index == 1 or pageData.isImg == false then
      Img:SetActive(false)
      Txt:SetActive(true)
      Txt:SetText(data.content)
    else
      Txt:SetActive(false)
      Img:SetActive(true)
      Img:SetSprite(data.content)
    end
  end
  element.Btn_Item.Img_Select:SetActive(data.state)
end

function Filter.FilterBtn(page, index)
  local data = DataModel.FilterData[page].filters
  local length = #data
  local allIndex = 1
  if index == allIndex then
    DataModel.FilterData[page].filters[allIndex].state = true
    for i = 2, length do
      DataModel.FilterData[page].filters[i].state = false
    end
  elseif index ~= allIndex then
    if data[index].state == false then
      DataModel.FilterData[page].filters[allIndex].state = false
    end
    DataModel.FilterData[page].filters[index].state = not data[index].state
  end
  local isAllClose = true
  local count = 0
  for k, v in pairs(DataModel.FilterData[page].filters) do
    if v.state then
      isAllClose = false
      if k ~= allIndex then
        count = count + 1
      end
    end
  end
  if isAllClose or count == length - 1 then
    DataModel.FilterData[page].filters[allIndex].state = true
    for i = 2, length do
      DataModel.FilterData[page].filters[i].state = false
    end
  end
  DataModel.View.Group_Filter["StaticGrid_" .. tostring(page)].grid.self:RefreshAllElement()
end

function Filter.ConfirmBtn()
  FromView()
  Filter.OpenFilter(false)
end

function Filter.SortBtn(index)
  local filterType = EnumDefine.SortType.filter
  if DataModel.SortData[index].type == filterType then
    Filter.OpenFilter(true)
    return
  end
  for k, v in pairs(DataModel.SortData) do
    if k == index and v.type == filterType then
    else
      local state = 1
      local isActive = false
      if k == index then
        isActive = true
        if v.state == DataModel.EnumSort.up_off or v.state == DataModel.EnumSort.down_on then
          state = DataModel.EnumSort.up_on
        elseif v.state == DataModel.EnumSort.up_on or v.state == DataModel.EnumSort.down_off then
          state = DataModel.EnumSort.down_on
        end
      elseif v.type == filterType then
        state = v.state
      elseif v.state == DataModel.EnumSort.up_on then
        state = DataModel.EnumSort.up_off
      elseif v.state == DataModel.EnumSort.down_on then
        state = DataModel.EnumSort.down_off
      else
        state = v.state
      end
      DataModel.SortData[k].state = state
      DataModel.SortData[k].isActive = isActive
    end
  end
  RefreshView()
  FromView()
end

function Filter.GetSorDetail()
  return Controller:GetRoleList()
end

local home_tag = "home_tag"
local hasNotGet = 10

function Filter.RefreshHome()
  local time = TimeUtil:GetServerTimeStamp()
  local hour = tonumber(os.date("%H", time))
  local isTime = 12 <= hour
  if isTime == false and PlayerData:GetPlayerPrefs("int", home_tag) == 0 then
    PlayerData:SetPlayerPrefs("int", home_tag, hasNotGet)
  end
end

return Filter
