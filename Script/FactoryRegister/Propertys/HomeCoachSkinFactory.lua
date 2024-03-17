RegProperty("HomeCoachSkinFactory", {
  {
    name = "name",
    type = "String",
    des = "皮肤名字",
    arg0 = ""
  },
  {
    name = "skinDetail",
    type = "Text",
    des = "皮肤描述",
    arg0 = ""
  },
  {
    name = "thumbnail",
    type = "Png",
    des = "皮肤UI图",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "skinDisplay",
    type = "Png",
    des = "皮肤展示图",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "produceMaterialList",
    type = "Array",
    des = "制作材料列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "ItemFactory#SourceMaterialFactory#HomeGoodsFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "coordinate",
    type = "Array",
    des = "栏位坐标",
    detail = "num#id#x#y#z"
  },
  {
    name = "num",
    type = "Int",
    des = "栏位",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "武装类型",
    arg0 = "TagFactory"
  },
  {
    name = "x",
    type = "Double",
    des = "X轴坐标",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "y",
    type = "Double",
    des = "y轴坐标",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "z",
    type = "Double",
    des = "z轴坐标",
    arg0 = "1",
    pyIgnore = true
  },
  {name = "end"},
  {
    name = "coachType",
    type = "Factory",
    des = "对应车厢类型",
    arg0 = "TagFactory"
  }
})
