local View = require("UIItemTips/UIItemTipsView")
local DataModel = require("UIItemTips/UIItemTipsDataModel")
local Controller = require("UIItemTips/UIItemTipsController")
local CommonUse = function(num)
  if DataModel.Data.isBattlePassItem == true and PlayerData:GetBattlePass().pass_type ~= 0 then
    CommonTips.OpenTips(80602307)
    return
  end
  if DataModel.Data.useType == "Chosen" then
    UIManager:GoBack()
    UIManager:Open("UI/SelectItem/SelectItem", tostring(DataModel.Id))
  else
    if DataModel.Data.containEquipment then
      local space_info = PlayerData.ServerData.user_info.space_info
      if space_info.max_equip_num <= space_info.now_equip_num then
        CommonTips.OpenTips(GetText(80600020))
        return
      end
    end
    if DataModel.Data.endTime ~= "" and 0 >= TimeUtil:LastTime(DataModel.Data.endTime) then
      CommonTips.OpenTips(GetText(80600012))
      return
    end
    local isMoveEnergy = false
    if DataModel.Data.exchangeList ~= nil and 0 < #DataModel.Data.exchangeList then
      local info = DataModel.Data.exchangeList[1]
      local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
      if info.itemId == homeConfig.homeEnergyItemId then
        isMoveEnergy = true
        if 0 >= PlayerData:GetGoodsById(homeConfig.homeEnergyItemId).num then
          CommonTips.OpenTips(80600681)
          return
        end
      end
    end
    local itemType
    local firstParam = tostring(DataModel.Id)
    local isLimited = false
    local limitedId
    if DataModel.Data.limitedTime and 0 < DataModel.Data.limitedTime and DataModel.LimitedTimeData then
      itemType = 1
      firstParam = DataModel.LimitedTimeData.uid[1]
      isLimited = true
      limitedId = firstParam
      local serverInfo = PlayerData:GetLimitedItems()[firstParam]
      local curTime = TimeUtil:GetServerTimeStamp()
      if curTime >= serverInfo.dead_line then
        UIManager:GoBack()
        CommonTips.OpenTips(80600045)
        return
      end
    end
    if DataModel.Data.isBatch == true and 0 < DataModel.ItemInfo.num then
      View.self:CloseUI()
      CommonTips.OpenUseTips({
        id = DataModel.Id,
        isLimited = isLimited,
        limitedId = limitedId,
        limitedTimeData = DataModel.LimitedTimeData
      })
      return
    end
    Net:SendProto("item.use_items", function(json)
      if DataModel.Data.isBattlePassItem == true then
        if DataModel.Data.BattlePassType == "Low" then
          PlayerData:GetBattlePass().pass_type = 1
        else
          PlayerData:GetBattlePass().pass_type = 2
        end
      end
      if itemType then
        PlayerData:GetLimitedItems()[firstParam] = nil
      else
        PlayerData:RefreshUseItems({
          [DataModel.Id] = num
        })
      end
      UIManager:GoBack()
      Controller.RefreshMain()
      if DataModel.Data.isDrinkItem then
        CommonTips.OpenTips(80600678)
        local station_info = PlayerData:GetHomeInfo().station_info
        if station_info ~= nil then
          local stop_info = station_info.stop_info
          if stop_info ~= nil and stop_info[2] == -1 then
            local stationId = tostring(stop_info[1])
            if PlayerData:GetHomeInfo().stations[stationId] ~= nil then
              local drink_num = PlayerData:GetHomeInfo().stations[stationId].drink_num or 0
              drink_num = drink_num - DataModel.Data.drinkNum
              if drink_num < 0 then
                drink_num = 0
              end
              PlayerData:GetHomeInfo().stations[stationId].drink_num = drink_num
            end
          end
        end
      elseif isMoveEnergy then
        CommonTips.OpenTips(80600680)
      elseif DataModel.Data.gettipstype and DataModel.Data.gettipstype == "Pet" then
        if json.reward and json.reward.pet then
          for k, v in pairs(json.reward.pet) do
            UIManager:Open("UI/HomePetStore/PetAcquire", Json.encode({uid = k}))
            break
          end
        end
      else
        CommonTips.OpenShowItem(json.reward)
      end
    end, firstParam, num, nil, itemType)
  end
end
local ViewFunction = {
  ItemTips_Btn_BG_Click = function(btn, str)
    if DataModel.Back.type and DataModel.Back.type == 1 then
      UIManager:GoBack()
    else
      UIManager:GoBack(false, 1)
    end
  end,
  ItemTips_Group_BatchUse_Btn_UseOne_Click = function(btn, str)
    CommonUse(1)
  end,
  ItemTips_Group_BatchUse_Btn_UseTen_Click = function(btn, str)
    local num = DataModel.ItemInfo.num >= 10 * DataModel.Data.numRequired and 10 or math.floor(DataModel.ItemInfo.num / DataModel.Data.numRequired)
    CommonUse(num)
  end,
  ItemTips_Group_Use_Btn_Use_Click = function(btn, str)
    print_r(DataModel.Data)
    CommonUse(1)
  end,
  ItemTips_Group_Use_Btn_Cancel_Click = function(btn, str)
    if DataModel.Back.type and DataModel.Back.type == 1 then
      UIManager:GoBack()
    else
      UIManager:GoBack(false, 1)
    end
  end,
  ItemTips_Group_BatchUse_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  ItemTips_Group_Goto_Btn_Goto_Click = function(btn, str)
    UIManager:GoBack()
    UIManager:Open(DataModel.Data.Prefab)
  end,
  ItemTips_Group_Goto_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  ItemTips_Group_Compose_Btn_Compose_Click = function(btn, str)
    CommonUse(1)
  end,
  ItemTips_Group_Compose_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  ItemTips_Group_BatchCompose_Btn_ComposeOne_Click = function(btn, str)
    CommonUse(1)
  end,
  ItemTips_Group_BatchCompose_Btn_ComposeTen_Click = function(btn, str)
    local num = DataModel.ItemInfo.num >= 5 * DataModel.Data.numRequired and 5 or math.floor(DataModel.ItemInfo.num / DataModel.Data.numRequired)
    CommonUse(num)
  end,
  ItemTips_Group_BatchCompose_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  ItemTips_Group_Sale_Btn_Sale_Click = function(btn, str)
    CommonTips.SaleTips(DataModel.SaleData)
  end,
  ItemTips_Group_Sale_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack()
  end,
  ItemTips_Group_Convert_Btn_Cancel_Click = function(btn, str)
    View.self:Confirm()
    UIManager:GoBack()
  end,
  ItemTips_Group_Convert_Btn_Convert_Click = function(btn, str)
    CommonTips.OpenConvertTips(DataModel)
  end,
  ItemTips_Group_Show_Btn_Access_Click = function(btn, str)
    local data = {}
    data.itemID = DataModel.Id
    data.posX = 270
    data.posY = -130
    View.Group_Show.Btn_Access.Img_On:SetActive(true)
    UIManager:Open("UI/Common/Group_GetWay", Json.encode(data), function()
      View.Group_Show.Btn_Access.Img_On:SetActive(false)
    end)
  end
}
return ViewFunction
