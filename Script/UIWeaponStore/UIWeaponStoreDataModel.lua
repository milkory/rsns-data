local View = require("UIWeaponStore/UIWeaponStoreView")
local DataModel = {}

function DataModel:Init(isInited)
  self:SetPreviewOpen(true)
  if isInited then
    self:RefreshCommodityList()
  else
    View.Group_Cost.self:SetActive(false)
    View.Group_Right.self:SetActive(false)
    View.Group_Bottom.self:SetActive(false)
    Net:SendProto("shop.info", function(json)
      View.Group_Cost.self:SetActive(true)
      View.Group_Right.self:SetActive(true)
      View.Group_Bottom.self:SetActive(true)
      self:RefreshCommodityList()
    end, DataModel.StoreCA.id)
  end
  View.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetUserInfo().gold or 0)
  View.Group_Name.Txt_Name:SetText(DataModel.StoreCA.storeName)
end

function DataModel:RefreshCommodityList()
  local serverItems = PlayerData.ServerData.shops[tostring(DataModel.StoreCA.id)].items
  local itemBuyCount = {}
  for k, v in pairs(serverItems) do
    itemBuyCount[tonumber(v.id)] = v.py_cnt
  end
  DataModel.itemBuyCount = itemBuyCount
  View.Group_Cost.ScrollGrid_Sale.grid.self:SetDataCount(#DataModel.StoreCA.shopList)
  DataModel.ItemIndex = nil
  self:OnSelectItem(1)
end

function DataModel:OnClickBtnPreview()
  self:SetPreviewOpen(not DataModel.isPreviewOpen)
  self:RefreshCommondityInfo()
end

function DataModel:SetPreviewOpen(isOpen)
  DataModel.isPreviewOpen = isOpen
  View.Group_Right.Btn_Button.Img_OFF:SetActive(not isOpen)
  View.Group_Right.Btn_Button.Img_ON:SetActive(isOpen)
end

function DataModel:OnSelectItem(index)
  if index == DataModel.ItemIndex then
    return
  end
  DataModel.ItemIndex = index
  View.Group_Cost.ScrollGrid_Sale.grid.self:RefreshAllElement()
  self:RefreshCostList()
  self:RefreshCommondityInfo()
end

function DataModel:OnCommodityListSetGrid(element, elementIndex)
  local commodityId = DataModel.StoreCA.shopList[elementIndex].id
  local commodityCA = PlayerData:GetFactoryData(commodityId)
  if commodityCA.purchase then
    local isSelected = elementIndex == DataModel.ItemIndex
    element.Group_On.self:SetActive(isSelected)
    element.Group_Off.self:SetActive(not isSelected)
    local groupSelected
    if isSelected then
      groupSelected = element.Group_On
    else
      groupSelected = element.Group_Off
    end
    local purchaseNum = commodityCA.purchaseNum
    local buyNum = DataModel.itemBuyCount[commodityId] or 0
    if purchaseNum > buyNum then
      groupSelected.Group_Residue.Txt_Num:SetText(string.format(GetText(80601235), purchaseNum - buyNum, purchaseNum))
      if isSelected then
        View.Group_Bottom.Group_Btn.Group_AlreadyGet.self:SetActive(false)
      end
    else
      groupSelected.Group_Residue.Txt_Num:SetText(string.format(GetText(80602327), purchaseNum))
      if isSelected then
        View.Group_Bottom.Group_Btn.Group_AlreadyGet.self:SetActive(true)
      end
    end
  else
    element.Group_On.self:SetActive(false)
    element.Group_Off.self:SetActive(false)
  end
  element.Group_Item.Img_Item:SetSprite(commodityCA.commodityView)
  local quality = commodityCA.qualityInt + 1
  element.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality])
  element.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[quality])
  element.Group_Item.Btn_Item:SetClickParam(elementIndex)
end

