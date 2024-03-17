RegProperty("FormulaFactory", {
  {
    mod = "默认",
    name = "drawingname",
    type = "String",
    des = "图纸名字",
    arg0 = ""
  },
  {
    mod = "默认",
    name = "drawingItem",
    type = "Factory",
    des = "关联配方组",
    arg0 = "ProductionFactory"
  },
  {
    mod = "默认",
    name = "drawingLevel",
    type = "Int",
    des = "等级",
    arg0 = "0"
  },
  {
    mod = "默认",
    name = "drawingQuality",
    type = "String",
    des = "品质|入门,进阶,精髓",
    arg0 = ""
  },
  {
    mod = "默认",
    name = "drawingTime",
    type = "Int",
    des = "合成所需时间|秒",
    arg0 = "0"
  },
  {
    mod = "默认",
    name = "doneCost",
    type = "Array",
    des = "快速合成消耗",
    detail = "Costid#Costnum"
  },
  {
    name = "Costid",
    type = "Factory",
    des = "消耗道具",
    arg0 = "ItemFactory"
  },
  {
    name = "Costnum",
    type = "Int",
    des = "消耗数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "draw",
    type = "Array",
    des = "合成目标",
    detail = "id#numMax#numMin"
  },
  {
    name = "id",
    type = "Factory",
    des = "合成道具id",
    arg0 = "ItemFactory#HomeGoodsFactory#SourceMaterialFactory#SkillFactory"
  },
  {
    name = "numMax",
    type = "Int",
    des = "合成数量上限",
    arg0 = "0"
  },
  {
    name = "numMin",
    type = "Int",
    des = "合成数量下限",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "drawForm",
    type = "Array",
    des = "组成|合成目标的组成和数量",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "组成素材",
    arg0 = "SourceMaterialFactory#HomeGoodsFactory#ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "组成数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "energyCondition",
    type = "Array",
    des = "发电机需求|电火冰混响负能的条件，值",
    detail = "num00#num01#num02#num03#num04"
  },
  {
    name = "num00",
    type = "Int",
    des = "电等级",
    arg0 = "0"
  },
  {
    name = "num01",
    type = "Int",
    des = "火等级",
    arg0 = "0"
  },
  {
    name = "num02",
    type = "Int",
    des = "冰等级",
    arg0 = "0"
  },
  {
    name = "num03",
    type = "Int",
    des = "混响等级",
    arg0 = "0"
  },
  {
    name = "num04",
    type = "Int",
    des = "负能等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "composeCondition",
    type = "Array",
    des = "合成消耗",
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
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "isAdded",
    type = "Bool",
    des = "有额外产出|勾选有,默认没有",
    arg0 = "False"
  },
  {
    mod = "默认",
    name = "added",
    type = "Array",
    des = "额外产出",
    detail = "chance#item#numMax#numMin#numLimit#quantity"
  },
  {
    name = "chance",
    type = "Double",
    des = "额外产出率",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "产出道具",
    arg0 = "ItemFactory#HomeGoodsFactory#SourceMaterialFactory#SkillFactory"
  },
  {
    name = "numMax",
    type = "Int",
    des = "额外数量上限",
    arg0 = "0"
  },
  {
    name = "numMin",
    type = "Int",
    des = "额外数量下限",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "numLimit",
    type = "Int",
    des = "合成次数控制|未超出次数则要每个都随额外产出",
    arg0 = "0"
  },
  {
    mod = "默认",
    name = "quantity",
    type = "Int",
    des = "合成控制份数|超出份数则根据配置值分阶段随",
    arg0 = "0"
  },
  {
    mod = "默认",
    name = "",
    type = "SysLine",
    des = "解锁"
  },
  {
    mod = "默认",
    name = "unlockenergyCondition",
    type = "Array",
    des = "解锁发电机需求|电火冰混响负能的条件，值",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "核心",
    arg0 = "EngineCoreFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "unlock",
    type = "Int",
    des = "家具等级",
    arg0 = "1"
  }
})
