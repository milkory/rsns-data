RegProperty("RankFactory", {
  {
    name = "name",
    type = "String",
    des = "排行榜名称",
    arg0 = ""
  },
  {
    name = "nameEN",
    type = "String",
    des = "英文名称",
    arg0 = ""
  },
  {
    name = "tabName",
    type = "String",
    des = "标签名称",
    arg0 = ""
  },
  {
    name = "rankName",
    type = "String",
    des = "排行内容",
    arg0 = ""
  },
  {
    name = "titlePng",
    type = "Png",
    des = "主题图片",
    arg0 = "",
    arg1 = "1162|156",
    pyIgnore = true
  },
  {
    name = "iconPng",
    type = "Png",
    des = "图标",
    arg0 = "",
    arg1 = "38|38",
    pyIgnore = true
  },
  {
    name = "peopleNum",
    type = "Int",
    des = "排行榜显示人数",
    arg0 = "0"
  },
  {
    name = "rankNumMax",
    type = "Int",
    des = "自身排名最大值",
    arg0 = "99"
  },
  {
    name = "rankType",
    type = "Enum",
    des = "排行榜类型||profit:累计利润,profitSingle:单次利润,environmental:环保积分",
    arg0 = "profit#profitSingle#environmental",
    arg1 = "profit"
  },
  {
    name = "timeType",
    type = "Enum",
    des = "时间类型||daily:每日,weekly:每周,all:每周、本地日周,forever:永久",
    arg0 = "daily#weekly#all#forever",
    arg1 = "all"
  },
  {
    name = "sectionType",
    type = "Enum",
    des = "分区类型||default:区间不重合,onebased:区间重合",
    arg0 = "default#onebased",
    arg1 = "default"
  },
  {
    name = "gradeSectionList",
    type = "Array",
    des = "等级区间",
    detail = "grade"
  },
  {
    name = "grade",
    type = "Int",
    des = "等级",
    arg0 = "0",
    pythonName = "id"
  },
  {name = "end"},
  {
    name = "isInquireArea",
    type = "Bool",
    des = "是否可查看其他分区",
    arg0 = "False"
  }
})
