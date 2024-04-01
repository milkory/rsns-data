local View = require("UIStore/UIStoreView")
local DataModel = require("UIStore/UIStoreDataModel")
local CommonItem = require("Common/BtnItem")
local buy_num = 1
local buy_price, all_num, gird_daily, gird_dimond, grid_daily_reward, grid_gold_reward, grid_gold, grid_gift, grid_role
local last_auto_refresh = 0
local refresh_state = false
local freeCount
local now_item_info = {}
local GetCurrency = function(id)
  if id == 11400001 then
    return PlayerData:GetUserInfo().gold
  end
  if id == 11400005 then
    return PlayerData:GetUserInfo().bm_rock
  end
  return 0
end
local get_dimond_grid = function()
  if not gird_dimond then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_DiamondStore")
    gird_dimond = View.Group_DiamondStore.ScrollGrid_List.grid.self
  end
  return gird_dimond
end
local get_day_grid = function()
  if not gird_daily then
    gird_daily = View.Group_DailyStore.StaticGrid_List.grid.self
  end
  return gird_daily
end
local get_gold_grid = function()
  if not grid_gold then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_GoldStore")
    grid_gold = View.Group_GoldStore.StaticGrid_List.grid.self
  end
  return grid_gold
end
local get_gift_grid = function()
  if not grid_gift then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_GiftStore")
    grid_gift = View.Group_GiftStore.ScrollGrid_List.grid.self
  end
  return grid_gift
end
local get_role_grid = function()
  if not grid_role then
    grid_role = View.Group_RoleStore.StaticGrid_List.grid.self
  end
  return grid_role
end
local get_reward_daily_grid = function()
  if not grid_daily_reward then
    grid_daily_reward = View.Group_DailyStore.Group_Reward.StaticGrid_Box.grid.self
  end
  return grid_daily_reward
end
local get_reward_gold_grid = function()
  if not grid_gold_reward then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_GoldStore")
    grid_gold_reward = View.Group_GoldStore.Group_Reward.StaticGrid_Box.grid.self
  end
  return grid_gold_reward
end
local Refresh_Month_Day = function()
  if PlayerData.ServerData.monthly_card["11400018"] then
    View.Group_Month.Group_Time.Txt_Time:SetText(PlayerData.ServerData.monthly_card["11400018"].month_time)
  else
    View.Group_Month.Group_Time.Txt_Time:SetText(0)
  end
end
local ShowPurchaseRole = function(data, index)
  local shopCA = PlayerData:GetFactoryData(data.id)
  local itemCA = PlayerData:GetFactoryData(shopCA.commodityItemList[1].id)
  local viewCA = PlayerData:GetFactoryData(itemCA.viewId)
  View.Group_RoleStore.Group_TimeCommodity.Group_Role.SpineAnimation_Character:SetData(viewCA.spineUrl)
  View.Group_RoleStore.Group_TimeCommodity.Group_Role.SpineAnimation_Character.transform.localPosition = Vector3(-80, -900, 0)
  View.Group_RoleStore.Group_TimeCommodity.Group_Role.Group_Character.Sprite_Character:SetActive(false)
  local lastTime = TimeUtil:LastTime(shopCA.endTime)
  local time = TimeUtil:SecondToTable(lastTime)
  DataModel.List[6].cor_time = lastTime
  DataModel.Choose_Purchase_Role = {}
  DataModel.Choose_Purchase_Role.index = index
  DataModel.Choose_Purchase_Role.id = data.id
  DataModel.Choose_Purchase_Role.shopCA = shopCA
  View.Group_RoleStore.Group_TimeCommodity.Group_Time.Txt_Time:SetText(TimeUtil:GetGachaDesc(time))
  View.Group_RoleStore.Group_TimeCommodity.Btn_Buy.Txt_Num:SetText(shopCA.moneyList[1].moneyNum)
  local left_money = PlayerData:GetFactoryData(tonumber(shopCA.moneyList[1].moneyID))
  View.Group_RoleStore.Group_TimeCommodity.Btn_Buy.Img_Money:SetSprite(left_money.iconPath)
end
local ShowMedal = function()
  View.Group_RoleStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetUserInfo().medal)
end
local refresh_buy_num = function()
  local ui_right = View.Group_PropBuy.Group_Right
  local group_middle = ui_right.Group_Middle
  local group_bottom = ui_right.Group_Bottom
  group_middle.Img_Num.Txt_Num:SetText(buy_num)
  group_bottom.Txt_Num:SetText(buy_num * buy_price)
end
local get_free_refresh_num = function(already, freeCount)
  local number = 0
  if freeCount <= already then
    number = 0
  else
    number = freeCount - already
  end
  return number
end
local init_item_detail = function(list, index)
  now_item_info = {}
  local row = list
  local commoditData = row.commoditData
  buy_num = 1
  local ui_list = View.Group_PropBuy
  local ui_left = ui_list.Group_Left
  ui_left.Txt_Title:SetText(commoditData.commodityName)
  ui_left.Img_Item:SetSprite(commoditData.commodityView)
  ui_left.Txt_Describe:SetText(commoditData.commodityFunction)
  local ui_right = ui_list.Group_Right
  local group_top = ui_right.Group_Top
  buy_price = commoditData.moneyList[1] == nil and 0 or commoditData.moneyList[1].moneyNum
  group_top.Txt_Price:SetText(buy_price)
  local money_info = commoditData.moneyList[1] and PlayerData:GetFactoryData(tonumber(commoditData.moneyList[1].moneyID)) or {iconPath = ""}
  local group_middle = ui_right.Group_Middle
  group_middle.Img_Num.Txt_Num:SetText(buy_num)
  all_num = row.residue
  group_middle.Txt_QuantityNum:SetText(all_num)
  local group_bottom = ui_right.Group_Bottom
  group_bottom.Txt_Num:SetText(buy_num * buy_price)
  if money_info.iconPath == "" then
    group_top:SetActive(false)
    group_bottom:SetActive(false)
  else
    group_top:SetActive(true)
    group_bottom:SetActive(true)
    group_top.Img_Icon:SetSprite(money_info.iconPath)
    group_bottom.Img_Icon:SetSprite(money_info.iconPath)
  end
  now_item_info.image = commoditData.commodityView
  now_item_info.name = row.name
  now_item_info.index = index
  now_item_info.shopid = DataModel.shop_id
  now_item_info.purchaseNum = commoditData.purchaseNum
  now_item_info.purchase = commoditData.purchase
  now_item_info.commoditData = commoditData
  now_item_info.residue = row.residue
end
local InitLackMoneyPage = function()
  View.Group_LackMoney.self:SetActive(true)
end
local CloseLackMoneyPage = function()
  View.Group_LackMoney.self:SetActive(false)
end
local CloseRefreshWindowPage = function()
  View.Group_RefreshWindow.self:SetActive(false)
end
local OpenStockPage = function()
  View.Group_RefreshWindow.self:SetActive(true)
  View.Group_RefreshWindow.Txt_NoReminded.Btn_Check.Txt_Check:SetActive(refresh_state)
end
local OpenDetail = function(row, index)
  View.Group_PropBuy.self:SetActive(true)
  init_item_detail(row, index)
end
local ClosePropBuy = function()
  View.Group_PropBuy.self:SetActive(false)
end
local bottom_button_config = {}
local UpdateBottomButtonState = function(index)
  DataModel.shop_id = DataModel.List[index].shopid
  if index == DataModel.Now_Tab_Index and DataModel.RefreshState == 0 then
    return
  end
  DataModel.RefreshState = 0
  DataModel.Now_Tab_Index = index
  for k, v in pairs(bottom_button_config) do
    v.button.Img_pitchon:SetActive(false)
    if v.show then
      v.show.self:SetActive(false)
    end
  end
  bottom_button_config[index].button.Img_pitchon:SetActive(true)
  if index == 7 then
    View.Group_Month.self:SetActive(true)
    Refresh_Month_Day()
    return
  end
  if index == 1 then
    CommonTips.OpenTips("推 推荐不了")
    return
  end
  DataModel.Choose_List = DataModel.List[index]
  freeCount = DataModel.List[index].shopFactory.freeRefreshNum
  local refresh_num = DataModel.Choose_List.refresh_num
  local showUI = bottom_button_config[index].show
  local reward_grid = bottom_button_config[index].reward
  if showUI.self == nil then
    return
  end
  showUI.self:SetActive(true)
  if index == 6 then
    ShowMedal()
    DataModel.RoleStore = {}
    local count = 1
    for k, v in pairs(DataModel.Choose_List.shopFactory.shopList) do
      local ca = PlayerData:GetFactoryData(v.id)
      if ca.isTime and ca.isTime == true then
        if ca.startTime ~= "" and TimeUtil:IsActive(ca.startTime, ca.endTime) then
          ShowPurchaseRole(v, k)
        end
      else
        DataModel.RoleStore[count] = v
        DataModel.RoleStore[count].index = k
        DataModel.RoleStore[count].server = {}
        if PlayerData.ServerData.shops[tostring(DataModel.shop_id)] then
          for c, d in pairs(PlayerData.ServerData.shops[tostring(DataModel.shop_id)].items) do
            if tonumber(d.id) == tonumber(v.id) then
              DataModel.RoleStore[count].server = d
            end
          end
        end
        count = count + 1
      end
    end
    if 0 < table.count(DataModel.RoleStore) then
      get_role_grid():SetActive(true)
      get_role_grid():SetDataCount(table.count(DataModel.RoleStore))
      get_role_grid():RefreshAllElement()
    else
      get_role_grid():SetActive(false)
    end
  end
  if index == 5 then
    get_gift_grid():SetDataCount(table.count(DataModel.Choose_List.shopFactory.shopList))
    get_gift_grid():RefreshAllElement()
  end
  if index == 4 then
    get_gold_grid():RefreshAllElement()
    View.Group_GoldStore.Group_Bottom.Img_Backgroud.Txt_RefreshTime:SetText("")
    View.Group_GoldStore.Group_Bottom.Img_Backgroud.Img_refresh.Txt_Stock:SetText("免费刷新 " .. get_free_refresh_num(refresh_num, freeCount) .. "/" .. freeCount)
  end
  if index == 3 then
    get_day_grid():RefreshAllElement()
    View.Group_DailyStore.Group_Bottom.Img_Backgroud.Txt_RefreshTime:SetText("")
    View.Group_DailyStore.Group_Bottom.Img_Backgroud.Img_refresh.Txt_Stock:SetText("免费刷新 " .. get_free_refresh_num(refresh_num, freeCount) .. "/" .. freeCount)
  end
  if index == 2 then
    get_dimond_grid():SetDataCount(table.count(DataModel.Choose_List.shopFactory.shopList))
    get_dimond_grid():RefreshAllElement()
  end
  if showUI.Group_Reward then
    showUI.Group_Reward:SetActive(false)
    local Group_Reward = showUI.Group_Reward
    if DataModel.Choose_List.rewards ~= nil and 0 < table.count(DataModel.Choose_List.rewards) then
      DataModel.Group_Reward = {}
      showUI.Group_Reward:SetActive(true)
      reward_grid():RefreshAllElement()
      local max_progress = DataModel.Choose_List.rewards[table.count(DataModel.Choose_List.rewards)].buy_times
      local progress = 1 < DataModel.Choose_List.shop_times / max_progress and 1 or DataModel.Choose_List.shop_times / max_progress
      Group_Reward.Group_Progress.Img_Bar:SetFilledImgAmount(progress)
      Group_Reward.Group_Progress.Txt_Progress:SetText(DataModel.Choose_List.shop_times)
    end
    Group_Reward.Btn_Back:SetActive(false)
  end
