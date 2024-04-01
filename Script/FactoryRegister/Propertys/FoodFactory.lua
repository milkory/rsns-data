RegProperty("FoodFactory", {
  {
    name = "name",
    type = "StringT",
    des = "食物名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "foodImagePath",
    type = "Png",
    des = "食物图标路径",
    arg0 = "",
    arg1 = "130|130",
    pyIgnore = true
  },
  {
    name = "foodSettlementImagePath",
    type = "Png",
    des = "食物结算图标路径",
    arg0 = "",
    arg1 = "130|130",
    pyIgnore = true
  },
  {
    name = "des",
    type = "StringT",
    des = "描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "炸鸡店套餐",
    name = "trust",
    type = "Int",
    des = "默契度",
    arg0 = "0"
  },
  {
    mod = "炸鸡店套餐",
    name = "PriceIndex",
    type = "Double",
    des = "物价系数",
    arg0 = "3"
  },
  {
    mod = "炸鸡店套餐",
    name = "mealTypeNum",
    type = "Int",
    des = "套餐适用人数",
    arg0 = "1"
  },
  {
    mod = "炸鸡店套餐",
    name = "cost",
    type = "Array",
    des = "价格",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "货币",
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
    mod = "炸鸡店套餐",
    name = "foodRes",
    type = "String",
    des = "套餐素材资源",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "炸鸡店套餐",
    name = "iconBuffDesMember",
    type = "Png",
    des = "队员buff图标",
    arg0 = "100|100",
    pyIgnore = true
  },
  {
    mod = "炸鸡店套餐",
    name = "numBuffDesMember",
    type = "Factory",
    des = "队员buff数值",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    mod = "炸鸡店套餐",
    name = "tipBuffDesMember",
    type = "Factory",
    des = "队员buff描述",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    mod = "炸鸡店套餐",
    name = "memberTrust",
    type = "Array",
    des = "队员默契加成",
    detail = "id#like#buff"
  },
  {
    name = "id",
    type = "Factory",
    des = "队员",
    arg0 = "UnitFactory"
  },
  {
    name = "like",
    type = "Factory",
    des = "喜好标签",
    arg0 = "TagFactory",
    pyIgnore = true
  },
  {
    name = "buff",
    type = "Factory",
    des = "默契buff",
    arg0 = "HomeBuffFactory"
  },
  {name = "end"},
  {
    mod = "炸鸡店套餐",
    name = "iconBuffDesLCZ",
    type = "Png",
    des = "列车长buff图标",
    arg0 = "100|100",
    pyIgnore = true
  },
  {
    mod = "炸鸡店套餐",
    name = "numBuffDesLCZ",
    type = "Factory",
    des = "列车长buff数值",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    mod = "炸鸡店套餐",
    name = "tipBuffDesLCZ",
    type = "Factory",
    des = "列车长buff描述",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    mod = "炸鸡店套餐",
    name = "speed",
    type = "Array",
    des = "列车速度加成",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "列车buff",
    arg0 = "HomeBuffFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "炸鸡店套餐",
    name = "",
    type = "SysLine",
    des = "战斗buff"
  },
  {
    mod = "炸鸡店套餐",
    name = "battleBuffList",
    type = "Array",
    des = "战斗buff列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "战斗buff",
    arg0 = "HomeBuffFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "battleBuffImagePath",
    type = "Png",
    des = "战斗buff类型",
    arg0 = "",
    arg1 = "130|130",
    pyIgnore = true
  },
  {
    mod = "炸鸡店套餐",
    name = "",
    type = "SysLine",
    des = "场景演出"
  },
  {
    mod = "炸鸡店套餐",
    name = "foodPrefab",
    type = "String",
    des = "演出预制体",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "炸鸡店套餐",
    name = "playerAni",
    type = "Array",
    des = "角色动作",
    detail = "animation",
    pyIgnore = true
  },
  {
    name = "animation",
    type = "Factory",
    des = "动作组",
    arg0 = "ListFactory",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "炸鸡店套餐",
    name = "isPickFood",
    type = "Bool",
    des = "是否拿取食物",
    detail = "false",
    pyIgnore = true
  },
  {
    mod = "炸鸡店套餐",
    name = "foodName",
    type = "String",
    des = "角色骨骼绑定道具",
    arg0 = ""
  },
  {
    mod = "炸鸡店套餐",
    name = "npcList",
    type = "Array",
    des = "npc列表",
    detail = "npcId#npcAni"
  },
  {
    name = "npcId",
    type = "Factory",
    des = "id",
    arg0 = "HomeCharacterFactory"
  },
  {
    name = "npcAni",
    type = "Factory",
    des = "动作组",
    arg0 = "ListFactory",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "炸鸡店套餐",
    name = "performFurnitureList",
    type = "Array",
    des = "演出家具列表",
    detail = "furnitureId#normalPath#performPath"
  },
  {
    name = "furnitureId",
    type = "Factory",
    des = "家具id",
    arg0 = "HomeFurnitureFactory"
  },
  {
    name = "normalPath",
    type = "String",
    des = "常态TimeLine",
    arg0 = ""
  },
  {
    name = "performPath",
    type = "String",
    des = "演出TimeLine",
    arg0 = ""
  },
  {
    name = "isPerformEffect",
    type = "Bool",
    des = "是否带特效",
    arg0 = "false"
  },
  {name = "end"},
  {
    mod = "炸鸡店套餐",
    name = "bgmPlay",
    type = "Factory",
    des = "演出播放音乐",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    mod = "免费工作餐",
    name = "energy",
    type = "Int",
    des = "行动值",
    arg0 = "0"
  },
  {
    mod = "付费外卖",
    name = "energy",
    type = "Int",
    des = "行动值",
    arg0 = "0"
  },
  {
    mod = "爱心便当",
    name = "energy",
    type = "Int",
    des = "行动值",
    arg0 = "0"
  },
  {
    mod = "爱心便当",
    name = "chefImagePath",
    type = "Png",
    des = "厨师图标路径",
    arg0 = "",
    arg1 = "130|130",
    pyIgnore = true
  },
  {
    mod = "爱心便当",
    name = "message",
    type = "StringT",
    des = "爱心字条",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "爱心便当",
    name = "rewards",
    type = "Array",
    des = "出售奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "货币",
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
    mod = "爱心便当",
    name = "expirationDate",
    type = "Int",
    des = "保质期天数",
    arg0 = "7"
  },
  {
    mod = "冰箱道具",
    name = "quality",
    type = "Enum",
    des = "品质",
    arg0 = "White#Blue#Purple#Golden",
    arg1 = "White"
  },
  {
    mod = "冰箱道具",
    name = "imagePath",
    type = "Png",
    des = "图标路径",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "冰箱道具",
    name = "tipsPath",
    type = "Png",
    des = "Tips图标路径",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "冰箱道具",
    name = "isSpeciality",
    type = "Bool",
    des = "稀有",
    arg0 = "false"
  },
  {
    mod = "冰箱道具",
    name = "space",
    type = "Double",
    des = "占用舱位",
    arg0 = "1"
  },
  {
    mod = "冰箱道具",
    name = "expirationDate",
    type = "Int",
    des = "保质期天数",
    arg0 = "7"
  },
  {
    mod = "冰箱道具",
    name = "turntoRubbish",
    type = "Int",
    des = "垃圾转换",
    arg0 = "1"
  },
  {
    mod = "冰箱道具",
    name = "Getway",
    type = "Array",
    des = "获取途径",
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
  {name = "end", pyIgnore = true}
})
