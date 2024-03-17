local View = require("UIMail/UIMailView")
local DataModel = {}
DataModel.Mails = {}
DataModel.OpenData = {}
DataModel.ChooseIndex = 1
local RefreshAllMailList = function()
  if table.count(DataModel.NomalMails) == 0 then
    View.Group_normal.ScrollGrid_MailList.self:SetActive(false)
  else
    View.Group_normal.ScrollGrid_MailList.self:SetActive(true)
    View.Group_normal.ScrollGrid_MailList.grid.self:SetDataCount(table.count(DataModel.NomalMails))
    View.Group_normal.ScrollGrid_MailList.grid.self:RefreshAllElement()
  end
  if table.count(DataModel.ImportantMails) == 0 then
    View.Group_important.ScrollGrid_MailList.self:SetActive(false)
  else
    View.Group_important.ScrollGrid_MailList.self:SetActive(true)
    View.Group_important.ScrollGrid_MailList.grid.self:SetDataCount(table.count(DataModel.ImportantMails))
    View.Group_important.ScrollGrid_MailList.grid.self:RefreshAllElement()
  end
end

function DataModel:Init()
  View.Group_normal.self:SetActive(true)
  View.Group_important.self:SetActive(false)
end

function DataModel:ShowMail()
  View.Group_Null.self:SetActive(true)
  View.Group_Null.Group_Nomal.self:SetActive(false)
  View.Group_Null.Group_Important.self:SetActive(false)
  if DataModel.ChooseIndex == 1 then
    DOTweenTools.DOLocalMoveXCallback(View.Group_Page.Img_selected.transform, -608, 0.25, function()
      if table.count(DataModel.NomalMails) == 0 then
        View.Group_Null.Group_Nomal.self:SetActive(true)
      end
      View.Group_normal.self:SetActive(true)
      View.Group_Page.Btn_normal.Group_On.self:SetActive(true)
      View.Group_Page.Btn_normal.Group_Off.self:SetActive(false)
      View.Group_Page.Btn_important.Group_On.self:SetActive(false)
      View.Group_Page.Btn_important.Group_Off.self:SetActive(true)
      View.Group_important.self:SetActive(false)
    end)
  else
    DOTweenTools.DOLocalMoveXCallback(View.Group_Page.Img_selected.transform, -264, 0.25, function()
      if table.count(DataModel.ImportantMails) == 0 then
        View.Group_Null.Group_Important.self:SetActive(true)
      end
      View.Group_normal.self:SetActive(false)
      View.Group_Page.Btn_normal.Group_On.self:SetActive(false)
      View.Group_Page.Btn_normal.Group_Off.self:SetActive(true)
      View.Group_Page.Btn_important.Group_On.self:SetActive(true)
      View.Group_Page.Btn_important.Group_Off.self:SetActive(false)
      View.Group_important.self:SetActive(true)
    end)
  end
end

function DataModel:CloseMailInfo()
  View.Group_MailInfo_Normal.self:SetActive(false)
end

function DataModel:RefreshData(index)
  if index then
    DataModel.ChooseIndex = index
  end
  DataModel.NomalMails = {}
  DataModel.ImportantMails = {}
  DataModel.CanDelete_Nomal = 0
  DataModel.CanDelete_Important = 0
  DataModel.CanReceive_Nomal = 0
  DataModel.CanReceive_Important = 0
  local count_n = 1
  local count_i = 1
  for k, v in pairs(PlayerData.ServerData.mails) do
    local front = tonumber(string.sub(k, 1, 3))
    if front == 808 then
      v.read = tonumber(v.read)
      DataModel.NomalMails[count_n] = v
      local now_time = (v.deadline or 0) - PlayerData.ServerData.server_now
      if now_time < 0 then
        now_time = 0
      end
      DataModel.NomalMails[count_n].now_time = now_time
      if v.recv == nil then
        DataModel.NomalMails[count_n].recv = 1
      end
      if v.read and v.read ~= 0 and v.recv and v.recv ~= 0 then
        DataModel.CanDelete_Nomal = DataModel.CanDelete_Nomal + 1
      end
      if v.recv and v.recv == 0 and v.reward then
        DataModel.CanReceive_Nomal = DataModel.CanReceive_Nomal + 1
      end
      v.isSpecial = false
      count_n = count_n + 1
      if v.mod and v.mod == "事件邮件" then
        v.isSpecial = true
      end
    else
      v.read = tonumber(v.read)
      DataModel.NomalMails[count_n] = v
      local now_time = (v.deadline or 0) - PlayerData.ServerData.server_now
      if now_time < 0 then
        now_time = 0
      end
      DataModel.NomalMails[count_n].now_time = now_time
      if v.recv == nil then
        DataModel.NomalMails[count_n].recv = 1
      end
      if v.read and v.read ~= 0 and v.recv and v.recv ~= 0 then
        DataModel.CanDelete_Nomal = DataModel.CanDelete_Nomal + 1
      end
      if v.recv and v.recv == 0 then
        DataModel.CanReceive_Nomal = DataModel.CanReceive_Nomal + 1
      end
      count_n = count_n + 1
    end
  end
  table.sort(DataModel.NomalMails, function(a, b)
    if a.recv ~= b.recv then
      return a.recv < b.recv
    else
      return a.gen_time > b.gen_time
    end
  end)
  table.sort(DataModel.ImportantMails, function(a, b)
    if a.recv ~= b.recv then
      return a.recv < b.recv
    else
      return a.gen_time > b.gen_time
    end
  end)
  View.Group_important.self:SetActive(true)
  View.Group_normal.self:SetActive(true)
  if DataModel.ChooseIndex == 1 then
    View.Group_important.self:SetActive(false)
  else
    View.Group_normal.self:SetActive(false)
  end
  RefreshAllMailList()
  DataModel:ShowMail()
end

return DataModel
