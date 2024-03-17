local View = require("UIStore/UIStoreView")
local DataModel = {}
DataModel.Choose_List = {}
DataModel.Choose_Button = {}
DataModel.Tag = {
  [1] = {
    btn = "Btn_recommend",
    name = "推荐",
    obj = "",
    list = {}
  },
  [2] = {
    btn = "Btn_diamondstore",
    name = "购买桦石",
    obj = "Group_DiamondStore",
    showUI = "Group_DiamondStore",
    list = PlayerData:GetFactoryData(99900001).diamondStoreList
  },
  [3] = {
    btn = "Btn_MoonStore",
    name = "黑月直营",
    obj = "Group_MoonStore",
    showUI = "Group_MoonStore",
    list = PlayerData:GetFactoryData(99900001).moonStoreList
  }
}
DataModel.List = {
  [3] = {
    {
      itemID = 11400005,
      commodityName = "测试名",
      propNumber = 15,
      element = "",
      isBuy = false,
      commodityMoney = "金币",
      commodityPrice = 6,
      monetaryView = "",
      commodityFunction = "你是一个描述"
    },
    {
      itemID = 11400006,
      commodityName = "测试名",
      propNumber = 5,
      element = "",
      isBuy = false,
      commodityMoney = "金币",
      commodityPrice = 60,
      monetaryView = "",
      commodityFunction = "你是一个描述"
    },
    {
      itemID = 11400003,
      commodityName = "测试名",
      propNumber = 56,
      element = "",
      isBuy = false,
      commodityMoney = "金币",
      commodityPrice = 16,
      monetaryView = "",
      commodityFunction = "你是一个描述"
    }
  },
  [2] = {
    {
      itemID = 11400002,
      commodityName = "测试名",
      propNumber = 10,
      element = "",
      isBuy = false,
      commodityMoney = "桦石",
      commodityPrice = 36,
      monetaryView = "",
      commodityFunction = "你是一个描述"
    },
    {
      itemID = 11400006,
      commodityName = "测试名",
      propNumber = 3,
      element = "",
      isBuy = false,
      commodityMoney = "桦石",
      commodityPrice = 56,
      monetaryView = "",
      commodityFunction = "你是一个描述"
    },
    {
      itemID = 11400006,
      commodityName = "测试名",
      propNumber = 91,
      element = "",
      isBuy = false,
      commodityMoney = "桦石",
      commodityPrice = 96,
      monetaryView = "",
      commodityFunction = "你是一个描述"
    },
    {
      itemID = 11400003,
      commodityName = "测试名",
      propNumber = 41,
      element = "",
      isBuy = false,
      commodityMoney = "桦石",
      commodityPrice = 600,
      monetaryView = "",
      commodityFunction = "你是一个描述"
    },
    {
      itemID = 11400003,
      commodityName = "测试名",
      propNumber = 77,
      element = "",
      isBuy = false,
      commodityMoney = "桦石",
      commodityPrice = 561,
      monetaryView = "",
      commodityFunction = "你是一个描述"
    },
    {
      itemID = 11400003,
      commodityName = "测试名",
      propNumber = 89,
      element = "",
      isBuy = false,
      commodityMoney = "桦石",
      commodityPrice = 561,
      monetaryView = "",
      commodityFunction = "你是一个描述"
    }
  }
}
local gird_dimond, grid_role, grid_gift, grid_skinPre, grid_recommend
DataModel.tagindex = nil
DataModel.rightindex = nil
local get_skinPre_grid = function()
  if not grid_skinPre then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_SkinPreStore")
    grid_skinPre = View.Group_SkinPreStore.NewScrollGrid_List.grid.self
  end
  return grid_skinPre
end
local get_dimond_grid = function()
  if not gird_dimond then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_DiamondStore")
    gird_dimond = View.Group_DiamondStore.ScrollGrid_List.grid.self
  end
  return gird_dimond
end
local get_role_grid = function()
  if not grid_role then
    grid_role = View.Group_RoleStore.StaticGrid_List.grid.self
  end
  return grid_role
