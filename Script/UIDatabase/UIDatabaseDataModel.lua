local View = require("UIDatabase/UIDatabaseView")
local DataModel = {}
local setTabData = function(row)
  local ca = PlayerData:GetFactoryData(row.id)
  row.coverPage = ca.coverPage
  row.icon = ca.icon
  row.interfaceUrl = ca.interfaceUrl
end

function DataModel.initData()
  DataModel.database_list = {}
  local dataTab = {}
  dataTab = PlayerData:GetFactoryData(80300040).dataTab
  DataModel.databae_info_list = nil
  DataModel.unlockcnt = 0
  DataModel.allcnt = 0
  DataModel.unlock_list = {}
  for i, v in ipairs(PlayerData.gotWord) do
    DataModel.unlock_list[v] = 1
  end
  DataModel.select1_indx = nil
  DataModel.select2_indx = nil
  DataModel.select_type = 0
  for i, v in ipairs(dataTab) do
    local row = v
    if v.name == "运营笔记" then
      local noteBookDataMode = require("UINotebook/UINotebookDataModel")
      local dataTab = PlayerData:GetFactoryData(v.id).dataTab
      row.allcnt, row.unlockcnt = noteBookDataMode.GetAllCountInfo(dataTab)
      row.new_cnt = noteBookDataMode.GetAllNewNum(dataTab)
    elseif v.name == "乘员名册" then
      row.new_cnt = PlayerData:GetNewRoleNum()
      row.allcnt = table.count(PlayerData:GetFactoryData(80900001).unitList)
      row.unlockcnt = table.count(PlayerData:GetRoles())
    elseif v.name == "敌人图鉴" then
      row.new_cnt = PlayerData:GetNewEnemiesNum()
      row.allcnt = table.count(PlayerData:GetFactoryData(80900005).unitList)
      row.unlockcnt = table.count(PlayerData:GetEnemies())
    else
      row.new_cnt = 0
      row.unlockcnt = 0
      row.allcnt = 0
      local dataTab = PlayerData:GetFactoryData(v.id).dataTab
      if dataTab then
        for i, v in ipairs(dataTab) do
          local data = PlayerData:GetFactoryData(v.id).dataTab
          for i, v in ipairs(data) do
            row.allcnt = row.allcnt + 1
            if DataModel.unlock_list[tostring(v.id)] then
              row.unlockcnt = row.unlockcnt + 1
              if PlayerData:GetPlayerPrefs("int", v.id) == 0 then
                row.new_cnt = row.new_cnt + 1
              end
            end
          end
        end
      end
    end
    setTabData(row)
    table.insert(DataModel.database_list, row)
  end
end

function DataModel.RefreshUI()
  View.ScrollGrid_Outside.grid.self:SetActive(true)
  View.ScrollGrid_Outside.grid.self:SetDataCount(table.count(DataModel.database_list))
  View.ScrollGrid_Outside.grid.self:RefreshAllElement()
end

function DataModel.GetDatabaseInfolist(select_type, data_type)
  DataModel.unlockcnt = 0
  DataModel.allcnt = 0
  DataModel.select1_indx = nil
  DataModel.select2_indx = nil
  DataModel.select_type = select_type
  DataModel.data_type = data_type
  local cfg_id = DataModel.database_list[data_type].id
  DataModel.databae_info_list = PlayerData:GetFactoryData(cfg_id).dataTab
  local first_list = PlayerData:GetFactoryData(cfg_id).dataTab
  DataModel.databae_info_list = {}
  for i, v in ipairs(first_list) do
    v.expand = false
    local data = PlayerData:GetFactoryData(v.id).dataTab
    local data_info = v
    data_info.new_cnt = 0
    local has_unlock = false
    for i, v in ipairs(data) do
      DataModel.allcnt = DataModel.allcnt + 1
      if DataModel.unlock_list[tostring(v.id)] then
        DataModel.unlockcnt = DataModel.unlockcnt + 1
        if PlayerData:GetPlayerPrefs("int", v.id) == 0 then
          data_info.new_cnt = data_info.new_cnt + 1
        end
        has_unlock = true
      end
    end
    if DataModel.select_type == 1 then
      if has_unlock then
        table.insert(DataModel.databae_info_list, data_info)
      end
    elseif DataModel.select_type == 0 then
      table.insert(DataModel.databae_info_list, data_info)
    end
  end
