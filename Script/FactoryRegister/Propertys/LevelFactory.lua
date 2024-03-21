RegProperty("LevelFactory", {
  {
    name = "",
    type = "SysLine",
    des = "通关经验"
  },
  {
    name = "minRoleNum",
    type = "Int",
    des = "最少角色数量",
    arg0 = "5"
  },
  {
    name = "characterExp",
    type = "Int",
    des = "角色经验",
    arg0 = "0"
  },
  {
    name = "playerExp",
    type = "Int",
    des = "玩家经验",
    arg0 = "0"
  },
  {
    name = "",
    type = "SysLine",
    des = "评分"
  },
  {
    name = "time",
    type = "Int",
    des = "评分时间(秒)",
    arg0 = "360",
    pyIgnore = true
  },
  {
    name = "difficulty",
    type = "Enum",
    des = "关卡难度",
    arg0 = "Normal#Difficult",
    arg1 = "Normal",
    pyIgnore = true
  },
  {
    name = "rating",
    type = "Int",
    des = "关卡分级",
    arg0 = "1"
  },
  {
    mod = "学院关卡",
    name = "",
    type = "SysLine",
    des = "学院关卡信息"
  },
  {
    mod = "学院关卡",
    name = "levelPreview",
    type = "Png",
    des = "关卡预览",
    arg0 = "",
    arg1 = "870|490",
    pyIgnore = true
  },
  {
    mod = "学院关卡",
    name = "collegeLevelType",
    type = "Enum",
    des = "考核类型",
    arg0 = "模拟战斗#外包任务",
    arg1 = "模拟战斗"
  },
  {
    name = "",
    type = "SysLine",
    des = "主界面背景"
  },
  {
    name = "mainBgPath",
    type = "Png",
    des = "主界面背景",
    arg0 = "",
    arg1 = "192|108",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "解锁插图"
  },
  {
    name = "pictureList",
    type = "Array",
    des = "解锁插图列表",
    detail = "score#id"
  },
  {
    name = "score",
    type = "Int",
    des = "所需分数",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "插图ID",
    arg0 = "PictureFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "解锁音乐"
  },
  {
    name = "musicList",
    type = "Array",
    des = "解锁音乐列表",
    detail = "score#id"
  },
  {
    name = "score",
    type = "Int",
    des = "所需分数",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "音乐ID",
    arg0 = "SoundFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "解锁视频"
  },
  {
    name = "videoList",
    type = "Array",
    des = "解锁视频列表",
    detail = "score#id"
  },
  {
    name = "score",
    type = "Int",
    des = "所需分数",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "视频ID",
    arg0 = "VideoFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "解锁怪物（图鉴）"
  },
  {
    name = "enemyBookList",
    type = "Array",
    des = "解锁怪物列表",
    detail = "score#id"
  },
  {
    name = "score",
    type = "Int",
    des = "所需分数",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "怪物ID",
    arg0 = "UnitFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "发送邮件"
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
    mod = "",
    name = "",
    type = "SysLine",
    des = "城市"
  },
  {
    name = "changeCityStateList",
    type = "Array",
    des = "首通后变更城市状态",
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
    name = "unlockQuestList",
    type = "Array",
    des = "首通后解锁任务",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "试炼场",
    name = "nextLevel",
    type = "Factory",
    des = "下一关",
    arg0 = "LevelFactory"
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "治安关卡"
  },
  {
    name = "saleLevelType",
    type = "Enum",
    des = "关卡类型||Default:默认,Mainline:主线,Activity:活动,Side:铁安局支线,Daily:铁安局随机,Reward:铁安局悬赏,Devil:魔窟,Line:线路拦路,LineClick:常规点击,pollute:污染拦路,twig:厄枝,buoy:浮标,World:世界BOSS,Core:核心关卡,Combat:作战中心,Test:试车场",
    arg0 = "Default#Mainline#Activity#Side#Daily#Weekly#Reward#Devil#Line#LineClick#pollute#twig#buoy#World#Core#Combat#Test",
    arg1 = "Default"
  },
  {
    name = "levelCoreId",
    type = "Factory",
    des = "关卡所属核心",
    arg0 = "EngineCoreFactory"
  },
  {
    name = "levelBgType",
    type = "Enum",
    des = "关卡背景类型",
    arg0 = "Normal#Hua",
    arg1 = "Normal",
    pyIgnore = true
  },
  {
    name = "levelStar",
    type = "Enum",
    des = "关卡星级",
    arg0 = "OneStar#TwoStar#ThreeStar#FourStar#FiveStar",
    arg1 = "OneStar"
  },
  {
    name = "reputation",
    type = "Int",
    des = "城市声望值",
    arg0 = "1"
  },
  {
    name = "constructLimit",
    type = "Int",
    des = "建设度限制",
    arg0 = "0"
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
  {
    name = "itemDemand",
    type = "Array",
    des = "道具需求",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具",
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
    name = "levelDemand",
    type = "Array",
    des = "前置关卡",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "关卡",
    arg0 = "LevelFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "通关数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "CorrespondingList",
    type = "Factory",
    des = "对应关卡包",
    arg0 = "ListFactory"
  },
  {
    name = "sort",
    type = "Int",
    des = "排序权重",
    arg0 = "99",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "Loading"
  },
  {
    name = "loadingPng",
    type = "Png",
    des = "Loading背景图",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "loadingTips",
    type = "String",
    des = "Loading提示",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "报案相关"
  },
  {
    name = "rewardCoefficientMax",
    type = "Double",
    des = "报酬最大系数",
    arg0 = "0.7"
  },
  {
    name = "rewardCoefficientMin",
    type = "Double",
    des = "报酬最大系数",
    arg0 = "0.3"
  },
  {
    name = "caseTimeLimit",
    type = "Int",
    des = "时间限制",
    arg0 = "7"
  },
  {
    name = "isBanAutoBattle",
    type = "Bool",
    des = "禁用自动战斗",
    arg0 = "False"
  }
})
