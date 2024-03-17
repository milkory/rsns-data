RegProperty("FridgeItemFactory", {
  {
    name = "name",
    type = "String",
    des = "名称",
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
    name = "iconPath",
    type = "Png",
    des = "图标路径",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "",
    name = "tipsPath",
    type = "Png",
    des = "Tips图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "",
    name = "sort",
    type = "Int",
    des = "排序权重",
    arg0 = "0"
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "出售"
  },
  {
    mod = "",
    name = "saletype",
    type = "Enum",
    des = "出售类型",
    arg0 = "NotSale#Sale#Overdue",
    arg1 = "NotSale"
  },
  {
    mod = "",
    name = "rewardList",
    type = "Array",
    des = "出售奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励ID",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "奖励数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "",
    name = "space",
    type = "Double",
    des = "占用舱位",
    arg0 = "1"
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
  {name = "end", pyIgnore = true}
})
