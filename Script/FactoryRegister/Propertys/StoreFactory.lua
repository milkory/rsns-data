RegProperty("StoreFactory", {
  {
    name = "pngSelect",
    type = "Png",
    des = "图标（选中）",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "pngNotSelect",
    type = "Png",
    des = "图标（未选中）",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "shopList",
    type = "Array",
    des = "商品列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "商品ID",
    arg0 = "CommodityFactory#ValuableFactory#HomeWeaponFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "商品权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "回收商店",
    name = "recycleShopList",
    type = "Array",
    des = "回收商品列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "商品ID",
    arg0 = "CommodityFactory#ValuableFactory"
  },
  {name = "end"},
  {
    mod = "推荐商店",
    name = "recommendList",
    type = "Array",
    des = "推荐页列表",
    detail = "name#tabPng#png#type#sequence#otherUI#id#storeId#comSequence#funcId"
  },
  {
    name = "name",
    type = "String",
    des = "推荐页名称",
    arg0 = ""
  },
  {
    name = "tabPng",
    type = "Png",
    des = "页签",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "png",
    type = "Png",
    des = "推荐页图片",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "type",
    type = "Enum",
    des = "功能类型",
    arg0 = "SkipStore#SkipPage#Buy",
    arg1 = "SkipStore"
  },
  {
    name = "sequence",
    type = "Int",
    des = "跳转页面顺序",
    arg0 = "1"
  },
  {
    name = "otherUI",
    type = "String",
    des = "跳转UI界面",
    arg0 = " "
  },
  {
    name = "id",
    type = "Factory",
    des = "商品ID",
    arg0 = "CommodityFactory#ValuableFactory"
  },
  {
    name = "storeId",
    type = "Factory",
    des = "对应商店",
    arg0 = "StoreFactory"
  },
  {
    name = "comSequence",
    type = "Int",
    des = "商品顺序",
    arg0 = "1"
  },
  {
    name = "funcId",
    type = "Int",
    des = "功能ID",
    arg0 = "-1"
  },
  {name = "end"},
  {
    name = "storeType",
    type = "Enum",
    des = "商店类型",
    arg0 = "Random#Regular#Repeatable",
    arg1 = "Random"
  },
  {
    mod = "商店",
    name = "TextLockId",
    type = "Factory",
    des = "未解锁文本",
    arg0 = "TextFactory"
  },
  {
    name = "showUI",
    type = "String",
    des = "显示界面",
    arg0 = "Group_DiamondStore"
  },
  {
    mod = "商店",
    name = "commodityFixedList",
    type = "Array",
    des = "自动刷新固定商品",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "商品ID",
    arg0 = "CommodityFactory#ListFactory"
  },
  {name = "end"},
  {
    mod = "活动商店",
    name = "activityId",
    type = "Factory",
    des = "所属活动",
    arg0 = "ActivityFactory"
  },
  {
    mod = "商店",
    name = "isRecordTimes",
    type = "Bool",
    des = "是否有购买奖励",
    arg0 = "False"
  },
  {
    mod = "商店",
    name = "rewardList",
    type = "Array",
    des = "购买次数奖励",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励列表ID",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "商店",
    name = "isStationRefresh",
    type = "Bool",
    des = "是否切换站点刷新",
    arg0 = "False"
  },
  {
    name = "capacityType",
    type = "Array",
    des = "容量类型",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "容量id",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    name = "refreshType",
    type = "Enum",
    des = "刷新类型",
    arg0 = "Daily#Weekly#Monthly",
    arg1 = "Daily"
  },
  {
    name = "",
    type = "SysLine",
    des = "限时商店"
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
    des = "货币显示"
  },
  {
    name = "currencyShow",
    type = "Array",
    des = "货币显示",
    detail = "id#click"
  },
  {
    name = "id",
    type = "Factory",
    des = "货币显示",
    arg0 = "ItemFactory"
  },
  {
    name = "click",
    type = "Enum",
    des = "点击功能",
    arg0 = "Other#Tips",
    arg1 = "Other"
  },
  {name = "end"}
})