end
local Refresh_Right_Top_Num = function()
  View.Group_TopRight.Btn_Diamond.Txt_diamondnum:SetText(PlayerData.ServerData.user_info.bm_rock)
  View.Group_TopRight.Btn_Gold.Txt_Gold:SetText(PlayerData.ServerData.user_info.gold)
end
local RefreshShopList = function(res)
  for k, v in pairs(PlayerData.ServerData.shops) do
    if tonumber(k) == tonumber(DataModel.List[3].shopid) then
      DataModel.List[3] = {}
      DataModel.List[3] = v
      DataModel.List[3].commoditData = ""
      DataModel.List[3].moneyList = {}
      DataModel.List[3].shopid = k
      DataModel.List[3].shopFactory = DataModel.GetStoreConfig(tonumber(k))
      DataModel.List[3].cor_time = 0
      if v.last_auto_refresh then
        DataModel.List[3].cor_time = v.last_auto_refresh + 86400 - PlayerData.ServerData.server_now
        DataModel.auto_refresh_index = DataModel.Now_Tab_Index
      end
    end
  end
  DataModel:ChooseRightTab(DataModel.rightindex, true)
end
local SendRefreshShop = function()
  Net:SendProto("shop.refresh", function(json)
    DataModel.RefreshState = 1
    Refresh_Right_Top_Num()
    RefreshShopList(json)
    local num = json.shops[tostring(DataModel.shop_id)].refresh_num
    if DataModel.Now_Tab_Index == 3 then
      View.Group_DailyStore.Group_Bottom.Img_Backgroud.Img_refresh.Txt_Stock:SetText("免费刷新 " .. get_free_refresh_num(num, freeCount) .. "/" .. freeCount)
    end
    if DataModel.Now_Tab_Index == 4 then
      View.Group_GoldStore.Group_Bottom.Img_Backgroud.Img_refresh.Txt_Stock:SetText("免费刷新 " .. get_free_refresh_num(num, freeCount) .. "/" .. freeCount)
    end
    CommonTips.OpenTips(80600076)
  end, DataModel.shop_id)
end
local ConsRockRefresh = function()
  local moneyList = DataModel.Choose_List.shopFactory.moneyList[1]
  local moneyNum = moneyList.moneyNum
  local moneyID = moneyList.moneyID
  if moneyNum > GetCurrency(moneyID) then
    if moneyID == 11400001 then
      CommonTips.OpenTips(80600129)
    end
    if moneyID == 11400005 then
      CommonTips.OnPrompt(80600147, "确认", "取消", callback)
    end
  else
    SendRefreshShop()
  end
end
local ClickBottomReward = function(str)
  local row = DataModel.Choose_List.rewards[str]
  if row.status_rec == 2 then
    Net:SendProto("shop.receive_awards", function(json)
      DataModel.RefreshState = 1
      CommonTips.OpenShowItem(json.reward)
      row.received_status = 1
      RefreshShopList(json)
      Refresh_Right_Top_Num()
    end, DataModel.shop_id, str - 1)
    return
  end
  if str ~= DataModel.Now_Group_Index then
    for k, v in pairs(DataModel.Choose_List.rewards) do
      local element_every = View.Group_DailyStore.Group_Reward.StaticGrid_Box.grid[k]
      element_every.Group_Preview:SetActive(false)
    end
  end
  local element = View.Group_DailyStore.Group_Reward.StaticGrid_Box.grid[str]
  if element.Group_Preview.IsActive == true then
    element.Group_Preview:SetActive(false)
    View.Group_DailyStore.Group_Reward.Btn_Back:SetActive(false)
  else
    element.Group_Preview:SetActive(true)
    View.Group_DailyStore.Group_Reward.Btn_Back:SetActive(true)
    DataModel.Now_Group_Index = str
  end
