RegProperty("QuestFactory", {
  {
    name = "name",
    type = "StringT",
    des = "任务名",
    arg0 = ""
  },
  {
    name = "story",
    type = "TextT",
    des = "描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "describe",
    type = "StringT",
    des = "任务目标",
    arg0 = ""
  },
  {
    mod = "基础任务,订单,活动任务",
    name = "isShowProgress",
    type = "Bool",
    des = "显示进度(主界面)",
    arg0 = "False",
    pyIgnore = true
  },
  {
    mod = "基础任务,订单,活动任务",
    name = "isShowUnlock",
    type = "Bool",
    des = "解锁时提示",
    arg0 = "False",
    pyIgnore = true
  },
  {
    mod = "基础任务,订单,活动任务",
    name = "isShowAchieveProgress",
    type = "Bool",
    des = "显示完成进度",
    arg0 = "False",
    pyIgnore = true
  },
  {
    name = "questType",
    type = "Enum",
    des = "任务类型||Main:主线任务,Side:支线任务,Daily:日常任务,Weekly:周常任务,Home:商会任务,Achieve:成就,Order:交货任务,Monthly:月任务,Activity:活动任务,ActivityAchieve:活动成就",
    arg0 = "Main#Side#Daily#Weekly#Home#Achieve#Order#Monthly#Activity#ActivityAchieve",
    arg1 = "Main"
  },
  {
    name = "sort",
    type = "Int",
    des = "排序权重",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "isSwitchUI",
    type = "Bool",
    des = "是否需要跳转",
    arg0 = "True",
    pyIgnore = true
  },
  {
    name = "switchUI",
    type = "String",
    des = "跳转至",
    arg0 = "UI/",
    pyIgnore = true
  },
  {
    mod = "活动任务",
    name = "",
    type = "SysLine",
    des = "前置条件"
  },
  {
    mod = "活动任务",
    name = "preQuestId",
    type = "Factory",
    des = "前置任务",
    arg0 = "QuestFactory"
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "完成条件（只配限制条件即可）"
  },
  {
    name = "conditionList",
    type = "Array",
    des = "条件列表",
    detail = "key#val"
  },
  {
    name = "key",
    type = "Enum",
    des = "条件|任务完成条件，可以组合使用|levelId:完成指定关卡,levelType:完成指定类型关卡0主线6治安,dialog:剧情对话,levelGrade:关卡达到指定评分,cityId:进入指定车站或限定任务车站,gacha:抽卡,safeSideLevelList:指定治安池中支线关卡,roleGrade:角色等级,buyItem:商店购买指定道具,trainLength:列车节数,coachType:车厢类型,questId:任务ID,sellItem:出售道具,allServer:全服数据,sellItemAddProfit:出售道具累计利润,sellItemOnceProfit:出售道具单笔利润,shopId:指定商店",
    arg0 = "levelId#chapterId#levelType#levelGrade#upOperation#itemCost#dayLog#energyCost#skillUp#useCharacterComplete#useCharacterHurt#useShield#dizziness#cure#cardColor#XuanShang#ZhiAn#beatAnyEnemy#beatBoss#discard#characterNum#camp#getEnergy#dialog#onceProfit#addProfit#addWeight#addPeople#addDrinkNum#cityId#invest#travel#finishOrder#solicitCustomer#priceDownWin#priceUpWin#gainFans#trade#gacha#anyStore#safeSideLevelList#roleGrade#buyItem#trainLength#coachType#questId#sellItem#allServer#sellItemAddProfit#sellItemOnceProfit#shopId",
    arg1 = "levelId"
  },
  {
    name = "val",
    type = "String",
    des = "参数",
    arg0 = "0"
  },
  {name = "end"},
  {
    name = "num",
    type = "Long",
    des = "数量/次数",
    arg0 = "1"
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    name = "islockAddProgress",
    type = "Bool",
    des = "未解锁也增加进度",
    arg0 = "False"
  },
  {
    mod = "基础任务,订单,车站月任务,活动任务",
    name = "isAutoComplete",
    type = "Bool",
    des = "自动完成",
    arg0 = "True"
  },
  {
    mod = "基础任务,活动任务",
    name = "checkComplete",
    type = "Bool",
    des = "解锁时检测能否完成",
    arg0 = "False"
  },
  {
    mod = "订单",
    name = "giveUp",
    type = "Bool",
    des = "可以放弃",
    arg0 = "True"
  },
  {
    mod = "基础任务,活动任务",
    name = "",
    type = "SysLine",
    des = "子任务"
  },
  {
    mod = "基础任务,交货订单,活动任务",
    name = "parentQuest",
    type = "Factory",
    des = "父任务|任务完成后增加父任务进度",
    arg0 = "QuestFactory"
  },
  {
    mod = "基础任务,交货订单,活动任务",
    name = "childQuestList",
    type = "Array",
    des = "子任务列表|客户端用",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "子任务",
    arg0 = "QuestFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "任务奖励"
  },
  {
    name = "rewardsList",
    type = "Array",
    des = "奖励列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#HomeGoodsFactory#HomeFurnitureFactory#FridgeItemFactory#HomeCharacterSkinFactory#HomeWeaponFactory#CollectionCardPackFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "成就",
    name = "achievePoint",
    type = "Int",
    des = "成就点数",
    arg0 = "10"
  },
  {
    mod = "成就",
    name = "achieveList",
    type = "Int",
    des = "对应成就列表",
    arg0 = "1"
  },
  {
    mod = "成就",
    name = "achievePng",
    type = "Png",
    des = "成就图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "订单",
    name = "reputationList",
    type = "Array",
    des = "声望列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "声望",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "交货订单",
    name = "",
    type = "SysLine",
    des = "交货订单"
  },
  {
    mod = "交货订单",
    name = "requireItemList",
    type = "Array",
    des = "需求物品列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "需求物品",
    arg0 = "ItemFactory#EquipmentFactory#HomeGoodsFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "交货订单",
    name = "",
    type = "SysLine",
    des = "刷新条件"
  },
  {
    mod = "交货订单",
    name = "constructLimit",
    type = "Int",
    des = "建设进度条件",
    arg0 = "0"
  },
  {
    mod = "交货订单",
    name = "unlockCity",
    type = "Factory",
    des = "解锁城市",
    arg0 = "HomeStationFactory"
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    name = "startStation",
    type = "Factory",
    des = "接取地点",
    arg0 = "HomeStationFactory"
  },
  {
    name = "endStationList",
    type = "Array",
    des = "完成地点列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "完成地点",
    arg0 = "HomeStationFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {name = "end"},
  {
    mod = "基础任务,订单,活动任务",
    name = "client",
    type = "Factory",
    des = "委托人",
    arg0 = "ProfilePhotoFactory",
    pyIgnore = true
  },
  {
    mod = "基础任务,活动任务",
    name = "",
    type = "SysLine",
    des = "解锁条件"
  },
  {
    mod = "基础任务,活动任务",
    name = "chapterId",
    type = "Factory",
    des = "主线关卡id",
    arg0 = "LevelFactory"
  },
  {
    mod = "基础任务,活动任务",
    name = "playerLevel",
    type = "Int",
    des = "玩家等级",
    arg0 = "1"
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "完成后解锁"
  },
  {
    name = "nextQuest",
    type = "Array",
    des = "下一个任务",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "基础任务"
  },
  {name = "end"},
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "完成后变更城市状态"
  },
  {
    name = "changeCityStateList",
    type = "Array",
    des = "变更城市状态",
    detail = "id#state"
  },
  {
    name = "id",
    type = "Factory",
    des = "城市",
    arg0 = "HomeStationFactory"
  },
  {
    name = "state",
    type = "Int",
    des = "状态ID",
    arg0 = "0"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "完成后发送邮件"
  },
  {
    name = "mailList",
    type = "Array",
    des = "邮件列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "邮件",
    arg0 = "MailFactory"
  },
  {name = "end"},
  {
    mod = "订单",
    name = "",
    type = "SysLine",
    des = "商会任务"
  },
  {
    mod = "订单",
    name = "isInitQuest",
    type = "Bool",
    des = "初始任务",
    arg0 = "False"
  },
  {
    mod = "订单",
    name = "",
    type = "SysLine",
    des = "解锁条件，都满足且完成地点解锁"
  },
  {
    mod = "订单",
    name = "questId",
    type = "Factory",
    des = "解锁任务",
    arg0 = "QuestFactory"
  },
  {
    mod = "订单,交货订单",
    name = "development",
    type = "Int",
    des = "发展度",
    arg0 = "0"
  },
  {
    mod = "订单,交货订单",
    name = "investment",
    type = "Int",
    des = "投资",
    arg0 = "0"
  },
  {
    mod = "订单",
    name = "trainLevel",
    type = "Int",
    des = "列车等级",
    arg0 = "0"
  },
  {
    mod = "基础任务,订单,活动任务",
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    mod = "订单",
    name = "cocQuestType",
    type = "Enum",
    des = "商会任务类型",
    arg0 = "Send#Buy#Passenger",
    arg1 = "Send"
  },
  {
    mod = "订单",
    name = "goodsList",
    type = "Array",
    des = "货物列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "货物",
    arg0 = "HomeGoodsFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "订单",
    name = "",
    type = "SysLine",
    des = "客运任务"
  },
  {
    mod = "订单",
    name = "cityList",
    type = "Array",
    des = "途经城市列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "城市",
    arg0 = "HomeStationFactory"
  },
  {name = "end"},
  {
    mod = "订单",
    name = "passengerList",
    type = "Array",
    des = "乘客列表",
    detail = "id#num#tag"
  },
  {
    name = "id",
    type = "Factory",
    des = "乘客",
    arg0 = "PassageFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {
    name = "tag",
    type = "Factory",
    des = "标签",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "订单",
    name = "",
    type = "SysLine",
    des = "采购任务才可配置为限时任务"
  },
  {
    mod = "订单",
    name = "timeLimit",
    type = "Double",
    des = "完成限时(小时)",
    arg0 = "-1"
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "触发铁路事件"
  },
  {
    name = "isEvent",
    type = "Bool",
    des = "是否触发铁路事件",
    arg0 = "False"
  },
  {
    name = "isOverwriteEvent",
    type = "Bool",
    des = "是否覆盖原有事件",
    arg0 = "False"
  },
  {
    mod = "",
    name = "eventList",
    type = "Array",
    des = "线路事件列表",
    detail = "idStation#idLine#idList"
  },
  {
    name = "idLine",
    type = "Factory",
    des = "线路ID",
    arg0 = "HomeLineFactory"
  },
  {
    name = "idList",
    type = "Factory",
    des = "事件列表ID",
    arg0 = "ListFactory",
    arg1 = "铁路事件"
  },
  {name = "end"},
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "特定大世界环境"
  },
  {
    mod = "",
    name = "environmentList",
    type = "Array",
    des = "特定环境列表",
    detail = "idMsg#idLine"
  },
  {
    name = "idLine",
    type = "Factory",
    des = "线路ID",
    arg0 = "HomeLineFactory"
  },
  {
    name = "idMsg",
    type = "Factory",
    des = "环境ID",
    arg0 = "TrainRoadMsgFactory"
  },
  {name = "end"},
  {
    mod = "基础任务,订单,交货订单,活动任务",
    name = "",
    type = "SysLine",
    des = "任务追踪"
  },
  {
    mod = "基础任务,订单,交货订单,活动任务",
    name = "traceList",
    type = "Array",
    des = "任务追踪列表",
    detail = "uiPath#traceId#btnListId#apiListId",
    pyIgnore = true
  },
  {
    name = "uiPath",
    type = "String",
    des = "UI路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "traceId",
    type = "Factory",
    des = "追踪配置",
    arg0 = "ListFactory",
    arg1 = "任务追踪",
    pyIgnore = true
  },
  {
    name = "btnListId",
    type = "Factory",
    des = "按钮列表",
    arg0 = "ListFactory",
    arg1 = "按钮列表",
    pyIgnore = true
  },
  {
    name = "apiListId",
    type = "Factory",
    des = "协议列表",
    arg0 = "ListFactory",
    arg1 = "协议列表",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "车站月任务",
    name = "",
    type = "SysLine",
    des = "车站月任务"
  },
  {
    mod = "车站月任务",
    name = "station",
    type = "Factory",
    des = "归属车站",
    arg0 = "HomeStationFactory"
  },
  {
    mod = "活动任务,基础任务",
    name = "",
    type = "SysLine",
    des = "限时部分"
  },
  {
    mod = "活动任务,基础任务",
    name = "isTime",
    type = "Bool",
    des = "是否限时",
    arg0 = "False"
  },
  {
    mod = "活动任务",
    name = "activityId",
    type = "Factory",
    des = "读取活动时间|活动ID",
    arg0 = "ActivityFactory"
  },
  {
    mod = "活动任务,基础任务",
    name = "startTime",
    type = "String",
    des = "开始时间|与活动时间互斥",
    arg0 = ""
  },
  {
    mod = "活动任务,基础任务",
    name = "endTime",
    type = "String",
    des = "结束时间|与活动时间互斥",
    arg0 = ""
  },
  {
    mod = "活动任务",
    name = "",
    type = "SysLine",
    des = "成就解锁条件"
  },
  {
    mod = "活动任务",
    name = "preQuest",
    type = "Array",
    des = "前置任务",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务id",
    arg0 = "QuestFactory",
    arg1 = "基础任务"
  },
  {name = "end"},
  {
    mod = "活动任务",
    name = "preLevel",
    type = "Array",
    des = "前置关卡",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "关卡id",
    arg0 = "LevelFactory",
    arg1 = "基础关卡"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "对应活动"
  },
  {
    name = "correspondActivity",
    type = "Factory",
    des = "对应活动",
    arg0 = "ActivityFactory"
  },
  {
    mod = "活动任务",
    name = "",
    type = "SysLine",
    des = "激活Buff"
  },
  {
    mod = "活动任务",
    name = "buffActivate",
    type = "Factory",
    des = "激活Buff",
    arg0 = "HomeBuffFactory"
  }
})
