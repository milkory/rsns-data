RegProperty("HomeCoachFactory", {
  {
    name = "name",
    type = "StringT",
    des = "车厢名",
    arg0 = ""
  },
  {
    name = "describe",
    type = "StringT",
    des = "车厢描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "level",
    type = "Int",
    des = "车厢等级",
    arg0 = "1"
  },
  {
    name = "thumbnail",
    type = "Png",
    des = "工厂抽象图",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "thumbnailone",
    type = "Png",
    des = "列表缩略图",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "skinList",
    type = "Array",
    des = "车厢皮肤列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "HomeCoachSkinFactory"
  },
  {name = "end"},
  {
    name = "cannotMove",
    type = "Bool",
    des = "不能移动",
    arg0 = "False"
  },
  {
    name = "cannotDecorate",
    type = "Bool",
    des = "不能装扮",
    arg0 = "False"
  },
  {
    name = "studyNeedLevel",
    type = "Int",
    des = "研究所需家园等级",
    arg0 = "1"
  },
  {
    name = "studyMaterialList",
    type = "Array",
    des = "研究消耗材料列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "defaultTemplate",
    type = "Factory",
    des = "默认家具模板",
    arg0 = "HomeTemplateFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "nextCoach",
    type = "Factory",
    des = "下一级车厢",
    arg0 = "HomeCoachFactory"
  },
  {
    name = "buildMaterialList",
    type = "Array",
    des = "建造/升级消耗材料列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
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
    name = "waittime",
    type = "Int",
    des = "建造等待时间s",
    arg0 = "21600"
  },
  {
    name = "JumptimeList",
    type = "Array",
    des = "跳过等待时间消耗道具",
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
    name = "defaultTemplate",
    type = "Factory",
    des = "默认家具模板",
    arg0 = "HomeTemplateFactory"
  },
  {
    name = "returnMaterialList",
    type = "Array",
    des = "拆除返还材料列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
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
    name = "unlockLevel",
    type = "Int",
    des = "执照等级解锁",
    arg0 = "0"
  },
  {
    name = "Achieve",
    type = "Factory",
    des = "达成成就解锁",
    arg0 = "QuestFactory"
  },
  {
    name = "weaponTypeList",
    type = "Array",
    des = "可装载武器类型",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    name = "space",
    type = "Double",
    des = "舱位",
    arg0 = "50"
  },
  {
    name = "weaponNum",
    type = "Int",
    des = "武器栏位数量",
    arg0 = "1"
  },
  {
    name = "accessoryNum",
    type = "Int",
    des = "车头辅助挂件数量",
    arg0 = "1"
  },
  {
    name = "electricCost",
    type = "Int",
    des = "车厢耗电",
    arg0 = "100"
  },
  {
    name = "characterNum",
    type = "Int",
    des = "可入住数量",
    arg0 = "1"
  },
  {
    name = "carriagedurability",
    type = "Int",
    des = "车厢耐久",
    arg0 = "1000"
  },
  {
    name = "carriageRubbish",
    type = "Int",
    des = "车厢默认垃圾产出/h",
    arg0 = "100"
  },
  {
    name = "speedEffect",
    type = "Double",
    des = "速度影响",
    arg0 = "0"
  },
  {
    name = "passengerCapacity",
    type = "Int",
    des = "载客量",
    arg0 = "0"
  },
  {
    name = "Armor",
    type = "Int",
    des = "装甲值",
    arg0 = "0"
  }
})
