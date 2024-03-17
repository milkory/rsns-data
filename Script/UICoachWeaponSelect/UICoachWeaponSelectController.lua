local View = require("UICoachWeaponSelect/UICoachWeaponSelectView")
local DataModel = require("UICoachWeaponSelect/UICoachWeaponSelectDataModel")
local BtnItem = require("Common/BtnItem")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  Controller:ShowTopElectric()
  local curShowType = DataModel.ShowType.Other
  if DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Weapon then
    curShowType = DataModel.ShowType.Train
  end
  DataModel.FirstIn = true
  Controller:SelectTrainOrOther(curShowType)
  DataModel.FirstIn = false
end

function Controller:ShowTopElectric()
  View.Img_HaveelectricBg:SetActive(true)
  View.Img_HaveelectricBg.Txt_Num:SetText(PlayerData:GetHomeInfo().electric_used .. "/" .. PlayerData.GetMaxElectric())
end

function Controller:ShowTrainWeapon(isShow)
  View.Group_SelectWindows.Group_Bottom.Group_TrainHead:SetActive(isShow)
  View.Group_SelectWindows.Group_Bottom.Img_Line1:SetActive(isShow)
  View.Group_SelectWindows.Group_Bottom.Group_Carriage:SetActive(isShow)
  View.Group_SelectWindows.Group_Bottom.Group_SortButton.Btn_Weapon.Img_ON:SetActive(isShow)
  View.Group_SelectWindows.Group_Bottom.Group_SortButton.Btn_Weapon.Img_OFF:SetActive(not isShow)
  if isShow then
    DataModel.toWeaponPosInfo.type = DataModel.WeaponType.Weapon
    local coachIdx = DataModel.FirstIn and DataModel.toWeaponPosInfo.coachIdx or 0
    local weaponIdx = DataModel.FirstIn and DataModel.toWeaponPosInfo.weaponIdx or 1
    Controller:ClickTrainWeaponElement(coachIdx, weaponIdx)
  end
end

function Controller:ShowOtherWeapon(isShow)
  View.Group_SelectWindows.Group_Bottom.Group_Accessory:SetActive(isShow)
  View.Group_SelectWindows.Group_Bottom.Img_Line2:SetActive(isShow)
  View.Group_SelectWindows.Group_Bottom.Group_Pendant:SetActive(isShow)
  View.Group_SelectWindows.Group_Bottom.Group_SortButton.Btn_Annex.Img_ON:SetActive(isShow)
  View.Group_SelectWindows.Group_Bottom.Group_SortButton.Btn_Annex.Img_OFF:SetActive(not isShow)
  if isShow then
    DataModel.toWeaponPosInfo.coachUid = nil
    local weaponType = DataModel.FirstIn and DataModel.toWeaponPosInfo.type or DataModel.WeaponType.Parts
    local weaponIdx = DataModel.FirstIn and DataModel.toWeaponPosInfo.weaponIdx or 1
    if weaponType == DataModel.WeaponType.Parts then
      Controller:ClickPartsWeaponElement(weaponIdx)
    elseif weaponType == DataModel.WeaponType.Pendant then
      Controller:ClickPendantWeaponElement(weaponIdx)
    end
  end
end

function Controller:RefreshTrainWeaponElement(element, elementIndex, weaponIdx)
  local weaponUid = ""
  if elementIndex == 0 then
    local coach = PlayerData:GetHomeInfo().coach[1]
    weaponUid = coach.battery[weaponIdx] or ""
  else
    local coach = PlayerData:GetHomeInfo().coach[elementIndex + 1]
    if coach == nil then
      element:SetActive(false)
      return
    end
    weaponUid = coach.battery[weaponIdx] or ""
    element.Img_AddBg.Txt_Number:SetText(string.format("%2d", elementIndex + 1))
    element.Img_Empty.Txt_Number:SetText(string.format("%2d", elementIndex + 1))
    local coachCA = PlayerData:GetFactoryData(coach.id, "HomeCoachFactory")
    local isCanWeapon = 0 < #coachCA.weaponTypeList
    element.Img_AddBg:SetActive(isCanWeapon)
    element.Img_Empty:SetActive(not isCanWeapon)
  end
  element:SetActive(true)
  element:SetClickParam(elementIndex)
  element.Group_Item:SetActive(weaponUid ~= "")
  if weaponUid ~= "" then
    local weaponInfo = PlayerData:GetBattery()[weaponUid]
    BtnItem:SetItem(element.Group_Item, {
      id = weaponInfo.id
    })
  end
  element.Img_SelectA:SetActive(elementIndex == DataModel.curSelectBottomIdx and DataModel.toWeaponPosInfo.weaponIdx == weaponIdx)
