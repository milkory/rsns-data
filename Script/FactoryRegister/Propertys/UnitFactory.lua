RegProperty("UnitFactory", {
  {
    mod = "玩家角色",
    name = "decomposeRewardList",
    type = "Array",
    des = "多余履历补充自动转化|获得角色次数大于共振列表长度后自动转化",
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
    mod = "玩家角色",
    name = "isSpine2",
    type = "Int",
    des = "是否有精二 ",
    arg0 = "1"
  },
  {
    mod = "玩家角色",
    name = "homeSkillList",
    type = "Array",
    des = "生活技能列表"
  },
  {
    name = "resonanceLv",
    type = "Int",
    des = "共振等级",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "解锁技能",
    arg0 = "HomeSkillFactory"
  },
  {
    name = "nextIndex",
    type = "Int",
    des = "下一级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "玩家角色",
    name = "",
    type = "SysLine",
    des = "技能卡牌数据"
  },
  {
    mod = "玩家角色",
    name = "totalCost",
    type = "Int",
    des = "角色技能总费用",
    arg0 = "1",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "totalCardNum",
    type = "Int",
    des = "角色卡牌总数 ",
    arg0 = "1",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "skillMin",
    type = "Int",
    des = "技能数量最小值",
    arg0 = "5",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "",
    type = "SysLine",
    des = "家园相关"
  },
  {
    mod = "玩家角色",
    name = "homeCharacter",
    type = "Factory",
    des = "对应家园角色",
    arg0 = "HomeCharacterFactory"
  },
  {
    mod = "玩家角色",
    name = "stationStoreCharacter",
    type = "Factory",
    des = "演出角色|车站店面演出时优先使用此配置，配置为空时再用家园角色",
    arg0 = "HomeCharacterFactory"
  },
  {
    mod = "玩家角色",
    name = "gotoBed",
    type = "Bool",
    des = "能否上床",
    arg0 = "true",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "isDoctor",
    type = "Bool",
    des = "持有医师执照",
    arg0 = "false"
  },
  {
    mod = "玩家角色",
    name = "medicalPoint",
    type = "Int",
    des = "医疗点数",
    arg0 = "0"
  },
  {
    mod = "玩家角色",
    name = "WasteCoefficient",
    type = "Double",
    des = "垃圾系数",
    arg0 = "1"
  },
  {
    mod = "玩家角色",
    name = "FoodList",
    type = "Array",
    des = "爱心便当列表",
    detail = "id#weight#letter"
  },
  {
    name = "id",
    type = "Factory",
    des = "爱心便当",
    arg0 = "FoodFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {
    name = "letter",
    type = "TextT",
    des = "爱心字条",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "玩家角色",
    name = "ProfilePhotoList",
    type = "Array",
    des = "头像列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "头像",
    arg0 = "ProfilePhotoFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "玩家角色",
    name = "",
    type = "SysLine",
    des = "档案"
  },
  {
    mod = "玩家角色",
    name = "classifyList",
    type = "Array",
    des = "角色定位",
    detail = "des",
    pyIgnore = true
  },
  {
    name = "des",
    type = "StringT",
    des = "角色定位",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "玩家角色",
    name = "fileList",
    type = "Array",
    des = "角色档案"
  },
  {
    name = "file",
    type = "Factory",
    des = "对应档案",
    arg0 = "ListFactory",
    arg1 = "角色档案"
  },
  {name = "end"},
  {
    mod = "玩家角色",
    name = "age",
    type = "Int",
    des = "年龄",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "gender",
    type = "StringT",
    des = "性别",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "birthday",
    type = "StringT",
    des = "生日",
    arg0 = "1月1日",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "height",
    type = "StringT",
    des = "身高",
    arg0 = "150",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "birthplace",
    type = "StringT",
    des = "出生地",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "ability",
    type = "StringT",
    des = "升构能力",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "identity",
    type = "StringT",
    des = "现身份",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "basic",
    type = "TextT",
    des = "基础信息",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "ResumeList",
    type = "Array",
    des = "履历",
    detail = "",
    pyIgnore = true
  },
  {
    name = "des",
    type = "TextT",
    des = "履历文本",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "玩家角色",
    name = "StoryList",
    type = "Array",
    des = "角色故事",
    detail = "",
    pyIgnore = true
  },
  {
    name = "Title",
    type = "String",
    des = "故事标题",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "des",
    type = "TextT",
    des = "故事文本",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "UnlockLevel",
    type = "Int",
    des = "解锁等级",
    arg0 = "1",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "玩家角色",
    name = "",
    type = "SysLine",
    des = "台词"
  },
  {
    mod = "玩家角色",
    name = "CvName",
    type = "String",
    des = "声优名字",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "玩家角色",
    name = "getCharacter",
    type = "TextT",
    des = "获得角色",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "基础单位",
    name = "",
    type = "SysLine",
    des = "图鉴相关"
  },
  {
    mod = "基础单位",
    name = "normalDes",
    type = "StringT",
    des = "基础设定",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "基础单位,敌方角色",
    name = "battleDes",
    type = "TextT",
    des = "战斗设定",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "基础单位",
    name = "lineDes",
    type = "Enum",
    des = "站位描述",
    arg0 = "前排#中排#后排",
    arg1 = "前排",
    pyIgnore = true
  },
  {
    mod = "基础单位",
    name = "armorDes",
    type = "Enum",
    des = "护甲描述",
    arg0 = "重甲#轻甲#混装",
    arg1 = "重甲",
    pyIgnore = true
  },
  {
    mod = "基础单位",
    name = "riskDes",
    type = "Enum",
    des = "危险性描述",
    arg0 = "危险性高#危险性中#危险性低",
    arg1 = "危险性高",
    pyIgnore = true
  },
  {
    name = "safeInformation",
    type = "TextT",
    des = "治安显示信息",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "unitInformation",
    type = "TextT",
    des = "角色信息",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "敌方角色",
    name = "enemyDrop",
    type = "Array",
    des = "掉落列表",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "物品ID",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#HomeGoodsFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "敌方角色",
    name = "abilityList",
    type = "Array",
    des = "特殊能力",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "标签id",
    arg0 = "TagFactory",
    arg1 = "敌人定位标签",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "敌方角色",
    name = "weaknessList",
    type = "Array",
    des = "弱点",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "标签id",
    arg0 = "TagFactory",
    arg1 = "敌人定位标签",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "敌方角色",
    name = "resistanceList",
    type = "Array",
    des = "抗性",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "标签id",
    arg0 = "TagFactory",
    arg1 = "敌人定位标签",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "敌方角色",
    name = "enemyType",
    type = "Factory",
    des = "敌人阶级",
    arg0 = "TagFactory",
    arg1 = "敌人强度标签",
    pyIgnore = true
  },
  {
    mod = "敌方角色",
    name = "enemyCamp",
    type = "Factory",
    des = "敌人类别",
    arg0 = "TagFactory",
    arg1 = "阵营",
    pyIgnore = true
  },
  {
    mod = "敌方角色",
    name = "enemyBookId",
    type = "Factory",
    des = "图鉴单位",
    arg0 = "UnitFactory",
    arg1 = "敌方角色"
  }
})
