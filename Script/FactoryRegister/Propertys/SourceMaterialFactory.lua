RegProperty("SourceMaterialFactory", {
  {
    mod = "",
    name = "tipsPath",
    type = "Png",
    des = "Tips图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "突破材料",
    name = "breakPath",
    type = "Png",
    des = "突破材料头像",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "突破材料",
    name = "isBreakChange",
    type = "Bool",
    des = "是否可分解",
    arg0 = "True"
  },
  {
    mod = "突破材料",
    name = "breakItemList",
    type = "Array",
    des = "分解转化物品",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品id",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "",
    name = "sort",
    type = "Int",
    des = "排序权重",
    arg0 = "0"
  },
  {
    name = "isNotDisplayInBag",
    type = "Bool",
    des = "不在背包中显示",
    arg0 = "False",
    pyIgnore = true
  },
  {
    mod = "经验书",
    name = "",
    type = "SysLine",
    des = "经验书"
  },
  {
    mod = "经验书",
    name = "exp",
    type = "Int",
    des = "经验值",
    arg0 = "0"
  },
  {
    mod = "经验书",
    name = "cost",
    type = "Int",
    des = "消耗金币",
    arg0 = "0"
  },
  {
    mod = "经验书",
    name = "equipExp",
    type = "Int",
    des = "装备经验值",
    arg0 = "0"
  },
  {
    mod = "经验书",
    name = "EquipItemType",
    type = "Factory",
    des = "道具类型",
    arg0 = "TagFactory",
    arg1 = "装备"
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "限时道具"
  },
  {
    mod = "",
    name = "endTime",
    type = "String",
    des = "使用截止时间",
    arg0 = ""
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
    des = "仓库出售类型",
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
    mod = "宠物口粮",
    name = "dayLove",
    type = "Int",
    des = "每日增加亲密度",
    arg0 = "0"
  },
  {
    mod = "宠物口粮",
    name = "petFoodNum",
    type = "Int",
    des = "份量",
    arg0 = "0"
  },
  {
    mod = "宠物口粮",
    name = "petFoodPrice",
    type = "Int",
    des = "价格",
    arg0 = "0"
  },
  {
    mod = "宠物好感道具",
    name = "usedPetVarity",
    type = "Array",
    des = "适用物种",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "适用物种",
    arg0 = "TagFactory",
    arg1 = "宠物物种"
  },
  {name = "end"},
  {
    mod = "宠物好感道具",
    name = "addLove",
    type = "Int",
    des = "增加好感度",
    arg0 = "0"
  },
  {
    mod = "冰箱材料",
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
