local View = require("UISignIn/UISignInView")
local DataModel = require("UISignIn/UISignInDataModel")
local Controll = require("UISignIn/Controller_UISignln")
local temporary_data = {}
local Refresh_Tag_Grid = function()
  local row = Controller_UISignln.Tag_Left_Table
  local old = row.old
  local choose = row.choose
  if table.count(old) ~= 0 then
    old.element.Btn_Bottom.self:SetActive(true)
    old.element.Img_BottomSelect.self:SetActive(false)
  end
  choose.element.Btn_Bottom.self:SetActive(false)
  choose.element.Img_BottomSelect.self:SetActive(true)
  choose.element.Img_BottomSelect.Txt_BottomSelect:SetText(choose.title)
end
local tag_obj = {
  activeSigninList = View.Group_EventSignIn,
  dailySigninList = View.Group_DailySignIn
}
local Refresh_Middle_Grid = function(str)
  for k, v in pairs(Controller_UISignln.Tag_Left_Table.content) do
    if tag_obj[k] ~= nil then
      tag_obj[k].self:SetActive(false)
    end
    if k == str and tag_obj[k] then
      tag_obj[k].self:SetActive(true)
      temporary_data = Controller_UISignln.Tag_Left_Table.content[k][1]
    end
  end
  if str == "activeSigninList" then
    Controller_UISignln.InitActiveGrid()
  elseif str == "dailySigninList" then
    Controller_UISignln.InitDayGrid(temporary_data.list.SigninAwardList)
  end
