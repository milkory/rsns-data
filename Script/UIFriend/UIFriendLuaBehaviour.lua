local View = require("UIFriend/UIFriendView")
local DataModel = require("UIFriend/UIFriendDataModel")
local FriendInfo = require("UIFriend/FriendInfo")
local AddFriend = require("UIFriend/AddFriend")
local RequestFriend = require("UIFriend/RequestFriend")
local FriendSpace = require("UIFriend/FriendSpace")
local BlackFriend = require("UIFriend/BlackFriend")
local OtherFriendSpace = require("UIFriend/OtherFriendSpace")
local ViewFunction = require("UIFriend/UIFriendViewFunction")
local Luabehaviour = {
  serialize = function()
    return Json.encode(2)
  end,
  deserialize = function(initParams)
    local json = Json.decode(initParams)
    print_r(json)
    print_r(DataModel.TableInfo)
    if json == 2 then
      return
    end
    DataModel.TableInfo = {
      [1] = {
        view = View.Group_Friend.self,
        load = FriendInfo
      },
      [2] = {
        view = View.Group_Add.self,
        load = AddFriend
      },
      [3] = {
        view = View.Group_Request.self,
        load = RequestFriend
      },
      [4] = {
        view = View.Group_Space.self,
        load = FriendSpace
      },
      [5] = {
        view = View.Group_BlackList.self,
        load = BlackFriend
      }
    }
    DataModel.Init()
    DataModel.ConfigFactory = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    DataModel.FriendNumMax = DataModel.ConfigFactory.friendsListMax
    DataModel.BlackNumMax = DataModel.ConfigFactory.blacklistMax
    DataModel.InitData(json)
    View.Group_Right.StaticGrid_Right.grid.self:RefreshAllElement()
    ViewFunction.Friend_Group_Right_StaticGrid_Right_Group_Right_Item_Btn_Img_Click(nil, DataModel.oldIndex or 1)
    DataModel.RefreshRedShow()
    View.Group_FriendSpace.self:SetActive(false)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.SearchTime > 0 then
      DataModel.SearchTime = DataModel.SearchTime - Time.fixedDeltaTime
      View.Group_Add.Group_Top.Btn_Search.Txt_Search:SetText(math.ceil(DataModel.SearchTime) .. "S")
    else
      DataModel.SearchTime = 0
      View.Group_Add.Group_Top.Btn_Search.Txt_Search:SetText("搜索")
    end
  end,
  ondestroy = function()
    DataModel.oldIndex = nil
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