end

function Controller:RefreshOtherWeaponElement(element, elementIndex, type)
  local weaponUid = ""
  local info
  if type == DataModel.WeaponType.Parts then
    weaponUid = PlayerData:GetHomeInfo().train_accessories[elementIndex] or ""
    info = DataModel.partsInfo
  elseif type == DataModel.WeaponType.Pendant then
    weaponUid = PlayerData:GetHomeInfo().train_pendant[elementIndex] or ""
    info = DataModel.pendantInfo
  end
  local detailInfo = info[elementIndex]
  if type == DataModel.WeaponType.Pendant then
    local electric_lv = PlayerData:GetHomeInfo().electric_lv
    local needLv = info[elementIndex].needElectricLv
    if electric_lv < needLv then
      detailInfo = nil
    end
  end
  element.Group_Empty:SetActive(detailInfo == nil)
  element.Group_Have:SetActive(detailInfo ~= nil)
  element.Group_Have.Btn_Zhaozi:SetClickParam(elementIndex)
  element.Group_Empty.Btn_Empty:SetClickParam(elementIndex)
  if detailInfo == nil then
    detailInfo = info[1]
    local tagCA = PlayerData:GetFactoryData(detailInfo.weaponTypeId, "TagFactory")
    element.Txt_Name:SetText(tagCA.tagName)
    return
  end
  element:SetActive(true)
  local tagCA = PlayerData:GetFactoryData(detailInfo.weaponTypeId, "TagFactory")
  element.Txt_Name:SetText(tagCA.tagName)
  element.Group_Have.Img_Use:SetActive(weaponUid == "")
  element.Group_Have.Group_Item:SetActive(weaponUid ~= "")
  if weaponUid ~= "" then
    local weaponInfo = PlayerData:GetBattery()[weaponUid]
    BtnItem:SetItem(element.Group_Have.Group_Item, {
      id = weaponInfo.id
    })
  end
  element.Img_Select:SetActive(elementIndex == DataModel.curSelectBottomIdx and type == DataModel.toWeaponPosInfo.type)
end

function Controller:ClickTrainWeaponElement(elementIndex, weaponIdx)
  local coachUid = PlayerData:GetHomeInfo().coach_template[elementIndex + 1]
  local coachId = PlayerData:GetHomeInfo().coach_store[coachUid].id
  local coachCA = PlayerData:GetFactoryData(coachId, "HomeCoachFactory")
  if #coachCA.weaponTypeList == 0 then
    CommonTips.OpenTips(80601650)
    return
  end
  DataModel.toWeaponPosInfo.coachUid = coachUid
  DataModel.toWeaponPosInfo.coachId = coachId
  DataModel.toWeaponPosInfo.weaponIdx = weaponIdx
  DataModel.curSelectBottomIdx = elementIndex
  Controller:RefreshTrainWeaponElement(View.Group_SelectWindows.Group_Bottom.Group_TrainHead.Btn_Add1, 0, 1)
  Controller:RefreshTrainWeaponElement(View.Group_SelectWindows.Group_Bottom.Group_TrainHead.Btn_Add2, 0, 2)
  View.Group_SelectWindows.Group_Bottom.Group_Carriage.StaticGrid_Add.grid.self:RefreshAllElement()
  Controller:GeneralClickBottom()
end

function Controller:ClickPartsWeaponElement(elementIndex)
  DataModel.toWeaponPosInfo.type = DataModel.WeaponType.Parts
  DataModel.toWeaponPosInfo.weaponIdx = elementIndex
  DataModel.curSelectBottomIdx = elementIndex
  View.Group_SelectWindows.Group_Bottom.Group_Accessory.StaticGrid_Accessory.grid.self:RefreshAllElement()
  View.Group_SelectWindows.Group_Bottom.Group_Pendant.StaticGrid_Pendant.grid.self:RefreshAllElement()
  Controller:GeneralClickBottom()
