RegProperty("ConfigFactory", {
  {
    mod = "初始配置",
    name = "initGold",
    type = "Int",
    des = "初始金币",
    arg0 = "0"
  },
  {
    mod = "初始配置",
    name = "energyMax",
    type = "Int",
    des = "体力最大值",
    arg0 = "0"
  },
  {
    mod = "初始配置",
    name = "energyExtraMax",
    type = "Int",
    des = "体力最大值（储存）",
    arg0 = "0"
  },
  {
    mod = "初始配置",
    name = "nowEnergyMax",
    type = "Int",
    des = "当前体力最大值|消耗道具或桦石可达到的最大体力",
    arg0 = "9999"
  },
  {
    mod = "初始配置",
    name = "energyAddCD",
    type = "Int",
    des = "体力恢复间隔秒",
    arg0 = "0"
  },
  {
    mod = "初始配置",
    name = "energyAdd",
    type = "Int",
    des = "体力恢复值",
    arg0 = "0"
  },
  {
    mod = "初始配置",
    name = "powerStoneCost",
    type = "Int",
    des = "消耗体力道具",
    arg0 = "1"
  },
  {
    mod = "初始配置",
    name = "receptionistId",
    type = "Factory",
    des = "初始看板娘",
    arg0 = "UnitFactory"
  },
  {
    mod = "初始配置",
    name = "guardId",
    type = "Factory",
    des = "初始护卫",
    arg0 = "UnitFactory"
  },
  {
    mod = "初始配置",
    name = "initProfilePhotoList",
    type = "Array",
    des = "初始头像列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "头像",
    arg0 = "ProfilePhotoFactory"
  },
  {name = "end"},
  {
    mod = "初始配置",
    name = "defaultSkins",
    type = "Array",
    des = "初始服装",
    detail = "id#wear"
  },
  {
    name = "id",
    type = "Factory",
    des = "服装",
    arg0 = "HomeCharacterSkinFactory"
  },
  {
    name = "wear",
    type = "Bool",
    des = "是否默认穿上",
    arg0 = "true"
  },
  {name = "end"},
  {
    mod = "初始配置",
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    mod = "初始配置",
    name = "roleList",
    type = "Array",
    des = "初始队员列表",
    detail = "roleId"
  },
  {
    name = "roleId",
    type = "Factory",
    des = "队员ID",
    arg0 = "UnitFactory"
  },
  {name = "end"},
  {
    mod = "初始配置",
    name = "teamList",
    type = "Array",
    des = "初始编队",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "队员ID",
    arg0 = "UnitFactory"
  },
  {name = "end"},
  {
    mod = "初始配置",
    name = "initQuestList",
    type = "Array",
    des = "初始任务列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "初始配置",
    name = "BattlePassId",
    type = "Factory",
    des = "通行证配置",
    arg0 = "BattlePassFactory"
  },
  {
    mod = "初始配置",
    name = "initFurnitureList",
    type = "Array",
    des = "初始家具列表",
    detail = "furnitureId#num"
  },
  {
    name = "furnitureId",
    type = "Factory",
    des = "家具",
    arg0 = "HomeFurnitureFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "初始配置",
    name = "initCoachList",
    type = "Array",
    des = "初始车厢列表",
    detail = "id#weapon"
  },
  {
    name = "id",
    type = "Factory",
    des = "车厢",
    arg0 = "HomeCoachFactory"
  },
  {
    name = "weapon",
    type = "Factory",
    des = "武器",
    arg0 = "HomeWeaponFactory"
  },
  {
    name = "default",
    type = "Int",
    des = "默认栏位",
    arg0 = "2"
  },
  {name = "end"},
  {
    mod = "初始配置",
    name = "trainSpeedInit",
    type = "Int",
    des = "列车初始速度",
    arg0 = "100"
  },
  {
    mod = "初始配置",
    name = "trainSpeedMinimum",
    type = "Int",
    des = "列车最低速度",
    arg0 = "30"
  },
  {
    mod = "初始配置",
    name = "trainRushSpeedAdd",
    type = "Int",
    des = "列车燃油加速",
    arg0 = "30"
  },
  {
    mod = "初始配置",
    name = "trainRushTime",
    type = "Int",
    des = "燃油持续时间",
    arg0 = "20"
  },
  {
    mod = "初始配置",
    name = "trainRushInit",
    type = "Int",
    des = "燃油初始数量",
    arg0 = "0"
  },
  {
    mod = "初始配置",
    name = "trainRushLimit",
    type = "Int",
    des = "燃油初始上限",
    arg0 = "5"
  },
  {
    mod = "初始配置",
    name = "trainRushBuyList",
    type = "Array",
    des = "每罐燃油价格",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品列表ID",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "初始配置",
    name = "goodsSlowDown",
    type = "Double",
    des = "载货承重减速",
    arg0 = "-20"
  },
  {
    mod = "初始配置",
    name = "passengerSlowDown",
    type = "Double",
    des = "载客承重减速",
    arg0 = "-20"
  },
  {
    mod = "初始配置",
    name = "protectCountList",
    type = "Array",
    des = "大保底开启次数列表|标签相同卡池公用次数",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "大保底标签",
    arg0 = "TagFactory",
    arg1 = "卡池大保底"
  },
  {
    name = "num",
    type = "Int",
    des = "大保底开启次数",
    arg0 = "50"
  },
  {name = "end"},
  {
    mod = "贸易经验表",
    name = "levelMax",
    type = "Int",
    des = "贸易最大等级",
    detail = "1"
  },
  {
    mod = "贸易经验表",
    name = "expList",
    type = "Array",
    des = "贸易经验表",
    detail = "needExp#bargainRange#riseRange#bargainSuccessRate#riseSuccessRate#unlockQuest"
  },
  {
    name = "needExp",
    type = "Int",
    des = "升下级所需经验",
    arg0 = "10"
  },
  {
    name = "bargainRange",
    type = "Double",
    des = "每次砍价幅度",
    arg0 = "5"
  },
  {
    name = "riseRange",
    type = "Double",
    des = "每次抬价幅度",
    arg0 = "5"
  },
  {
    name = "bargainSuccessRate",
    type = "Double",
    des = "砍价成功率加成",
    arg0 = "5"
  },
  {
    name = "riseSuccessRate",
    type = "Double",
    des = "抬价成功率加成",
    arg0 = "5"
  },
  {
    name = "unlockQuest",
    type = "Factory",
    des = "升级后解锁任务",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "家园电力",
    name = "electricList",
    type = "Array",
    des = "电力升级列表",
    detail = "electric#id#slotNum#speed"
  },
  {
    name = "electric",
    type = "Int",
    des = "提供电力",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "升至下一等级所需材料",
    arg0 = "ListFactory"
  },
  {
    name = "slotNum",
    type = "Int",
    des = "插槽开启数量",
    arg0 = "1"
  },
  {
    name = "speed",
    type = "Int",
    des = "列车增加速度",
    arg0 = "100"
  },
  {name = "end"},
  {
    mod = "家园电力",
    name = "buyElectricList",
    type = "Array",
    des = "安装模块列表",
    detail = "electric#id#addSpeed"
  },
  {
    name = "electric",
    type = "Int",
    des = "提供电力",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "安装消耗材料",
    arg0 = "ListFactory"
  },
  {
    name = "addSpeed",
    type = "Int",
    des = "模块提供速度",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "characterScale",
    type = "Double",
    des = "角色缩放",
    arg0 = "1",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "开车相关配置"
  },
  {
    mod = "家园配置",
    name = "disRatio",
    type = "Double",
    des = "换算公里系数",
    arg0 = "0.02"
  },
  {
    mod = "家园配置",
    name = "timeRatio",
    type = "Double",
    des = "换算时间系数",
    arg0 = "0.01",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "energyOver",
    type = "Double",
    des = "开车超额疲劳值",
    arg0 = "50"
  },
  {
    mod = "家园配置",
    name = "disEnergyStart",
    type = "Double",
    des = "开车起步疲劳距离",
    arg0 = "300"
  },
  {
    mod = "家园配置",
    name = "energyStart",
    type = "Double",
    des = "开车起步疲劳值",
    arg0 = "5"
  },
  {
    mod = "家园配置",
    name = "disEnergyPer",
    type = "Double",
    des = "开车单位疲劳距离",
    arg0 = "100"
  },
  {
    mod = "家园配置",
    name = "energyPer",
    type = "Double",
    des = "开车单位疲劳值",
    arg0 = "1"
  },
  {
    mod = "家园配置",
    name = "disExpPer",
    type = "Double",
    des = "开车单位经验距离",
    arg0 = "100"
  },
  {
    mod = "家园配置",
    name = "expPer",
    type = "Double",
    des = "开车单位经验值",
    arg0 = "1"
  },
  {
    mod = "家园配置",
    name = "goodsOver",
    type = "Int",
    des = "开车超额货物",
    arg0 = "50"
  },
  {
    mod = "家园配置",
    name = "goodsReduceSpeed",
    type = "Int",
    des = "减1速超额货物",
    arg0 = "2"
  },
  {
    mod = "家园配置",
    name = "dayScale",
    type = "Double",
    des = "大世界时间比例",
    arg0 = "24"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    mod = "家园配置",
    name = "defaultName",
    type = "StringT",
    des = "默认列车名",
    arg0 = "XP5B无垠"
  },
  {
    mod = "家园配置",
    name = "furnitureCoin",
    type = "Factory",
    des = "家园币",
    arg0 = "ItemFactory"
  },
  {
    mod = "家园配置",
    name = "tradeCoin",
    type = "Factory",
    des = "贸易货币",
    arg0 = "ItemFactory"
  },
  {
    mod = "家园配置",
    name = "conductorM",
    type = "Factory",
    des = "男列车长",
    arg0 = "HomeCharacterFactory",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "conductorW",
    type = "Factory",
    des = "女列车长",
    arg0 = "HomeCharacterFactory",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "box",
    type = "Factory",
    des = "波克士",
    arg0 = "HomeCharacterFactory",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "yao",
    type = "Factory",
    des = "遥",
    arg0 = "HomeCharacterFactory"
  },
  {
    mod = "家园配置",
    name = "businessman",
    type = "Factory",
    des = "商人",
    arg0 = "HomeCharacterFactory",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "coachDefaultBgmId",
    type = "Factory",
    des = "车厢默认BGM",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "levelMax",
    type = "Int",
    des = "家园最大等级",
    arg0 = "5"
  },
  {
    mod = "家园配置",
    name = "levelList",
    type = "Array",
    des = "家园等级表",
    detail = "developmentDegree#coachMax"
  },
  {
    name = "developmentDegree",
    type = "Int",
    des = "发展度",
    arg0 = "1"
  },
  {
    name = "coachMax",
    type = "Int",
    des = "最大车厢数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "creatureBag",
    type = "Int",
    des = "生物背包初始大小",
    arg0 = "100"
  },
  {
    mod = "家园配置",
    name = "buildList",
    type = "Array",
    des = "可建造车厢列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "车厢",
    arg0 = "HomeCoachFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "coachTypeList",
    type = "Array",
    des = "车厢类型列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "类型",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "装扮相关配置"
  },
  {
    mod = "家园配置",
    name = "defaultFloor",
    type = "Factory",
    des = "默认地板",
    arg0 = "HomeFurnitureFactory",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "defaultWallpaper",
    type = "Factory",
    des = "默认墙纸",
    arg0 = "HomeFurnitureFactory",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "CustomTemplateNum",
    type = "Int",
    des = "预设数量",
    arg0 = "10"
  },
  {
    mod = "家园配置",
    name = "themeList",
    type = "Array",
    des = "主题列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "类型",
    arg0 = "HomeTemplateFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "floorTypeList",
    type = "Array",
    des = "地面家具类型",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "类型",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "wallTypeList",
    type = "Array",
    des = "墙面家具类型",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "类型",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "furnitureAttrList",
    type = "Array",
    des = "家具属性列表",
    detail = "attrName#field#iconPath",
    pyIgnore = true
  },
  {
    name = "attrName",
    type = "String",
    des = "属性",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "field",
    type = "String",
    des = "字段",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "iconPath",
    type = "Png",
    des = "图标",
    arg0 = "",
    arg1 = "40|40",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "制造家具",
    name = "",
    type = "SysLine",
    des = "制造家具相关配置"
  },
  {
    mod = "制造家具",
    name = "productionFurnitureList",
    type = "Array",
    des = "制造家具列表",
    detail = "id#bgPath#cName#engName#GetWay#UIName",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "类型",
    arg0 = "TagFactory",
    pyIgnore = true
  },
  {
    name = "bgPath",
    type = "Png",
    des = "背景图",
    arg0 = "",
    arg1 = "300|300",
    pyIgnore = true
  },
  {
    name = "cName",
    type = "String",
    des = "家具中文名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "engName",
    type = "String",
    des = "家具英文名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "GetWay",
    type = "TextT",
    des = "获取途径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "UIName",
    type = "String",
    des = "UI名称",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "景点剧情"
  },
  {
    mod = "家园配置",
    name = "maxAttractionTipNum",
    type = "Int",
    des = "景点对话显示上限",
    arg0 = "1"
  },
  {
    mod = "家园配置",
    name = "attractionTipOffsetX",
    type = "Int",
    des = "景点对话初始位置X",
    arg0 = "0"
  },
  {
    mod = "家园配置",
    name = "attractionTipOffsetY",
    type = "Int",
    des = "景点对话初始位置Y",
    arg0 = "200"
  },
  {
    mod = "家园配置",
    name = "attractionTipSpacing",
    type = "Int",
    des = "景点对话间隔距离",
    arg0 = "0"
  },
  {
    mod = "家园配置",
    name = "isTipRepeat",
    type = "Bool",
    des = "是否重复触发|勾上后景点剧情可重复触发",
    arg0 = "false"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "车站"
  },
  {
    mod = "家园配置",
    name = "defaultStation",
    type = "Factory",
    des = "默认车站",
    arg0 = "HomeStationFactory"
  },
  {
    mod = "家园配置",
    name = "stationList",
    type = "Array",
    des = "车站列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "车站",
    arg0 = "HomeStationFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "lineList",
    type = "Array",
    des = "线路列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "线路",
    arg0 = "HomeLineFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "商会任务"
  },
  {
    mod = "家园配置",
    name = "cocQuestMax",
    type = "Int",
    des = "商会任务上限",
    arg0 = "9"
  },
  {
    mod = "家园配置",
    name = "cocAddQuestItemList",
    type = "Array",
    des = "增加任务消耗道具",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "cocItemAddQuestNum",
    type = "Int",
    des = "道具增加任务数量",
    arg0 = "1"
  },
  {
    mod = "交易所",
    name = "bargainCost",
    type = "Int",
    des = "议价消耗疲劳值",
    arg0 = "3"
  },
  {
    mod = "交易所",
    name = "bargainMax",
    type = "Double",
    des = "砍价上限",
    arg0 = "0.2"
  },
  {
    mod = "交易所",
    name = "bargainSuccessRateList",
    type = "Array",
    des = "基础砍价成功率",
    detail = "rate"
  },
  {
    name = "rate",
    type = "Double",
    des = "成功率",
    arg0 = "0.5",
    pythonName = "id"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "riseMax",
    type = "Double",
    des = "抬价上限",
    arg0 = "0.2"
  },
  {
    mod = "交易所",
    name = "riseSuccessRateList",
    type = "Array",
    des = "基础抬价成功率",
    detail = "rate"
  },
  {
    name = "rate",
    type = "Double",
    des = "成功率",
    arg0 = "0.5",
    pythonName = "id"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "initBargainSuccessNum",
    type = "Int",
    des = "砍价必定成功次数",
    arg0 = "0"
  },
  {
    mod = "交易所",
    name = "initRiseSuccessNum",
    type = "Int",
    des = "抬价必定成功次数",
    arg0 = "0"
  },
  {
    mod = "交易所",
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    mod = "交易所",
    name = "taxConvertRep",
    type = "Int",
    des = "税收增加声望常量",
    arg0 = "2000"
  },
  {
    mod = "交易所",
    name = "profitConvertRep",
    type = "Int",
    des = "利润增加声望常量",
    arg0 = "20000"
  },
  {
    mod = "交易所",
    name = "tradeConvertDev",
    type = "Int",
    des = "贸易增加发展度常量",
    arg0 = "1000000"
  },
  {
    mod = "交易所",
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    mod = "交易所",
    name = "settlementDays",
    type = "Int",
    des = "结算统计天数",
    arg0 = "4"
  },
  {
    mod = "交易所",
    name = "",
    type = "SysLine",
    des = "使用道具"
  },
  {
    mod = "交易所",
    name = "refreshGoods",
    type = "Array",
    des = "进货采买书",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "refreshBargain",
    type = "Array",
    des = "再交涉请求书",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "buyItemList",
    type = "Array",
    des = "我要买可使用道具",
    detail = "id#func#textId#isOneOfUs",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "道具",
    arg0 = "ItemFactory",
    pyIgnore = true
  },
  {
    name = "func",
    type = "Enum",
    des = "道具功能||RefreshGoods:进货,RefreshBargain:再交涉,BargainItem:议价道具,Tips:分割提示",
    arg0 = "RefreshGoods#RefreshBargain#BargainItem#Tips",
    arg1 = "BargainItem",
    pyIgnore = true
  },
  {
    name = "textId",
    type = "Factory",
    des = "文本",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "isOneOfUs",
    type = "Bool",
    des = "同盟徽章",
    arg0 = "False",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "交易所",
    name = "sellItemList",
    type = "Array",
    des = "我要卖可使用道具",
    detail = "id#func#textId#isOneOfUs",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "道具",
    arg0 = "ItemFactory",
    pyIgnore = true
  },
  {
    name = "func",
    type = "Enum",
    des = "道具功能||RefreshBargain:再交涉,BargainItem:议价道具,Tips:分割提示",
    arg0 = "RefreshBargain#BargainItem#Tips",
    arg1 = "BargainItem",
    pyIgnore = true
  },
  {
    name = "textId",
    type = "Factory",
    des = "文本",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "isOneOfUs",
    type = "Bool",
    des = "同盟徽章",
    arg0 = "False",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "交易所",
    name = "",
    type = "SysLine",
    des = "行情"
  },
  {
    mod = "交易所",
    name = "extraQuotation",
    type = "Double",
    des = "0点额外行情波动",
    arg0 = "0.01"
  },
  {
    mod = "交易所",
    name = "quotationThresholdList",
    type = "Array",
    des = "行情变化阈值",
    detail = "id"
  },
  {
    name = "id",
    type = "Int",
    des = "阈值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "fastQuotationStart",
    type = "String",
    des = "快速行情开始时间",
    arg0 = ""
  },
  {
    mod = "交易所",
    name = "fastQuotationEnd",
    type = "String",
    des = "快速行情结束时间",
    arg0 = ""
  },
  {
    mod = "交易所",
    name = "rareGoodsInitQMin",
    type = "Double",
    des = "稀少交易品初始行情下限",
    arg0 = "1"
  },
  {
    mod = "交易所",
    name = "rareGoodsInitQMax",
    type = "Double",
    des = "稀少交易品初始行情上限",
    arg0 = "1.1"
  },
  {
    mod = "交易所",
    name = "rareGoodsQuotationMin",
    type = "Double",
    des = "稀少交易品卖出行情下限",
    arg0 = "0.65"
  },
  {
    mod = "交易所",
    name = "rareGoodsQuotationMax",
    type = "Double",
    des = "稀少交易品卖出行情上限",
    arg0 = "1.35"
  },
  {
    mod = "交易所",
    name = "resetQuotationMin",
    type = "Double",
    des = "重置行情下限",
    arg0 = "0.95"
  },
  {
    mod = "交易所",
    name = "resetQuotationMax",
    type = "Double",
    des = "重置行情上限",
    arg0 = "1.05"
  },
  {
    mod = "交易所",
    name = "suddenQuotationList",
    type = "Array",
    des = "暴涨暴跌时间表",
    detail = "sTime#num"
  },
  {
    name = "sTime",
    type = "String",
    des = "时间",
    arg0 = ""
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "riseQuotationInitMin",
    type = "Double",
    des = "暴涨初始行情下限",
    arg0 = "1.1"
  },
  {
    mod = "交易所",
    name = "riseQuotationInitMax",
    type = "Double",
    des = "暴涨初始行情上限",
    arg0 = "1.15"
  },
  {
    mod = "交易所",
    name = "dropQuotationInitMin",
    type = "Double",
    des = "暴跌初始行情下限",
    arg0 = "0.85"
  },
  {
    mod = "交易所",
    name = "dropQuotationInitMax",
    type = "Double",
    des = "暴跌初始行情上限",
    arg0 = "0.9"
  },
  {
    mod = "交易所",
    name = "suddenQuotationMin",
    type = "Double",
    des = "暴涨暴跌行情下限",
    arg0 = "0.65"
  },
  {
    mod = "交易所",
    name = "suddenQuotationMax",
    type = "Double",
    des = "暴涨暴跌行情上限",
    arg0 = "1.35"
  },
  {
    mod = "交易所",
    name = "suddenQMax",
    type = "Double",
    des = "暴涨暴最长时间（小时）",
    arg0 = "3"
  },
  {
    mod = "交易所",
    name = "",
    type = "SysLine",
    des = "污染影响"
  },
  {
    mod = "交易所",
    name = "buyPollutionRatio",
    type = "Double",
    des = "买入污染指数系数",
    arg0 = "0.003"
  },
  {
    mod = "交易所",
    name = "sellPollutionRatio",
    type = "Double",
    des = "卖出污染指数系数",
    arg0 = "0.003"
  },
  {
    mod = "交易所",
    name = "",
    type = "SysLine",
    des = "任务行情"
  },
  {
    mod = "交易所",
    name = "questQuotationList",
    type = "Array",
    des = "任务行情",
    detail = "questId#quotationId#quotationVal#quotationType#stationId"
  },
  {
    name = "questId",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "基础任务"
  },
  {
    name = "stationId",
    type = "Factory",
    des = "城市(车站)",
    arg0 = "HomeStationFactory"
  },
  {
    name = "quotationType",
    type = "Enum",
    des = "行情类型||Sell:车站出售,Buy:车站收购",
    arg0 = "Sell#Buy",
    arg1 = "Sell"
  },
  {
    name = "quotationId",
    type = "Factory",
    des = "行情ID",
    arg0 = "HomeGoodsQuotationFactory"
  },
  {
    name = "quotationVal",
    type = "Double",
    des = "行情",
    arg0 = "0.8"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "疲劳值相关配置"
  },
  {
    mod = "家园配置",
    name = "homeEnergyItemId",
    type = "Factory",
    des = "疲劳值道具",
    arg0 = "ItemFactory"
  },
  {
    mod = "家园配置",
    name = "homeEnergyAddCD",
    type = "Int",
    des = "疲劳值恢复间隔秒",
    arg0 = "540"
  },
  {
    mod = "家园配置",
    name = "homeEnergyAdd",
    type = "Int",
    des = "疲劳值单次恢复值",
    arg0 = "1"
  },
  {
    mod = "家园配置",
    name = "upgradeOrderTimes",
    type = "Int",
    des = "每日桦石次数上限",
    arg0 = "3"
  },
  {
    mod = "家园配置",
    name = "upgradeOrderValue",
    type = "Int",
    des = "桦石单次降低值",
    arg0 = "50"
  },
  {
    mod = "家园配置",
    name = "orderCost",
    type = "Array",
    des = "桦石消耗",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具ID",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "50"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "homeEnergyItemList",
    type = "Array",
    des = "疲劳值道具列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具列表",
    arg0 = "ItemFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "homeEnergyStatementList",
    type = "Array",
    des = "疲劳值状态",
    detail = "ratioMin#ratioMax#bg#stateText#face#faceSpine#arrow#lightIcon#tipText#tipImg#"
  },
  {
    name = "ratioMin",
    type = "Double",
    des = "状态程度比值最小",
    arg0 = "0"
  },
  {
    name = "ratioMax",
    type = "Double",
    des = "状态程度比值最大",
    arg0 = "1"
  },
  {
    name = "bg",
    type = "Png",
    des = "顶部背景图",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "stateText",
    type = "Factory",
    des = "状态语",
    arg0 = "TextFactory"
  },
  {
    name = "face",
    type = "Png",
    des = "大头像",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "faceSpine",
    type = "String",
    des = "大头像spine",
    arg0 = ""
  },
  {
    name = "arrow",
    type = "Png",
    des = "箭头",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "lightIcon",
    type = "String",
    des = "点亮小表情",
    arg0 = "Img_1"
  },
  {
    name = "tipText",
    type = "Factory",
    des = "提示字",
    arg0 = "TextFactory"
  },
  {
    name = "tipImg",
    type = "Png",
    des = "提示字图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "便当柜相关配置"
  },
  {
    mod = "家园配置",
    name = "freeOrderTimes",
    type = "Int",
    des = "每日日常餐次数",
    arg0 = "3"
  },
  {
    mod = "家园配置",
    name = "orderTimeList",
    type = "Array",
    des = "免费餐派送时间列表",
    detail = "time#id"
  },
  {
    name = "time",
    type = "String",
    des = "派送时间",
    arg0 = "00:00:00"
  },
  {
    name = "id",
    type = "Factory",
    des = "日常餐食物",
    arg0 = "FoodFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "normalOrder",
    type = "Factory",
    des = "疲劳值快捷道具",
    arg0 = "FoodFactory#ItemFactory"
  },
  {
    mod = "家园配置",
    name = "foodBag",
    type = "Int",
    des = "便当仓库初始容量",
    arg0 = "12"
  },
  {
    mod = "家园配置",
    name = "loveBentoLevel",
    type = "Int",
    des = "爱心便当开启默契等级",
    arg0 = "6"
  },
  {
    mod = "家园配置",
    name = "loveBentoPr",
    type = "Double",
    des = "爱心便当获取概率",
    arg0 = "0.2"
  },
  {
    mod = "家园配置",
    name = "loveBentoMax",
    type = "Double",
    des = "爱心便当每日获取上限",
    arg0 = "3"
  },
  {
    mod = "家园配置",
    name = "loveBentoPrMax",
    type = "Double",
    des = "爱心便当获取概率上限",
    arg0 = "0.3"
  },
  {
    mod = "家园配置",
    name = "loveBentoPrMin",
    type = "Double",
    des = "爱心便当获取概率下限",
    arg0 = "0.1"
  },
  {
    mod = "家园配置",
    name = "rateBento",
    type = "Array",
    des = "便当评分",
    detail = "num#id"
  },
  {
    name = "num",
    type = "Double",
    des = "概率变化",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "对应文本",
    arg0 = "TextFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "eatPrefab",
    type = "String",
    des = "吃便当预制体",
    arg0 = ""
  },
  {
    mod = "家园配置",
    name = "eatEffect",
    type = "String",
    des = "吃饭特效",
    arg0 = ""
  },
  {
    mod = "家园配置",
    name = "playerEatAni",
    type = "Array",
    des = "列车长吃饭动作",
    detail = "animation"
  },
  {
    name = "animation",
    type = "String",
    des = "动作名称",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "memberEatAni",
    type = "String",
    des = "队员陪吃动作",
    arg0 = ""
  },
  {
    mod = "家园配置",
    name = "memberTrustAddtion",
    type = "Int",
    des = "队员陪吃额外默契度",
    arg0 = "50"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "更衣室面板显示"
  },
  {
    mod = "家园配置",
    name = "dressTypeOrder",
    type = "Array",
    des = "服装类型顺序",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "服装类型",
    arg0 = "TagFactory",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "defaultDressType",
    type = "Factory",
    des = "默认服装类型",
    arg0 = "TagFactory",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "大头贴机"
  },
  {
    mod = "家园配置",
    name = "stickerCost",
    type = "Array",
    des = "拍照消耗",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗道具ID",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "金额",
    arg0 = "50"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "HBPStoreList",
    type = "Array",
    des = "海豹券兑换商店列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "开启商店",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "炮台"
  },
  {
    mod = "家园配置",
    name = "costNum",
    type = "Array",
    des = "解锁花费",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品ID",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "headWeaponNum",
    type = "Int",
    des = "车头武装栏位数量",
    arg0 = "2"
  },
  {
    mod = "家园配置",
    name = "bodyWeaponNum",
    type = "Int",
    des = "车厢武装栏位数量",
    arg0 = "2"
  },
  {
    mod = "家园配置",
    name = "weaponBag",
    type = "Int",
    des = "武装仓库容量",
    arg0 = "200"
  },
  {
    mod = "家园配置",
    name = "initGrade",
    type = "Int",
    des = "初始武装等级",
    arg0 = "1"
  },
  {
    mod = "家园配置",
    name = "gradelist",
    type = "Array",
    des = "武装等级列表",
    detail = "quality#grademax#id"
  },
  {
    name = "quality",
    type = "Enum",
    des = "品质",
    arg0 = "white#blue#purple#golden"
  },
  {
    name = "grademax",
    type = "Int",
    des = "最高等级",
    arg0 = "15"
  },
  {
    name = "id",
    type = "Factory",
    des = "武装升级数据",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "costItemList",
    type = "Array",
    des = "消耗材料列表",
    detail = "id#num#coefficient"
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗材料",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "初始数量",
    arg0 = "1"
  },
  {
    name = "coefficient",
    type = "Int",
    des = "消耗系数",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "selectNum",
    type = "Int",
    des = "选中数量上限",
    arg0 = "20"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "垃圾"
  },
  {
    mod = "家园配置",
    name = "overflowtime",
    type = "Int",
    des = "垃圾溢出时间h",
    arg0 = "48"
  },
  {
    mod = "家园配置",
    name = "ReduceCleanliness",
    type = "Double",
    des = "溢出清洁度降低",
    arg0 = "0.2"
  },
  {
    mod = "家园配置",
    name = "stackingquantity",
    type = "Int",
    des = "垃圾叠加数量",
    arg0 = "10"
  },
  {
    mod = "家园配置",
    name = "CompressNum",
    type = "Int",
    des = "每x垃圾压缩成块",
    arg0 = "100"
  },
  {
    mod = "家园配置",
    name = "CompressTime",
    type = "Int",
    des = "每次压缩耗时s",
    arg0 = "900"
  },
  {
    mod = "家园配置",
    name = "autoModeLevel",
    type = "Int",
    des = "自动开启等级",
    arg0 = "11"
  },
  {
    mod = "家园配置",
    name = "secondOpenLevel",
    type = "Int",
    des = "第2通道开启等级",
    arg0 = "6"
  },
  {
    mod = "家园配置",
    name = "thirdOpenLevel",
    type = "Int",
    des = "第3通道开启等级",
    arg0 = "11"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "列车工厂相关配置"
  },
  {
    mod = "家园配置",
    name = "passengerMinimum",
    type = "Int",
    des = "载客最低限制",
    arg0 = "8"
  },
  {
    mod = "家园配置",
    name = "trainlong",
    type = "Int",
    des = "列车最短长度（含车头）",
    arg0 = "3"
  },
  {
    mod = "家园配置",
    name = "trainlength",
    type = "Int",
    des = "列车最长长度（含车头）",
    arg0 = "8"
  },
  {
    mod = "家园配置",
    name = "distanceone",
    type = "Int",
    des = "距离区间1",
    arg0 = "100"
  },
  {
    mod = "家园配置",
    name = "distancetwo",
    type = "Int",
    des = "距离区间2",
    arg0 = "200"
  },
  {
    mod = "家园配置",
    name = "distancethree",
    type = "Int",
    des = "距离区间3",
    arg0 = "300"
  },
  {
    mod = "家园配置",
    name = "presetquantity",
    type = "Int",
    des = "预设数量",
    arg0 = "3"
  },
  {
    mod = "家园配置",
    name = "coefficientone",
    type = "Int",
    des = "系数1",
    arg0 = "2"
  },
  {
    mod = "家园配置",
    name = "coefficienttwo",
    type = "Int",
    des = "系数2",
    arg0 = "5000"
  },
  {
    mod = "家园配置",
    name = "coefficientthree",
    type = "Int",
    des = "系数3",
    arg0 = "50"
  },
  {
    mod = "家园配置",
    name = "repairpriceList",
    type = "Array",
    des = "每点耐久维修价格",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗道具",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "5"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "autorepair",
    type = "Double",
    des = "自动维修比例",
    arg0 = "0.5"
  },
  {
    mod = "家园配置",
    name = "maintaindistance",
    type = "Int",
    des = "保养距离km",
    arg0 = "20000"
  },
  {
    mod = "家园配置",
    name = "maintainpriceList",
    type = "Array",
    des = "每节保养价格",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗道具",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "5000"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "slowdown",
    type = "Double",
    des = "不保养降低车速比例",
    arg0 = "0.2"
  },
  {
    mod = "家园配置",
    name = "cleannum",
    type = "Double",
    des = "清洁度上限",
    arg0 = "1"
  },
  {
    mod = "家园配置",
    name = "Unitdistance",
    type = "Int",
    des = "单位距离km",
    arg0 = "100"
  },
  {
    mod = "家园配置",
    name = "Reduceclean",
    type = "Double",
    des = "降低清洁度",
    arg0 = "0.01"
  },
  {
    mod = "家园配置",
    name = "cleancoefficientone",
    type = "Int",
    des = "清洁度系数1",
    arg0 = "105"
  },
  {
    mod = "家园配置",
    name = "cleancoefficienttwoList",
    type = "Array",
    des = "清洁度系数2",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗道具",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "10"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "cleanone",
    type = "Double",
    des = "清洁度区间1",
    arg0 = "0.8"
  },
  {
    mod = "家园配置",
    name = "cleantwo",
    type = "Double",
    des = "清洁度区间2",
    arg0 = "0.3"
  },
  {
    mod = "家园配置",
    name = "electricLevelList",
    type = "Array",
    des = "解锁列车车厢上限",
    detail = "lv"
  },
  {
    name = "lv",
    type = "Int",
    des = "电力等级",
    arg0 = "0",
    pythonName = "id"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "buildSaleList",
    type = "Array",
    des = "车厢建造打折",
    detail = "discountRange"
  },
  {
    name = "discountRange",
    type = "Double",
    des = "打折幅度",
    arg0 = "0.5",
    pythonName = "id"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "TrainFactoryScenes",
    type = "String",
    des = "列车工厂场景",
    arg0 = "Loading_Matou_zhengbei"
  },
  {
    mod = "家园配置",
    name = "OilLevelList",
    type = "Array",
    des = "燃油升级列表",
    detail = "OilLevel#id#OilNum#speeduptime#speedup"
  },
  {
    name = "OilLevel",
    type = "Int",
    des = "燃油改造等级",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "升到下级所需材料",
    arg0 = "ListFactory"
  },
  {
    name = "OilNum",
    type = "Int",
    des = "燃油数量增加",
    arg0 = "1"
  },
  {
    name = "speeduptime",
    type = "Int",
    des = "加速时间增加（s）",
    arg0 = "1"
  },
  {
    name = "speedup",
    type = "Int",
    des = "加速速度增加",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "speedUpList",
    type = "Array",
    des = "加速升级列表",
    detail = "Level#id#Num"
  },
  {
    name = "Level",
    type = "Int",
    des = "加速系统等级",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "升到下级所需材料",
    arg0 = "ListFactory"
  },
  {
    name = "Num",
    type = "Double",
    des = "加速度增加",
    arg0 = "0.5"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "slowDownList",
    type = "Array",
    des = "刹车升级列表",
    detail = "Level#id#Num"
  },
  {
    name = "Level",
    type = "Int",
    des = "刹车系统等级",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "升到下级所需材料",
    arg0 = "ListFactory"
  },
  {
    name = "Num",
    type = "Int",
    des = "减速度增加",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "normalCarriageList",
    type = "Array",
    des = "通用车厢",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "类型",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "accessoryList",
    type = "Array",
    des = "配件顺序",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "类型",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "banCarriageList",
    type = "Array",
    des = "不可拆卸车厢",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "类型",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "挂机"
  },
  {
    mod = "家园配置",
    name = "successNum",
    type = "Double",
    des = "判断成功参数",
    arg0 = "1"
  },
  {
    mod = "家园配置",
    name = "timeInterval",
    type = "Array",
    des = "间隔时间",
    detail = "min#max"
  },
  {
    name = "min",
    type = "Double",
    des = "最短间隔时间",
    arg0 = "1"
  },
  {
    name = "max",
    type = "Double",
    des = "最长间隔时间",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "eventList",
    type = "Array",
    des = "事件列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "刷新事件",
    arg0 = "AFKEventFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "coachCosttwoList",
    type = "Array",
    des = "列车维护（保养）",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "总消耗",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "coachCostthreeList",
    type = "Array",
    des = "列车维护（损毁）",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "总消耗",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "timePermit",
    type = "Int",
    des = "时间上限",
    arg0 = "1"
  },
  {
    mod = "家园配置",
    name = "awardCoefficient",
    type = "Double",
    des = "挂机奖励系数",
    arg0 = "1"
  },
  {
    mod = "家园配置",
    name = "onhookAward",
    type = "Array",
    des = "挂机奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励物品",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "生物净化时长分类"
  },
  {
    mod = "家园配置",
    name = "typeList",
    type = "Array",
    des = "生物净化时间分类",
    detail = "purifyTime",
    pyIgnore = true
  },
  {
    name = "purifyTime",
    type = "Int",
    des = "净化时长",
    arg0 = "24",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "扭蛋"
  },
  {
    mod = "家园配置",
    name = "capsuleList",
    type = "Array",
    des = "扭蛋列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "扭蛋池",
    arg0 = "ExtractFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "storeList",
    type = "Array",
    des = "装扮商店列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "开启商店",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "区域驱逐度"
  },
  {
    mod = "家园配置",
    name = "expelNum",
    type = "Int",
    des = "驱逐度上限",
    arg0 = "100"
  },
  {
    mod = "家园配置",
    name = "areaList",
    type = "Array",
    des = "区域列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "区域",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "levelRefreshTime",
    type = "String",
    des = "刷新时间",
    arg0 = ""
  },
  {
    mod = "家园配置",
    name = "moneyList",
    type = "Array",
    des = "悬赏关卡刷新道具",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "offerQuestMax",
    type = "Int",
    des = "悬赏关卡上限",
    arg0 = "8"
  },
  {
    mod = "家园配置",
    name = "investMoneyList",
    type = "Array",
    des = "投资刷新道具",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "喝酒"
  },
  {
    mod = "家园配置",
    name = "drinkRefreshType",
    type = "Enum",
    des = "喝酒刷新类型",
    arg0 = "daily#switchStation",
    arg1 = "daily"
  },
  {
    mod = "家园配置",
    name = "firstDrinkBuff",
    type = "Factory",
    des = "首次喝酒BUFF",
    arg0 = "HomeBuffFactory"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "报案相关",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "energyEnd",
    type = "Int",
    des = "报案关卡结算消耗体力",
    arg0 = "10"
  },
  {
    mod = "家园配置",
    name = "shareEnergyEnd",
    type = "Int",
    des = "分享关卡结算消耗体力",
    arg0 = "10"
  },
  {
    mod = "家园配置",
    name = "returnCoefficient",
    type = "Double",
    des = "返还系数",
    arg0 = "0.7"
  },
  {
    mod = "家园配置",
    name = "overtime",
    type = "Int",
    des = "超时时间（秒）",
    arg0 = "1200"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "拖车配置",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "trainHelpCost",
    type = "Double",
    des = "拖车费用",
    arg0 = "0.5"
  },
  {
    mod = "家园配置",
    name = "trainHelpSpeed",
    type = "Int",
    des = "工程车速度",
    arg0 = "100",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "trainHelpSpeedAdd",
    type = "Int",
    des = "工程车行驶加速度",
    arg0 = "20",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "trainHelpSpeedDec",
    type = "Int",
    des = "工程车行驶减速度",
    arg0 = "10",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "trainHelpDec",
    type = "Double",
    des = "工程车出生点与玩家间的距离",
    arg0 = "1000",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "trainHelpLook",
    type = "Factory",
    des = "工程车外形",
    arg0 = "HomeCoachSkinFactory",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "weaponCreate",
    type = "Factory",
    des = "列车武器制造",
    arg0 = "HomeStationFactory"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "动态难度配置",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "difficultyTransMutiple",
    type = "Double",
    des = "动态难度文本变化速率",
    arg0 = "1"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "拦路怪部分",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "meetCoefficient",
    type = "Double",
    des = "威慑度遇怪系数",
    arg0 = "1"
  },
  {
    mod = "家园配置",
    name = "buyGoldInit",
    type = "Int",
    des = "花钱买路基础金币",
    arg0 = "500"
  },
  {
    mod = "家园配置",
    name = "balloonItem",
    type = "Factory",
    des = "诱饵气球道具",
    arg0 = "ItemFactory"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "作战中心出售",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "saleConvertConstruct",
    type = "Int",
    des = "出售增加建设度数量",
    arg0 = "2000"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "淘金乐园玩法",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "isPark",
    type = "Array",
    des = "乐园关联车站",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "车站id",
    arg0 = "HomeStationFactory"
  },
  {name = "end"},
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "高价回收",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "highNumMin",
    type = "Int",
    des = "高价数量最小值",
    arg0 = "4"
  },
  {
    mod = "家园配置",
    name = "highNumMax",
    type = "Int",
    des = "高价数量最大值",
    arg0 = "8"
  },
  {
    mod = "家园配置",
    name = "highCoefficient",
    type = "Double",
    des = "高价系数",
    arg0 = "1.2"
  },
  {
    mod = "家园配置",
    name = "",
    type = "SysLine",
    des = "小人上限",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "MinShowNum",
    type = "Double",
    des = "出现数量最小随机数",
    arg0 = "1.0",
    pyIgnore = true
  },
  {
    mod = "家园配置",
    name = "MaxShowNum",
    type = "Double",
    des = "出现数量最大随机数",
    arg0 = "1.0",
    pyIgnore = true
  },
  {
    mod = "任务完成类型表",
    name = "passAnyLevel",
    type = "Array",
    des = "通关任意关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passAnyMainLevel",
    type = "Array",
    des = "通关任意主线关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passAnySafeLevel",
    type = "Array",
    des = "通关任意治安关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passAnyDangerLevel",
    type = "Array",
    des = "通关任意悬赏关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passBylevelId",
    type = "Array",
    des = "通关指定ID关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passByChapterId",
    type = "Array",
    des = "通关指定ID副本",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passBylevelIdAndGrade",
    type = "Array",
    des = "以指定评分通关指定ID关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passAnyLevelByGrade",
    type = "Array",
    des = "以指定评分通关任意关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passMainLevelByGrade",
    type = "Array",
    des = "以指定评分通关任意主线关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passSafeLevelLimitCity",
    type = "Array",
    des = "通关指定城市的治安关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passSafeSideLevelLimitPool",
    type = "Array",
    des = "通关指定治安池支线关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "enterCity",
    type = "Array",
    des = "进入城市",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "upOperation",
    type = "Array",
    des = "升级操作",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "itemCost",
    type = "Array",
    des = "消耗金币",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "dayLog",
    type = "Array",
    des = "每日登录",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passAnyResLevel",
    type = "Array",
    des = "通关任意资源关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "energyCost",
    type = "Array",
    des = "消耗体力",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "useShield",
    type = "Array",
    des = "使用护盾",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "dizziness",
    type = "Array",
    des = "眩晕",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "cure",
    type = "Array",
    des = "治疗",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "cardColor",
    type = "Array",
    des = "使用某颜色卡牌",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "beatAnyEnemy",
    type = "Array",
    des = "击败任意敌方单位",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "beatAppointBoss",
    type = "Array",
    des = "击败指定BOSS",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "discard",
    type = "Array",
    des = "弃置手牌",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "passAnyHighLevel",
    type = "Array",
    des = "通关任意高难关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "skillUp",
    type = "Array",
    des = "技能升级操作",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "onceProfit",
    type = "Array",
    des = "单笔利润达成",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "addProfit",
    type = "Array",
    des = "累计赚到铁盟币",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "addWeight",
    type = "Array",
    des = "累计货运交易品",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "addPeople",
    type = "Array",
    des = "累计客运人次",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "addDrinkNum",
    type = "Array",
    des = "累计喝一杯",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "invest",
    type = "Array",
    des = "投资金额",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "travel",
    type = "Array",
    des = "行驶路程",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "finishOrder",
    type = "Array",
    des = "完成订单数量",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "solicitCustomer",
    type = "Array",
    des = "招揽客人",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "priceDownWin",
    type = "Array",
    des = "成功砍价",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "priceUpWin",
    type = "Array",
    des = "成功抬价",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "gainFans",
    type = "Array",
    des = "获得粉丝",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "trade",
    type = "Array",
    des = "卖出交易品",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "gacha",
    type = "Array",
    des = "抽卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "getAnyCharacter",
    type = "Array",
    des = "获得新角色",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "roleGrade",
    type = "Array",
    des = "角色到达一定等级",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "resonance",
    type = "Array",
    des = "累积共振次数",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "awake",
    type = "Array",
    des = "累积觉醒次数",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "eatBento",
    type = "Array",
    des = "累积吃便当",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "entertain",
    type = "Array",
    des = "累积请客次数",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "trainWash",
    type = "Array",
    des = "累积洗车次数",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "trainMaintain",
    type = "Array",
    des = "累积保养次数",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "trainRepair",
    type = "Array",
    des = "累积修理次数",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "trainRemould",
    type = "Array",
    des = "累积改造次数",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "carriageBuild",
    type = "Array",
    des = "车厢建造",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "petFeed",
    type = "Array",
    des = "饲养宠物次数",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "aquariumFeed",
    type = "Array",
    des = "饲养水族",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "botanyPlant",
    type = "Array",
    des = "种植绿植",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "buyItem",
    type = "Array",
    des = "商店购买指定道具",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "elecLevelUp",
    type = "Array",
    des = "升级电力",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "trainLength",
    type = "Array",
    des = "列车节数",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "receiveOrder",
    type = "Array",
    des = "接取商会订单|可指定任务ID，不配则为所有订单",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "sellItem",
    type = "Array",
    des = "卖出指定货物",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "sellItemServer",
    type = "Array",
    des = "全服卖出指定货物",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "任务完成类型表",
    name = "sellItemProfit",
    type = "Array",
    des = "卖出指定货物统计利润",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "日常任务表",
    name = "questNum",
    type = "Int",
    des = "日常任务栏",
    arg0 = "5"
  },
  {
    mod = "日常任务表",
    name = "dailyQuestList",
    type = "Array",
    des = "日常任务表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务列表",
    arg0 = "ListFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "刷新数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "日常任务表",
    name = "apRewardList",
    type = "Array",
    des = "活跃度奖励",
    detail = "ap#id#num"
  },
  {
    name = "ap",
    type = "Int",
    des = "活跃度",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "日常任务表",
    name = "getCost",
    type = "Array",
    des = "领取消耗",
    detail = "getnum#id#num"
  },
  {
    name = "getnum",
    type = "Int",
    des = "领取次数",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "日常任务表",
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    mod = "日常任务表",
    name = "weeklyQuestList",
    type = "Array",
    des = "周常任务表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "周常任务",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "日常任务表",
    name = "wApRewardList",
    type = "Array",
    des = "周活跃度奖励",
    detail = "ap#id#num"
  },
  {
    name = "ap",
    type = "Int",
    des = "活跃度",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "日常任务表",
    name = "isOpen",
    type = "Bool",
    des = "是否开启周切换栏",
    arg0 = "true"
  },
  {
    mod = "公告配置",
    name = "",
    type = "SysLine",
    des = "版本信息"
  },
  {
    mod = "公告配置",
    name = "version",
    type = "StringT",
    des = "版本号",
    arg0 = ""
  },
  {
    mod = "默认设置",
    name = "dailyRefreshTime",
    type = "String",
    des = "日常刷新时间",
    arg0 = "05:00:00"
  },
  {
    mod = "默认设置",
    name = "resonanceUnlockLevel",
    type = "Int",
    des = "共振解锁等级",
    arg0 = "1"
  },
  {
    mod = "默认设置",
    name = "activityItem",
    type = "Factory",
    des = "活跃度道具",
    arg0 = "ItemFactory"
  },
  {
    mod = "默认设置",
    name = "wActivityItem",
    type = "Factory",
    des = "周活跃度道具",
    arg0 = "ItemFactory"
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "仓库"
  },
  {
    mod = "默认设置",
    name = "equipmentBag",
    type = "Int",
    des = "装备仓库初始容量",
    arg0 = "100"
  },
  {
    mod = "默认设置",
    name = "itemBag",
    type = "Int",
    des = "道具仓库初始容量",
    arg0 = "1000"
  },
  {
    mod = "默认设置",
    name = "materialBag",
    type = "Int",
    des = "材料仓库初始容量",
    arg0 = "1000"
  },
  {
    mod = "默认设置",
    name = "furnitureBag",
    type = "Int",
    des = "家具仓库初始容量",
    arg0 = "1000"
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "玩家"
  },
  {
    mod = "默认设置",
    name = "playerHeadList",
    type = "Array",
    des = "默认头像"
  },
  {
    name = "playerHeadPath",
    type = "Png",
    des = "头像路径",
    arg0 = "",
    arg1 = "146|146"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "playerSpineList",
    type = "Array",
    des = "默认立绘"
  },
  {
    name = "id",
    type = "Factory",
    des = "单位id",
    arg0 = "UnitFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "profilePhotoM",
    type = "Factory",
    des = "男角色头像",
    arg0 = "ProfilePhotoFactory"
  },
  {
    mod = "默认设置",
    name = "profilePhotoW",
    type = "Factory",
    des = "女角色头像",
    arg0 = "ProfilePhotoFactory"
  },
  {
    mod = "默认设置",
    name = "ratioExp",
    type = "Int",
    des = "玩家经验获取比例",
    arg0 = "1"
  },
  {
    mod = "默认设置",
    name = "levelMax",
    type = "Int",
    des = "玩家等级上限",
    arg0 = "100"
  },
  {
    mod = "默认设置",
    name = "renameCost",
    type = "Array",
    des = "改名消耗",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具ID",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "300"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "gachaRecord",
    type = "Int",
    des = "抽卡记录保存天数",
    arg0 = "90"
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "类型对应"
  },
  {
    mod = "默认设置",
    name = "equipTagList",
    type = "Array",
    des = "类型对应列表"
  },
  {
    name = "equipTagId",
    type = "Factory",
    des = "类型ID",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "关卡评分参数"
  },
  {
    mod = "默认设置",
    name = "stime01",
    type = "Int",
    des = "时间参数1",
    arg0 = "7"
  },
  {
    mod = "默认设置",
    name = "slive01",
    type = "Int",
    des = "人数参数1",
    arg0 = "500"
  },
  {
    mod = "默认设置",
    name = "slive02",
    type = "Int",
    des = "人数参数2",
    arg0 = "100"
  },
  {
    mod = "默认设置",
    name = "sdiff01",
    type = "Double",
    des = "普通难度",
    arg0 = "1.0"
  },
  {
    mod = "默认设置",
    name = "sdiff02",
    type = "Double",
    des = "困难难度",
    arg0 = "1.5"
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "结算"
  },
  {
    mod = "默认设置",
    name = "nextTime",
    type = "Double",
    des = "自动下一步时间",
    arg0 = "10"
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "主界面商城"
  },
  {
    mod = "默认设置",
    name = "storeMainList",
    type = "Array",
    des = "主商店列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "类型ID",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "diamondStoreList",
    type = "Array",
    des = "购买桦石商店列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "类型ID",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "moonStoreList",
    type = "Array",
    des = "黑月商店列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "类型ID",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "mainStoreList",
    type = "Array",
    des = "主页商店列表",
    detail = "name#id#pngSelect#pngNotSelect"
  },
  {
    name = "name",
    type = "StringT",
    des = "标签名称"
  },
  {
    name = "id",
    type = "Factory",
    des = "商店ID",
    arg0 = "ListFactory"
  },
  {
    name = "pngSelect",
    type = "Png",
    des = "标签图案(选中)",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "pngNotSelect",
    type = "Png",
    des = "标签图案(未选中)",
    arg0 = "",
    arg1 = "100|100"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "homeStoreList",
    type = "Array",
    des = "装扮商店列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "开启商店",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "体力澄明度相关"
  },
  {
    mod = "默认设置",
    name = "energyItemList",
    type = "Array",
    des = "体力道具列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具列表",
    arg0 = "ItemFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "energyStatementList",
    type = "Array",
    des = "澄明度状态",
    detail = "ratioMin#ratioMax#bg#display#scroll"
  },
  {
    name = "ratioMin",
    type = "Double",
    des = "状态程度比值最小",
    arg0 = "0"
  },
  {
    name = "ratioMax",
    type = "Double",
    des = "状态程度比值最大",
    arg0 = "1"
  },
  {
    name = "bg",
    type = "Png",
    des = "背景图",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "display",
    type = "Png",
    des = "电视屏幕状态图",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "scroll",
    type = "Factory",
    des = "滚动字",
    arg0 = "TextFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "energyAddNum",
    type = "Int",
    des = "购买行动力单次增加值",
    arg0 = "50"
  },
  {
    mod = "默认设置",
    name = "energyMoneyCost",
    type = "Array",
    des = "购买行动力消耗",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具ID",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "50"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "energyAddMax",
    type = "Int",
    des = "购买行动力上限",
    arg0 = "10"
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "界面缓动"
  },
  {
    mod = "默认设置",
    name = "startAlpha",
    type = "Double",
    des = "初始透明度",
    arg0 = "0"
  },
  {
    mod = "默认设置",
    name = "endAlpha",
    type = "Double",
    des = "结束透明度",
    arg0 = "1"
  },
  {
    mod = "默认设置",
    name = "alphaTime",
    type = "Double",
    des = "缓动时间",
    arg0 = "0.2"
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "好友"
  },
  {
    mod = "默认设置",
    name = "friendsListMax",
    type = "Int",
    des = "好友人数上限",
    arg0 = "30"
  },
  {
    mod = "默认设置",
    name = "blacklistMax",
    type = "Int",
    des = "黑名单上限",
    arg0 = "30"
  },
  {
    mod = "默认设置",
    name = "requestListMax",
    type = "Int",
    des = "未处理申请上限",
    arg0 = "30"
  },
  {
    mod = "默认设置",
    name = "dailyRequestMax",
    type = "Int",
    des = "每日发送申请上限",
    arg0 = "100"
  },
  {
    mod = "默认设置",
    name = "searchCD",
    type = "Int",
    des = "玩家搜索间隔",
    arg0 = "10"
  },
  {
    mod = "默认设置",
    name = "messageBoardMax",
    type = "Int",
    des = "留言板上限",
    arg0 = "20"
  },
  {
    mod = "默认设置",
    name = "messageWordMax",
    type = "Int",
    des = "留言字数上限",
    arg0 = "20"
  },
  {
    mod = "默认设置",
    name = "requestWordMax",
    type = "Int",
    des = "好友验证字数上限",
    arg0 = "15"
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "经验道具"
  },
  {
    mod = "默认设置",
    name = "expSourceMaterialList",
    type = "Array",
    des = "经验道具",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "SourceMaterialFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "剧情任务"
  },
  {
    mod = "默认设置",
    name = "storyQuestChapterList",
    type = "Array",
    des = "章节列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "章节",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "资源章节"
  },
  {
    mod = "默认设置",
    name = "resourceChapterList",
    type = "Array",
    des = "资源章节",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "ChapterFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "试练场"
  },
  {
    mod = "默认设置",
    name = "testLevelId",
    type = "Factory",
    des = "单角色试练场关卡",
    arg0 = "LevelFactory"
  },
  {
    mod = "默认设置",
    name = "challengeLevelList",
    type = "Array",
    des = "挑战关卡列表",
    detail = "unitId#levelId"
  },
  {
    name = "unitId",
    type = "Factory",
    des = "BOSS",
    arg0 = "UnitFactory"
  },
  {
    name = "levelId",
    type = "Factory",
    des = "关卡",
    arg0 = "LevelFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "LoadingTextList",
    type = "Array",
    des = "加载文字列表",
    detail = "textId"
  },
  {
    name = "textId",
    type = "Factory",
    des = "加载文字",
    arg0 = "TextFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "掉落排序列表"
  },
  {
    mod = "默认设置",
    name = "DropSortList",
    type = "Array",
    des = "掉落排序列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "掉落ID",
    arg0 = "ItemFactory"
  },
  {name = "end"},
  {
    mod = "随机昵称配置",
    name = "firstNameList",
    type = "Array",
    des = "姓氏",
    detail = "firstName"
  },
  {
    name = "firstName",
    type = "String",
    des = "姓氏",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "随机昵称配置",
    name = "secondNameList",
    type = "Array",
    des = "名字",
    detail = "secondName"
  },
  {
    name = "secondName",
    type = "String",
    des = "名字",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "节假日配置",
    name = "notes",
    type = "String",
    des = "有效日期|需要每年更新！！！",
    arg0 = ""
  },
  {
    mod = "节假日配置",
    name = "holidayList",
    type = "Array",
    des = "节假日表",
    detail = "day"
  },
  {
    name = "day",
    type = "String",
    des = "日期",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "UI音效设置",
    name = "",
    type = "SysLine",
    des = "Loading"
  },
  {
    mod = "UI音效设置",
    name = "",
    type = "SysLine",
    des = "抽卡"
  },
  {
    mod = "UI音效设置",
    name = "gaizhang",
    type = "Factory",
    des = "抽卡盖章",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "huoche",
    type = "Factory",
    des = "抽卡火车",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "choukaN",
    type = "Factory",
    des = "抽卡N",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "choukaR",
    type = "Factory",
    des = "抽卡R",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "choukaSR",
    type = "Factory",
    des = "抽卡SR",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "choukaSSR",
    type = "Factory",
    des = "抽卡SSR",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "jiesuanN",
    type = "Factory",
    des = "结算N",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "jiesuanR",
    type = "Factory",
    des = "结算R",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "jiesuanSR",
    type = "Factory",
    des = "结算SR",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "jiesuanSSR",
    type = "Factory",
    des = "结算SSR",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "",
    type = "SysLine",
    des = "交易所"
  },
  {
    mod = "UI音效设置",
    name = "tradeBarginSuccessList",
    type = "Array",
    des = "砍价成功",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "音效",
    arg0 = "SoundFactory"
  },
  {name = "end"},
  {
    mod = "UI音效设置",
    name = "tradeRaiseSuccessList",
    type = "Array",
    des = "抬价成功",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "音效",
    arg0 = "SoundFactory"
  },
  {name = "end"},
  {
    mod = "UI音效设置",
    name = "tradeBargainFailureList",
    type = "Array",
    des = "议价失败",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "音效",
    arg0 = "SoundFactory"
  },
  {name = "end"},
  {
    mod = "UI音效设置",
    name = "tradeSettlementBuyList",
    type = "Array",
    des = "购买结算",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "音效",
    arg0 = "SoundFactory"
  },
  {name = "end"},
  {
    mod = "UI音效设置",
    name = "tradeSettlementSell",
    type = "Factory",
    des = "出售结算",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "needProfit2",
    type = "Int",
    des = "第2档所需利润",
    arg0 = "300000"
  },
  {
    mod = "UI音效设置",
    name = "tradeSettlementSell30W",
    type = "Factory",
    des = "第2档利润音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "needProfit3",
    type = "Int",
    des = "第3档所需利润",
    arg0 = "1000000"
  },
  {
    mod = "UI音效设置",
    name = "tradeSettlementSell100W",
    type = "Factory",
    des = "第3档利润音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "electricUp",
    type = "Factory",
    des = "电力升级成功音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "electricBuy",
    type = "Factory",
    des = "模块购买成功音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "gradeUp",
    type = "Factory",
    des = "列车长升级音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "repLevelUp",
    type = "Factory",
    des = "声望等级升级音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "TradeLevelUp",
    type = "Factory",
    des = "贸易等级升级音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "UI音效设置",
    name = "PlotTextChange",
    type = "Factory",
    des = "剧情文本切换音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "枚举配置",
    name = "",
    type = "SysLine",
    des = "装备类型"
  },
  {
    mod = "枚举配置",
    name = "enumEquipTypeList",
    type = "Array",
    des = "装备类型枚举",
    detail = "equipType"
  },
  {
    mod = "枚举配置",
    name = "equipType",
    type = "Factory",
    des = "装备类型标签",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "枚举配置",
    name = "commonRareList",
    type = "Array",
    des = "稀有度通用枚举",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "稀有度",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "枚举配置",
    name = "trainWeaponTypeList",
    type = "Array",
    des = "武装类型枚举",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "武装类型",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "枚举配置",
    name = "",
    type = "SysLine",
    des = "角色皮肤途径"
  },
  {
    mod = "枚举配置",
    name = "SkinGetWay",
    type = "Array",
    des = "皮肤获取途径"
  },
  {
    mod = "枚举配置",
    name = "id",
    type = "StringT",
    des = "途径名",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "枚举配置",
    name = "noRarityItem",
    type = "Array",
    des = "无稀有度商品",
    detail = "Factory"
  },
  {
    mod = "枚举配置",
    name = "Factory",
    type = "String",
    des = "无稀有度工厂名",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "枚举配置",
    name = "enemyCampEnumList",
    type = "Array",
    des = "敌方种类枚举",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "种类ID",
    arg0 = "TagFactory",
    arg1 = "阵营"
  },
  {name = "end"},
  {
    mod = "枚举配置",
    name = "enemyEnumSideList",
    type = "Array",
    des = "敌方阵营枚举",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "阵营ID",
    arg0 = "TagFactory",
    arg1 = "阵营"
  },
  {name = "end"},
  {
    mod = "枚举配置",
    name = "enemyStrengthEnumList",
    type = "Array",
    des = "敌方强度枚举",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "强度ID",
    arg0 = "TagFactory",
    arg1 = "敌人强度标签"
  },
  {name = "end"},
  {
    mod = "枚举配置",
    name = "bookCharacterSideEnumList",
    type = "Array",
    des = "图鉴角色阵营枚举",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "阵营ID",
    arg0 = "TagFactory",
    arg1 = "阵营"
  },
  {name = "end"},
  {
    mod = "宠物配置",
    name = "petScoresConfig",
    type = "Array",
    des = "宠物等级评分配置",
    detail = "level#Favorability#scores"
  },
  {
    name = "level",
    type = "Int",
    des = "等级",
    arg0 = "0"
  },
  {
    name = "Favorability",
    type = "Int",
    des = "亲密度每级上限",
    arg0 = "100"
  },
  {
    name = "scores",
    type = "Int",
    des = "每级增加评分",
    arg0 = "10"
  },
  {name = "end"},
  {
    mod = "宠物配置",
    name = "feederLoveUp",
    type = "Double",
    des = "饲养员亲密度加成",
    arg0 = "1"
  },
  {
    mod = "宠物配置",
    name = "TouchTimes",
    type = "Int",
    des = "每日可抚摸次数",
    arg0 = "3"
  },
  {
    mod = "宠物配置",
    name = "FavorabilityInt",
    type = "Array",
    des = "每次抚摸增加好感"
  },
  {
    name = "Max",
    type = "Int",
    des = "最大值",
    arg0 = "9"
  },
  {
    name = "Minimum",
    type = "Int",
    des = "最小值",
    arg0 = "3"
  },
  {name = "end"},
  {
    mod = "宠物配置",
    name = "DailyFavorability",
    type = "Int",
    des = "每天增加的好感度",
    arg0 = "0"
  },
  {
    mod = "宠物配置",
    name = "feedCount",
    type = "Int",
    des = "每天最大投喂次数",
    arg0 = "3"
  },
  {
    mod = "宠物配置",
    name = "feedAddition",
    type = "Double",
    des = "对应物种零食加成",
    arg0 = "1.5"
  },
  {
    mod = "宠物配置",
    name = "FavorabilityLimit",
    type = "Int",
    des = "每级好感上限",
    arg0 = "100"
  },
  {
    mod = "宠物配置",
    name = "petStateConfig",
    type = "Array",
    des = "宠物状态配置"
  },
  {
    name = "petStateMin",
    type = "Int",
    des = "状态等级下限",
    arg0 = "7"
  },
  {
    name = "petStateMax",
    type = "Int",
    des = "状态等级上限",
    arg0 = "9"
  },
  {
    name = "stateName",
    type = "StringT",
    des = "状态",
    arg0 = "一般"
  },
  {
    name = "petStateBuff",
    type = "Int",
    des = "宠物状态好感加成",
    arg0 = "100"
  },
  {name = "end"},
  {
    mod = "宠物配置",
    name = "petPersonalityList",
    type = "Array",
    des = "宠物性格",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "宠物性格",
    arg0 = "TagFactory",
    arg1 = "宠物性格"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "宠物配置",
    name = "petVarityList",
    type = "Array",
    des = "宠物物种",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "宠物物种",
    arg0 = "TagFactory",
    arg1 = "宠物物种"
  },
  {name = "end"},
  {
    mod = "宠物配置",
    name = "petTiesOpen",
    type = "Int",
    des = "宠物羁绊开启等级",
    arg0 = "8"
  },
  {
    mod = "宠物配置",
    name = "foodItemList",
    type = "Array",
    des = "宠物口粮",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "宠物口粮",
    arg0 = "SourceMaterialFactory",
    arg1 = "宠物口粮"
  },
  {name = "end"},
  {
    mod = "宠物配置",
    name = "favorItemList",
    type = "Array",
    des = "宠物零食",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "宠物零食",
    arg0 = "SourceMaterialFactory",
    arg1 = "宠物好感道具"
  },
  {name = "end"},
  {
    mod = "装备配置",
    name = "equipMaxLv",
    type = "Int",
    des = "装备最大等级",
    arg0 = "80"
  },
  {
    mod = "装备配置",
    name = "ChangeNum",
    type = "Int",
    des = "可替换词缀次数",
    arg0 = "10"
  },
  {
    mod = "装备配置",
    name = "LevelNum",
    type = "Int",
    des = "每X级解锁一条词缀",
    arg0 = "10"
  },
  {
    mod = "装备配置",
    name = "EquipPresetsNum",
    type = "Int",
    des = "装备预设数量",
    arg0 = "10"
  },
  {
    mod = "装备配置",
    name = "Orange",
    type = "Int",
    des = "UR基础经验",
    arg0 = "10000"
  },
  {
    mod = "装备配置",
    name = "Golden",
    type = "Int",
    des = "SSR基础经验",
    arg0 = "8000"
  },
  {
    mod = "装备配置",
    name = "Purple",
    type = "Int",
    des = "SR基础经验",
    arg0 = "5000"
  },
  {
    mod = "装备配置",
    name = "Blue",
    type = "Int",
    des = "R基础经验",
    arg0 = "3000"
  },
  {
    mod = "装备配置",
    name = "White",
    type = "Int",
    des = "N基础经验",
    arg0 = "2000"
  },
  {
    mod = "装备配置",
    name = "jewelryEx",
    type = "Double",
    des = "饰品额外消耗系数",
    arg0 = "1.5"
  },
  {
    mod = "装备配置",
    name = "Coefficient",
    type = "Double",
    des = "强化继承系数",
    arg0 = "0.8"
  },
  {
    mod = "装备配置",
    name = "UseNum",
    type = "Int",
    des = "强化消耗数量",
    arg0 = "20"
  },
  {
    mod = "装备配置",
    name = "Weapon",
    type = "Int",
    des = "武器词缀数量",
    arg0 = "4"
  },
  {
    mod = "装备配置",
    name = "Armor",
    type = "Int",
    des = "防具词缀数量",
    arg0 = "4"
  },
  {
    mod = "装备配置",
    name = "Ornaments",
    type = "Int",
    des = "饰品词缀数量",
    arg0 = "6"
  },
  {
    mod = "装备配置",
    name = "EquipTypeList",
    type = "Array",
    des = "装备类型排序值",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "装备类型",
    arg0 = "TagFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "排序参数",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "装备数值参数",
    name = "EquipParameterList",
    type = "Array",
    des = "装备数值参数",
    detail = "num"
  },
  {
    name = "num",
    type = "Double",
    des = "数值参数",
    arg0 = "0.1"
  },
  {name = "end"},
  {
    mod = "行驶辅助配置",
    name = "autoBuyRoadLv",
    type = "Int",
    des = "自动买路等级|开启拦路怪自动买路所需要的玩家等级",
    arg0 = "30"
  },
  {
    mod = "行驶辅助配置",
    name = "autoBuyRoadPath",
    type = "Path",
    des = "自动买路图标",
    arg0 = ""
  },
  {
    mod = "行驶辅助配置",
    name = "autoBuyRoadUnLock",
    type = "Array",
    des = "解锁材料",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "材料id",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "行驶辅助配置",
    name = "autoRushLv",
    type = "Int",
    des = "自动弹丸等级|开启自动使用弹丸所需要的玩家等级",
    arg0 = "5"
  },
  {
    mod = "行驶辅助配置",
    name = "autoRushPath",
    type = "Path",
    des = "自动弹丸图标",
    arg0 = ""
  },
  {
    mod = "行驶辅助配置",
    name = "autoRushUnLock",
    type = "Array",
    des = "解锁材料",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "材料id",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "行驶辅助配置",
    name = "autoStrikeLv",
    type = "Int",
    des = "自动撞角等级|开启拦路怪自动撞角所需要的玩家等级",
    arg0 = "30"
  },
  {
    mod = "行驶辅助配置",
    name = "autoStrikePath",
    type = "Path",
    des = "自动撞角图标",
    arg0 = ""
  },
  {
    mod = "行驶辅助配置",
    name = "aautoStrikeUnLock",
    type = "Array",
    des = "解锁材料",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "材料id",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "行驶辅助配置",
    name = "autoFightLv",
    type = "Int",
    des = "遇敌自动等级|开启拦路怪自动战斗所需要的玩家等级",
    arg0 = "30"
  },
  {
    mod = "行驶辅助配置",
    name = "autoFightPath",
    type = "Path",
    des = "遇敌自动图标",
    arg0 = ""
  },
  {
    mod = "行驶辅助配置",
    name = "autoFightUnLock",
    type = "Array",
    des = "解锁材料",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "材料id",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "列车配置",
    name = "pullOutTime",
    type = "Double",
    des = "出站动画时间（秒）",
    arg0 = "2"
  },
  {
    mod = "列车配置",
    name = "delayTime",
    type = "Double",
    des = "火车启动延迟",
    arg0 = "0.3"
  },
  {
    mod = "列车配置",
    name = "pullOutASpeed",
    type = "Double",
    des = "出站加速度（帧）",
    arg0 = "0.01"
  },
  {
    mod = "列车配置",
    name = "pullOutSpeedMax",
    type = "Double",
    des = "出站最大速度",
    arg0 = "3"
  },
  {
    mod = "列车配置",
    name = "accelerationRatio",
    type = "Double",
    des = "加速度倍率(武装词条用)",
    arg0 = "5"
  },
  {
    mod = "列车配置",
    name = "whistleSoundId",
    type = "Factory",
    des = "鸣笛音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "列车配置",
    name = "trainSoundId",
    type = "Factory",
    des = "火车音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "列车配置",
    name = "",
    type = "SysLine",
    des = "列车音效相关"
  },
  {
    mod = "列车配置",
    name = "soundDrive",
    type = "Factory",
    des = "开车音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "列车配置",
    name = "soundBrake",
    type = "Factory",
    des = "刹车音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "列车配置",
    name = "soundStop",
    type = "Factory",
    des = "停车音效",
    arg0 = "SoundFactory"
  },
  {
    mod = "列车配置",
    name = "voiceDeparture",
    type = "Array",
    des = "发车语音",
    detail = "id#type"
  },
  {
    name = "id",
    type = "Factory",
    des = "语音id|如果是动态语音，该项不填",
    arg0 = "SoundFactory"
  },
  {
    name = "type",
    type = "String",
    des = "动态类型|需要与程序制定字段对应的规则",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "列车配置",
    name = "voiceDeparturePassenger",
    type = "Array",
    des = "乘客发车语音",
    detail = "id#type"
  },
  {
    name = "id",
    type = "Factory",
    des = "语音id|如果是动态语音，该项不填",
    arg0 = "SoundFactory"
  },
  {
    name = "type",
    type = "String",
    des = "动态类型|需要与程序制定字段对应的规则",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "列车配置",
    name = "voiceWillArrive",
    type = "Array",
    des = "即将到站语音",
    detail = "id#type"
  },
  {
    name = "id",
    type = "Factory",
    des = "语音id|如果是动态语音，该项不填",
    arg0 = "SoundFactory"
  },
  {
    name = "type",
    type = "String",
    des = "动态类型|需要与程序制定字段对应的规则",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "列车配置",
    name = "voiceWillArrivePassenger",
    type = "Array",
    des = "乘客即将到站语音",
    detail = "id#type"
  },
  {
    name = "id",
    type = "Factory",
    des = "语音id|如果是动态语音，该项不填",
    arg0 = "SoundFactory"
  },
  {
    name = "type",
    type = "String",
    des = "动态类型|需要与程序制定字段对应的规则",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "列车配置",
    name = "voiceArrive",
    type = "Array",
    des = "到站语音",
    detail = "id#type"
  },
  {
    name = "id",
    type = "Factory",
    des = "语音id|如果是动态语音，该项不填",
    arg0 = "SoundFactory"
  },
  {
    name = "type",
    type = "String",
    des = "动态类型|需要与程序制定字段对应的规则",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "列车配置",
    name = "voiceArrivePassenger",
    type = "Array",
    des = "乘客到站语音",
    detail = "id#type"
  },
  {
    name = "id",
    type = "Factory",
    des = "语音id|如果是动态语音，该项不填",
    arg0 = "SoundFactory"
  },
  {
    name = "type",
    type = "String",
    des = "动态类型|需要与程序制定字段对应的规则",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "列车配置",
    name = "voiceGetIn",
    type = "Array",
    des = "进站语音",
    detail = "id#type"
  },
  {
    name = "id",
    type = "Factory",
    des = "语音id|如果是动态语音，该项不填",
    arg0 = "SoundFactory"
  },
  {
    name = "type",
    type = "String",
    des = "动态类型|需要与程序制定字段对应的规则",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "列车配置",
    name = "voiceGetInPassenger",
    type = "Array",
    des = "乘客进站语音",
    detail = "id#type"
  },
  {
    name = "id",
    type = "Factory",
    des = "语音id|如果是动态语音，该项不填",
    arg0 = "SoundFactory"
  },
  {
    name = "type",
    type = "String",
    des = "动态类型|需要与程序制定字段对应的规则",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "行情反转概率表",
    name = "reversalProbabilityList",
    type = "Array",
    des = "反转概率",
    detail = "quotation#probability"
  },
  {
    name = "quotation",
    type = "Double",
    des = "行情",
    arg0 = "1"
  },
  {
    name = "probability",
    type = "Double",
    des = "反转概率",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "行情反转概率表",
    name = "activityReversalProbabilityList",
    type = "Array",
    des = "活动反转概率",
    detail = "quotation#probability"
  },
  {
    name = "quotation",
    type = "Double",
    des = "行情",
    arg0 = "1"
  },
  {
    name = "probability",
    type = "Double",
    des = "反转概率",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "Loading文本",
    name = "enterMainUIList",
    type = "Array",
    des = "进入主界面背景",
    detail = "imagePath"
  },
  {
    name = "imagePath",
    type = "Png",
    des = "图片",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "Loading文本",
    name = "enterHomeUIList",
    type = "Array",
    des = "进入车厢背景",
    detail = "imagePath"
  },
  {
    name = "imagePath",
    type = "Png",
    des = "图片",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "Loading文本",
    name = "tipsList",
    type = "Array",
    des = "提示列表",
    detail = "tips"
  },
  {
    name = "tips",
    type = "TextT",
    des = "提示文本",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "Loading文本",
    name = "bigWorldTipsList",
    type = "Array",
    des = "大世界提示文本",
    detail = "tips"
  },
  {
    name = "tips",
    type = "TextT",
    des = "提示文本",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "默契相关配置",
    name = "trustExpList",
    type = "Array",
    des = "默契经验表"
  },
  {
    name = "exp",
    type = "Int",
    des = "升到下一级经验",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "默契相关配置",
    name = "",
    type = "SysLine",
    des = "关卡默契奖励"
  },
  {
    mod = "默契相关配置",
    name = "levelTrustExpList",
    type = "Array",
    des = "关卡类型默契奖励|索引=关卡类型"
  },
  {
    name = "exp",
    type = "Int",
    des = "获得默契值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "默契相关配置",
    name = "leaderExtra",
    type = "Double",
    des = "队长默契加成",
    arg0 = "0.2"
  },
  {
    mod = "默契相关配置",
    name = "",
    type = "SysLine",
    des = "觉醒默契奖励"
  },
  {
    mod = "默契相关配置",
    name = "awakeTrustExpList",
    type = "Array",
    des = "觉醒默契奖励"
  },
  {
    name = "exp",
    type = "Int",
    des = "获得默契值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "默契相关配置",
    name = "",
    type = "SysLine",
    des = "共振默契奖励"
  },
  {
    mod = "默契相关配置",
    name = "resonanceTrustExpList",
    type = "Array",
    des = "共振默契奖励"
  },
  {
    name = "exp",
    type = "Int",
    des = "获得默契值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "默契相关配置",
    name = "",
    type = "SysLine",
    des = "看板娘"
  },
  {
    mod = "默契相关配置",
    name = "trustExpInterval",
    type = "Int",
    arg0 = "1",
    des = "看板娘信任间隔|间隔是秒"
  },
  {
    mod = "默契相关配置",
    name = "clientGetExpInterval",
    type = "Int",
    arg0 = "1",
    des = "客户端领取间隔"
  },
  {
    mod = "默契相关配置",
    name = "talkIntervalMin",
    type = "Int",
    arg0 = "1",
    des = "最小说话间隔"
  },
  {
    mod = "默契相关配置",
    name = "talkIntervalRandom",
    type = "Int",
    arg0 = "1",
    des = "说话间隔随机区间"
  },
  {
    mod = "成就相关",
    name = "achievePointList",
    type = "Array",
    des = "成就点数列表",
    detail = "name#id#pngSelect#pngNotSelect"
  },
  {
    name = "name",
    type = "StringT",
    des = "类型名称",
    arg0 = ""
  },
  {
    name = "id",
    type = "Factory",
    des = "积分项",
    arg0 = "ListFactory"
  },
  {
    name = "pngSelect",
    type = "Png",
    des = "图标（选中）",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "pngNotSelect",
    type = "Png",
    des = "图标（未选中）",
    arg0 = "",
    arg1 = "100|100"
  },
  {name = "end"},
  {
    mod = "成就相关",
    name = "achieveList",
    type = "Array",
    des = "成就开启列表",
    detail = "name#id#pngSelect#pngNotSelect#pngGet#pngLittle#showMax"
  },
  {
    name = "name",
    type = "StringT",
    des = "类型名称",
    arg0 = ""
  },
  {
    name = "id",
    type = "Factory",
    des = "开启成就",
    arg0 = "ListFactory"
  },
  {
    name = "pngSelect",
    type = "Png",
    des = "图标（选中）",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "pngNotSelect",
    type = "Png",
    des = "图标（未选中）",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "pngGet",
    type = "Png",
    des = "成就获得时图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "pngLittle",
    type = "Png",
    des = "界面显示图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "showMax",
    type = "Int",
    des = "最多显示成就数量",
    arg0 = "4"
  },
  {name = "end"},
  {
    mod = "主界面配置",
    name = "funcbtnlist",
    type = "Array",
    des = "ESC功能按钮列表",
    detail = "icon#name#funcId#prefab#param",
    pyIgnore = true
  },
  {
    name = "icon",
    type = "Png",
    des = "图标",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "name",
    type = "String",
    des = "按钮名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "funcId",
    type = "Int",
    des = "功能ID",
    arg0 = "100",
    pyIgnore = true
  },
  {
    name = "prefab",
    type = "String",
    des = "预制",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "param",
    type = "String",
    des = "初始化参数",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "主界面配置",
    name = "mileageMax",
    type = "Int",
    des = "里程表最大值",
    arg0 = "99999999",
    pyIgnore = true
  },
  {
    mod = "主界面配置",
    name = "dashboardList",
    type = "Array",
    des = "仪表盘",
    detail = "changeSpeed#dashboardPath#maxSpeed",
    pyIgnore = true
  },
  {
    name = "changeSpeed",
    type = "Int",
    des = "更换表盘速度",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "dashboardPath",
    type = "String",
    des = "表盘路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "maxSpeed",
    type = "Int",
    des = "表盘最大速度",
    arg0 = "0",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "主界面配置",
    name = "bgList",
    type = "Array",
    des = "副官界面背景",
    detail = "changeTime#bgPath",
    pyIgnore = true
  },
  {
    name = "changeTime",
    type = "String",
    des = "变化时间",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "bgPath",
    type = "Png",
    des = "背景图",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "盆栽配置",
    name = "SizeOneList",
    type = "Array",
    des = "1格花盆列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "1格花盆",
    arg0 = "HomeFurnitureFactory"
  },
  {name = "end"},
  {
    mod = "盆栽配置",
    name = "SizeTwoList",
    type = "Array",
    des = "2格花盆列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "2格花盆",
    arg0 = "HomeFurnitureFactory"
  },
  {name = "end"},
  {
    mod = "盆栽配置",
    name = "SizeThreeList",
    type = "Array",
    des = "3格花盆列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "3格花盆",
    arg0 = "HomeFurnitureFactory"
  },
  {name = "end"},
  {
    mod = "盆栽配置",
    name = "SizeFourList",
    type = "Array",
    des = "4格花盆列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "4格花盆",
    arg0 = "HomeFurnitureFactory"
  },
  {name = "end"},
  {
    mod = "盆栽配置",
    name = "SizeFiveList",
    type = "Array",
    des = "5格花盆列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "5格花盆",
    arg0 = "HomeFurnitureFactory"
  },
  {name = "end"},
  {
    mod = "盆栽配置",
    name = "SizeSixList",
    type = "Array",
    des = "6格花盆列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "6格花盆",
    arg0 = "HomeFurnitureFactory"
  },
  {name = "end"},
  {
    mod = "车厢仓库",
    name = "Initialquantity",
    type = "Int",
    des = "初始车厢仓库数量",
    arg0 = "4"
  },
  {
    mod = "车厢仓库",
    name = "CarriagehouseList",
    type = "Array",
    des = "车厢仓库扩建价格",
    detail = "no#id#num"
  },
  {
    name = "no",
    type = "Int",
    des = "第几个车厢仓库",
    arg0 = "5"
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗道具",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "消耗数量",
    arg0 = "1000"
  },
  {name = "end"},
  {
    mod = "剧情回顾列表",
    name = "PlotReviewList",
    type = "Array",
    des = "剧情表"
  },
  {
    name = "ChapterList",
    type = "Factory",
    des = "大章节",
    arg0 = "PlotFactory"
  },
  {name = "end"},
  {
    mod = "功能开启",
    name = "funcList",
    type = "Array",
    des = "功能列表",
    detail = "funcId#name#iconPath#guideId#quest#isShow#tips",
    pyIgnore = true
  },
  {
    name = "funcId",
    type = "Int",
    des = "功能ID",
    arg0 = "100",
    pyIgnore = true
  },
  {
    name = "name",
    type = "StringT",
    des = "功能名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "iconPath",
    type = "Png",
    des = "图标",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "guideId",
    type = "Int",
    des = "解锁引导序号",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "quest",
    type = "Factory",
    des = "解锁任务",
    arg0 = "QuestFactory",
    pyIgnore = true
  },
  {
    name = "tips",
    type = "Factory",
    des = "未解锁提示",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "playerLevel",
    type = "Int",
    des = "解锁列车长等级",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "isShow",
    type = "Bool",
    des = "显示展示界面",
    arg0 = "False",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "首次进入引导",
    name = "guideList",
    type = "Array",
    des = "引导列表",
    detail = "id#ui#guideId#unlockQuest"
  },
  {
    name = "id",
    type = "Int",
    des = "序号",
    arg0 = "0"
  },
  {
    name = "ui",
    type = "String",
    des = "UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "guideId",
    type = "Factory",
    des = "引导",
    arg0 = "GuideFactory",
    pyIgnore = true
  },
  {
    name = "unlockQuest",
    type = "Factory",
    des = "保存后解锁任务",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "职级一览",
    name = "Playerranklist",
    type = "Array",
    des = "职级列表"
  },
  {
    Mod = "职级一览",
    name = "level",
    type = "Int",
    des = "等级",
    arg0 = "1"
  },
  {
    Mod = "职级一览",
    name = "id",
    type = "Factory",
    des = "对应职级",
    arg0 = "ListFactory",
    arg1 = "列车长职级"
  },
  {name = "end"},
  {
    mod = "随机展示列车",
    name = "randomTrainPre",
    type = "Double",
    des = "展示列车概率",
    arg0 = "0.5",
    pyIgnore = true
  },
  {
    mod = "随机展示列车",
    name = "showTrainPlayerMin",
    type = "Int",
    des = "玩家列车最小数量",
    arg0 = "1"
  },
  {
    mod = "随机展示列车",
    name = "showTrainPlayerMax",
    type = "Int",
    des = "玩家列车最大数量",
    arg0 = "10"
  },
  {
    mod = "随机展示列车",
    name = "randomTrainDisBirth",
    type = "Double",
    des = "生成时最小距离",
    arg0 = "2000",
    pyIgnore = true
  },
  {
    mod = "随机展示列车",
    name = "randomTrainDisDestroy",
    type = "Double",
    des = "销毁时最小距离",
    arg0 = "2000",
    pyIgnore = true
  },
  {
    mod = "随机展示列车",
    name = "trainList",
    type = "Array",
    des = "随机展示列车",
    detail = "weight#trainId",
    pyIgnore = true
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "trainId",
    type = "Factory",
    des = "列车外形",
    arg0 = "ListFactory",
    pyIgnore = true
  },
  {
    name = "speedMin",
    type = "Int",
    des = "列车最小速度",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "speedMax",
    type = "Int",
    des = "列车最大速度",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "speedAdd",
    type = "Int",
    des = "启动加速度",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "speedDec",
    type = "Int",
    des = "停车减速度",
    arg0 = "1",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "大世界环境",
    name = "environmentList",
    type = "Array",
    des = "一天的环境",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "环境列表id",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "skinState2Condition",
    type = "String",
    des = "皮肤精二条件"
  },
  {
    mod = "默认设置",
    name = "skinState2Num",
    type = "Int",
    des = "皮肤精二对应数值",
    arg0 = "ListFactory"
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "发动机核心"
  },
  {
    mod = "默认设置",
    name = "coreList",
    type = "Array",
    des = "核心列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "开启核心",
    arg0 = "ConfigFactory#EngineCoreFactory"
  },
  {name = "end"},
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "公告"
  },
  {
    mod = "默认设置",
    name = "NoticeAdress",
    type = "String",
    des = "公告地址",
    arg0 = ""
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "短信验证"
  },
  {
    mod = "默认设置",
    name = "limitTimes",
    type = "Int",
    des = "限制次数",
    arg0 = "6"
  },
  {
    mod = "默认设置",
    name = "maxTimes",
    type = "Int",
    des = "上限次数",
    arg0 = "30"
  },
  {
    mod = "默认设置",
    name = "BlockTime",
    type = "Int",
    des = "锁定时长",
    arg0 = "1200"
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "缩放设置"
  },
  {
    mod = "默认设置",
    name = "scaleCoefficient",
    type = "Int",
    des = "缩放比例",
    arg0 = "20",
    pyIgnore = true
  },
  {
    mod = "默认设置",
    name = "",
    type = "SysLine",
    des = "性别选择语音"
  },
  {
    mod = "默认设置",
    name = "maleSwitchVoice",
    type = "Factory",
    des = "男列车长语音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    mod = "默认设置",
    name = "femaleSwitchVoice",
    type = "Factory",
    des = "女列车长语音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    mod = "默认设置",
    name = "extractTabX",
    type = "Double",
    des = "卡池页签选中坐标",
    arg0 = "10"
  },
  {
    mod = "大世界污染",
    name = "linePlyerLv",
    type = "Int",
    des = "常规拦路所需玩家等级",
    arg0 = "10"
  },
  {
    mod = "大世界污染",
    name = "pollutePlyerLv",
    type = "Int",
    des = "所需玩家等级",
    arg0 = "10"
  },
  {
    mod = "大世界污染",
    name = "polluteQuestId",
    type = "Factory",
    des = "所需主线任务",
    arg0 = "QuestFactory"
  },
  {
    mod = "大世界污染",
    name = "polluteMin",
    type = "Int",
    des = "污染最小数量",
    arg0 = "1"
  },
  {
    mod = "大世界污染",
    name = "polluteMax",
    type = "Int",
    des = "污染最大数量",
    arg0 = "3"
  },
  {
    mod = "大世界污染",
    name = "pollutePlayerNum",
    type = "Int",
    des = "人数基数",
    arg0 = "5000"
  },
  {
    mod = "大世界污染",
    name = "polluteAreaList",
    type = "Array",
    des = "各区域污染",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "区域id",
    arg0 = "AreaFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "出现权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "大世界污染",
    name = "isClickPollute",
    type = "Bool",
    des = "开启混响浮标",
    arg0 = "true"
  },
  {
    mod = "大世界污染",
    name = "clickPolluteWeek",
    type = "Int",
    des = "浮标间隔周数",
    arg0 = "2"
  },
  {
    mod = "大世界污染",
    name = "isClickDungeon",
    type = "Bool",
    des = "开启点击副本",
    arg0 = "true"
  },
  {
    mod = "大世界污染",
    name = "clickDungeonWeek",
    type = "Int",
    des = "副本间隔周数",
    arg0 = "2"
  },
  {
    mod = "大世界污染",
    name = "polluteRegularList",
    type = "Array",
    des = "固定出现污染",
    detail = "id#startTime#endTime"
  },
  {
    name = "startTime",
    type = "String",
    des = "开始日期",
    arg0 = ""
  },
  {
    name = "endTime",
    type = "String",
    des = "结束日期",
    arg0 = ""
  },
  {
    name = "id",
    type = "Factory",
    des = "污染列表id",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "素材路径",
    name = "polluteIconPath",
    type = "Array",
    des = "污染等级图标",
    detail = "path"
  },
  {
    name = "path",
    type = "Png",
    des = "图标路径",
    arg0 = "",
    arg1 = "100|100"
  },
  {name = "end"},
  {
    mod = "节日奖励",
    name = "LevelLimit",
    type = "Int",
    des = "领取等级限制",
    arg0 = "1"
  },
  {
    mod = "节日奖励",
    name = "FestivalRewardList",
    type = "Array",
    des = "节日奖励列表",
    detail = "Festival#StartDate#EndDate#FestivalReward"
  },
  {
    mod = "节日奖励",
    name = "Festival",
    type = "String",
    des = "节日",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "节日奖励",
    name = "StartDate",
    type = "String",
    des = "开始时间",
    arg0 = "2023-01-01 00:00:00"
  },
  {
    mod = "节日奖励",
    name = "EndDate",
    type = "String",
    des = "结束时间",
    arg0 = "2023-01-01 24:00:00"
  },
  {
    mod = "节日奖励",
    name = "FestivalReward",
    type = "Factory",
    des = "奖励",
    arg0 = "ListFactory",
    arg1 = "节日奖励"
  },
  {name = "end", pyIgnore = true},
  {
    mod = "手账帮助",
    name = "tradeNoteList1",
    type = "Array",
    des = "交易笔记1开启条件",
    detail = "path#level"
  },
  {
    name = "path",
    type = "String",
    des = "图片组件",
    arg0 = ""
  },
  {
    name = "level",
    type = "Int",
    des = "解锁贸易等级",
    arg0 = "1"
  },
  {name = "end", pyIgnore = true},
  {
    mod = "手账帮助",
    name = "tradeNoteList2",
    type = "Array",
    des = "交易笔记2开启条件",
    detail = "path#level"
  },
  {
    name = "path",
    type = "String",
    des = "图片组件",
    arg0 = ""
  },
  {
    name = "level",
    type = "Int",
    des = "解锁贸易等级",
    arg0 = "1"
  },
  {name = "end", pyIgnore = true},
  {
    mod = "手账帮助",
    name = "tradeNoteList3",
    type = "Array",
    des = "交易笔记3开启条件",
    detail = "path#level",
    pyIgnore = true
  },
  {
    name = "path",
    type = "String",
    des = "图片组件",
    arg0 = ""
  },
  {
    name = "level",
    type = "Int",
    des = "解锁贸易等级",
    arg0 = "1"
  },
  {name = "end", pyIgnore = true},
  {
    mod = "手账帮助",
    name = "tradeNoteList4",
    type = "Array",
    des = "交易笔记4开启条件",
    detail = "path#level"
  },
  {
    name = "path",
    type = "String",
    des = "图片组件",
    arg0 = ""
  },
  {
    name = "level",
    type = "Int",
    des = "解锁贸易等级",
    arg0 = "1"
  },
  {name = "end", pyIgnore = true},
  {
    mod = "加载视频",
    name = "",
    type = "SysLine",
    des = "加载时视频"
  },
  {
    mod = "加载视频",
    name = "loadVideo",
    type = "Array",
    des = "加载视频",
    detail = "id"
  },
  {
    name = "id",
    type = "String",
    des = "视频id",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "列车武装",
    name = "Orange",
    type = "Double",
    des = "橙色消耗系数",
    arg0 = "1"
  },
  {
    mod = "列车武装",
    name = "Golden",
    type = "Double",
    des = "金色消耗系数",
    arg0 = "1"
  },
  {
    mod = "列车武装",
    name = "Purple",
    type = "Double",
    des = "紫色消耗系数",
    arg0 = "1"
  },
  {
    mod = "列车武装",
    name = "Blue",
    type = "Double",
    des = "蓝色消耗系数",
    arg0 = "1"
  },
  {
    mod = "列车武装",
    name = "White",
    type = "Double",
    des = "白色消耗系数",
    arg0 = "1"
  },
  {
    mod = "列车武装",
    name = "typeConstantList",
    type = "Array",
    des = "类型系数列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "武装类型",
    arg0 = "TagFactory"
  },
  {
    name = "num",
    type = "Double",
    des = "类型系数",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "列车武装",
    name = "pendantElectricList",
    type = "Array",
    des = "开启挂件位电力等级",
    detail = "id"
  },
  {
    name = "id",
    type = "Int",
    des = "电力等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "列车武装",
    name = "strengthList",
    type = "Array",
    des = "强化材料列表",
    detail = "level#item#gold"
  },
  {
    name = "level",
    type = "Int",
    des = "当前强化等级",
    arg0 = "0"
  },
  {
    name = "item",
    type = "Factory",
    des = "消耗材料升级",
    arg0 = "ListFactory"
  },
  {
    name = "gold",
    type = "Int",
    des = "消耗金币升级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "列车武装",
    name = "coretypeList",
    type = "Array",
    des = "核心排序",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "核心类型",
    arg0 = "EngineCoreFactory"
  },
  {name = "end"},
  {
    mod = "列车武装",
    name = "monsterList",
    type = "Array",
    des = "怪物类型排序",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "怪物类型",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "列车武装",
    name = "createTypeList",
    type = "Array",
    des = "制造界面标签",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "撞角",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "列车武装",
    name = "collisionAngleList",
    type = "Array",
    des = "可制造撞角",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "武装类型",
    arg0 = "ListFactory#HomeWeaponFactory"
  },
  {name = "end"},
  {
    mod = "列车武装",
    name = "accessoryList",
    type = "Array",
    des = "可制造配件",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "配件",
    arg0 = "ListFactory#HomeWeaponFactory"
  },
  {name = "end"},
  {
    mod = "列车武装",
    name = "PendantList",
    type = "Array",
    des = "可制造挂件",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "挂件",
    arg0 = "ListFactory#HomeWeaponFactory"
  },
  {name = "end"},
  {
    mod = "诱饵气球",
    name = "balloonItemList",
    type = "Array",
    des = "气球道具相关",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具id",
    arg0 = "ItemFactory"
  },
  {
    name = "isReward",
    type = "Bool",
    des = "是否获得奖励",
    arg0 = "false"
  },
  {name = "end"},
  {
    mod = "诱饵气球",
    name = "polluteBalloonList",
    type = "Array",
    des = "各污染的气球",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "列表id",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "设置相关",
    name = "CVList",
    type = "Array",
    des = "配音设置",
    detail = "replacePath"
  },
  {
    name = "replacePath",
    type = "String",
    des = "路径",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "铁盟拖车",
    name = "trailerUnlock",
    type = "Int",
    des = "功能解锁等级",
    arg0 = "20"
  },
  {
    mod = "铁盟拖车",
    name = "trailerList",
    type = "Array",
    des = "铁盟拖车数据",
    detail = "weight#trainId"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {
    name = "trainId",
    type = "Factory",
    des = "列车外形",
    arg0 = "ListFactory",
    pyIgnore = true
  },
  {
    name = "speedMin",
    type = "Int",
    des = "列车最小速度",
    arg0 = "0"
  },
  {
    name = "speedMax",
    type = "Int",
    des = "列车最大速度",
    arg0 = "0"
  },
  {
    name = "speedAdd",
    type = "Int",
    des = "启动加速度",
    arg0 = "1"
  },
  {
    name = "speedDec",
    type = "Int",
    des = "停车减速度",
    arg0 = "1"
  },
  {
    name = "speedRush",
    type = "Int",
    des = "急行弹丸速度",
    arg0 = "50"
  },
  {name = "end"},
  {
    mod = "铁盟拖车",
    name = "trailerMax",
    type = "Int",
    des = "每日最大次数",
    arg0 = "4"
  },
  {
    mod = "铁盟拖车",
    name = "trailerCost",
    type = "Array",
    des = "拖车价格",
    detail = "price#dis"
  },
  {
    name = "price",
    type = "Int",
    des = "单位价格",
    arg0 = "10"
  },
  {
    name = "dis",
    type = "Double",
    des = "单位距离",
    arg0 = "100"
  },
  {name = "end", pyIgnore = true},
  {
    mod = "铁盟拖车",
    name = "trailerMonthCardMax",
    type = "Int",
    des = "月卡每日最大",
    arg0 = "4"
  },
  {
    mod = "铁盟拖车",
    name = "trailerMonthCardCost",
    type = "Array",
    des = "月卡额外拖车",
    detail = "price#dis"
  },
  {
    name = "price",
    type = "Int",
    des = "单位价格",
    arg0 = "0"
  },
  {
    name = "dis",
    type = "Double",
    des = "单位距离",
    arg0 = "100"
  },
  {name = "end", pyIgnore = true},
  {
    mod = "揽客配置",
    name = "solicitOpen",
    type = "Int",
    des = "揽客开启等级|列车长等级",
    arg0 = "1"
  },
  {
    mod = "揽客配置",
    name = "solicitQuestOpen",
    type = "Factory",
    des = "揽客开启任务|主线任务",
    arg0 = "QuestFactory"
  },
  {
    mod = "揽客配置",
    name = "passageOpen",
    type = "Int",
    des = "乘客功能开启列车等级",
    arg0 = "1"
  },
  {
    mod = "揽客配置",
    name = "advertiseOpen",
    type = "Int",
    des = "传单功能开启列车等级",
    arg0 = "1"
  },
  {
    mod = "揽客配置",
    name = "advertiseQuestOpen",
    type = "Factory",
    des = "传单开启主线任务",
    arg0 = "QuestFactory"
  },
  {
    mod = "揽客配置",
    name = "magazineOpen",
    type = "Int",
    des = "杂志开启等级",
    arg0 = "1"
  },
  {
    mod = "揽客配置",
    name = "magazineFameOpen",
    type = "Int",
    des = "杂志声望开启|等级",
    arg0 = "1"
  },
  {
    mod = "揽客配置",
    name = "channelOpen",
    type = "Int",
    des = "频道开启等级",
    arg0 = "1"
  },
  {
    mod = "揽客配置",
    name = "channelFameOpen",
    type = "Int",
    des = "频道声望开启|等级",
    arg0 = "1"
  },
  {
    mod = "揽客配置",
    name = "",
    type = "SysLine",
    des = "票价"
  },
  {
    mod = "揽客配置",
    name = "standing",
    type = "Int",
    des = "站票基础值",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "hardSeat",
    type = "Array",
    des = "硬座票价",
    detail = "level#price"
  },
  {
    name = "level",
    type = "Int",
    des = "座椅等级",
    arg0 = "0"
  },
  {
    name = "price",
    type = "Int",
    des = "票价",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "揽客配置",
    name = "bunkBed",
    type = "Array",
    des = "上下铺票价",
    detail = "level#price"
  },
  {
    name = "level",
    type = "Int",
    des = "座椅等级",
    arg0 = "0"
  },
  {
    name = "price",
    type = "Int",
    des = "票价",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "揽客配置",
    name = "sleepingBerth",
    type = "Array",
    des = "卧铺票价",
    detail = "level#price"
  },
  {
    name = "level",
    type = "Int",
    des = "座椅等级",
    arg0 = "0"
  },
  {
    name = "price",
    type = "Int",
    des = "票价",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "揽客配置",
    name = "doubleQueenBed",
    type = "Array",
    des = "双人大床票价",
    detail = "level#price"
  },
  {
    name = "level",
    type = "Int",
    des = "座椅等级",
    arg0 = "0"
  },
  {
    name = "price",
    type = "Int",
    des = "票价",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "揽客配置",
    name = "",
    type = "SysLine",
    des = "传单加印配置"
  },
  {
    mod = "揽客配置",
    name = "workdayNum",
    type = "Int",
    des = "工作日免费获得传单数量",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "OffdayNum",
    type = "Int",
    des = "休息日免费获得传单数量",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "leafletAddMax",
    type = "Int",
    des = "加印上限/周",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "leafletAddPay",
    type = "Array",
    des = "加印花费/张"
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗道具的id",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "消耗道具的数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "揽客配置",
    name = "",
    type = "SysLine",
    des = "传单基础配置"
  },
  {
    mod = "揽客配置",
    name = "stationNum",
    type = "Int",
    des = "车厢站票容量|每个车厢",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "uiLadflet",
    type = "String",
    des = "传单UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "揽客配置",
    name = "leafletMax",
    type = "Int",
    des = "传单总持有上限",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "setTypeNum",
    type = "Int",
    des = "座位种类数",
    arg0 = "3"
  },
  {
    mod = "揽客配置",
    name = "leafletNum",
    type = "Int",
    des = "传单初始数量",
    arg0 = "10"
  },
  {
    mod = "揽客配置",
    name = "leafletDozen",
    type = "Int",
    des = "传单派发基数",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "leafletIncome",
    type = "Array",
    des = "传单收益与距离|行驶距离,招收下限,招收上限,乘客收益系数",
    detail = "distance#adPassageMin#adPassageMax#earning"
  },
  {
    name = "distance",
    type = "Int",
    des = "距离",
    arg0 = "0"
  },
  {
    name = "adPassageMin",
    type = "Int",
    des = "招收最少",
    arg0 = "0"
  },
  {
    name = "adPassageMax",
    type = "Int",
    des = "招收最多",
    arg0 = "0"
  },
  {
    name = "earning",
    type = "Double",
    des = "乘客收益系数",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "揽客配置",
    name = "demandBasics",
    type = "Double",
    des = "乘客基础需求系数",
    arg0 = ""
  },
  {
    mod = "揽客配置",
    name = "demandOut",
    type = "Double",
    des = "乘客超额需求系数",
    arg0 = ""
  },
  {
    mod = "揽客配置",
    name = "tickerDistance",
    type = "Int",
    des = "车票计算距离",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "animatorTime",
    type = "Int",
    des = "乘客上下车动画时间/秒",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "揽客配置",
    name = "",
    type = "SysLine",
    des = "揽客垃圾配置"
  },
  {
    mod = "揽客配置",
    name = "passengeWaste",
    type = "Double",
    des = "乘客垃圾系数|用于垃圾产出中乘客乘的系数",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "lineWaste",
    type = "Double",
    des = "垃圾行程系数|用于垃圾产出中行程乘以的系数",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "runDistance",
    type = "Double",
    des = "列车行驶距离系数",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "",
    type = "SysLine",
    des = "结算评分UI路径"
  },
  {
    mod = "揽客配置",
    name = "comfort",
    type = "String",
    des = "舒适度UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "揽客配置",
    name = "plantScores",
    type = "String",
    des = "绿植UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "揽客配置",
    name = "fishScores",
    type = "String",
    des = "水族UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "揽客配置",
    name = "petScores",
    type = "String",
    des = "宠物UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "揽客配置",
    name = "foodScores",
    type = "String",
    des = "美味UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "揽客配置",
    name = "playScores",
    type = "String",
    des = "娱乐UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "揽客配置",
    name = "medicalScores",
    type = "String",
    des = "医疗UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "揽客配置",
    name = "arm",
    type = "String",
    des = "武装UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "揽客配置",
    name = "clean",
    type = "String",
    des = "清洁UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "揽客配置",
    name = "",
    type = "SysLine",
    des = "杂志和频道基础配置"
  },
  {
    mod = "揽客配置",
    name = "magazineTime",
    type = "Int",
    des = "杂志派发次数|每日",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "tvTime",
    type = "Int",
    des = "频道派发次数|每日",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "magazineShowNum",
    type = "Int",
    des = "杂志显示数量",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "tvShowNum",
    type = "Int",
    des = "频道显示数量",
    arg0 = "0"
  },
  {
    mod = "揽客配置",
    name = "magazineId",
    type = "Factory",
    des = "杂志总引用",
    arg0 = "ListFactory"
  },
  {
    mod = "揽客配置",
    name = "tvId",
    type = "Factory",
    des = "频道总引用",
    arg0 = "ListFactory"
  },
  {
    mod = "揽客配置",
    name = "",
    type = "SysLine",
    des = "招揽结算配置"
  },
  {
    mod = "揽客配置",
    name = "leafletEnd",
    type = "Array",
    des = "传单结算|大图片,气泡文本id,气泡icon路径,结算文本id,结算文本id英文",
    detail = "icon#bubbleId#bubbleIcon#endId#endEnId",
    pyIgnore = true
  },
  {
    name = "icon",
    type = "String",
    des = "图标路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "bubbleId",
    type = "Factory",
    des = "气泡文本id",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "bubbleIcon",
    type = "String",
    des = "气泡icon路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "endId",
    type = "Factory",
    des = "结算文本id",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "endEnId",
    type = "Factory",
    des = "英文文本id|英文",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "揽客配置",
    name = "MagazineEnd",
    type = "Array",
    des = "杂志结算|大图片,气泡文本id,气泡icon路径,结算文本id,结算文本id英文",
    detail = "icon#bubbleId#bubbleIcon#endId#endEnId",
    pyIgnore = true
  },
  {
    name = "icon",
    type = "String",
    des = "图标路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "bubbleId",
    type = "Factory",
    des = "气泡文本id",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "bubbleIcon",
    type = "String",
    des = "气泡icon路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "endId",
    type = "Factory",
    des = "结算文本id",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "endEnId",
    type = "Factory",
    des = "英文文本id|英文",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "揽客配置",
    name = "tvEnd",
    type = "Array",
    des = "频道结算|大图片,气泡文本id,气泡icon路径,结算文本id,结算文本id英文",
    detail = "icon#bubbleId#bubbleIcon#endId#endEnId",
    pyIgnore = true
  },
  {
    name = "icon",
    type = "String",
    des = "图标路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "bubbleId",
    type = "Factory",
    des = "气泡文本id",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "bubbleIcon",
    type = "String",
    des = "气泡icon路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "endId",
    type = "Factory",
    des = "结算文本id",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "endEnId",
    type = "Factory",
    des = "英文文本id|英文",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "活动总览",
    name = "activeList",
    type = "Array",
    des = "活动列表",
    detail = "id#tag#name#png#sort#startTime#endTime"
  },
  {
    name = "id",
    type = "Factory",
    des = "活动id",
    arg0 = "ActivityFactory"
  },
  {
    name = "tag",
    type = "Factory",
    des = "活动类型",
    arg0 = "TagFactory"
  },
  {
    name = "name",
    type = "Factory",
    des = "页签名字",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "png",
    type = "Png",
    des = "页签图标路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "sort",
    type = "Int",
    des = "排序",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "startTime",
    type = "String",
    des = "开始时间",
    arg0 = ""
  },
  {
    name = "endTime",
    type = "String",
    des = "结束时间",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "活动总览",
    name = "questList",
    type = "Array",
    des = "活动初始任务",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "战斗配置",
    name = "specialIcon05",
    type = "Png",
    des = "特殊图标05",
    arg0 = "",
    pyIgnore = false
  },
  {
    mod = "官方群",
    name = "qqList",
    type = "Array",
    des = "官方群列表",
    detail = "name#Adress#isShow",
    pyIgnore = true
  },
  {
    name = "name",
    type = "StringT",
    des = "群名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "Adress",
    type = "String",
    des = "链接地址",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "isShow",
    type = "Bool",
    des = "显示群",
    arg0 = "True",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "渠道商店",
    name = "storeList",
    type = "Array",
    des = "渠道商店列表",
    detail = "name#adress",
    pyIgnore = true
  },
  {
    name = "name",
    type = "String",
    des = "渠道名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "adress",
    type = "String",
    des = "商店地址",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "列车相机",
    name = "lookSpeed",
    type = "Double",
    des = "基础旋转速度",
    arg0 = "0.8"
  }
})
