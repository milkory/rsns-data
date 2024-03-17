RegProperty("ProductionFactory", {
  {
    mod = "默认配方",
    name = "name",
    type = "String",
    des = "名字",
    arg0 = ""
  },
  {
    name = "unlock",
    type = "Factory",
    des = "解锁条件",
    arg0 = "ItemFactory"
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
    mod = "默认配方",
    name = "condition",
    type = "Array",
    des = "配方组",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "关联配方",
    arg0 = "FormulaFactory"
  },
  {name = "end"}
})