end

function Controller:ClickPendantWeaponElement(elementIndex)
  local electric_lv = PlayerData:GetHomeInfo().electric_lv
  local needLv = DataModel.pendantInfo[elementIndex].needElectricLv
  if electric_lv < needLv then
    CommonTips.OpenTips(string.format(GetText(80602116), needLv))
    return
  end
  DataModel.toWeaponPosInfo.type = DataModel.WeaponType.Pendant
  DataModel.toWeaponPosInfo.weaponIdx = elementIndex
  DataModel.toWeaponPosInfo.coachUid = coachUid
  DataModel.curSelectBottomIdx = elementIndex
  View.Group_SelectWindows.Group_Bottom.Group_Accessory.StaticGrid_Accessory.grid.self:RefreshAllElement()
  View.Group_SelectWindows.Group_Bottom.Group_Pendant.StaticGrid_Pendant.grid.self:RefreshAllElement()
  Controller:GeneralClickBottom()
end

function Controller:GeneralClickBottom()
  local typeWeaponId = 0
  DataModel.curSelectIdx = 1
  DataModel.curWeaponIngInfo = DataModel.GetCurWeaponInfo()
  DataModel.curShowBagInfo, typeWeaponId = DataModel.GetCurShowBagInfo()
  local tagCA = PlayerData:GetFactoryData(typeWeaponId, "TagFactory")
  View.Group_SelectWindows.Group_Left.Group_Title.Txt_TypeName:SetText(tagCA.tagName)
  DataModel.SortTrainWeaponBag(DataModel.curShowBagInfo, DataModel.curSortType)
  View.Group_SelectWindows.Group_Left.ScrollGrid_TrainWeapon.grid.self:SetDataCount(#DataModel.curShowBagInfo)
  View.Group_SelectWindows.Group_Left.ScrollGrid_TrainWeapon.grid.self:RefreshAllElement()
  Controller:ShowRightDetailPanel()
end

function Controller:SelectTrainOrOther(type)
  Controller:ShowTrainWeapon(type == DataModel.ShowType.Train)
  Controller:ShowOtherWeapon(type == DataModel.ShowType.Other)
end

function Controller:ShowRightDetailPanel()
  View.Group_SelectWindows.Group_Right.Group_Button.Btn_All.Img_Change:SetActive(false)
  View.Group_SelectWindows.Group_Right.Group_Button.Btn_All.Img_Remove:SetActive(false)
  View.Group_SelectWindows.Group_Right.Group_Button.Btn_All.Img_Use:SetActive(false)
  local info = DataModel.curShowBagInfo[DataModel.curSelectIdx]
  local isSelected = info ~= nil
  View.Group_SelectWindows.Group_Center.Group_Rare:SetActive(isSelected)
  View.Group_SelectWindows.Group_Center.Img_Weapon:SetActive(isSelected)
  View.Group_SelectWindows.Group_Center.Txt_CarriageNumber:SetActive(isSelected)
  View.Group_SelectWindows.Group_Center.Img_CoreBase:SetActive(isSelected)
  View.Group_SelectWindows.Group_Right.Group_RareTag:SetActive(isSelected)
  View.Group_SelectWindows.Group_Right.Group_NameAndLevel:SetActive(isSelected)
  View.Group_SelectWindows.Group_Right.Group_Entry:SetActive(isSelected)
  View.Group_SelectWindows.Group_Right.Group_Button:SetActive(isSelected)
  if isSelected then
    local weaponCA = PlayerData:GetFactoryData(info.id, "HomeWeaponFactory")
    View.Group_SelectWindows.Group_Center.Img_CoreBase.StaticGrid_Type.grid.self:RefreshAllElement()
    if DataModel.curWeaponIngInfo ~= nil and DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Weapon and DataModel.curWeaponIngInfo.uid == info.uid then
      View.Group_SelectWindows.Group_Center.Txt_CarriageNumber:SetActive(true)
      local showText
      if DataModel.curSelectBottomIdx == 0 then
        showText = GetText(80601649)
      else
        showText = string.format(GetText(80601580), elementIndex + 1)
      end
      View.Group_SelectWindows.Group_Center.Txt_CarriageNumber:SetText(showText)
    else
      View.Group_SelectWindows.Group_Center.Txt_CarriageNumber:SetActive(false)
    end
    local element = View.Group_SelectWindows.Group_Center.Group_Rare
    for i = 1, 5 do
      local imgQuality = element["Img_" .. i]
      imgQuality:SetActive(i == weaponCA.qualityInt + 1)
    end
    View.Group_SelectWindows.Group_Center.Img_Weapon:SetSprite(weaponCA.tipsPath)
    View.Group_SelectWindows.Group_Center.Txt_Detail:SetText(weaponCA.des)
    element = View.Group_SelectWindows.Group_Right.Group_RareTag
    for i = 1, 5 do
      local rareTag = element["Img_" .. i]
      rareTag:SetActive(i == weaponCA.qualityInt + 1)
    end
    View.Group_SelectWindows.Group_Right.Group_NameAndLevel.Txt_Name:SetText(weaponCA.name)
    View.Group_SelectWindows.Group_Right.Group_NameAndLevel.Group_Leve.Txt_Level:SetText(info.serverInfo.lv)
    local height = 0
    element = View.Group_SelectWindows.Group_Right.Group_Entry.ScrollView_Entry.Viewport.Content
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
              valueA = (ca.aNumMinP + info.serverInfo.lv * ca.aUpgradeRangeP) * ca.aCommonNumP
            else
              valueA = valueA * ca.aCommonNumP
            end
          else
            valueA = ca.aNumMin
            if ca.aDevelopment then
              valueA = (ca.aNumMin + info.serverInfo.lv * ca.aUpgradeRange) * ca.aCommonNum
            else
              valueA = valueA * ca.aCommonNum
            end
          end
          if ca.bTypeInt == 1 then
            valueB = ca.bNumMinP
            if ca.bDevelopment then
              valueB = (ca.bNumMinP + info.serverInfo.lv * ca.bUpgradeRangeP) * ca.bCommonNumP
            else
              valueB = valueB * ca.bCommonNumP
            end
          else
            valueB = ca.bNumMin
            if ca.bDevelopment then
              valueB = (ca.bNumMin + info.serverInfo.lv * ca.bUpgradeRange) * ca.bCommonNum
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
    View.Group_SelectWindows.Group_Right.Group_Entry.ScrollView_Entry:SetContentHeight(contentHeight)
    View.Group_SelectWindows.Group_Right.Group_Entry.ScrollView_Entry:SetVerticalNormalizedPosition(1)
    if DataModel.curWeaponIngInfo == nil then
      View.Group_SelectWindows.Group_Right.Group_Button.Btn_All.Img_Use:SetActive(true)
      DataModel.curSelWeaponOperatorType = DataModel.OperatorType.Use
    elseif info.uid == DataModel.curWeaponIngInfo.uid then
      View.Group_SelectWindows.Group_Right.Group_Button.Btn_All.Img_Remove:SetActive(true)
      DataModel.curSelWeaponOperatorType = DataModel.OperatorType.Remove
    else
      View.Group_SelectWindows.Group_Right.Group_Button.Btn_All.Img_Change:SetActive(true)
      DataModel.curSelWeaponOperatorType = DataModel.OperatorType.Change
    end
  end
  View.Group_SelectWindows.Group_Right.Group_Button.Btn_Level.self:SetActive(true)
end

function Controller:ClickWeaponOperatorBtn()
  local info = DataModel.curShowBagInfo[DataModel.curSelectIdx]
  if info == nil then
    return
  end
  local weaponCA = PlayerData:GetFactoryData(info.id, "HomeWeaponFactory")
  local needCoreList = weaponCA.coreList
  for i, v in ipairs(needCoreList) do
    local nowLv = PlayerData.ServerData.engines[tostring(v.id)].lv
    if nowLv < v.level then
      CommonTips.OpenTips(80602171)
      return
    end
  end
  local isUnset = 0
  if DataModel.curSelWeaponOperatorType == DataModel.OperatorType.Remove then
    isUnset = 1
  end
  local used = false
  if info.serverInfo.u_cid ~= nil and info.serverInfo.u_cid ~= "" then
    used = true
  end
  if not used then
    for i, id in ipairs(PlayerData:GetHomeInfo().train_pendant) do
      if info.uid == id then
        used = true
        break
      end
    end
  end
  local doWeaponOperator = function()
    local usedWeaponElectricCost = 0
    local newWeaponElectricCost = 0
    if DataModel.curWeaponIngInfo then
      usedWeaponElectricCost = TrainWeaponTag.GetOneWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.ElectricCost, DataModel.curWeaponIngInfo.uid, 0)
    end
    if isUnset == 0 and not used then
      newWeaponElectricCost = TrainWeaponTag.GetOneWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.ElectricCost, info.uid, 0)
    end
    if PlayerData:GetHomeInfo().electric_used - usedWeaponElectricCost + newWeaponElectricCost > PlayerData.GetMaxElectric() then
      CommonTips.OpenTips(80602347)
      return
    end
    Net:SendProto("home.set_train_weapon", function(json)
      if DataModel.curWeaponIngInfo then
        local bagBatteryDetail = PlayerData:GetBattery()[DataModel.curWeaponIngInfo.uid]
        if bagBatteryDetail.u_cid ~= nil and bagBatteryDetail.u_cid ~= "" then
          local coachBattery = PlayerData:GetHomeInfo().coach_store[bagBatteryDetail.u_cid].battery
          for k, v in pairs(coachBattery) do
            if v == DataModel.curWeaponIngInfo.uid then
              coachBattery[k] = ""
              break
            end
          end
          bagBatteryDetail.u_cid = ""
        end
        if DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Parts then
          PlayerData:GetHomeInfo().train_accessories[DataModel.toWeaponPosInfo.weaponIdx] = ""
        elseif DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Pendant then
          PlayerData:GetHomeInfo().train_pendant[DataModel.toWeaponPosInfo.weaponIdx] = ""
        end
      end
      if isUnset == 0 then
        if DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Weapon then
          local serverCoach = PlayerData:GetHomeInfo().coach_store[DataModel.toWeaponPosInfo.coachUid]
          serverCoach.battery[DataModel.toWeaponPosInfo.weaponIdx] = info.uid
        elseif DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Parts then
          PlayerData:GetHomeInfo().train_accessories[DataModel.toWeaponPosInfo.weaponIdx] = info.uid
        elseif DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Pendant then
          if used then
            for i, id in ipairs(PlayerData:GetHomeInfo().train_pendant) do
              if info.uid == id then
                PlayerData:GetHomeInfo().train_pendant[i] = ""
                break
              end
            end
          end
          PlayerData:GetHomeInfo().train_pendant[DataModel.toWeaponPosInfo.weaponIdx] = info.uid
        end
        local bagBatteryDetail = PlayerData:GetBattery()[info.uid]
        if bagBatteryDetail.u_cid ~= nil then
          bagBatteryDetail.u_cid = DataModel.toWeaponPosInfo.coachUid
        end
      end
      DataModel.curWeaponIngInfo = DataModel.GetCurWeaponInfo()
      View.Group_SelectWindows.Group_Left.ScrollGrid_TrainWeapon.grid.self:RefreshAllElement()
      Controller:ShowRightDetailPanel()
      TrainWeaponTag.CalTrainWeaponAllAttributes()
      local originValue = PlayerData:GetHomeInfo().electric_used
      PlayerData:GetHomeInfo().electric_used = originValue - usedWeaponElectricCost + newWeaponElectricCost
      if DataModel.toWeaponPosInfo.type == DataModel.WeaponType.Weapon then
        Controller:RefreshTrainWeaponElement(View.Group_SelectWindows.Group_Bottom.Group_TrainHead.Btn_Add1, 0, 1)
        Controller:RefreshTrainWeaponElement(View.Group_SelectWindows.Group_Bottom.Group_TrainHead.Btn_Add2, 0, 2)
        View.Group_SelectWindows.Group_Bottom.Group_Carriage.StaticGrid_Add.grid.self:RefreshAllElement()
      else
        View.Group_SelectWindows.Group_Bottom.Group_Accessory.StaticGrid_Accessory.grid.self:RefreshAllElement()
        View.Group_SelectWindows.Group_Bottom.Group_Pendant.StaticGrid_Pendant.grid.self:RefreshAllElement()
      end
      Controller:ShowTopElectric()
    end, info.uid, isUnset, DataModel.toWeaponPosInfo.weaponIdx - 1, DataModel.toWeaponPosInfo.coachUid)
  end
  if used and isUnset == 0 then
    CommonTips.OnPrompt(GetText(80601506), nil, nil, function()
      doWeaponOperator()
    end)
  else
    doWeaponOperator()
  end
