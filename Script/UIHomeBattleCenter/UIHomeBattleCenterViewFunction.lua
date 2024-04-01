local CommonItem = require("Common/BtnItem")
local View = require("UIHomeBattleCenter/UIHomeBattleCenterView")
local DataModel = require("UIHomeBattleCenter/UIHomeBattleCenterDataModel")
local ViewFunction = {
  HomeBattleCenter_Group_Main_Btn_Battle_Click = function(btn, str)
    DataModel:OpenBattlePage()
  end,
  HomeBattleCenter_Group_Main_Btn_Order_Click = function(btn, str)
    DataModel:OpenOrderPage()
  end,
  HomeBattleCenter_Group_Main_Btn_Talk_Click = function(btn, str)
    DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end,
  HomeBattleCenter_Group_Zhu_Group_Construct_Btn_Construct_Click = function(btn, str)
    DataModel:OpenConstructStage()
  end,
  HomeBattleCenter_Group_Battle_Group_Ding_Btn_Energy_Click = function(btn, str)
    local callback = function()
      DataModel:RefreshResource(DataModel.Index_OutSide)
    end
    CommonTips.OpenEnergy(callback)
  end,
  HomeBattleCenter_Group_Battle_Group_Ding_Btn_Energy_Btn_Add_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Battle_Group_1_Group_Information_Group_TZ_Btn_QW_Click = function(btn, str)
    local info = DataModel.ShowBattleLevelList[tonumber(DataModel.Index_Battle)]
    local levelId = info.id
    local levelCA = info.ca
    local detailDo = function()
      if CommonTips.OpenBuyEnergyTips(levelId) then
        return
      end
      local status = {
        Current = "Chapter",
        squadIndex = PlayerData.BattleInfo.squadIndex,
        hasOpenThreeView = false,
        stationId = DataModel.StationId,
        npcId = DataModel.NpcId,
        bgPath = DataModel.BgPath,
        autoShowLevel = 1,
        name = DataModel.StationName,
        isBattleCenter = true
      }
      PlayerData.BattleInfo.battleStageId = levelId
      PlayerData.BattleCallBackPage = "UI/HomeBattleCenter/HomeBattleCenter"
      UIManager:Open("UI/Squads/Squads", Json.encode(status))
    end
    if not levelCA.isEnemyLvEquilsPlayer and levelCA.recomGrade - PlayerData:GetPlayerLevel() >= 5 then
      local checkTipParam = {}
      checkTipParam.isCheckTip = true
      checkTipParam.checkTipKey = "HomeBattleCenterHardTip"
      checkTipParam.checkTipType = 1
      checkTipParam.showDanger = true
      CommonTips.OnPrompt(80601227, nil, nil, detailDo, nil, nil, nil, nil, checkTipParam)
    else
      detailDo()
    end
  end,
  HomeBattleCenter_Group_Battle_Group_1_Group_Information_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local row = DataModel.ChooseRewardList[elementIndex]
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    element.Group_First.self:SetActive(false)
    element.Group_Allready.self:SetActive(false)
    if row.type == 1 then
      element.Group_First.self:SetActive(true)
      if row.isFinish == true then
        element.Group_Allready.self:SetActive(true)
      end
    end
    CommonItem:SetItem(element.Group_Item, row)
  end,
  HomeBattleCenter_Group_Battle_Group_1_Group_Information_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.ChooseRewardList[tonumber(str)].id, nil, true)
  end,
  HomeBattleCenter_Group_Battle_Group_1_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.ShowBattleLevelList[elementIndex]
    local ca = PlayerData:GetFactoryData(row.id)
    row.ca = ca
    row.element = element
    element:SetActive(true)
    element.Img_Di:SetSprite(DataModel.difficultyBg[row.difficulty])
    element.Txt_Grade:SetText(elementIndex)
    element.Btn_:SetClickParam(elementIndex)
    element.Group_Limit:SetActive(not PlayerData:GetLevelPass(row.id))
    element.Group_Clear:SetActive(PlayerData:GetLevelPass(row.id))
    element.Img_Select:SetActive(false)
    row.isBattle = PlayerData:GetLevelPass(row.id)
    if tonumber(elementIndex) == 1 then
      element.Group_Limit:SetActive(false)
      row.isBattle = true
    end
    if DataModel.ShowBattleLevelList[elementIndex - 1] then
      local last_row = DataModel.ShowBattleLevelList[elementIndex - 1]
      if PlayerData:GetLevelPass(last_row.id) == true then
        element.Group_Limit:SetActive(false)
        row.isBattle = true
        DataModel.Index_Init = tonumber(elementIndex)
      end
    end
    if DataModel.Index_Battle and elementIndex == DataModel.Index_Battle then
      element.Img_Select:SetActive(true)
    end
  end,
  HomeBattleCenter_Group_Battle_Group_1_ScrollGrid_List_Group_Item_Btn__Click = function(btn, str)
    DataModel:ChooseBattleLevel(tonumber(str))
  end,
  HomeBattleCenter_Group_Order_Group_Ding_Btn_Energy_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Order_Group_Ding_Btn_Energy_Btn_Add_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Order_Group_Ding_Btn_YN_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Order_Group_Ding_Btn_YN_Btn_Add_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Order_Group_1_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.orderList[elementIndex]
    row.isRefresh = false
    row.isDelete = false
    if row.oid ~= "" and row.oid ~= nil then
      local config = PlayerData:GetFactoryData(row.oid)
      row.config = config
      element.Btn_:SetClickParam(elementIndex)
      element.Txt_Name:SetText(config.name)
      element.Group_Submit:SetActive(false)
      element.Group_Limit:SetActive(false)
      element.Group_On:SetActive(false)
      if row.refresh_time and row.refresh_time ~= -1 and row.refresh_time - TimeUtil:GetServerTimeStamp() > 0 then
        local time = row.refresh_time - TimeUtil:GetServerTimeStamp()
        row.isRefresh = true
        element.Group_Limit:SetActive(true)
        element.Group_Limit.Group_Time:SetActive(true)
        element.Group_Limit.Group_Other:SetActive(false)
        element.Group_Limit.Txt_Num:SetText("0" .. elementIndex)
        element.Group_Limit.Group_Time.Txt_Time:SetText(string.format(GetText(80601232), TimeUtil:SecondToTable(time).minute, TimeUtil:SecondToTable(time).second))
      else
        element.Group_Limit.Group_Time:SetActive(false)
        element.Group_Limit.Group_Other:SetActive(false)
        local count_list = 0
        local count_e = 0
        for i = 1, 3 do
          local obj_name = "Group_Consume" .. i
          local obj = element.Group_Item[obj_name]
          obj:SetActive(false)
          if config.requireItemList[i] then
            count_list = count_list + 1
            obj:SetActive(true)
            CommonItem:SetItem(obj.Group_Item, {
              id = config.requireItemList[i].id,
              num = ""
            })
            obj.Group_Item.Btn_Item:SetClickParam(config.requireItemList[i].id)
            obj.Group_Cost.Txt_Need:SetText(PlayerData:TransitionNum(config.requireItemList[i].num))
            obj.Group_Cost.Txt_Have:SetText(PlayerData:TransitionNum(PlayerData:GetGoodsById(config.requireItemList[i].id).num))
            obj.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
            if config.requireItemList[i].num <= PlayerData:GetGoodsById(config.requireItemList[i].id).num then
              obj.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
              count_e = count_e + 1
            end
          end
        end
        row.isSubmit = false
        if count_e == count_list then
          row.isSubmit = true
          element.Group_Submit:SetActive(true)
        end
      end
    else
      element.Group_On:SetActive(false)
      element.Group_Limit:SetActive(true)
      element.Group_Limit.Group_Time:SetActive(false)
      element.Group_Limit.Group_Other:SetActive(false)
      if row.is_unlock == 0 then
        element.Group_Limit.Group_Other:SetActive(true)
        element.Group_Limit.Txt_Num:SetText("0" .. elementIndex)
        element.Group_Limit.Group_Other.Txt_Other:SetText(string.format(GetText(80601233), row.ca.constructLimit))
      end
      if row.refresh_time and row.refresh_time ~= -1 and row.refresh_time - TimeUtil:GetServerTimeStamp() > 0 then
        row.isRefresh = true
        element.Group_Limit.Txt_Num:SetText("0" .. elementIndex)
      end
    end
    if DataModel.Index_Order and DataModel.Index_Order == tonumber(elementIndex) then
      element.Group_On:SetActive(true)
    end
    if row.is_unlock == 1 and row.isRefresh == false then
      row.isDelete = true
      DataModel.isAllRefreshCount = DataModel.isAllRefreshCount + 1
    end
    element.Txt_Num:SetText("0" .. elementIndex)
    row.element = element
  end,
  HomeBattleCenter_Group_Order_Group_1_ScrollGrid_List_Group_Item_Btn__Click = function(btn, str)
    DataModel:ChooseOrder(tonumber(str))
  end,
  HomeBattleCenter_Group_Order_Group_1_ScrollGrid_List_Group_Item_Group_Item_Group_Consume1_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  HomeBattleCenter_Group_Order_Group_1_ScrollGrid_List_Group_Item_Group_Item_Group_Consume2_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  HomeBattleCenter_Group_Order_Group_1_ScrollGrid_List_Group_Item_Group_Item_Group_Consume3_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  HomeBattleCenter_Group_Order_Group_1_Group_Dec_Group_Reward_Btn_Exchange_Click = function(btn, str)
    DataModel:DeleteOreder()
  end,
  HomeBattleCenter_Group_Order_Group_1_Group_Dec_Group_Reward_Btn_Delivery_Click = function(btn, str)
    local row = DataModel.orderList[DataModel.Index_Order]
    DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.orderSuccessText)
    Net:SendProto("station.complete_order", function(Json)
      DataModel.StationList.orders = Json.change_order
      if Json.construction then
        DataModel.StationList.construction = Json.construction
      end
      CommonTips.OpenShowItem(Json.reward)
      local list = {}
      for k, v in pairs(row.config.requireItemList) do
        list[tostring(v.id)] = {}
        list[tostring(v.id)][tostring(v.id)] = {}
        list[tostring(v.id)][tostring(v.id)].num = v.num
      end
      PlayerData:RemoveDepotServer(list)
      DataModel:OpenOrderPage(1)
      DataModel:RefreshLeftData()
      QuestTrace.CompleteQuestOne(row.oid)
    end, DataModel.Index_Order - 1)
  end,
  HomeBattleCenter_Group_Order_Group_1_Group_Dec_Group_Reward_Btn_NotDelivery_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Order_Group_1_Group_Dec_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    local row = DataModel.ChooseBattleRewardList[elementIndex]
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    CommonItem:SetItem(element.Group_Item, row)
  end,
  HomeBattleCenter_Group_Order_Group_1_Group_Dec_ScrollGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.ChooseBattleRewardList[tonumber(str)].id, nil, true)
  end,
  HomeBattleCenter_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.Group_Zhu.self:SetActive(false)
    if View.Group_Battle.self.IsActive or View.Group_Order.self.IsActive or View.Group_Ticket.self.IsActive or View.Group_Exchange.self.IsActive or View.Group_Sale.self.IsActive then
      View.Group_Ticket.self:SetActive(false)
      View.Group_Order.self:SetActive(false)
      View.Group_Battle.self:SetActive(false)
      View.Group_Exchange.self:SetActive(false)
      View.Group_Sale.self:SetActive(false)
      View.Group_Main.self:SetActive(true)
      View.self:PlayAnim("Main")
      return
    end
    UIManager:Open("UI/CityMap/CityMap", Json.encode({
      stationId = DataModel.StationId
    }))
  end,
  HomeBattleCenter_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  HomeBattleCenter_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Order_Group_1_Group_Dec_Group_Reward_Btn_QuestSign_Click = function(btn, str)
    DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.signText)
    local row = DataModel.orderList[DataModel.Index_Order]
    Net:SendProto("station.mark_order", function(Json)
      QuestTrace.AcceptQuest(row.oid)
      local index = DataModel.Index_Order
      local row = DataModel.orderList[index]
      row.is_mark = true
      DataModel.StationList.orders[index].is_mark = 1
      DataModel.Index_Order = nil
      DataModel:ChooseOrder(index)
    end, DataModel.Index_Order - 1)
  end,
  HomeBattleCenter_Group_Order_Group_1_Group_Dec_Group_Reward_Btn_NotQuestSign_Click = function(btn, str)
    DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.cancelSignText)
    local row = DataModel.orderList[DataModel.Index_Order]
    Net:SendProto("station.mark_order", function(Json)
      QuestTrace.CancelQuest(row.oid)
      local index = DataModel.Index_Order
      DataModel.orderList[index].is_mark = false
      DataModel.StationList.orders[index].is_mark = nil
      DataModel.Index_Order = nil
      DataModel:ChooseOrder(index)
    end, DataModel.Index_Order - 1)
  end,
  HomeBattleCenter_Group_Main_StaticGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.StationCA.openPageList[tonumber(elementIndex)]
    element.Btn_List:SetClickParam(elementIndex)
    element.Btn_List.Txt_Dec:SetText(row.name)
    element.Btn_List.Img_Icon:SetSprite(row.icon)
    if row.isStore == true then
      local isStoreOpen = false
      local storeRemainTime
      local storeList = DataModel.StationCA.exchangeStoreList
      for i = 1, #storeList do
        isStoreOpen, storeRemainTime = PlayerData:IsStoreOpen(storeList[i].id)
        if isStoreOpen then
          break
        end
      end
      local imgLimit = element.Btn_List.Img_Limit
      local group_time = element.Btn_List.Group_Time
      imgLimit.self:SetActive(not isStoreOpen)
      group_time.self:SetActive(isStoreOpen and storeRemainTime ~= nil)
      if isStoreOpen then
        if storeRemainTime ~= nil then
          group_time.Txt_Time:SetText(string.format(GetText(80601093), math.floor(storeRemainTime / 86400)))
        end
      else
        imgLimit.Txt_Dec:SetText(row.name)
        imgLimit.Img_Icon:SetSprite(row.icon)
      end
    else
      element.Btn_List.Img_Limit.self:SetActive(false)
      element.Btn_List.Group_Time.self:SetActive(false)
    end
  end,
  HomeBattleCenter_Group_Main_StaticGrid_List_Group_Btn_Btn_List_Click = function(btn, str)
    local row = DataModel.StationCA.openPageList[tonumber(str)]
    if row.isTalk == true then
      DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
      return
    end
    if row.showUI == "Group_Battle" then
      DataModel:OpenBattlePage()
    end
    if row.showUI == "Group_Order" then
      DataModel:OpenOrderPage()
    end
    if row.showUI == "Group_Ticket" then
      View.self:PlayAnim("ticketIn")
      local fairyland = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)].fairyland
      DataModel:RefreshParkInfo(fairyland)
      Net:SendProto("station.park_reward", function(json)
        DataModel:RefreshParkInfo(json.interface)
        DataModel:OpenTicketPage()
      end)
    end
    if row.showUI == "Group_Exchange" then
      DataModel:OpenStorePage()
    end
    if row.showUI == "Group_Sale" then
      DataModel:OpenSalePage()
    end
  end,
  HomeBattleCenter_Group_Main_Group_Btn_Btn_List_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Order_Group_Ding_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Order_Group_Ding_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Main_Btn_Income_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TicketProfit_Btn__Click = function(btn, str)
    if DataModel.park.current_reward <= 0 then
      CommonTips.OpenTips(80602090)
      return
    end
    Net:SendProto("station.park_reward", function(json)
      if json.reward then
        CommonTips.OpenShowItem(json.reward)
      end
      if table.count(DataModel.park.record) > 0 then
        local curMonthIndex = table.count(DataModel.park.record)
        DataModel.park.record[curMonthIndex] = DataModel.park.record[curMonthIndex] + DataModel.park.current_reward
        if DataModel.park.record[curMonthIndex] > DataModel.park.record[DataModel.park.maxProfitMonthIndex] then
          DataModel.park.maxProfitMonthIndex = curMonthIndex
        end
      end
      DataModel.park.current_reward = 0
      DataModel:RefreshBySelectType(1)
    end, 1)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Group_TicketProfit_Btn_on_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Group_TicketProfit_Btn_off_Click = function(btn, str)
    DataModel:RefreshBySelectType(1)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Group_Investment_Btn_on_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Group_Investment_Btn_off_Click = function(btn, str)
    DataModel:RefreshBySelectType(2)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Group_Quest_Btn_on_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Group_Quest_Btn_off_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_GroupGold_Btn_Add_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_Quest_ScrollGrid_Quest_SetGrid = function(element, elementIndex)
  end,
  HomeBattleCenter_Group_Ticket_Group_Quest_ScrollGrid_Quest_Group_taskbar_Group_questRight_Group_btn_Btn_on_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_Quest_ScrollGrid_Quest_Group_taskbar_Group_questRight_Group_btn_Btn_off_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_Quest_ScrollGrid_Quest_Group_taskbar_Group_questRight_Group_btn_Btn_end_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_Quest_ScrollGrid_Quest_Group_taskbar_Img_rewardbottom_ScrollGrid_Quest_Reward_SetGrid = function(element, elementIndex)
  end,
  HomeBattleCenter_Group_Ticket_Group_Quest_ScrollGrid_Quest_Group_taskbar_Img_rewardbottom_ScrollGrid_Quest_Reward_Group_reward_Btn_Item_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TicketProfit_Group_income_Group_progress_Slider_progressBg_Slider = function(slider, value)
  end,
  HomeBattleCenter_Group_Ticket_Group_TicketProfit_Group_income_Group_progress_Slider_progressBg_SliderDown = function(slider)
  end,
  HomeBattleCenter_Group_Ticket_Group_TicketProfit_Group_income_Group_progress_Slider_progressBg_SliderUp = function(slider)
  end,
  HomeBattleCenter_Group_Tab_Btn_Buy_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Tab_Btn_Sell_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_Switch_Group_Single_Btn__Click = function(btn, str)
    DataModel:SetSaleStatus(DataModel.SALE_STATUS.single)
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_Switch_Group_Batch_Btn__Click = function(btn, str)
    DataModel:SetSaleStatus(DataModel.SALE_STATUS.batch)
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local itemFVO = DataModel.saleList[elementIndex]
    element.Group_Select.self:SetActive(itemFVO.isSelected)
    local itemCA = PlayerData:GetFactoryData(itemFVO.id)
    element.Img_:SetSprite(DataModel.StationCA.saleBottomPath)
    element.Group_Item.Img_Item:SetSprite(itemCA.iconPath)
    element.Group_Item.Btn_Item:SetClickParam(itemFVO.id)
    local quality = itemFVO.quality
    element.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality])
    element.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[quality])
    element.Group_Item.Txt_Num:SetText(itemFVO.num)
    element.Txt_Name:SetText(itemCA.name)
    element.Group_Num.Txt_Num:SetText(math.floor(itemCA.rewardList[1].num * itemFVO.priceRate))
    element.Btn_:SetClickParam(elementIndex)
    element.Group_Num.Img_Up:SetActive(DataModel.highRecyclableMap[tostring(itemFVO.id)] == true)
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_ScrollGrid_List_Group_Item_Btn__Click = function(btn, str)
    local index = tonumber(str)
    local itemFVO = DataModel.saleList[index]
    if DataModel.saleStatus == DataModel.SALE_STATUS.single then
      UIManager:Open("UI/Common/StationSaleTips", Json.encode({
        id = itemFVO.id
      }), function()
        DataModel:OpenSalePage(DataModel.SALE_STATUS.single)
        DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.saleSuccessText)
      end)
      return
    end
    local isSelected = not itemFVO.isSelected
    DataModel:SetSaleItemSelected(index, isSelected, true)
    DataModel:RefreshSelectNumAndPrice()
    if not isSelected then
      local groupBottom = View.Group_Sale.Group_Middle.Group_Di
      groupBottom.Group_SelectAll.Group_On.self:SetActive(isSelected)
      local quality = DataModel.saleList[index].quality
      local btn = DataModel:GetSelectBtnByQuality(quality)
      btn:SetActive(isSelected)
    end
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_Di_Btn_Sale_Click = function(btn, str)
    if DataModel.selectedCount <= 0 then
      CommonTips.OpenTips(GetText(80601881))
    else
      local saleList = DataModel.saleList
      local param = ""
      local cost = {}
      local hasRarity = false
      for i = 1, #saleList do
        if saleList[i].isSelected then
          if param ~= "" then
            param = param .. ","
          end
          param = param .. saleList[i].id .. ":" .. saleList[i].num
          cost[saleList[i].id] = saleList[i].num
          if saleList[i].quality > 2 then
            hasRarity = true
          end
        end
      end
      if not hasRarity then
        Net:SendProto("item.recycle_material", function(json)
          CommonTips.OpenShowItem(json.reward, function()
            PlayerData:RefreshUseItems(cost)
            DataModel:OpenSalePage()
            DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.saleSuccessText)
          end)
        end, param)
      else
        CommonTips.OnPrompt("80601994", nil, nil, function()
          Net:SendProto("item.recycle_material", function(json)
            CommonTips.OpenShowItem(json.reward, function()
              PlayerData:RefreshUseItems(cost)
              DataModel:OpenSalePage()
              DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.saleSuccessText)
            end)
          end, param)
        end)
      end
    end
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_Di_Group_SelectAll_Btn__Click = function(btn, str)
    local groupBottom = View.Group_Sale.Group_Middle.Group_Di
    local isSelected = not groupBottom.Group_SelectAll.Group_On.self.IsActive
    DataModel:SetAllSaleItemSelected(isSelected)
    DataModel:RefreshSelectNumAndPrice()
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_Di_Group_SelectSSR_Btn__Click = function(btn, str)
    local groupBottom = View.Group_Sale.Group_Middle.Group_Di
    local isSelected = not groupBottom.Group_SelectSSR.Group_On.self.IsActive
    DataModel:SetSaleItemsSelectedByQuality(4, isSelected)
    DataModel:RefreshSelectNumAndPrice()
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_Di_Group_SelectSR_Btn__Click = function(btn, str)
    local groupBottom = View.Group_Sale.Group_Middle.Group_Di
    local isSelected = not groupBottom.Group_SelectSR.Group_On.self.IsActive
    DataModel:SetSaleItemsSelectedByQuality(3, isSelected)
    DataModel:RefreshSelectNumAndPrice()
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_Di_Group_SelectR_Btn__Click = function(btn, str)
    local groupBottom = View.Group_Sale.Group_Middle.Group_Di
    local isSelected = not groupBottom.Group_SelectR.Group_On.self.IsActive
    DataModel:SetSaleItemsSelectedByQuality(2, isSelected)
    DataModel:RefreshSelectNumAndPrice()
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_Di_Group_SelectN_Btn__Click = function(btn, str)
    local groupBottom = View.Group_Sale.Group_Middle.Group_Di
    local isSelected = not groupBottom.Group_SelectN.Group_On.self.IsActive
    DataModel:SetSaleItemsSelectedByQuality(1, isSelected)
    DataModel:RefreshSelectNumAndPrice()
  end,
  HomeBattleCenter_Group_Sale_Group_Ding_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Sale_Group_Ding_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Exchange_Group_Ding_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Exchange_Group_Ding_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Exchange_Group_Ding_Group_Time_Btn_Tips_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Exchange_Group_Middle_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local itemId = DataModel.itemList[elementIndex].id
    local ca = PlayerData:GetFactoryData(itemId, "CommondityFactory")
    if DataModel.StationCA.exchangeBottomPath ~= nil and DataModel.StationCA.exchangeBottomPath ~= "" then
      element.Img_Di:SetSprite(DataModel.StationCA.exchangeBottomPath)
    end
    element.Img_Icon.self:SetSprite(ca.commodityView)
    element.Img_Icon.Btn_:SetClickParam(ca.commodityItemList[1].id)
    element.Group_Name.Txt_Name:SetText(string.format(GetText(80601981), ca.commodityName, ca.commodityNum))
    local moneyList = ca.moneyList
    local groupItem = element.Group_Item
    for i = 1, 3 do
      local isShow = i <= #moneyList
      local groupConsume = groupItem["Group_Consume" .. i]
      groupConsume.self:SetActive(isShow)
      if isShow then
        local moneyCA = PlayerData:GetFactoryData(moneyList[i].moneyID)
        groupConsume.Group_Item.Img_Item:SetSprite(moneyCA.iconPath or moneyCA.imagePath)
        local quality = moneyCA.qualityInt + 1
        groupConsume.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality])
        groupConsume.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[quality])
        groupConsume.Group_Item.Btn_Item:SetClickParam(moneyCA.id)
        local groupCost = groupConsume.Group_Cost
        local needNum = moneyList[i].moneyNum
        groupCost.Txt_Need.Txt.text = PlayerData:NumToFormatString(needNum, 1)
        local haveNum = PlayerData:GetGoodsById(moneyList[i].moneyID).num
        groupCost.Txt_Have.Txt.text = PlayerData:NumToFormatString(haveNum, 1)
        if needNum > haveNum then
          groupCost.Txt_Have:SetColor(UIConfig.Color.Red)
          if DataModel.notEnoughMap[elementIndex] ~= true then
            DataModel.notEnoughMap[elementIndex] = true
          end
        else
          groupCost.Txt_Have:SetColor(UIConfig.Color.White)
        end
      end
    end
    local isPurchase = ca.purchase
    element.Group_Num.self:SetActive(isPurchase)
    local groupBtn = element.Group_Btn
    if DataModel.StationCA.exchangeAffirmPath ~= nil and DataModel.StationCA.exchangeAffirmPath ~= "" then
      groupBtn.Group_Can.Img_:SetSprite(DataModel.StationCA.exchangeAffirmPath)
    end
    if DataModel.StationCA.exchangeCompletePath ~= nil and DataModel.StationCA.exchangeCompletePath ~= "" then
      groupBtn.Group_Not.Img_:SetSprite(DataModel.StationCA.exchangeCompletePath)
    end
    groupBtn.Group_Can.Btn_:SetClickParam(elementIndex)
    if isPurchase then
      local itemBuyCount = DataModel.itemBuyCount[tonumber(itemId)] or 0
      local remainCount = math.max(0, ca.purchaseNum - itemBuyCount)
      local textIdEnuogh = 80601872
      local textIdUnEnuogh = 80601873
      if ca.limitBuyType == "Forever" then
        textIdEnuogh = 80601872
        textIdUnEnuogh = 80601873
      elseif ca.limitBuyType == "Daily" then
        textIdEnuogh = 80602203
        textIdUnEnuogh = 80602202
      elseif ca.limitBuyType == "Weekly" then
        textIdEnuogh = 80602204
        textIdUnEnuogh = 80602205
      elseif ca.limitBuyType == "Monthly" then
        textIdEnuogh = 80602206
        textIdUnEnuogh = 80602207
      end
      if 0 < remainCount then
        element.Group_Num.Txt_Num:SetText(string.format(GetText(textIdEnuogh), remainCount))
      else
        element.Group_Num.Txt_Num:SetText(GetText(textIdUnEnuogh))
      end
      groupBtn.Group_Can.self:SetActive(0 < remainCount)
      groupBtn.Group_Not.self:SetActive(remainCount <= 0)
      element.Group_Allready.self:SetActive(remainCount <= 0)
    else
      element.Group_Allready.self:SetActive(false)
      groupBtn.Group_Can.self:SetActive(true)
      groupBtn.Group_Not.self:SetActive(false)
    end
    local extraGiveList = ca.extraGiveList
    local groupExtra = element.Group_Extra
    groupExtra.self:SetActive(0 < #extraGiveList)
    if 0 < #extraGiveList then
      groupExtra.Txt_Num:SetText(string.format(GetText(80601880), extraGiveList[1].num))
      groupExtra.Img_Icon:SetSprite(PlayerData:GetFactoryData(extraGiveList[1].id).iconPath)
      groupExtra.Img_Icon.Btn_:SetClickParam(extraGiveList[1].id)
    end
    local isTime = ca.isTime
    local groupTime = element.Group_Time
    groupTime.self:SetActive(isTime)
    if isTime then
      local remainTime = TimeUtil:SecondToTable(TimeUtil:LastTime(ca.endTime))
      groupTime.Txt_Time:SetText(string.format(GetText(80601059), remainTime.day, remainTime.hour))
    end
  end,
  HomeBattleCenter_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Img_Icon_Btn__Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  HomeBattleCenter_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Item_Group_Consume1_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  HomeBattleCenter_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Item_Group_Consume2_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  HomeBattleCenter_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Item_Group_Consume3_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  HomeBattleCenter_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Btn_Group_Can_Btn__Click = function(btn, str)
    if DataModel.notEnoughMap[tonumber(str)] then
      CommonTips.OpenTips(80601871)
      return
    end
    local itemId = DataModel.itemList[tonumber(str)].id
    local ca = PlayerData:GetFactoryData(itemId, "CommondityFactory")
    local remainBuyNum = ca.purchase ~= true and -1 or math.max(0, ca.purchaseNum - (DataModel.itemBuyCount[tonumber(itemId)] or 0))
    UIManager:Open("UI/Common/ExchangeTips", Json.encode({
      commodityId = itemId,
      remainNum = remainBuyNum,
      shopId = DataModel.exchangeStoreCA.id,
      index = DataModel.itemList[tonumber(str)].commodityIndex
    }), function()
      DataModel:OpenStorePage()
      DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.exchangeSuccessText)
    end)
  end,
  HomeBattleCenter_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Btn_Group_Not_Btn__Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Extra_Img_Icon_Btn__Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  HomeBattleCenter_Group_Ticket_Group_TicketProfit_Group_information_Group_circle_Group_tanhao_Btn__Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TicketProfit_Group_information_Group_circle_Group_Tips_Btn_Close_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TicketProfit_Group_information_Group_profit_Group_Incomedata_Group_tanhao_Btn__Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TicketProfit_Group_information_Group_profit_Group_Incomedata_Group_Tips_Btn_Close_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Group_DonateTips_Btn_Close_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Group_NextTips_Btn_Close_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Group_TicketTips_Btn_Close_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_Up_Btn__Click = function(btn, str)
    DataModel:SetUptipsShow(true)
    View.Group_Sale.Group_Middle.Group_Up.Img_RedPoint:SetActive(false)
    PlayerData:SaveHighRecycleClickTime(DataModel.StationCA.id)
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_UpTips_Btn__Click = function(btn, str)
    DataModel:SetUptipsShow(false)
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_UpTips_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local recyclableList = DataModel.recyclableList
    local itemId = recyclableList[elementIndex]
    local itemCA = PlayerData:GetFactoryData(itemId)
    element.Group_Item.Img_Item:SetSprite(itemCA.iconPath)
    element.Group_Item.Btn_Item:SetClickParam(itemId)
    local quality = itemCA.qualityInt + 1
    element.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality])
    element.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[quality])
    element.Group_Item.Btn_Item:SetClickParam(itemId)
  end,
  HomeBattleCenter_Group_Sale_Group_Middle_Group_UpTips_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Group_Quest_Btn_lock_Click = function(btn, str)
    CommonTips.OpenTips(80602067)
  end,
  HomeBattleCenter_Group_Ticket_Group_Investment_Group_progressbar_Group_progress_Img_bottom_Group_award_Btn_CanReceive_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_Investment_Group_progressbar_Group_progress_Img_bottom_Group_award_Btn_Received_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_Investment_Group_progressbar_Group_progress_Img_bottom_Group_award_Btn_CantReceive_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Btn_DonateNum_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Btn_DonateNum_Btn__Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Btn_NextRefressh_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Btn_NextRefressh_Btn__Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Btn_TicketRefressh_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TapBattle_Btn_TicketRefressh_Btn__Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_Quest_Group_progressbar_Group_progress_Img_bottom_Group_award_Btn_CanReceive_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_Quest_Group_progressbar_Group_progress_Img_bottom_Group_award_Btn_Received_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_Quest_Group_progressbar_Group_progress_Img_bottom_Group_award_Btn_CantReceive_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_TicketProfit_Group_information_Group_profit_Group_Incomedata_Group_PriceShow_ScrollGrid_LIst_SetGrid = function(element, elementIndex)
    local maxProfit = DataModel.park.record[DataModel.park.maxProfitMonthIndex]
    local num = DataModel.park.record[elementIndex]
    element.Group_Pillar:SetActive(0 < num)
    element.Group_Without:SetActive(num == 0)
    if 0 < num then
      element.Group_Pillar:SetHeight(200 * num / maxProfit)
    end
    local currentMonth = tonumber(os.date("%m"))
    if elementIndex == table.count(DataModel.park.record) then
      element.Img_Moon.Txt_Moon:SetText("本月")
    else
      local month = currentMonth - (table.count(DataModel.park.record) - elementIndex)
      if month <= 0 then
        month = month + 12
      end
      element.Img_Moon.Txt_Moon:SetText(math.floor(month) .. "月")
    end
    if 1000 <= num and num < 1000000 then
      num = tostring(math.floor(num / 1000)) .. "K"
    elseif 1000000 <= num and num < 1000000000 then
      num = tostring(math.floor(num / 1000000)) .. "M"
    elseif 1000000000 <= num then
      num = tostring(math.floor(num / 1000000000)) .. "G"
    end
    element.Group_Pillar.Txt_Num:SetText(num)
  end,
  HomeBattleCenter_Group_Ticket_Group_Investment_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local pondCfg = PlayerData:GetFactoryData(DataModel.park.pond[elementIndex], "PondFactory")
    local rewardItemCfg, obj
    element.Img_bottom.Btn_inverstment:SetClickParam(elementIndex)
    element.Img_bottom.Img_lock:SetActive(DataModel.park.investmentNum <= 0)
    local tagCfg = PlayerData:GetFactoryData(pondCfg.type, "TagFactory")
    element.Img_bottom.Img_icon:SetSprite(tagCfg.icon)
    element.Img_bottom.Img_level:SetSprite(tagCfg.investIcon)
    element.Img_bottom.Txt_Title:SetText(tagCfg.investName)
    local itemCfg = PlayerData:GetFactoryData(pondCfg.item[1].id, "ItemFactory")
    element.Img_bottom.Txt_content:SetText(string.format("投资%d%s", pondCfg.item[1].num, itemCfg.name))
    element.Img_bottom.Img_resources:SetSprite(itemCfg.iconPath)
    element.Img_bottom.Img_resources.Txt_:SetText(pondCfg.item[1].num)
    for i = 1, element.Img_bottom.Group_tx.transform.childCount do
      element.Img_bottom.Group_tx.transform:GetChild(i - 1).gameObject:SetActive(false)
    end
    for i = 1, element.Img_bottom.Group_tx.transform.childCount do
      local child = element.Img_bottom.Group_tx.transform:GetChild(i - 1)
      if child.name == tagCfg.investEffect then
        child.gameObject:SetActive(true)
        break
      end
    end
    local mode = "UI/HomeBattleCenter/Group_Reward"
    local parent = element.Img_bottom.Group_Reward.Group_RewardList.transform
    for rewardIndex, reward in ipairs(pondCfg.build) do
      obj = DataModel.donateRewardItemObjList[elementIndex] and DataModel.donateRewardItemObjList[elementIndex][rewardIndex]
      if not obj then
        DataModel.donateRewardItemObjList[elementIndex] = DataModel.donateRewardItemObjList[elementIndex] or {}
        obj = View.self:GetRes(mode, parent)
        table.insert(DataModel.donateRewardItemObjList[elementIndex], obj)
      end
      obj.gameObject:SetActive(true)
      rewardItemCfg = PlayerData:GetFactoryData(reward.id, "ItemFactory")
      obj.transform:Find("Img_reward"):GetComponent(typeof(CS.Seven.UIImg)):SetSprite(rewardItemCfg.iconPath)
      obj.transform:Find("Txt_reward"):GetComponent(typeof(CS.Seven.UITxt)):SetText(reward.num .. rewardItemCfg.name)
    end
    local divideStr = tostring(pondCfg.divide * 100)
    element.Img_bottom.Group_Reward.Group_RewardOther.Txt_Divide:SetActive(pondCfg.divide ~= 0)
    element.Img_bottom.Group_Reward.Group_RewardOther.Txt_Divide:SetText("获得" .. ClearFollowZero(pondCfg.divide * 100) .. "%分成提高奖励")
    element.Img_bottom.Group_Reward.Group_RewardOther.Txt_Rate:SetActive(pondCfg.tax ~= 0)
    element.Img_bottom.Group_Reward.Group_RewardOther.Txt_Rate:SetText("获得" .. ClearFollowZero(pondCfg.tax * 100) .. "%税率减少奖励")
    element.Img_bottom.Group_Reward.Group_RewardOther.Txt_Ticket:SetActive(pondCfg.ticket ~= 0)
    element.Img_bottom.Group_Reward.Group_RewardOther.Txt_Ticket:SetText(string.format("获得%d票价提升奖励", pondCfg.ticket))
  end,
  HomeBattleCenter_Group_Ticket_Group_Investment_ScrollGrid_List_Group_pond_Img_bottom_Btn_inverstment_Click = function(btn, str)
    if DataModel.park.investmentNum == 0 then
      CommonTips.OpenTips(80601933)
      return
    end
    local callback = function()
      Net:SendProto("station.donate", function(json)
        local pondCfg = PlayerData:GetFactoryData(DataModel.park.pond[tonumber(str)], "PondFactory")
        DataModel:DonateRefreshParkInfo(pondCfg)
        local constructMax = PlayerData:GetConstructionProportion(DataModel.StationId) >= DataModel.curStage.constructNum
        local ticketMax = DataModel.park.ticket >= DataModel.park.maxTicket
        local taxMax = DataModel.park.tax <= 0
        local divideMax = DataModel.park.divide >= DataModel.StationCA.maxDivide
        local constructNum = pondCfg.build[1] and pondCfg.build[1].num or 0
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_build:SetActive(constructNum ~= 0)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_build.Group_num:SetActive(not constructMax)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_build.Txt_Max:SetActive(constructMax)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_build.Group_num.Txt_Num:SetText(constructNum)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_build.Group_num.Img_UP.transform.localScale = 0 < constructNum and Vector3(1, 1, 1) or Vector3(1, -1, 1)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Divide:SetActive(pondCfg.divide ~= 0)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Divide.Group_num:SetActive(not divideMax)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Divide.Txt_Max:SetActive(divideMax)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Divide.Group_num.Txt_Num:SetText(ClearFollowZero(pondCfg.divide * 100) .. "%")
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Divide.Group_num.Img_UP.transform.localScale = 0 < pondCfg.divide and Vector3(1, 1, 1) or Vector3(1, -1, 1)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Rate:SetActive(pondCfg.tax ~= 0)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Rate.Group_num:SetActive(not taxMax)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Rate.Txt_Max:SetActive(taxMax)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Rate.Group_num.Txt_Num:SetText(ClearFollowZero(pondCfg.tax * 100) .. "%")
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Rate.Group_num.Img_UP.transform.localScale = pondCfg.tax > 0 and Vector3(1, 1, 1) or Vector3(1, -1, 1)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Ticket:SetActive(pondCfg.ticket ~= 0)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Ticket.Group_num:SetActive(not ticketMax)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Ticket.Txt_Max:SetActive(ticketMax)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Ticket.Group_num.Txt_Num:SetText(pondCfg.ticket)
        View.Group_Ticket.Group_StageReward.Group_InvestReward.Group_Up.Group_Ticket.Group_num.Img_UP.transform.localScale = pondCfg.ticket > 0 and Vector3(1, 1, 1) or Vector3(1, -1, 1)
        View.Group_Ticket.Group_StageReward:SetActive(true)
        View.Group_Ticket.Group_StageReward.Group_InvestReward:SetActive(false)
        View.Group_Ticket.Group_StageReward.Group_InvestReward:SetActive(true)
        local sound = SoundManager:CreateSound(30002966)
        sound:Play()
        DataModel:RefreshBySelectType(2)
      end, tonumber(str) - 1)
    end
    local txtId = DataModel.IsInvestTipsShow(DataModel.park.pond[tonumber(str)])
    if 0 < txtId then
      UIManager:Open("UI/HomeBattleCenter/Group_InvestTip", Json.encode({txtId = txtId}), callback)
    else
      callback()
    end
  end,
  HomeBattleCenter_Group_Ticket_Group_StageReward_Group_InvestReward_Btn_Close_Click = function(btn, str)
    View.Group_Ticket.Group_StageReward.Group_InvestReward:SetActive(false)
  end,
  HomeBattleCenter_Group_Ticket_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeBattleCenter_Group_Ticket_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    if View.Group_Ticket.self.IsActive then
      local data = {helpId = 80300282}
      UIManager:Open("UI/Common/Group_Help", Json.encode(data))
    end
  end
}
return ViewFunction
