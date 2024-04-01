local View = require("UIEnergy/UIEnergyView")
local DataModel = require("UIEnergy/UIEnergyDataModel")
local GetItemExInfo = function(itemType)
  local isSimlator = false
  if itemType == 1 then
    isSimlator = true
    local des = PlayerData:GetFactoryData(80600497).text
    local getEnergyNum = DataModel.sutaminaBox_getEnergyNum
    local content = string.format(des, getEnergyNum)
    return content, isSimlator
  else
    local des = PlayerData:GetFactoryData(80600496).text
    local needNum = DataModel.rock_NeedNum
    local getEnergyNum = DataModel.rock_GetEnergyNum
    local remainCount = DataModel.rock_RemainNum
    local content = string.format(des, needNum, getEnergyNum, remainCount)
    return content, isSimlator
  end
end
local GetOwerNum = function(itemType)
  if itemType == 1 then
    local isShow, textId, owerNumcontet
    if 1 <= DataModel.owner_SutaminaBoxNum then
      isShow = false
      textId = 80600449
    else
      isShow = true
      textId = 80600499
    end
    owerNumcontet = PlayerData:GetFactoryData(textId).text
    local content = string.format(owerNumcontet, DataModel.owner_SutaminaBoxNum)
    return content, isShow
  else
    local textId = DataModel.bm_rockNum >= DataModel.rock_NeedNum and 80600498 or 80600450
    local owerNumcontet = PlayerData:GetFactoryData(textId).text
    local content = string.format(owerNumcontet, DataModel.bm_rockNum)
    return content
  end
end
local UpdateExInfo = function()
  local exchangeNum = DataModel.buyType == 1 and DataModel.sutaminaBox_getEnergyNum or DataModel.rock_GetEnergyNum
  View.Group_Page2.Group_Change.Txt_BeforeNum:SetText(PlayerData.ServerData.user_info.energy)
  View.Group_Page2.Group_Change.Txt_AfterNum:SetText(PlayerData.ServerData.user_info.energy + exchangeNum * DataModel.selectNum)
  View.Group_Page2.Group_Num.Group_Slider.Group_Num.Txt_Select:SetText(DataModel.selectNum)
  View.Group_Page2.Group_Num.Group_Slider.Group_Num.Txt_Possess:SetText(DataModel.maxNum)
end
local EnterExchangePanel = function()
  local quality, iconPath
  if DataModel.buyType == 1 then
    quality = DataModel.qualityId1
    iconPath = DataModel.iconPath1
  else
    quality = DataModel.qualityId2
    iconPath = DataModel.iconPath2
  end
  View.Group_Page2.Group_Num.self:SetActive(DataModel.buyType == 1)
  DataModel:GetMaxNum()
  local exInfocontet, IsSimlator = GetItemExInfo(DataModel.buyType)
  local holdContent = GetOwerNum(DataModel.buyType)
  View.Group_Page2.Img_Num.Txt_Num:SetText(holdContent)
  View.Group_Page2.Group_Des.Txt_TitleItem:SetActive(IsSimlator)
  View.Group_Page2.Group_Des.Txt_TitleItem:SetText(DataModel.sutaminaBox_name)
  View.Group_Page2.Group_Des.Txt_TitleMoney:SetActive(not IsSimlator)
  View.Group_Page2.Group_Tip:SetActive(not IsSimlator)
  View.Group_Page2.Group_Des.Txt_Des:SetText(exInfocontet)
  View.Group_Page2.Group_Des.Group_ItemEnergy.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality])
  View.Group_Page2.Group_Des.Group_ItemEnergy.Img_Mask:SetSprite(UIConfig.MaskConfig[quality])
  View.Group_Page2.Group_Des.Group_ItemEnergy.Img_Item:SetSprite(iconPath)
  local sliderValue = 1
  if DataModel.maxNum == 1 then
    sliderValue = 1
  else
    sliderValue = DataModel.maxNum == 0 and 0 or (DataModel.selectNum - 1) / (DataModel.maxNum - 1)
  end
  View.Group_Page2.Group_Num.Group_Slider.Slider_Value:SetSliderValue(sliderValue)
  View.Group_Page2.Group_Num.Group_Slider.Slider_Value.slider.interactable = 1 < DataModel.maxNum
  UpdateExInfo()