end

function DataModel.RefreshDatabaseInfoList(data_indx, operate_type)
  local old_data = DataModel.databae_info_list
  DataModel.databae_info_list = {}
  if operate_type == 1 then
    local new_data = PlayerData:GetFactoryData(old_data[data_indx].id).dataTab
    for i = 1, data_indx do
      table.insert(DataModel.databae_info_list, old_data[i])
    end
    local add_cnt = 0
    local front = old_data[data_indx].id
    for i, v in ipairs(new_data) do
      v.front = front
      if DataModel.select_type == 0 then
        table.insert(DataModel.databae_info_list, v)
        add_cnt = add_cnt + 1
      elseif DataModel.select_type == 1 then
        if DataModel.unlock_list[tostring(v.id)] then
          table.insert(DataModel.databae_info_list, v)
          add_cnt = add_cnt + 1
        end
      elseif DataModel.select_type == 2 and DataModel.unlock_list[tostring(v.id)] == nil then
        table.insert(DataModel.databae_info_list, v)
        add_cnt = add_cnt + 1
      end
    end
    local old_datacnt = #old_data
    if data_indx < old_datacnt then
      for i = data_indx + 1, old_datacnt do
        table.insert(DataModel.databae_info_list, old_data[i])
      end
    end
  else
    local del_data = PlayerData:GetFactoryData(old_data[data_indx].id).dataTab
    local del_cnt = 0
    for i, v in ipairs(del_data) do
      if DataModel.select_type == 0 then
        del_cnt = del_cnt + 1
      elseif DataModel.select_type == 1 then
        if DataModel.unlock_list[tostring(v.id)] then
          del_cnt = del_cnt + 1
        end
      elseif DataModel.select_type == 2 and DataModel.unlock_list[tostring(v.id)] == nil then
        del_cnt = del_cnt + 1
      end
    end
    for i, v in ipairs(old_data) do
      if data_indx >= i or i > data_indx + del_cnt then
        table.insert(DataModel.databae_info_list, v)
      elseif DataModel.select_indx == i then
        DataModel.select_indx = nil
      end
    end
  end
  old_data[data_indx].expand = operate_type == 1 and true or false
end

function DataModel.UpdateFirstNewCnt(now_idx, first_id)
  local select_id = now_idx
  if PlayerData:GetPlayerPrefs("int", DataModel.databae_info_list[select_id].id) == 0 then
    now_idx = now_idx - 1
    while 0 < now_idx and DataModel.databae_info_list[now_idx].id ~= first_id do
      now_idx = now_idx - 1
    end
    DataModel.databae_info_list[now_idx].new_cnt = DataModel.databae_info_list[now_idx].new_cnt - 1
    DataModel.database_list[DataModel.data_type].new_cnt = DataModel.database_list[DataModel.data_type].new_cnt - 1
    PlayerData:SetPlayerPrefs("int", DataModel.databae_info_list[select_id].id, 1)
  end
end

function DataModel.FormatNum(num)
  local num = math.floor(num * 10) / 10
  if num <= 0 then
    return 0
  else
    local t1, t2 = math.modf(num)
    if 0 < t2 then
      return num
    else
      return t1
    end
  end
end

function DataModel.GetRedPointState()
  for i, v in ipairs(DataModel.database_list) do
    if v.new_cnt and v.new_cnt > 0 then
      return true
    end
  end
  return false
end

return DataModel
