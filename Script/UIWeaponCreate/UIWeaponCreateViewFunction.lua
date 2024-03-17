local View = require("UIWeaponCreate/UIWeaponCreateView")
local DataModel = require("UIWeaponCreate/UIWeaponCreateDataModel")
local NPCDialog = require("Common/NPCDialog")
local CommonItem = require("Common/BtnItem")
local PlayNPCTalk = function(talk_type)
  local npcConfig = PlayerData:GetFactoryData(DataModel.NpcId, "NPCFactory")
  local textTable = npcConfig[talk_type]
  if textTable then
    NPCDialog.SetNPCText(View.Group_NPC, textTable, talk_type)
  end
end
local RefreshPanel = function()
  View.Group_Main.self:SetActive(true)
  View.Group_NPC.self:SetActive(true)
  View.Group_WeaponList.self:SetActive(false)
  View.Img_Backgroud:SetSprite(DataModel.BgPath)
  View.Img_Backgroud:SetColor("#" .. DataModel.BgColor)
  NPCDialog.SetNPC(View.Group_NPC, DataModel.NpcId)
  PlayNPCTalk("enterText")
  View.Group_Ding.Btn_YN.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
end
local RefreshCreateList = function()
  View.Group_WeaponList.Group_List.Group_Left.Img_Bg.Group_Page.StaticGrid_Page.grid.self:RefreshAllElement()
  local weaponList = DataModel.GetWeaponList()
  View.Group_WeaponList.Group_List.Group_Left.Img_Bg.ScrollGrid_Item.grid.self:SetDataCount(#weaponList)
  View.Group_WeaponList.Group_List.Group_Left.Img_Bg.ScrollGrid_Item.grid.self:RefreshAllElement()
  View.Group_WeaponList.Group_List.Group_Left.Img_Bg.ScrollGrid_Item.grid.self:MoveToTop()
  local weapon_list = DataModel.GetWeaponList()
  local data = weapon_list[DataModel.select_indx]
  View.self:StartC(LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
    View.Group_WeaponList.Group_List.Group_Right.NewScrollGrid_List.grid.self:SetDataCount(#data)
    View.Group_WeaponList.Group_List.Group_Right.NewScrollGrid_List.grid.self:RefreshAllElement()
    View.Group_WeaponList.Group_List.Group_Right.NewScrollGrid_List.grid.self:MoveToTop()
  end))
end
local RefreshTagInfo = function(lv)
  local weaponCA = PlayerData:GetFactoryData(DataModel.weapon_id)
  local height = 0
  local element = View.Group_WeaponList.Group_Create.Group_Right.ScrollView_Entry.Viewport.Content
  element:SetActive(false)
  element:SetActive(true)
  element.Group_MonsterType:SetActive(false)
  local contentHeight = 204
  if weaponCA.typeWeapon == 12600303 then
    element.Group_MonsterType:SetActive(true)
    local monsterList = PlayerData:GetFactoryData(99900044).monsterList
    local hitEventType = weaponCA.hitEventType
    local count = #monsterList
    for i = 1, count do
      local Group_Type = element.Group_MonsterType["Group_Type" .. i]
      local tagCa = PlayerData:GetFactoryData(monsterList[i].id)
      if Group_Type then
        Group_Type.Img_Type.Img_Icon:SetSprite(tagCa.icon)
        Group_Type.Img_Type.Txt_Name:SetText(tagCa.tagName)
        Group_Type:SetAlpha(0.4)
        for i1, v1 in ipairs(hitEventType) do
          if v1.id == monsterList[i].id then
            Group_Type:SetAlpha(1)
            break
          end
        end
      end
    end
  end
  local normalEntryListCnt = #weaponCA.normalEntryList
  if 0 < normalEntryListCnt then
    height = height + 28
  end
  element.Group_BaseTitle:SetActive(0 < normalEntryListCnt)
  for i = 1, 2 do
    local baseEntry = element.Group_BaseTitle["Group_BaseEntry" .. i]
    baseEntry:SetActive(i <= normalEntryListCnt)
    if i <= normalEntryListCnt then
      local affixInfo = weaponCA.normalEntryList[i]
      if affixInfo then
        local ca = PlayerData:GetFactoryData(affixInfo.id, "TrainWeaponSkillFactory")
        local value = math.floor(ca.Constant * ca.CommonNum)
        local tagCa = PlayerData:GetFactoryData(ca.entryTag)
        local icon = tagCa.icon
        baseEntry.Img_Icon:SetSprite(icon)
        baseEntry.Txt_Entry:SetText(ca.name)
        value = ca.entryTag == 12600368 and string.format("-%dkm/h", value) or value
        baseEntry.Img_Num.Txt_Num:SetText(value)
        local txtHeight = 56
        height = height + txtHeight
      else
        baseEntry:SetActive(false)
      end
    end
  end
  element.Group_BaseTitle:SetHeight(height)
  contentHeight = contentHeight + height + 10
  height = 0
  local growUpEntryListCount = #weaponCA.growUpEntryList
  if 0 < growUpEntryListCount then
    height = height + 28
  end
  element.Group_SpecialTitle:SetActive(0 < growUpEntryListCount)
  for i = 1, 4 do
    local specialEntry = element.Group_SpecialTitle["Group_SpecialEntry" .. i]
    specialEntry:SetActive(i <= growUpEntryListCount)
    if i <= growUpEntryListCount then
      local affixInfo = weaponCA.growUpEntryList[i]
      if affixInfo then
        local ca = PlayerData:GetFactoryData(affixInfo.id, "TrainWeaponSkillFactory")
        local valueA, valueB
        if ca.aTypeInt == 1 then
          valueA = ca.aNumMinP
          if ca.aDevelopment then
            valueA = (ca.aNumMinP + lv * ca.aUpgradeRangeP) * ca.aCommonNumP
          else
            valueA = valueA * ca.aCommonNumP
          end
        else
          valueA = ca.aNumMin
          if ca.aDevelopment then
            valueA = (ca.aNumMin + lv * ca.aUpgradeRange) * ca.aCommonNum
          else
            valueA = valueA * ca.aCommonNum
          end
        end
        if ca.bTypeInt == 1 then
          valueB = ca.bNumMinP
          if ca.bDevelopment then
            valueB = (ca.bNumMinP + lv * ca.bUpgradeRangeP) * ca.bCommonNumP
          else
            valueB = valueB * ca.bCommonNumP
          end
        else
          valueB = ca.bNumMin
          if ca.bDevelopment then
            valueB = (ca.bNumMin + lv * ca.bUpgradeRange) * ca.bCommonNum
          else
            valueB = valueB * ca.bCommonNum
          end
        end
        valueA = DataModel.FormatNum(valueA)
        valueB = DataModel.FormatNum(valueB)
        specialEntry.Txt_Entry:SetText("<color=#D2B075>" .. ca.name .. "</color>　" .. string.format(ca.text, valueA, valueB))
        local txtHeight = specialEntry.Txt_Entry:GetHeight()
        height = height + txtHeight + 20
        specialEntry.Txt_Entry:SetHeight(txtHeight)
        specialEntry:SetHeight(txtHeight)
      else
        specialEntry:SetActive(false)
      end
    end
  end
  element:SetActive(false)
  element.Group_SpecialTitle:SetHeight(height)
  element:SetActive(true)
  contentHeight = contentHeight + height
  View.Group_WeaponList.Group_Create.Group_Right.ScrollView_Entry:SetContentHeight(contentHeight)
  View.Group_WeaponList.Group_Create.Group_Right.ScrollView_Entry:SetVerticalNormalizedPosition(1)
end
local OpenWeaponCreatePanel = function(weapon_id)
  View.self:PlayAnimOnce("In_Create", function()
    View.Group_WeaponList.Group_List:SetActive(false)
  end)
  View.Group_WeaponList.Group_Create:SetActive(true)
  DataModel.weapon_id = weapon_id
  local cfg = PlayerData:GetFactoryData(DataModel.weapon_id)
  DataModel.cost_list = cfg.TrainWeaponMakeUp or {}
  View.Group_WeaponList.Group_Create.Group_Left.StaticGrid_Item.grid.self:RefreshAllElement()
  local icon = string.format(DataModel.qualitBasePath, DataModel.qualityMap[cfg.quality])
  View.Group_WeaponList.Group_Create.Group_Left.Group_RareAndName.Img_Rare:SetSprite(icon)
  View.Group_WeaponList.Group_Create.Group_Left.Group_RareAndName.Txt_Name:SetText(cfg.name)
  View.Group_WeaponList.Group_Create.Group_Left.Img_Circle.Img_Weapon:SetSprite(cfg.tipsPath)
  local tagCfg = PlayerData:GetFactoryData(cfg.typeWeapon)
  View.Group_WeaponList.Group_Create.Group_Left.Img_Type.Txt_Type:SetText(tagCfg.tagName)
  View.Group_WeaponList.Group_Create.Group_Right.Btn_Button.Img_ON:SetActive(false)
  View.Group_WeaponList.Group_Create.Group_Right.Btn_Button.Img_OFF:SetActive(true)
  RefreshTagInfo(0)
  local cost = cfg.goldCost or 0
  local color = "#FFFFFF"
  local enough = DataModel.MaterialIsEnough(weapon_id)
  View.Group_WeaponList.Group_Create.Group_Right.Btn_Build.Img_Shadow:SetActive(not enough)
  if PlayerData:GetUserInfo().gold < cfg.goldCost then
    color = "#E76666"
  end
  View.Group_WeaponList.Group_Create.Group_Right.Btn_Build.Txt_Gold:SetText(cost)
  View.Group_WeaponList.Group_Create.Group_Right.Btn_Build.Txt_Gold:SetColor(color)
end
local ViewFunction = {
  WeaponCreate_Group_Main_Btn_Talk_Click = function(btn, str)
    PlayNPCTalk("talkText")
  end,
  WeaponCreate_Group_Main_Btn_Create_Click = function(btn, str)
    View.Group_WeaponList:SetActive(true)
    View.Group_Main.self:SetActive(false)
    View.Group_NPC.self:SetActive(false)
    View.Group_WeaponList.Group_List:SetActive(true)
    View.Group_WeaponList.Group_Create:SetActive(false)
    DataModel.SetSelectTab(1, 1)
    RefreshCreateList()
    View.self:PlayAnimOnce("WeaponCreat_Main")
  end,
  WeaponCreate_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.Group_WeaponList.Group_List:SetActive(true)
    if View.Group_WeaponList.Group_Create.IsActive then
      View.self:PlayAnimOnce("Out_Create", function()
        View.Group_WeaponList.Group_Create:SetActive(false)
      end)
    elseif View.Group_WeaponList.Group_List.IsActive then
      View.Group_Main.self:SetActive(true)
      View.Group_NPC.self:SetActive(true)
      View.self:PlayAnimOnce("WeaponCreat_Out", function()
        View.Group_WeaponList:SetActive(false)
        PlayNPCTalk("enterText")
      end)
    else
      UIManager:GoBack()
    end
  end,
  WeaponCreate_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  WeaponCreate_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  WeaponCreate_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  WeaponCreate_Btn_Skip_Click = function(btn, str)
  end,
  WeaponCreate_Group_Ding_Btn_YN_Click = function(btn, str)
  end,
  WeaponCreate_Group_Ding_Btn_YN_Btn_Add_Click = function(btn, str)
  end,
  WeaponCreate_Group_WeaponList_Group_List_Group_Left_Img_Bg_Group_Page_StaticGrid_Page_SetGrid = function(element, elementIndex)
    element.Btn_Page.Img_OFF:SetActive(DataModel.tab_indx ~= elementIndex)
    element.Btn_Page.Img_ON:SetActive(DataModel.tab_indx == elementIndex)
    element.Btn_Page:SetClickParam(elementIndex)
    local cfg = PlayerData:GetFactoryData(DataModel.tabList[elementIndex].id)
    element.Btn_Page.Img_OFF.Txt_OFF:SetText(cfg.tagName)
    element.Btn_Page.Img_ON.Txt_ON:SetText(cfg.tagName)
  end,
  WeaponCreate_Group_WeaponList_Group_List_Group_Left_Img_Bg_Group_Page_StaticGrid_Page_Group_Page_Btn_Page_Click = function(btn, str)
    DataModel.SetSelectTab(tonumber(str))
    RefreshCreateList()
  end,
  WeaponCreate_Group_WeaponList_Group_Create_Group_Left_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local item = element.Group_Item
    local data = DataModel.cost_list[elementIndex]
    if data then
      item:SetActive(true)
      CommonItem:SetItem(item, {
        id = data.id,
        num = data.num
      }, EnumDefine.ItemType.Item)
      item.Txt_Num:SetActive(false)
      local material_type = DataManager:GetFactoryNameById(data.id) == "HomeWeaponFactory" and 2 or 1
      local count = DataModel.SearchMaterialCount(data.id, material_type)
      local need_count = DataModel.cost_list[elementIndex].num
      local color_info = count >= need_count and "#FFFFF" or "#E76666"
      item.Group_Num.Txt_Need:SetText(need_count)
      item.Group_Num.Txt_Have:SetColor(color_info)
      item.Group_Num.Txt_Have:SetText(count)
      item.Btn_Item:SetClickParam(data.id)
    else
      item:SetActive(false)
    end
  end,
  WeaponCreate_Group_WeaponList_Group_Create_Group_Left_StaticGrid_Item_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenRewardDetail(tonumber(str))
  end,
  WeaponCreate_Group_WeaponList_Group_List_Group_Left_Img_Bg_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local weapon_list = DataModel.GetWeaponList()
    local weapon_id = weapon_list[elementIndex][1].id
    local cfg = PlayerData:GetFactoryData(weapon_id)
    element.Btn_Button:SetClickParam(elementIndex)
    local item = element.Img_WeaponItem.Group_WeaponItem
    item.Img_Mask.Img_Item:SetSprite(cfg.tipsPath)
    local icon = string.format(DataModel.qualitBasePath, DataModel.qualityMap[cfg.quality])
    item.Img_Rare:SetSprite(icon)
    element.Img_Select:SetActive(DataModel.select_indx == elementIndex)
    item.Txt_Name:SetText(cfg.name)
    element.Btn_Button:SetClickParam(elementIndex)
    local tagCfg = PlayerData:GetFactoryData(cfg.typeWeapon)
    item.Group_Type.Img_Type:SetSprite(tagCfg.icon)
    item.Group_Type.Txt_Type:SetText(tagCfg.tagName)
  end,
  WeaponCreate_Group_WeaponList_Group_List_Group_Left_Img_Bg_ScrollGrid_Item_Group_Item_Btn_Button_Click = function(btn, str)
    DataModel.select_indx = tonumber(str)
    View.Group_WeaponList.Group_List.Group_Left.Img_Bg.ScrollGrid_Item.grid.self:RefreshAllElement()
    View.Group_WeaponList.Group_List.Group_Left.Img_Bg.ScrollGrid_Item.grid.self:MoveToTop()
    View.Group_WeaponList.Group_List.Group_Right.NewScrollGrid_List.grid.self:RefreshAllElement()
    View.Group_WeaponList.Group_List.Group_Right.NewScrollGrid_List.grid.self:MoveToTop()
  end,
  WeaponCreate_Group_WeaponList_Group_Create_Group_Right_Btn_Button_Click = function(btn, str)
    local lv = 0
    if View.Group_WeaponList.Group_Create.Group_Right.Btn_Button.Img_ON.IsActive then
      View.Group_WeaponList.Group_Create.Group_Right.Btn_Button.Img_ON:SetActive(false)
      View.Group_WeaponList.Group_Create.Group_Right.Btn_Button.Img_OFF:SetActive(true)
    else
      View.Group_WeaponList.Group_Create.Group_Right.Btn_Button.Img_ON:SetActive(true)
      View.Group_WeaponList.Group_Create.Group_Right.Btn_Button.Img_OFF:SetActive(false)
      lv = DataModel.maxLevel
    end
    RefreshTagInfo(lv)
  end,
  WeaponCreate_Group_WeaponList_Group_Create_Group_Right_Btn_Build_Click = function(btn, str)
    local can_synthetic = true
    local costWeaponkey
    for k, v in pairs(DataModel.cost_list) do
      local material_type = DataManager:GetFactoryNameById(v.id) == "HomeWeaponFactory" and 2 or 1
      local count = DataModel.SearchMaterialCount(v.id, material_type)
      if count < v.num then
        can_synthetic = false
        break
      end
      if material_type == 2 then
        costWeaponkey = DataModel.FindWeaponKey(v.id)
      end
    end
    local cfg = PlayerData:GetFactoryData(DataModel.weapon_id)
    local cost = cfg.goldCost or 0
    if cost > PlayerData:GetUserInfo().gold then
      can_synthetic = false
    end
    if costWeaponkey then
      local isEquipment = DataModel.WeaponIsEquipment(costWeaponkey)
      if isEquipment == true then
        CommonTips.OnPrompt(GetText(80602309), nil, nil, function()
          local CarriageDataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
          local t = {
            CurrTag = CarriageDataModel.TagType.Weapon
          }
          CommonTips.OpenToHomeCarriageeditor(t)
        end)
        return
      end
    end
    if can_synthetic then
      Net:SendProto("home.make_train_weapon", function(json)
        local weaponId = DataModel.weapon_id
        SdkReporter.TrackTrainWep({wepId = weaponId})
        local reward = {}
        reward.item = {}
        for k, v in pairs(json.battery) do
          reward.item[v.id] = {num = 1}
          DataModel.UpdateWeaponMadelist(v.id)
        end
        for k, v in pairs(json.rewards or {}) do
          reward[k] = v
        end
        DataModel.UpdateSyntheticList(json.battery, costWeaponkey)
        for k, v in pairs(DataModel.cost_list) do
          if v.id ~= cost_weapon and v.id ~= 11400001 then
            local num = PlayerData:GetGoodsById(v.id).num
            PlayerData:GetGoodsById(v.id).num = num - v.num
          end
        end
        View.Group_Ding.Btn_YN.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
        View.Group_WeaponList.Group_Create.Group_Left.StaticGrid_Item.grid.self:RefreshAllElement()
        View.Group_WeaponList.Group_List.Group_Right.NewScrollGrid_List.grid.self:RefreshAllElement()
        local color = "#FFFFFF"
        local enough = DataModel.MaterialIsEnough(DataModel.weapon_id)
        View.Group_WeaponList.Group_Create.Group_Right.Btn_Build.Img_Shadow:SetActive(not enough)
        if PlayerData:GetUserInfo().gold < cfg.goldCost then
          color = "#E76666"
        end
        View.Group_WeaponList.Group_Create.Group_Right.Btn_Build.Txt_Gold:SetColor(color)
        CommonTips.OpenShowItem(reward, function()
          if DataModel.tab_indx == 1 then
            CommonTips.OnPrompt(GetText(80601516), nil, nil, function()
              local CarriageDataModel = require("UIHomeCarriageeditor/UIHomeCarriageeditorDataModel")
              local t = {
                CurrTag = CarriageDataModel.TagType.Weapon
              }
              CommonTips.OpenToHomeCarriageeditor(t)
            end)
          end
        end)
      end, DataModel.weapon_id, costWeaponkey)
    else
      CommonTips.OpenTips(80601046)
    end
  end,
  WeaponCreate_Group_WeaponList_Group_List_Group_Right_NewScrollGrid_List_SetGrid = function(element, elementIndex)
    local weapon_list = DataModel.GetWeaponList()
    local data = weapon_list[DataModel.select_indx][elementIndex]
    element:SetActive(false)
    if data == nil then
      return
    end
    element:SetActive(true)
    local weapon_id = data.id
    local cfg = PlayerData:GetFactoryData(weapon_id)
    element.Group_WeaponItem.Img_Mask.Img_Item:SetSprite(cfg.tipsPath)
    local icon = string.format(DataModel.qualitBasePath, DataModel.qualityMap[cfg.quality])
    element.Group_WeaponItem.Img_Rare:SetSprite(icon)
    element.Group_WeaponItem.Txt_Name:SetText(cfg.name)
    element.Group_WeaponItem.Btn_Button:SetClickParam(weapon_id)
    local tagCfg = PlayerData:GetFactoryData(cfg.typeWeapon)
    element.Group_WeaponItem.Group_Type.Img_Type:SetSprite(tagCfg.icon)
    element.Group_WeaponItem.Group_Type.Txt_Type:SetText(tagCfg.tagName)
    local enough = DataModel.MaterialIsEnough(weapon_id)
    element.Group_WeaponItem.Img_Shadow:SetActive(not enough)
    local color = "#7F7F7F"
    if enough then
      color = "#FFFFFF"
    end
    element.Group_WeaponItem.Img_Mask.Img_Item:SetColor(color)
    element.Group_WeaponItem.Img_Line:SetActive(elementIndex ~= 1)
    local unlock = DataModel.WeaponIsMade(cfg.WeaponLow)
    element.Group_WeaponItem.Img_Qianzhi:SetActive(not unlock)
    if unlock == false then
      element.Group_WeaponItem.Img_Shadow:SetActive(false)
      local frontWeaponCfg = PlayerData:GetFactoryData(cfg.WeaponLow)
      element.Group_WeaponItem.Img_Qianzhi.Txt_Tips:SetText(string.format(GetText(80602440), frontWeaponCfg.name))
    end
  end,
  WeaponCreate_Group_WeaponList_Group_List_Group_Right_NewScrollGrid_List_Group_Item_Group_WeaponItem_Btn_Button_Click = function(btn, str)
    local weapon_id = tonumber(str)
    local cfg = PlayerData:GetFactoryData(weapon_id)
    local unlock = DataModel.WeaponIsMade(cfg.WeaponLow)
    if unlock then
      OpenWeaponCreatePanel(weapon_id)
    else
      local frontWeaponCfg = PlayerData:GetFactoryData(cfg.WeaponLow)
      CommonTips.OpenTips(string.format(GetText(80602440), frontWeaponCfg.name))
    end
  end,
  RefreshPanel = RefreshPanel,
  WeaponCreate_Group_WeaponList_Group_List_Group_Left_Img_Bg_Group_Page_Group_Page_Btn_Page_Click = function(btn, str)
  end,
  WeaponCreate_Group_WeaponList_Group_Create_Group_Left_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end
}
return ViewFunction
