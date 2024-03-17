local View = require("UIFriend/UIFriendView")
local DataModel = require("UIFriend/UIFriendDataModel")
local FriendInfo = require("UIFriend/FriendInfo")
local AddFriend = require("UIFriend/AddFriend")
local FriendSpace = require("UIFriend/FriendSpace")
local RequestFriend = require("UIFriend/RequestFriend")
local BlackFriend = require("UIFriend/BlackFriend")
local OtherFriendSpace = require("UIFriend/OtherFriendSpace")
local TempData = {}
local OpenRequestTip = function()
  local Group_AddTip = View.Group_AddTip
  Group_AddTip.self:SetActive(true)
  local default = "你好,我是" .. PlayerData:GetUserInfo().role_name .. "。"
  Group_AddTip.InputField_Add.self:SetText(default)
  Group_AddTip.InputField_Add.self:SetCharacterLimit(DataModel.ConfigFactory.requestWordMax)
end
local CloseRequestTip = function()
  View.Group_AddTip.self:SetActive(false)
end
local RefreshRightTable = function(index)
  if DataModel.oldIndex ~= nil then
    local element_old = DataModel.RightTable[DataModel.oldIndex].element
    element_old.Btn_Img.Img_Tag:SetActive(false)
    DataModel.TabNumRefresh()
    DataModel.TableInfo[DataModel.oldIndex].view:SetActive(false)
  else
    for k, v in pairs(DataModel.TableInfo) do
      v.view:SetActive(false)
    end
  end
  if DataModel.RightTable[index] then
    local element_choose = DataModel.RightTable[index].element
    element_choose.Btn_Img.Img_Tag:SetActive(true)
    element_choose.Btn_Img.Img_Tag.Txt_Tag:SetText(DataModel.RightTable[index].txt)
    DataModel.TabNumRefresh()
  end
  DataModel.TableInfo[index].view:SetActive(true)
  DataModel.TableInfo[index].load:Load()
  View.Group_AddTip.self:SetActive(false)
  View.Group_Reply.self:SetActive(false)
  DataModel.oldIndex = index
