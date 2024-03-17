RegProperty("TimeLineFactory", {
  {
    name = "timeLinePath",
    type = "String",
    des = "TimeLine路径",
    arg0 = ""
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
  {
    name = "z",
    type = "Double",
    des = "z坐标",
    arg0 = "0"
  },
  {
    name = "actorList",
    type = "Array",
    des = "随机演员",
    detail = "actor#replaceType#limitList"
  },
  {
    name = "actor",
    type = "String",
    des = "演员",
    arg0 = ""
  },
  {
    name = "replaceType",
    type = "Enum",
    des = "替换方式",
    arg0 = "HomeCharacter#BattleCharacter#Limit#Conductor",
    arg1 = "HomeCharacter"
  },
  {
    name = "limitList",
    type = "Factory",
    des = "限定列表",
    arg0 = "ListFactory",
    arg1 = "TimeLine"
  },
  {name = "end"},
  {
    name = "lczPathList",
    type = "Array",
    des = "列车长路径列表",
    detail = "lcz"
  },
  {
    name = "lcz",
    type = "String",
    des = "列车长路径",
    arg0 = ""
  },
  {name = "end"},
  {
    name = "fixedActorList",
    type = "Array",
    des = "固定角色",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "角色",
    arg0 = "UnitFactory"
  },
  {name = "end"},
  {
    mod = "剧情TL",
    name = "",
    type = "SysLine",
    des = "相机设置"
  },
  {
    mod = "剧情TL",
    name = "camX",
    type = "Double",
    des = "x坐标",
    arg0 = "0"
  },
  {
    mod = "剧情TL",
    name = "camY",
    type = "Double",
    des = "y坐标",
    arg0 = "5"
  },
  {
    mod = "剧情TL",
    name = "camZ",
    type = "Double",
    des = "z坐标",
    arg0 = "-24"
  },
  {
    mod = "剧情TL",
    name = "rotationX",
    type = "Double",
    des = "x轴旋转",
    arg0 = "0"
  },
  {
    mod = "剧情TL",
    name = "fOV",
    type = "Double",
    des = "FOV",
    arg0 = "50"
  },
  {
    mod = "剧情TL",
    name = "processPath",
    type = "String",
    des = "后处理路径|剧情用",
    arg0 = ""
  },
  {
    mod = "剧情TL",
    name = "",
    type = "SysLine",
    des = "光照设置"
  },
  {
    mod = "剧情TL",
    name = "isChangeLighting",
    type = "Bool",
    des = "修改光照|播放TimeLine期间将EnvironmentLighting替换为下列配置",
    arg0 = "True"
  },
  {
    mod = "剧情TL",
    name = "skyColorStr",
    type = "String",
    des = "SkyColorRGB(逗号隔开)",
    arg0 = ""
  },
  {
    mod = "剧情TL",
    name = "equatorColorStr",
    type = "String",
    des = "EquatorColorRGB(逗号隔开)",
    arg0 = ""
  },
  {
    mod = "剧情TL",
    name = "groundColorStr",
    type = "String",
    des = "GroundColorRGB(逗号隔开)",
    arg0 = ""
  },
  {
    mod = "剧情TL",
    name = "skybox",
    type = "String",
    des = "Skybox",
    arg0 = ""
  },
  {
    mod = "剧情TL",
    name = "cubemap",
    type = "String",
    des = "Cubemap",
    arg0 = ""
  },
  {
    mod = "剧情TL",
    name = "inTrainMap",
    type = "Bool",
    des = "在大世界|在大世界场景播放剧情",
    arg0 = "False"
  },
  {
    mod = "剧情TL",
    name = "isChangeFog",
    type = "Bool",
    des = "修改雾",
    arg0 = "False"
  },
  {
    mod = "剧情TL",
    name = "isOpenFog",
    type = "Bool",
    des = "开启雾",
    arg0 = "False"
  },
  {
    mod = "剧情TL",
    name = "fogColorStr",
    type = "String",
    des = "FogColorRGB(逗号隔开)",
    arg0 = ""
  },
  {
    mod = "剧情TL",
    name = "fogMode",
    type = "Enum",
    des = "模式",
    arg0 = "Linear#Exponential#ExponentialSquared",
    arg1 = "Exponential"
  },
  {
    mod = "剧情TL",
    name = "density",
    type = "Double",
    des = "密度",
    arg0 = "0"
  },
  {
    mod = "剧情TL",
    name = "",
    type = "SysLine",
    des = "触发战斗"
  },
  {
    mod = "剧情TL",
    name = "showBtn",
    type = "Bool",
    des = "显示按钮|显示TimeLine按钮",
    arg0 = "False"
  },
  {
    mod = "剧情TL",
    name = "btnX",
    type = "Double",
    des = "x坐标",
    arg0 = "0"
  },
  {
    mod = "剧情TL",
    name = "btnY",
    type = "Double",
    des = "y坐标",
    arg0 = "0"
  },
  {
    mod = "剧情TL",
    name = "levelId",
    type = "Factory",
    des = "关卡",
    arg0 = "LevelFactory"
  }
})