end
local get_gift_grid = function()
  if not grid_gift then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_GiftStore")
    grid_gift = View.Group_GiftStore.NewScrollGrid_List.grid.self
  end
  return grid_gift
end
local get_recommend_grid = function()
  if not grid_recommend then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_RecommendStore")
    grid_recommend = View.Group_RecommendStore.ScrollGrid_List.grid.self
  end
  return grid_recommend
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
  DataModel.Choose_Purchase_Role = {}
  DataModel.Choose_Purchase_Role.index = index
  DataModel.Choose_Purchase_Role.id = data.id
  DataModel.Choose_Purchase_Role.shopCA = shopCA
  View.Group_RoleStore.Group_TimeCommodity.Group_Time.Txt_Time:SetText(TimeUtil:GetGachaDesc(time))
  View.Group_RoleStore.Group_TimeCommodity.Btn_Buy.Txt_Num:SetText(shopCA.moneyList[1].moneyNum)
  local left_money = PlayerData:GetFactoryData(tonumber(shopCA.moneyList[1].moneyID))
  View.Group_RoleStore.Group_TimeCommodity.Btn_Buy.Img_Money:SetSprite(left_money.iconPath)
  local roleCA = PlayerData:GetFactoryData(shopCA.commodityItemList[1].id)
  local Group_SkillColor = View.Group_RoleStore.Group_TimeCommodity.Group_Role.Group_SkillColor
  Group_SkillColor.self:SetActive(true)
  local cardList = PlayerData:GetRoleCardList(roleCA.id)
  for i = 1, table.count(cardList) do
    local obj = "Group_SkillColor" .. i
    local cardCA = PlayerData:GetFactoryData(cardList[table.count(cardList) - i + 1].id)
    local color = cardCA.color
    Group_SkillColor[obj].Img_Color:SetSprite(UIConfig.CharacterSkillColor[color])
  end
  local Group_Locate = View.Group_RoleStore.Group_TimeCommodity.Group_Role.Group_SkillColor.Group_Locate
  Group_Locate.Img_Line:SetSprite(UIConfig.CharacterLine[roleCA.line])
