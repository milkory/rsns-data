RegProperty("ExtractFactory", {
  {
    name = "commodityId",
    type = "Factory",
    des = "券商品ID",
    arg0 = "CommodityFactory"
  },
  {
    name = "",
    type = "SysLine",
    des = "",
    pyIgnore = true
  },
  {
    name = "startTime",
    type = "String",
    des = "开启时间",
    arg0 = ""
  },
  {
    name = "endTime",
    type = "String",
    des = "关闭时间",
    arg0 = ""
  },
  {
    name = "type",
    type = "Enum",
    des = "卡池类型",
    arg0 = "Pay#NonePay#limitCapsule",
    arg1 = "Pay"
  },
  {
    mod = "抽角色配置",
    name = "isNewbie",
    type = "Bool",
    des = "新手卡池",
    arg0 = "False"
  },
  {
    mod = "",
    name = "costList",
    type = "Array",
    des = "单抽消耗道具列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具ID",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "0"
  },
  {
    name = "count",
    type = "Int",
    des = "次数",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "",
    name = "costTenList",
    type = "Array",
    des = "十连消耗道具列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具ID",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "0"
  },
  {
    name = "count",
    type = "Int",
    des = "次数",
    arg0 = "0"
  },
  {name = "end"},
  {
    name = "freeCD",
    type = "Int",
    des = "免费单抽间隔",
    arg0 = "0"
  },
  {
    mod = "抽角色配置",
    name = "closeNum",
    type = "Int",
    des = "可抽取次数|-1时不限制次数",
    arg0 = "-1"
  },
  {
    name = "",
    type = "SysLine",
    des = "",
    pyIgnore = true
  },
  {
    mod = "抽角色配置",
    name = "firstReward",
    type = "Array",
    des = "首抽奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "角色ID",
    arg0 = "UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "奖励数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "抽角色配置",
    name = "secondReward",
    type = "Array",
    des = "二抽奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "角色ID",
    arg0 = "UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "奖励数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园扭蛋",
    name = "capFirstReward",
    type = "Array",
    des = "扭蛋首抽奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖品ID",
    arg0 = "HomeWeaponFactory#HomeFurnitureFactory#ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "奖励数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "抽角色配置",
    name = "newNormalList",
    type = "Array",
    des = "基础产品列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励列表",
    arg0 = "ListFactory",
    arg1 = "角色抽卡相关"
  },
  {
    name = "weight",
    type = "Int",
    des = "基础权重",
    arg0 = "0"
  },
  {
    name = "weightVAR",
    type = "Int",
    des = "权重变化值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "抽角色配置",
    name = "tenList",
    type = "Array",
    des = "10连保底产品表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "角色ID",
    arg0 = "UnitFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "0"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "extraRewardsList",
    type = "Array",
    des = "额外奖励（每抽）",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "抽角色配置",
    name = "tenSSRMax",
    type = "Int",
    des = "十连SSR最大数量",
    arg0 = "10"
  },
  {
    mod = "家园扭蛋",
    name = "capsuleList",
    type = "Array",
    des = "扭蛋产品列表",
    detail = "id#weight#num#limitNum"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖品ID",
    arg0 = "HomeWeaponFactory#HomeFurnitureFactory#ItemFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "0"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {
    name = "limitNum",
    type = "Int",
    des = "限购数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园扭蛋",
    name = "capTenList",
    type = "Array",
    des = "扭蛋10连保底产品表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖品ID",
    arg0 = "HomeWeaponFactory#HomeFurnitureFactory#ItemFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "0"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "protectTag",
    type = "Factory",
    des = "所属大保底标签",
    arg0 = "TagFactory",
    arg1 = "卡池大保底"
  },
  {
    name = "protectCount",
    type = "Int",
    des = "大保底开启次数",
    arg0 = "0"
  },
  {
    mod = "抽角色配置",
    name = "upList",
    type = "Array",
    des = "up角色列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "角色ID",
    arg0 = "UnitFactory"
  },
  {name = "end"},
  {
    mod = "家园扭蛋",
    name = "capProtectList",
    type = "Array",
    des = "扭蛋保底产品列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励ID",
    arg0 = "HomeWeaponFactory#HomeFurnitureFactory#ItemFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "0"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "家园扭蛋",
    name = "protectSectionList",
    type = "Array",
    des = "隐藏权重累加表",
    detail = "min#max#id"
  },
  {
    name = "min",
    type = "Int",
    des = "最小值",
    arg0 = "0"
  },
  {
    name = "max",
    type = "Int",
    des = "最大值",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "角色抽卡列表ID",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    name = "",
    type = "SysLine",
    des = "",
    pyIgnore = true
  },
  {
    mod = "家园扭蛋",
    name = "themeName",
    type = "StringT",
    des = "主题名称",
    arg0 = ""
  },
  {
    mod = "家园扭蛋",
    name = "pictureName",
    type = "StringT",
    des = "图片主题名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "抽角色配置",
    name = "name",
    type = "StringT",
    des = "卡池名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "sort",
    type = "Int",
    des = "UI排序权重|越大越靠前",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "抽角色配置",
    name = "questId",
    type = "Factory",
    des = "完成任务后显示",
    arg0 = "QuestFactory",
    arg1 = "基础任务",
    pyIgnore = true
  },
  {
    mod = "抽角色配置",
    name = "imageBg",
    type = "Png",
    des = "卡池背景",
    arg0 = "",
    arg1 = "200|100",
    pyIgnore = true
  },
  {
    mod = "抽角色配置",
    name = "tabName",
    type = "StringT",
    des = "页签名",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "抽角色配置",
    name = "tabPath",
    type = "Png",
    des = "页签图片",
    arg0 = "",
    arg1 = "216|100",
    pyIgnore = true
  },
  {
    mod = "抽角色配置",
    name = "animName",
    type = "String",
    des = "动画名",
    arg0 = "anim1",
    pyIgnore = true
  },
  {
    mod = "抽角色配置",
    name = "imageList",
    type = "Array",
    des = "卡池图片列表",
    detail = "image#x#y#scale",
    pyIgnore = true
  },
  {
    name = "image",
    type = "Png",
    des = "图片路径",
    arg0 = "",
    pyIgnore = true,
    arg1 = "100|100"
  },
  {
    name = "x",
    type = "Double",
    des = "X坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "y",
    type = "Double",
    des = "Y坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "scale",
    type = "Double",
    des = "缩放",
    arg0 = "1",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    name = "titlePath",
    type = "Png",
    des = "标题图片",
    arg0 = "",
    arg1 = "200|100",
    pyIgnore = true
  },
  {
    name = "titleX",
    type = "Double",
    des = "标题X坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "titleY",
    type = "Double",
    des = "标题Y坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "抽角色配置",
    name = "btnList",
    type = "Array",
    des = "角色详情列表",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "角色ID",
    arg0 = "UnitFactory",
    pyIgnore = true
  },
  {
    name = "x",
    type = "Double",
    des = "X坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "y",
    type = "Double",
    des = "Y坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "抽角色配置",
    name = "details",
    type = "TextT",
    des = "招募详情",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "抽角色配置",
    name = "tryList",
    type = "Array",
    des = "试用关卡列表",
    detail = "levelId#x#y",
    pyIgnore = true
  },
  {
    name = "levelId",
    type = "Factory",
    des = "关卡id",
    arg0 = "LevelFactory",
    pyIgnore = true
  },
  {
    name = "x",
    type = "Double",
    des = "X坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "y",
    type = "Double",
    des = "Y坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true}
})