function DataModel:RefreshCostList()
  DataModel.isEnough = true
  local commodityId = DataModel.StoreCA.shopList[DataModel.ItemIndex].id
  local commodityCA = PlayerData:GetFactoryData(commodityId)
  View.Group_Bottom.ScrollGrid_Cost.grid.self:SetDataCount(#commodityCA.moneyList)
  View.Group_Bottom.ScrollGrid_Cost.grid.self:RefreshAllElement()
end

function DataModel:OnCostListSetGrid(element, elementIndex)
  local commodityId = DataModel.StoreCA.shopList[DataModel.ItemIndex].id
  local commodityCA = PlayerData:GetFactoryData(commodityId)
  local costId = commodityCA.moneyList[elementIndex].moneyID
  local costNum = commodityCA.moneyList[elementIndex].moneyNum
  element.Group_Num.Txt_Num2:SetText(PlayerData:NumToFormatString(costNum, 1))
  local hasNum = PlayerData:GetGoodsById(costId).num
  element.Group_Num.Txt_Num1:SetText(PlayerData:NumToFormatString(hasNum, 1))
  if costNum > hasNum then
    DataModel.isEnough = false
    element.Group_Num.Txt_Num1:SetColor("#FF0000")
  else
    element.Group_Num.Txt_Num1:SetColor("#FFFFFF")
  end
  local costCA = PlayerData:GetFactoryData(costId)
  element.Group_Item.Img_Item:SetSprite(costCA.iconPath or costCA.imagePath)
  local quality = costCA.qualityInt + 1
  element.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality])
  element.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[quality])
  element.Group_Item.Btn_Item:SetClickParam(elementIndex)
end

function DataModel:OnClickCostItem(str)
  if str == nil then
    return
  end
  local commodityId = DataModel.StoreCA.shopList[DataModel.ItemIndex].id
  local commodityCA = PlayerData:GetFactoryData(commodityId)
  local costId = commodityCA.moneyList[tonumber(str)].moneyID
  CommonTips.OpenPreRewardDetailTips(costId, nil, true)
end

