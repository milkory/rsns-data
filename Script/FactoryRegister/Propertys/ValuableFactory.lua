RegProperty("ValuableFactory", {
  {
    name = "costId",
    type = "String",
    des = "支付id",
    arg0 = ""
  },
  {
    name = "correspondStore",
    type = "Factory",
    des = "对应商店",
    arg0 = "StoreFactory"
  },
  {
    name = "name",
    type = "StringT",
    des = "商品名称",
    arg0 = ""
  },
  {
    name = "describe",
    type = "StringT",
    des = "商品描述",
    arg0 = ""
  },
  {
    name = "iconPath",
    type = "Png",
    des = "商品图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "buyPath",
    type = "Png",
    des = "购买弹窗图片",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "isTips",
    type = "Bool",
    des = "是否需要提示弹窗",
    arg0 = "False"
  },
  {
    mod = "",
    name = "rewardList",
    type = "Array",
    des = "包含物品",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品id",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#FridgeItemFactory#HomeFurnitureFactory#PetFactory#ProfilePhotoFactory#HomeCharacterSkinFactory#HomeWeaponFactory#UnitViewFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "isFirst",
    type = "Bool",
    des = "是否有首充奖励",
    arg0 = "False"
  },
  {
    mod = "",
    name = "rewardFirstList",
    type = "Array",
    des = "首充赠送",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品id",
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
    mod = "",
    name = "rewardFollowList",
    type = "Array",
    des = "后续赠送",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品id",
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
    name = "buyType",
    type = "Enum",
    des = "购买类型",
    arg0 = "Money#Item",
    arg1 = "Money"
  },
  {
    name = "value",
    type = "Double",
    des = "货币价值",
    arg0 = "100"
  },
  {
    name = "buyItemList",
    type = "Array",
    des = "购买道具",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品id",
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
    name = "superValue",
    type = "Int",
    des = "超值系数（纯显示）",
    arg0 = "200"
  },
  {
    name = "",
    type = "SysLine",
    des = "限购"
  },
  {
    name = "purchase",
    type = "Bool",
    des = "是否限购",
    arg0 = "False"
  },
  {
    name = "purchaseNum",
    type = "Int",
    des = "限购数量",
    arg0 = "1"
  },
  {
    name = "limitBuyType",
    type = "Enum",
    des = "限购类型",
    arg0 = "Forever#Daily#Weekly#Monthly",
    arg1 = "Forever"
  },
  {
    name = "",
    type = "SysLine",
    des = "限时"
  },
  {
    name = "isTime",
    type = "Bool",
    des = "是否限时",
    arg0 = "False"
  },
  {
    name = "startTime",
    type = "String",
    des = "开始时间",
    arg0 = ""
  },
  {
    name = "endTime",
    type = "String",
    des = "结束时间",
    arg0 = ""
  },
  {
    name = "",
    type = "SysLine",
    des = "限制条件"
  },
  {
    name = "isBuyCondition",
    type = "Bool",
    des = "是否有购买限制",
    arg0 = "False"
  },
  {
    name = "gradeCondition",
    type = "Int",
    des = "列车长等级条件",
    arg0 = "0"
  },
  {
    name = "",
    type = "SysLine",
    des = "月卡礼包"
  },
  {
    name = "ismonthCard",
    type = "Bool",
    des = "是否为月卡礼包",
    arg0 = "False"
  },
  {
    name = "showList",
    type = "Array",
    des = "月卡奖励(纯界面显示用)",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品id",
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
    name = "",
    type = "SysLine",
    des = "皮肤礼包"
  },
  {
    name = "isCharacterSkin",
    type = "Bool",
    des = "是否为皮肤礼包",
    arg0 = "False"
  },
  {
    name = "",
    type = "SysLine",
    des = "通行证"
  },
  {
    name = "BattlePassLevel",
    type = "Int",
    des = "通行证等级",
    arg0 = "0"
  }
})