end
local OpenStorePage = function()
  if DataModel.Now_ShopList.showUI == nil then
    return
  end
  View[DataModel.Now_ShopList.showUI]:SetActive(true)
  if DataModel.Now_ShopList.showUI == "Group_DiamondStore" then
    for k, v in pairs(DataModel.Now_ShopList.shopList) do
      v.num = 0
      if PlayerData.RechargeGoods ~= nil then
        local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
        if recharge and recharge[tostring(v.id)] then
          local num = recharge[tostring(v.id)].num
          v.num = num
        end
      end
    end
    get_dimond_grid():SetDataCount(table.count(DataModel.Now_ShopList.shopList))
    get_dimond_grid():RefreshAllElement()
    View.Group_DiamondStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
  end
  if DataModel.Now_ShopList.showUI == "Group_RoleStore" then
    DataModel.RoleStore = {}
    local count = 1
    for k, v in pairs(DataModel.Now_ShopList.shopList) do
      local ca = PlayerData:GetFactoryData(v.id)
      if ca.isTime and ca.isTime == true then
        if ca.startTime ~= "" and TimeUtil:IsActive(ca.startTime, ca.endTime) then
          ShowPurchaseRole(v, k)
        end
      else
        DataModel.RoleStore[count] = v
        DataModel.RoleStore[count].index = k
        DataModel.RoleStore[count].server = {}
        if PlayerData.ServerData.shops[tostring(DataModel.Shop_Id)] then
          for c, d in pairs(PlayerData.ServerData.shops[tostring(DataModel.Shop_Id)].items) do
            if tonumber(d.id) == tonumber(v.id) then
              DataModel.RoleStore[count].server = d
            end
          end
        end
        count = count + 1
      end
    end
    View.Group_RoleStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400017).num)
    get_role_grid():SetDataCount(table.count(DataModel.RoleStore))
    get_role_grid():RefreshAllElement()
  end
  DataModel.isFirstGiftStore = true
  if DataModel.Now_ShopList.showUI == "Group_GiftStore" then
    for k, v in pairs(DataModel.Now_ShopList.shopList) do
      local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
      v.num = 0
      if recharge and recharge[tostring(v.id)] then
        local num = recharge[tostring(v.id)].num
        v.num = num
      end
      local isMax_index = 1
      local index = k
      local commoditData = PlayerData:GetFactoryData(v.id)
      if commoditData.purchase == true and DataModel.PurchaseTypeList(commoditData.limitBuyType) ~= nil and v.num >= commoditData.purchaseNum then
        isMax_index = 2
      end
      v.index = index
      v.isMax_index = isMax_index
    end
    table.sort(DataModel.Now_ShopList.shopList, function(a, b)
      if a.isMax_index == b.isMax_index then
        return a.index < b.index
      end
      return a.isMax_index < b.isMax_index
    end)
    if DataModel.isFirstGiftStore == true then
      get_gift_grid():StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        get_gift_grid():SetDataCount(table.count(DataModel.Now_ShopList.shopList))
        get_gift_grid():RefreshAllElement()
        get_gift_grid():MoveToTop()
        View.Group_GiftStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
      end))
      DataModel.isFirstGiftStore = false
    else
      get_gift_grid():SetDataCount(table.count(DataModel.Now_ShopList.shopList))
      get_gift_grid():RefreshAllElement()
      get_gift_grid():MoveToTop()
      View.Group_GiftStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    end
  end
  DataModel.isFirstSkinPreStore = true
  if DataModel.Now_ShopList.showUI == "Group_SkinPreStore" then
    for k, v in pairs(DataModel.Now_ShopList.shopList) do
      local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
      v.num = 0
      if recharge and recharge[tostring(v.id)] then
        local num = recharge[tostring(v.id)].num
        v.num = num
      end
      local isMax_index = 1
      local index = k
      local commoditData = PlayerData:GetFactoryData(v.id)
      if commoditData.purchase == true and DataModel.PurchaseTypeList(commoditData.limitBuyType) ~= nil and v.num == commoditData.purchaseNum then
        isMax_index = 2
      end
      v.index = index
      v.isMax_index = isMax_index
    end
    table.sort(DataModel.Now_ShopList.shopList, function(a, b)
      if a.isMax_index == b.isMax_index then
        return a.index < b.index
      end
      return a.isMax_index < b.isMax_index
    end)
    if DataModel.isFirstSkinPreStore == true then
      get_skinPre_grid():StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        get_skinPre_grid():SetDataCount(table.count(DataModel.Now_ShopList.shopList))
        get_skinPre_grid():RefreshAllElement()
        get_skinPre_grid():MoveToTop()
        View.Group_SkinPreStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
      end))
      DataModel.isFirstSkinPreStore = false
    else
      get_skinPre_grid():SetDataCount(table.count(DataModel.Now_ShopList.shopList))
      get_skinPre_grid():RefreshAllElement()
      get_skinPre_grid():MoveToTop()
      View.Group_SkinPreStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    end
  end
  if DataModel.Now_ShopList.showUI == "Group_RecommendStore" then
    DataModel.recommendList = {}
    for k, v in pairs(DataModel.Now_ShopList.recommendList) do
      if v.funcId then
        local commoditData = PlayerData:GetFactoryData(v.id) or {}
        local row = v
        row.commoditData = commoditData
        if v.funcId ~= -1 then
          local funcCommon = require("Common/FuncCommon")
          local isUnlock = funcCommon.FuncActiveCheck(v.funcId, false)
          if isUnlock == true then
            table.insert(DataModel.recommendList, v)
          end
        else
          table.insert(DataModel.recommendList, v)
        end
      end
    end
    get_recommend_grid():SetDataCount(table.count(DataModel.recommendList))
    get_recommend_grid():RefreshAllElement()
    View.Group_RecommendStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    DataModel.RecommedIndex = nil
    DataModel.ChooseRecommedStore(1)
  end
