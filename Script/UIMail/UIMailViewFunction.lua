local View = require("UIMail/UIMailView")
local DataModel = require("UIMail/UIMailDataModel")
local CommonItem = require("Common/BtnItem")
local Controller = require("UIMail/UIMailController")
local ShowOnlyMail = function(data, element)
  if data.reward then
    element.Group_Item.self:SetActive(true)
    element.Img_Null:SetActive(false)
    CommonItem:SetItem(element.Group_Item, data.reward[1])
    element.Txt_ExpirationTime:SetActive(true)
    element.Img_Attachment:SetActive(true)
    element.Img_ABG:SetActive(true)
    element.Txt_Attachment:SetText(string.format(GetText(80600118), table.count(data.reward)))
  else
    element.Txt_ExpirationTime:SetActive(false)
    element.Img_Attachment:SetActive(false)
    element.Group_Item.self:SetActive(false)
    element.Img_Null:SetActive(true)
    element.Img_ABG:SetActive(false)
    element.Txt_Attachment:SetText("")
  end
  element.Txt_Title:SetText(data.title)
  element.Txt_Addresser:SetText(data.from)
  element.Txt_Time:SetText(os.date("%Y/%m/%d", data.gen_time))
  element.Txt_ExpirationTime:SetText(TimeUtil:GetMailCommonDesc(data.now_time))
  element.Group_Item.Txt_Num:SetActive(false)
end
local RefreshOnlyMail = function(data, element, elementIndex)
  local Group_01 = element.Group_01
  local Group_02 = element.Group_02
  if data.read == 0 or data.recv == 0 then
    Group_02.self:SetActive(false)
    Group_01.self:SetActive(true)
    if not data.reward and data.read == 1 then
      Group_02.self:SetActive(true)
      Group_01.self:SetActive(false)
    end
  else
    Group_02.self:SetActive(true)
    Group_01.self:SetActive(false)
  end
  for i = 1, 2 do
    local obj = "Group_0" .. i
    ShowOnlyMail(data, element[obj])
    element[obj].Btn_Check:SetClickParam(elementIndex)
  end
  element.Group_01.Btn_Receive:SetClickParam(elementIndex)
end
local OpenMailDetail = function(data)
  DataModel.OpenData = data
  local Group_MailInfo_Normal
  if DataModel.ChooseIndex == 1 then
    View.Group_MailInfo_Normal.self:SetActive(true)
    Group_MailInfo_Normal = View.Group_MailInfo_Normal
    Group_MailInfo_Normal.ScrollGrid_Rewards.self:SetActive(false)
    if data.reward then
      Group_MailInfo_Normal.ScrollGrid_Rewards.self:SetActive(true)
      Group_MailInfo_Normal.ScrollGrid_Rewards.grid.self:SetDataCount(table.count(data.reward))
      Group_MailInfo_Normal.ScrollGrid_Rewards.grid.self:RefreshAllElement()
    end
    if data.recv and data.recv == 0 then
      Group_MailInfo_Normal.Btn_Receive.self:SetActive(true)
      Group_MailInfo_Normal.Btn_Delete.self:SetActive(false)
    else
      Group_MailInfo_Normal.Btn_Receive.self:SetActive(false)
      Group_MailInfo_Normal.Btn_Delete.self:SetActive(true)
    end
    Group_MailInfo_Normal.Txt_Title:SetText(data.title)
    Group_MailInfo_Normal.Txt_Addresser:SetText(data.from)
    Group_MailInfo_Normal.Txt_Time:SetText(os.date("%Y/%m/%d", data.gen_time))
    Group_MailInfo_Normal.ScrollView_Content.Viewport.Txt_Content:SetText(data.text)
    Group_MailInfo_Normal.Txt_ExpirationTime:SetText(TimeUtil:GetMailCommonDesc(data.now_time))
    Group_MailInfo_Normal.ScrollView_Content.Viewport.Txt_Content.Btn_Event.self:SetActive(false)
    if (data.id == "80800016" or data.isSpecial == true) and (data.mark == nil or data.mark ~= 1) then
      Group_MailInfo_Normal.ScrollView_Content.Viewport.Txt_Content.Btn_Event.self:SetActive(true)
      Group_MailInfo_Normal.ScrollView_Content.Viewport.Txt_Content:SetText(data.text .. "\n" .. "\n" .. "\n")
      Group_MailInfo_Normal.ScrollView_Content.Viewport.Txt_Content.Btn_Event.Txt_TXT:SetText("授权")
      if not data.reward then
        Group_MailInfo_Normal.Btn_Receive.self:SetActive(false)
      end
    end
  else
    CommonTips.OpenPreRewardDetailTips(DataModel.OpenData.reward[1].id, DataModel.OpenData)
  end
