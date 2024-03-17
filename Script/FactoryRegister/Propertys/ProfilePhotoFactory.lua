RegProperty("ProfilePhotoFactory", {
  {
    name = "name",
    type = "StringT",
    des = "头像名",
    arg0 = ""
  },
  {
    name = "quality",
    type = "Enum",
    des = "品质",
    arg0 = "White#Blue#Purple#Golden",
    arg1 = "White"
  },
  {
    name = "imagePath",
    type = "Png",
    des = "图片路径",
    arg0 = "",
    arg1 = "130|130"
  },
  {
    mod = "",
    name = "tipsPath",
    type = "Png",
    des = "Tips图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "des",
    type = "TextT",
    des = "描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "convertItem",
    type = "Array",
    des = "相同头像转换",
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
    des = "数量",
    arg0 = "50"
  },
  {name = "end"},
  {
    name = "sort",
    type = "Int",
    des = "排序优先级",
    arg0 = "0"
  }
})
