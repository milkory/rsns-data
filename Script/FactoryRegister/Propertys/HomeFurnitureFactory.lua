RegProperty("HomeFurnitureFactory", {
  {
    name = "beStored",
    type = "Bool",
    des = "可否被收纳",
    arg0 = "True",
    pyIgnore = true
  },
  {
    name = "SkinList",
    type = "Array",
    des = "家具皮肤列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "家具皮肤",
    arg0 = "HomeFurnitureSkinFactory"
  },
  {name = "end"},
  {
    name = "tipsPath",
    type = "Png",
    des = "Tips图标",
    arg0 = "",
    arg1 = "300|300",
    pyIgnore = true
  },
  {
    name = "Level",
    type = "Int",
    des = "家具等级",
    arg0 = "0"
  },
  {
    name = "comfort",
    type = "Int",
    des = "舒适度",
    arg0 = "0"
  },
  {
    name = "plantScores",
    type = "Int",
    des = "绿植评分",
    arg0 = "0"
  },
  {
    name = "fishScores",
    type = "Int",
    des = "水族评分",
    arg0 = "0"
  },
  {
    name = "petScores",
    type = "Int",
    des = "宠物评分",
    arg0 = "0"
  },
  {
    name = "foodScores",
    type = "Int",
    des = "美味评分",
    arg0 = "0"
  },
  {
    name = "playScores",
    type = "Int",
    des = "娱乐评分",
    arg0 = "0"
  },
  {
    name = "medicalScores",
    type = "Int",
    des = "医疗评分",
    arg0 = "0"
  },
  {
    name = "electricCost",
    type = "Int",
    des = "家具耗电",
    arg0 = "0"
  },
  {
    name = "wasteoutput",
    type = "Int",
    des = "每小时垃圾产出",
    arg0 = "0"
  },
  {
    name = "yinuooutput",
    type = "Int",
    des = "每小时以诺产出",
    arg0 = "0"
  },
  {
    name = "addPassengerCapacity",
    type = "Int",
    des = "增加载客量",
    arg0 = "0"
  },
  {
    name = "setfares",
    type = "Int",
    des = "座位类型|0硬座/1是上下铺/2是豪华双人床",
    arg0 = "-1"
  },
  {
    name = "seatPrice",
    type = "Int",
    des = "座位价格",
    arg0 = "0"
  },
  {
    name = "upgrade",
    type = "Factory",
    des = "升级家具",
    arg0 = "HomeFurnitureFactory"
  },
  {
    name = "lastgrade",
    type = "Factory",
    des = "上一级家具",
    arg0 = "HomeFurnitureFactory"
  },
  {
    name = "upgradeCostList",
    type = "Array",
    des = "升级消耗材料",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "材料",
    arg0 = "ItemFactory#HomeGoodsFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "功能家具",
    name = "functionType",
    type = "Factory",
    des = "功能类型",
    arg0 = "TagFactory",
    arg1 = "家具功能类型"
  },
  {
    mod = "功能家具",
    name = "manufactureType",
    type = "Factory",
    des = "制造类型",
    arg0 = "TagFactory",
    arg1 = "家具功能类型"
  },
  {
    name = "FurnitureSkillList",
    type = "Array",
    des = "家具技能",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "技能",
    arg0 = "HomeFurnitureSkillFactory"
  },
  {name = "end"},
  {
    name = "interfaceUrl",
    type = "String",
    des = "UI界面",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "PictureUrl",
    type = "String",
    des = "相框照片路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "formulaGroup",
    type = "Array",
    des = "图纸配方组",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "配方组",
    arg0 = "ProductionFactory"
  },
  {name = "end"},
  {
    name = "isShowBubble",
    type = "Bool",
    des = "显示气泡弹窗",
    arg0 = "True",
    pyIgnore = true
  },
  {
    name = "interfaceName",
    type = "String",
    des = "交互按钮名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "interfaceIcon",
    type = "Png",
    des = "交互按钮图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "movementName",
    type = "String",
    des = "行为交互按钮名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "movementIcon",
    type = "Png",
    des = "行为交互按钮图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "movement",
    type = "String",
    des = "行为路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "movementBreakName",
    type = "String",
    des = "行为交互打断名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "movementBreakIcon",
    type = "Png",
    des = "行为交互打断图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "movementBreak",
    type = "String",
    des = "行为路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "animationOpenName",
    type = "String",
    des = "动画开启按钮名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "animationOpenIcon",
    type = "Png",
    des = "动画开启按钮图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "animationOpenUrl",
    type = "String",
    des = "开启动画名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "animationCloseName",
    type = "String",
    des = "动画关闭按钮名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "animationCloseIcon",
    type = "Png",
    des = "动画关闭按钮图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "animationCloseUrl",
    type = "String",
    des = "关闭动画名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "floatUI",
    type = "String",
    des = "悬浮UI",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "ShowUI",
    type = "Png",
    des = "常显UI",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "OffsetX",
    type = "Double",
    des = "偏移X",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "OffsetY",
    type = "Double",
    des = "偏移Y",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "相机聚焦角度"
  },
  {
    name = "checkCameraX",
    type = "Double",
    des = "查看X轴相机角度",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "checkCameraY",
    type = "Double",
    des = "查看Y轴相机角度",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "checkCameraZ",
    type = "Double",
    des = "查看Z轴相机角度",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "checkCameraTime",
    type = "Double",
    des = "查看聚焦时间",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "upgradeCameraX",
    type = "Double",
    des = "升级X轴相机角度",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "upgradeCameraY",
    type = "Double",
    des = "升级Y轴相机角度",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "upgradeCameraZ",
    type = "Double",
    des = "升级Z轴相机角度",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "upgradeCameraTime",
    type = "Double",
    des = "升级聚焦时间",
    arg0 = "1",
    pyIgnore = true
  },
  {
    mod = "功能家具",
    name = "",
    type = "SysLine",
    des = "功能家具属性"
  },
  {
    mod = "功能家具",
    name = "",
    type = "SysLine",
    des = "净化仓"
  },
  {
    mod = "功能家具",
    name = "PurificationsiloList",
    type = "Array",
    des = "净化仓功能",
    detail = "pycNum#pycRewardsPercent#pycTimePercent"
  },
  {
    mod = "功能家具",
    name = "pycNum",
    type = "Int",
    des = "同时净化数量",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "pycRewardsPercent",
    type = "Double",
    des = "奖励百分比",
    arg0 = "1"
  },
  {
    mod = "功能家具",
    name = "pycTimePercent",
    type = "Double",
    des = "耗时百分比",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "功能家具",
    name = "",
    type = "SysLine",
    des = "鱼缸"
  },
  {
    mod = "功能家具",
    name = "fishtankType",
    type = "Enum",
    des = "鱼缸类型",
    arg0 = "小鱼缸#中鱼缸#大鱼缸",
    arg1 = "小鱼缸"
  },
  {
    mod = "功能家具",
    name = "fishtankVolume",
    type = "Int",
    des = "鱼缸体积",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "characterNum",
    type = "Int",
    des = "提供入住人数",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "PlantsNum",
    type = "Int",
    des = "植物数量",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "compressionTime",
    type = "Int",
    des = "压缩时间s",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "StoreRubbish",
    type = "Int",
    des = "垃圾暂存容量",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "StoreRubbishMax",
    type = "Int",
    des = "暂存容量上限",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "Capacity",
    type = "Int",
    des = "口粮器容量",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "PetNum",
    type = "Int",
    des = "宠物数量",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "FoodNum",
    type = "Int",
    des = "粮食槽容量",
    arg0 = "0"
  },
  {
    mod = "花盆",
    name = "",
    type = "SysLine",
    des = "花盆属性"
  },
  {
    mod = "花盆",
    name = "potSize",
    type = "Enum",
    des = "尺寸类型标签",
    arg0 = "Size1#Size2#Size3#Size4#Size5#Size6",
    arg1 = "Size1",
    pyIgnore = true
  },
  {
    mod = "花盆",
    name = "potType",
    type = "Enum",
    des = "花盆类型标签",
    arg0 = "Normal#Narrow#Basket#Garden",
    arg1 = "Normal",
    pyIgnore = true
  },
  {
    mod = "花盆",
    name = "",
    type = "SysLine",
    des = "3D模型偏移",
    pyIgnore = true
  },
  {
    mod = "花盆",
    name = "potX3D",
    type = "Double",
    des = "X轴偏移",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "花盆",
    name = "potY3D",
    type = "Double",
    des = "Y轴偏移",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "花盆",
    name = "potZ3D",
    type = "Double",
    des = "Z轴偏移",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "花盆",
    name = "",
    type = "SysLine",
    des = "2DUI偏移",
    pyIgnore = true
  },
  {
    mod = "花盆",
    name = "potX2D",
    type = "Double",
    des = "X轴偏移",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "花盆",
    name = "potY2D",
    type = "Double",
    des = "Y轴偏移",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "功能家具",
    name = "homeLoveUp",
    type = "Double",
    des = "家具亲密度加成",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "maxFood",
    type = "Int",
    des = "口粮上限",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "maxPetNum",
    type = "Int",
    des = "宠物数量上限",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "trustUp",
    type = "Int",
    des = "默契度提升",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "FridgeNum",
    type = "Int",
    des = "冰箱容量",
    arg0 = "0"
  },
  {
    mod = "功能家具",
    name = "ElectricPlus",
    type = "Int",
    des = "电力上限提升",
    arg0 = "0"
  }
})
