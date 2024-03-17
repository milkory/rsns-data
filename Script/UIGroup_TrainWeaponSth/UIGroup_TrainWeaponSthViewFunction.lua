local View = require("UIGroup_TrainWeaponSth/UIGroup_TrainWeaponSthView")
local DataModel = require("UIGroup_TrainWeaponSth/UIGroup_TrainWeaponSthDataModel")
local CommonItem = require("Common/BtnItem")
local GetGrowUpValue = function(lv, ca)
  local valueA, valueB
  if ca.aTypeInt == 1 then
    valueA = ca.aNumMinP
    if ca.aDevelopment then
      valueA = (ca.aNumMinP + lv * ca.aUpgradeRangeP) * ca.aCommonNumP
    end
  else
    valueA = ca.aNumMin
    if ca.aDevelopment then
      valueA = (ca.aNumMin + lv * ca.aUpgradeRange) * ca.aCommonNum
    end
  end
  if ca.bTypeInt == 1 then
    valueB = ca.bNumMinP
    if ca.bDevelopment then
      valueB = (ca.bNumMinP + lv * ca.bUpgradeRangeP) * ca.bCommonNumP
    end
  else
    valueB = ca.bNumMin
    if ca.bDevelopment then
      valueB = (ca.bNumMin + lv * ca.bUpgradeRange) * ca.bCommonNum
    end
  end
  valueA = DataModel.FormatNum(valueA)
  valueB = DataModel.FormatNum(valueB)
  return valueA, valueB
end
local RefreshPanel = function()
  local quality = DataModel.qualityMap[DataModel.weaponCA.quality]
  View.Group_Right.Img_Bg:SetSprite(string.format(DataModel.baseIconPath.bg, quality))
  View.Group_Right.Img_Bg.Group_GrowthAttributes.Img_attributeline:SetSprite(string.format(DataModel.baseIconPath.attributeline, quality))
  View.Group_Top.Img_TitleBg:SetSprite(string.format(DataModel.baseIconPath.title, quality))
  View.Group_Top.Img_TitleIcon:SetSprite(string.format(DataModel.baseIconPath.titleicon, quality))
  View.Group_Right.Img_Bg.Img_Rare:SetSprite(string.format(DataModel.qualitBasePath, quality))
  View.Group_Right.Img_Bg.Txt_Name:SetText(DataModel.weaponCA.name)
  local tagName = PlayerData:GetFactoryData(DataModel.weaponCA.typeWeapon).tagName
  View.Group_Right.Img_Bg.Img_Type.Txt_Type:SetText(tagName)
  View.Group_Left.Group_Level.Txt_OldLevel:SetText(DataModel.serverWeaponData.lv)
  View.Img_HavemoneyBg.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
  View.Group_Left.Img_Weapon:SetSprite(DataModel.weaponCA.tipsPath)
  View.Group_Left.Img_CircleBg.Img_Circle:SetSprite(string.format(DataModel.qualitBaseBGPath, quality))
  View.Img_BgLighting:SetColor(DataModel.qualityColorMap[DataModel.weaponCA.quality])
  for i = 1, 4 do
    local affixInfo = DataModel.weaponCA.growUpEntryList[i]
    local specialEntry = View.Group_Right.Img_Bg.Group_GrowthAttributes["Group_SpecialEntry" .. i]
    if affixInfo then
      local ca = PlayerData:GetFactoryData(affixInfo.id, "TrainWeaponSkillFactory")
      local nowValueA, nowValueB = GetGrowUpValue(DataModel.serverWeaponData.lv, ca)
      if ca.aDevelopment == false and ca.bDevelopment == false then
        specialEntry:SetActive(false)
      else
        if DataModel.serverWeaponData.lv < DataModel.maxLevel then
          local nextValueA, nextValueB = GetGrowUpValue(DataModel.serverWeaponData.lv + 1, ca)
          local addValueA = nextValueA - nowValueA
          local addValueB = nextValueB - nowValueB
          if 0 < addValueA then
            nowValueA = string.format("%s<color=#ffb800>+%s</color>", DataModel.FormatNum(nowValueA), DataModel.FormatNum(addValueA))
          end
          if 0 < addValueB then
            nowValueB = string.format("%s<color=#ffb800>+%s</color>", DataModel.FormatNum(nowValueB), DataModel.FormatNum(addValueB))
          end
        end
        specialEntry:SetActive(true)
      end
      if DataModel.serverWeaponData.lv >= DataModel.maxLevel then
        specialEntry:SetActive(true)
      end
      specialEntry.Txt_Entry:SetText("<color=#D2B075>" .. ca.name .. "</color>　" .. string.format(ca.text, nowValueA, nowValueB))
      local txtHeight = specialEntry.Txt_Entry:GetHeight()
      specialEntry.Txt_Entry:SetHeight(txtHeight)
      specialEntry:SetHeight(txtHeight)
    else
      specialEntry:SetActive(false)
    end
  end
  if DataModel.serverWeaponData.lv < DataModel.maxLevel then
    View.Group_Left.Group_Level.Txt_NewLevel:SetText(DataModel.serverWeaponData.lv + 1)
    View.Group_Left.Group_Level.Img_Arrow:SetActive(true)
    View.Group_Left.Group_Level.Txt_NewLevel:SetActive(true)
    View.Group_Left.Group_Level.Txt_LEVEL2:SetActive(true)
    View.Group_Right.Img_Bg.Group_MaterialAndBtn.Btn_Strength:SetActive(true)
  else
    View.Group_Left.Group_Level.Img_Arrow:SetActive(false)
    View.Group_Left.Group_Level.Txt_NewLevel:SetActive(false)
    View.Group_Left.Group_Level.Txt_LEVEL2:SetActive(false)
    View.Group_Right.Img_Bg.Group_MaterialAndBtn.Btn_Strength:SetActive(false)
  end
  View.Group_Right.Img_Bg.Group_MaterialAndBtn.Img_MaterialBg.StaticGrid_Material.grid.self:RefreshAllElement()
