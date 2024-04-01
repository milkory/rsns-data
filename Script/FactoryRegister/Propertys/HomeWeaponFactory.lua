RegProperty("HomeWeaponFactory", {
  {
    name = "name",
    type = "StringT",
    des = "武器名",
    arg0 = ""
  },
  {
    name = "effectType",
    type = "Enum",
    des = "特效类型|0-无特效状态，1-大世界常态加载，2-UI替换，3-timeline加载，4-点击喇叭加载",
    arg0 = "0#1#2#3#4",
    arg1 = "0"
  },
  {
    name = "effectTypeEffect",
    type = "Factory",
    des = "特殊特效",
    arg0 = "EffectFactory"
  },
  {
    name = "specialEffects",
    type = "Path",
    des = "特效路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "timeLineEffect",
    type = "Factory",
    des = "TimeLine",
    arg0 = "TimeLineFactory",
    pyIgnore = true
  },
  {
    name = "XEffects",
    type = "Double",
    des = "特效X轴坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "YEffects",
    type = "Double",
    des = "特效Y轴坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "ZEffects",
    type = "Double",
    des = "特效Z轴坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "isCost",
    type = "Bool",
    des = "是否可被消耗",
    arg0 = "true"
  },
  {
    name = "des",
    type = "Text",
    des = "武器描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "createDes",
    type = "StringT",
    des = "制造功能描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "quality",
    type = "Enum",
    des = "品质",
    arg0 = "White#Blue#Purple#Golden#Orange",
    arg1 = "White"
  },
  {
    name = "typeWeapon",
    type = "Factory",
    des = "武装类型",
    arg0 = "TagFactory"
  },
  {
    name = "",
    type = "SysLine",
    des = "武装词条相关"
  },
  {
    name = "weaponType",
    type = "Enum",
    des = "武装类型|D-成长型，R-随机型，B-随机和成长混用",
    arg0 = "Development#Random#Both",
    arg1 = "Development"
  },
  {
    name = "normalEntryList",
    type = "Array",
    des = "固有属性"
  },
  {
    name = "id",
    type = "Factory",
    des = "固有词条",
    arg0 = "TrainWeaponSkillFactory"
  },
  {name = "end"},
  {
    name = "growUpEntryList",
    type = "Array",
    des = "成长属性"
  },
  {
    name = "id",
    type = "Factory",
    des = "成长词条",
    arg0 = "TrainWeaponSkillFactory"
  },
  {name = "end"},
  {
    name = "randomSkillNum",
    type = "Int",
    des = "随机属性数量",
    arg0 = "1"
  },
  {
    name = "randomSkillList",
    type = "Array",
    des = "随机属性"
  },
  {
    name = "id",
    type = "Factory",
    des = "随机词条",
    arg0 = "TrainWeaponSkillFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "随机权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "装备满足条件"
  },
  {
    name = "coreList",
    type = "Array",
    des = "需求核心等级",
    detail = "id#level"
  },
  {
    name = "id",
    type = "Factory",
    des = "核心类型",
    arg0 = "EngineCoreFactory"
  },
  {
    name = "level",
    type = "Int",
    des = "需求等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "装备突破素材"
  },
  {
    name = "materialList",
    type = "Array",
    des = "突破材料列表",
    detail = "level#list"
  },
  {
    name = "level",
    type = "Int",
    des = "装备当前等级",
    arg0 = "4"
  },
  {
    name = "list",
    type = "Factory",
    des = "突破到下级材料列表",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    name = "imagePath",
    type = "Png",
    des = "图标路径",
    arg0 = "",
    arg1 = "130|130",
    pyIgnore = true
  },
  {
    name = "tipsPath",
    type = "Png",
    des = "Tips图标",
    arg0 = "",
    arg1 = "130|130",
    pyIgnore = true
  },
  {
    mod = "车厢撞角",
    name = "configWinPercent",
    type = "Double",
    des = "成功率基础值",
    arg0 = "0.6"
  },
  {
    mod = "车厢撞角",
    name = "configNumMin",
    type = "Double",
    des = "耐久损失最小随机数",
    arg0 = "0.8"
  },
  {
    mod = "车厢撞角",
    name = "configNumMax",
    type = "Double",
    des = "耐久损失最大随机数",
    arg0 = "1.1"
  },
  {
    name = "TrainWeaponMakeUp",
    type = "Array",
    des = "制作消耗物品|物品数量",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "制造消耗物品",
    arg0 = "ItemFactory#HomeWeaponFactory#SourceMaterialFactory#HomeGoodsFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "物品数量",
    arg0 = "3"
  },
  {name = "end"},
  {
    name = "goldCost",
    type = "Int",
    des = "制造消耗金币",
    arg0 = "10000"
  },
  {
    name = "",
    type = "SysLine",
    des = "获取途径",
    pyIgnore = true
  },
  {
    name = "Getway",
    type = "Array",
    des = "获取途径",
    pyIgnore = true
  },
  {
    name = "funcId",
    type = "Int",
    des = "功能ID",
    arg0 = "-1",
    pyIgnore = true
  },
  {
    name = "FromLevel",
    type = "Factory",
    des = "关卡掉落",
    arg0 = "LevelFactory",
    pyIgnore = true
  },
  {
    name = "DisplayName",
    type = "String",
    des = "显示名称",
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
  {
    name = "Way3",
    type = "String",
    des = "程序提供",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "车厢撞角",
    name = "TrainWeaponTips",
    type = "Array",
    des = "文本描述",
    detail = "desc"
  },
  {
    name = "desc",
    type = "Factory",
    des = "文本描述",
    arg0 = "TextFactory"
  },
  {name = "end"},
  {
    mod = "车厢撞角",
    name = "percentWin",
    type = "Double",
    des = "完美撞击成功率",
    arg0 = "0.6"
  },
  {
    mod = "车厢撞角",
    name = "configNumPer",
    type = "Double",
    des = "列车耐久损失系数",
    arg0 = "0.6"
  },
  {
    mod = "车厢撞角",
    name = "isFirst",
    type = "Bool",
    des = "是否是初级科技",
    arg0 = "false"
  },
  {
    mod = "车厢撞角",
    name = "WeaponLow",
    type = "Factory",
    des = "前置撞角",
    arg0 = "HomeWeaponFactory"
  },
  {
    mod = "车厢撞角",
    name = "WeaponTired",
    type = "Double",
    des = "产生疲劳度",
    arg0 = "10"
  }
})
