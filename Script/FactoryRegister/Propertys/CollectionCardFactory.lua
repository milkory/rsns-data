RegProperty("CollectionCardFactory", {
  {
    name = "name",
    type = "String",
    des = "名称",
    arg0 = ""
  },
  {
    name = "viewId",
    type = "String",
    des = "视图",
    arg0 = ""
  },
  {
    name = "quality",
    type = "Enum",
    des = "品质",
    arg0 = "MR#LR#SSR#SR#R",
    arg1 = ""
  },
  {
    name = "cardType",
    type = "Enum",
    des = "类型",
    arg0 = "列车长卡#角色卡#支援者卡#怪物卡#道具卡#能量卡",
    arg1 = ""
  },
  {
    name = "specialAnimation",
    type = "Enum",
    des = "特殊工艺",
    arg0 = "金闪#蓝闪",
    arg1 = ""
  },
  {
    name = "des",
    type = "TextT",
    des = "描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "iconPath",
    type = "Png",
    des = "道具图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "tipsPath",
    type = "Png",
    des = "Tips图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "",
    type = "SysLine",
    des = "是否限时"
  },
  {
    name = "isTimeLimited",
    type = "Bool",
    des = "获得是否有时间限制，勾选有默认没有",
    arg0 = "False"
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
  {
    name = "",
    type = "SysLine",
    des = "是否为卡包首卡"
  },
  {
    name = "isWhole",
    type = "Bool",
    des = "获取条件是否为收集卡包其余卡，默认不是",
    arg0 = "False"
  },
  {
    name = "preconditionsList",
    type = "Array",
    des = "前置卡列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "前置卡id",
    arg0 = "CollectionCardFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "卡包套图及偏移"
  },
  {
    name = "packViewPng",
    type = "Png",
    des = "卡包中图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "packViewX",
    type = "Double",
    des = "X轴偏移",
    arg0 = "0"
  },
  {
    name = "pageViewY",
    type = "Double",
    des = "Y轴偏移",
    arg0 = "0"
  }
})