end
local OpenUnreadMailDetail = function(data)
  if data.read == 0 then
    if not data.reward then
      Net:SendProto("mail.receive_award", function(json)
        local args = {isOnekey = 0}
        Controller:OnReceiveMailAward(args)
        data.read = 1
        data.recv = 1
        OpenMailDetail(data)
        DataModel:RefreshData()
      end, tostring(data.id))
      return
    end
    Net:SendProto("mail.read", function(json)
      OpenMailDetail(data)
      DataModel:RefreshData()
    end, tostring(data.id))
  else
    OpenMailDetail(data)
  end
end
local UpdateInportmantMail = function()
  for k, v in pairs(PlayerData.ServerData.mails) do
    local ca = PlayerData:GetFactoryData(k)
    if ca.mod == "基础邮件" and v.read and v.read ~= 0 and v.recv and v.recv ~= 0 then
      PlayerData.ServerData.mails[k] = nil
    end
  end
end
local UpdateNormalMail = function()
  for k, v in pairs(PlayerData.ServerData.mails) do
    if v.read and v.read ~= 0 and v.recv and v.recv ~= 0 then
      PlayerData.ServerData.mails[k] = nil
    end
  end
end
local ViewFunction = {
  Mail_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoBack()
  end,
  Mail_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoBack()
    UIManager:GoBack()
  end,
  Mail_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Mail_Group_normal_ScrollGrid_MailList_SetGrid = function(element, elementIndex)
    local row = DataModel.NomalMails[tonumber(elementIndex)]
    RefreshOnlyMail(row, element, elementIndex)
  end,
  Mail_Group_normal_Group_Bottom_Btn_ReceiveAll_Click = function(btn, str)
    if DataModel.CanReceive_Nomal == 0 then
      CommonTips.OpenTips(80600079)
      return
    end
    Net:SendProto("mail.receive_award", function(json)
      local args = {isOnekey = 1}
      Controller:OnReceiveMailAward(args)
      DataModel:RefreshData()
      CommonTips.OpenShowItem(json.reward)
    end, "", 1)
  end,
  Mail_Group_normal_Group_Bottom_Btn_DeleteAll_Click = function(btn, str)
    if DataModel.CanDelete_Nomal == 0 then
      CommonTips.OpenTips(80600078)
      return
    end
    Net:SendProto("mail.delete", function(json)
      UpdateNormalMail()
      DataModel:RefreshData()
    end, "", 1)
  end,
  Mail_Group_MailInfo_Normal_Btn_Close_Click = function(btn, str)
  end,
  Mail_Group_MailInfo_Normal_ScrollGrid_Rewards_SetGrid = function(element, elementIndex)
    CommonItem:SetItem(element.Group_Item, DataModel.OpenData.reward[tonumber(elementIndex)], nil, 1)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    element.Img_Received:SetActive(false)
    if DataModel.OpenData.recv and DataModel.OpenData.recv ~= 0 then
      element.Img_Received:SetActive(true)
    end
  end,
  Mail_Group_MailInfo_Normal_Btn_Delete_Click = function(btn, str)
    Net:SendProto("mail.delete", function(json)
      PlayerData.ServerData.mails[tostring(DataModel.OpenData.id)] = nil
      DataModel:RefreshData()
      DataModel:CloseMailInfo()
    end, DataModel.OpenData.id)
  end,
  Mail_Group_MailInfo_Normal_Btn_Receive_Click = function(btn, str)
    if DataModel.OpenData.now_time <= 0 then
      Net:SendProto("mail.get", function(json)
        View.Group_MailInfo.self:SetActive(false)
      end)
      DataModel:RefreshData()
    end
    Net:SendProto("mail.receive_award", function(json)
      local args = {isOnekey = 0}
      Controller:OnReceiveMailAward(args)
      DataModel:RefreshData()
      DataModel.OpenData.recv = 1
      OpenMailDetail(DataModel.OpenData)
      CommonTips.OpenShowItem(json.reward)
    end, DataModel.OpenData.id)
  end,
  Mail_Group_normal_ScrollGrid_MailList_Group_Item_Group_01_Btn_Check_Click = function(btn, str)
    OpenUnreadMailDetail(DataModel.NomalMails[tonumber(str)])
  end,
  Mail_Group_normal_ScrollGrid_MailList_Group_Item_Group_01_Group_Item_Btn_Item_Click = function(btn, str)
    OpenUnreadMailDetail(DataModel.NomalMails[tonumber(str)])
  end,
  Mail_Group_normal_ScrollGrid_MailList_Group_Item_Group_01_Btn_Receive_Click = function(btn, str)
    local row = DataModel.NomalMails[tonumber(str)]
    Net:SendProto("mail.receive_award", function(json)
      local args = {isOnekey = 0}
      Controller:OnReceiveMailAward(args)
      DataModel:RefreshData()
      CommonTips.OpenShowItem(json.reward)
    end, row.id)
  end,
  Mail_Group_normal_ScrollGrid_MailList_Group_Item_Group_02_Btn_Check_Click = function(btn, str)
    OpenMailDetail(DataModel.NomalMails[tonumber(str)])
  end,
  Mail_Group_normal_ScrollGrid_MailList_Group_Item_Group_02_Group_Item_Btn_Item_Click = function(btn, str)
    OpenMailDetail(DataModel.NomalMails[tonumber(str)])
  end,
  Mail_Group_important_ScrollGrid_MailList_Group_Item_Group_01_Btn_Check_Click = function(btn, str)
    OpenUnreadMailDetail(DataModel.ImportantMails[tonumber(str)])
  end,
  Mail_Group_important_ScrollGrid_MailList_Group_Item_Group_01_Group_Item_Btn_Item_Click = function(btn, str)
    OpenUnreadMailDetail(DataModel.ImportantMails[tonumber(str)])
  end,
  Mail_Group_important_ScrollGrid_MailList_Group_Item_Group_01_Btn_Receive_Click = function(btn, str)
    local row = DataModel.ImportantMails[tonumber(str)]
    Net:SendProto("mail.receive_award", function(json)
      local args = {isOnekey = 0}
      Controller:OnReceiveMailAward(args)
      DataModel:RefreshData()
      CommonTips.OpenShowItem(json.reward)
    end, row.id)
  end,
  Mail_Group_important_ScrollGrid_MailList_Group_Item_Group_02_Btn_Check_Click = function(btn, str)
    OpenMailDetail(DataModel.ImportantMails[tonumber(str)])
  end,
  Mail_Group_important_ScrollGrid_MailList_Group_Item_Group_02_Group_Item_Btn_Item_Click = function(btn, str)
    OpenMailDetail(DataModel.ImportantMails[tonumber(str)])
  end,
  Mail_Group_important_Group_Bottom_Btn_ReceiveAll_Click = function(btn, str)
  end,
  Mail_Group_important_Group_Bottom_Btn_DeleteAll_Click = function(btn, str)
    if DataModel.CanDelete_Important == 0 then
      CommonTips.OpenTips(80600078)
      return
    end
    Net:SendProto("mail.delete", function(json)
      UpdateInportmantMail()
      DataModel:RefreshData()
    end, "", 1)
  end,
  Mail_Group_Page_Btn_normal_Click = function(btn, str)
    DataModel.ChooseIndex = 1
    DataModel:ShowMail()
    DataModel:CloseMailInfo()
  end,
  Mail_Group_Page_Btn_important_Click = function(btn, str)
    DataModel.ChooseIndex = 2
    DataModel:ShowMail()
    DataModel:CloseMailInfo()
  end,
  Mail_Group_important_ScrollGrid_MailList_SetGrid = function(element, elementIndex)
    local row = DataModel.ImportantMails[tonumber(elementIndex)]
    RefreshOnlyMail(row, element, elementIndex)
  end,
  Mail_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Mail_Group_MailInfo_Normal_ScrollGrid_Rewards_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    print_r(DataModel.OpenData.reward[tonumber(str)].id)
    CommonTips.OpenPreRewardDetailTips(DataModel.OpenData.reward[tonumber(str)].id)
  end,
  Mail_Group_MailInfo_Normal_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.Group_MailInfo_Normal.self:SetActive(false)
  end,
  Mail_Group_MailInfo_Normal_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoBack()
    UIManager:GoBack()
  end,
  Mail_Group_MailInfo_Normal_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Mail_Group_MailInfo_Normal_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Mail_Group_MailInfo_Normal_ScrollView_Content_Viewport_Txt_Content_Btn_Event_Click = function(btn, str)
    Controller:OnMailEvent()
  end,
  Mail_ShowItem_ScrollGrid_Items_SetGrid = function(element, elementIndex)
  end,
  Mail_ShowItem_Btn_OK_Click = function(btn, str)
  end,
  Mail_ShowItem_ScrollGrid_Items_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Mail_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end,
  Mail_Group_MailInfo_Normal_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end
}
return ViewFunction