end
local SwitchPanel = function(panelType)
  local isShow = false
  if panelType == 1 then
    isShow = true
  else
    DataModel:UpdateSelectNum(1)
    EnterExchangePanel()
  end
  View.Group_Page2:SetActive(not isShow)
end
local RefreshSelectPanel = function(selectType)
  DataModel.buyType = selectType
  View.Group_PickEnergyWay.StaticGrid_.self:RefreshAllElement()
  local energy_content = string.format("%d/%d", PlayerData:GetUserInfo().energy, PlayerData:GetUserInfo().max_energy)
  View.Group_PickEnergyWay.Group_Energy.Txt_Energy:SetText(energy_content)
  View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG1.Txt_Num:SetText(energy_content)
  local effect_indx, cfg = DataModel.GetBgStatusImgPath()
  View.Group_PickEnergyWay.Group_effect_low:SetActive(effect_indx == 1)
  View.Group_PickEnergyWay.Group_effect_middle:SetActive(effect_indx == 2)
  View.Group_PickEnergyWay.Group_effect_high:SetActive(effect_indx == 3)
  View.Group_PickEnergyWay.Img_BG:SetSprite(cfg.bg)
  View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG1:SetEnableAnimator(effect_indx == 1)
  View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG1.Txt_Num:SetActive(true)
  View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG1:SetSprite(cfg.display)
  View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG1.Group_Mask.Txt_Scroll:SetText(GetText(cfg.scroll))
  View.Group_PickEnergyWay.Btn_Medal.Txt_Num:SetText(PlayerData:GetUserInfo().bm_rock)
  DataModel.scroll_content_width = View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG1.Group_Mask.Txt_Scroll:GetWidth()
  View.Group_PickEnergyWay.Img_Machine.Group_Display.Img_BG1.Group_Mask.Txt_Scroll:SetWidth()
