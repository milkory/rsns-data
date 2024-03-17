RegProperty("PondFactory", {
  {
    mod = "淘金投资",
    name = "type",
    type = "Factory",
    des = "投资类型",
    arg0 = "TagFactory"
  },
  {
    mod = "淘金投资",
    name = "dec",
    type = "String",
    des = "描述",
    arg0 = ""
  },
  {
    mod = "淘金投资",
    name = "isHighLight",
    type = "Bool",
    des = "是否高亮",
    arg0 = "False"
  },
  {
    mod = "淘金投资",
    name = "item",
    type = "Array",
    des = "投资道具",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "投资道具",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "投资数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "淘金投资",
    name = "build",
    type = "Array",
    des = "获得建设度奖励",
    detail = "id#num"
  },
  {
    mod = "淘金投资",
    name = "id",
    type = "Factory",
    des = "获得建设奖励",
    arg0 = "ItemFactory"
  },
  {
    mod = "淘金投资",
    name = "num",
    type = "Int",
    des = "奖励数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "淘金投资",
    name = "divide",
    type = "Double",
    des = "奖励分成",
    arg0 = "0"
  },
  {
    mod = "淘金投资",
    name = "tax",
    type = "Double",
    des = "奖励税率",
    arg0 = "0"
  },
  {
    mod = "淘金投资",
    name = "ticket",
    type = "Int",
    des = "奖励票价",
    arg0 = "0"
  },
  {
    mod = "杂志视频广告",
    name = "adName",
    type = "String",
    des = "广告名称",
    arg0 = ""
  },
  {
    mod = "杂志视频广告",
    name = "adType",
    type = "Factory",
    des = "广告类型",
    arg0 = "TagFactory"
  },
  {
    mod = "杂志视频广告",
    name = "adIcon",
    type = "Png",
    des = "广告图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "杂志视频广告",
    name = "adDesc",
    type = "Factory",
    des = "地点描述",
    arg0 = "TextFactory"
  },
  {
    mod = "杂志视频广告",
    name = "adItem",
    type = "Array",
    des = "招揽消耗道具",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具ID",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "消耗数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "杂志视频广告",
    name = "adPassageTypeList",
    type = "Array",
    des = "乘客招收构成",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "乘客id",
    arg0 = "PassageFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "乘客构成权重",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "杂志视频广告",
    name = "adPassageTagList",
    type = "Array",
    des = "招收乘客标签",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "标签id",
    arg0 = "ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "标签构成权重",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "杂志视频广告",
    name = "adIncome",
    type = "Array",
    des = "收益与距离|行驶距离,招收下限,招收上限,乘客收益系数",
    detail = "distance#adPassageMin#adPassageMax#earning"
  },
  {
    name = "distance",
    type = "Int",
    des = "距离",
    arg0 = "0"
  },
  {
    name = "adPassageMin",
    type = "Int",
    des = "招收最少",
    arg0 = "0"
  },
  {
    name = "adPassageMax",
    type = "Int",
    des = "招收最多",
    arg0 = "0"
  },
  {
    name = "earning",
    type = "Double",
    des = "乘客收益系数",
    arg0 = "0"
  },
  {name = "end"}
})