end
local ShowPurchaseRole = function(data, index)
  local shopCA = PlayerData:GetFactoryData(data.id)
  local itemCA = PlayerData:GetFactoryData(shopCA.commodityItemList[1].id)
  local viewCA = PlayerData:GetFactoryData(itemCA.viewId)
  View.Group_MoonStore.Group_RoleStore.Group_TimeCommodity.Group_Role.SpineAnimation_Character:SetData(viewCA.spineUrl)
  View.Group_MoonStore.Group_RoleStore.Group_TimeCommodity.Group_Role.SpineAnimation_Character.transform.localPosition = Vector3(-80, -900, 0)
  View.Group_MoonStore.Group_RoleStore.Group_TimeCommodity.Group_Role.Group_Character.Sprite_Character:SetActive(false)
  local lastTime = TimeUtil:LastTime(shopCA.endTime)
  local time = TimeUtil:SecondToTable(lastTime)
  DataModel.List[3].cor_time = lastTime
  DataModel.Choose_Purchase_Role = {}
  DataModel.Choose_Purchase_Role.index = index
  DataModel.Choose_Purchase_Role.id = data.id
  DataModel.Choose_Purchase_Role.shopCA = shopCA
  View.Group_MoonStore.Group_RoleStore.Group_TimeCommodity.Group_Time.Txt_Time:SetText(TimeUtil:GetGachaDesc(time))
  View.Group_MoonStore.Group_RoleStore.Group_TimeCommodity.Btn_Buy.Txt_Num:SetText(shopCA.moneyList[1].moneyNum)
  local left_money = PlayerData:GetFactoryData(tonumber(shopCA.moneyList[1].moneyID))
  View.Group_MoonStore.Group_RoleStore.Group_TimeCommodity.Btn_Buy.Img_Money:SetSprite(left_money.iconPath)
  View.Group_MoonStore.Group_RoleStore.Group_TimeCommodity.Group_Role.Txt_Name:SetText(shopCA.commodityName)
  View.Group_MoonStore.Group_RoleStore.Group_TimeCommodity.Group_Role.Img_Quality:SetSprite(UIConfig.WeaponQuality[shopCA.qualityInt + 1])
  local roleCA = PlayerData:GetFactoryData(shopCA.commodityItemList[1].id)
  local Group_SkillColor = View.Group_MoonStore.Group_RoleStore.Group_TimeCommodity.Group_Role.Group_SkillColor
  Group_SkillColor.self:SetActive(true)
  local cardList = PlayerData:GetRoleCardList(roleCA.id)
  for i = 1, table.count(cardList) do
    local obj = "Group_SkillColor" .. i
    local cardCA = PlayerData:GetFactoryData(cardList[table.count(cardList) - i + 1].id)
    local color = cardCA.color
    Group_SkillColor[obj].Img_Color:SetSprite(UIConfig.CharacterSkillColor[color])
  end
  local Group_Locate = View.Group_MoonStore.Group_RoleStore.Group_TimeCommodity.Group_Role.Group_SkillColor.Group_Locate
  Group_Locate.Img_Line:SetSprite(UIConfig.CharacterLine[roleCA.line])
end

function DataModel.GetInitStoreConfig()
  local diamondStoreList = PlayerData:GetFactoryData(99900001).diamondStoreList
  local moonStoreList = PlayerData:GetFactoryData(99900001).moonStoreList
  DataModel.List = {}
  local row = {}
  table.insert(DataModel.List, row)
  local count = table.count(DataModel.List) or 0
  local row = {}
  row.shopFactory = PlayerData:GetFactoryData(diamondStoreList[1].id)
  row.severStroeValue = PlayerData.ServerData.shops[tostring(diamondStoreList[1].id)] or {}
  if row.shopFactory.storeType == "Regular" and diamondStoreList[1].id == 40300003 then
    for k, v in pairs(row.shopFactory.shopList) do
      local recharge = PlayerData.RechargeGoods[tostring(40300003)]
      v.num = 0
      if recharge and recharge[tostring(v.id)] then
        local num = recharge[tostring(v.id)].num
        v.num = num
      end
    end
  end
  row.cor_time = row.cor_time or 0
  row.commoditData = ""
  row.moneyList = {}
  row.shopid = diamondStoreList[1].id
  DataModel.List[2] = row
  local list = {}
  for i = 1, 4 do
    local row = {}
    list[i] = {}
    if i == 3 then
      local shopFactory = PlayerData:GetFactoryData(moonStoreList[1].id)
      local severStroeValue = PlayerData.ServerData.shops[tostring(moonStoreList[1].id)] or {}
      if shopFactory.storeType == "Random" then
        DataModel.List[count] = severStroeValue
        if severStroeValue.last_auto_refresh then
          DataModel.List[count].cor_time = severStroeValue.last_auto_refresh + 86400 - PlayerData.ServerData.server_now
          DataModel.auto_refresh_index = 3
        end
      end
      row.cor_time = row.cor_time or 0
      row.commoditData = ""
      row.moneyList = {}
      row.shopFactory = shopFactory
      row.severStroeValue = severStroeValue
      row.shopid = moonStoreList[1].id
      list[i] = row
    end
  end
  DataModel.List[3] = list
