RegProperty("PetFactory", {
  {
    name = "petName",
    type = "StringT",
    des = "名字",
    arg0 = ""
  },
  {
    name = "petIconPath",
    type = "Png",
    des = "图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "petVarity",
    type = "Factory",
    des = "物种",
    arg0 = "TagFactory",
    arg1 = "宠物物种"
  },
  {
    name = "petSpecies",
    type = "Factory",
    des = "品种",
    arg0 = "TagFactory",
    arg1 = "宠物品种"
  },
  {
    name = "petFoodInt",
    type = "Int",
    des = "口粮消耗",
    arg0 = "0"
  },
  {
    name = "wasteoutput",
    type = "Int",
    des = "垃圾产出",
    arg0 = "0"
  },
  {
    name = "petBaseScore",
    type = "Int",
    des = "基础评分",
    arg0 = "0"
  },
  {
    name = "petState",
    type = "Int",
    des = "状态",
    arg0 = "8"
  },
  {
    name = "ties",
    type = "Array",
    des = "宠物羁绊",
    detail = "tiesId"
  },
  {
    name = "tiesId",
    type = "Factory",
    des = "宠物羁绊",
    arg0 = "TagFactory",
    arg1 = "宠物羁绊"
  },
  {name = "end"},
  {
    name = "unlockedItem",
    type = "Array",
    des = "解锁道具",
    detail = "itemId#itemNum"
  },
  {
    name = "itemId",
    type = "Factory",
    des = "解锁道具",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "itemNum",
    type = "Int",
    des = "道具数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "homeCharacter",
    type = "Factory",
    des = "对应家园角色",
    arg0 = "HomeCharacterFactory"
  },
  {
    name = "des",
    type = "TextT",
    des = "描述",
    arg0 = "",
    pyIgnore = true
  }
})
