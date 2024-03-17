RegProperty("HomeCreatureFactory", {
  {
    name = "name",
    type = "StringT",
    des = "名字",
    arg0 = ""
  },
  {
    name = "des",
    type = "StringT",
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
    name = "tipsPath",
    type = "Png",
    des = "Tips图标",
    arg0 = "",
    arg1 = "300|300",
    pyIgnore = true
  },
  {
    name = "iconPath",
    type = "Png",
    des = "图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    name = "comfort",
    type = "Int",
    des = "舒适度",
    arg0 = "0"
  },
  {
    name = "plantScores",
    type = "Int",
    des = "绿植评分",
    arg0 = "0"
  },
  {
    name = "fishScores",
    type = "Int",
    des = "水族评分",
    arg0 = "0"
  },
  {
    name = "petScores",
    type = "Int",
    des = "宠物评分",
    arg0 = "0"
  },
  {
    name = "foodScores",
    type = "Int",
    des = "美味评分",
    arg0 = "0"
  },
  {
    name = "playScores",
    type = "Int",
    des = "娱乐评分",
    arg0 = "0"
  },
  {
    name = "medicalScores",
    type = "Int",
    des = "医疗评分",
    arg0 = "0"
  },
  {
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    mod = "生物",
    name = "rewards",
    type = "Array",
    des = "净化奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "生物",
    name = "purifyTime",
    type = "Int",
    des = "净化耗时(秒)",
    arg0 = "600"
  },
  {
    mod = "鱼",
    name = "fishType",
    type = "Enum",
    des = "鱼的类型",
    arg0 = "小型鱼#中型鱼#大型鱼#超大型鱼",
    arg1 = "小型鱼"
  },
  {
    mod = "鱼",
    name = "fishVolume",
    type = "Int",
    des = "鱼的体积",
    arg0 = "100"
  },
  {
    mod = "鱼",
    name = "fishGarbage",
    type = "Int",
    des = "鱼的垃圾产出",
    arg0 = "1"
  },
  {
    mod = "鱼",
    name = "fishMood",
    type = "Int",
    des = "鱼提供舒适度",
    arg0 = "10"
  },
  {
    mod = "植物",
    name = "purifyTime",
    type = "Int",
    des = "净化耗时(秒)",
    arg0 = "-1"
  },
  {
    mod = "植物",
    name = "PlantMood",
    type = "Int",
    des = "提供心情",
    arg0 = "10"
  },
  {
    mod = "植物",
    name = "rewards",
    type = "Array",
    des = "出售奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "盆栽",
    name = "PotSize",
    type = "Enum",
    des = "尺寸类型标签",
    arg0 = "Size1#Size2#Size3#Size4#Size5#Size6",
    arg1 = "Size1"
  },
  {
    mod = "盆栽",
    name = "PotType",
    type = "Enum",
    des = "花盆类型标签",
    arg0 = "Normal#Narrow#Basket#Garden",
    arg1 = "Normal"
  },
  {
    mod = "盆栽",
    name = "initial",
    type = "Factory",
    des = "初始花盆",
    arg0 = "HomeFurnitureFactory"
  },
  {
    mod = "盆栽",
    name = "",
    type = "SysLine",
    des = "3D模型偏移"
  },
  {
    mod = "盆栽",
    name = "flowerX3D",
    type = "Double",
    des = "X轴偏移",
    arg0 = "0"
  },
  {
    mod = "盆栽",
    name = "flowerY3D",
    type = "Double",
    des = "Y轴偏移",
    arg0 = "0"
  },
  {
    mod = "盆栽",
    name = "flowerZ3D",
    type = "Double",
    des = "Z轴偏移",
    arg0 = "0"
  },
  {
    mod = "盆栽",
    name = "flowerScaleX",
    type = "Double",
    des = "3d花X轴缩放",
    arg0 = "1"
  },
  {
    mod = "盆栽",
    name = "flowerScaleY",
    type = "Double",
    des = "3d花Y轴缩放",
    arg0 = "1"
  },
  {
    mod = "盆栽",
    name = "",
    type = "SysLine",
    des = "2DUI偏移"
  },
  {
    mod = "盆栽",
    name = "flowerX2D",
    type = "Double",
    des = "X轴偏移",
    arg0 = "0"
  },
  {
    mod = "盆栽",
    name = "flowerY2D",
    type = "Double",
    des = "Y轴偏移",
    arg0 = "0"
  }
})