end

function Controller:ClickWeaponLevelUpBtn()
  local uid = DataModel.curShowBagInfo[DataModel.curSelectIdx].uid
  local data = {uid = uid}
  UIManager:Open("UI/Trainfactory/Group_TrainWeaponSth", Json.encode(data), function()
    Controller:ShowTopElectric()
    View.Group_SelectWindows.Group_Bottom.Group_Accessory.StaticGrid_Accessory.grid.self:RefreshAllElement()
    View.Group_SelectWindows.Group_Bottom.Group_Pendant.StaticGrid_Pendant.grid.self:RefreshAllElement()
    View.Group_SelectWindows.Group_Left.ScrollGrid_TrainWeapon.grid.self:RefreshAllElement()
    Controller:ShowRightDetailPanel()
  end)
end

function Controller:RefreshLeftWeaponElement(element, elementIndex)
  local info = DataModel.curShowBagInfo[elementIndex]
  BtnItem:SetItem(element.Group_Item, {
    id = info.id
  })
  element.Group_Item.Btn_Item:SetClickParam(elementIndex)
  element.Group_Item.Img_Select:SetActive(elementIndex == DataModel.curSelectIdx)
  element.Group_Item.Img_UseBg:SetActive(DataModel.curWeaponIngInfo and info.uid == DataModel.curWeaponIngInfo.uid)
  local used = false
  if info.serverInfo.u_cid ~= nil and info.serverInfo.u_cid ~= "" then
    used = true
  end
  if info.serverInfo.used ~= nil then
    used = info.serverInfo.used
  end
  element.Group_Item.Img_Tag:SetActive(used)
  element.Group_Item.Txt_EquipmentLevel:SetText(string.format("<size=16>LV</size>%d", info.serverInfo.lv))
