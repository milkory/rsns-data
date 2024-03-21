RegProperty("CollectionCardFactory", {
  {
    name = "name",
    type = "StringT",
    des = "名称",
    arg0 = ""
  },
  {
    name = "englishName",
    type = "String",
    des = "英文名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "quality",
    type = "Enum",
    des = "品质",
    arg0 = "MR#LR#SSR#SR#R",
    arg1 = ""
  },
  {
    name = "cardTypeId",
    type = "Factory",
    des = "类型id",
    arg0 = "TagFactory",
    arg1 = "收集卡牌类型"
  },
  {
    name = "specialAnimation",
    type = "Enum",
    des = "特殊工艺||Gold:金闪,Blue:蓝闪,None:无",
    arg0 = "Gold#Blue#None",
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
    name = "getMethod",
    type = "TextT",
    des = "获取方式",
    arg0 = ""
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
    name = "correspondingPack",
    type = "Factory",
    des = "所属卡包",
    arg0 = "CollectionCardPackFactory",
    arg1 = "基础卡包"
  }
})
