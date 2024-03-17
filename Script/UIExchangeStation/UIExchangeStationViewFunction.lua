local View = require("UIExchangeStation/UIExchangeStationView")
local DataModel = require("UIExchangeStation/UIExchangeStationDataModel")
local ViewFunction = {
  ExchangeStation_Group_Zhu_Group_Construct_Btn_Construct_Click = function(btn, str)
    DataModel:OpenConstructStage()
  end,
  ExchangeStation_Group_Tab_Btn_Buy_Click = function(btn, str)
  end,
  ExchangeStation_Group_Tab_Btn_Sell_Click = function(btn, str)
  end,
  ExchangeStation_Group_Exchange_Group_Ding_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  ExchangeStation_Group_Exchange_Group_Ding_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  ExchangeStation_Group_Exchange_Group_Ding_Group_Time_Btn_Tips_Click = function(btn, str)
  end,
  ExchangeStation_Group_Exchange_Group_Middle_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local itemId = DataModel.itemList[elementIndex].id
    local ca = PlayerData:GetFactoryData(itemId, "CommondityFactory")
    if DataModel.BuildCA.bottomPath ~= nil and DataModel.BuildCA.bottomPath ~= "" then
      element.Img_Di:SetSprite(DataModel.BuildCA.bottomPath)
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
        groupBtn.Group_Can.Img_:SetSprite(DataModel.BuildCA.exchangeAffirmPath)
      else
        element.Group_Num.Txt_Num:SetText(GetText(textIdUnEnuogh))
        groupBtn.Group_Not.Img_:SetSprite(DataModel.BuildCA.exchangeCompletePath)
      end
      groupBtn.Group_Can.self:SetActive(0 < remainCount)
      groupBtn.Group_Not.self:SetActive(remainCount <= 0)
      element.Group_Allready.self:SetActive(remainCount <= 0)
    else
      element.Group_Allready.self:SetActive(false)
      groupBtn.Group_Can.self:SetActive(true)
      groupBtn.Group_Not.self:SetActive(false)
      groupBtn.Group_Can.Img_:SetSprite(DataModel.BuildCA.exchangeAffirmPath)
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
  ExchangeStation_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Img_Icon_Btn__Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  ExchangeStation_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Item_Group_Consume1_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  ExchangeStation_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Item_Group_Consume2_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  ExchangeStation_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Item_Group_Consume3_Group_Item_Btn_Item_Click = function(btn, str)
    if str == nil then
      return
    end
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  ExchangeStation_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Btn_Group_Can_Btn__Click = function(btn, str)
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
  ExchangeStation_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Btn_Group_Not_Btn__Click = function(btn, str)
  end,
  ExchangeStation_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Extra_Img_Icon_Btn__Click = function(btn, str)
  end,
  ExchangeStation_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.Group_Zhu.self:SetActive(false)
    if View.Group_Exchange.self.IsActive then
      View.Group_Exchange.self:SetActive(false)
      View.Group_Main.self:SetActive(true)
      if DataModel.InitMode == nil then
        View.self:PlayAnim("Main")
        return
      end
    end
    UIManager:GoBack()
  end,
  ExchangeStation_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  ExchangeStation_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ExchangeStation_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    UIManager:Open("UI/Common/Group_Help", Json.encode({
      helpId = DataModel.HelpId
    }))
  end,
  ExchangeStation_Group_Main_Group_Btn_Btn_List_Click = function(btn, str)
  end,
  ExchangeStation_Group_Main_StaticGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.BuildCA.exchangeOpenPageList[tonumber(elementIndex)]
    element.Btn_List:SetClickParam(elementIndex)
    element.Btn_List.Txt_Dec:SetText(row.name)
    element.Btn_List.Img_Icon:SetSprite(row.icon)
    if row.isStore == true then
      local isStoreOpen = false
      local storeRemainTime
      local storeList = DataModel.BuildCA.exchangeStoreList
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
    if row.uiPath ~= nil and row.uiPath ~= "" then
      DataModel:RefreshWeaponStore()
    end
  end,
  ExchangeStation_Group_Main_StaticGrid_List_Group_Btn_Btn_List_Click = function(btn, str)
    local row = DataModel.BuildCA.exchangeOpenPageList[tonumber(str)]
    if row.isTalk == true then
      DataModel:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
      return
    end
    if row.showUI == "Group_Exchange" then
      DataModel:OpenStorePage()
    end
    if row.uiPath ~= nil and row.uiPath ~= "" then
      DataModel:OpenWeaponStore(row.uiPath)
    end
  end,
  ExchangeStation_Group_Zhu_Group_Reputation_Btn_Reputation_Click = function(btn, str)
    local HomeCommon = require("Common/HomeCommon")
    HomeCommon.ClickReputationBtn(DataModel.StationId, nil, nil, function()
      HomeCommon.SetReputationElement(View.Group_Zhu.Group_Reputation, DataModel.StationId)
    end)
  end
}
return ViewFunction