end

function DataModel.GetStoreConfig(id)
  return PlayerData:GetFactoryData(id, "StoreFactory")
end

function DataModel.GetStoreConditionFactory(id)
  return PlayerData:GetFactoryData(id, "StoreConditionFactory")
end

function DataModel:ChooseTag(index)
  if index == 1 then
    CommonTips.OpenTips("策划还没想好呢 ！！！")
    return
  end
  if index and DataModel.Tag[index] then
    if DataModel.tagindex ~= nil and DataModel.tagindex == index then
      return
    end
    DataModel.tagindex = index
    for k, v in pairs(DataModel.Tag) do
      local btn = View.Group_Top_Button[v.btn].Btn_Top
      btn.Img_pitchon:SetActive(false)
      if v.showUI and View[v.showUI] then
        View[v.showUI].self:SetActive(false)
      end
    end
    DataModel.Choose_List = DataModel.List[index]
    DataModel.shop_id = DataModel.List[index].shopid
    local btn = View.Group_Top_Button[DataModel.Tag[index].btn].Btn_Top
    btn.Img_pitchon:SetActive(true)
    if DataModel.Tag[index].showUI and View[DataModel.Tag[index].showUI] then
      View[DataModel.Tag[index].showUI].self:SetActive(true)
    end
    if index == 1 then
      CommonTips.OpenTips("策划还没想好呢 ！！！")
      return
    end
    if index == 2 then
      get_dimond_grid():SetDataCount(table.count(DataModel.Choose_List.shopFactory.shopList))
      get_dimond_grid():RefreshAllElement()
    end
    if index == 3 then
      View.Group_MoonStore.Group_RoleStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetUserInfo().medal)
      DataModel:ChooseRightTab(3)
    end
  end
end

local RightTag = {
  "Btn_Equip",
  "Btn_Furniture",
  "Btn_Role",
  "Btn_Skin"
}

function DataModel:ChooseRightTab(index, state)
  if index ~= 3 and index then
    CommonTips.OpenTips(80600410)
    return
  end
  if index then
    if DataModel.rightindex ~= nil and DataModel.rightindex == index and state == nil then
      return
    end
    DataModel.rightindex = index
    for k, v in pairs(RightTag) do
      local btn = View.Group_MoonStore.Group_BtnTag[v]
      btn.Group_Off:SetActive(true)
    end
    local btn = View.Group_MoonStore.Group_BtnTag[RightTag[index]]
    btn.Group_Off:SetActive(false)
    DataModel.Role_list = DataModel.Choose_List[index]
    DataModel.shop_id = DataModel.Role_list.shopid
    DataModel.RoleStore = {}
    local count = 1
    for k, v in pairs(DataModel.Role_list.shopFactory.shopList) do
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
    if table.count(DataModel.RoleStore) > 0 then
      get_role_grid():SetActive(true)
      get_role_grid():SetDataCount(table.count(DataModel.RoleStore))
      get_role_grid():RefreshAllElement()
    else
      get_role_grid():SetActive(false)
    end
  end
end