end
local ViewFunction = {
  Group_TrainWeaponSth_Group_Right_Img_Bg_Group_MaterialAndBtn_Img_MaterialBg_Group_Item_Img_Dikuang_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Group_TrainWeaponSth_Group_Right_Img_Bg_Group_MaterialAndBtn_Img_MaterialBg_StaticGrid_Material_SetGrid = function(element, elementIndex)
    element.Img_Dikuang.Group_Item:SetActive(false)
    element.Img_Dikuang.Group_Cost:SetActive(false)
    local data = DataModel.costMaterailList[elementIndex]
    if data and data.num > 0 then
      element.Img_Dikuang.Group_Item:SetActive(true)
      element.Img_Dikuang.Group_Cost:SetActive(true)
      CommonItem:SetItem(element.Img_Dikuang.Group_Item, {
        id = data.id,
        num = data.num
      }, EnumDefine.ItemType.Item)
      element.Img_Dikuang.Group_Item.Txt_Num:SetActive(false)
      local needNum = data.num
      element.Img_Dikuang.Group_Cost.Txt_Need:SetText(needNum)
      element.Img_Dikuang.Group_Cost.Txt_Have:SetActive(false)
      element.Img_Dikuang.Group_Cost.Txt_And:SetActive(false)
      if data.id ~= 11400001 then
        element.Img_Dikuang.Group_Cost.Txt_Have:SetActive(true)
        element.Img_Dikuang.Group_Cost.Txt_And:SetActive(true)
        local holdNum = PlayerData:GetGoodsById(data.id).num
        local colorInfo = needNum <= holdNum and "#FFFFFF" or "#ff7750"
        element.Img_Dikuang.Group_Cost.Txt_Have:SetText(string.format("<color=%s>%d</color>", colorInfo, holdNum))
      else
        local holdNum = PlayerData:GetGoodsById(data.id).num
        local color = needNum <= holdNum and "#FFFFFF" or "#ff7750"
        element.Img_Dikuang.Group_Cost.Txt_Need:SetColor(color)
      end
      element.Img_Dikuang.Group_Item.Btn_Item:SetClickParam(data.id)
    end
  end,
  Group_TrainWeaponSth_Group_Right_Img_Bg_Group_MaterialAndBtn_Img_MaterialBg_StaticGrid_Material_Group_Item_Img_Dikuang_Group_Item_Btn_Item_Click = function(btn, str)
    local itemId = tonumber(str)
    CommonTips.OpenRewardDetail(itemId)
  end,
  Group_TrainWeaponSth_Group_Right_Img_Bg_Group_MaterialAndBtn_Btn_Strength_Click = function(btn, str)
    for i, v in ipairs(DataModel.costMaterailList) do
      local holdNum = PlayerData:GetGoodsById(v.id).num
      if holdNum < v.num then
        CommonTips.OpenTips(80602173)
        return
      end
    end
    if DataModel.serverWeaponData.lv >= DataModel.maxLevel then
      return
    end
    Net:SendProto("home.upgrade_train_weapon", function(json)
      for i, v in ipairs(DataModel.costMaterailList) do
        if v.id ~= 11400001 then
          local nowValue = PlayerData:GetGoodsById(v.id).num - v.num
          PlayerData:GetGoodsById(v.id).num = nowValue
        end
      end
      DataModel.serverWeaponData.lv = DataModel.serverWeaponData.lv + 1
      DataModel.GetCostMaterialList()
      RefreshPanel()
      TrainWeaponTag.CalTrainWeaponAllAttributes()
      View.self:PlayAnimOnce("LevelUp")
    end, DataModel.uid)
  end,
  Group_TrainWeaponSth_Img_HavemoneyBg_Btn_Add_Click = function(btn, str)
  end,
  Group_TrainWeaponSth_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:Confirm()
    View.self:PlayAnimOnce("TrainWeaponSth_Out", function()
      UIManager:GoBack(false)
    end)
  end,
  Group_TrainWeaponSth_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Group_TrainWeaponSth_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Group_TrainWeaponSth_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  RefreshPanel = RefreshPanel
}
return ViewFunction
