RegProperty("ActivityFactory", {
  {
    name = "name",
    type = "StringT",
    des = "活动名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "showUI",
    type = "String",
    des = "显示界面",
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
    name = "npcId",
    type = "Factory",
    des = "NPC",
    arg0 = "NPCFactory",
    pyIgnore = true
  },
  {
    name = "helpId",
    type = "Factory",
    des = "帮助功能",
    arg0 = "ListFactory",
    pyIgnore = true
  },
  {
    name = "voiceActivity",
    type = "Factory",
    des = "活动背景音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "参加类型",
    type = "SysLine",
    des = ""
  },
  {
    name = "isJoin",
    type = "Bool",
    des = "活动是否需要参加",
    arg0 = "False"
  },
  {
    name = "参加限制",
    type = "SysLine",
    des = ""
  },
  {
    name = "questId",
    type = "Factory",
    des = "完成任务",
    arg0 = "QuestFactory"
  },
  {
    name = "限时部分",
    type = "SysLine",
    des = ""
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
    des = "奖励预览"
  },
  {
    name = "rewardPreviewList",
    type = "Array",
    des = "预览物品",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品id",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#FridgeItemFactory#HomeFurnitureFactory#PetFactory#ProfilePhotoFactory#HomeCharacterSkinFactory#HomeWeaponFactory#UnitViewFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "活动商店"
  },
  {
    name = "activityStoreList",
    type = "Array",
    des = "活动开启商店",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "开启商店",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    mod = "签到",
    name = "signinId",
    type = "Factory",
    des = "签到id",
    arg0 = "SigninFactory"
  },
  {
    mod = "红茶活动",
    name = "joinPlotId",
    type = "Factory",
    des = "参与触发剧情",
    arg0 = "ParagraphFactory"
  },
  {
    mod = "红茶活动",
    name = "joinQuestId",
    type = "Factory",
    des = "参与触发任务",
    arg0 = "QuestFactory"
  },
  {
    mod = "红茶活动",
    name = "sequenceList",
    type = "Array",
    des = "序幕列表",
    detail = "startTime#questId#skipId"
  },
  {
    name = "startTime",
    type = "String",
    des = "开启时间",
    arg0 = ""
  },
  {
    name = "questId",
    type = "Factory",
    des = "前置任务",
    arg0 = "QuestFactory"
  },
  {
    name = "skipId",
    type = "Factory",
    des = "跳转部分",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "红茶活动",
    name = "",
    type = "SysLine",
    des = "采购任务"
  },
  {
    mod = "红茶活动",
    name = "isChangeCOCQuest",
    type = "Bool",
    des = "修改商会任务",
    arg0 = "True"
  },
  {
    mod = "红茶活动",
    name = "stationList",
    type = "Array",
    des = "活动城市列表",
    detail = "stationId#startTime#endTime#listId"
  },
  {
    name = "stationId",
    type = "Factory",
    des = "触发城市",
    arg0 = "HomeStationFactory"
  },
  {
    name = "startTime",
    type = "String",
    des = "开始时间(子)|不配时读取活动开始时间",
    arg0 = ""
  },
  {
    name = "endTime",
    type = "String",
    des = "结束时间(子)|不配时读取活动结束时间",
    arg0 = ""
  },
  {
    name = "listId",
    type = "Factory",
    des = "订单列表",
    arg0 = "ListFactory",
    arg1 = "商会任务"
  },
  {name = "end"},
  {
    mod = "红茶活动",
    name = "",
    type = "SysLine",
    des = "活动行情"
  },
  {
    mod = "红茶活动",
    name = "isChangeQuotation",
    type = "Bool",
    des = "修改交易所行情",
    arg0 = "True"
  },
  {
    mod = "红茶活动",
    name = "goodsList",
    type = "Array",
    des = "活动货物列表",
    detail = "goodsId#startTime#endTime#buyStationList#buyQuotationMin#buyQuotationMax#sellStationList#sellQuotationMin#sellQuotationMax"
  },
  {
    name = "goodsId",
    type = "Factory",
    des = "活动货物",
    arg0 = "HomeGoodsFactory",
    arg1 = "基础货物"
  },
  {
    name = "startTime",
    type = "String",
    des = "开始时间(子)|不配时读取活动开始时间",
    arg0 = ""
  },
  {
    name = "endTime",
    type = "String",
    des = "结束时间(子)|不配时读取活动结束时间",
    arg0 = ""
  },
  {
    name = "buyStationList",
    type = "Factory",
    des = "买入城市列表",
    arg0 = "ActivityListFactory",
    arg1 = "城市列表"
  },
  {
    name = "buyQuotationMin",
    type = "Double",
    des = "买入行情下限|玩家买入",
    arg0 = "0.75"
  },
  {
    name = "buyQuotationMax",
    type = "Double",
    des = "买入行情上限|玩家买入",
    arg0 = "0.9"
  },
  {
    name = "sellStationList",
    type = "Factory",
    des = "卖出城市列表",
    arg0 = "ActivityListFactory",
    arg1 = "城市列表"
  },
  {
    name = "sellQuotationMin",
    type = "Double",
    des = "卖出行情下限|玩家卖出",
    arg0 = "1.1"
  },
  {
    name = "sellQuotationMax",
    type = "Double",
    des = "卖出行情上限|玩家卖出",
    arg0 = "1.35"
  },
  {name = "end"},
  {
    mod = "红茶活动",
    name = "",
    type = "SysLine",
    des = "活动成就"
  },
  {
    mod = "红茶活动",
    name = "tradeTypeList",
    type = "Array",
    des = "贸易成就种类列表",
    detail = "typeId#typeEnum#seriesName#targetNum#icon"
  },
  {
    name = "typeId",
    type = "Factory",
    des = "种类",
    arg0 = "ListFactory",
    arg1 = "活动相关"
  },
  {
    name = "typeEnum",
    type = "Enum",
    des = "成就类型||addProfit:累计利润,onceProfit:单笔最高",
    arg0 = "addProfit#onceProfit",
    arg1 = ","
  },
  {
    name = "seriesName",
    type = "StringT",
    des = "种类名称",
    arg0 = ""
  },
  {
    name = "targetNum",
    type = "Int",
    des = "目标数量",
    arg0 = "1"
  },
  {
    name = "icon",
    type = "Png",
    des = "种类大图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "红茶活动",
    name = "battleList",
    type = "Array",
    des = "作战成就列表",
    detail = "missionId#lockDes#commonBg#lockedBg#icon"
  },
  {
    name = "missionId",
    type = "Factory",
    des = "成就id",
    arg0 = "QuestFactory",
    arg1 = "活动任务"
  },
  {
    name = "lockDes",
    type = "StringT",
    des = "前置条件提示",
    arg0 = ""
  },
  {
    name = "commonBg",
    type = "Png",
    des = "正常成就背景",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "lockedBg",
    type = "Png",
    des = "锁定时成就背景",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "icon",
    type = "Png",
    des = "作战成就图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "红茶活动",
    name = "",
    type = "SysLine",
    des = "阶段奖励"
  },
  {
    mod = "红茶活动",
    name = "ServerProgressList",
    type = "Array",
    des = "全服阶段任务列表",
    detail = "id#buff#buyNum#buyPng#revenueNum#revenuePng#buyIcon#revenueIcon"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "活动任务"
  },
  {
    name = "buff",
    type = "Factory",
    des = "buff",
    arg0 = "HomeBuffFactory",
    arg1 = "活动buff"
  },
  {
    name = "buyNum",
    type = "Int",
    des = "买入数值",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "buyPng",
    type = "Png",
    des = "买入buff图标",
    arg0 = "",
    arg1 = "116|106",
    pyIgnore = true
  },
  {
    name = "buyIcon",
    type = "Png",
    des = "买入图标",
    arg0 = "",
    arg1 = "116|106",
    pyIgnore = true
  },
  {
    name = "revenueNum",
    type = "Int",
    des = "税收数值",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "revenuePng",
    type = "Png",
    des = "税收buff图标",
    arg0 = "",
    arg1 = "116|106",
    pyIgnore = true
  },
  {
    name = "revenueIcon",
    type = "Png",
    des = "税收图标",
    arg0 = "",
    arg1 = "116|106",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "红茶活动",
    name = "PersonalProgressList",
    type = "Array",
    des = "个人阶段任务列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "活动任务"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "收集卡包"
  },
  {
    name = "activityCardPack",
    type = "Factory",
    des = "活动卡包",
    arg0 = "CollectionCardPackFactory",
    arg1 = "基础卡包"
  },
  {
    mod = "红茶活动",
    name = "activityGoods",
    type = "Factory",
    des = "活动商品",
    arg0 = "HomeGoodsFactory",
    arg1 = "基础货物"
  }
})