function DataModel.InitTopList()
  DataModel.mainStoreList = PlayerData:GetFactoryData(99900001).mainStoreList
  View.StaticGrid_TopButton.self:RefreshAllElement()
  DataModel.ChooseTopList(DataModel.TopIndex)
end

function DataModel.ChooseTopList(index)
  if index == nil then
    return
  end
  if index == DataModel.TopIndex and DataModel.RefreshState == 0 then
    return
  end
  DataModel.RefreshState = 0
  local row = DataModel.mainStoreList[tonumber(index)]
  if DataModel.TopIndex ~= nil then
    View.StaticGrid_TopButton.grid[DataModel.TopIndex].Btn_Top.Img_pitchon:SetActive(false)
  end
  DataModel.TopIndex = tonumber(index)
  View.StaticGrid_TopButton.grid[tonumber(index)].Btn_Top.Img_pitchon:SetActive(true)
  if table.count(row.ca.mainStoreList) > 1 then
    View.StaticGrid_RightButton.self:SetActive(true)
    DataModel.RightMainStoreList = row.ca.mainStoreList
    DataModel.RightIndex = nil
    View.StaticGrid_RightButton.self:RefreshAllElement()
    DataModel.ChooseRightList(1)
  else
    View.StaticGrid_RightButton.self:SetActive(false)
    if DataModel.Now_ShopList then
      View[DataModel.Now_ShopList.showUI]:SetActive(false)
    end
    if table.count(row.ca.mainStoreList) == 1 then
      DataModel.Shop_Id = PlayerData:GetFactoryData(row.ca.mainStoreList[1].id).id
      DataModel.Now_ShopList = {}
      DataModel.Now_ShopList = PlayerData:GetFactoryData(row.ca.mainStoreList[1].id)
      DataModel.Now_ShopList.shopList = PlayerData:GetFactoryData(row.ca.mainStoreList[1].id).shopList
      DataModel.Now_ShopList.server = PlayerData.ServerData.shops[tostring(40300008)]
      OpenStorePage()
    end
  end
end

function DataModel.ChooseRecommedStore(index)
  if index and DataModel.RecommedIndex == index then
    return
  end
  if DataModel.RecommedIndex then
    local old_element = View.Group_RecommendStore.ScrollGrid_List.grid.self:GetElementByIndex(DataModel.RecommedIndex - 1)
    old_element.Group_Off.self:SetActive(true)
    old_element.Group_On.self:SetActive(false)
  end
  local now_element = View.Group_RecommendStore.ScrollGrid_List.grid.self:GetElementByIndex(index - 1)
  now_element.Group_Off.self:SetActive(false)
  now_element.Group_On.self:SetActive(true)
  View.Group_RecommendStore.Btn_Recommend:SetSprite(DataModel.recommendList[index].png)
  DataModel.RecommedIndex = index
end

function DataModel.ChooseRightList(index)
  if index == nil then
    return
  end
  if index == DataModel.RightIndex then
    return
  end
  local row = DataModel.mainStoreList[tonumber(index)]
  if DataModel.RightIndex ~= nil then
    DataModel.mainStoreList[DataModel.RightIndex].element.Btn_Top.Img_pitchon:SetActive(false)
  end
  DataModel.RightIndex = tonumber(index)
  row.element.Btn_Top.Img_pitchon:SetActive(true)
end

function DataModel.PurchaseTypeList(type)
  local id
  if type == "Forever" then
    id = 80602487
  elseif type == "Daily" then
    id = 80602484
  elseif type == "Weekly" then
    id = 80602483
  elseif type == "Monthly" then
    id = 80602485
  end
  return id
end

DataModel.ConditionList = {}
DataModel.InitSelectIndex = 1
DataModel.ConditionTrueNum = 0

function DataModel:Clear()
  gird_dimond = nil
  grid_role = nil
  grid_gift = nil
  grid_skinPre = nil
  grid_recommend = nil
  DataModel.tagindex = nil
  DataModel.rightindex = nil
  DataModel.TopIndex = nil
  DataModel.Now_ShopList = nil
end

return DataModel
