RegProperty("PetUpgradeFactory", {
  {
    name = "favorMax",
    type = "Int",
    des = "好感上限",
    arg0 = "100"
  },
  {
    name = "dayCost",
    type = "Int",
    des = "升下级天数",
    arg0 = "1"
  },
  {
    name = "itemList",
    type = "Array",
    des = "升下级材料",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗道具id",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "消耗数量",
    arg0 = "0"
  },
  {name = "end"}
})
