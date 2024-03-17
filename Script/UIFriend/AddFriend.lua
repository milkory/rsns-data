local View = require("UIFriend/UIFriendView")
local DataModel = require("UIFriend/UIFriendDataModel")
local characterLimit = 14
local Group_Add
local module = {
  Load = function(self)
    Group_Add = View.Group_Add
    Group_Add.Group_Top.InputField_Search.self:SetText("")
    Group_Add.Group_Top.InputField_Search.self:SetCharacterLimit(characterLimit)
    Group_Add.Group_List.Group_Data.ScrollGrid_Friend.self:SetActive(false)
    Group_Add.Group_List.Group_Data.Group_Null.self:SetActive(true)
    DataModel.IsSearch = false
    DataModel.SearchTime = 0
  end,
  RefreshSearchList = function()
    Group_Add.Group_List.Group_Data.ScrollGrid_Friend.self:SetActive(true)
    Group_Add.Group_List.Group_Data.Group_Null.self:SetActive(false)
    Group_Add.Group_List.Group_Data.ScrollGrid_Friend.grid.self:SetDataCount(table.count(DataModel.SearchInfo))
    Group_Add.Group_List.Group_Data.ScrollGrid_Friend.grid.self:RefreshAllElement()
  end,
  OpenSearchList = function(self)
    local content = Group_Add.Group_Top.InputField_Search.self:GetText()
    if content == "" then
      return CommonTips.OpenTips(80600091)
    end
    Net:SendProto("friend.search", function(json)
      DataModel.SearchTime = DataModel.ConfigFactory.searchCD or 8
      local list, count = DataModel.SortData(json.search_info)
      if count ~= 0 then
        DataModel.SearchInfo = list
      end
      Group_Add.Group_Top.InputField_Search.self:SetText("")
      if table.count(DataModel.SearchInfo) == 0 then
        return CommonTips.OpenTips(80600092)
      end
      DataModel.IsSearch = true
      self:RefreshSearchList()
    end, content)
  end,
  CloseInputValue = function(self)
    Group_Add.Group_Top.InputField_Search.self:SetText("")
    DataModel.IsSearch = false
    self.Load()
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
        DataModel.TabNumRefresh()
        CommonTips.OpenTips(80600095)
      end, uid)
    end
    CommonTips.OnPrompt("80600119", nil, nil, callback)
  end,
  JoinBlack = function(self, uid)
    if DataModel.IsBlackMax(uid) == true then
      return
    end
    local callback = function()
      Net:SendProto("friend.add_blacklist", function(json)
        print_r(json)
        DataModel.JoinBlackList(json.new_black, uid)
        self:RefreshSearchList()
        DataModel.TabNumRefresh()
        CommonTips.OpenTips(80600098)
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
        DataModel.TabNumRefresh()
        CommonTips.OpenTips(80600099)
      end, uid)
    end
    CommonTips.OnPrompt("80600115", nil, nil, callback)
  end
}
return module