end
local ViewFunction = {
  Store_Group_CommonTopLeft_Btn_Return_Click = function(str)
    View.self:PlayAnim("Out")
    DataModel.Now_Tab_Index = nil
    UIManager:GoBack()
  end,
  Store_Group_CommonTopLeft_Btn_Home_Click = function(str)
    View.self:PlayAnim("Out")
    MapNeedleData.GoHome()
  end,
  Store_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Store_Group_PropBuy_Btn_Close_Click = function(btn, str)
    ClosePropBuy()
  end,
  Store_Group_PropBuy_Group_Right_Group_Middle_Btn_Reduce_Click = function(btn, str)
    if 1 < buy_num then
      buy_num = buy_num - 1
    end
    refresh_buy_num()
  end,
  Store_Group_PropBuy_Group_Right_Group_Middle_Btn_Reduce_LongPress = function(btn, str)
    View.self:StartC(LuaUtil.cs_generator(function()
      while btn.Btn.isHandled do
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
        if 1 < buy_num then
          buy_num = buy_num - 1
        end
        refresh_buy_num()
      end
    end))
  end,
  Store_Group_PropBuy_Group_Right_Group_Middle_Btn_Add_Click = function(btn, str)
    if 0 < all_num - buy_num and buy_num < 99 then
      buy_num = buy_num + 1
    end
    refresh_buy_num()
  end,
  Store_Group_PropBuy_Group_Right_Group_Middle_Btn_Add_LongPress = function(btn, str)
    View.self:StartC(LuaUtil.cs_generator(function()
      while btn.Btn.isHandled do
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
        if 0 < all_num - buy_num and buy_num < 99 then
          buy_num = buy_num + 1
        end
        refresh_buy_num()
      end
    end))
  end,
  Store_Group_PropBuy_Group_Right_Group_Middle_Btn_Max_Click = function(btn, str)
    buy_num = now_item_info.residue
    refresh_buy_num()
  end,
  Store_Group_PropBuy_Group_Right_Btn_Buy_Click = function(btn, str)
    local moneyList = now_item_info.commoditData.moneyList[1]
    local moneyNum = moneyList == nil and 0 or moneyList.moneyNum
    local moneyID = moneyList == nil and 0 or moneyList.moneyID
    local money = buy_num * moneyNum
    if money > GetCurrency(moneyID) then
      InitLackMoneyPage()
    else
      local callback = function()
        Refresh_Right_Top_Num()
        ClosePropBuy()
      end
      Net:SendProto("shop.buy", function(json)
        print_r(json)
        local row = json.reward
        row.Title = "获得道具"
        CommonTips.OpenShowItem(json.reward)
        RefreshShopList(json)
        callback()
        Refresh_Right_Top_Num()
      end, tostring(now_item_info.shopid), now_item_info.index, buy_num)
    end
  end,
  Store_Group_SuccessfulPurchase_Btn_Close_Click = function(btn, str)
    View.Group_SuccessfulPurchase.self:SetActive(false)
  end,
  Store_Group_LackMoney_Btn_Close_Click = function(btn, str)
    CloseLackMoneyPage()
  end,
  Store_Group_LackMoney_Btn_Confirm_Click = function(btn, str)
    CloseLackMoneyPage()
    ClosePropBuy()
    UpdateBottomButtonState(2)
  end,
  Store_Group_LackMoney_Btn_Cancel_Click = function(btn, str)
    CloseLackMoneyPage()
  end,
  Store_Group_RefreshWindow_Btn_Close_Click = function(btn, str)
    CloseRefreshWindowPage()
  end,
  Store_Group_RefreshWindow_Btn_Confirm_Click = function(btn, str)
    local sever_now = PlayerData.ServerData.server_now
    if refresh_state == true then
      PlayerData:SetPlayerPrefs("int", "refreshState" .. DataModel.shop_id, 1)
      PlayerData:SetPlayerPrefs("int", "lastautorefresh" .. DataModel.shop_id, sever_now)
    else
      PlayerData:SetPlayerPrefs("int", "refreshState" .. DataModel.shop_id, 0)
    end
    CloseRefreshWindowPage()
    ConsRockRefresh()
  end,
  Store_Group_RefreshWindow_Btn_Cancel_Click = function(btn, str)
    CloseRefreshWindowPage()
  end,
  Store_Group_RefreshWindow_Txt_NoReminded_Btn_Check_Click = function(btn, str)
    refresh_state = not refresh_state
    View.Group_RefreshWindow.Txt_NoReminded.Btn_Check.Txt_Check:SetActive(refresh_state)
  end,
  Store_Group_Top_Button_Btn_recommend_Click = function(btn, str)
    DataModel:ChooseTag(1)
  end,
  Store_Group_Top_Button_Btn_diamondstore_Click = function(btn, str)
    DataModel:ChooseTag(2)
  end,
  Store_Group_Top_Button_Btn_dailystore_Click = function(btn, str)
    local condition = DataModel.ConditionList[2]
    if condition.state == false then
      CommonTips.OpenTips(condition.txt)
      return
    end
    UpdateBottomButtonState(3)
  end,
  Store_Group_Top_Button_Btn_month_Click = function(btn, str)
    UpdateBottomButtonState(7)
  end,
  Store_Group_TopRight_Btn_Diamond_Click = function(btn, str)
  end,
  Store_Group_TopRight_Btn_Gold_Click = function(btn, str)
  end,
  Store_Group_Month_Btn_Buy_Click = function(btn, str)
    Net:SendProto("shop.shop_card", function(json)
      print_r(json)
      CommonTips.OpenShowItem(json.reward)
      Refresh_Right_Top_Num()
      Refresh_Month_Day()
    end, 82100002)
  end,
  Store_Group_Month_Group_Detail_Group_MonthReward_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenRewardDetail(11400005)
  end,
  Store_Group_Month_Group_Detail_Group_Reward_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenRewardDetail(11400005)
  end,
  Store_Group_Top_Button_Btn_glodStore_Click = function(btn, str)
    UpdateBottomButtonState(4)
  end,
  Store_Group_Top_Button_Btn_giftStore_Click = function(btn, str)
    UpdateBottomButtonState(5)
  end,
  Store_Group_Top_Button_Btn_roleStore_Click = function(btn, str)
    UpdateBottomButtonState(6)
  end,
  Store_Group_Top_Button_Btn_MoonStore_Click = function(btn, str)
    DataModel:ChooseTag(3)
  end,
  Store_Group_MoonStore_Group_BtnTag_Btn_Equip_Click = function(btn, str)
    DataModel:ChooseRightTab(1)
  end,
  Store_Group_MoonStore_Group_BtnTag_Btn_Furniture_Click = function(btn, str)
    DataModel:ChooseRightTab(2)
  end,
  Store_Group_MoonStore_Group_BtnTag_Btn_Role_Click = function(btn, str)
    DataModel:ChooseRightTab(3)
  end,
  Store_Group_MoonStore_Group_BtnTag_Btn_Skin_Click = function(btn, str)
    DataModel:ChooseRightTab(4)
  end,
  Store_Group_EventStore_Group_TopRight_Btn_Token_Click = function(btn, str)
  end,
  Store_Group_EventStore_Group_StoreList_StaticGrid_List_SetGrid = function(element, elementIndex)
  end,
  Store_Group_EventStore_Group_StoreList_StaticGrid_List_Group_ItemEvent_Btn_Item_Click = function(btn, str)
  end,
  Store_Group_EventStore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
  end,
  Store_Group_EventStore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  Store_Group_EventStore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Store_StaticGrid_TopButton_SetGrid = function(element, elementIndex)
    local row = DataModel.mainStoreList[tonumber(elementIndex)]
    element:SetActive(false)
    if row then
      element:SetActive(true)
      local ca = PlayerData:GetFactoryData(row.id)
      row.ca = ca
      element.Btn_Top.Txt_TopName:SetText(row.name)
      element.Btn_Top.Img_1:SetSprite(row.pngNotSelect)
      element.Btn_Top.Img_pitchon.Txt_TopName:SetText(row.name)
      element.Btn_Top.Img_pitchon.Img_2:SetSprite(row.pngSelect)
      element.Btn_Top.Img_pitchon:SetActive(false)
      element.Btn_Top:SetClickParam(elementIndex)
    end
  end,
  Store_StaticGrid_RightButton_SetGrid = function(element, elementIndex)
    local row = DataModel.RightMainStoreList[tonumber(elementIndex)]
    element:SetActive(false)
    if row then
      element:SetActive(true)
      local Group_On = element.Group_On
      local Group_Off = element.Group_Off
      Group_On:SetActive(false)
      Group_Off:SetActive(false)
      local ca = PlayerData:GetFactoryData(row.id)
      row.ca = ca
      element:SetClickParam(elementIndex)
    end
  end,
  Store_StaticGrid_RightButton_Btn_RightButtom_000_Click = function(btn, str)
  end,
  Store_StaticGrid_RightButton_Btn_RightButtom_001_Click = function(btn, str)
  end,
  Store_StaticGrid_RightButton_Btn_RightButtom_002_Click = function(btn, str)
  end,
  Store_StaticGrid_RightButton_Btn_RightButtom_003_Click = function(btn, str)
  end,
  Store_Group_Top_Button_Btn_giftstore_Click = function(btn, str)
  end,
  Store_Group_Top_Button_Btn_Top_Click = function(btn, str)
  end,
  Store_Group_RoleStore_StaticGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.RoleStore[tonumber(elementIndex)]
    local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
    row.commoditData = commoditData
    row.name = commoditData.commodityName
    row.image = commoditData.commodityView
    row.residue = 0
    local Btn_Item = element.Btn_Item
    Btn_Item.self:SetClickParam(elementIndex)
    Btn_Item.Txt_ItemName:SetText(row.name)
    local Item = PlayerData:GetFactoryData(commoditData.commodityItemList[1].id)
    Btn_Item.Img_ItemBG.Img_Item:SetSprite(row.image)
    local quantity = Item.qualityInt
    Btn_Item.Img_ItemBG:SetSprite(UIConfig.BottomConfig[quantity])
    row.qualityInt = quantity
    local purchase = commoditData.purchase
    Btn_Item.Img_Sold.self:SetActive(false)
    if purchase == true then
      row.residue = commoditData.purchaseNum - (row.server and row.server.py_cnt or 0)
      if row.residue < 0 then
        row.residue = 0
      end
      Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText(string.format(GetText(80600430), row.residue))
      Btn_Item.Img_ItemBG.Img_Residue:SetActive(true)
      if row.residue == 0 then
        Btn_Item.Img_Sold.self:SetActive(true)
      else
        Btn_Item.Img_Sold.self:SetActive(false)
      end
    else
      Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText("")
      Btn_Item.Img_ItemBG.Img_Residue:SetActive(false)
    end
    Btn_Item.Img_ItemBG.Txt_Num:SetText(commoditData.commodityNum or 1)
    local money = commoditData.moneyList[1]
    if money then
      local priceNum = commoditData.moneyList[1].moneyNum
      local moneyID = commoditData.moneyList[1].moneyID
      row.priceNum = priceNum
      row.moneyID = moneyID
      Btn_Item.Img_Money:SetActive(true)
      local left_money = PlayerData:GetFactoryData(tonumber(commoditData.moneyList[1].moneyID))
      Btn_Item.Img_Money.self:SetSprite(left_money.iconPath)
      Btn_Item.Img_Money.Txt_MoneyNum:SetText(priceNum)
      return
    end
    Btn_Item.Img_Money:SetActive(false)
  end,
  Store_Group_RoleStore_Group_TimeCommodity_Btn_Buy_Click = function(btn, str)
  end,
  Store_Group_RoleStore_Btn_Medal_Click = function(btn, str)
    local pos = {x = -650, y = 290}
    CommonTips.OpenExplain(11400017, pos)
  end,
  Store_Group_RoleStore_StaticGrid_List_Group_ItemMoon_Btn_Item_Click = function(btn, str)
    local row = DataModel.RoleStore[tonumber(str)]
    if row.priceNum and row.priceNum > 0 and PlayerData:GetGoodsById(row.moneyID).num < row.priceNum then
      CommonTips.OpenTips(string.format(GetText(80600023), PlayerData:GetFactoryData(row.moneyID, "ItemFactory").name))
      return
    end
    if row.residue == 0 then
      return
    end
    row.index = tonumber(str) - 1
    row.shopid = DataModel.Shop_Id
    row.type = "role"
    CommonTips.OpenBuyTips(row)
  end,
  Store_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Store_Group_EventStore_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Store_Btn_Medal_Click = function(btn, str)
  end,
  Store_Btn_Medal_Btn_Add_Click = function(btn, str)
  end,
  Store_Group_MoonTips_Btn_Close_Click = function(btn, str)
    View.Group_MoonTips.self:SetActive(false)
  end,
  Store_StaticGrid_TopButton_Group_Top_Btn_Top_Click = function(btn, str)
    DataModel.ChooseTopList(str)
  end,
  Store_Group_DiamondStore_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.Now_ShopList.shopList[tonumber(elementIndex)]
    local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
    row.commoditData = commoditData
    row.name = commoditData.commodityName
    row.image = commoditData.commodityView
    local Btn_Item = element.Btn_Item
    Btn_Item.self:SetClickParam(elementIndex)
    local Group_Bottom = Btn_Item.Group_Bottom
    local Img_discountBG = Btn_Item.Img_discountBG
    local count = 0
    if commoditData.rewardFirstList and 0 < table.count(commoditData.rewardFirstList) then
      count = table.count(commoditData.rewardFirstList)
    end
    Group_Bottom.Txt_FollowCharge:SetActive(false)
    if commoditData.isFirst == true and 0 < count and row.num == 0 then
      local rewardFirst = PlayerData:GetFactoryData(commoditData.rewardFirstList[1].id)
      Img_discountBG.Txt_FirstCharge:SetText(string.format(GetText(80600198), commoditData.rewardFirstList[1].num))
      local reward = PlayerData:GetFactoryData(commoditData.rewardList[1].id)
      Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. reward.name .. "+" .. commoditData.rewardFirstList[1].num .. rewardFirst.name)
      Group_Bottom.Txt_discountNum:SetActive(true)
      Img_discountBG:SetActive(true)
    else
      Group_Bottom.Txt_discountNum:SetActive(false)
      Img_discountBG:SetActive(false)
      local reward = PlayerData:GetFactoryData(commoditData.rewardList[1].id)
      Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. reward.name)
      if commoditData.rewardFollowList and table.count(commoditData.rewardFollowList) ~= 0 then
        Group_Bottom.Txt_FollowCharge:SetActive(true)
        Group_Bottom.Txt_FollowCharge:SetText(string.format(GetText(80601197), commoditData.rewardFollowList[1].num))
        local ca = PlayerData:GetFactoryData(commoditData.rewardFollowList[1].id)
        Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. reward.name .. "+" .. commoditData.rewardFollowList[1].num .. ca.name)
      end
    end
    Btn_Item.Img_diamond:SetSprite(commoditData.iconPath)
    Group_Bottom.Txt_price:SetText(string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(commoditData.value, 2)))
    Btn_Item.Txt_Name:SetText(commoditData.name)
  end,
  Store_Group_DiamondStore_ScrollGrid_List_Group_diamondItem_Btn_Item_Click = function(btn, str)
    local row = DataModel.Now_ShopList.shopList[tonumber(str)]
    local metaId = tostring(row.id)
    local shopId = DataModel.Shop_Id
    local payAmount = row.commoditData.value
    local name = row.commoditData.name
    local priceStr = string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(row.commoditData.value, 2))
    local uiParams = Json.encode({
      name = name,
      price = priceStr,
      itemId = metaId,
      shopId = shopId,
      payAmount = payAmount
    })
    local callback = function(json)
      row.num = row.num and row.num + 1 or 1
      local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
      if recharge then
        if recharge[tostring(row.id)] then
          recharge[tostring(row.id)].num = row.num
        else
          recharge[tostring(row.id)] = {}
          recharge[tostring(row.id)].num = row.num
        end
      else
        recharge = {}
        recharge[tostring(row.id)] = {}
        recharge[tostring(row.id)].num = row.num
      end
      if row.num == 1 then
        local commoditData = row.commoditData
        local element = View.Group_DiamondStore.ScrollGrid_List.grid[tonumber(str)]
        local Btn_Item = element.Btn_Item
        local Group_Bottom = Btn_Item.Group_Bottom
        local Img_discountBG = Btn_Item.Img_discountBG
        local count = 0
        if commoditData.rewardFirstList and 0 < table.count(commoditData.rewardFirstList) then
          count = table.count(commoditData.rewardFirstList)
        end
        if commoditData.isFirst == true and 0 < count and row.num == 0 then
          local rewardFirst = PlayerData:GetFactoryData(commoditData.rewardFirstList[1].id)
          Img_discountBG.Txt_FirstCharge:SetText(string.format(GetText(80600198), commoditData.rewardFirstList[1].num))
          local reward = PlayerData:GetFactoryData(commoditData.rewardList[1].id)
          Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. reward.name .. "+" .. commoditData.rewardFirstList[1].num .. rewardFirst.name)
          Group_Bottom.Txt_discountNum:SetActive(true)
          Img_discountBG:SetActive(true)
        else
          Group_Bottom.Txt_discountNum:SetActive(false)
          Img_discountBG:SetActive(false)
          local reward = PlayerData:GetFactoryData(commoditData.rewardList[1].id)
          Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. reward.name)
          if commoditData.rewardFollowList and table.count(commoditData.rewardFollowList) ~= 0 then
            Group_Bottom.Txt_FollowCharge:SetActive(true)
            Group_Bottom.Txt_FollowCharge:SetText(string.format(GetText(80601197), commoditData.rewardFollowList[1].num))
            local ca = PlayerData:GetFactoryData(commoditData.rewardFollowList[1].id)
            Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. reward.name .. "+" .. commoditData.rewardFollowList[1].num .. ca.name)
          end
        end
      end
      View.Group_DiamondStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
      CommonTips.OpenShowItem(json.reward)
    end
    PayHelper.Buy(metaId, callback, uiParams)
  end,
  Store_Group_GoldStore_StaticGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.Choose_List.items[tonumber(elementIndex)]
    local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
    row.commoditData = commoditData
    row.name = commoditData.commodityName
    row.image = commoditData.commodityView
    row.residue = 0
    local Btn_Item = element.Btn_Item
    Btn_Item.self:SetClickParam(elementIndex)
    Btn_Item.Txt_ItemName:SetText(row.name)
    local Item = PlayerData:GetFactoryData(commoditData.commodityItemList[1].id)
    Btn_Item.Img_ItemBG.Img_Item:SetSprite(row.image)
    local quantity = Item.qualityInt
    Btn_Item.Img_ItemBG:SetSprite(UIConfig.BottomConfig[quantity + 1])
    row.qualityInt = quantity
    local purchase = commoditData.purchase
    if purchase == true then
      row.residue = commoditData.purchaseNum - row.py_cnt
      if row.residue < 0 then
        row.residue = 0
      end
      Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText(string.format(GetText(80600430), row.residue))
      if row.residue == 0 then
        Btn_Item.Img_Sold.self:SetActive(true)
      else
        Btn_Item.Img_Sold.self:SetActive(false)
      end
    else
      Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText("")
    end
    Btn_Item.Img_ItemBG.Txt_Num:SetText(commoditData.commodityNum or 1)
    local money = commoditData.moneyList[1]
    if money then
      Btn_Item.Img_Money:SetActive(true)
      local left_money = PlayerData:GetFactoryData(tonumber(commoditData.moneyList[1].moneyID))
      Btn_Item.Img_Money.self:SetSprite(left_money.iconPath)
      Btn_Item.Img_Money.Txt_MoneyNum:SetText(commoditData.moneyList[1].moneyNum)
      return
    end
    Btn_Item.Img_Money:SetActive(false)
  end,
  Store_Group_GoldStore_StaticGrid_List_Group_Item_Btn_Item_Click = function(btn, str)
    local row = DataModel.Choose_List.items[tonumber(str)]
    if row.residue == 0 then
      CommonTips.OpenTips(80600077)
      return
    end
    row.index = tonumber(str) - 1
    row.shopid = DataModel.shop_id
    CommonTips.OpenBuyTips(row)
  end,
  Store_Group_GoldStore_Group_Bottom_Img_Backgroud_Img_refresh_Btn_Mask_Click = function(btn, str)
    local sever_now = PlayerData.ServerData.server_now
    if freeCount - DataModel.Choose_List.refresh_num > 0 then
      SendRefreshShop()
      return
    elseif PlayerData:GetPlayerPrefs("int", "refreshState" .. DataModel.shop_id) == 0 and sever_now ~= PlayerData:GetPlayerPrefs("int", "lastautorefresh" .. DataModel.shop_id) then
      OpenStockPage()
    else
      ConsRockRefresh()
    end
  end,
  Store_Group_GoldStore_Group_Bottom_Img_Backgroud_Btn_Refresh_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_Btn_Back_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_SetGrid = function(element, elementIndex)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Group_NoGet_Btn_Preview_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Group_Got_Btn_Preview_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Group_CanGet_Btn_Get_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Group_Preview_StaticGrid_Item_SetGrid = function(element, elementIndex)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Group_Preview_StaticGrid_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Store_Group_DiamondStore_Btn_Medal_Click = function(btn, str)
    DataModel.ChooseTopList(2)
  end,
  Store_Group_GiftStore_Btn_Medal_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_DiamondStore_Btn_Medal_Btn_Add_Click = function(btn, str)
  end,
  Store_Group_GiftStore_Btn_Medal_Btn_Add_Click = function(btn, str)
  end,
  Store_Group_RecommendStore_Btn_Medal_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_RecommendStore_Btn_Medal_Btn_Add_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_RecommendStore_Btn_Recommend_Click = function(btn, str)
    local row = DataModel.recommendList[DataModel.RecommedIndex]
    if row.type == "SkipStore" then
      DataModel.ChooseTopList(row.sequence)
      return
    end
    if row.type == "SkipPage" then
      if row.otherUI ~= "" then
        local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
        local battlePass = PlayerData:GetFactoryData(initConfig.BattlePassId, "BattlePassFactory")
        if row.name == "环游手册" and TimeUtil:LastTime(battlePass.PassEndTime) < 0 then
          CommonTips.OpenTips(80602313)
          return
        end
        UIManager:Open(row.otherUI)
      end
      return
    end
    if row.type == "Buy" then
      DataModel.RefreshState = 1
      DataModel.ChooseTopList(row.sequence)
      if row.sequence == 3 then
        local count = row.comSequence
        local row_s = DataModel.Now_ShopList.shopList[count]
        if row_s then
          if row_s.isLock then
            CommonTips.OpenTips(80601023)
            return
          end
          if row_s.isMax then
            CommonTips.OpenTips(80600077)
            return
          end
          do
            local params = {}
            params.name = row_s.name
            params.commoditData = row.commoditData
            params.num = row_s.num
            params.weight = row_s.weight
            params.image = row_s.image
            params.id = row_s.id
            params.isFree = row_s.isFree
            local callback = function()
              local metaId = tostring(row.id)
              local shopId = DataModel.Shop_Id
              local name = params.commoditData.name
              local payAmount = row_s.commoditData.value
              local priceStr = string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(params.commoditData.value, 2))
              local uiParams = Json.encode({
                name = name,
                price = priceStr,
                itemId = metaId,
                shopId = shopId,
                payAmount = payAmount
              })
              PayHelper.Buy(metaId, function(json)
                local list = {}
                local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
                list.num = 1
                if recharge then
                  if recharge[tostring(row.id)] then
                    local num = recharge[tostring(row.id)].num + 1
                    list.num = num
                    recharge[tostring(row.id)].num = num
                  else
                    recharge[tostring(row.id)] = list
                  end
                else
                  PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)] = {}
                  PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)][tostring(row.id)] = list
                end
                CommonTips.OpenShowItem(json.reward)
                DataModel.RefreshState = 1
                DataModel.ChooseTopList(DataModel.TopIndex)
              end, uiParams)
            end
            CommonTips.OnBuyGiftTips(params, callback)
          end
        end
      end
      return
    end
  end,
  Store_Group_RecommendStore_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.recommendList[tonumber(elementIndex)]
    element.Btn_:SetClickParam(tonumber(elementIndex))
    element.Group_Off.self:SetActive(true)
    element.Group_On.self:SetActive(false)
    element.Group_Off.Img_Tab:SetSprite(row.tabPng)
    element.Group_On.Img_Tab:SetSprite(row.tabPng)
    element.Group_Off.Txt_Name:SetText(row.name)
    element.Group_On.Txt_Name:SetText(row.name)
  end,
  Store_Group_RecommendStore_ScrollGrid_List_Group_Item_Btn__Click = function(btn, str)
    DataModel.ChooseRecommedStore(tonumber(str))
  end,
  Store_Group_GiftStore_NewScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.Now_ShopList.shopList[tonumber(elementIndex)]
    local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
    row.commoditData = commoditData
    row.name = commoditData.name
    row.image = commoditData.iconPath
    row.buyPath = commoditData.buyPath
    local Btn_Item = element.Btn_Item
    local Group_Bottom = Btn_Item.Group_Bottom
    Btn_Item.self:SetClickParam(elementIndex)
    Group_Bottom.Btn_Help:SetClickParam(elementIndex)
    Btn_Item.Img_icon:SetSprite(row.image)
    Group_Bottom.Txt_name:SetText(row.name)
    Group_Bottom.Img_chaozhi:SetActive(false)
    if commoditData.superValue ~= 0 then
      Group_Bottom.Img_chaozhi:SetActive(true)
      Group_Bottom.Img_chaozhi.Txt_shuzhi:SetText(string.format(GetText(80602486), commoditData.superValue))
    end
    Btn_Item.Group_Bottom.Txt_price:SetActive(false)
    Btn_Item.Group_Bottom.Txt_Free:SetActive(false)
    Btn_Item.Group_Bottom.Group_Cost:SetActive(false)
    local isFree = false
    if commoditData.buyType == "Money" then
      if commoditData.value ~= 0 then
        Btn_Item.Group_Bottom.Txt_price:SetActive(true)
        Btn_Item.Group_Bottom.Txt_price:SetText(string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(commoditData.value, 2)))
      else
        isFree = true
      end
    end
    if commoditData.buyType == "Item" then
      if commoditData.buyItemList[1] then
        Btn_Item.Group_Bottom.Group_Cost:SetActive(true)
        Btn_Item.Group_Bottom.Group_Cost.Img_Icon:SetSprite(PlayerData:GetFactoryData(commoditData.buyItemList[1].id).buyPath)
        Btn_Item.Group_Bottom.Group_Cost.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(commoditData.buyItemList[1].num, 2))
      else
        isFree = true
      end
    end
    if isFree == true then
      Btn_Item.Group_Bottom.Txt_Free:SetActive(true)
    end
    row.isFree = isFree
    Btn_Item.Group_Bottom.Group_Empty:SetActive(false)
    Btn_Item.Group_Bottom.Group_LimitNum:SetActive(false)
    Btn_Item.Group_Bottom.Group_LimitTime:SetActive(false)
    Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(false)
    Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
    row.isMax = false
    if commoditData.purchase == true then
      local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
      if typeTxtId ~= nil then
        Btn_Item.Group_Bottom.Group_LimitNum:SetActive(true)
        Btn_Item.Group_Bottom.Group_LimitNum.Txt_LimitNum:SetText(string.format(GetText(typeTxtId), math.max(commoditData.purchaseNum - row.num, 0), commoditData.purchaseNum))
        if row.num >= commoditData.purchaseNum then
          row.isMax = true
          Btn_Item.Group_Bottom.Group_Empty:SetActive(true)
        end
      end
    end
    if commoditData.isTime == true then
      local lastTime = TimeUtil:LastTime(commoditData.endTime)
      if 0 < lastTime then
        local time = TimeUtil:SecondToTable(lastTime)
        Btn_Item.Group_Bottom.Group_LimitTime:SetActive(true)
        Btn_Item.Group_Bottom.Group_LimitTime.Txt_Time:SetText(string.format(GetText(80601059), time.day, time.hour))
      end
    end
    if commoditData.isBuyCondition == true and PlayerData:GetUserInfo().lv < commoditData.gradeCondition then
      Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(true)
      Btn_Item.Group_Bottom.Group_GradeLimit.Txt_Grade:SetText(string.format(GetText(80601022), commoditData.gradeCondition))
      row.isLock = true
    end
    Btn_Item.Group_Bottom.Btn_Help:SetActive(false)
    Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
    if commoditData.ismonthCard == true then
      Btn_Item.Group_Bottom.Btn_Help:SetActive(true)
      if PlayerData.ServerData.monthly_card and PlayerData.ServerData.monthly_card["11400018"] then
        local t = PlayerData.ServerData.monthly_card["11400018"]
        local diff = 0
        if t.reward_ts then
          if t.reward_ts <= t.deadline then
            diff = t.deadline - t.reward_ts
          end
        else
          if t.reward_date == nil or t.reward_date == "" then
            t.reward_date = os.date("%Y-%m-%d %H:%M:%S", TimeUtil:GetFutureTime(0, 6))
          end
          local lastTime = os.time(TimeUtil:GetTimeTable(t.reward_date))
          if lastTime <= t.deadline then
            diff = t.deadline - lastTime
          end
        end
        if 0 < diff then
          local time = TimeUtil:SecondToTable(diff)
          Btn_Item.Group_Bottom.Group_residueTime:SetActive(true)
          Btn_Item.Group_Bottom.Group_residueTime.Txt_residueTime:SetText(string.format(GetText(80601102), time.day - 1))
        end
      end
    end
  end,
  Store_Group_GiftStore_NewScrollGrid_List_Group_gift_Btn_Item_Click = function(btn, str)
    local row = DataModel.Now_ShopList.shopList[tonumber(str)]
    if row.isLock then
      CommonTips.OpenTips(80601023)
      return
    end
    if row.isMax then
      CommonTips.OpenTips(80600077)
      return
    end
    local params = {}
    params.name = row.name
    params.commoditData = row.commoditData
    params.num = row.num
    params.weight = row.weight
    params.image = row.image
    params.id = row.id
    params.isFree = row.isFree
    params.isMoveEnergyOpen = DataModel.isMoveEnergyOpen
    local callback = function()
      local metaId = tostring(row.id)
      local shopId = DataModel.Shop_Id
      local name = row.commoditData.name
      local payAmount = row.commoditData.value
      local priceStr = string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(row.commoditData.value, 2))
      local uiParams = Json.encode({
        name = name,
        price = priceStr,
        itemId = metaId,
        shopId = shopId,
        payAmount = payAmount
      })
      PayHelper.Buy(metaId, function(json)
        local list = {}
        local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
        local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
        list.num = 1
        if recharge then
          if recharge[tostring(row.id)] then
            local num = recharge[tostring(row.id)].num + 1
            list.num = num
            recharge[tostring(row.id)].num = num
          else
            recharge[tostring(row.id)] = list
          end
        else
          PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)] = {}
          PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)][tostring(row.id)] = list
        end
        row.num = row.num + 1
        local element = View.Group_GiftStore.NewScrollGrid_List.grid.self:GetElementByIndex(tonumber(str) - 1)
        local Btn_Item = element.Btn_Item
        if commoditData.purchase == true then
          local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
          if typeTxtId ~= nil then
            Btn_Item.Group_Bottom.Group_LimitNum:SetActive(true)
            Btn_Item.Group_Bottom.Group_LimitNum.Txt_LimitNum:SetText(string.format(GetText(typeTxtId), commoditData.purchaseNum - row.num, commoditData.purchaseNum))
            if row.num >= commoditData.purchaseNum then
              row.isMax = true
              row.isMax_index = 2
              Btn_Item.Group_Bottom.Group_Empty:SetActive(true)
            end
          end
        end
        table.sort(DataModel.Now_ShopList.shopList, function(a, b)
          if a.isMax_index == b.isMax_index then
            return a.index < b.index
          end
          return a.isMax_index < b.isMax_index
        end)
        View.Group_GiftStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.Now_ShopList.shopList))
        View.Group_GiftStore.NewScrollGrid_List.grid.self:RefreshAllElement()
        if DataModel.isMoveEnergyOpen then
          UIManager:GoBack()
        end
        CommonTips.OpenShowItem(json.reward)
        DataModel.RefreshState = 1
        DataModel.ChooseTopList(DataModel.TopIndex)
      end, uiParams)
    end
    CommonTips.OnBuyGiftTips(params, callback)
  end,
  Store_Group_GiftStore_NewScrollGrid_List_Group_gift_Btn_Item_Group_Bottom_Btn_Help_Click = function(btn, str)
    View.Group_MoonTips.self:SetActive(true)
  end,
  Store_Group_SkinPreStore_Btn_Medal_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_SkinPreStore_Btn_Medal_Btn_Add_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_SkinPreStore_NewScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.Now_ShopList.shopList[tonumber(elementIndex)]
    local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
    row.commoditData = commoditData
    row.name = commoditData.name
    row.image = commoditData.iconPath
    row.buyPath = commoditData.buyPath
    local Btn_Item = element.Btn_Item
    local Group_Bottom = Btn_Item.Group_Bottom
    Btn_Item.self:SetClickParam(elementIndex)
    Group_Bottom.Btn_Help:SetClickParam(elementIndex)
    Btn_Item.Img_icon:SetSprite(row.image)
    Group_Bottom.Txt_name:SetText(row.name)
    Group_Bottom.Img_chaozhi:SetActive(false)
    if commoditData.superValue ~= 0 then
      Group_Bottom.Img_chaozhi:SetActive(true)
      Group_Bottom.Img_chaozhi.Txt_shuzhi:SetText(string.format(GetText(80602486), commoditData.superValue))
    end
    Btn_Item.Group_Bottom.Txt_price:SetActive(false)
    Btn_Item.Group_Bottom.Txt_Free:SetActive(false)
    Btn_Item.Group_Bottom.Group_Cost:SetActive(false)
    local isFree = false
    if commoditData.buyType == "Money" then
      if commoditData.value ~= 0 then
        Btn_Item.Group_Bottom.Txt_price:SetActive(true)
        Btn_Item.Group_Bottom.Txt_price:SetText(string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(commoditData.value, 2)))
      else
        isFree = true
      end
    end
    if commoditData.buyType == "Item" then
      if commoditData.buyItemList[1] then
        Btn_Item.Group_Bottom.Group_Cost:SetActive(true)
        Btn_Item.Group_Bottom.Group_Cost.Img_Icon:SetSprite(PlayerData:GetFactoryData(commoditData.buyItemList[1].id).buyPath)
        Btn_Item.Group_Bottom.Group_Cost.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(commoditData.buyItemList[1].num, 2))
      else
        isFree = true
      end
    end
    if isFree == true then
      Btn_Item.Group_Bottom.Txt_Free:SetActive(true)
    end
    row.isFree = isFree
    Btn_Item.Group_Bottom.Group_Empty:SetActive(false)
    Btn_Item.Group_Bottom.Group_LimitNum:SetActive(false)
    Btn_Item.Group_Bottom.Group_LimitTime:SetActive(false)
    Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(false)
    Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
    row.isMax = false
    if commoditData.purchase == true then
      local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
      if typeTxtId ~= nil then
        Btn_Item.Group_Bottom.Group_LimitNum:SetActive(true)
        Btn_Item.Group_Bottom.Group_LimitNum.Txt_LimitNum:SetText(string.format(GetText(typeTxtId), math.max(commoditData.purchaseNum - row.num, 0), commoditData.purchaseNum))
        if row.num >= commoditData.purchaseNum then
          row.isMax = true
          Btn_Item.Group_Bottom.Group_Empty:SetActive(true)
        end
      end
    end
    if commoditData.isTime == true then
      local lastTime = TimeUtil:LastTime(commoditData.endTime)
      if 0 < lastTime then
        local time = TimeUtil:SecondToTable(lastTime)
        Btn_Item.Group_Bottom.Group_LimitTime:SetActive(true)
        Btn_Item.Group_Bottom.Group_LimitTime.Txt_Time:SetText(string.format(GetText(80601059), time.day, time.hour))
      end
    end
    if commoditData.isBuyCondition == true and PlayerData:GetUserInfo().lv < commoditData.gradeCondition then
      Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(true)
      Btn_Item.Group_Bottom.Group_GradeLimit.Txt_Grade:SetText(string.format(GetText(80601022), commoditData.gradeCondition))
      row.isLock = true
    end
    Btn_Item.Group_Bottom.Btn_Help:SetActive(false)
    Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
  end,
  Store_Group_SkinPreStore_NewScrollGrid_List_Group_gift_Btn_Item_Click = function(btn, str)
    local row = DataModel.Now_ShopList.shopList[tonumber(str)]
    if row.isLock then
      CommonTips.OpenTips(80601023)
      return
    end
    if row.isMax then
      CommonTips.OpenTips(80600077)
      return
    end
    local params = {}
    params.name = row.name
    params.commoditData = row.commoditData
    params.num = row.num
    params.weight = row.weight
    params.image = row.image
    params.id = row.id
    params.isFree = row.isFree
    params.isMoveEnergyOpen = DataModel.isMoveEnergyOpen
    local callback = function()
      local metaId = tostring(row.id)
      local shopId = DataModel.Shop_Id
      local name = row.commoditData.name
      local payAmount = row.commoditData.value
      local priceStr = string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(row.commoditData.value, 2))
      local uiParams = Json.encode({
        name = name,
        price = priceStr,
        itemId = metaId,
        shopId = shopId,
        payAmount = payAmount
      })
      PayHelper.Buy(metaId, function(json)
        CommonTips.OpenShowItem(json.reward)
        local list = {}
        local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
        local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
        list.num = 1
        if recharge then
          if recharge[tostring(row.id)] then
            local num = recharge[tostring(row.id)].num + 1
            list.num = num
            recharge[tostring(row.id)].num = num
          else
            recharge[tostring(row.id)] = list
          end
        else
          PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)] = {}
          PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)][tostring(row.id)] = list
        end
        row.num = row.num + 1
        local element = View.Group_SkinPreStore.NewScrollGrid_List.grid.self:GetElementByIndex(tonumber(str) - 1)
        local Btn_Item = element.Btn_Item
        if commoditData.purchase == true then
          local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
          if typeTxtId ~= nil then
            Btn_Item.Group_Bottom.Group_LimitNum:SetActive(true)
            Btn_Item.Group_Bottom.Group_LimitNum.Txt_LimitNum:SetText(string.format(GetText(typeTxtId), commoditData.purchaseNum - row.num, commoditData.purchaseNum))
            if row.num >= commoditData.purchaseNum then
              row.isMax = true
              row.isMax_index = 2
              Btn_Item.Group_Bottom.Group_Empty:SetActive(true)
            end
          end
        end
        table.sort(DataModel.Now_ShopList.shopList, function(a, b)
          if a.isMax_index == b.isMax_index then
            return a.index < b.index
          end
          return a.isMax_index < b.isMax_index
        end)
        View.Group_SkinPreStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.Now_ShopList.shopList))
        View.Group_SkinPreStore.NewScrollGrid_List.grid.self:RefreshAllElement()
        if DataModel.isMoveEnergyOpen then
          UIManager:GoBack()
        end
        DataModel.RefreshState = 1
        DataModel.ChooseTopList(DataModel.TopIndex)
      end, uiParams)
    end
    CommonTips.OnBuyGiftTips(params, callback)
  end,
  Store_Group_SkinPreStore_NewScrollGrid_List_Group_gift_Btn_Item_Group_Bottom_Btn_Help_Click = function(btn, str)
  end,
  Store_Group_GiftStore_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.Now_ShopList.shopList[tonumber(elementIndex)]
    local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
    row.commoditData = commoditData
    row.name = commoditData.name
    row.image = commoditData.iconPath
    row.buyPath = commoditData.buyPath
    local Btn_Item = element.Btn_Item
    local Group_Bottom = Btn_Item.Group_Bottom
    Btn_Item.self:SetClickParam(elementIndex)
    Group_Bottom.Btn_Help:SetClickParam(elementIndex)
    Btn_Item.Img_icon:SetSprite(row.image)
    Group_Bottom.Txt_name:SetText(row.name)
    Group_Bottom.Img_chaozhi:SetActive(false)
    if commoditData.superValue ~= 0 then
      Group_Bottom.Img_chaozhi:SetActive(true)
      Group_Bottom.Img_chaozhi.Txt_shuzhi:SetText(string.format(GetText(80602486), commoditData.superValue))
    end
    Btn_Item.Group_Bottom.Txt_price:SetActive(false)
    Btn_Item.Group_Bottom.Txt_Free:SetActive(false)
    Btn_Item.Group_Bottom.Group_Cost:SetActive(false)
    local isFree = false
    if commoditData.buyType == "Money" then
      if commoditData.value ~= 0 then
        Btn_Item.Group_Bottom.Txt_price:SetActive(true)
        Btn_Item.Group_Bottom.Txt_price:SetText(string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(commoditData.value, 2)))
      else
        isFree = true
      end
    end
    if commoditData.buyType == "Item" then
      if commoditData.buyItemList[1] then
        Btn_Item.Group_Bottom.Group_Cost:SetActive(true)
        Btn_Item.Group_Bottom.Group_Cost.Img_Icon:SetSprite(PlayerData:GetFactoryData(commoditData.buyItemList[1].id).buyPath)
        Btn_Item.Group_Bottom.Group_Cost.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(commoditData.buyItemList[1].num, 2))
      else
        isFree = true
      end
    end
    if isFree == true then
      Btn_Item.Group_Bottom.Txt_Free:SetActive(true)
    end
    row.isFree = isFree
    Btn_Item.Group_Bottom.Group_Empty:SetActive(false)
    Btn_Item.Group_Bottom.Group_LimitNum:SetActive(false)
    Btn_Item.Group_Bottom.Group_LimitTime:SetActive(false)
    Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(false)
    Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
    row.isMax = false
    if commoditData.purchase == true then
      local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
      if typeTxtId ~= nil then
        Btn_Item.Group_Bottom.Group_LimitNum:SetActive(true)
        Btn_Item.Group_Bottom.Group_LimitNum.Txt_LimitNum:SetText(string.format(GetText(typeTxtId), math.max(commoditData.purchaseNum - row.num, 0), commoditData.purchaseNum))
        if row.num >= commoditData.purchaseNum then
          row.isMax = true
          Btn_Item.Group_Bottom.Group_Empty:SetActive(true)
        end
      end
    end
    if commoditData.isTime == true then
      local lastTime = TimeUtil:LastTime(commoditData.endTime)
      if 0 < lastTime then
        local time = TimeUtil:SecondToTable(lastTime)
        Btn_Item.Group_Bottom.Group_LimitTime:SetActive(true)
        Btn_Item.Group_Bottom.Group_LimitTime.Txt_Time:SetText(string.format(GetText(80601059), time.day, time.hour))
      end
    end
    if commoditData.isBuyCondition == true and PlayerData:GetUserInfo().lv < commoditData.gradeCondition then
      Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(true)
      Btn_Item.Group_Bottom.Group_GradeLimit.Txt_Grade:SetText(string.format(GetText(80601022), commoditData.gradeCondition))
      row.isLock = true
    end
    Btn_Item.Group_Bottom.Btn_Help:SetActive(false)
    Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
    if commoditData.ismonthCard == true then
      Btn_Item.Group_Bottom.Btn_Help:SetActive(true)
      if PlayerData.ServerData.monthly_card and PlayerData.ServerData.monthly_card["11400018"] then
        local t = PlayerData.ServerData.monthly_card["11400018"]
        local diff = 0
        if t.reward_ts then
          if t.reward_ts <= t.deadline then
            diff = t.deadline - t.reward_ts
          end
        else
          if t.reward_date == nil or t.reward_date == "" then
            t.reward_date = os.date("%Y-%m-%d %H:%M:%S", TimeUtil:GetFutureTime(0, 6))
          end
          local lastTime = os.time(TimeUtil:GetTimeTable(t.reward_date))
          if lastTime <= t.deadline then
            diff = t.deadline - lastTime
          end
        end
        if 0 < diff then
          local time = TimeUtil:SecondToTable(diff)
          Btn_Item.Group_Bottom.Group_residueTime:SetActive(true)
          Btn_Item.Group_Bottom.Group_residueTime.Txt_residueTime:SetText(string.format(GetText(80601102), time.day))
        end
      end
    end
  end,
  Store_Group_GiftStore_ScrollGrid_List_Group_gift_Btn_Item_Group_Bottom_Btn_Help_Click = function(btn, str)
    View.Group_MoonTips.self:SetActive(true)
  end,
  Store_Group_GiftStore_ScrollGrid_List_Group_gift_Btn_Item_Click = function(btn, str)
    local row = DataModel.Now_ShopList.shopList[tonumber(str)]
    if row.isLock then
      CommonTips.OpenTips(80601023)
      return
    end
    if row.isMax then
      CommonTips.OpenTips(80600077)
      return
    end
    local params = {}
    params.name = row.name
    params.commoditData = row.commoditData
    params.num = row.num
    params.weight = row.weight
    params.image = row.image
    params.id = row.id
    params.isFree = row.isFree
    params.isMoveEnergyOpen = DataModel.isMoveEnergyOpen
    local callback = function()
      local metaId = tostring(row.id)
      local shopId = DataModel.Shop_Id
      local name = row.commoditData.name
      local payAmount = row.commoditData.value
      local priceStr = string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(row.commoditData.value, 2))
      local uiParams = Json.encode({
        name = name,
        price = priceStr,
        itemId = metaId,
        shopId = shopId,
        payAmount = payAmount
      })
      PayHelper.Buy(metaId, function(json)
        local list = {}
        local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
        local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
        list.num = 1
        if recharge then
          if recharge[tostring(row.id)] then
            local num = recharge[tostring(row.id)].num + 1
            list.num = num
            recharge[tostring(row.id)].num = num
          else
            recharge[tostring(row.id)] = list
          end
        else
          PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)] = {}
          PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)][tostring(row.id)] = list
        end
        row.num = row.num + 1
        local element = View.Group_GiftStore.ScrollGrid_List.grid.self:GetElementByIndex(tonumber(str) - 1)
        local Btn_Item = element.Btn_Item
        if commoditData.purchase == true then
          local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
          if typeTxtId ~= nil then
            Btn_Item.Group_Bottom.Group_LimitNum:SetActive(true)
            Btn_Item.Group_Bottom.Group_LimitNum.Txt_LimitNum:SetText(string.format(GetText(typeTxtId), commoditData.purchaseNum - row.num, commoditData.purchaseNum))
            if row.num == commoditData.purchaseNum then
              row.isMax = true
              Btn_Item.Group_Bottom.Group_Empty:SetActive(true)
            end
          end
        end
        if DataModel.isMoveEnergyOpen then
          UIManager:GoBack()
        end
        CommonTips.OpenShowItem(json.reward)
        DataModel.RefreshState = 1
        DataModel.ChooseTopList(DataModel.TopIndex)
      end, uiParams)
    end
    CommonTips.OnBuyGiftTips(params, callback)
  end,
  Store_Group_SkinPreStore_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.Now_ShopList.shopList[tonumber(elementIndex)]
    local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
    row.commoditData = commoditData
    row.name = commoditData.name
    row.image = commoditData.iconPath
    row.buyPath = commoditData.buyPath
    local Btn_Item = element.Btn_Item
    local Group_Bottom = Btn_Item.Group_Bottom
    Btn_Item.self:SetClickParam(elementIndex)
    Group_Bottom.Btn_Help:SetClickParam(elementIndex)
    Btn_Item.Img_icon:SetSprite(row.image)
    Group_Bottom.Txt_name:SetText(row.name)
    Group_Bottom.Img_chaozhi:SetActive(false)
    if commoditData.superValue ~= 0 then
      Group_Bottom.Img_chaozhi:SetActive(true)
      Group_Bottom.Img_chaozhi.Txt_shuzhi:SetText(string.format(GetText(80602486), commoditData.superValue))
    end
    Btn_Item.Group_Bottom.Txt_price:SetActive(false)
    Btn_Item.Group_Bottom.Txt_Free:SetActive(false)
    Btn_Item.Group_Bottom.Group_Cost:SetActive(false)
    local isFree = false
    if commoditData.buyType == "Money" then
      if commoditData.value ~= 0 then
        Btn_Item.Group_Bottom.Txt_price:SetActive(true)
        Btn_Item.Group_Bottom.Txt_price:SetText(string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(commoditData.value, 2)))
      else
        isFree = true
      end
    end
    if commoditData.buyType == "Item" then
      if commoditData.buyItemList[1] then
        Btn_Item.Group_Bottom.Group_Cost:SetActive(true)
        Btn_Item.Group_Bottom.Group_Cost.Img_Icon:SetSprite(PlayerData:GetFactoryData(commoditData.buyItemList[1].id).buyPath)
        Btn_Item.Group_Bottom.Group_Cost.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(commoditData.buyItemList[1].num, 2))
      else
        isFree = true
      end
    end
    if isFree == true then
      Btn_Item.Group_Bottom.Txt_Free:SetActive(true)
    end
    row.isFree = isFree
    Btn_Item.Group_Bottom.Group_Empty:SetActive(false)
    Btn_Item.Group_Bottom.Group_LimitNum:SetActive(false)
    Btn_Item.Group_Bottom.Group_LimitTime:SetActive(false)
    Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(false)
    Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
    row.isMax = false
    if commoditData.purchase == true then
      local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
      if typeTxtId ~= nil then
        Btn_Item.Group_Bottom.Group_LimitNum:SetActive(true)
        Btn_Item.Group_Bottom.Group_LimitNum.Txt_LimitNum:SetText(string.format(GetText(typeTxtId), math.max(commoditData.purchaseNum - row.num, 0), commoditData.purchaseNum))
        if row.num >= commoditData.purchaseNum then
          row.isMax = true
          Btn_Item.Group_Bottom.Group_Empty:SetActive(true)
        end
      end
    end
    if commoditData.isTime == true then
      local lastTime = TimeUtil:LastTime(commoditData.endTime)
      if 0 < lastTime then
        local time = TimeUtil:SecondToTable(lastTime)
        Btn_Item.Group_Bottom.Group_LimitTime:SetActive(true)
        Btn_Item.Group_Bottom.Group_LimitTime.Txt_Time:SetText(string.format(GetText(80601059), time.day, time.hour))
      end
    end
    if commoditData.isBuyCondition == true and PlayerData:GetUserInfo().lv < commoditData.gradeCondition then
      Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(true)
      Btn_Item.Group_Bottom.Group_GradeLimit.Txt_Grade:SetText(string.format(GetText(80601022), commoditData.gradeCondition))
      row.isLock = true
    end
    Btn_Item.Group_Bottom.Btn_Help:SetActive(false)
    Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
  end,
  Store_Group_SkinPreStore_ScrollGrid_List_Group_gift_Btn_Item_Click = function(btn, str)
    local row = DataModel.Now_ShopList.shopList[tonumber(str)]
    if row.isLock then
      CommonTips.OpenTips(80601023)
      return
    end
    if row.isMax then
      CommonTips.OpenTips(80600077)
      return
    end
    local params = {}
    params.name = row.name
    params.commoditData = row.commoditData
    params.num = row.num
    params.weight = row.weight
    params.image = row.image
    params.id = row.id
    params.isFree = row.isFree
    params.isMoveEnergyOpen = DataModel.isMoveEnergyOpen
    local callback = function()
      local metaId = tostring(row.id)
      local shopId = DataModel.Shop_Id
      local name = row.commoditData.name
      local payAmount = row.commoditData.value
      local priceStr = string.format(GetText(80601069), PlayerData:GetPreciseDecimalFloor(row.commoditData.value, 2))
      local uiParams = Json.encode({
        name = name,
        price = priceStr,
        itemId = metaId,
        shopId = shopId,
        payAmount = payAmount
      })
      PayHelper.Buy(metaId, function(json)
        local list = {}
        local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
        local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
        list.num = 1
        if recharge then
          if recharge[tostring(row.id)] then
            local num = recharge[tostring(row.id)].num + 1
            list.num = num
            recharge[tostring(row.id)].num = num
          else
            recharge[tostring(row.id)] = list
          end
        else
          PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)] = {}
          PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)][tostring(row.id)] = list
        end
        row.num = row.num + 1
        local element = View.Group_SkinPreStore.ScrollGrid_List.grid.self:GetElementByIndex(tonumber(str) - 1)
        local Btn_Item = element.Btn_Item
        if commoditData.purchase == true then
          local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
          if typeTxtId ~= nil then
            Btn_Item.Group_Bottom.Group_LimitNum:SetActive(true)
            Btn_Item.Group_Bottom.Group_LimitNum.Txt_LimitNum:SetText(string.format(GetText(typeTxtId), commoditData.purchaseNum - row.num, commoditData.purchaseNum))
            if row.num >= commoditData.purchaseNum then
              row.isMax = true
              row.isMax_index = 2
              Btn_Item.Group_Bottom.Group_Empty:SetActive(true)
            end
          end
        end
        table.sort(DataModel.Now_ShopList.shopList, function(a, b)
          if a.isMax_index == b.isMax_index then
            return a.index < b.index
          end
          return a.isMax_index < b.isMax_index
        end)
        get_gift_grid():SetDataCount(table.count(DataModel.Now_ShopList.shopList))
        get_gift_grid():RefreshAllElement()
        if DataModel.isMoveEnergyOpen then
          UIManager:GoBack()
        end
        CommonTips.OpenShowItem(json.reward)
        DataModel.RefreshState = 1
        DataModel.ChooseTopList(DataModel.TopIndex)
      end, uiParams)
    end
    CommonTips.OnBuyGiftTips(params, callback)
  end,
  Store_Group_SkinPreStore_ScrollGrid_List_Group_gift_Btn_Item_Group_Bottom_Btn_Help_Click = function(btn, str)
  end,
  Store_StaticGrid_TopButton_Btn_Top_000_Click = function(btn, str)
    DataModel.ChooseTopList(str)
  end,
  Store_StaticGrid_TopButton_Btn_Top_001_Click = function(btn, str)
    DataModel.ChooseTopList(str)
  end,
  Store_StaticGrid_TopButton_Btn_Top_002_Click = function(btn, str)
    DataModel.ChooseTopList(str)
  end,
  Store_StaticGrid_TopButton_Btn_Top_003_Click = function(btn, str)
    DataModel.ChooseTopList(str)
  end,
  Store_StaticGrid_TopButton_Btn_Top_004_Click = function(btn, str)
    DataModel.ChooseTopList(str)
  end,
  Store_Group_MoonStore_Group_RoleStore_StaticGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.RoleStore[tonumber(elementIndex)]
    local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
    row.commoditData = commoditData
    row.name = commoditData.commodityName
    row.image = commoditData.commodityView
    row.residue = 0
    local Btn_Item = element.Btn_Item
    Btn_Item.self:SetClickParam(elementIndex)
    Btn_Item.Txt_ItemName:SetText(row.name)
    local Item = PlayerData:GetFactoryData(commoditData.commodityItemList[1].id)
    Btn_Item.Img_ItemBG.Img_Item:SetSprite(row.image)
    local quantity = Item.qualityInt
    Btn_Item.Img_ItemBG:SetSprite(UIConfig.BottomConfig[quantity])
    row.qualityInt = quantity
    local purchase = commoditData.purchase
    Btn_Item.Img_Sold.self:SetActive(false)
    if purchase == true then
      row.residue = commoditData.purchaseNum - (row.server and row.server.py_cnt or 0)
      if row.residue < 0 then
        row.residue = 0
      end
      Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText(string.format(GetText(80600430), row.residue))
      Btn_Item.Img_ItemBG.Img_Residue:SetActive(true)
      if row.residue == 0 then
        Btn_Item.Img_Sold.self:SetActive(true)
      else
        Btn_Item.Img_Sold.self:SetActive(false)
      end
    else
      Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText("")
      Btn_Item.Img_ItemBG.Img_Residue:SetActive(false)
    end
    Btn_Item.Img_ItemBG.Txt_Num:SetText(commoditData.commodityNum or 1)
    local money = commoditData.moneyList[1]
    if money then
      local priceNum = commoditData.moneyList[1].moneyNum
      local moneyID = commoditData.moneyList[1].moneyID
      row.priceNum = priceNum
      row.moneyID = moneyID
      Btn_Item.Img_Money:SetActive(true)
      local left_money = PlayerData:GetFactoryData(tonumber(commoditData.moneyList[1].moneyID))
      Btn_Item.Img_Money.self:SetSprite(left_money.iconPath)
      Btn_Item.Img_Money.Txt_MoneyNum:SetText(priceNum)
      return
    end
    Btn_Item.Img_Money:SetActive(false)
  end,
  Store_Group_MoonStore_Group_RoleStore_StaticGrid_List_Group_ItemMoon_Btn_Item_Click = function(btn, str)
    local row = DataModel.RoleStore[tonumber(str)]
    if row.priceNum and row.priceNum > 0 and PlayerData:GetGoodsById(row.moneyID).num < row.priceNum then
      CommonTips.OpenTips(string.format(GetText(80600023), PlayerData:GetFactoryData(row.moneyID, "ItemFactory").name))
      return
    end
    if row.residue == 0 then
      return
    end
    row.index = tonumber(str) - 1
    row.shopid = DataModel.shop_id
    row.type = "role"
    CommonTips.OpenBuyTips(row)
  end,
  Store_Group_MoonStore_Group_RoleStore_Group_TimeCommodity_Btn_Buy_Click = function(btn, str)
    local shopCA = DataModel.Choose_Purchase_Role.shopCA
    local priceNum = shopCA.moneyList[1].moneyNum
    local moneyID = tonumber(shopCA.moneyList[1].moneyID)
    if priceNum and 0 < priceNum and priceNum > PlayerData:GetGoodsById(moneyID).num then
      CommonTips.OpenTips(string.format(GetText(80600023), PlayerData:GetFactoryData(moneyID, "ItemFactory").name))
      return
    end
    Net:SendProto("shop.buy", function(json)
      print_r(json)
      local row = json.reward
      row.Title = "获得角色"
      CommonTips.OpenShowItem(json.reward)
      DataModel.RefreshState = 1
      Refresh_Right_Top_Num()
      RefreshShopList(json)
    end, DataModel.shop_id, DataModel.Choose_Purchase_Role.index, 1, DataModel.Choose_Purchase_Role.id)
  end,
  Store_Group_MoonStore_Group_RoleStore_Btn_Medal_Click = function(btn, str)
    CommonTips.OpenPreItemTips({
      itemId = 11400017,
      type = EnumDefine.OpenTip.NoDepot
    })
  end,
  Store_Group_DailyStore_StaticGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.Choose_List.items[tonumber(elementIndex)]
    local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
    row.commoditData = commoditData
    row.name = commoditData.commodityName
    row.image = commoditData.commodityView
    row.residue = 0
    local Btn_Item = element.Btn_Item
    Btn_Item.self:SetClickParam(elementIndex)
    Btn_Item.Txt_ItemName:SetText(row.name)
    local Item = PlayerData:GetFactoryData(commoditData.commodityItemList[1].id)
    Btn_Item.Img_ItemBG.Img_Item:SetSprite(row.image)
    local quantity = Item.qualityInt
    Btn_Item.Img_ItemBG:SetSprite(UIConfig.BottomConfig[quantity + 1])
    row.qualityInt = quantity
    local purchase = commoditData.purchase
    if purchase == true then
      row.residue = commoditData.purchaseNum - row.py_cnt
      if row.residue < 0 then
        row.residue = 0
      end
      Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText(string.format(GetText(80600430), row.residue))
      if row.residue == 0 then
        Btn_Item.Img_Sold.self:SetActive(true)
      else
        Btn_Item.Img_Sold.self:SetActive(false)
      end
    else
      Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText("")
    end
    Btn_Item.Img_ItemBG.Txt_Num:SetText(commoditData.commodityNum or 1)
    local money = commoditData.moneyList[1]
    if money then
      Btn_Item.Img_Money:SetActive(true)
      local left_money = PlayerData:GetFactoryData(tonumber(commoditData.moneyList[1].moneyID))
      Btn_Item.Img_Money.self:SetSprite(left_money.iconPath)
      Btn_Item.Img_Money.Txt_MoneyNum:SetText(commoditData.moneyList[1].moneyNum)
      return
    end
    Btn_Item.Img_Money:SetActive(false)
  end,
  Store_Group_DailyStore_StaticGrid_List_Group_Item_Btn_Item_Click = function(btn, str)
    local row = DataModel.Choose_List.items[tonumber(str)]
    if row.residue == 0 then
      CommonTips.OpenTips(80600077)
      return
    end
    row.index = tonumber(str) - 1
    row.shopid = DataModel.shop_id
    CommonTips.OpenBuyTips(row)
  end,
  Store_Group_DailyStore_Group_Bottom_Img_Backgroud_Img_refresh_Btn_Mask_Click = function(btn, str)
    local sever_now = PlayerData.ServerData.server_now
    if freeCount - DataModel.Choose_List.refresh_num > 0 then
      SendRefreshShop()
      return
    elseif PlayerData:GetPlayerPrefs("int", "refreshState" .. DataModel.shop_id) == 0 and sever_now ~= PlayerData:GetPlayerPrefs("int", "lastautorefresh" .. DataModel.shop_id) then
      OpenStockPage()
    else
      ConsRockRefresh()
    end
  end,
  Store_Group_DailyStore_Group_Bottom_Img_Backgroud_Btn_Refresh_Click = function(btn, str)
  end,
  Store_Group_DailyStore_Group_Reward_StaticGrid_Box_SetGrid = function(element, elementIndex)
    local row = DataModel.Choose_List.rewards[tonumber(elementIndex)]
    local Btn_Box = element.Btn_Box
    Btn_Box.self:SetClickParam(elementIndex)
    Btn_Box.Group_NoGet.Btn_Preview:SetClickParam(elementIndex)
    Btn_Box.Group_Got.Btn_Preview:SetClickParam(elementIndex)
    Btn_Box.Group_CanGet.Btn_Get:SetClickParam(elementIndex)
    Btn_Box.Group_NoGet:SetActive(false)
    Btn_Box.Group_Got:SetActive(false)
    Btn_Box.Group_CanGet:SetActive(false)
    row.status_rec = 0
    if row.received_status == 1 then
      row.status_rec = 1
      Btn_Box.Group_Got:SetActive(true)
      Btn_Box.Group_Got.Txt_Num:SetText(row.buy_times)
    end
    if row.received_status == 0 then
      if DataModel.Choose_List.shop_times >= row.buy_times then
        row.status_rec = 2
        Btn_Box.Group_CanGet:SetActive(true)
        Btn_Box.Group_CanGet.Txt_Num:SetText(row.buy_times)
      else
        row.status_rec = 0
        Btn_Box.Group_NoGet:SetActive(true)
        Btn_Box.Group_NoGet.Txt_Num:SetText(row.buy_times)
      end
    end
    DataModel.Group_Reward[tonumber(elementIndex)] = PlayerData:GetFactoryData(row.id).goodsList
    DataModel.Now_Group_Index = tonumber(elementIndex)
    element.Group_Preview.StaticGrid_Item.grid.self:RefreshAllElement()
    element.Group_Preview:SetActive(false)
  end,
  Store_Group_DailyStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Click = function(btn, str)
    ClickBottomReward(tonumber(str))
  end,
  Store_Group_DailyStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Group_NoGet_Btn_Preview_Click = function(btn, str)
    ClickBottomReward(tonumber(str))
  end,
  Store_Group_DailyStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Group_Got_Btn_Preview_Click = function(btn, str)
    ClickBottomReward(tonumber(str))
  end,
  Store_Group_DailyStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Group_CanGet_Btn_Get_Click = function(btn, str)
    ClickBottomReward(tonumber(str))
  end,
  Store_Group_DailyStore_Group_Reward_StaticGrid_Box_Group_Box_Group_Preview_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.Group_Reward[DataModel.Now_Group_Index][tonumber(elementIndex)]
    element.Btn_Item:SetClickParam(elementIndex)
    CommonItem:SetItem(element, row)
  end,
  Store_Group_DailyStore_Group_Reward_StaticGrid_Box_Group_Box_Group_Preview_StaticGrid_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local row = DataModel.Group_Reward[DataModel.Now_Group_Index][tonumber(str)]
    CommonTips.OpenRewardDetail(row.id)
  end,
  Store_Group_DailyStore_Group_Reward_Btn_Back_Click = function(btn, str)
    ClickBottomReward(DataModel.Now_Group_Index)
  end,
  Store_Group_RoleStore_StaticGrid_List_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Store_Group_RoleStore_Group_Bottom_Img_Backgroud_Img_refresh_Btn_Mask_Click = function(btn, str)
  end,
  Store_Group_RoleStore_Group_Bottom_Img_Backgroud_Btn_Refresh_Click = function(btn, str)
  end,
  Store_Group_DiamondStore_ScrollGrid_List_Group_Item_2_Btn_Item_Click = function(btn, str)
    local row = DataModel.Choose_List.items[tonumber(str)]
    OpenDetail(row, tonumber(str) - 1)
  end,
  Store_Group_DailyStore_Group_Reward_StaticGrid_Box_Group_Box_Group_Preview_Btn_Back_Click = function(btn, str)
    local element = View.Group_DailyStore.Group_Reward.StaticGrid_Box.grid[tonumber(str)]
    if element.Group_Preview.IsActive == true then
      element.Group_Preview:SetActive(false)
    else
      element.Group_Preview:SetActive(true)
    end
  end,
  Store_Group_TopRight_Img_Diamond_Click = function(btn, str)
    UpdateBottomButtonState(1)
  end,
  Store_Group_TopRight_Img_Gold_Click = function(btn, str)
  end,
  Store_Refresh_Time = function()
    last_auto_refresh = DataModel.List[DataModel.auto_refresh_index or 1].last_auto_refresh or 0
  end,
  Store_Refresh_Right_Top_Num = function()
    Refresh_Right_Top_Num()
  end,
  Store_Init = function(index)
    Refresh_Right_Top_Num()
    gird_daily = nil
    gird_dimond = nil
    grid_role = nil
    grid_gift = nil
    grid_gold = nil
    grid_gold_reward = nil
    grid_daily_reward = nil
    DataModel.shop_id = nil
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_DiamondStore")
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_GoldStore")
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_GiftStore")
    bottom_button_config = {
      {
        button = View.Group_Top_Button.Btn_recommend
      },
      {
        button = View.Group_Top_Button.Btn_diamondstore,
        show = View.Group_DiamondStore
      },
      {
        button = View.Group_Top_Button.Btn_dailystore,
        show = View.Group_DailyStore,
        reward = get_reward_daily_grid
      },
      {
        button = View.Group_Top_Button.Btn_glodStore,
        show = View.Group_GoldStore,
        reward = get_reward_gold_grid
      },
      {
        button = View.Group_Top_Button.Btn_giftStore,
        show = View.Group_GiftStore
      },
      {
        button = View.Group_Top_Button.Btn_roleStore,
        show = View.Group_RoleStore
      },
      {
        button = View.Group_Top_Button.Btn_month,
        show = View.Group_Month
      }
    }
    UpdateBottomButtonState(index or 2)
  end
}
return ViewFunction
