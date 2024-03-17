RegProperty("HomeLineFactory", {
  {
    name = "forceNeedleList",
    type = "Array",
    des = "线路插针事件",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "插针距离配置",
    arg0 = "AFKEventFactory",
    arg1 = "distance"
  },
  {name = "end"},
  {
    name = "lineQuestList",
    type = "Array",
    des = "可解锁隐藏任务"
  },
  {
    name = "id",
    type = "Factory",
    des = "隐藏任务",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    name = "station01",
    type = "Factory",
    des = "车站1",
    arg0 = "HomeStationFactory"
  },
  {
    name = "station02",
    type = "Factory",
    des = "车站2",
    arg0 = "HomeStationFactory"
  },
  {
    name = "distance",
    type = "Double",
    des = "距离",
    arg0 = "10"
  },
  {
    name = "sceneGroup",
    type = "Factory",
    des = "场景组",
    arg0 = "HomeTrainSceneGroupFactory",
    pyIgnore = true
  },
  {
    name = "bgmId",
    type = "Factory",
    des = "线路BGM",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "bgmId2",
    type = "Factory",
    des = "反向线路BGM",
    arg0 = "SoundFactory",
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
    des = "线路关卡事件部分"
  },
  {
    name = "lineLevelList",
    type = "Array",
    des = "线路关卡事件",
    detail = "distance#id#weight"
  },
  {
    name = "distance",
    type = "Int",
    des = "距离",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "对应驱逐列表",
    arg0 = "ListFactory",
    arg1 = "治安关卡"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "triggerNumMin",
    type = "Int",
    des = "最小事件数量",
    arg0 = "0"
  },
  {
    name = "triggerNumMax",
    type = "Int",
    des = "最大事件数量",
    arg0 = "0"
  },
  {
    name = "lineBgList",
    type = "Array",
    des = "线路关卡地图列表",
    detail = "distance0#distance1#LineBgid",
    pyIgnore = true
  },
  {
    name = "distance0",
    type = "Int",
    des = "距离起点",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "LineBgid",
    type = "Factory",
    des = "对应战斗场景",
    arg0 = "BackgroundFactory",
    arg1 = "3D场景",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    name = "LineEnemyLv",
    type = "Int",
    des = "线路怪物等级",
    arg0 = "1"
  },
  {
    name = "LineEnemyLvRan",
    type = "Int",
    des = "怪物等级随机数",
    arg0 = "0"
  },
  {
    name = "LineEnemyRn",
    type = "Int",
    des = "线路怪物共振",
    arg0 = "0"
  },
  {
    name = "LineWeatherRate",
    type = "SafeNumber",
    des = "线路天气几率",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "LineWeatherList",
    type = "Array",
    des = "线路天气列表",
    detail = "LineWTid",
    pyIgnore = true
  },
  {
    name = "LineWTid",
    type = "Factory",
    des = "天气id",
    arg0 = "WeatherFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    name = "eventHpRatio",
    type = "Double",
    des = "拦路血量系数",
    arg0 = "1"
  },
  {
    name = "",
    type = "SysLine",
    des = "污染关卡事件部分"
  },
  {
    name = "enemyLevelMin",
    type = "Int",
    des = "关卡敌人最低等级",
    arg0 = "1"
  },
  {
    name = "",
    type = "SysLine",
    des = "线路宝箱"
  },
  {
    name = "boxMin",
    type = "Int",
    des = "最小宝箱数量",
    arg0 = "0"
  },
  {
    name = "boxMax",
    type = "Int",
    des = "最大宝箱数量",
    arg0 = "0"
  },
  {
    name = "boxPolluteNum",
    type = "Double",
    des = "污染影响数量",
    arg0 = "0.5"
  },
  {
    mod = "",
    name = "boxList",
    type = "Array",
    des = "宝箱列表",
    detail = "distance#id#weight"
  },
  {
    name = "distance",
    type = "Int",
    des = "距离",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "宝箱事件ID",
    arg0 = "AFKEventFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "0"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "地区提示"
  },
  {
    mod = "",
    name = "AreaTipList",
    type = "Array",
    des = "地区列表",
    detail = "disMin#id"
  },
  {
    name = "disMin",
    type = "Int",
    des = "触发最小距离",
    arg0 = "0"
  },
  {
    name = "disMax",
    type = "Int",
    des = "触发最大距离",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "文本ID",
    arg0 = "TextFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "景点剧情"
  },
  {
    mod = "",
    name = "AttractionList",
    type = "Array",
    des = "景点列表",
    detail = "disMin#id"
  },
  {
    name = "disMin",
    type = "Int",
    des = "触发最小距离",
    arg0 = "0"
  },
  {
    name = "disMax",
    type = "Int",
    des = "触发最大距离",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "剧情列表ID",
    arg0 = "ParagraphFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "大世界污染"
  },
  {
    mod = "",
    name = "areaList",
    type = "Array",
    des = "所属区域列表",
    detail = "areaId"
  },
  {
    name = "disMin",
    type = "Double",
    des = "事件最小距离",
    arg0 = "1000"
  },
  {
    name = "disMax",
    type = "Double",
    des = "事件最大距离",
    arg0 = "2000"
  },
  {
    name = "disInterval",
    type = "Double",
    des = "事件最小间隔",
    arg0 = "300"
  },
  {
    name = "areaId",
    type = "Factory",
    des = "所属区域",
    arg0 = "AreaFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "所属城市"
  },
  {
    mod = "",
    name = "cityList",
    type = "Array",
    des = "所属城市列表",
    detail = "cityId#buildingId"
  },
  {
    name = "cityId",
    type = "Factory",
    des = "所属城市",
    arg0 = "HomeStationFactory"
  },
  {
    name = "buildingId",
    type = "Factory",
    des = "所属建筑",
    arg0 = "BuildingFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "小地图"
  },
  {
    name = "wayPointList",
    type = "Array",
    des = "路点（1到2）",
    detail = "x#y",
    pyIgnore = true
  },
  {
    name = "x",
    type = "Double",
    des = "x坐标",
    arg0 = "0"
  },
  {
    name = "y",
    type = "Double",
    des = "y坐标",
    arg0 = "0"
  },
  {name = "end"}
})
