local CommonItem = require("Common/BtnItem")
local View = require("UIGroup_Strengthen/UIGroup_StrengthenView")
local DataModel = require("UIGroup_Strengthen/UIGroup_StrengthenDataModel")
DataModel.BtnList = {
  [1] = {
    content = "SSR及以下装备",
    index = 1,
    type = 3,
    isItem = false,
    max = 0
  },
  [2] = {
    content = "SR及以下装备",
    index = 2,
    type = 2,
    isItem = false,
    max = 0
  },
  [3] = {
    content = "R及以下装备",
    index = 3,
    type = 1,
    isItem = false,
    max = 0
  },
  [4] = {
    content = "SSR及以下经验道具",
    index = 4,
    type = 3,
    isItem = true,
    max = 0
  },
  [5] = {
    content = "SR及以下经验道具",
    index = 5,
    type = 2,
    isItem = true,
    max = 0
  },
  [6] = {
    content = "R及以下经验道具",
    index = 6,
    type = 1,
    isItem = true,
    max = 0
  }
}
local UpdateSortRare = function()
  DataModel.BtnListIndex = nil
  View.Group_SortRare.Img_Glass.Img_Bg.StaticGrid_Rare.grid.self:SetDataCount(table.count(DataModel.BtnList))
  View.Group_SortRare.Img_Glass.Img_Bg.StaticGrid_Rare.grid.self:RefreshAllElement()
  DataModel:SelectBtnList(PlayerData:GetPlayerPrefs("int", "EquipType") == 0 and table.count(DataModel.BtnList) or PlayerData:GetPlayerPrefs("int", "EquipType"))
end
local ClickRightBtn = function()
  if View.Group_SortRare.self.IsActive == true then
    View.Group_SortRare.self:SetActive(false)
    View.Group_SortRare.self:SelectPlayAnim("Out_SortRare")
    View.Group_Right.Btn_List.Img_Arrow.transform.localRotation = Quaternion.Euler(0, 0, 90)
  else
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/weapon/Group_Strengthen", "Group_SortRare")
    View.Group_SortRare.self:SetActive(true)
    View.Btn_CloseTips:SetActive(true)
    View.Group_SortRare.self:SelectPlayAnim("In_SortRare")
    UpdateSortRare()
    View.Group_Right.Btn_List.Img_Arrow.transform.localRotation = Quaternion.Euler(0, 0, 0)
  end
