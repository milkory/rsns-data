local View = require("UIDressStore/UIDressStoreView")
local DataModel = require("UIDressStore/UIDressStoreDataModel")
local ViewFunction = {
  DressStore_Group_RightPanel_Group_Top_ScrollGrid_SkinType_SetGrid = function(element, elementIndex)
    local skinType = DataModel.shopItemTypes[elementIndex]
    DataModel.skinTypeElements[skinType] = element
    local skinTypeCA = PlayerData:GetFactoryData(skinType, "TagFactory")
    element.Txt_:SetText(skinTypeCA.name)
    element.Img_Icon:SetSprite(skinTypeCA.unSelectIconPathDS)
    element.Img_Picked:SetActive(DataModel.curSelectShopItemType == skinType)
    element.Img_Picked.Img_IconPicked:SetSprite(skinTypeCA.selectIconPathDS)
    element.Img_Picked.Txt_:SetText(skinTypeCA.name)
    element.Btn_:SetClickParam(skinType)
  end,
  DressStore_Group_RightPanel_Group_Top_ScrollGrid_SkinType_Group_Item_Btn__Click = function(btn, str)
    if DataModel.curSelectShopItemType and DataModel.curSelectShopItemType == tonumber(str) then
      return
    end
    if DataModel.curSelectShopItemType then
      local oldSkinTypeCA = PlayerData:GetFactoryData(DataModel.curSelectShopItemType, "TagFactory")
      local oldElement = DataModel.skinTypeElements[DataModel.curSelectShopItemType]
      if oldElement then
        oldElement.Img_Picked:SetActive(false)
      end
    end
    local curElement = DataModel.skinTypeElements[tonumber(str)]
    curElement.Img_Picked:SetActive(true)
    DataModel.SetCurSkinListByType(tonumber(str))
  end,
  DressStore_Group_RightPanel_Group_Middle_ScrollGrid_Skin_SetGrid = function(element, elementIndex)
    local item = DataModel.curTypeShopItems[elementIndex]
    local skinId = item.itemId
    local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
    local commodityCA
    if item.commodityId and item.commodityId > 0 then
      commodityCA = PlayerData:GetFactoryData(item.commodityId, "CommodityFactory")
    end
    local have = item.skinUid ~= nil
    local select = DataModel.IsSkinSelect(skinId)
    element.Img_Picked:SetActive(select)
    element.Txt_Name:SetText(skinCA.name)
    element.Img_Skin:SetSprite(commodityCA and commodityCA.commodityView or skinCA.iconPath)
    element.Img_Owned:SetActive(have)
    element.Img_BgMoney:SetActive(not have)
    if not have and commodityCA then
      local costConfig = commodityCA.moneyList[1]
      if costConfig then
        local costNum = costConfig.moneyNum
        local costItemCA = PlayerData:GetFactoryData(costConfig.moneyID, "ItemFactory")
        element.Img_BgMoney.Group_Money.Group_Money.Img_Money:SetSprite(costItemCA.buyPath)
        element.Img_BgMoney.Group_Money.Txt_MoneyNum:SetText(costNum)
      end
    end
    DataModel.skinElements[skinId] = element
    element.Btn_Dress:SetClickParam(elementIndex)
    element.Btn_Buy:SetClickParam(elementIndex)
    element.Btn_Info:SetClickParam(skinId)
  end,
  DressStore_Group_RightPanel_Group_Middle_ScrollGrid_Skin_Group_Item_Btn_Info_Click = function(btn, str)
    CommonTips.OpenDressTips(tonumber(str))
  end,
  DressStore_Group_Character_Btn_Turn_Click = function(btn, str)
    local animName = DataModel.isBack and "dorm_stand" or "dorm_stand_back"
    View.Group_Character.SpineAnimation_:SetActionWithoutMix(animName, true, true)
    DataModel.isBack = not DataModel.isBack
  end,
  DressStore_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  DressStore_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  DressStore_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  DressStore_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  DressStore_Group_RightPanel_Group_Middle_ScrollGrid_Skin_Group_Item_Btn_Dress_Click = function(btn, str)
    local item = DataModel.curTypeShopItems[tonumber(str)]
    local skinId = item.itemId
    local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
    local selectItem = DataModel.allSelectShopItems[skinCA.skinType]
    if selectItem then
      local selectSkinId = selectItem.itemId
      local oldElement = DataModel.skinElements[selectSkinId]
      if oldElement then
        oldElement.Img_Picked:SetActive(false)
      end
      if selectSkinId == skinId then
        DataModel.ChangeSkin(item, false)
        return
      end
    end
    local element = DataModel.skinElements[skinId]
    element.Img_Picked:SetActive(true)
    DataModel.ChangeSkin(item, true)
  end,
  DressStore_Group_RightPanel_Group_Middle_ScrollGrid_Skin_Group_Item_Btn_Buy_Click = function(btn, str)
    local item = DataModel.curTypeShopItems[tonumber(str)]
    if item.skinUid ~= nil then
      return
    end
    local commodityCA = PlayerData:GetFactoryData(item.commodityId, "CommodityFactory")
    local costConfig = commodityCA[1]
    if costConfig then
      local costNum = costConfig.moneyNum
      local haveNum = PlayerData:GetGoodsById(costConfig.moneyID).num
      if costNum > haveNum then
        PlayerData:AllBuyCommodity(costConfig.moneyID, costNum)
        return
      end
    end
    local data = {}
    data.commoditData = commodityCA
    data.shopid = DataModel.shopId
    data.storeType = PlayerData:GetFactoryData(DataModel.shopId, "StoreFactory").storeType
    data.name = commodityCA.commodityName
    data.image = commodityCA.commodityView
    data.qualityInt = commodityCA.qualityInt + 1
    CommonTips.OpenBuyTips(data, function()
      local skinId = item.itemId
      local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
      local selectItem = DataModel.allSelectShopItems[skinCA.skinType]
      if selectItem then
        local selectSkinId = selectItem.itemId
        local oldElement = DataModel.skinElements[selectSkinId]
        if oldElement then
          oldElement.Img_Picked:SetActive(false)
        end
      end
      local element = DataModel.skinElements[skinId]
      element.Img_Owned:SetActive(true)
      element.Img_BgMoney:SetActive(false)
      element.Img_Picked:SetActive(true)
      DataModel.ChangeSkin(item, true)
      local skinUid
      for i, v in pairs(PlayerData.ServerData.dress) do
        if v.id == tostring(skinId) then
          skinUid = i
          break
        end
      end
      if skinUid then
        local skinCA = PlayerData:GetFactoryData(skinId, "HomeCharacterSkinFactory")
        Net:SendProto("hero.dress", function(jso)
        end, DataModel.unitId, skinUid)
        item.skinUid = skinUid
        DataModel.allSelectShopItems[skinCA.skinType] = item
        DataModel.SaveDresses()
        DataModel.InitSceneCharacterSkin()
      end
      View.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    end)
  end,
  DressStore_Group_Character_Btn_Save_Click = function(btn, str)
    for skinType, shopItem in pairs(DataModel.allSelectShopItems) do
      local skinUid = shopItem.skinUid
      if not skinUid then
        local format = PlayerData:GetFactoryData(80602332, "TextFactory").text
        local skinTypeCA = PlayerData:GetFactoryData(skinType, "TagFactory")
        CommonTips.OpenTips(string.format(format, skinTypeCA.name))
        return
      end
    end
    DataModel.SaveDresses()
    DataModel.InitSceneCharacterSkin()
    CommonTips.OpenTips(80602333)
  end,
  DressStore_Btn_Medal_Click = function(btn, str)
  end,
  DressStore_Btn_Medal_Btn_Add_Click = function(btn, str)
  end
}
return ViewFunction
