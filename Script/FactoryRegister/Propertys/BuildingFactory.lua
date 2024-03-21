RegProperty("BuildingFactory", {
  {
    name = "name",
    type = "StringT",
    des = "建筑名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "buildingIconPath",
    type = "Png",
    des = "建筑Logo",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "firstPlotId",
    type = "Factory",
    des = "进入首次触发剧情",
    arg0 = "ParagraphFactory"
  },
  {
    name = "uiPath",
    type = "String",
    des = "UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "bgPath",
    type = "Png",
    des = "背景图片",
    arg0 = "",
    arg1 = "216|100",
    pyIgnore = true
  },
  {
    name = "bgColor",
    type = "String",
    des = "背景图颜色",
    arg0 = "FFFFFF",
    pyIgnore = true
  },
  {
    name = "stationId",
    type = "Factory",
    des = "车站|用于声望相关功能",
    arg0 = "HomeStationFactory"
  },
  {
    name = "npcId",
    type = "Factory",
    des = "NPC",
    arg0 = "NPCFactory",
    pyIgnore = true
  },
  {
    name = "favorability",
    type = "Bool",
    des = "增加好感度|增加NPC好感度",
    arg0 = "False"
  },
  {
    name = "helpId",
    type = "Factory",
    des = "帮助功能",
    arg0 = "ListFactory",
    pyIgnore = true
  },
  {
    name = "rankId",
    type = "Factory",
    des = "排行榜功能",
    arg0 = "RankFactory"
  },
  {
    name = "eventList",
    type = "Array",
    des = "交谈事件列表",
    detail = "questId#eventType#eventId#startTime#endTime#activityId",
    pyIgnore = true
  },
  {
    name = "questId",
    type = "Factory",
    des = "拥有任务|解锁未完成",
    arg0 = "QuestFactory",
    pyIgnore = true
  },
  {
    name = "eventType",
    type = "Enum",
    des = "事件类型||Dialog:剧情,Level:关卡",
    arg0 = "Dialog#Level",
    arg1 = "Dialog",
    pyIgnore = true
  },
  {
    name = "eventId",
    type = "Factory",
    des = "事件ID",
    arg0 = "ParagraphFactory#LevelFactory",
    pyIgnore = true
  },
  {
    name = "activityId",
    type = "Factory",
    des = "在活动期间显示|活动ID",
    arg0 = "ActivityFactory",
    pyIgnore = true
  },
  {
    name = "startTime",
    type = "String",
    des = "开始时间|与活动时间互斥",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "endTime",
    type = "String",
    des = "结束时间|与活动时间互斥",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    mod = "兑换站",
    name = "",
    type = "SysLine",
    des = "进入限制"
  },
  {
    mod = "兑换站",
    name = "playerLevel",
    type = "Int",
    des = "列车长等级",
    arg0 = "20"
  },
  {
    mod = "动态建筑",
    name = "openPageList",
    type = "Array",
    des = "开启界面功能列表",
    detail = "icon#name#reputation#showUI#btnType",
    pyIgnore = true
  },
  {
    name = "icon",
    type = "Png",
    des = "对应图标",
    arg0 = "",
    arg1 = "60|60"
  },
  {
    name = "name",
    type = "String",
    des = "对应名字",
    arg0 = ""
  },
  {
    name = "reputation",
    type = "Int",
    des = "声望限制",
    arg0 = "1"
  },
  {
    name = "showUI",
    type = "String",
    des = "开启界面",
    arg0 = ""
  },
  {
    name = "btnType",
    type = "Enum",
    des = "功能枚举||Exchange:兑换,Expel:驱逐关卡,Talk:交谈,Other:其他",
    arg0 = "Exchange#Expel#Talk#Other",
    arg1 = "Other",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "垃圾站",
    name = "integralCoefficient",
    type = "Int",
    des = "积分系数",
    arg0 = "2000"
  },
  {
    mod = "垃圾站",
    name = "integralRewardList",
    type = "Array",
    des = "积分奖励列表",
    detail = "integral#id#index"
  },
  {
    name = "integral",
    type = "Int",
    des = "所需积分",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励",
    arg0 = "ListFactory"
  },
  {
    name = "index",
    type = "Int",
    des = "排列顺序",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "垃圾站",
    name = "rubbishRankList",
    type = "Array",
    des = "垃圾站排行榜",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "排行榜",
    arg0 = "RankFactory"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "battleLevelName",
    type = "String",
    des = "作战名称",
    arg0 = ""
  },
  {
    mod = "作战中心",
    name = "battleLevelList",
    type = "Array",
    des = "关卡列表",
    detail = "id#difficulty"
  },
  {
    name = "id",
    type = "Factory",
    des = "关卡",
    arg0 = "LevelFactory"
  },
  {
    name = "difficulty",
    type = "Int",
    des = "难度",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "createOrderList",
    type = "Array",
    des = "交货订单列表",
    detail = "id#constructLimit"
  },
  {
    name = "id",
    type = "Factory",
    des = "生成交货订单",
    arg0 = "ListFactory"
  },
  {
    name = "constructLimit",
    type = "Int",
    des = "格子开启限制",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "refreshTime",
    type = "Int",
    des = "订单刷新时间",
    arg0 = "300"
  },
  {
    mod = "作战中心",
    name = "constructStageList",
    type = "Array",
    des = "建设阶段列表",
    detail = "name#nameEN#constructNum#id#state#desc#png"
  },
  {
    name = "name",
    type = "String",
    des = "阶段名称(中文)",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "nameEN",
    type = "String",
    des = "阶段名称(英文)",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "constructNum",
    type = "Int",
    des = "阶段所需进度",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "建设阶段奖励",
    arg0 = "ListFactory"
  },
  {
    name = "state",
    type = "Int",
    des = "切换状态ID",
    arg0 = "0"
  },
  {
    name = "desc",
    type = "TextT",
    des = "阶段描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "png",
    type = "Png",
    des = "阶段图",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "sellList",
    type = "Array",
    des = "出售货物列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "列表工厂",
    arg0 = "ListFactory",
    arg1 = "货物"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "acquisitionList",
    type = "Array",
    des = "收购货物列表|不用配置出售列表中的货物。出售当前车站的货物，价格始终为购买价格的50%",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "列表工厂",
    arg0 = "ListFactory",
    arg1 = "货物"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "",
    type = "SysLine",
    des = "仓库",
    pyIgnore = true
  },
  {
    mod = "交易所",
    name = "isWarehouse",
    type = "Bool",
    des = "是否有仓库",
    arg0 = "False"
  },
  {
    mod = "交易所",
    name = "warehousePrestige",
    type = "Int",
    des = "仓库开启声望等级",
    arg0 = "1"
  },
  {
    mod = "交易所",
    name = "buyPrice",
    type = "Array",
    des = "仓库单个购买价格",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "购买道具",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "价格",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "buyReward",
    type = "Array",
    des = "仓库购买奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "声望道具",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "",
    type = "SysLine",
    des = "排行榜",
    pyIgnore = true
  },
  {
    mod = "交易所",
    name = "tradeRankList",
    type = "Array",
    des = "排行榜",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "排行榜",
    arg0 = "RankFactory"
  },
  {name = "end"},
  {
    mod = "商会",
    name = "initCOCQuestList",
    type = "Array",
    des = "初始任务列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "订单"
  },
  {name = "end"},
  {
    mod = "商会",
    name = "cocStoreList",
    type = "Array",
    des = "商店列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "商店",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "铁安局",
    name = "createQuestList",
    type = "Array",
    des = "驱逐任务列表",
    detail = "id#repCondition"
  },
  {
    name = "id",
    type = "Factory",
    des = "生成任务",
    arg0 = "ListFactory"
  },
  {
    name = "repCondition",
    type = "Int",
    des = "声望等级限制",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "铁安局",
    name = "triggerPlot",
    type = "Factory",
    des = "触发剧情",
    arg0 = "ParagraphFactory"
  },
  {
    mod = "铁安局",
    name = "triggerQuest",
    type = "Factory",
    des = "触发支线任务",
    arg0 = "QuestFactory"
  },
  {
    mod = "铁安局",
    name = "",
    type = "SysLine",
    des = "素材部分"
  },
  {
    mod = "铁安局",
    name = "tagOnPath",
    type = "Png",
    des = "选中图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "铁安局",
    name = "tagOffPath",
    type = "Png",
    des = "未选中图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "铁安局",
    name = "expelBgPath",
    type = "Png",
    des = "背景底板",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "铁安局",
    name = "",
    type = "SysLine",
    des = "悬赏"
  },
  {
    mod = "铁安局",
    name = "offerPrestige",
    type = "Int",
    des = "悬赏开启声望等级",
    arg0 = "3"
  },
  {
    mod = "铁安局",
    name = "offerQuestList",
    type = "Array",
    des = "悬赏任务",
    detail = "bossId#id#weight#isRepetition"
  },
  {
    name = "bossId",
    type = "Factory",
    des = "显示怪物",
    arg0 = "UnitFactory"
  },
  {
    name = "id",
    type = "Factory",
    des = "悬赏任务",
    arg0 = "LevelFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {
    name = "isRepetition",
    type = "Bool",
    des = "是否会被重复刷新",
    arg0 = "False"
  },
  {name = "end"},
  {
    mod = "铁安局",
    name = "",
    type = "SysLine",
    des = "报案"
  },
  {
    mod = "铁安局",
    name = "shareLevelNumMax",
    type = "Int",
    des = "分享关卡数量上限",
    arg0 = "10"
  },
  {
    mod = "铁安局",
    name = "changeRefreshTime",
    type = "Int",
    des = "换一批CD时间",
    arg0 = "10"
  },
  {
    mod = "铁安局",
    name = "returnCoefficient",
    type = "Double",
    des = "返还系数",
    arg0 = "0.7"
  },
  {
    mod = "铁安局",
    name = "",
    type = "SysLine",
    des = "兑换"
  },
  {
    mod = "铁安局",
    name = "exchangeBuildId",
    type = "Factory",
    des = "兑换站id",
    arg0 = "BuildingFactory"
  },
  {
    mod = "酒吧",
    name = "limitNum",
    type = "Int",
    des = "限喝次数",
    arg0 = "3"
  },
  {
    mod = "酒吧",
    name = "drinkCost",
    type = "Array",
    des = "喝酒花费",
    detail = "name#id#powerReduce"
  },
  {
    name = "name",
    type = "String",
    des = "喝酒名称",
    arg0 = ""
  },
  {
    name = "id",
    type = "Factory",
    des = "喝酒属性",
    arg0 = "ListFactory"
  },
  {
    name = "powerReduce",
    type = "Int",
    des = "疲劳值减少",
    arg0 = "-5"
  },
  {name = "end"},
  {
    mod = "酒吧",
    name = "barStoreList",
    type = "Array",
    des = "商店",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "商店",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "酒吧",
    name = "drinkVideo",
    type = "String",
    des = "喝酒播放视频",
    arg0 = ""
  },
  {
    mod = "商店",
    name = "petStoreList",
    type = "Array",
    des = "商店列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "商店",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "商店",
    name = "petRecycleStoreList",
    type = "Array",
    des = "回收商店列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "回收商店",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "炸鸡店",
    name = "keepSingleMealList",
    type = "Array",
    des = "单人餐菜单",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "单人餐菜单",
    arg0 = "FoodFactory"
  },
  {name = "end"},
  {
    mod = "炸鸡店",
    name = "keepTeamMealList",
    type = "Array",
    des = "团队餐菜单",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "团队餐菜单",
    arg0 = "FoodFactory"
  },
  {name = "end"},
  {
    mod = "炸鸡店",
    name = "inviteTimes",
    type = "Int",
    des = "请客邀请次数",
    arg0 = "1"
  },
  {
    mod = "兑换站",
    name = "exchangeOpenPageList",
    type = "Array",
    des = "兑换站开启列表",
    detail = "icon#name#showUI#uiPath#isTalk#isStore",
    pyIgnore = true
  },
  {
    name = "icon",
    type = "Png",
    des = "对应图标",
    arg0 = "",
    arg1 = "60|60"
  },
  {
    name = "name",
    type = "String",
    des = "对应名字",
    arg0 = ""
  },
  {
    name = "showUI",
    type = "String",
    des = "开启UI组",
    arg0 = ""
  },
  {
    name = "uiPath",
    type = "String",
    des = "开启界面",
    arg0 = ""
  },
  {
    name = "isTalk",
    type = "Bool",
    des = "是否为交谈",
    arg0 = "False"
  },
  {
    name = "isStore",
    type = "Bool",
    des = "是否为兑换",
    arg0 = "False"
  },
  {name = "end"},
  {
    mod = "兑换站",
    name = "exchangeStoreList",
    type = "Array",
    des = "开启兑换商店",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "兑换商店",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "兑换站",
    name = "exchangeWeaponList",
    type = "Array",
    des = "开启武装商店",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "武装商店",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "兑换站",
    name = "isShowConstruct",
    type = "Bool",
    des = "是否显示建设进度",
    arg0 = "False",
    pyIgnore = true
  },
  {
    mod = "兑换站",
    name = "isShowReputation",
    type = "Bool",
    des = "是否显示声望",
    arg0 = "False",
    pyIgnore = true
  },
  {
    mod = "兑换站",
    name = "exchangeName",
    type = "String",
    des = "兑换名称",
    arg0 = ""
  },
  {
    mod = "兑换站",
    name = "buildingPath",
    type = "Png",
    des = "建筑图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "兑换站",
    name = "exchangePath",
    type = "Png",
    des = "兑换图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "兑换站",
    name = "pagePath",
    type = "Png",
    des = "页面背景",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "兑换站",
    name = "bottomPath",
    type = "Png",
    des = "兑换底",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "兑换站",
    name = "exchangeAffirmPath",
    type = "Png",
    des = "兑换确认按钮",
    arg0 = "",
    arg1 = "160|160"
  },
  {
    mod = "兑换站",
    name = "exchangeCompletePath",
    type = "Png",
    des = "兑换完成按钮",
    arg0 = "",
    arg1 = "160|160"
  },
  {
    mod = "传单地点",
    name = "namePlace",
    type = "String",
    des = "地点名",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "传单地点",
    name = "placeType",
    type = "Factory",
    des = "地点类型",
    arg0 = "TagFactory"
  },
  {
    mod = "传单地点",
    name = "namePlaceIcon",
    type = "Png",
    des = "店铺图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "传单地点",
    name = "PlaceDesc",
    type = "Factory",
    des = "地点描述",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    mod = "传单地点",
    name = "unlockPlace",
    type = "Int",
    des = "店铺城市声望解锁条件",
    arg0 = "0"
  },
  {
    mod = "传单地点",
    name = "placeWeight",
    type = "Int",
    des = "店铺排序权重",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "传单地点",
    name = "passageMax",
    type = "Int",
    des = "乘客招收上限",
    arg0 = "0"
  },
  {
    mod = "传单地点",
    name = "passageMin",
    type = "Int",
    des = "乘客招收下限",
    arg0 = "0"
  },
  {
    mod = "传单地点",
    name = "passageTypeList",
    type = "Array",
    des = "乘客招收构成",
    detail = "id#weight"
  },
  {
    mod = "传单地点",
    name = "id",
    type = "Factory",
    des = "乘客id",
    arg0 = "PassageFactory"
  },
  {
    mod = "传单地点",
    name = "weight",
    type = "Int",
    des = "乘客构成权重",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "传单地点",
    name = "passageTagList",
    type = "Array",
    des = "招收乘客标签",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "标签id",
    arg0 = "ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "标签构成权重",
    arg0 = "0"
  },
  {name = "end"}
})
