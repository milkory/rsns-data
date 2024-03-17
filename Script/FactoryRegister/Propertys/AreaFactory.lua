RegProperty("AreaFactory", {
  {
    name = "name",
    type = "StringT",
    des = "区域名称",
    arg0 = ""
  },
  {
    mod = "路线区域",
    name = "LineList",
    type = "Array",
    des = "包含路线",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "线路id",
    arg0 = "HomeLineFactory"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "",
    type = "SysLine",
    des = "大世界污染"
  },
  {
    mod = "路线区域",
    name = "polluteList",
    type = "Array",
    des = "污染指数及概率",
    detail = "num#weight"
  },
  {
    mod = "路线区域",
    name = "num",
    type = "Int",
    des = "污染指数",
    arg0 = "1"
  },
  {
    mod = "路线区域",
    name = "weight",
    type = "Int",
    des = "该指数出现权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "polluteX",
    type = "Double",
    des = "污染地图坐标X|在地图界面上显示污染图标的x坐标",
    arg0 = "1",
    pyIgnore = true
  },
  {
    mod = "路线区域",
    name = "polluteY",
    type = "Double",
    des = "污染地图坐标Y|在地图界面上显示污染图标的y坐标",
    arg0 = "1",
    pyIgnore = true
  },
  {
    mod = "路线区域",
    name = "",
    type = "SysLine",
    des = "污染战斗相关"
  },
  {
    mod = "路线区域",
    name = "polluteBgList",
    type = "Array",
    des = "污染关卡地图列表",
    detail = "polluteBgId"
  },
  {
    name = "polluteBgId",
    type = "Factory",
    des = "场景id",
    arg0 = "BackgroundFactory"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "RnWtList",
    type = "Array",
    des = "污染共振天气列表",
    detail = "RnWtId"
  },
  {
    name = "RnWtId",
    type = "Factory",
    des = "天气id",
    arg0 = "WeatherFactory"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "polluteWeatherRate",
    type = "SafeNumber",
    des = "污染天气几率",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "polluteWtList",
    type = "Array",
    des = "污染天气列表",
    detail = "polluteWtId"
  },
  {
    name = "polluteWtId",
    type = "Factory",
    des = "天气id",
    arg0 = "WeatherFactory"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "polluteLvList",
    type = "Array",
    des = "污染敌人等级列表",
    detail = "polluteLvOffsetMax#polluteLvOffsetMin#polluteLvMin#buoyLvMin#polluteLvSN"
  },
  {
    name = "polluteLvOffsetMax",
    type = "Int",
    des = "等级调整上限",
    arg0 = "1"
  },
  {
    name = "polluteLvOffsetMin",
    type = "Int",
    des = "等级调整下限",
    arg0 = "0"
  },
  {
    name = "polluteLvMin",
    type = "Int",
    des = "最低敌人等级",
    arg0 = "1"
  },
  {
    name = "buoyLvMin",
    type = "Int",
    des = "浮标最低等级",
    arg0 = "1"
  },
  {
    name = "polluteLvSN",
    type = "Int",
    des = "等级系数",
    arg0 = "3"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "",
    type = "SysLine",
    des = "污染拦路事件"
  },
  {
    mod = "路线区域",
    name = "polluteLevelList",
    type = "Array",
    des = "污染拦路事件列表|每组数据对应每个污染指数",
    detail = "id#min#max"
  },
  {
    name = "id",
    type = "Factory",
    des = "关卡列表id",
    arg0 = "ListFactory"
  },
  {
    name = "min",
    type = "Int",
    des = "关卡最小数量",
    arg0 = "3"
  },
  {
    name = "max",
    type = "Int",
    des = "关卡最大数量",
    arg0 = "5"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "",
    type = "SysLine",
    des = "常驻点击事件"
  },
  {
    mod = "路线区域",
    name = "ClickLevelList",
    type = "Array",
    des = "常驻点击事件列表",
    detail = "id#countInit#countPollute"
  },
  {
    name = "id",
    type = "Factory",
    des = "事件列表id",
    arg0 = "ListFactory"
  },
  {
    mod = "路线区域",
    name = "countInit",
    type = "Int",
    des = "基础数量(a)",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "countPollute",
    type = "Int",
    des = "污染影响数量(b)",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "min",
    type = "Double",
    des = "基础浮动最小值",
    arg0 = "0.8"
  },
  {
    mod = "路线区域",
    name = "max",
    type = "Double",
    des = "基础浮动最大值",
    arg0 = "1.2"
  },
  {
    mod = "路线区域",
    name = "levelLvMax",
    type = "Int",
    des = "关卡等级上限",
    arg0 = "60"
  },
  {
    mod = "路线区域",
    name = "levelLvMin",
    type = "Int",
    des = "关卡等级下限",
    arg0 = "1"
  },
  {
    mod = "路线区域",
    name = "ratioInit",
    type = "Double",
    des = "基础概率",
    arg0 = "1"
  },
  {
    mod = "路线区域",
    name = "ratioPollute",
    type = "Double",
    des = "污染影响概率",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "",
    type = "SysLine",
    des = "污染点击事件"
  },
  {
    mod = "路线区域",
    name = "ClickEventPosList",
    type = "Array",
    des = "事件坐标的列表",
    detail = "pos_x#pos_y#pos_z"
  },
  {
    mod = "路线区域",
    name = "pos_x",
    type = "Double",
    des = "坐标X",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "pos_y",
    type = "Double",
    des = "坐标Y",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "pos_z",
    type = "Double",
    des = "坐标Z",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "icon_x",
    type = "Double",
    des = "UI坐标X",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "icon_y",
    type = "Double",
    des = "UI坐标Y",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "ClickEventList",
    type = "Array",
    des = "污染点击事件列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "事件列表id",
    arg0 = "ListFactory"
  },
  {
    mod = "路线区域",
    name = "min",
    type = "Int",
    des = "最小数量",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "max",
    type = "Int",
    des = "最大数量",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "minPolluteLimit",
    type = "Int",
    des = "最小污染限制",
    arg0 = "3"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "",
    type = "SysLine",
    des = "污染点击副本事件"
  },
  {
    mod = "路线区域",
    name = "ClickDungeonEventPosList",
    type = "Array",
    des = "事件坐标的列表",
    detail = "pos_x#pos_y#pos_z"
  },
  {
    mod = "路线区域",
    name = "pos_x",
    type = "Double",
    des = "坐标X",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "pos_y",
    type = "Double",
    des = "坐标Y",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "pos_z",
    type = "Double",
    des = "坐标Z",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "icon_x",
    type = "Double",
    des = "UI坐标X",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "icon_y",
    type = "Double",
    des = "UI坐标Y",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "ClickDungeonEventList",
    type = "Array",
    des = "点击副本事件列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "事件列表id",
    arg0 = "ListFactory"
  },
  {
    mod = "路线区域",
    name = "min",
    type = "Int",
    des = "最小数量",
    arg0 = "0"
  },
  {
    mod = "路线区域",
    name = "max",
    type = "Int",
    des = "最大数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "路线区域",
    name = "",
    type = "SysLine",
    des = "污染特效相关"
  },
  {
    name = "polluteWuqi",
    type = "String",
    des = "污染雾气父节点",
    arg0 = "MapEffect/Shuiqi"
  },
  {
    mod = "",
    name = "polluteWuqiList",
    type = "Array",
    des = "污染雾气节点",
    detail = "name"
  },
  {
    name = "name",
    type = "String",
    des = "节点名称",
    arg0 = ""
  },
  {
    name = "pos_x",
    type = "Double",
    des = "坐标X",
    arg0 = "0"
  },
  {
    name = "pos_y",
    type = "Double",
    des = "坐标Y",
    arg0 = "0"
  },
  {
    name = "pos_z",
    type = "Double",
    des = "坐标Z",
    arg0 = "0"
  },
  {
    name = "distance",
    type = "Double",
    des = "显示距离",
    arg0 = "6000"
  },
  {name = "end"},
  {
    name = "MapEffectRSS",
    type = "String",
    des = "污染特效父节点",
    arg0 = "MapEffect_RSS"
  },
  {
    mod = "",
    name = "MapEffectRSSList",
    type = "Array",
    des = "污染特效节点",
    detail = "name"
  },
  {
    name = "name",
    type = "String",
    des = "节点名称",
    arg0 = ""
  },
  {
    name = "pos_x",
    type = "Double",
    des = "坐标X",
    arg0 = "0"
  },
  {
    name = "pos_y",
    type = "Double",
    des = "坐标Y",
    arg0 = "0"
  },
  {
    name = "pos_z",
    type = "Double",
    des = "坐标Z",
    arg0 = "0"
  },
  {
    name = "distance",
    type = "Double",
    des = "显示距离",
    arg0 = "6000"
  },
  {name = "end"}
})
