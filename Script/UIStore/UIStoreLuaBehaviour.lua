local View = require("UIStore/UIStoreView")
local DataModel = require("UIStore/UIStoreDataModel")
local ViewFunction = require("UIStore/UIStoreViewFunction")
local InitBottomButton = function()
  local user_info = PlayerData:GetUserInfo()
  View.Group_TopRight.Btn_Diamond.Txt_diamondnum:SetText(user_info.bm_rock)
  View.Group_TopRight.Btn_Gold.Txt_Gold:SetText(user_info.gold)
end
local SendShopInfo = function()
  local a, b, c, d = PlayerData:OpenStoreCondition()
  DataModel.ConditionList = b
  DataModel.InitSelectIndex = c
  DataModel.ConditionTrueNum = d
end
local tagPanel = {
  "Group_RecommendStore",
  "Group_DiamondStore",
  "Group_GiftStore",
  "Group_SkinPreStore"
}
local Luabehaviour = {
  serialize = function()
    local param = {}
    param.index = DataModel.TopIndex
    param.RefreshState = 1
    return Json.encode(param)
  end,
  deserialize = function(initParams)
    if initParams then
      local json = Json.decode(initParams)
      DataModel.TopIndex = DataModel.TopIndex or 1
      for k, v in pairs(tagPanel) do
        View[v]:SetActive(false)
      end
      if DataModel.TopIndex ~= json.index and json.index then
        View[tagPanel[DataModel.TopIndex]]:SetActive(false)
        View[tagPanel[json.index]]:SetActive(true)
      end
      DataModel.RefreshState = json.RefreshState or 1
      DataModel.TopIndex = json.index or 1
      DataModel.InitTopList()
      if DataModel.TopIndex == 3 and json.subIndex ~= nil then
        local itemIndex
        for i = 1, #DataModel.Now_ShopList.shopList do
          if tonumber(DataModel.Now_ShopList.shopList[i].id) == tonumber(json.subIndex) then
            itemIndex = i
            break
          end
        end
        if itemIndex ~= nil then
          ViewFunction.Store_Group_GiftStore_NewScrollGrid_List_Group_gift_Btn_Item_Click(nil, tostring(itemIndex))
        end
      end
      DataModel.isMoveEnergyOpen = json.isMoveEnergyOpen
      if GameSetting.AdministrationsAddictionFeature then
        local grow = PlayerData:IsCheckYearOld(PlayerData:GetUserInfo().real_info.id_card)
        if grow < 18 then
          CommonTips.OpenAntiAddiction({index = 2})
        end
      end
      if DataModel.isMoveEnergyOpen then
        View.self:StartC(LuaUtil.cs_generator(function()
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          local idx = -1
          for i, v in ipairs(DataModel.Now_ShopList.shopList) do
            if v.id == 82100015 and v.isMax == false then
              idx = i
              break
            end
            if v.id == 82100021 and v.isMax == false then
              idx = i
            end
          end
          if idx == -1 then
            UIManager:GoBack()
            return
          end
          ViewFunction.Store_Group_GiftStore_ScrollGrid_List_Group_gift_Btn_Item_Click(nil, idx)
        end))
      end
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.List[DataModel.Now_Tab_Index] and next(DataModel.List[DataModel.Now_Tab_Index]) ~= nil and DataModel.List[DataModel.Now_Tab_Index].cor_time > 0 then
      DataModel.List[DataModel.Now_Tab_Index].cor_time = DataModel.List[DataModel.Now_Tab_Index].cor_time - Time.fixedDeltaTime
      View.Group_DailyStore.Group_Bottom.Img_Backgroud.Txt_RefreshTime:SetText(GetTimeData(DataModel.List[DataModel.Now_Tab_Index].cor_time))
      View.Group_GoldStore.Group_Bottom.Img_Backgroud.Txt_RefreshTime:SetText(GetTimeData(DataModel.List[DataModel.Now_Tab_Index].cor_time))
      View.Group_RoleStore.Group_TimeCommodity.Group_Time.Txt_Time:SetText(TimeUtil:GetGachaDesc(TimeUtil:SecondToTable(DataModel.List[DataModel.Now_Tab_Index].cor_time)))
    else
      SendShopInfo()
    end
  end,
  ondestroy = function()
    DataModel:Clear()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
