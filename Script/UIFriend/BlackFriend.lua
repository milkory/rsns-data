local View = require("UIFriend/UIFriendView")
local DataModel = require("UIFriend/UIFriendDataModel")
local black_data, black_grid
local module = {
  Load = function(self)
    black_data = View.Group_BlackList.Group_Data
    black_grid = black_data.ScrollGrid_BlackList.grid
    black_data.Group_Null.self:SetActive(false)
    black_data.ScrollGrid_BlackList.self:SetActive(true)
    if table.count(DataModel.SeverListData.blacklist) == 0 then
      black_data.Group_Null.self:SetActive(true)
      black_data.ScrollGrid_BlackList.self:SetActive(false)
      return
    end
    black_grid.self:SetDataCount(table.count(DataModel.SeverListData.blacklist))
    black_grid.self:RefreshAllElement()
  end,
  RemoveBlack = function(self, uid, index)
    local callback = function()
      Net:SendProto("friend.remove_blacklist", function(json)
        print_r(json)
        table.remove(DataModel.SeverListData.blacklist, index)
        self.Load()
        DataModel.TabNumRefresh()
        CommonTips.OpenTips(80600099)
      end, uid)
    end
    CommonTips.OnPrompt("80600115", nil, nil, callback)
  end
}
return module
