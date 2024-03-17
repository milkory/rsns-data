RegProperty("ItemFactory", {
  {
    mod = "",
    name = "iconPath",
    type = "Png",
    des = "道具图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
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
    mod = "",
    name = "buyPath",
    type = "Png",
    des = "购买用图标",
    arg0 = "",
    arg1 = "43|39",
    pyIgnore = true
  },
  {
    mod = "",
    name = "textIcon",
    type = "String",
    des = "TextIcon",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "sort",
    type = "Int",
    des = "排序权重",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "isNotDisplayInBag",
    type = "Bool",
    des = "不在背包中显示",
    arg0 = "False",
    pyIgnore = true
  },
  {
    name = "isShowNum",
    type = "Bool",
    des = "显示拥有数量",
    arg0 = "True",
    pyIgnore = true
  },
  {
    mod = "可使用道具",
    name = "batchUsetype",
    type = "Enum",
    des = "批量使用类型",
    arg0 = "Other#Energy#Tired",
    arg1 = "Other",
    pyIgnore = true
  },
  {
    mod = "基础道具,可使用道具",
    name = "useLimitNum",
    type = "Int",
    des = "批量使用上限",
    arg0 = "10"
  },
  {
    mod = "可使用道具",
    name = "isTiredItem",
    type = "Bool",
    des = "是否为疲劳恢复道具",
    arg0 = "False",
    pyIgnore = true
  },
  {
    mod = "可使用道具",
    name = "containEquipment",
    type = "Bool",
    des = "奖励中包含装备",
    arg0 = "False"
  },
  {
    mod = "可使用道具",
    name = "isCompose",
    type = "Bool",
    des = "按钮上显示合成",
    arg0 = "False",
    pyIgnore = true
  },
  {
    mod = "可使用道具",
    name = "isDrinkItem",
    type = "Bool",
    des = "是否为喝酒恢复道具",
    arg0 = "False"
  },
  {
    mod = "可使用道具",
    name = "drinkNum",
    type = "Int",
    des = "增加喝酒次数",
    arg0 = "3"
  },
  {
    mod = "可使用道具",
    name = "isBattlePassItem",
    type = "Bool",
    des = "是否为通行证返利道具",
    arg0 = "False"
  },
  {
    mod = "可使用道具",
    name = "BattlePassType",
    type = "Enum",
    des = "通行证类型",
    arg0 = "Low#High",
    arg1 = "Low"
  },
  {
    mod = "可使用道具,图纸道具",
    name = "breakPath",
    type = "Png",
    des = "道具头像",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "可使用道具",
    name = "uiPath",
    type = "String",
    des = "使用后打开界面",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "装备道具",
    name = "briefText",
    type = "String",
    des = "简略文本",
    arg0 = ""
  },
  {
    mod = "跳转道具",
    name = "",
    type = "SysLine",
    des = "跳转道具",
    pyIgnore = true
  },
  {
    mod = "跳转道具",
    name = "Prefab",
    type = "String",
    des = "目标界面",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "议价道具",
    name = "",
    type = "SysLine",
    des = "议价道具",
    pyIgnore = true
  },
  {
    mod = "议价道具",
    name = "homeBuffId",
    type = "Factory",
    des = "议价Buff",
    arg0 = "HomeBuffFactory",
    arg1 = "议价道具"
  },
  {
    mod = "议价道具",
    name = "",
    type = "SysLine",
    des = "限时道具",
    pyIgnore = true
  },
  {
    mod = "",
    name = "endTime",
    type = "String",
    des = "使用截止时间",
    arg0 = ""
  },
  {
    mod = "可使用道具",
    name = "limitedTime",
    type = "Int",
    des = "限时天数",
    arg0 = ""
  },
  {
    mod = "通行证道具",
    name = "battlePassGrade",
    type = "Int",
    des = "转化通行证积分",
    arg0 = ""
  },
  {
    mod = "议价道具",
    name = "",
    type = "SysLine",
    des = "出售",
    pyIgnore = true
  },
  {
    mod = "",
    name = "saletype",
    type = "Enum",
    des = "出售类型",
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
    type = "Int",
    des = "奖励ID",
    arg0 = "11400001"
  },
  {
    name = "num",
    type = "Int",
    des = "奖励数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "月卡道具",
    name = "",
    type = "SysLine",
    des = "月卡道具",
    pyIgnore = true
  },
  {
    mod = "月卡道具",
    name = "isMonth",
    type = "Bool",
    des = "是否月卡道具",
    arg0 = "False"
  },
  {
    mod = "月卡道具",
    name = "monthTime",
    type = "Int",
    des = "月卡天数",
    arg0 = "30"
  },
  {
    mod = "月卡道具",
    name = "monthList",
    type = "Array",
    des = "月卡奖励",
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
    mod = "插画",
    name = "",
    type = "SysLine",
    des = "插画",
    pyIgnore = true
  },
  {
    mod = "插画",
    name = "imagePath",
    type = "Png",
    des = "图片路径",
    arg0 = "",
    arg1 = "320|180",
    pyIgnore = true
  },
  {
    mod = "照片",
    name = "pictureId",
    type = "Factory",
    des = "照片ID",
    arg0 = "PictureFactory"
  },
  {
    mod = "录像",
    name = "videoId",
    type = "Factory",
    des = "录像ID",
    arg0 = "VideoFactory"
  },
  {
    mod = "磁带",
    name = "soundId",
    type = "Factory",
    des = "磁带ID",
    arg0 = "SoundFactory"
  },
  {
    mod = "头像",
    name = "profilePhotoID",
    type = "Factory",
    des = "头像ID",
    arg0 = "ProfilePhotoFactory"
  },
  {
    mod = "食材",
    name = "FoodCategory",
    type = "Enum",
    des = "食材种类",
    arg0 = "观赏鱼#食用鱼#植物",
    arg1 = "食用鱼"
  },
  {
    mod = "食材",
    name = "Rate",
    type = "Int",
    des = "食材比",
    arg0 = "0"
  },
  {
    mod = "议价道具",
    name = "",
    type = "SysLine",
    des = "获取途径",
    pyIgnore = true
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
  {name = "end", pyIgnore = true},
  {
    mod = "装备道具",
    name = "Experiencevalue",
    type = "Int",
    des = "提供经验",
    arg0 = "1000"
  },
  {
    mod = "装备道具",
    name = "EntryItemList",
    type = "Array",
    des = "词缀列表",
    detail = "Entry#Weight"
  },
  {
    name = "Entry",
    type = "Factory",
    des = "词缀",
    arg0 = "SkillFactory#ListFactory"
  },
  {
    name = "Weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "装备道具",
    name = "campType",
    type = "Factory",
    des = "阵营限制",
    arg0 = "TagFactory"
  },
  {
    mod = "装备道具",
    name = "EquipItemType",
    type = "Factory",
    des = "道具类型",
    arg0 = "TagFactory",
    arg1 = "装备"
  },
  {
    mod = "建设进度",
    name = "",
    type = "SysLine",
    des = "使用城市",
    pyIgnore = true
  },
  {
    mod = "建设进度",
    name = "correspondingCity",
    type = "Factory",
    des = "建设度对应站点",
    arg0 = "HomeStationFactory"
  },
  {
    mod = "图纸道具",
    name = "drawing",
    type = "Factory",
    des = "图纸配方组|关联所有配方",
    arg0 = "ProductionFactory"
  },
  {
    mod = "资料道具",
    name = "dataDrop",
    type = "Factory",
    des = "对应资料",
    arg0 = "DataFactory"
  },
  {
    mod = "资料道具",
    name = "useAutomatically",
    type = "Bool",
    des = "是否自动使用",
    arg0 = "False"
  },
  {
    mod = "可使用道具",
    name = "gettipstype",
    type = "Enum",
    des = "弹窗类型",
    arg0 = "Default#Pet",
    arg1 = "Default",
    pyIgnore = true
  },
  {
    mod = "活动纪念卡",
    name = "",
    type = "SysLine",
    des = "获取前置条件"
  },
  {
    mod = "活动纪念卡",
    name = "preconditionsList",
    type = "Array",
    des = "纪念卡列表",
    detail = "cardID"
  },
  {
    name = "cardID",
    type = "Factory",
    des = "纪念卡ID",
    arg0 = "ItemFactory",
    arg1 = "活动纪念卡"
  },
  {name = "end"}
})
