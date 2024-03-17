RegProperty("EngineCoreFactory", {
  {
    name = "electricLimit",
    type = "Int",
    des = "电力等级限制",
    arg0 = "0"
  },
  {
    name = "coreExpList",
    type = "Array",
    des = "发动机升级列表",
    detail = "num#id#isBreak#effects"
  },
  {
    name = "num",
    type = "Int",
    des = "单场最高次数",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "升级相关",
    arg0 = "ListFactory",
    arg1 = "发动机核心"
  },
  {
    name = "isBreak",
    type = "Bool",
    des = "是否需要突破",
    arg0 = "False"
  },
  {
    name = "effects",
    type = "String",
    des = "显示特效",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    name = "coreLevelList",
    type = "Array",
    des = "核心关卡列表",
    detail = "grade#id#profileId"
  },
  {
    name = "grade",
    type = "Int",
    des = "核心等级",
    arg0 = "10"
  },
  {
    name = "id",
    type = "Factory",
    des = "对应关卡",
    arg0 = "LevelFactory"
  },
  {
    name = "profileId",
    type = "Factory",
    des = "对应怪物",
    arg0 = "UnitFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "文本部分"
  },
  {
    name = "name",
    type = "Factory",
    des = "名称",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "nameEN",
    type = "Factory",
    des = "英文名称",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "record",
    type = "Factory",
    des = "当前挑战记录",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "challengeTips",
    type = "Factory",
    des = "挑战内容提示",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "mvpNum",
    type = "Factory",
    des = "MVP次数",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "settlementNum",
    type = "Factory",
    des = "结算挑战记录",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "battleNum",
    type = "Factory",
    des = "战斗过程记录",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "battleName",
    type = "Factory",
    des = "战斗内关卡名称",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "素材部分"
  },
  {
    name = "coreIconPath",
    type = "Png",
    des = "核心图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "coreIconPathW",
    type = "Png",
    des = "核心条件图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "breakPath",
    type = "Png",
    des = "突破条",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "informationPath",
    type = "Png",
    des = "信息底",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "breakIconPath",
    type = "Png",
    des = "突破底用图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "breakDi1Path",
    type = "Png",
    des = "突破底1",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "breakDi2Path",
    type = "Png",
    des = "突破底2",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "gradePath",
    type = "Png",
    des = "升级后底",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "settlementIconPath",
    type = "Png",
    des = "结算图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "overviewBgPath",
    type = "Png",
    des = "总览背景",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "overviewSelectPath",
    type = "Png",
    des = "总览选择图案",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "color",
    type = "String",
    des = "字体颜色",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "升级特效部分"
  },
  {
    name = "upEffects",
    type = "String",
    des = "升级特效",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "突破特效部分"
  },
  {
    name = "breakEffects1",
    type = "String",
    des = "突破特效1",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "breakEffects2",
    type = "String",
    des = "突破特效2",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "breakEffects3",
    type = "String",
    des = "突破特效3",
    arg0 = "",
    pyIgnore = true
  }
})