end
local ViewFunction = {
  Friend_Group_Right_StaticGrid_Right_SetGrid = function(element, elementIndex)
    local row = DataModel.RightTable[tonumber(elementIndex)]
    element.Btn_Img.Txt_Tag:SetText(row.txt)
    element.Btn_Img.Img_Tag:SetActive(false)
    element.Btn_Img:SetClickParam(elementIndex)
    if tonumber(elementIndex) == 1 then
      element.Btn_Img.Txt_FriendNum:SetText(table.count(DataModel.SeverListData.friends) .. "/" .. DataModel.FriendNumMax)
    elseif tonumber(elementIndex) == 5 then
      element.Btn_Img.Txt_FriendNum:SetText(table.count(DataModel.SeverListData.blacklist) .. "/" .. DataModel.BlackNumMax)
    else
      element.Btn_Img.Txt_FriendNum:SetText("")
    end
    row.element = element
  end,
  Friend_Group_Right_StaticGrid_Right_Group_Right_Item_Btn_Img_Click = function(btn, str)
    DataModel.TableIndex = tonumber(str)
    if DataModel.oldIndex == DataModel.TableIndex then
      return
    end
    RefreshRightTable(tonumber(str))
  end,
  Friend_Group_Right_Group_Right_Item_Btn_Img_Click = function(btn, str)
  end,
  Friend_Group_Friend_Group_Friend_Group_Data_ScrollGrid_Friend_SetGrid = function(element, elementIndex)
    local row = DataModel.SeverListData.friends[tonumber(elementIndex)]
    local Group_Pop = element.Group_Pop
    Group_Pop.self:SetActive(false)
    element.Group_Pop.Img_Bg.Btn_Visit:SetClickParam(elementIndex)
    element.Btn_More:SetClickParam(elementIndex)
    Group_Pop.Img_Bg.Btn_Delete:SetClickParam(elementIndex)
    Group_Pop.Img_Bg.Btn_JoinBlack:SetClickParam(elementIndex)
    Group_Pop.Img_Bg.Btn_Des:SetClickParam(elementIndex)
    DataModel.RefreshFriend(element, row)
  end,
  Friend_Group_Add_Group_Top_Btn_Close_Click = function(btn, str)
    AddFriend:CloseInputValue()
  end,
  Friend_Group_Add_Group_Top_Btn_Search_Click = function(btn, str)
    if DataModel.SearchTime ~= 0 then
      return
    end
    AddFriend:OpenSearchList()
  end,
  Friend_Group_Add_Group_List_Group_Data_ScrollGrid_Friend_SetGrid = function(element, elementIndex)
    if DataModel.IsSearch then
      element.Btn_AlreadyAdd.self:SetActive(true)
      element.Btn_Add.self:SetActive(true)
      local row = DataModel.SearchInfo[tonumber(elementIndex)]
      element.Btn_AlreadyAdd.self:SetActive(DataModel.SeverData.friends[tostring(row.id)])
      element.Btn_Add.self:SetActive(not DataModel.SeverData.friends[tostring(row.id)])
      element.Btn_Visit.self:SetActive(tonumber(row.id) ~= tonumber(PlayerData.ServerData.user_info.uid))
      element.Btn_More.self:SetActive(tonumber(row.id) ~= tonumber(PlayerData.ServerData.user_info.uid))
      if row.id == PlayerData.ServerData.uid then
        element.Btn_AlreadyAdd.self:SetActive(false)
        element.Btn_Add.self:SetActive(false)
      end
      element.Group_Pop:SetActive(false)
      DataModel.RefreshFriend(element, row)
    else
      local row = DataModel.TempRecommendData[tonumber(elementIndex)]
    end
    element.Btn_Add:SetClickParam(elementIndex)
    element.Btn_AlreadyAdd:SetClickParam(elementIndex)
    element.Btn_Visit:SetClickParam(elementIndex)
    element.Btn_More:SetClickParam(elementIndex)
    local Group_Pop = element.Group_Pop
    Group_Pop.self:SetActive(false)
    Group_Pop.Img_Bg.Btn_Delete:SetClickParam(elementIndex)
    Group_Pop.Img_Bg.Btn_JoinBlack:SetClickParam(elementIndex)
    Group_Pop.Img_Bg.Btn_Des:SetClickParam(elementIndex)
  end,
  Friend_Group_Add_Group_List_Group_Data_ScrollGrid_Friend_Group_Add_Friend_Btn_Add_Click = function(btn, str)
    TempData = {}
    local row = DataModel.SearchInfo[tonumber(str)]
    TempData = row
    TempData.index = tonumber(str)
    OpenRequestTip()
  end,
  Friend_Group_Add_Group_List_Group_Data_ScrollGrid_Friend_Group_Add_Friend_Btn_Visit_Click = function(btn, str)
    local row = DataModel.SearchInfo[tonumber(str)]
    DataModel.NowChooseInfo = row
    OtherFriendSpace:Load()
  end,
  Friend_Group_Add_Group_List_Group_Data_ScrollGrid_Friend_Group_Add_Friend_Btn_More_Click = function(btn, str)
    local element = View.Group_Add.Group_List.Group_Data.ScrollGrid_Friend.grid[tonumber(str)]
    if element.Group_Pop.self.IsActive then
      element.Group_Pop.self:SetActive(false)
    else
      element.Group_Pop.self:SetActive(true)
    end
    local row = DataModel.SearchInfo[tonumber(str)]
    local Btn_JoinBlack = element.Group_Pop.Img_Bg.Btn_JoinBlack
    if DataModel.IsBlack(row.id) then
      Btn_JoinBlack.Txt_Join:SetText("移除黑名单")
    else
      Btn_JoinBlack.Txt_Join:SetText("加入黑名单")
    end
  end,
  Friend_Group_Add_Group_List_Group_Data_ScrollGrid_Friend_Group_Add_Friend_Btn_LineState_Click = function(btn, str)
  end,
  Friend_Group_Add_Group_List_Group_Data_ScrollGrid_Friend_Group_Add_Friend_Group_Pop_Img_Bg_Btn_Delete_Click = function(btn, str)
    local row = DataModel.SearchInfo[tonumber(str)]
    AddFriend:DeleteFriend(row.id, tonumber(str))
  end,
  Friend_Group_Add_Group_List_Group_Data_ScrollGrid_Friend_Group_Add_Friend_Group_Pop_Img_Bg_Btn_JoinBlack_Click = function(btn, str)
    local row = DataModel.SearchInfo[tonumber(str)]
    local state, index = DataModel.IsBlack(row.id)
    if state then
      BlackFriend:RemoveBlack(row.id, index)
    else
      AddFriend:JoinBlack(row.id)
    end
  end,
  Friend_Group_Add_Group_List_Group_Data_ScrollGrid_Friend_Group_Add_Friend_Group_Pop_Img_Bg_Btn_Des_Click = function(btn, str)
  end,
  Friend_Group_Add_Group_List_Group_Data_ScrollGrid_Friend_Group_Add_Friend_Btn_AlreadyAdd_Click = function(btn, str)
  end,
  Friend_Group_Space_Group_Right_Group_Middle_Group_Push_Group_Show_Group_Init_001_Btn_Choose_Click = function(btn, str)
    FriendSpace:SendPermission(0)
  end,
  Friend_Group_Space_Group_Right_Group_Middle_Group_Push_Group_Show_Group_Init_002_Btn_Choose_Click = function(btn, str)
    FriendSpace:SendPermission(1)
  end,
  Friend_Group_Space_Group_Right_Group_Middle_Group_Push_Group_Init_Btn_Push_Click = function(btn, str)
    FriendSpace:RefreshPushShow()
  end,
  Friend_Group_Space_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_SetGrid = function(element, elementIndex)
    local row = DataModel.Messages[tonumber(elementIndex)]
    if row.avatar ~= nil and DataModel.GetHeadPath(row.avatar) ~= nil then
      element.Btn_Head.Img_Head:SetSprite(DataModel.GetHeadPath(row.avatar))
    else
      element.Btn_Head.Img_Head:SetSprite(UIConfig.FriendDefaultHead)
    end
    element.Txt_Lv:SetText(row.lv or 1)
    element.Txt_Time:SetText(os.date("%Y-%m-%d", row.time))
    element.Group_Middle.Txt_Name:SetText(row.role_name or "")
    if row.replied_rolename and row.replied_rolename ~= "" then
      element.Group_Middle.Txt_Board:SetText("回复" .. "<color=#FFC14B>" .. row.replied_rolename .. "</color>" .. ":" .. row.content)
    else
      element.Group_Middle.Txt_Board:SetText(row.content)
    end
    element.Group_More:SetActive(false)
    element.Btn_Delete:SetClickParam(elementIndex)
    element.Btn_Reply:SetClickParam(elementIndex)
    element.Btn_Head:SetClickParam(elementIndex)
    local Group_More = element.Group_More
    Group_More.self:SetActive(false)
    Group_More.Btn_Add:SetClickParam(elementIndex)
    Group_More.Btn_Black:SetClickParam(elementIndex)
    Group_More.Btn_Visit:SetClickParam(elementIndex)
    row.element = element
  end,
  Friend_Group_Space_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Btn_Head_Click = function(btn, str)
    local element = DataModel.Messages[tonumber(str)].element
    local row = DataModel.Messages[tonumber(str)]
    if row.uid == PlayerData:GetUserInfo().uid then
      return
    end
    if element.Group_More.IsActive then
      element.Group_More:SetActive(false)
    else
      element.Group_More:SetActive(true)
    end
  end,
  Friend_Group_Space_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Btn_Delete_Click = function(btn, str)
    FriendSpace:DeleteMessage(tonumber(str))
  end,
  Friend_Group_Space_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Btn_Reply_Click = function(btn, str)
    local row = DataModel.Messages[tonumber(str)]
    DataModel.FriendMessageIndex = tonumber(str)
    FriendSpace:OpenReplyMessagePage(row)
  end,
  Friend_Group_Space_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Group_More_Btn_Visit_Click = function(btn, str)
    local row = DataModel.Messages[tonumber(str)]
    DataModel.NowChooseInfo = row
    DataModel.NowChooseInfo.id = row.uid
    OtherFriendSpace:Load()
  end,
  Friend_Group_Space_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Group_More_Btn_Add_Click = function(btn, str)
    TempData = {}
    local row = DataModel.Messages[tonumber(str)]
    TempData = row
    TempData.index = tonumber(str)
    OpenRequestTip()
  end,
  Friend_Group_Space_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Group_More_Btn_Black_Click = function(btn, str)
    local row = DataModel.Messages[tonumber(str)]
    FriendSpace:JoinBlack(row.uid)
  end,
  Friend_Group_AddTip_Btn_Cancel_Click = function(btn, str)
    CloseRequestTip()
  end,
  Friend_Group_AddTip_Btn_Request_Click = function(btn, str)
    local content = View.Group_AddTip.InputField_Add.self:GetText()
    AddFriend:RequestFriend(TempData.id, TempData.index, content)
    CloseRequestTip()
  end,
  Friend_Group_Space_Group_Right_Group_Bottom_Btn_Board_Click = function(btn, str)
    local content = View.Group_Space.Group_Right.Group_Bottom.InputField_Board.self:GetText()
    View.Group_Space.Group_Right.Group_Bottom.InputField_Board.self:SetCharacterLimit(20)
    if content == nil or content == "" then
      CommonTips.OpenTips(80600101)
      return
    end
    FriendSpace:LeaveMessage(content)
  end,
  Friend_Group_FriendSpace_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_SetGrid = function(element, elementIndex)
    local row = DataModel.FriendMessage[tonumber(elementIndex)]
    if row.avatar ~= nil and DataModel.GetHeadPath(row.avatar) ~= nil then
      element.Btn_Head.Img_Head:SetSprite(DataModel.GetHeadPath(row.avatar))
    else
      element.Btn_Head.Img_Head:SetSprite(UIConfig.FriendDefaultHead)
    end
    element.Txt_Lv:SetText(row.lv)
    element.Txt_Time:SetText(os.date("%Y-%m-%d", row.time))
    element.Group_Middle.Txt_Name:SetText(row.role_name)
    element.Group_Middle.Txt_Board:SetText(row.content or "")
    element.Group_More:SetActive(false)
    element.Btn_Delete.self:SetActive(false)
    element.Btn_Reply.self:SetActive(false)
  end,
  Friend_Group_FriendSpace_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Btn_Head_Click = function(btn, str)
  end,
  Friend_Group_FriendSpace_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Btn_Reply_Click = function(btn, str)
  end,
  Friend_Group_FriendSpace_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Group_More_Btn_Add_Click = function(btn, str)
  end,
  Friend_Group_FriendSpace_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Group_More_Btn_Black_Click = function(btn, str)
  end,
  Friend_Group_FriendSpace_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Group_More_Btn_Visit_Click = function(btn, str)
  end,
  Friend_Group_FriendSpace_Group_Right_Group_Bottom_Btn_Board_Click = function(btn, str)
    local content = View.Group_FriendSpace.Group_Right.Group_Bottom.InputField_Board.self:GetText()
    View.Group_FriendSpace.Group_Right.Group_Bottom.InputField_Board.self:SetCharacterLimit(20)
    if content == nil or content == "" then
      CommonTips.OpenTips(80600101)
      return
    end
    OtherFriendSpace:LeaveMessage(content)
  end,
  Friend_Group_FriendSpace_Group_Right_Group_Middle_Group_Content_ScrollGrid_Board_Group_Board_Btn_Delete_Click = function(btn, str)
    OtherFriendSpace:DeleteMessage(tonumber(str))
  end,
  Friend_Group_Reply_Btn_Board_Click = function(btn, str)
    FriendSpace:ReplyMessage()
  end,
  Friend_Group_Reply_Btn_Mask_Click = function(btn, str)
    View.Group_Reply.self:SetActive(false)
  end,
  Friend_Group_Friend_Group_Friend_Group_Data_ScrollGrid_Friend_Group_Friend_Item_Btn_More_Click = function(btn, str)
    local element = View.Group_Friend.Group_Friend.Group_Data.ScrollGrid_Friend.grid[tonumber(str)]
    if element.Group_Pop.self.IsActive then
      element.Group_Pop.self:SetActive(false)
    else
      element.Group_Pop.self:SetActive(true)
    end
  end,
  Friend_Group_Friend_Group_Friend_Group_Data_ScrollGrid_Friend_Group_Friend_Item_Btn_LineState_Click = function(btn, str)
  end,
  Friend_Group_Friend_Group_Friend_Group_Data_ScrollGrid_Friend_Group_Friend_Item_Group_Pop_Img_Bg_Btn_Delete_Click = function(btn, str)
    local row = DataModel.SeverListData.friends[tonumber(str)]
    FriendInfo:DeleteFriend(row.id, tonumber(str))
  end,
  Friend_Group_Friend_Group_Friend_Group_Data_ScrollGrid_Friend_Group_Friend_Item_Group_Pop_Img_Bg_Btn_JoinBlack_Click = function(btn, str)
    local row = DataModel.SeverListData.friends[tonumber(str)]
    FriendInfo:JoinBlack(row.id, tonumber(str))
  end,
  Friend_Group_Friend_Group_Friend_Group_Data_ScrollGrid_Friend_Group_Friend_Item_Group_Pop_Img_Bg_Btn_Des_Click = function(btn, str)
  end,
  Friend_Group_Friend_Group_Friend_Group_Data_ScrollGrid_Friend_Group_Friend_Item_Group_Pop_Img_Bg_Btn_Visit_Click = function(btn, str)
    local row = DataModel.SeverListData.friends[tonumber(str)]
    DataModel.NowChooseInfo = row
    OtherFriendSpace:Load()
  end,
  Friend_Group_Add_Group_List_Group_Data_ScrollGrid_Friend_Group_Add_Friend_Group_Pop_Img_Bg_Btn_Visit_Click = function(btn, str)
  end,
  Friend_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_SetGrid = function(element, elementIndex)
    local row = DataModel.SeverListData.requests_ed[tonumber(elementIndex)]
    DataModel.RefreshRequestFriend(element, row)
    element.Group_FriendInfo.Txt_RequestInfo:SetText(row.ask_msg or "")
    element.Btn_Agree:SetClickParam(elementIndex)
    element.Btn_Refuse:SetClickParam(elementIndex)
    element.Btn_Visit:SetClickParam(elementIndex)
    element.Btn_More:SetClickParam(elementIndex)
    local Group_Pop = element.Group_Pop
    Group_Pop.self:SetActive(false)
    Group_Pop.Img_Bg.Btn_Delete:SetClickParam(elementIndex)
    Group_Pop.Img_Bg.Btn_JoinBlack:SetClickParam(elementIndex)
  end,
  Friend_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Btn_Agree_Click = function(btn, str)
    local row = DataModel.SeverListData.requests_ed[tonumber(str)]
    RequestFriend:AgreeFriend(row.id, tonumber(str))
  end,
  Friend_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Btn_Refuse_Click = function(btn, str)
    local row = DataModel.SeverListData.requests_ed[tonumber(str)]
    RequestFriend:RefuseFriend(row.id, tonumber(str))
  end,
  Friend_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Btn_Visit_Click = function(btn, str)
    local row = DataModel.SeverListData.requests_ed[tonumber(str)]
    DataModel.NowChooseInfo = row
    OtherFriendSpace:Load()
  end,
  Friend_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Btn_More_Click = function(btn, str)
    local element = View.Group_Request.Group_List.Group_Data.ScrollGrid_Friend.grid[tonumber(str)]
    if element.Group_Pop.self.IsActive then
      element.Group_Pop.self:SetActive(false)
    else
      element.Group_Pop.self:SetActive(true)
    end
  end,
  Friend_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Btn_LineState_Click = function(btn, str)
  end,
  Friend_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Group_Pop_Img_Bg_Btn_Delete_Click = function(btn, str)
    local row = DataModel.SeverListData.requests_ed[tonumber(str)]
    FriendInfo:DeleteFriend(row.id, tonumber(str))
  end,
  Friend_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Group_Pop_Img_Bg_Btn_JoinBlack_Click = function(btn, str)
    local row = DataModel.SeverListData.requests_ed[tonumber(str)]
    FriendInfo:JoinBlack(row.id, tonumber(str))
  end,
  Friend_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Group_Pop_Img_Bg_Btn_Des_Click = function(btn, str)
  end,
  Friend_Group_BlackList_Group_Data_ScrollGrid_BlackList_SetGrid = function(element, elementIndex)
    local row = DataModel.SeverListData.blacklist[tonumber(elementIndex)]
    element.Btn_Remove:SetClickParam(elementIndex)
    DataModel.RefreshFriend(element, row)
  end,
  Friend_Group_BlackList_Group_Data_ScrollGrid_BlackList_Group_Black_Item_Btn_Remove_Click = function(btn, str)
    local row = DataModel.SeverListData.blacklist[tonumber(str)]
    BlackFriend:RemoveBlack(row.id, tonumber(str))
  end,
  Friend_Group_BlackList_Group_Data_ScrollGrid_BlackList_Group_Black_Item_Btn_LineState_Click = function(btn, str)
  end,
  Friend_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoBack()
  end,
  Friend_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoHome()
  end,
  Friend_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Friend_Group_FriendSpace_Group_Right_Group_Middle_Group_Push_Group_Show_Group_Init_001_Btn_Choose_Click = function(btn, str)
  end,
  Friend_Group_FriendSpace_Group_Right_Group_Middle_Group_Push_Group_Show_Group_Init_002_Btn_Choose_Click = function(btn, str)
  end,
  Friend_Group_FriendSpace_Group_Right_Group_Middle_Group_Push_Group_Init_Btn_Push_Click = function(btn, str)
  end,
  Friend_Group_FriendSpace_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.Group_FriendSpace.self:SetActive(false)
  end,
  Friend_Group_FriendSpace_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Friend_Group_FriendSpace_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Friend_Group_BlackList_Group_Data_ScrollGrid_BlackList_Group_Black_Item_Group_Friend_Item_Btn_LineState_Click = function(btn, str)
  end,
  Friend_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Friend_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end,
  Friend_Group_FriendSpace_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Friend_Group_FriendSpace_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end,
  Friend_Group_Friend_Group_Friend_Group_Data_ScrollGrid_Friend_Group_Item_Btn_More_Click = function(btn, str)
    local element = View.Group_Friend.Group_Friend.Group_Data.ScrollGrid_Friend.grid[tonumber(str)]
    if element.Group_Pop.self.IsActive then
      element.Group_Pop.self:SetActive(false)
    else
      element.Group_Pop.self:SetActive(true)
    end
  end,
  Friend_Group_Friend_Group_Friend_Group_Data_ScrollGrid_Friend_Group_Item_Btn_LineState_Click = function(btn, str)
  end,
  Friend_Group_Friend_Group_Friend_Group_Data_ScrollGrid_Friend_Group_Item_Group_Pop_Img_Bg_Btn_Des_Click = function(btn, str)
  end,
  Friend_Group_Friend_Group_BlackList_Group_Data_ScrollGrid_BlackList_Group_Black_Item_Btn_LineState_Click = function(btn, str)
  end,
  Friend_Group_Top_Btn_Help_Click = function(btn, str)
  end,
  Friend_Group_Add_Group_Middle_Btn_Request_Click = function(btn, str)
    AddFriend:OpenFriendRequest()
  end,
  Friend_Group_Add_Group_Middle_Btn_Recommend_Click = function(btn, str)
  end,
  Friend_Group_Add_Group_Request_Btn_Request_Click = function(btn, str)
  end,
  Friend_Group_Add_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Btn_LineState_Click = function(btn, str)
  end,
  Friend_Group_Add_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Group_Pop_Img_Bg_Btn_Delete_Click = function(btn, str)
  end,
  Friend_Group_Add_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Group_Pop_Img_Bg_Btn_JoinBlack_Click = function(btn, str)
  end,
  Friend_Group_Add_Group_Request_Group_List_Group_Data_ScrollGrid_Friend_Group_Friend_Request_Group_Pop_Img_Bg_Btn_Des_Click = function(btn, str)
  end,
  Friend_Group_Add_Group_Request_Group_Top_Btn_Help_Click = function(btn, str)
  end,
  Friend_Group_Add_Group_Request_Btn_Back_Click = function(btn, str)
    AddFriend.CloseFriendRequest()
  end,
  Friend_Group_FriendSpace_Btn_Close_Click = function(btn, str)
    View.Group_FriendSpace.self:SetActive(false)
  end
}
return ViewFunction