end
local ViewFunction = {
  Group_Strengthen_Group_Right_Group_Money_Btn_MoneyAdd_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Right_Btn_List_Click = function(btn, str)
    ClickRightBtn()
  end,
  Group_Strengthen_Group_Right_Btn_Oneclickput_Click = function(btn, str)
    DataModel:OneClickPut()
  end,
  Group_Strengthen_Group_Right_Group_Bar_ScrollGrid_Equipment_SetGrid = function(element, elementIndex)
    local row = DataModel.RightChooseConsumeEquip[tonumber(elementIndex)]
    local factoryName = DataManager:GetFactoryNameById(row.eid)
    element.Btn_add:SetActive(true)
    element.Btn_add:SetClickParam(elementIndex)
    element.Group_Equipment:SetActive(true)
    if row.eid == "" then
      element.Group_Equipment:SetActive(false)
    else
      local equip_data = DataModel.ChooseLeftDataIndexList[tonumber(elementIndex)]
      local Group_Equipment = element.Group_Equipment
      Group_Equipment.Btn_Item:SetClickParam(elementIndex)
      Group_Equipment.Img_Item:SetSprite(equip_data.equipCA.iconPath)
      Group_Equipment.Img_Mask:SetSprite(UIConfig.MaskConfig[equip_data.equipCA.qualityInt + 1])
      Group_Equipment.Img_Bottom:SetSprite(UIConfig.BottomConfig[equip_data.equipCA.qualityInt + 1])
      Group_Equipment.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), equip_data.lv))
      Group_Equipment.Img_Select:SetActive(false)
      Group_Equipment.Group_Face:SetActive(false)
      Group_Equipment.Img_Lock:SetActive(false)
      if row.is_locked == 1 then
        Group_Equipment.Img_Lock:SetActive(true)
      end
      Group_Equipment.Img_NoType:SetActive(false)
      if factoryName == "SourceMaterialFactory" then
        Group_Equipment.Txt_EquipmentLevel:SetText("")
      end
    end
  end,
  Group_Strengthen_Group_Right_Group_Bar_ScrollGrid_Equipment_Group_Item_Btn_add_Click = function(btn, str)
    DataModel:OpenChooseEquipList()
  end,
  Group_Strengthen_Group_Right_Group_Bar_ScrollGrid_Equipment_Group_Item_Group_Equipment_Btn_Item_Click = function(btn, str)
    local row = DataModel.RightChooseConsumeEquip[tonumber(str)]
    local index = 1
    for k, v in pairs(DataModel.AllEquip) do
      if v.eid == row.eid then
        index = k
        break
      end
    end
    DataModel:OpenChooseEquipList(index, true)
  end,
  Group_Strengthen_Group_Right_Btn_Change_Click = function(btn, str)
    DataModel:ClickChangeWindows()
  end,
  Group_Strengthen_Btn_Close_Click = function(btn, str)
    DataModel:CloseChooseEquip()
  end,
  Group_Strengthen_Btn_Strengthen_Click = function(btn, str)
    local connect = ";"
    local costExp = ""
    if DataModel.ConsumeNum == 0 then
      CommonTips.OpenTips(80600524)
      return
    end
    if DataModel.AllGold > PlayerData:GetUserInfo().gold then
      CommonTips.OpenTips(80600129)
      return
    end
    local equipList = ""
    local itemList = {}
    for i = 1, table.count(DataModel.RightChooseConsumeEquip) do
      local eid = DataModel.RightChooseConsumeEquip[i].eid
      if eid ~= "" then
        if PlayerData:GetFactoryData(eid) then
          if itemList[eid] == nil then
            itemList[eid] = DataModel.ChooseLeftData[tostring(eid)]
          end
        else
          equipList = equipList .. eid .. connect
        end
      end
    end
    for k, v in pairs(itemList) do
      costExp = costExp .. k .. ":" .. v.num .. connect
    end
    if equipList ~= "" then
      equipList = string.sub(equipList, 1, string.len(equipList) - 1)
    end
    if costExp ~= "" then
      costExp = string.sub(costExp, 1, string.len(costExp) - 1)
    end
    Net:SendProto("equip.upgrade", function(json)
      local trackArgs = {}
      trackArgs.equip_id = DataModel.equipCA.id
      trackArgs.equip_lv = DataModel.server.lv
      trackArgs.cost_item = costExp
      trackArgs.cost_equip = equipList
      SdkReporter.TrackEquip(trackArgs)
      print_r(json)
      if View.Group_Detail.self.IsActive == true then
        View.self:PlayAnim("Close_All")
        View.Group_Detail.self:SetActive(false)
        DataModel:CloseChooseEquip()
      elseif View.Group_Left.self.IsActive == true then
        View.self:PlayAnim("Close_List")
        DataModel:CloseChooseEquip()
      end
      View.self:SelectPlayAnim(View.Group_effect.self, "Strengthen", function()
        if table.count(DataModel.Add_Right_Content) > 0 then
          local params = {}
          params.beforeLv = DataModel.server.lv
          params.nowLv = DataModel.Add_lv + DataModel.server.lv
          params.content = DataModel.Add_Right_Content
          params.ca = DataModel.equipCA
          params.equip = json.equip
          CommonTips.OnStrengthenSuccesePage(params)
        end
        DataModel.server.exp = DataModel.Show_Exp
        DataModel.server.lv = DataModel.server.lv + DataModel.Add_lv
        PlayerData.ServerData.equipments.equips[DataModel.eid] = json.equip
        DataModel.server = json.equip
        for k, v in pairs(DataModel.RightChooseConsumeEquip) do
          if v.eid ~= "" then
            if PlayerData:GetFactoryData(v.eid) then
              PlayerData:GetGoodsById(v.eid).num = PlayerData:GetGoodsById(v.eid).num - 1
              if PlayerData:GetGoodsById(v.eid).num == 0 then
                PlayerData:GetItems()[v.eid] = nil
              end
            else
              PlayerData.ServerData.equipments.equips[v.eid] = nil
            end
          end
        end
        DataModel:InitEquipList()
        DataModel:RefreshRightContent()
        View.Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:MoveToTop()
      end)
    end, DataModel.eid, costExp, equipList)
  end,
  Group_Strengthen_Group_Left_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.AllEquip[tonumber(elementIndex)]
    local Group_Equipment1 = element.Group_Equipment1
    Group_Equipment1.Btn_Item:SetClickParam(elementIndex)
    Group_Equipment1.Btn_Cancel:SetClickParam(elementIndex)
    Group_Equipment1.Img_Item:SetSprite(row.equipCA.iconPath)
    Group_Equipment1.Img_Mask:SetSprite(UIConfig.MaskConfig[row.equipCA.qualityInt + 1])
    Group_Equipment1.Img_Bottom:SetSprite(UIConfig.BottomConfig[row.equipCA.qualityInt + 1])
    Group_Equipment1.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), row.lv))
    Group_Equipment1.Img_Select:SetActive(false)
    Group_Equipment1.Btn_Cancel:SetActive(false)
    Group_Equipment1.Group_Face:SetActive(false)
    Group_Equipment1.Img_Choose:SetActive(false)
    Group_Equipment1.Img_Lock:SetActive(false)
    Group_Equipment1.Img_AddNum:SetActive(false)
    Group_Equipment1.Txt_Num:SetActive(false)
    if row.maxNum then
      Group_Equipment1.Txt_Num:SetActive(true)
      Group_Equipment1.Txt_Num:SetText(row.maxNum)
    end
    if row.isItem == true then
      if row.num > 0 then
        Group_Equipment1.Img_AddNum:SetActive(true)
        Group_Equipment1.Img_AddNum.Txt_Num:SetText(row.num)
      end
      Group_Equipment1.Txt_EquipmentLevel:SetText("")
    end
    if row.is_locked == 1 then
      Group_Equipment1.Img_Lock:SetActive(true)
    end
    Group_Equipment1.Img_NoType:SetActive(false)
    if DataModel.ChooseLeftData[row.eid] then
      Group_Equipment1.Btn_Cancel:SetActive(true)
      Group_Equipment1.Img_Choose:SetActive(true)
    end
    if DataModel.LeftChooseEquipData.eid and DataModel.LeftChooseEquipData.eid == row.eid then
      DataModel:ClickLeftEquipData(elementIndex)
    end
    row.element = element
  end,
  Group_Strengthen_Group_Left_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Item_Click = function(btn, str)
    DataModel:ClickLeftEquipData(str)
  end,
  Group_Strengthen_Group_Left_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Cancel_Click = function(btn, str)
    local row = DataModel.AllEquip[tonumber(str)]
    if DataModel.ChooseLeftData[row.eid] then
      if row.isItem == true and row.num > 1 then
        row.num = row.num - 1
        row.element.Group_Equipment1.Img_AddNum:SetActive(true)
        row.element.Group_Equipment1.Img_AddNum.Txt_Num:SetText(row.num)
        table.remove(DataModel.ChooseLeftDataIndexList, DataModel.ChooseLeftData[row.eid].index)
        DataModel:RefreshBottomEquipData()
        DataModel:Clear()
        DataModel:RefreshRightDownContent()
      else
        row.element.Group_Equipment1.Img_Choose:SetActive(false)
        row.element.Group_Equipment1.Btn_Cancel:SetActive(false)
        row.element.Group_Equipment1.Img_AddNum:SetActive(false)
        if row.isItem == true then
          row.num = 0
        end
        table.remove(DataModel.ChooseLeftDataIndexList, DataModel.ChooseLeftData[row.eid].index)
        DataModel.ChooseLeftData[row.eid] = nil
        if DataModel.LeftChooseEquipIndex ~= nil then
          local old_element = DataModel.AllEquip[DataModel.LeftChooseEquipIndex].element
          old_element.Group_Equipment1.Img_Select:SetActive(false)
          DataModel.LeftChooseEquipIndex = nil
        end
        local callback = function()
          View.self:PlayAnim("Close_Detail", function()
            View.Group_Detail.self:SetActive(false)
          end)
        end
        DataModel:SendEquipLockData(callback)
        DataModel:RefreshBottomEquipData()
        DataModel:Clear()
        DataModel:RefreshRightDownContent()
      end
    end
  end,
  Group_Strengthen_Group_Left_Btn_Search_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Left_Btn_Sort_Click = function(btn, str)
    DataModel:SortButton()
  end,
  Group_Strengthen_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Group_Strengthen_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Group_Strengthen_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Right_ScrollView_Content_Viewport_Content_Btn_Tips1_Click = function(btn, str)
    View.Group_Tips.self:SetActive(true)
    View.Btn_CloseTips:SetActive(true)
  end,
  Group_Strengthen_Group_Windows_Btn_Black_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_Btn_UseItem_Click = function(btn, str)
    DataModel:ClickGroupUseItem()
  end,
  Group_Strengthen_Group_Windows_Img_NoHaveChangeEntry_Btn_Tips1_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_Img_ItemChangeEntry_Group_Equipment1_Btn_Item_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_Img_ItemChangeEntry_Group_Equipment1_Btn_Cancel_Click = function(btn, str)
    DataModel:CloseGroupUseItem()
    DataModel:ClickGroupUseItem()
  end,
  Group_Strengthen_Group_Windows_ScrollGrid_Entry_SetGrid = function(element, elementIndex)
    DataModel:EntrySetGrid(element, elementIndex)
  end,
  Group_Strengthen_Group_Windows_ScrollGrid_Entry_Group_Item_Btn_Entry_Click = function(btn, str)
    DataModel:EntryClickSetGrid(str)
  end,
  Group_Strengthen_Group_Windows_Btn_Cancel_Click = function(btn, str)
    DataModel:CloseChangeWindows()
    if DataModel.IsSend == true then
      DataModel:InitEquipList()
      DataModel:RefreshRightContent()
    end
  end,
  Group_Strengthen_Group_Windows_Btn_Confirm_Click = function(btn, str)
    DataModel:ConfirmEntry()
  end,
  Group_Strengthen_Group_Detail_Btn_Close_Click = function(btn, str)
    local callback = function()
      View.self:PlayAnim("Close_Detail", function()
        View.Group_Detail.self:SetActive(false)
      end)
    end
    DataModel:SendEquipLockData(callback)
  end,
  Group_Strengthen_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Detail_Group_EXPEquip_Btn_Lock_Click = function(btn, str)
    local row = DataModel.SendLockList[DataModel.LeftChooseEquipData.eid]
    local row_left = DataModel.AllEquip[tonumber(DataModel.LeftChooseEquipIndex)]
    if row.is_locked == 1 then
      row.is_locked = 0
      PlayerData:GetEquipById(DataModel.LeftChooseEquipData.eid).is_locked = 0
      row_left.is_locked = 0
      row_left.element.Group_Equipment1.Img_Lock:SetActive(false)
      View.Group_Detail.Group_EXPEquip.Btn_Lock.Img_Lock:SetActive(false)
      View.Group_Detail.Group_EXPEquip.Btn_Lock.Img_Unlock:SetActive(true)
    else
      row.is_locked = 1
      PlayerData:GetEquipById(DataModel.LeftChooseEquipData.eid).is_locked = 1
      row_left.is_locked = 1
      row_left.element.Group_Equipment1.Img_Lock:SetActive(true)
      View.Group_Detail.Group_EXPEquip.Btn_Lock.Img_Lock:SetActive(true)
      View.Group_Detail.Group_EXPEquip.Btn_Lock.Img_Unlock:SetActive(false)
    end
    if row.is_locked == row.old_locked then
      row.isChange = 0
      DataModel.LeftChooseEquipData.isChange = 0
    else
      row.isChange = 1
      DataModel.LeftChooseEquipData.isChange = 1
    end
    if row.is_locked == 1 then
      local row = DataModel.AllEquip[tonumber(DataModel.LeftChooseEquipIndex)]
      if DataModel.ChooseLeftData[row.eid] then
        row.element.Group_Equipment1.Img_Choose:SetActive(false)
        row.element.Group_Equipment1.Btn_Cancel:SetActive(false)
        table.remove(DataModel.ChooseLeftDataIndexList, DataModel.ChooseLeftData[row.eid].index)
        DataModel.ChooseLeftData[row.eid] = nil
        DataModel:RefreshBottomEquipData()
      end
    end
  end,
  Group_Strengthen_Group_Detail_Group_EXPEquip_Btn_Tips_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Detail_Group_EXPEquip_ScrollView_Content_Viewport_Content_Btn_Tips1_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Right_Group_Money_Btn_GoldCoin_Click = function(btn, str)
  end,
  Group_Strengthen_Btn_CloseTips_Click = function(btn, str)
    if View.Group_Tips.self.IsActive == true then
      View.Group_Tips.self:SetActive(false)
    end
    if View.Group_SortRare.self.IsActive == true then
      ClickRightBtn()
    end
    View.Btn_CloseTips:SetActive(false)
  end,
  Group_Strengthen_Group_SortRare_Img_Glass_Img_Bg_StaticGrid_Rare_SetGrid = function(element, elementIndex)
    local row = DataModel.BtnList[tonumber(elementIndex)]
    element.Btn_Select:SetClickParam(elementIndex)
    element.Img_Select:SetActive(true)
    element.Img_Select.Txt_Detail:SetText(row.content)
    element.Img_Selected:SetActive(false)
    element.Img_Selected.Txt_Detail:SetText(row.content)
  end,
  Group_Strengthen_Group_SortRare_Img_Glass_Img_Bg_StaticGrid_Rare_Group_Rare_Btn_Select_Click = function(btn, str)
    DataModel:SelectBtnList(tonumber(str))
  end,
  Group_Strengthen_Group_SortRare_Group_Rare_Btn_Select_Click = function(btn, str)
  end,
  Group_Strengthen_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end,
  Group_Strengthen_Group_Windows_Txt_RemainingChangeNum_Btn_Tips_Click = function(btn, str)
    View.Group_Windows.Group_Tips.self:SetActive(true)
    View.Group_Windows.Btn_CloseTips:SetActive(true)
  end,
  Group_Strengthen_Group_Windows_Btn_CloseTips_Click = function(btn, str)
    View.Group_Windows.Group_Tips.self:SetActive(false)
    View.Group_Windows.Btn_CloseTips:SetActive(false)
  end,
  Group_Strengthen_Group_Windows_Group_UseItem_Btn_CancelItem_Click = function(btn, str)
    DataModel:CloseGroupUseItem()
  end,
  Group_Strengthen_Group_Windows_Group_UseItem_Btn_ConfirmItem_Click = function(btn, str)
    DataModel:UseItemEntry()
  end,
  Group_Strengthen_Group_Windows_Group_UseItem_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.UseItemList[tonumber(elementIndex)]
    local Group_Equipment1 = element.Group_Equipment1
    Group_Equipment1.Btn_Item:SetClickParam(elementIndex)
    Group_Equipment1.Btn_Cancel:SetClickParam(elementIndex)
    Group_Equipment1.Img_Item:SetSprite(row.itemCA.iconPath)
    Group_Equipment1.Img_Mask:SetSprite(UIConfig.MaskConfig[row.itemCA.qualityInt + 1])
    Group_Equipment1.Img_Bottom:SetSprite(UIConfig.BottomConfig[row.itemCA.qualityInt + 1])
    Group_Equipment1.Txt_EquipmentLevel:SetText(row.num)
    Group_Equipment1.Img_Select:SetActive(false)
    Group_Equipment1.Btn_Cancel:SetActive(false)
    Group_Equipment1.Group_Face:SetActive(false)
    Group_Equipment1.Img_Choose:SetActive(false)
    Group_Equipment1.Img_Lock:SetActive(false)
    Group_Equipment1.Img_NoType:SetActive(false)
    if DataModel.ChooseUseItemIndex and DataModel.ChooseUseItemIndex == tonumber(elementIndex) then
      Group_Equipment1.Img_Select:SetActive(true)
    end
    row.element = element
  end,
  Group_Strengthen_Group_Windows_Group_UseItem_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Item_Click = function(btn, str)
    DataModel:ChooseEquipItem(str)
  end,
  Group_Strengthen_Group_Windows_Group_UseItem_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Cancel_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Right_Group_Bar_ScrollGrid_Equipment_Group_Item_Group_Equipment_Btn_Cancel_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_Img_HaveChangeEntry_Btn_Del_Click = function(btn, str)
    DataModel:DelEnrty()
  end,
  Group_Strengthen_Group_Windows_ScrollGrid_Item_SetGrid = function(element, elementIndex)
  end,
  Group_Strengthen_Group_Windows_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Item_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Cancel_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_Btn_CancelItem_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_Btn_ConfirmItem_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_Btn_Tips_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Detail_Btn_Lock_Click = function(btn, str)
    local row = DataModel.SendLockList[DataModel.LeftChooseEquipData.eid]
    local row_left = DataModel.AllEquip[tonumber(DataModel.LeftChooseEquipIndex)]
    if row.is_locked == 1 then
      row.is_locked = 0
      PlayerData:GetEquipById(DataModel.LeftChooseEquipData.eid).is_locked = 0
      row_left.is_locked = 0
      row_left.element.Group_Equipment1.Img_Lock:SetActive(false)
      View.Group_Detail.Btn_Lock.Img_Lock:SetActive(false)
      View.Group_Detail.Btn_Lock.Img_Unlock:SetActive(true)
    else
      row.is_locked = 1
      PlayerData:GetEquipById(DataModel.LeftChooseEquipData.eid).is_locked = 1
      row_left.is_locked = 1
      row_left.element.Group_Equipment1.Img_Lock:SetActive(true)
      View.Group_Detail.Btn_Lock.Img_Lock:SetActive(true)
      View.Group_Detail.Btn_Lock.Img_Unlock:SetActive(false)
    end
    if row.is_locked == row.old_locked then
      row.isChange = 0
      DataModel.LeftChooseEquipData.isChange = 0
    else
      row.isChange = 1
      DataModel.LeftChooseEquipData.isChange = 1
    end
    if row.is_locked == 1 then
      local row = DataModel.AllEquip[tonumber(DataModel.LeftChooseEquipIndex)]
      if DataModel.ChooseLeftData[row.eid] then
        row.element.Group_Equipment1.Img_Choose:SetActive(false)
        row.element.Group_Equipment1.Btn_Cancel:SetActive(false)
        table.remove(DataModel.ChooseLeftDataIndexList, DataModel.ChooseLeftData[row.eid].index)
        DataModel.ChooseLeftData[row.eid] = nil
        DataModel:RefreshBottomEquipData()
      end
    end
  end,
  Group_Strengthen_Group_Detail_Btn_Tips_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Detail_ScrollView_Content_Viewport_Content_Btn_Tips1_Click = function(btn, str)
  end
}
return ViewFunction
