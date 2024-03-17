local View = require("UIFriend/UIFriendView")
local DataModel = {}
DataModel.SeverData = {}
DataModel.SeverListData = {
  friends = {},
  blacklist = {},
  requests_ed = {},
  requests = {}
}
DataModel.TempRecommendData = {}
DataModel.IsSearch = false
DataModel.FriendNumMax = 1
DataModel.BlackNumMax = 1
DataModel.SearchTime = 0
DataModel.SearchInfo = {}
DataModel.MsgPermission = 0
DataModel.NowChooseInfo = {}
DataModel.Messages = {}
DataModel.FriendMessage = {}
DataModel.FriendMessageIndex = 1
DataModel.RightTable = {
  {
    txt = "好友",
    element = {}
  },
  {
    txt = "添加",
    element = {}
  },
  {
    txt = "好友申请",
    element = {}
  },
  {
    txt = "空间",
    element = {}
  },
  {
    txt = "黑名单",
    element = {}
  }
}
DataModel.ConfigFactory = {}
DataModel.TableIndex = 1
DataModel.FriendState = false
local black, friend, black_data, friend_data, black_grid, friend_grid

function DataModel.SortData(data)
  local list = {}
  if data == nil or table.count(data) == 0 then
    return list, 0
  end
  local count = 1
  for k, v in pairs(data) do
    list[count] = v
    list[count].id = k
    count = count + 1
  end
  return list, table.count(data)
end

function DataModel.InitData(json)
  DataModel.SeverData = json
  for k, v in pairs(DataModel.SeverListData) do
    v = DataModel.SortData(DataModel.SeverData[k])
    DataModel.SeverListData[k] = v
  end
end

function DataModel.RefreshFriend(element, row)
  local Group_FriendInfo = element.Group_FriendInfo
  if row.avatar ~= nil and DataModel.GetHeadPath(row.avatar) ~= nil then
    Group_FriendInfo.Img_Head:SetSprite(DataModel.GetHeadPath(row.avatar))
  else
    Group_FriendInfo.Img_Head:SetSprite(UIConfig.FriendDefaultHead)
  end
  Group_FriendInfo.Txt_Name:SetText(row.role_name)
  Group_FriendInfo.Txt_Name.Txt_UID:SetText(string.format(GetText(80600166), row.id))
  Group_FriendInfo.Group_Mark.Txt_Num:SetText(row.lv)
  local txt, state = TimeUtil:GetFriendDesc(row.login_time)
  element.Btn_LineState.Txt_LineState:SetText(txt)
  element.Btn_LineState.Img_Online:SetActive(state)
end

function DataModel.RefreshRequestFriend(element, row)
  local Group_FriendInfo = element.Group_FriendInfo
  if row.avatar ~= nil then
    Group_FriendInfo.Img_Head:SetSprite(DataModel.GetHeadPath(row.avatar))
  else
    Group_FriendInfo.Img_Head:SetSprite(UIConfig.FriendDefaultHead)
  end
  Group_FriendInfo.Txt_Name:SetText(row.role_name)
  Group_FriendInfo.Group_Mark.Txt_Num:SetText(row.lv)
  local txt, state = TimeUtil:GetFriendDesc(row.login_time)
  element.Btn_LineState.Txt_LineState:SetText(txt)
end

function DataModel.IsFriendMax()
  local friendNum = table.count(DataModel.SeverListData.friends)
  if friendNum == DataModel.FriendNumMax then
    return true
  end
  return false
end

function DataModel.IsBlackMax(uid)
  if table.count(DataModel.SeverListData.blacklist) > 0 then
    for k, v in pairs(DataModel.SeverListData.blacklist) do
      if v.id == uid then
        CommonTips.OpenTips(80600112)
        return true
      end
    end
  end
  local blackNum = table.count(DataModel.SeverListData.blacklist)
  if blackNum == DataModel.BlackNumMax then
    CommonTips.OpenTips(80600097)
    return true
  end
  return false
end

function DataModel.RefreshRedShow()
  View.Group_Right.Img_Red:SetActive(table.count(DataModel.SeverListData.requests_ed) > 0)
end

function DataModel.IsFriend(uid)
  for k, v in pairs(DataModel.SeverListData.friends) do
    if v.id == uid then
      return true, k
    end
  end
  return false
end

function DataModel.IsBlack(uid)
  for k, v in pairs(DataModel.SeverListData.blacklist) do
    if v.id == uid then
      return true, k
    end
  end
  return false
end

function DataModel.TabNumRefresh()
  for i = 1, 5 do
    local element = View.Group_Right.StaticGrid_Right.grid[i]
    if i == 1 then
      element.Btn_Img.Txt_FriendNum:SetText(table.count(DataModel.SeverListData.friends) .. "/" .. DataModel.FriendNumMax)
      element.Btn_Img.Img_Tag.Txt_FriendNum:SetText(table.count(DataModel.SeverListData.friends) .. "/" .. DataModel.FriendNumMax)
    elseif i == 5 then
      element.Btn_Img.Txt_FriendNum:SetText(table.count(DataModel.SeverListData.blacklist) .. "/" .. DataModel.BlackNumMax)
      element.Btn_Img.Img_Tag.Txt_FriendNum:SetText(table.count(DataModel.SeverListData.blacklist) .. "/" .. DataModel.BlackNumMax)
    else
      element.Btn_Img.Txt_FriendNum:SetText("")
      element.Btn_Img.Img_Tag.Txt_FriendNum:SetText("")
    end
  end
end

function DataModel.Init()
  DataModel.oldIndex = nil
  black = View.Group_BlackList
  friend = View.Group_Friend
  black_data = black.Group_Data
  friend_data = friend.Group_Friend.Group_Data
  black_grid = black_data.ScrollGrid_BlackList.grid
  friend_grid = friend_data.ScrollGrid_Friend.grid
end

function DataModel.JoinBlackList(new_black, uid)
  local fs, index = DataModel.IsFriend(uid)
  if fs then
    table.remove(DataModel.SeverListData.friends, index)
  end
  table.insert(DataModel.SeverListData.blacklist, DataModel.SortData(new_black)[1])
end

function DataModel.GetHeadPath(headId)
  if headId == nil then
    return nil
  end
  local factory = PlayerData:GetFactoryData(headId, "ProfilePhotoFactory")
  if factory == nil then
    return nil
  end
  return factory.imagePath
end

return DataModel
