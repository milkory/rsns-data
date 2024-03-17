local View = require("UIFriend/UIFriendView")
local DataModel = require("UIFriend/UIFriendDataModel")
local friend_data, friend_grid
local module = {
  Load = function()
    DataModel.FriendState = true
    friend_data = View.Group_Friend.Group_Friend.Group_Data
    friend_grid = friend_data.ScrollGrid_Friend.grid
    friend_data.Group_Null.self:SetActive(false)
    friend_data.ScrollGrid_Friend.self:SetActive(true)
    if table.count(DataModel.SeverListData.friends) == 0 then
      friend_data.Group_Null.self:SetActive(true)
      friend_data.ScrollGrid_Friend.self:SetActive(false)
      return
    end
    friend_grid.self:SetDataCount(table.count(DataModel.SeverListData.friends))
    friend_grid.self:RefreshAllElement()
  end,
  DeleteFriend = function(self, uid, index)
    local callback = function()
      Net:SendProto("friend.delete", function(json)
        print_r(json)
        table.remove(DataModel.SeverListData.friends, index)
        self.Load()
        DataModel.TabNumRefresh()
        CommonTips.OpenTips(80600095)
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
        self.Load()
        DataModel.TabNumRefresh()
        CommonTips.OpenTips(80600098)
      end, uid)
    end
    CommonTips.OnPrompt("80600114", nil, nil, callback)
  end
}
return module
