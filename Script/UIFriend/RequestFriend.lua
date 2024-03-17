local View = require("UIFriend/UIFriendView")
local DataModel = require("UIFriend/UIFriendDataModel")
local characterLimit = 7
local Group_Add, Group_Request
local module = {
  Load = function(self)
    Group_Request = View.Group_Request
    Group_Request.self:SetActive(true)
    Group_Request.Group_List.Group_Data.Group_Null.self:SetActive(false)
    Group_Request.Group_List.Group_Data.ScrollGrid_Friend.self:SetActive(true)
    if table.count(DataModel.SeverListData.requests_ed) == 0 then
      Group_Request.Group_List.Group_Data.Group_Null.self:SetActive(true)
      Group_Request.Group_List.Group_Data.ScrollGrid_Friend.self:SetActive(false)
      return
    end
    Group_Request.Group_List.Group_Data.ScrollGrid_Friend.grid.self:SetDataCount(table.count(DataModel.SeverListData.requests_ed))
    Group_Request.Group_List.Group_Data.ScrollGrid_Friend.grid.self:RefreshAllElement()
    DataModel.RefreshRedShow()
    DataModel.SearchTime = 0
  end,
  OpenFriendRequest = function()
    Group_Request.self:SetActive(true)
    Group_Request.Group_List.Group_Data.Group_Null.self:SetActive(false)
    Group_Request.Group_List.Group_Data.ScrollGrid_Friend.self:SetActive(false)
    if table.count(DataModel.SeverListData.requests_ed) == 0 then
      Group_Request.Group_List.Group_Data.Group_Null.self:SetActive(true)
      return
    end
    Group_Request.Group_List.Group_Data.ScrollGrid_Friend.self:SetActive(true)
    Group_Request.Group_List.Group_Data.ScrollGrid_Friend.grid.self:SetDataCount(table.count(DataModel.SeverListData.requests_ed))
    Group_Request.Group_List.Group_Data.ScrollGrid_Friend.grid.self:RefreshAllElement()
  end,
  CloseFriendRequest = function(self)
    Group_Request.self:SetActive(false)
  end,
  AgreeFriend = function(self, uid, index)
    if DataModel.IsFriendMax() then
      return CommonTips.OpenTips(80600096)
    end
    Net:SendProto("friend.accept_request", function(json)
      print_r(json)
      table.remove(DataModel.SeverListData.requests_ed, index)
      table.insert(DataModel.SeverListData.friends, DataModel.SortData(json.new_friend)[1])
      self:OpenFriendRequest()
      DataModel.RefreshRedShow()
      DataModel.TabNumRefresh()
    end, uid)
  end,
  RefuseFriend = function(self, uid, index)
    Net:SendProto("friend.refuse_request", function(json)
      print_r(json)
      table.remove(DataModel.SeverListData.requests_ed, index)
      self:OpenFriendRequest()
      DataModel.RefreshRedShow()
      DataModel.TabNumRefresh()
    end, uid)
  end,
  RequestFriend = function(self, uid, index, re_word)
    Net:SendProto("friend.add_request", function(json)
      print_r(json)
      self:RefreshSearchList()
      CommonTips.OpenTips(80600100)
    end, uid, re_word)
  end,
  DeleteFriend = function(self, uid, index)
    if not DataModel.IsFriend(uid) then
      CommonTips.OpenTips("对方不是您的好友！")
      return
    end
    local callback = function()
      Net:SendProto("friend.delete", function(json)
        print_r(json)
        table.remove(DataModel.SeverListData.friends, index)
        DataModel.RefreshList()
        CommonTips.OpenTips(80600095)
        DataModel.TabNumRefresh()
      end, uid)
    end
    CommonTips.OnPrompt("80600119", nil, nil, callback)
  end,
  JoinBlack = function(self, uid, index)
    if DataModel.IsBlackMax(uid) then
      return CommonTips.OpenTips(80600097)
    end
    local callback = function()
      Net:SendProto("friend.add_blacklist", function(json)
        print_r(json)
        DataModel.JoinBlackList(json.new_black, uid)
        self:RefreshSearchList()
        CommonTips.OpenTips(80600098)
        DataModel.TabNumRefresh()
      end, uid)
    end
    CommonTips.OnPrompt("80600114", nil, nil, callback)
  end,
  RemoveBlack = function(self, uid, index)
    local callback = function()
      Net:SendProto("friend.remove_blacklist", function(json)
        print_r(json)
        table.remove(DataModel.SeverListData.blacklist, index)
        self:RefreshSearchList()
        CommonTips.OpenTips(80600099)
        DataModel.TabNumRefresh()
      end, uid)
    end
    CommonTips.OnPrompt("80600115", nil, nil, callback)
  end
}
return module
