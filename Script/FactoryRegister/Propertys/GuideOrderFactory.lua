RegProperty("GuideOrderFactory", {
  {
    mod = "开始战斗",
    name = "levelId",
    type = "Factory",
    des = "关卡",
    arg0 = "LevelFactory"
  },
  {
    mod = "开始战斗",
    name = "roleList",
    type = "Array",
    des = "预制角色列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "角色",
    arg0 = "LevelRoleFactory"
  },
  {name = "end"},
  {
    mod = "对话",
    name = "paragraphId",
    type = "Factory",
    des = "段落",
    arg0 = "ParagraphFactory"
  },
  {
    mod = "聚焦角色并高亮",
    name = "unitId",
    type = "Factory",
    des = "角色",
    arg0 = "UnitFactory",
    arg1 = "玩家角色"
  },
  {
    mod = "聚焦货物并高亮",
    name = "goodsId",
    type = "Factory",
    des = "货物",
    arg0 = "HomeGoodsFactory",
    arg1 = "基础货物"
  },
  {
    mod = "聚焦角色并高亮,聚焦货物并高亮",
    name = "uiType",
    type = "Enum",
    des = "指定UI||CharacterList:角色列表,Squads:编队,SelectCharacter:编队选角色,HomeSticker:大头贴机,HomeTrade:交易所",
    arg0 = "CharacterList#Squads#HomeSticker#SelectCharacter#HomeTrade",
    arg1 = "CharacterList"
  },
  {
    mod = "指定UI高亮,关闭UI拖动,ScrollView聚焦",
    name = "uiPath",
    type = "String",
    des = "UI路径",
    arg0 = ""
  },
  {
    mod = "ScrollView聚焦",
    name = "scrollViewPath",
    type = "String",
    des = "ScrollView路径",
    arg0 = ""
  },
  {
    mod = "ScrollView聚焦",
    name = "nodePath",
    type = "String",
    des = "节点路径",
    arg0 = ""
  },
  {
    mod = "指定UI高亮,关闭UI拖动",
    name = "nodeName",
    type = "String",
    des = "节点名",
    arg0 = ""
  },
  {
    mod = "指定UI高亮",
    name = "delay",
    type = "Bool",
    des = "延迟处理",
    arg0 = "False"
  },
  {
    mod = "指定位置高亮",
    name = "x",
    type = "Double",
    des = "高亮中心X坐标",
    arg0 = "0"
  },
  {
    mod = "指定位置高亮",
    name = "y",
    type = "Double",
    des = "高亮中心Y坐标",
    arg0 = "0"
  },
  {
    mod = "指定位置高亮,指定UI高亮,聚焦角色并高亮,编队空角色位高亮,聚焦货物并高亮",
    name = "w",
    type = "Double",
    des = "高亮框宽度",
    arg0 = "0"
  },
  {
    mod = "指定位置高亮,指定UI高亮,聚焦角色并高亮,编队空角色位高亮,聚焦货物并高亮",
    name = "h",
    type = "Double",
    des = "高亮框高度",
    arg0 = "0"
  },
  {
    mod = "指定UI高亮,聚焦角色并高亮,编队空角色位高亮,聚焦货物并高亮",
    name = "offsetX",
    type = "Double",
    des = "X偏移",
    arg0 = "0"
  },
  {
    mod = "指定UI高亮,聚焦角色并高亮,编队空角色位高亮,聚焦货物并高亮",
    name = "offsetY",
    type = "Double",
    des = "Y偏移",
    arg0 = "0"
  },
  {
    mod = "指定位置高亮",
    name = "left",
    type = "Int",
    des = "左右适配：自适配(2):左(-1):中(0):右(1)",
    arg0 = "2"
  },
  {
    mod = "指定位置高亮",
    name = "top",
    type = "Int",
    des = "上下适配：自适配(2):上(-1):中(0):下(1)",
    arg0 = "2"
  },
  {
    mod = "指定位置高亮,指定UI高亮,聚焦角色并高亮,编队空角色位高亮,聚焦货物并高亮",
    name = "alpha",
    type = "Double",
    des = "遮罩透明度",
    arg0 = "0.7"
  },
  {
    mod = "指定位置高亮,指定UI高亮,聚焦角色并高亮,编队空角色位高亮,聚焦货物并高亮",
    name = "isShowFinger",
    type = "Bool",
    des = "显示小手",
    arg0 = "true"
  },
  {
    mod = "提示",
    name = "x",
    type = "Double",
    des = "提示中心X坐标",
    arg0 = "0"
  },
  {
    mod = "提示",
    name = "y",
    type = "Double",
    des = "提示中心Y坐标",
    arg0 = "0"
  },
  {
    mod = "提示",
    name = "text",
    type = "TextT",
    des = "提示内容",
    arg0 = ""
  },
  {
    mod = "提示",
    name = "isDoTween",
    type = "Bool",
    des = "开启打字机",
    arg0 = "True"
  },
  {
    mod = "提示",
    name = "speed",
    type = "Double",
    des = "打字机速度",
    arg0 = "0.02"
  },
  {
    mod = "提示",
    name = "soundId",
    type = "Factory",
    des = "配音",
    arg0 = "SoundFactory"
  },
  {
    mod = "提示",
    name = "pfp",
    type = "Png",
    des = "头像",
    arg0 = ""
  },
  {
    mod = "提示",
    name = "isWaitClick",
    type = "Bool",
    des = "点击结束当前引导",
    arg0 = "True"
  },
  {
    mod = "提示",
    name = "left",
    type = "Int",
    des = "左右适配：自适配(2):左(-1):中(0):右(1)",
    arg0 = "2"
  },
  {
    mod = "提示",
    name = "top",
    type = "Int",
    des = "上下适配：自适配(2):上(-1):中(0):下(1)",
    arg0 = "2"
  },
  {
    mod = "打开面板",
    name = "panelName",
    type = "String",
    des = "面板名称",
    arg0 = ""
  },
  {
    mod = "打开面板",
    name = "params",
    type = "String",
    des = "初始化参数",
    arg0 = ""
  },
  {
    mod = "指定关卡居中",
    name = "specificLevelId",
    type = "Factory",
    des = "指定关卡id",
    arg0 = "LevelFactory"
  },
  {
    mod = "指定关卡居中",
    name = "tweenTime",
    type = "Double",
    des = "缓动时长(单位:秒)",
    arg0 = "0"
  },
  {
    mod = "点击按钮",
    name = "panelName",
    type = "String",
    des = "面板名称",
    arg0 = ""
  },
  {
    mod = "点击按钮",
    name = "btnName",
    type = "String",
    des = "按钮名称",
    arg0 = ""
  },
  {
    mod = "设置任务追踪",
    name = "questId",
    type = "Factory",
    des = "任务ID",
    arg0 = "QuestFactory"
  },
  {
    mod = "延迟",
    name = "sec",
    type = "Double",
    des = "秒",
    arg0 = "0.5"
  },
  {
    mod = "设置UI面板",
    name = "panelName",
    type = "String",
    des = "面板名称",
    arg0 = ""
  },
  {
    mod = "设置UI面板",
    name = "isActive",
    type = "Bool",
    des = "按钮点击",
    arg0 = "True"
  },
  {
    mod = "更新引导序号",
    name = "skipOrderIdNum",
    type = "Int",
    des = "跳过引导序号数量",
    arg0 = "0"
  },
  {
    mod = "更新引导序号",
    name = "isChangesOrder",
    type = "Bool",
    des = "强更序号",
    arg0 = "False"
  },
  {
    mod = "等待帧事件触发",
    name = "eventString",
    type = "String",
    des = "帧事件String",
    arg0 = ""
  },
  {
    mod = "关闭当前界面",
    name = "uiPath",
    type = "String",
    des = "UI路径",
    arg0 = ""
  },
  {
    mod = "关闭当前界面",
    name = "isInit",
    type = "Bool",
    des = "初始化",
    arg0 = "True"
  },
  {
    mod = "关闭当前界面",
    name = "childNodePath",
    type = "String",
    des = "子节点路径",
    arg0 = ""
  },
  {
    mod = "关闭UI拖动",
    name = "isClose",
    type = "Bool",
    des = "关闭",
    arg0 = "True"
  },
  {
    mod = "保存面板触发引导序号",
    name = "apiName",
    type = "String",
    des = "协议名|不填协议会直接更新序号！",
    arg0 = ""
  },
  {
    mod = "保存面板触发引导序号",
    name = "guideNo",
    type = "Int",
    des = "引导序号",
    arg0 = "0"
  },
  {
    mod = "检测协议参数",
    name = "paramList",
    type = "Array",
    des = "参数列表",
    detail = "paramEnum#paramVal"
  },
  {
    name = "paramEnum",
    type = "Enum",
    des = "参数枚举|需要检测的参数，具体问程序",
    arg0 = "LevelId#sid",
    arg1 = "LevelId"
  },
  {
    name = "paramVal",
    type = "String",
    des = "参数",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "IFELSE跳转",
    name = "isLoop",
    type = "Bool",
    des = "循环判断|循环判断条件是否为真，为真后继续执行",
    arg0 = "false"
  },
  {
    mod = "IFELSE跳转",
    name = "trueLabel",
    type = "Factory",
    des = "成功跳转标签|不配则向下执行",
    arg0 = "GuideOrderFactory",
    arg1 = "标签"
  },
  {
    mod = "IFELSE跳转",
    name = "falseLabel",
    type = "Factory",
    des = "失败跳转标签|不配则向下执行",
    arg0 = "GuideOrderFactory",
    arg1 = "标签"
  },
  {
    mod = "IFELSE跳转",
    name = "keyList",
    type = "Array",
    des = "条件列表",
    detail = "key#compareType#val#num#uiPath"
  },
  {
    name = "key",
    type = "Enum",
    des = "条件|条件枚举|HeroNumInSquads:当前编队人数,GoodsNum:背包中指定货物数量,BargainNum:剩余砍价次数,RiseNum:剩余抬价次数,GoodsCanBuy:货物能否购买,HomeEnergy:疲劳值,IsActivated:UI激活,TradeLv:贸易等级,GoodsIndex:货物索引,IsMale:男列车长,QuestCompleted:完成已任务,CaptainNumber:编队队长位置,IsInSquads:角色是否在当前编队中,RemainingLoadage:剩余载货量,IsArrived:到达指定车站站外,ELECLevel:电力等级,CharacterLv:角色等级,AverageLevel:当前编队平均等级,AchievementCompleted:完成成就,TrainLength:列车节数,QuestProgress:任务进度,IsHaveCOCQuest:拥有完成地点为目标车站的商会任务,LevelCompleted:关卡已完成,IsCanReso:能否共振",
    arg0 = "HeroNumInSquads#GoodsNum#BargainNum#RiseNum#GoodsCanBuy#HomeEnergy#IsActivated#TradeLv#GoodsIndex#IsMale#QuestCompleted#CaptainNumber#IsInSquads#RemainingLoadage#IsArrived#ELECLevel#CharacterLv#AverageLevel#AchievementCompleted#TrainLength#QuestProgress#IsHaveCOCQuest#LevelCompleted#IsCanReso",
    arg1 = "HeroNumInSquads"
  },
  {
    name = "uiPath",
    type = "String",
    des = "UI路径",
    arg0 = ""
  },
  {
    name = "val",
    type = "String",
    des = "条件值",
    arg0 = ""
  },
  {
    name = "compareType",
    type = "Enum",
    des = "比较类型||LT:小于,LE:小于等于,EQ:等于,NE:不等于,GT:大于,GE:大于等于",
    arg0 = "LT#LE#EQ#NE#GT#GE",
    arg1 = "EQ"
  },
  {
    name = "num",
    type = "Double",
    des = "比较值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "点击按钮,转动视角,提示",
    name = "autoCompletedTime",
    type = "Double",
    des = "自动完成时间",
    arg0 = "-1"
  },
  {
    mod = "图片教学",
    name = "guildanceOrderId",
    type = "Factory",
    des = "图片教学引导",
    arg0 = "GuildanceOrderFactory",
    arg1 = "图片教程"
  },
  {
    mod = "强制开车",
    name = "stationId",
    type = "Factory",
    des = "目的地",
    arg0 = "HomeStationFactory"
  },
  {
    mod = "完成任务",
    name = "questId",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory"
  },
  {
    mod = "聚焦家具",
    name = "furnitureId",
    type = "Factory",
    des = "家具",
    arg0 = "HomeFurnitureFactory"
  },
  {
    mod = "聚焦家具",
    name = "moveTime",
    type = "Double",
    des = "移动时间",
    arg0 = "0"
  },
  {
    mod = "相机",
    name = "cameraType",
    type = "Int",
    des = "相机类型|-1:当前,0:World,1:Env,2:CocahInner,3:Store,4:CoachFactory,5:Max,6：Passenger",
    arg0 = "-1"
  },
  {
    mod = "相机",
    name = "moveCam",
    type = "Bool",
    des = "拖动",
    arg0 = "True"
  },
  {
    mod = "相机",
    name = "clickCam",
    type = "Bool",
    des = "点击",
    arg0 = "True"
  }
})
