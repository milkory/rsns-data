local View = require("UIGroup_TrainWeaponItem/UIGroup_TrainWeaponItemView")
local DataModel = require("UIGroup_TrainWeaponItem/UIGroup_TrainWeaponItemDataModel")
local ViewFunction = require("UIGroup_TrainWeaponItem/UIGroup_TrainWeaponItemViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local data = Json.decode(initParams)
    DataModel.init(data.id, data.weaponUid)
    local cfg = PlayerData:GetFactoryData(DataModel.weaponId)
    print_r(UIConfig.WeaponQuality[cfg.qualityInt + 1])
    View.Img_Rare:SetSprite(UIConfig.WeaponQuality[cfg.qualityInt + 1])
    View.Group_Equipment.Txt_EquipmentNum:SetText(cfg.name)
    View.Group_Equipment.Txt_EquipmentLevel:SetText(DataModel.lv)
    local typeCfg = PlayerData:GetFactoryData(cfg.typeWeapon)
    View.Group_Type.Img_EquipmentIcom:SetSprite(typeCfg.icon)
    View.Group_Type.Txt_Name:SetText(typeCfg.tagName)
    View.Img_Equipment:SetSprite(cfg.tipsPath)
    if cfg.typeWeapon == 12600303 then
      View.StaticGrid_MonsterType.self:SetActive(true)
      View.StaticGrid_MonsterType.grid.self:RefreshAllElement()
    else
      View.StaticGrid_MonsterType.self:SetActive(false)
    end
    View.Img_whoBg:SetActive(DataModel.isEquip)
    View.Group_Two:SetActive(DataModel.own)
    local normalEntryListCnt = #cfg.normalEntryList
    local itemList = {
      View.Group_BasicAttributes.Group_Electric,
      View.Group_BasicAttributes.Group_Speed
    }
    View.Group_BasicAttributes:SetActive(0 < normalEntryListCnt)
    for i = 1, 2 do
      local baseEntry = itemList[i]
      baseEntry:SetActive(i <= normalEntryListCnt)
      if i <= normalEntryListCnt then
        local affixInfo = cfg.normalEntryList[i]
        if affixInfo then
          local ca = PlayerData:GetFactoryData(affixInfo.id, "TrainWeaponSkillFactory")
          local value = math.floor(ca.Constant * ca.CommonNum)
          local tagCa = PlayerData:GetFactoryData(ca.entryTag)
          local icon = tagCa.icon
          baseEntry.Img_Icon:SetSprite(icon)
          baseEntry.Txt_Text:SetText(ca.name)
          value = ca.entryTag == 12600368 and string.format("-%dkm/h", value) or value
          baseEntry.Txt_Num:SetText(value)
        else
          baseEntry:SetActive(false)
        end
      end
    end
    local height = 100
    View.ScrollView_Content.Viewport.Content.Group_Need.StaticGrid_Type.grid.self:RefreshAllElement()
    local growUpEntryListCount = #cfg.growUpEntryList
    local element = View.ScrollView_Content.Viewport.Content.Group_Entry
    element.Group_SpecialTitle:SetActive(0 < growUpEntryListCount)
    for i = 1, 4 do
      local specialEntry = element.Group_SpecialTitle["Group_SpecialEntry" .. i]
      specialEntry:SetActive(i <= growUpEntryListCount)
      if i <= growUpEntryListCount then
        local affixInfo = cfg.growUpEntryList[i]
        if affixInfo then
          local ca = PlayerData:GetFactoryData(affixInfo.id, "TrainWeaponSkillFactory")
          local valueA, valueB
          if ca.aTypeInt == 1 then
            valueA = ca.aNumMinP
            if ca.aDevelopment then
              valueA = (ca.aNumMinP + DataModel.lv * ca.aUpgradeRangeP) * ca.aCommonNumP
            else
              valueA = valueA * ca.aCommonNumP
            end
          else
            valueA = ca.aNumMin
            if ca.aDevelopment then
              valueA = (ca.aNumMin + DataModel.lv * ca.aUpgradeRange) * ca.aCommonNum
            else
              valueA = valueA * ca.aCommonNum
            end
          end
          if ca.bTypeInt == 1 then
            valueB = ca.bNumMinP
            if ca.bDevelopment then
              valueB = (ca.bNumMinP + DataModel.lv * ca.bUpgradeRangeP) * ca.bCommonNumP
            else
              valueB = valueB * ca.bCommonNumP
            end
          else
            valueB = ca.bNumMin
            if ca.bDevelopment then
              valueB = (ca.bNumMin + DataModel.lv * ca.bUpgradeRange) * ca.bCommonNum
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
    element = View.ScrollView_Content.Viewport.Content.Group_Des
    element.Txt_EquipmentDetail:SetText(cfg.des)
    element:SetAnchoredPositionY(-height - 20)
    local txtHeight = element.Txt_EquipmentDetail:GetHeight()
    element.Txt_EquipmentDetail:SetHeight(txtHeight)
    element:SetHeight(txtHeight)
    height = height + txtHeight + 20
    View.ScrollView_Content.self:SetContentHeight(height)
    View.ScrollView_Content.self:SetVerticalNormalizedPosition(1)
    print_r(height)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
