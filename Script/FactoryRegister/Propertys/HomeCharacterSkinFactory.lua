RegProperty("HomeCharacterSkinFactory", {
  {
    mod = "默认",
    name = "skinType",
    type = "Factory",
    des = "服装类型",
    arg0 = "TagFactory"
  },
  {
    name = "name",
    type = "String",
    des = "服装名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "des",
    type = "String",
    des = "服装描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "默认",
    name = "spineDataPath",
    type = "String",
    des = "spineData路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "发型",
    name = "skinType",
    type = "Factory",
    des = "服装类型",
    arg0 = "TagFactory"
  },
  {
    mod = "发型",
    name = "hairList",
    type = "Array",
    des = "不同形态的发型",
    detail = "hairType#spineDataPath#skinPath",
    pyIgnore = true
  },
  {
    name = "hairType",
    type = "Enum",
    des = "类型",
    arg0 = "Default#Hat#Bald",
    arg1 = "Default",
    pyIgnore = true
  },
  {
    name = "spineDataPath",
    type = "String",
    des = "spineData路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "skinPath",
    type = "String",
    des = "皮肤名字",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    name = "skinPath",
    type = "String",
    des = "Spine皮肤路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "iconPath",
    type = "Png",
    des = "服装图标路径",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "tipsPath",
    type = "Png",
    des = "Tips图标",
    arg0 = "",
    arg1 = "100|100",
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
    name = "character",
    type = "Array",
    des = "适用角色",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "角色id",
    arg0 = "UnitFactory"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "hairType",
    type = "Enum",
    des = "适用发型类型",
    arg0 = "Default#Hat#Bald",
    arg1 = "Default",
    pyIgnore = true
  }
})
