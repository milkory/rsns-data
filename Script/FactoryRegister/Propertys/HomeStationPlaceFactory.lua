RegProperty("HomeStationPlaceFactory", {
  {
    name = "npcList",
    type = "Array",
    des = "NPC列表",
    detail = "id#npcX#npcZ#tree"
  },
  {
    name = "id",
    type = "Factory",
    des = "NPC角色",
    arg0 = "HomeCharacterFactory",
    pyIgnore = true
  },
  {
    name = "npcX",
    type = "Double",
    des = "初始位置X",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "npcZ",
    type = "Double",
    des = "初始位置Z",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "tree",
    type = "String",
    des = "行为树",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "isRandom",
    type = "Bool",
    des = "位置随机",
    arg0 = "True"
  },
  {name = "end"},
  {
    name = "resId",
    type = "Factory",
    des = "对应车厢",
    arg0 = "HomeCoachFactory"
  },
  {
    name = "serverId",
    type = "Factory",
    des = "服务员角色",
    arg0 = "HomeCharacterFactory",
    pyIgnore = true
  },
  {
    name = "bgm",
    type = "Factory",
    des = "背景音乐",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "npcRefreshList",
    type = "Array",
    des = "NPC刷新列表",
    detail = "id#npcX#npcZ#tree"
  },
  {
    name = "id",
    type = "Factory",
    des = "NPC角色",
    arg0 = "HomeCharacterFactory",
    pyIgnore = true
  },
  {
    name = "npcX",
    type = "Double",
    des = "初始位置X",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "npcZ",
    type = "Double",
    des = "初始位置Z",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "tree",
    type = "String",
    des = "行为树",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "isRandom",
    type = "Bool",
    des = "位置随机",
    arg0 = "True"
  },
  {name = "end"},
  {
    name = "entranceList",
    type = "Array",
    des = "店面入口位置列表",
    detail = "entranceX#entranceY"
  },
  {
    name = "entranceX",
    type = "Double",
    des = "X位置",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "entranceY",
    type = "Double",
    des = "Y位置",
    arg0 = "0",
    pyIgnore = true
  },
  {name = "end"},
  {
    name = "exitList",
    type = "Array",
    des = "店面出口位置列表",
    detail = "exitX#exitY"
  },
  {
    name = "exitX",
    type = "Double",
    des = "X位置",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "exitY",
    type = "Double",
    des = "Y位置",
    arg0 = "0",
    pyIgnore = true
  },
  {name = "end"},
  {
    name = "eventList",
    type = "Array",
    des = "NPC事件列表",
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
    name = "homeQId",
    type = "Factory",
    des = "Q版角色ID",
    arg0 = "HomeCharacterFactory",
    pyIgnore = true
  },
  {
    name = "qXPos",
    type = "Int",
    des = "小人X坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "qYPos",
    type = "Int",
    des = "小人Y坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "bubbleString",
    type = "String",
    des = "气泡路径",
    arg0 = "",
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
    des = "摄像机位置",
    pyIgnore = true
  },
  {
    name = "cameraLeft",
    type = "Double",
    des = "镜头锁定左",
    arg0 = ""
  },
  {
    name = "cameraRight",
    type = "Double",
    des = "镜头锁定右",
    arg0 = ""
  },
  {
    name = "animationCameraX",
    type = "Double",
    des = "演出镜头X",
    arg0 = ""
  },
  {
    name = "animationCameraY",
    type = "Double",
    des = "演出镜头Y",
    arg0 = ""
  },
  {
    name = "animationCameraZ",
    type = "Double",
    des = "演出镜头Z",
    arg0 = ""
  },
  {
    name = "animationCameraRot",
    type = "Double",
    des = "演出镜头倾角",
    arg0 = ""
  },
  {
    name = "animationFieldOfView",
    type = "Double",
    des = "演出镜头广角",
    arg0 = ""
  },
  {
    name = "",
    type = "SysLine",
    des = "演出动画",
    pyIgnore = true
  },
  {
    name = "animationPrefab",
    type = "String",
    des = "播放动画预制体路径",
    arg0 = ""
  },
  {
    name = "dressStoreList",
    type = "Array",
    des = "服装店列表",
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
    des = "菜单",
    pyIgnore = true
  },
  {
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
    name = "inviteTimes",
    type = "Int",
    des = "请客邀请次数",
    arg0 = "6"
  },
  {
    name = "titleBuffDesLCZ",
    type = "Factory",
    des = "列车长buff标题",
    arg0 = "TextFactory"
  },
  {
    name = "bgBuffDesLCZ",
    type = "Png",
    des = "列车长buff背景",
    arg0 = ""
  },
  {
    name = "decBuffDesLCZ",
    type = "Png",
    des = "列车长buff竖线装饰",
    arg0 = "100|100"
  },
  {
    name = "titleBuffDesMember",
    type = "Factory",
    des = "队员buff标题",
    arg0 = "TextFactory"
  },
  {
    name = "bgBuffDesMember",
    type = "Png",
    des = "队员buff背景",
    arg0 = ""
  },
  {
    name = "decBuffDesMember",
    type = "Png",
    des = "队员buff竖线装饰",
    arg0 = "100|100"
  },
  {
    name = "",
    type = "SysLine",
    des = "菜单UI布局",
    pyIgnore = true
  },
  {
    name = "bgTop",
    type = "Png",
    des = "上部背景横幅",
    arg0 = ""
  },
  {
    name = "nameSingle",
    type = "String",
    des = "页签单人餐名称",
    arg0 = ""
  },
  {
    name = "iconSingleOn",
    type = "Png",
    des = "页签单人餐图标开启状态",
    arg0 = "100|100"
  },
  {
    name = "iconSingleOff",
    type = "Png",
    des = "页签单人餐图标关闭状态",
    arg0 = "100|100"
  },
  {
    name = "nameTeam",
    type = "String",
    des = "页签团队餐名称",
    arg0 = ""
  },
  {
    name = "iconTeamOn",
    type = "Png",
    des = "页签团队餐图标开启状态",
    arg0 = "100|100"
  },
  {
    name = "iconTeamOff",
    type = "Png",
    des = "页签团队餐图标关闭状态",
    arg0 = "100|100"
  },
  {
    name = "bgRight",
    type = "Png",
    des = "右边背景",
    arg0 = ""
  },
  {
    name = "picRightTip",
    type = "Png",
    des = "右边未选中提示图",
    arg0 = ""
  },
  {
    name = "textRightTip",
    type = "Factory",
    des = "右边未选中文字",
    arg0 = "TextFactory"
  },
  {
    name = "listPrefab",
    type = "String",
    des = "菜单面板预制件",
    arg0 = ""
  },
  {
    name = "",
    type = "SysLine",
    des = "结算UI布局",
    pyIgnore = true
  },
  {
    name = "bgSettlement",
    type = "Png",
    des = "结算背景",
    arg0 = ""
  },
  {
    name = "iconSettlement",
    type = "Png",
    des = "结算图标",
    arg0 = ""
  },
  {
    name = "textTitle",
    type = "Factory",
    des = "结算标题",
    arg0 = "TextFactory"
  },
  {
    name = "textSettlement",
    type = "Factory",
    des = "右边未选中文字",
    arg0 = "TextFactory"
  },
  {
    name = "animeName",
    type = "String",
    des = "动画名称",
    arg0 = ""
  },
  {
    name = "animeEndName",
    type = "String",
    des = "收尾动画名称",
    arg0 = ""
  },
  {
    name = "isPickFood",
    type = "Bool",
    des = "是否拿起食物",
    arg0 = "false"
  },
  {
    name = "bgPhoto",
    type = "Png",
    des = "拍照背景",
    arg0 = ""
  }
})
