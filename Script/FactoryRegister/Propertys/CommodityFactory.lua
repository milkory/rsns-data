RegProperty("CommodityFactory", {
  {
    name = "isChange",
    type = "Bool",
    des = "价格是否跟着购买次数变化",
    arg0 = "False"
  },
  {
    name = "oneTimeMax",
    type = "Int",
    des = "单次购买最大数量",
    arg0 = "10"
  },
  {
    mod = "",
    name = "iconPath",
    type = "Png",
    des = "商品图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "isTime",
    type = "Bool",
    des = "是否限时",
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
    des = "间隔刷新商品"
  },
  {
    name = "isRefresh",
    type = "Bool",
    des = "是否间隔刷新",
    arg0 = "False"
  },
  {
    name = "initTime",
    type = "String",
    des = "初始时间",
    arg0 = ""
  },
  {
    name = "refreshDay",
    type = "Int",
    des = "间隔天数",
    arg0 = "10"
  },
  {
    name = "",
    type = "SysLine",
    des = "限购类型"
  },
  {
    name = "limitBuyType",
    type = "Enum",
    des = "限购类型",
    arg0 = "Forever#Daily#Weekly#Monthly",
    arg1 = "Forever"
  },
  {
    name = "",
    type = "SysLine",
    des = "购买条件"
  },
  {
    name = "isBuyCondition",
    type = "Bool",
    des = "是否有购买限制",
    arg0 = "False"
  },
  {
    name = "stationCondition",
    type = "Factory",
    des = "城市站点",
    arg0 = "HomeStationFactory"
  },
  {
    name = "repGradeCondition",
    type = "Int",
    des = "声望等级条件",
    arg0 = "0"
  },
  {
    name = "gradeCondition",
    type = "Int",
    des = "列车长等级条件",
    arg0 = "0"
  },
  {
    name = "",
    type = "SysLine",
    des = "刷新条件"
  },
  {
    name = "gradeRefresh",
    type = "Int",
    des = "等级刷新",
    arg0 = "0"
  },
  {
    name = "",
    type = "SysLine",
    des = "触发限时"
  },
  {
    name = "isTriggerTime",
    type = "Bool",
    des = "是否为触发限时商品",
    arg0 = "False"
  },
  {
    name = "continueTime",
    type = "Int",
    des = "持续时间（秒）",
    arg0 = "0"
  },
  {
    name = "",
    type = "SysLine",
    des = "额外赠送"
  },
  {
    name = "extraGiveList",
    type = "Array",
    des = "额外赠送",
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
  {name = "end"}
})