end

function Controller:ClickWeapon(idx)
  DataModel.curSelectIdx = idx
  View.Group_SelectWindows.Group_Left.ScrollGrid_TrainWeapon.grid.self:RefreshAllElement()
  Controller:ShowRightDetailPanel()
end

function Controller:ClickSortBtn()
  DataModel.curSortType = (DataModel.curSortType + 1) % 2
  View.Group_SelectWindows.Group_Left.Btn_Sort.Img_Straight:SetActive(DataModel.curSortType == DataModel.SortType.QualityUp)
  View.Group_SelectWindows.Group_Left.Btn_Sort.Img_Reverse:SetActive(DataModel.curSortType == DataModel.SortType.QualityDown)
  DataModel.SortTrainWeaponBag(DataModel.curShowBagInfo, DataModel.curSortType)
  PlayerData:SetPlayerPrefs("int", "TrainWeaponSort", DataModel.curSortType)
  View.Group_SelectWindows.Group_Left.ScrollGrid_TrainWeapon.grid.self:RefreshAllElement()
end

function Controller:Exit()
  View.self:Confirm()
  View.self:PlayAnim("CoachWeaponSelect_out", function()
    UIManager:GoBack(false)
  end)
end

function Controller:GoHome()
  View.self:Confirm()
  UIManager:GoHome()
end

function Controller:RefreshCoreList(element, elementIndex)
  local coretypeList = PlayerData:GetFactoryData(99900044).coretypeList
  local cfg = PlayerData:GetFactoryData(coretypeList[elementIndex].id)
  element:SetSprite(cfg.coreIconPathW)
  local info = DataModel.curShowBagInfo[DataModel.curSelectIdx]
  local weaponCA = PlayerData:GetFactoryData(info.id, "HomeWeaponFactory")
  element:SetAlpha(0.4)
  element.Txt_Level:SetActive(false)
  local needCoreList = weaponCA.coreList
  for k, v in pairs(needCoreList) do
    if v.id == coretypeList[elementIndex].id then
      element:SetAlpha(1)
      element.Txt_Level:SetActive(true)
      element.Txt_Level:SetText("LV" .. v.level)
      break
    end
  end
end

return Controller