end
local ViewFunction = {
  SignIn_Group_EventSignIn_StaticGrid_Board_SetGrid = function(element, elementIndex)
    local row = DataModel.Config.SigninAwardList[tonumber(elementIndex)]
    element.Img_Mark:SetActive(false)
    element.BtnPolygon_BG:SetSprite(row.sealPic)
    element.BtnPolygon_BG:SetClickParam(elementIndex)
    element.Img_Oh:SetActive(false)
    local sign = PlayerData:GetSignInfo()[tostring(DataModel.Config.id)]
    if tonumber(elementIndex) <= sign.count then
      element.Img_Mark:SetActive(true)
    else
      element.Img_Mark:SetActive(false)
    end
    if tonumber(elementIndex) == sign.count + 1 and sign.status == 0 then
      element.Img_Oh:SetActive(true)
    end
  end,
  SignIn_Btn_Close_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoBack()
  end,
  SignIn_Group_Left_Tag_StaticGrid_Tag_SetGrid = function(element, elementIndex)
    element.Btn_Bottom.self:SetClickParam(elementIndex)
    if elementIndex > table.count(Controller_UISignln.Tag_Left_Table.content) then
      element.self:SetActive(false)
      return
    end
    local row = Controller_UISignln.Tag_Left_Table.content[Controller_UISignln.Xml_Data[tonumber(elementIndex)].key][1]
    row.element = element
    element.self:SetActive(true)
    element.Btn_Bottom.Txt_Bottom:SetText(row.title)
    element.Img_BottomSelect.self:SetActive(false)
  end,
  SignIn_Group_DailySignIn_ScrollGrid_Daily_SetGrid = function(element, elementIndex)
    local row = temporary_data.list.SigninAwardList[tonumber(elementIndex)]
    local itemData = PlayerData:GetFactoryData(row.itemid, "ItemFactory")
    element.self:SetActive(true)
    element.Btn_Icon:SetClickParam(elementIndex)
    element.Btn_Icon:SetSprite(itemData.iconPath)
    element.Img_Oh:SetActive(false)
    element.Img_Mark:SetActive(false)
    element.Img_Number.Txt_Number:SetText(row.itemNum)
    row.element = element
    row.isSign = false
    row.isNew = false
    table.insert(Controller_UISignln.Month_Table, elementIndex, {
      element = element,
      index = elementIndex,
      isSign = false
    })
  end,
  SignIn_Group_DailySignIn_ScrollGrid_Daily_Group_Item_Btn_Icon_Click = function(btn, str)
    local row = temporary_data.list.SigninAwardList[tonumber(str)]
    local element = row.element
    row.isSign = not row.isSign
    row.isNew = not row.isNew
    element.Img_Mark:SetActive(row.isSign)
    element.Img_Mark:SetLocalEulerAngles(math.random(-45, 45))
  end,
  SignIn_Group_DailySignIn_Btn_SignIn_Click = function(btn, str)
  end,
  SignIn_Group_EventSignIn_Group_Decorate_Btn_Details_Click = function(btn, str)
    CommonTips.OpenUnitDetail({id = 10000298, type = 1})
  end,
  SignIn_Group_EventSignIn_StaticGrid_Board_Group_Item_BtnPolygon_BG_Click = function(btn, str)
    local index = tonumber(str)
    local sign = PlayerData:GetSignInfo()[tostring(DataModel.Config.id)]
    if sign then
      if sign.status == 1 then
        if index <= sign.count then
          CommonTips.OpenTips(80600191)
          return
        else
          CommonTips.OpenTips(80600194)
          return
        end
      elseif index == sign.count + 1 then
        if sign.status == 1 then
          CommonTips.OpenTips(80600191)
          return
        end
        Net:SendProto("main.sign_in", function(json)
          if json.reward.role then
            for k, v in pairs(json.reward.role) do
              local ca = PlayerData:GetFactoryData(k)
              local hero_list = {}
              hero_list.hero_id = ca.id
              hero_list.hero_name = ca.name
              hero_list.event_seq = "main.sign_in"
              hero_list.get_times = PlayerData:GetSeverTime()
              print_r(hero_list)
              print_r("fdhsakfl;hdas;klfha;slkfha;sdklhfa")
              ReportTrackEvent.hero_get(hero_list)
            end
          end
          View.Group_EventSignIn.StaticGrid_Board.grid[index].Img_Mark:SetActive(true)
          View.Group_EventSignIn.StaticGrid_Board.grid[index].Img_Oh:SetActive(false)
          CommonTips.OpenShowItem(json.reward)
          PlayerData.ServerData.sign_info = json.user_info.sign_info
        end, DataModel.Config.id)
      elseif index < sign.count + 1 then
        CommonTips.OpenTips(80600191)
        return
      else
        CommonTips.OpenTips(80600194)
        return
      end
    end
  end,
  SignIn_Group_Left_Tag_StaticGrid_Tag_Group__Btn_Bottom_Click = function(btn, str)
  end,
  SignIn_Btn_BG_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoBack()
  end,
  SignIn_Group_EventSignIn_ScrollGrid_Board_SetGrid = function(element, elementIndex)
    local row = DataModel.Config.SigninAwardList[tonumber(elementIndex)]
    local Group_Item = element.Group_Item
    Group_Item.Img_Icon:SetSprite(row.sealPic)
    Group_Item.Img_Mark:SetActive(false)
    Group_Item.BtnPolygon_BG:SetClickParam(elementIndex)
    Group_Item.Img_Oh:SetActive(false)
    local sign = PlayerData:GetSignInfo()[tostring(DataModel.Config.id)]
    if tonumber(elementIndex) <= sign.count then
      Group_Item.Img_Mark:SetActive(true)
    else
      Group_Item.Img_Mark:SetActive(false)
    end
    if tonumber(elementIndex) == sign.count + 1 and sign.status == 0 then
      Group_Item.Img_Oh:SetActive(true)
    end
    row.element = element
  end,
  SignIn_Group_EventSignIn_ScrollGrid_Board_Group_Item_Group_Item_BtnPolygon_BG_Click = function(btn, str)
    local index = tonumber(str)
    local sign = PlayerData:GetSignInfo()[tostring(DataModel.Config.id)]
    local row = DataModel.Config.SigninAwardList[index]
    local element = row.element
    local id = DataModel.Config.id
    if sign then
      if sign.status == 1 then
        if index <= sign.count then
          CommonTips.OpenTips(80600191)
          return
        else
          CommonTips.OpenTips(80600194)
          return
        end
      elseif index == sign.count + 1 then
        if sign.status == 1 then
          CommonTips.OpenTips(80600191)
          return
        end
        Net:SendProto("main.sign_in", function(json)
          SdkReporter.TrackSignReward({
            id = id,
            day = sign.count + 1
          })
          if json.reward.role then
            for k, v in pairs(json.reward.role) do
              local ca = PlayerData:GetFactoryData(k)
              local hero_list = {}
              hero_list.hero_id = ca.id
              hero_list.hero_name = ca.name
              hero_list.event_seq = "main.sign_in"
              hero_list.get_times = PlayerData:GetSeverTime()
              ReportTrackEvent.hero_get(hero_list)
            end
          end
          element.Group_Item.Img_Mark:SetActive(true)
          element.Group_Item.Img_Oh:SetActive(false)
          CommonTips.OpenShowItem(json.reward)
          PlayerData.ServerData.sign_info = json.user_info.sign_info
        end, DataModel.Config.id)
      elseif index < sign.count + 1 then
        CommonTips.OpenTips(80600191)
        return
      else
        CommonTips.OpenTips(80600194)
        return
      end
    end
  end
}
return ViewFunction
