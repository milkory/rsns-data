RegProperty("HomeCharacterFactory", {
  {
    mod = "宠物",
    name = "",
    type = "SysLine",
    des = "宠物阶段",
    pyIgnore = true
  },
  {
    mod = "宠物",
    name = "upgradeList",
    type = "Array",
    des = "阶段配置",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "宠物阶段id",
    arg0 = "PetUpgradeFactory"
  },
  {name = "end"},
  {
    mod = "宠物",
    name = "",
    type = "SysLine",
    des = "好感度道具",
    pyIgnore = true
  },
  {
    mod = "宠物",
    name = "PetExpSourceMaterialList",
    type = "Array",
    des = "宠物好感度道具",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具名",
    arg0 = "SourceMaterialFactory"
  },
  {name = "end"},
  {
    mod = "宠物",
    name = "评分",
    type = "SysLine",
    des = ""
  },
  {
    mod = "宠物",
    name = "comfort",
    type = "Int",
    des = "舒适度",
    arg0 = "0"
  },
  {
    mod = "宠物",
    name = "plantScores",
    type = "Int",
    des = "绿植评分",
    arg0 = "0"
  },
  {
    mod = "宠物",
    name = "fishScores",
    type = "Int",
    des = "水族评分",
    arg0 = "0"
  },
  {
    mod = "宠物",
    name = "petScores",
    type = "Int",
    des = "宠物评分",
    arg0 = "0"
  },
  {
    mod = "宠物",
    name = "foodScores",
    type = "Int",
    des = "美味评分",
    arg0 = "0"
  },
  {
    mod = "宠物",
    name = "playScores",
    type = "Int",
    des = "娱乐评分",
    arg0 = "0"
  },
  {
    mod = "宠物",
    name = "medicalScores",
    type = "Int",
    des = "医疗评分",
    arg0 = "0"
  },
  {
    mod = "宠物",
    name = "rest",
    type = "String",
    des = "休息状态",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "宠物",
    name = "stand",
    type = "String",
    des = "站立状态",
    arg0 = "dorm_stand",
    pyIgnore = true
  },
  {
    mod = "宠物",
    name = "eat",
    type = "String",
    des = "吃零食状态",
    arg0 = "dorm_eat_02",
    pyIgnore = true
  },
  {
    mod = "宠物",
    name = "petInteractionList",
    type = "Array",
    des = "宠物交互列表",
    detail = "interaction",
    pyIgnore = true
  },
  {
    name = "interaction",
    type = "String",
    des = "交互动作",
    arg0 = "dorm_interaction",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "宠物",
    name = "petID",
    type = "Factory",
    des = "对应宠物",
    arg0 = "PetFactory"
  },
  {
    mod = "角色",
    name = "name",
    type = "String",
    des = "角色名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "角色",
    name = "interactiveIconPath",
    type = "Png",
    des = "常显UI",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "NPC初始行为持续时间/秒",
    pyIgnore = true
  },
  {
    mod = "",
    name = "minTime",
    type = "Int",
    des = "最小时间",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "",
    name = "maxTime",
    type = "Int",
    des = "最大时间",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "乘客和猫待机行为路径",
    pyIgnore = true
  },
  {
    mod = "",
    name = "infoTree",
    type = "String",
    des = "待机行为树",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "bgPath",
    type = "String",
    des = "UI背景图标路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "defaultSkins",
    type = "Array",
    des = "默认服装",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "服装类型",
    arg0 = "HomeCharacterSkinFactory"
  },
  {name = "end"},
  {
    mod = "",
    name = "nudeSkins",
    type = "Array",
    des = "裸模列表",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "服装类型",
    arg0 = "HomeCharacterSkinFactory",
    pyIgnore = true
  },
  {name = "end"}
})
