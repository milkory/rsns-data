local DataModel = {}

function DataModel.initData(uid)
  DataModel.uid = uid
  local weaponId = PlayerData:GetBattery()[uid].id
  DataModel.weaponCA = PlayerData:GetFactoryData(weaponId)
  DataModel.serverWeaponData = PlayerData:GetBattery()[uid]
  DataModel.baseIconPath = {
    attributeline = "UI/Trainfactory/Weapon/levelup/%s_attributeline",
    bg = "UI/Trainfactory/Weapon/levelup/%s_bg",
    title = "UI/Trainfactory/Weapon/levelup/%s_Title",
    titleicon = "UI/Trainfactory/Weapon/levelup/%s_Titleicon"
  }
  DataModel.qualitBasePath = "UI/Common/Common_icon_rarity_%s"
  DataModel.qualitBaseBGPath = "UI/Trainfactory/Weapon/%sbg"
  DataModel.qualityMap = {
    White = "N",
    Blue = "R",
    Purple = "SR",
    Golden = "SSR",
    Orange = "UR"
  }
  DataModel.qualityColorMap = {
    White = "#FFFFFF",
    Blue = "#377bf8",
    Purple = "#c895ff",
    Golden = "#ffb800",
    Orange = "#ff8a00"
  }
  DataModel.strengthList = PlayerData:GetFactoryData(99900044).strengthList
  DataModel.maxLevel = DataModel.strengthList[#DataModel.strengthList].level
  DataModel.GetCostMaterialList()
end

function DataModel.GetCostMaterialList()
  DataModel.costMaterailList = {}
  local goldData = {id = 11400001, num = 0}
  local trainWeaponConfig = PlayerData:GetFactoryData(99900044)
  local constantValue = 1
  for k, v in pairs(trainWeaponConfig.typeConstantList) do
    if v.id == DataModel.weaponCA.typeWeapon then
      constantValue = v.num
      break
    end
  end
  goldData.num = DataModel.strengthList[DataModel.serverWeaponData.lv + 1].gold * trainWeaponConfig[DataModel.weaponCA.quality] * constantValue
  goldData.num = math.floor(goldData.num)
  table.insert(DataModel.costMaterailList, goldData)
  for i, v in ipairs(DataModel.weaponCA.materialList) do
    if DataModel.serverWeaponData.lv == v.level then
      if 0 < v.list then
        local OilMaterialList = PlayerData:GetFactoryData(v.list).OilMaterialList
        for i, v in ipairs(OilMaterialList) do
          local data = {}
          data.id = v.id
          data.num = v.num
          table.insert(DataModel.costMaterailList, data)
        end
      end
      break
    end
  end
end

function DataModel.FormatNum(num)
  if num <= 0 then
    return 0
  else
    local t1, t2 = math.modf(num + 1.0E-6)
    if 0 < t2 - 1.0E-5 then
      return num
    else
      return t1
    end
  end
end

return DataModel