function DataModel:RefreshCommondityInfo()
  local commodityId = DataModel.StoreCA.shopList[DataModel.ItemIndex].id
  local commodityCA = PlayerData:GetFactoryData(commodityId)
  View.Group_Centre.Txt_Name:SetText(commodityCA.commodityName)
  View.Group_Centre.Img_Icon:SetSprite(commodityCA.commodityView)
  View.Group_Centre.Group_Quality.Img_Quality:SetSprite(UIConfig.WeaponQuality[commodityCA.qualityInt + 1])
  local itemId = commodityCA.commodityItemList[1].id
  local isWeapon = DataManager:GetFactoryNameById(tonumber(itemId)) == "HomeWeaponFactory"
  local weaponCA = PlayerData:GetFactoryData(itemId, "HomeWeaponFactory")
  if isWeapon and weaponCA ~= nil then
    View.Group_Right.self:SetActive(true)
    local weaponTypeCA = PlayerData:GetFactoryData(weaponCA.typeWeapon)
    View.Group_Right.Img_Icon:SetSprite(weaponTypeCA.icon)
    View.Group_Right.Txt_Title:SetText(weaponTypeCA.tagName)
    local content = View.Group_Right.ScrollView_Entry.Viewport.Content
    local tagList = weaponCA.hitEventType
    if tagList ~= nil and 0 < #tagList then
      content.Group_MonsterType.self:SetActive(true)
      for i = 1, #tagList do
        local group = content.Group_MonsterType.Group_Type["Group_Type" .. i]
        if group ~= nil then
          local tagCA = PlayerData:GetFactoryData(tagList[i].id)
          group:SetActive(true)
          group.Img_Type.Img_Icon:SetSprite(tagCA.icon)
          group.Img_Type.Txt_Name:SetText(tagCA.tagName)
        end
      end
      for i = #tagList + 1, content.Group_MonsterType.Group_Type.self.transform.childCount do
        content.Group_MonsterType.Group_Type["Group_Type" .. i]:SetActive(false)
      end
    else
      content.Group_MonsterType.self:SetActive(false)
    end
    local normalEntryList = weaponCA.normalEntryList
    if normalEntryList ~= nil and 0 < #normalEntryList then
      content.Group_BaseTitle.self:SetActive(true)
      for i = 1, #normalEntryList do
        local group = content.Group_BaseTitle.Group_BaseEntry["Group_BaseEntry" .. i]
        if group then
          group:SetActive(true)
          local entryCA = PlayerData:GetFactoryData(normalEntryList[i].id)
          local entryTag = PlayerData:GetFactoryData(entryCA.entryTag)
          group.Img_Icon:SetSprite(entryTag.icon)
          group.Txt_Entry:SetText(entryTag.entryName)
          local constantStr
          local constant = PlayerData:GetPreciseDecimalFloor(entryCA.Constant, 2)
          if entryCA.numText ~= nil and 0 < entryCA.numText then
            constantStr = string.format(GetText(entryCA.numText), constant)
          else
            constantStr = constant
          end
          group.Img_Num.Txt_Num:SetText(constantStr)
        end
      end
      for i = #normalEntryList + 1, content.Group_BaseTitle.Group_BaseEntry.self.transform.childCount do
        content.Group_BaseTitle.Group_BaseEntry["Group_BaseEntry" .. i]:SetActive(false)
      end
    else
      content.Group_BaseTitle.self:SetActive(false)
    end
    local growUpEntryList = weaponCA.growUpEntryList
    if growUpEntryList ~= nil and 0 < #growUpEntryList then
      content.Group_SpecialTitle:SetActive(true)
      for i = 1, #growUpEntryList do
        local group = content.Group_SpecialTitle.Group_SpecialEntry["Group_SpecialEntry" .. i]
        if group then
          group:SetActive(true)
          local entryCA = PlayerData:GetFactoryData(growUpEntryList[i].id)
          local desStr = entryCA.text
          local paramA
          if entryCA.aTypeInt == 1 then
            if entryCA.aDevelopment and DataModel.isPreviewOpen then
              paramA = entryCA.aNumMaxP * entryCA.aCommonNumP
            else
              paramA = entryCA.aNumMinP * entryCA.aCommonNumP
            end
          elseif entryCA.aDevelopment and DataModel.isPreviewOpen then
            paramA = entryCA.aNumMax * entryCA.aCommonNum
          else
            paramA = entryCA.aNumMin * entryCA.aCommonNum
          end
          local paramB
          if entryCA.bTypeInt == 1 then
            if entryCA.bDevelopment and DataModel.isPreviewOpen then
              paramB = entryCA.bNumMaxP * entryCA.bCommonNumP
            else
              paramB = entryCA.bNumMinP * entryCA.bCommonNumP
            end
          elseif entryCA.bDevelopment and DataModel.isPreviewOpen then
            paramB = entryCA.bNumMax * entryCA.bCommonNum
          else
            paramB = entryCA.bNumMin * entryCA.bCommonNum
          end
          local txtFormat = GetText(80603024)
          local desStr = string.format(desStr, PlayerData:GetPreciseDecimalFloor(paramA, 2), PlayerData:GetPreciseDecimalFloor(paramB, 2))
          group.Txt_Entry:SetText(string.format(txtFormat, entryCA.name, desStr))
        end
      end
      for i = #growUpEntryList + 1, content.Group_SpecialTitle.Group_SpecialEntry.self.transform.childCount do
        content.Group_SpecialTitle.Group_SpecialEntry["Group_SpecialEntry" .. i]:SetActive(false)
      end
    else
      content.Group_SpecialTitle:SetActive(false)
    end
    if weaponCA.des ~= nil and weaponCA.des ~= "" then
      content.Group_Des:SetActive(true)
      content.Group_Des.Txt_Des:SetText(weaponCA.des)
    else
      content.Group_Des:SetActive(false)
    end
  else
    View.Group_Right.self:SetActive(false)
  end
end

function DataModel:OnClickExchange()
  local commodityId = DataModel.StoreCA.shopList[DataModel.ItemIndex].id
  local ca = PlayerData:GetFactoryData(commodityId, "CommondityFactory")
  if ca.purchase and ca.purchaseNum <= (DataModel.itemBuyCount[commodityId] or 0) then
    return
  end
  if not DataModel.isEnough then
    CommonTips.OpenTips(80602326)
    return
  end
  local remainBuyNum = ca.purchase ~= true and -1 or math.max(0, ca.purchaseNum - (DataModel.itemBuyCount[tonumber(commodityId)] or 0))
  UIManager:Open("UI/Common/ExchangeTips", Json.encode({
    commodityId = commodityId,
    remainNum = remainBuyNum,
    shopId = DataModel.StoreId,
    index = DataModel.ItemIndex
  }), function()
    self:RefreshCostList()
    self:RefreshCommodityList()
  end)
end

return DataModel
