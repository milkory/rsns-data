RegProperty("HomeStationFactory", {
  {
    name = "name",
    type = "StringT",
    des = "车站名",
    arg0 = ""
  },
  {
    name = "nameEN",
    type = "StringT",
    des = "车站英文名",
    arg0 = "",
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
    name = "voiceName",
    type = "Factory",
    des = "车站名语音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "voiceDeparture",
    type = "Factory",
    des = "发车语音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "voiceDeparturePassenger",
    type = "Factory",
    des = "乘客发车语音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "voiceWillArrive",
    type = "Factory",
    des = "即将到站语音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "voiceWillArrivePassenger",
    type = "Factory",
    des = "乘客即将到站语音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "voiceArrive",
    type = "Factory",
    des = "到站语音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "voiceArrivePassenger",
    type = "Factory",
    des = "乘客到站语音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "voiceGetIn",
    type = "Factory",
    des = "进站语音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "voiceGetInPassenger",
    type = "Factory",
    des = "乘客进站语音",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "attachedToCity",
    type = "Factory",
    des = "隶属于",
    arg0 = "HomeStationFactory"
  },
  {
    name = "force",
    type = "Factory",
    des = "势力|如果势力是当前车站则不配",
    arg0 = "TagFactory",
    pyIgnore = true
  },
  {
    name = "isShowRep",
    type = "Bool",
    des = "显示声望|头像面板",
    arg0 = "true",
    pyIgnore = true
  },
  {
    name = "sort",
    type = "Int",
    des = "排序权重|声望总和，越大越靠前",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "textArriveFirst",
    type = "Factory",
    des = "首次抵达文本",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "iconPath",
    type = "Png",
    des = "车站图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "cityMapIconPath",
    type = "Png",
    des = "城市地图图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "解锁条件（都要满足）"
  },
  {
    name = "playerLevel",
    type = "Int",
    des = "列车长等级",
    arg0 = "0"
  },
  {
    name = "questId",
    type = "Factory",
    des = "完成任务",
    arg0 = "QuestFactory"
  },
  {
    name = "specifiedLevelId",
    type = "Factory",
    des = "通关关卡",
    arg0 = "LevelFactory"
  },
  {
    name = "",
    type = "SysLine",
    des = "禁止停靠"
  },
  {
    name = "isBanStop",
    type = "Bool",
    des = "禁止停靠|不能前往，目前只做了前端限制",
    arg0 = "False",
    pyIgnore = true
  },
  {
    name = "banStopTips",
    type = "String",
    des = "禁停提示",
    arg0 = "当前执照无法申请该线路",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "拥有以下任务时限制离开车站"
  },
  {
    name = "lockStationQuestList",
    type = "Array",
    des = "禁止出站任务列表",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "任务`",
    arg0 = "QuestFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    name = "",
    type = "SysLine",
    des = "进站触发剧情"
  },
  {
    name = "enterStationPlotList",
    type = "Array",
    des = "进站触发剧情列表",
    detail = "isTime#startTime#endTime#activityId#questId#id"
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
    name = "activityId",
    type = "Factory",
    des = "参与活动",
    arg0 = "ActivityFactory"
  },
  {
    name = "questId",
    type = "Factory",
    des = "前置任务",
    arg0 = "QuestFactory"
  },
  {
    name = "id",
    type = "Factory",
    des = "触发剧情",
    arg0 = "ParagraphFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "城市地图",
    pyIgnore = true
  },
  {
    name = "cityStateList",
    type = "Array",
    des = "城市状态列表",
    detail = "state#name#cityMapId#dungeonId#sceneId#recommendLevel",
    pyIgnore = true
  },
  {
    name = "state",
    type = "Int",
    des = "状态编号",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "recommendLevel",
    type = "Int",
    des = "推荐等级",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "name",
    type = "String",
    des = "按钮文字",
    arg0 = "访问城市",
    pyIgnore = true
  },
  {
    name = "cityMapId",
    type = "Factory",
    des = "城市地图",
    arg0 = "ListFactory",
    arg1 = "城市地图",
    pyIgnore = true
  },
  {
    name = "dungeonId",
    type = "Factory",
    des = "副本ID",
    arg0 = "ChapterFactory",
    pyIgnore = true
  },
  {
    name = "sceneId",
    type = "Factory",
    des = "车站场景",
    arg0 = "ListFactory",
    arg1 = "车站场景",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    name = "",
    type = "SysLine",
    des = "TimeLine",
    pyIgnore = true
  },
  {
    name = "timeLineList",
    type = "Array",
    des = "站台TimeLine列表",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "TimeLine",
    arg0 = "TimeLineFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    name = "pullOutTimeLineList",
    type = "Array",
    des = "出站TimeLine列表",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "TimeLine",
    arg0 = "TimeLineFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    name = "",
    type = "SysLine",
    des = "大世界",
    pyIgnore = true
  },
  {
    name = "pos",
    type = "Int",
    des = "大世界位置",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "小地图配置"
  },
  {
    name = "isShowInMap",
    type = "Bool",
    des = "在小地图上显示",
    arg0 = "true",
    pyIgnore = true
  },
  {
    name = "x",
    type = "Double",
    des = "x坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "y",
    type = "Double",
    des = "y坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "mapIconPath",
    type = "Png",
    des = "小地图图标",
    arg0 = "",
    arg1 = "50|50",
    pyIgnore = true
  },
  {
    name = "nodePath",
    type = "String",
    des = "小地图红点路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "showGoodsQuest",
    type = "Factory",
    des = "解锁交易品任务",
    arg0 = "QuestFactory",
    arg1 = "基础任务",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "城市声望",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "repRewardList",
    type = "Array",
    des = "声望奖励列表",
    detail = "repNum#id#revenue#buyNum#bargainNum#riseNum#bargainSuccessRate#wareNum#cocAutoRefreshNum#cocQuestList#offerAutoRefreshNum#honorPng#flagPng#peopleName#desc"
  },
  {
    name = "repNum",
    type = "Double",
    des = "升至下级所需声望",
    arg0 = "500"
  },
  {
    name = "id",
    type = "Factory",
    des = "声望奖励",
    arg0 = "ListFactory"
  },
  {
    name = "revenue",
    type = "Double",
    des = "城市税收",
    arg0 = "0.1"
  },
  {
    name = "buyNum",
    type = "Double",
    des = "增加货品买入量",
    arg0 = "1.2"
  },
  {
    name = "bargainNum",
    type = "Int",
    des = "砍价次数",
    arg0 = "1"
  },
  {
    name = "riseNum",
    type = "Int",
    des = "抬价次数",
    arg0 = "2"
  },
  {
    name = "bargainSuccessRate",
    type = "Double",
    des = "增加议价成功率",
    arg0 = "0"
  },
  {
    name = "wareNum",
    type = "Int",
    des = "仓库容量",
    arg0 = "100"
  },
  {
    name = "cocAutoRefreshNum",
    type = "Int",
    des = "订单每天刷新数量",
    arg0 = "3"
  },
  {
    name = "cocQuestList",
    type = "Factory",
    des = "商会任务列表",
    arg0 = "ListFactory",
    arg1 = "商会任务"
  },
  {
    name = "offerAutoRefreshNum",
    type = "Int",
    des = "悬赏每天刷新数量",
    arg0 = "1"
  },
  {
    name = "honorPng",
    type = "Png",
    des = "荣誉勋章",
    arg0 = ""
  },
  {
    name = "flagPng",
    type = "Png",
    des = "旗子",
    arg0 = ""
  },
  {
    name = "peopleName",
    type = "String",
    des = "市民名称",
    arg0 = ""
  },
  {
    name = "desc",
    type = "TextT",
    des = "特权描述",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "垃圾站",
    name = "",
    type = "SysLine",
    des = "垃圾站不配下面的",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "市政厅",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "cityHallName",
    type = "String",
    des = "市政厅名字",
    arg0 = "市政厅",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "cityPrestige",
    type = "Int",
    des = "解锁声望等级",
    arg0 = "2"
  },
  {
    mod = "基础车站",
    name = "investList",
    type = "Array",
    des = "投资列表",
    detail = "name#id#developNum#limitNum#repGrade"
  },
  {
    name = "name",
    type = "String",
    des = "投资名称",
    arg0 = ""
  },
  {
    name = "id",
    type = "Factory",
    des = "投资花费及奖励",
    arg0 = "ListFactory"
  },
  {
    name = "developNum",
    type = "Int",
    des = "增加发展度",
    arg0 = "1"
  },
  {
    name = "limitNum",
    type = "Int",
    des = "投资限制次数",
    arg0 = "1"
  },
  {
    name = "repGrade",
    type = "Int",
    des = "声望等级要求",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "基础车站",
    name = "defaultDevelop",
    type = "Int",
    des = "初始发展度",
    arg0 = "5000"
  },
  {
    mod = "基础车站",
    name = "addDevelop",
    type = "Int",
    des = "每日增加发展度",
    arg0 = "50"
  },
  {
    mod = "基础车站",
    name = "developUpperLimit",
    type = "Int",
    des = "发展度上限",
    arg0 = "50"
  },
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "交易所",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "tradeRankList",
    type = "Array",
    des = "交易所排行榜",
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
    name = "sellList",
    type = "Array",
    des = "出售货物列表",
    detail = "id"
  },
  {
    mod = "基础车站",
    name = "id",
    type = "Factory",
    des = "货物行情",
    arg0 = "HomeGoodsQuotationFactory",
    arg1 = "货物"
  },
  {name = "end"},
  {
    name = "acquisitionList",
    type = "Array",
    des = "收购货物列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "货物行情",
    arg0 = "HomeGoodsQuotationFactory",
    arg1 = "货物"
  },
  {name = "end"},
  {
    mod = "基础车站",
    name = "bargainSpinePath",
    type = "String",
    des = "议价Spine",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "actionM",
    type = "String",
    des = "砍价动画-男",
    arg0 = "nan2_1",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "actionW",
    type = "String",
    des = "砍价动画-女",
    arg0 = "nv1_1",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "action2M",
    type = "String",
    des = "同盟徽章动画-男",
    arg0 = "nan2_2",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "action2W",
    type = "String",
    des = "同盟徽章动画-女",
    arg0 = "nv1_2",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "交易所仓库",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "isWarehouse",
    type = "Bool",
    des = "是否有仓库",
    arg0 = "False"
  },
  {
    mod = "基础车站",
    name = "warehousePrestige",
    type = "Int",
    des = "仓库开启声望等级",
    arg0 = "1"
  },
  {
    mod = "基础车站",
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
    mod = "基础车站",
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
    name = "",
    type = "SysLine",
    des = "商会",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "isCOC",
    type = "Bool",
    des = "拥有商会",
    arg0 = "False"
  },
  {
    name = "initCOCQuestList",
    type = "Array",
    des = "初始商会任务列表",
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
    mod = "基础车站",
    name = "cocStoreList",
    type = "Array",
    des = "商会开启商店",
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
    mod = "基础车站",
    name = "cocExchangeBuildId",
    type = "Factory",
    des = "商会开启兑换站",
    arg0 = "BuildingFactory"
  },
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "酒吧",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "limitNum",
    type = "Int",
    des = "限喝次数",
    arg0 = "3"
  },
  {
    mod = "基础车站",
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
    mod = "基础车站",
    name = "recoverItem",
    type = "Factory",
    des = "恢复次数道具",
    arg0 = "ItemFactory#SourceMaterialFactory#FridgeItemFactory"
  },
  {
    mod = "基础车站",
    name = "barStoreList",
    type = "Array",
    des = "开启商店",
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
    mod = "基础车站",
    name = "drinkVideo",
    type = "String",
    des = "喝酒播放视频",
    arg0 = ""
  },
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "铁安局作战中心",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "isHomeBattleCentre",
    type = "Bool",
    des = "是否有作战中心",
    arg0 = "False"
  },
  {
    mod = "基础车站",
    name = "openPageList",
    type = "Array",
    des = "功能开启列表",
    detail = "icon#name#showUI#isTalk#isStore",
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
    mod = "基础车站",
    name = "buildingIconPath",
    type = "Png",
    des = "建筑图标",
    arg0 = "",
    arg1 = "160|160"
  },
  {
    mod = "基础车站",
    name = "battleLevelName",
    type = "String",
    des = "作战名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "battleIconPath",
    type = "Png",
    des = "战斗计划图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "battleLevelList",
    type = "Array",
    des = "作战中心关卡列表",
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
    mod = "基础车站",
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
    mod = "基础车站",
    name = "refreshTime",
    type = "Int",
    des = "订单刷新时间",
    arg0 = "300"
  },
  {
    name = "constructIconPath",
    type = "Png",
    des = "建设图标",
    arg0 = "",
    arg1 = "84|84",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "isPark",
    type = "Bool",
    des = "是否有游乐场",
    arg0 = "False"
  },
  {
    mod = "基础车站",
    name = "parkTicket",
    type = "Int",
    des = "基础票价",
    arg0 = "0"
  },
  {
    mod = "基础车站",
    name = "parkTicketMax",
    type = "Int",
    des = "投资票价上限",
    arg0 = "0"
  },
  {
    mod = "基础车站",
    name = "divide",
    type = "Double",
    des = "基础分成",
    arg0 = "0"
  },
  {
    mod = "基础车站",
    name = "maxDivide",
    type = "Double",
    des = "分成总额",
    arg0 = "0"
  },
  {
    mod = "基础车站",
    name = "added",
    type = "Int",
    des = "基础额外收入",
    arg0 = "0"
  },
  {
    mod = "基础车站",
    name = "travelDay",
    type = "Int",
    des = "基础游玩天数|天",
    arg0 = "0"
  },
  {
    mod = "基础车站",
    name = "tax",
    type = "Double",
    des = "基础税率",
    arg0 = "0"
  },
  {
    mod = "基础车站",
    name = "investTime",
    type = "Double",
    des = "基础投资次数",
    arg0 = "0"
  },
  {
    mod = "基础车站",
    name = "constructStageList",
    type = "Array",
    des = "建设阶段列表",
    detail = "name#nameEN#nameBtn#constructNum#id#state#desc#stagePng#png"
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
    name = "nameBtn",
    type = "String",
    des = "阶段名称(按钮)",
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
    name = "stagePng",
    type = "Png",
    des = "阶段图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "png",
    type = "Png",
    des = "阶段背景",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "basisNum",
    type = "Int",
    des = "基础经营值",
    arg0 = "0"
  },
  {
    name = "overNum",
    type = "Int",
    des = "超额经营值",
    arg0 = "0"
  },
  {
    name = "upperNum",
    type = "Int",
    des = "上限经营值",
    arg0 = "0"
  },
  {
    name = "pond",
    type = "Factory",
    des = "投资池子",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "基础车站",
    name = "exchangeName",
    type = "String",
    des = "兑换名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "基础车站",
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
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "兑换素材部分",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "exchangeIconPath",
    type = "Png",
    des = "兑换图标",
    arg0 = "",
    arg1 = "160|160",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "exchangePagePath",
    type = "Png",
    des = "兑换页面背景",
    arg0 = "",
    arg1 = "160|160",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "exchangeBottomPath",
    type = "Png",
    des = "兑换底",
    arg0 = "",
    arg1 = "160|160",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "exchangeAffirmPath",
    type = "Png",
    des = "兑换确认按钮",
    arg0 = "",
    arg1 = "160|160",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "exchangeCompletePath",
    type = "Png",
    des = "兑换完成按钮",
    arg0 = "",
    arg1 = "160|160",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "saleName",
    type = "String",
    des = "出售名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "materialRecycleList",
    type = "Array",
    des = "出售列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "出售物品",
    arg0 = "SourceMaterialFactory"
  },
  {name = "end"},
  {
    mod = "基础车站",
    name = "correspondingConstruction",
    type = "Factory",
    des = "对应建设度",
    arg0 = "ItemFactory"
  },
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "出售素材部分",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "saleBottomPath",
    type = "Png",
    des = "出售底",
    arg0 = "",
    arg1 = "160|160",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "saleHighPricePath",
    type = "Png",
    des = "高价回收底",
    arg0 = "",
    arg1 = "160|160",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "花鸟市场",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "petStoreList",
    type = "Array",
    des = "花鸟市场开启商店",
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
    mod = "基础车站",
    name = "petRecycleStoreList",
    type = "Array",
    des = "花鸟市场回收商店",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "开启回收商店",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "Keep炸鸡店",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "keepSingleMealList",
    type = "Array",
    des = "炸鸡店单人餐菜单",
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
    mod = "基础车站",
    name = "keepTeamMealList",
    type = "Array",
    des = "炸鸡店团队餐菜单",
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
    mod = "基础车站",
    name = "inviteTimes",
    type = "Int",
    des = "请客邀请次数",
    arg0 = "1"
  },
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "传单揽客地点",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "isLeaflet",
    type = "Bool",
    des = "是否可发传单",
    arg0 = "False"
  },
  {
    mod = "基础车站",
    name = "leafletUnlock",
    type = "Int",
    des = "城市声望解锁|声望等级",
    arg0 = "0"
  },
  {
    mod = "基础车站",
    name = "leafletMap",
    type = "String",
    des = "车站背景图",
    arg0 = ""
  },
  {
    mod = "基础车站",
    name = "order",
    type = "Int",
    des = "排序|从0开始",
    arg0 = "0"
  },
  {
    mod = "基础车站",
    name = "cityLeafletLest",
    type = "Array",
    des = "传单派发地点列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "传单派发地点列表",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "广告揽客",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "isAd",
    type = "Bool",
    des = "是否可发广告",
    arg0 = "False"
  },
  {
    mod = "基础车站",
    name = "adUnlock",
    type = "Int",
    des = "城市声望解锁|声望等级",
    arg0 = "0"
  },
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "展示列车相关",
    pyIgnore = true
  },
  {
    mod = "基础车站",
    name = "trainList",
    type = "Array",
    des = "定制展示列车",
    detail = "type#trainId"
  },
  {
    name = "type",
    type = "Int",
    des = "列车出发位置类型",
    arg0 = "0"
  },
  {
    name = "trainId",
    type = "Factory",
    des = "列车外观",
    arg0 = "ListFactory"
  },
  {
    name = "trainDistance",
    type = "Double",
    des = "触发点位置",
    arg0 = "0"
  },
  {
    name = "posStart",
    type = "Double",
    des = "出生位置",
    arg0 = "0"
  },
  {
    name = "endType",
    type = "Int",
    des = "终点类型",
    arg0 = "0"
  },
  {
    name = "speedMin",
    type = "Int",
    des = "列车最小速度",
    arg0 = "0"
  },
  {
    name = "speedMax",
    type = "Int",
    des = "列车最大速度",
    arg0 = "0"
  },
  {
    name = "speedAdd",
    type = "Int",
    des = "列车启动加速度",
    arg0 = "1"
  },
  {
    name = "speedDec",
    type = "Int",
    des = "列车停车减速度",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "挂机（废弃）",
    pyIgnore = true
  },
  {
    name = "recommendNum",
    type = "Int",
    des = "推荐武装度",
    arg0 = "1"
  },
  {
    name = "kmCostList",
    type = "Array",
    des = "公里花费",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品ID",
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
    name = "onhookCoefficient",
    type = "Double",
    des = "挂机系数",
    arg0 = "1"
  },
  {
    mod = "基础车站",
    name = "",
    type = "SysLine",
    des = "拖车演绎",
    pyIgnore = true
  },
  {
    name = "trainHelpChat",
    type = "Factory",
    des = "拖车段落",
    arg0 = "ParagraphFactory"
  }
})