end
local ViewFunction = {
  Energy_Group_Page2_Group_Num_Btn_Min_Click = function(btn, str)
    if DataModel.maxNum > 1 then
      View.Group_Page2.Group_Num.Group_Slider.Slider_Value:SetSliderValue(0)
      if DataModel.maxNum > 1 then
        DataModel.selectNum = DataModel.maxNum == 0 and 0 or 1
        UpdateExInfo()
      end
    end
  end,
  Energy_Group_Page2_Group_Num_Btn_Dec_Click = function(btn, str)
    if DataModel.maxNum > 1 then
      DataModel:UpdateSelectNum(2)
      local temp = DataModel.selectNum
      View.Group_Page2.Group_Num.Group_Slider.Slider_Value:SetSliderValue(DataModel.maxNum == 0 and 0 or (DataModel.selectNum - 1) / (DataModel.maxNum - 1))
      DataModel.selectNum = temp
      UpdateExInfo()
    end
  end,
  Energy_Group_Page2_Group_Num_Group_Slider_Slider_Value_Slider = function(slider, value)
    local selectnum = DataModel.maxNum > 0 and value * (DataModel.maxNum - 1) + 1 or 0
    DataModel.selectNum = math.floor(selectnum)
    if DataModel.maxNum >= 1 and DataModel.selectNum == 0 then
      DataModel.selectNum = 1
    end
    UpdateExInfo()
  end,
  Energy_Group_Page2_Group_Num_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  Energy_Group_Page2_Group_Num_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  Energy_Group_Page2_Group_Num_Btn_Add_Click = function(btn, str)
    if DataModel.maxNum > 1 then
      DataModel:UpdateSelectNum(3)
      local temp = DataModel.selectNum
      View.Group_Page2.Group_Num.Group_Slider.Slider_Value:SetSliderValue(DataModel.maxNum == 0 and 0 or (DataModel.selectNum - 1) / (DataModel.maxNum - 1))
      DataModel.selectNum = temp
      UpdateExInfo()
    end
  end,
  Energy_Group_Page2_Group_Num_Btn_Max_Click = function(btn, str)
    if DataModel.maxNum > 1 then
      DataModel.selectNum = DataModel:GetMaxNum()
      View.Group_Page2.Group_Num.Group_Slider.Slider_Value:SetSliderValue(1)
      UpdateExInfo()
    end
  end,
  Energy_Group_Page2_Btn_Cancel_Click = function(btn, str)
    SwitchPanel(1)
  end,
  Energy_Group_Page2_Btn_Sale_Click = function(btn, str)
    local itemid = DataModel.buyType == 1 and DataModel.energyId or nil
    local num = DataModel.selectNum
    if num == 0 then
      local textId = 80600010
      if DataModel.buyType == 2 and PlayerData.ServerData.user_info.buy_energy_cnt >= DataModel.energyAddMax then
        textId = 80600467
      end
      local context = PlayerData:GetFactoryData(textId, "TextFactory").text
      CommonTips.OpenTips(context)
    else
      local firstParam, secondParam, thirdParam, fourthParam, protocolName
      local usedUid = {}
      if itemid ~= nil then
        protocolName = "item.use_items"
        firstParam = itemid
        secondParam = num
        local itemCA = PlayerData:GetFactoryData(itemid)
        if itemCA.limitedTime and 0 < itemCA.limitedTime then
          secondParam = nil
          limitedUsed = true
          local curTime = TimeUtil:GetServerTimeStamp()
          local limitItems = DataModel.GetLimitTimeItem(itemid)
          if curTime >= limitItems[1].dead_line then
            View.Group_PickEnergyWay.StaticGrid_.self:RefreshAllElement()
            View.Group_Page2:SetActive(false)
            CommonTips.OpenTips(80600045)
            return
          end
          firstParam = limitItems[1].uid
          usedUid[1] = limitItems[1].uid
          for i = 2, num do
            firstParam = firstParam .. "," .. limitItems[i].uid
            usedUid[i] = limitItems[i].uid
          end
          fourthParam = 1
        end
      else
        protocolName = "main.add_energy"
        firstParam = num
      end
      Net:SendProto(protocolName, function(json)
        if DataModel.buyType == 1 then
          if next(usedUid) ~= nil then
            for k, v in pairs(usedUid) do
              PlayerData:GetLimitedItems()[v] = nil
            end
          else
            PlayerData:GetGoodsById(DataModel.energyId).num = PlayerData:GetGoodsById(DataModel.energyId).num - DataModel.selectNum
          end
        else
          SdkReporter.TrackUseDiamond({
            amount = DataModel.rock_NeedNum,
            reason = "stamina"
          })
          PlayerData.ServerData.user_info.buy_energy_cnt = PlayerData.ServerData.user_info.buy_energy_cnt + DataModel.selectNum
        end
        UIManager:GoBack(true, 1)
        local content = PlayerData:GetFactoryData(80600525, "TextFactory").text
        local oneNum = DataModel.buyType == 1 and DataModel.sutaminaBox_getEnergyNum or DataModel.rock_GetEnergyNum
        CommonTips.OpenTips(string.format(content, oneNum * num))
        View.self:Confirm()
      end, firstParam, secondParam, thirdParam, fourthParam)
    end
  end,
  Energy_Group_PickEnergyWay_Group_EnergyItem_Img_Mask_Btn_Access_Click = function(btn, str)
  end,
  Energy_Group_PickEnergyWay_Group_EnergyItem_Btn__Click = function(btn, str)
  end,
  Energy_Group_PickEnergyWay_Btn_Medal_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Energy_Group_PickEnergyWay_Btn_Medal_Btn_Add_Click = function(btn, str)
  end,
  Energy_Group_PickEnergyWay_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack(true, 1)
    View.self:Cancel()
  end,
  Energy_Group_PickEnergyWay_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  Energy_Group_PickEnergyWay_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Energy_Group_PickEnergyWay_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Energy_Group_PickEnergyWay_StaticGrid__SetGrid = function(element, elementIndex)
    local cfg = PlayerData:GetFactoryData(DataModel.item_list[elementIndex].id)
    if cfg.id == 11400005 then
      element.Img_TimeLeft:SetActive(false)
      element.Group_Diamond.Img_:SetSprite(cfg.iconPath)
      element.Group_Diamond.Txt_Name:SetText(cfg.name)
      element.Group_Energy.Txt_EnergyNum:SetText(string.format(GetText(80601816), DataModel.rock_GetEnergyNum))
      element.Img_Limited:SetActive(true)
      element.Img_Limited.Txt_Limited:SetText(string.format(GetText(80601878), DataModel.rock_RemainNum, DataModel.energyAddMax))
    else
      element.Img_Limited:SetActive(false)
      element.Img_TimeLeft:SetActive(false)
      local item_cnt = PlayerData:GetGoodsById(cfg.id).num or 0
      if 0 < item_cnt then
        element.Group_Item.Img_BGItemNo:SetActive(false)
        element.Group_Item.Img_BGItem:SetActive(true)
        element.Img_Mask:SetActive(false)
        element.Btn_:SetActive(true)
        element.Group_Item.Img_BGItem.Img_BGNum.Txt_HoldNum:SetText(item_cnt)
        local itemCA = PlayerData:GetFactoryData(cfg.id)
        if itemCA.limitedTime and 0 < itemCA.limitedTime then
          local item = DataModel.GetLastLimitTimeItem(cfg.id)
          element.Img_TimeLeft:SetActive(true)
          local curTime = TimeUtil:GetServerTimeStamp()
          local remainTime = item.dead_line - curTime
          element.Img_TimeLeft.Txt_Timeleft:SetText(string.format(GetText(80601877), math.ceil(remainTime / 86400)))
        end
      else
        element.Group_Item.Img_BGItemNo:SetActive(true)
        element.Group_Item.Img_BGItem:SetActive(false)
        element.Img_Mask:SetActive(true)
        element.Btn_:SetActive(false)
        element.Img_Mask.Btn_Access:SetClickParam(cfg.id)
      end
      element.Group_Item.Img_Item:SetSprite(cfg.iconPath)
      element.Group_Item.Txt_Name:SetText(cfg.name)
      element.Group_Energy.Txt_EnergyNum:SetText(string.format(GetText(80601816), cfg.exchangeList[1].num))
    end
    element.Btn_:SetClickParam(cfg.id)
  end,
  Energy_Group_PickEnergyWay_StaticGrid__Group_EnergyItem_Img_Mask_Btn_Access_Click = function(btn, str)
    DataModel.isClickAccess = true
    local data = {}
    data.itemID = tonumber(str)
    data.posX = 225
    data.posY = 42
    if data.itemID == 11400067 then
      data.posX = -658
    elseif data.itemID == 11400014 then
      data.posX = -195
    elseif data.itemID == 11400068 then
      data.posX = 225
    end
    data.goback_num = 1
    UIManager:Open("UI/Common/Group_GetWay", Json.encode(data))
  end,
  Energy_Group_PickEnergyWay_StaticGrid__Group_EnergyItem_Btn__Click = function(btn, str)
    DataModel.buyType = str == "11400005" and 2 or 1
    if DataModel.buyType == 1 then
      DataModel.RefreshSutaminaBox(tonumber(str))
    end
    local num = DataModel:GetMaxNum()
    if num == 0 then
      local textId = 80600010
      if DataModel.buyType == 2 then
        if PlayerData.ServerData.user_info.buy_energy_cnt >= DataModel.energyAddMax then
          textId = 80600467
        else
          local callback = function()
            CommonTips.OpenStoreBuy()
          end
          CommonTips.OnPrompt(80600147, GetText(80600068), GetText(80600067), callback)
          return
        end
      end
      local context = PlayerData:GetFactoryData(textId, "TextFactory").text
      CommonTips.OpenTips(context)
    else
      SwitchPanel(2)
    end
  end,
  RefreshSelectPanel = RefreshSelectPanel,
  Energy_Btn_BG_Click = function(btn, str)
  end
}
return ViewFunction
