RegProperty("HomeGoodsFactory", {
  {
    name = "name",
    type = "StringT",
    des = "货物名",
    arg0 = ""
  },
  {
    name = "des",
    type = "TextT",
    des = "描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "quality",
    type = "Enum",
    des = "品质",
    arg0 = "White#Blue#Purple#Golden",
    arg1 = "White"
  },
  {
    name = "imagePath",
    type = "Png",
    des = "图标路径",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "tipsPath",
    type = "Png",
    des = "Tips图标路径",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    name = "isSpeciality",
    type = "Bool",
    des = "特产",
    arg0 = "false"
  },
  {
    mod = "基础货物",
    name = "isPollution",
    type = "Bool",
    des = "受污染指数影响",
    arg0 = "false"
  },
  {
    name = "space",
    type = "Double",
    des = "占用舱位",
    arg0 = "1"
  },
  {
    mod = "基础货物",
    name = "quotationVariation",
    type = "Double",
    des = "默认行情波动",
    arg0 = "0.02"
  },
  {
    mod = "基础货物",
    name = "fastQuotationVariation",
    type = "Double",
    des = "快速行情波动",
    arg0 = "0.04"
  },
  {
    mod = "基础货物",
    name = "producerList",
    type = "Array",
    des = "产地列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "HomeStationFactory"
  },
  {name = "end"},
  {
    mod = "垃圾",
    name = "costList",
    type = "Array",
    des = "处理消耗",
    detail = "id#num"
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
    mod = "垃圾",
    name = "rewardsList",
    type = "Array",
    des = "出售奖励",
    detail = "id#num"
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
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    name = "sort",
    type = "Int",
    des = "排序权重",
    arg0 = "99",
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
    name = "丢失价值",
    type = "SysLine",
    des = ""
  },
  {
    name = "price",
    type = "Int",
    des = "丢失价值",
    arg0 = "1000"
  }
})
