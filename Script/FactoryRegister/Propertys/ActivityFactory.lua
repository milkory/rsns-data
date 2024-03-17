RegProperty("ActivityFactory", {
  {
    name = "name",
    type = "String",
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
    name = "sequenceList",
    type = "Array",
    des = "序幕列表",
    detail = "putTime#name#questId"
  },
  {
    name = "putTime",
    type = "Int",
    des = "顺延时间（小时",
    arg0 = "72"
  },
  {
    name = "name",
    type = "String",
    des = "名称",
    arg0 = ""
  },
  {
    name = "questId",
    type = "Factory",
    des = "前置任务",
    arg0 = "QuestFactory"
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
    name = "achievementTypeList",
    type = "Array",
    des = "成就种类列表",
    detail = "typeId"
  },
  {
    name = "typeId",
    type = "Factory",
    des = "种类",
    arg0 = "ListFactory",
    arg1 = "活动相关"
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
    detail = "Id#buff"
  },
  {
    name = "Id",
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
  {name = "end"},
  {
    mod = "红茶活动",
    name = "PersonalProgressList",
    type = "Array",
    des = "个人阶段任务列表",
    detail = "Id"
  },
  {
    name = "Id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "活动任务"
  },
  {name = "end"}
})
