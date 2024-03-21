local factoryDic = {}

function RegProperty(factoryName, properties)
  if factoryDic[factoryName] == nil then
    factoryDic[factoryName] = CS.CBus.Instance:GetFactory(factoryName, false, true)
  end
  factory = factoryDic[factoryName]
  if factory ~= nil then
    for i = 1, #properties do
      pro = properties[i]
      mod = pro.mod
      if mod == nil then
        mod = ""
      end
      name = pro.name
      if name == nil then
        name = "DefaultName"
      end
      pType = pro.type
      if pType == nil then
        pType = "String"
      end
      des = pro.des
      if des == nil then
        des = ""
      end
      isDarken = pro.isDarken
      if isDarken == nil then
        isDarken = false
      end
      pythonName = pro.pythonName
      if pythonName == nil then
        pythonName = ""
      end
      prthonType = pro.pythonType
      if pythonType == nil then
        pythonType = -1
      end
      detail = pro.detail
      if detail == nil then
        detail = ""
      end
      pyIgnore = pro.pyIgnore
      if pyIgnore == nil then
        pyIgnore = false
      end
      factory:RegPropertyOutside(mod, name, pType, des, pro.arg0, pro.arg1, isDarken, pythonName, pythonType, detail, pyIgnore)
    end
  end
end

require("FactoryRegister/Propertys/UnitFactory")
require("FactoryRegister/Propertys/ForgeListFactory")
require("FactoryRegister/Propertys/ListFactory")
require("FactoryRegister/Propertys/EquipmentFactory")
require("FactoryRegister/Propertys/ConfigFactory")
require("FactoryRegister/Propertys/SkillFactory")
require("FactoryRegister/Propertys/LevelFactory")
require("FactoryRegister/Propertys/StoreFactory")
require("FactoryRegister/Propertys/StoreConditionFactory")
require("FactoryRegister/Propertys/CommodityFactory")
require("FactoryRegister/Propertys/ExtractFactory")
require("FactoryRegister/Propertys/TextFactory")
require("FactoryRegister/Propertys/ItemFactory")
require("FactoryRegister/Propertys/SourceMaterialFactory")
require("FactoryRegister/Propertys/TalentFactory")
require("FactoryRegister/Propertys/ChapterFactory")
require("FactoryRegister/Propertys/SkillLvUpFactory")
require("FactoryRegister/Propertys/MailFactory")
require("FactoryRegister/Propertys/UnitViewFactory")
require("FactoryRegister/Propertys/BookFactory")
require("FactoryRegister/Propertys/LevelFactory")
require("FactoryRegister/Propertys/QuestFactory")
require("FactoryRegister/Propertys/GuideOrderFactory")
require("FactoryRegister/Propertys/PlotFactory")
require("FactoryRegister/Propertys/TagFactory")
require("FactoryRegister/Propertys/ValuableFactory")
require("FactoryRegister/Propertys/HomeCoachFactory")
require("FactoryRegister/Propertys/HomeFurnitureFactory")
require("FactoryRegister/Propertys/HomeTemplateFactory")
require("FactoryRegister/Propertys/PictureFactory")
require("FactoryRegister/Propertys/SoundFactory")
require("FactoryRegister/Propertys/VideoFactory")
require("FactoryRegister/Propertys/BattlePassFactory")
require("FactoryRegister/Propertys/EquipmentSetFactory")
require("FactoryRegister/Propertys/ProfilePhotoFactory")
require("FactoryRegister/Propertys/AFKEventFactory")
require("FactoryRegister/Propertys/HomeGoodsFactory")
require("FactoryRegister/Propertys/HomeStationFactory")
require("FactoryRegister/Propertys/HomeLineFactory")
require("FactoryRegister/Propertys/HomeWeaponFactory")
require("FactoryRegister/Propertys/HomeCoachSkinFactory")
require("FactoryRegister/Propertys/FoodFactory")
require("FactoryRegister/Propertys/HomeCreatureFactory")
require("FactoryRegister/Propertys/PetFactory")
require("FactoryRegister/Propertys/GrowthFactory")
require("FactoryRegister/Propertys/AdvLevelFactory")
require("FactoryRegister/Propertys/HomeCharacterFactory")
require("FactoryRegister/Propertys/PetUpgradeFactory")
require("FactoryRegister/Propertys/NPCFactory")
require("FactoryRegister/Propertys/DictionaryFactory")
require("FactoryRegister/Propertys/HomeSkillFactory")
require("FactoryRegister/Propertys/TimeLineFactory")
require("FactoryRegister/Propertys/ParagraphFactory")
require("FactoryRegister/Propertys/HomeBuffFactory")
require("FactoryRegister/Propertys/HomeFurnitureSkinFactory")
require("FactoryRegister/Propertys/HomeStationPlaceFactory")
require("FactoryRegister/Propertys/PassageFactory")
require("FactoryRegister/Propertys/RankFactory")
require("FactoryRegister/Propertys/BuildingFactory")
require("FactoryRegister/Propertys/DataFactory")
require("FactoryRegister/Propertys/AreaFactory")
require("FactoryRegister/Propertys/HomeGoodsQuotationFactory")
require("FactoryRegister/Propertys/ProductionFactory")
require("FactoryRegister/Propertys/FridgeItemFactory")
require("FactoryRegister/Propertys/TrainWeaponSkillFactory")
require("FactoryRegister/Propertys/TrainWeaponBulletFactory")
require("FactoryRegister/Propertys/EngineCoreFactory")
require("FactoryRegister/Propertys/FormulaFactory")
require("FactoryRegister/Propertys/HomeCharacterSkinFactory")
require("FactoryRegister/Propertys/PondFactory")
require("FactoryRegister/Propertys/WeatherFactory")
require("FactoryRegister/Propertys/CdkFactory")
require("FactoryRegister/Propertys/HomeFurnitureSkillFactory")
require("FactoryRegister/Propertys/GuideFactory")
require("FactoryRegister/Propertys/COCListFactory")
require("FactoryRegister/Propertys/ActivityFactory")
require("FactoryRegister/Propertys/ActivityListFactory")
require("FactoryRegister/Propertys/CollectionCardFactory")
require("FactoryRegister/Propertys/CollectionCardPackFactory")
require("FactoryRegister/Propertys/SigninFactory")
require("FactoryRegister/Propertys/MapNeedleFactory")
require("FactoryRegister/Propertys/EffectFactory")
factoryDic = nil
buffer = nil
