RegProperty("PriceLineFactory", {
  {
    name = "station01",
    type = "Factory",
    des = "车站1",
    arg0 = "HomeStationFactory"
  },
  {
    name = "station02",
    type = "Factory",
    des = "车站2",
    arg0 = "HomeStationFactory"
  },
  {
    name = "num",
    type = "Double",
    des = "额外收入系数",
    arg0 = "0"
  },
  {
    mod = "",
    name = "dec",
    type = "String",
    des = "配置标注",
    detail = ""
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "0-硬座类型-要按等级顺序排列"
  },
  {
    mod = "",
    name = "hardSeat",
    type = "Array",
    des = "硬座票价",
    detail = "id"
  },
  {
    mod = "",
    name = "id",
    type = "Int",
    des = "价格",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "1-上下铺类型--按等级顺序排列"
  },
  {
    mod = "",
    name = "bunkBed",
    type = "Array",
    des = "上下铺票价",
    detail = "id"
  },
  {
    name = "id",
    type = "Int",
    des = "价格",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "2-双人铺类型--要按等级顺序排列"
  },
  {
    mod = "",
    name = "sleepers",
    type = "Array",
    des = "双人床票价",
    detail = "id"
  },
  {
    name = "id",
    type = "Int",
    des = "价格",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "3-单人卧铺--要按等级顺序排列"
  },
  {
    mod = "",
    name = "sleeper",
    type = "Array",
    des = "单人卧铺票价",
    detail = "id"
  },
  {
    name = "id",
    type = "Int",
    des = "价格",
    arg0 = "0"
  },
  {name = "end"}
})
