RegProperty("ChapterFactory", {
  {
    mod = "",
    name = "mainVideoList",
    type = "Array",
    des = "章节视频",
    pyIgnore = true
  },
  {
    name = "mainVideoPath",
    type = "String",
    des = "章节视频",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    name = "mainBgPath",
    type = "String",
    des = "主界面背景",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "章节描述",
    pyIgnore = true
  },
  {
    name = "chapterIndex",
    type = "Int",
    des = "章节序号",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "nameCN",
    type = "StringT",
    des = "章节名中文",
    arg0 = ""
  },
  {
    name = "nameEN",
    type = "StringT",
    des = "章节名英文",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "abbreviate",
    type = "StringT",
    des = "缩写",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "time",
    type = "StringT",
    des = "时间",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "placeCN",
    type = "StringT",
    des = "地点中文",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "placeEN",
    type = "StringT",
    des = "地点英文",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "资源章节",
    name = "",
    type = "SysLine",
    des = "解锁条件"
  },
  {
    mod = "资源章节",
    name = "playerLevel",
    type = "Int",
    des = "玩家等级",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "资源章节",
    name = "specifiedLevelId",
    type = "Factory",
    des = "指定关卡ID",
    arg0 = "LevelFactory",
    pyIgnore = true
  },
  {
    mod = "资源章节",
    name = "",
    type = "SysLine",
    des = "开启时间"
  },
  {
    mod = "资源章节",
    name = "weekList",
    type = "String",
    des = "开启时间",
    arg0 = "0,0,0,0,0,0,0"
  },
  {
    mod = "资源章节",
    name = "",
    type = "SysLine",
    des = "--------------"
  },
  {
    mod = "资源章节",
    name = "num",
    type = "Int",
    des = "次数",
    arg0 = "1"
  },
  {
    mod = "基础章节",
    name = "",
    type = "SysLine",
    des = "选关地图背景"
  },
  {
    mod = "",
    name = "chapterMapBackground",
    type = "String",
    des = "背景图片|地图界面的背景图片(直接填写素材路径)",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "铁轨素材"
  },
  {
    name = "",
    type = "SysLine",
    des = "关卡选中特效"
  },
  {
    name = "spineMarkId",
    type = "Factory",
    des = "Spine图标特效",
    arg0 = "EffectFactory",
    pyIgnore = true
  },
  {
    name = "spinePointId",
    type = "Factory",
    des = "Spine点特效",
    arg0 = "EffectFactory",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "章节进度奖励"
  },
  {
    mod = "",
    name = "rewardlList",
    type = "Array",
    des = "章节奖励",
    detail = "progress#id"
  },
  {
    name = "progress",
    type = "Int",
    des = "进度条件",
    arg0 = ""
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励ID",
    arg0 = "ListFactory"
  },
  {
    name = "iconPath",
    type = "Png",
    des = "奖励图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "",
    name = "advList",
    type = "Array",
    des = "大冒险列表",
    detail = "weight#id"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "大冒险关卡ID",
    arg0 = "AdvLevelFactory"
  },
  {name = "end"}
})
