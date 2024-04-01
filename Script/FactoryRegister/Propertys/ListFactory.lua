RegProperty("ListFactory", {
  {
    mod = "活动跳转相关",
    name = "skipStationStart",
    type = "Factory",
    des = "跳转城市（开始）",
    arg0 = "HomeStationFactory"
  },
  {
    mod = "活动跳转相关",
    name = "skipQuestList",
    type = "Array",
    des = "任务跳转列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务跳转",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "活动跳转相关",
    name = "skipStationEnd",
    type = "Factory",
    des = "跳转城市（结束）",
    arg0 = "HomeStationFactory"
  },
  {
    mod = "通用奖励",
    name = "rewardList",
    type = "Array",
    des = "奖励列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#HomeGoodsFactory#HomeFurnitureFactory#FridgeItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "插针小地图坐标",
    name = "needleInMapList",
    type = "Array",
    des = "插针列表",
    detail = "id#mapIconPath#iconPosy#iconPosx"
  },
  {
    name = "id",
    type = "Factory",
    des = "大地图插针",
    arg0 = "MapNeedleFactory"
  },
  {
    mod = "大世界剧情插针",
    name = "iconPosx",
    type = "Double",
    des = "UI坐标X",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "大世界剧情插针",
    name = "iconPosy",
    type = "Double",
    des = "UI坐标Y",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "大世界剧情插针",
    name = "mapIconPath",
    type = "String",
    des = "地图图标素材",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "商品",
    name = "shopList",
    type = "Array",
    des = "商品列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "商品ID",
    arg0 = "CommodityFactory#ValuableFactory#HomeWeaponFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "商品权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "商品",
    name = "priceList",
    type = "Array",
    des = "价格列表",
    detail = "num"
  },
  {
    name = "num",
    type = "Int",
    des = "价格",
    arg0 = "1",
    pythonName = "id"
  },
  {name = "end"},
  {
    mod = "发动机核心",
    name = "breakItemList",
    type = "Array",
    des = "突破材料列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "对应材料",
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
    mod = "发动机核心",
    name = "EngineRewardList",
    type = "Array",
    des = "升级奖励列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "对应材料",
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
    mod = "作战中心",
    name = "initOrderList",
    type = "Array",
    des = "初始交货订单",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "初始订单任务",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "OrderList",
    type = "Array",
    des = "交货订单",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "交货订单任务",
    arg0 = "QuestFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "stageRewardList",
    type = "Array",
    des = "阶段奖励列表",
    detail = "construct#id#num"
  },
  {
    name = "construct",
    type = "Int",
    des = "可领取建设进度",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励物品",
    arg0 = "ItemFactory#EquipmentFactory#HomeGoodsFactory#SourceMaterialFactory#FridgeItemFactory#HomeWeaponFactory#HomeFurnitureFactory#HomeCharacterSkinFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "textTipsList",
    type = "Array",
    des = "文本提示列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "提示文本",
    arg0 = "TextFactory"
  },
  {name = "end"},
  {
    mod = "治安关卡",
    name = "seriesType",
    type = "Enum",
    des = "序列类型||Story:临时剧情,Official:正式版",
    arg0 = "Story#Official",
    arg1 = "Official"
  },
  {
    mod = "治安关卡",
    name = "seriesCompleteNum",
    type = "Int",
    des = "系列完成数量",
    arg0 = "3"
  },
  {
    mod = "治安关卡",
    name = "seriesName",
    type = "String",
    des = "系列名称",
    arg0 = ""
  },
  {
    mod = "治安关卡",
    name = "sequenceName",
    type = "Factory",
    des = "序列名称",
    arg0 = "TextFactory"
  },
  {
    mod = "治安关卡",
    name = "expelNum",
    type = "Int",
    des = "驱逐总值",
    arg0 = "100"
  },
  {
    mod = "治安关卡",
    name = "deterrence",
    type = "Int",
    des = "增加威慑度",
    arg0 = "50"
  },
  {
    mod = "治安关卡",
    name = "expelRewardList",
    type = "Array",
    des = "驱逐进度奖励",
    detail = "expel#id"
  },
  {
    name = "expel",
    type = "Int",
    des = "所需驱逐度",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "治安关卡",
    name = "sideQuestList",
    type = "Array",
    des = "支线任务",
    detail = "id#weight#lv"
  },
  {
    name = "lv",
    type = "Int",
    des = "等级",
    arg0 = "1"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "支线任务",
    arg0 = "LevelFactory"
  },
  {name = "end"},
  {
    mod = "治安关卡",
    name = "dayQuestList",
    type = "Array",
    des = "日随机任务",
    detail = "id#weight#comNum#lv"
  },
  {
    name = "lv",
    type = "Int",
    des = "等级",
    arg0 = "1"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {
    name = "comNum",
    type = "Int",
    des = "限定完成次数",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "日随机任务",
    arg0 = "LevelFactory"
  },
  {name = "end"},
  {
    mod = "治安关卡",
    name = "buildingId",
    type = "Factory",
    des = "对应建筑",
    arg0 = "BuildingFactory"
  },
  {
    mod = "治安关卡",
    name = "",
    type = "SysLine",
    des = "线路关卡部分"
  },
  {
    mod = "治安关卡,路线事件列表",
    name = "eventType",
    type = "Enum",
    des = "事件类型||Hua:受协响度影响,Block:受威慑度影响,Other:不受影响",
    arg0 = "Hua#Block#Other",
    arg1 = "Other"
  },
  {
    mod = "治安关卡",
    name = "eventDeterrence",
    type = "Int",
    des = "事件威慑度",
    arg0 = "100"
  },
  {
    mod = "治安关卡,路线事件列表",
    name = "eventColoudness",
    type = "Int",
    des = "事件协响度",
    arg0 = "100"
  },
  {
    mod = "治安关卡",
    name = "eventLevelList",
    type = "Array",
    des = "触发关卡事件",
    detail = "id#weight"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "关卡事件",
    arg0 = "AFKEventFactory"
  },
  {name = "end"},
  {
    mod = "投资相关",
    name = "investorCostList",
    type = "Array",
    des = "投资花费列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "投资道具",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "100000"
  },
  {name = "end"},
  {
    mod = "投资相关",
    name = "investorRewList",
    type = "Array",
    des = "投资奖励列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "投资奖励",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "列车武装",
    name = "gradeExpList",
    type = "Array",
    des = "升级经验列表",
    detail = "num"
  },
  {
    name = "num",
    type = "Int",
    des = "升至下级所需经验",
    arg0 = "50"
  },
  {name = "end"},
  {
    mod = "列车武装",
    name = "offerExpList",
    type = "Array",
    des = "提供经验列表",
    detail = "num"
  },
  {
    name = "num",
    type = "Int",
    des = "提供经验",
    arg0 = "50"
  },
  {name = "end"},
  {
    mod = "货物",
    name = "goodsId",
    type = "Factory",
    des = "货物",
    arg0 = "HomeGoodsFactory",
    arg1 = "基础货物"
  },
  {
    mod = "货物",
    name = "price",
    type = "Int",
    des = "基础价格",
    arg0 = "100"
  },
  {
    mod = "货物",
    name = "minQuotation",
    type = "Double",
    des = "最低行情",
    arg0 = "0.8"
  },
  {
    mod = "货物",
    name = "maxQuotation",
    type = "Double",
    des = "最高行情",
    arg0 = "1.2"
  },
  {
    mod = "货物",
    name = "num",
    type = "Int",
    des = "基础数量",
    arg0 = "100"
  },
  {
    mod = "货物",
    name = "stockMultipleMin",
    type = "Int",
    des = "库存倍率下限",
    arg0 = "20"
  },
  {
    mod = "货物",
    name = "stockMultipleMax",
    type = "Int",
    des = "库存倍率上限",
    arg0 = "40"
  },
  {
    mod = "货物",
    name = "isSudden",
    type = "Bool",
    des = "暴涨暴跌",
    arg0 = "False"
  },
  {
    mod = "货物",
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    mod = "货物",
    name = "needDevelopNum",
    type = "Int",
    des = "刷新要求（发展度）",
    arg0 = "0"
  },
  {
    mod = "货物",
    name = "needItem",
    type = "Factory",
    des = "可购买投资货币要求",
    arg0 = "ItemFactory"
  },
  {
    mod = "货物",
    name = "needItemNum",
    type = "Int",
    des = "可购买投资货币数量要求",
    arg0 = "0"
  },
  {
    mod = "签到相关",
    name = "awardList",
    type = "Array",
    des = "签到奖励列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励id",
    arg0 = "ItemFactory#SourceMaterialFactory#UnitFactory#HomeCharacterSkinFactory#HomeWeaponFactory#EquipmentFactory#PetFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "喝酒相关",
    name = "drinkList",
    type = "Array",
    des = "喝酒列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗道具",
    arg0 = "ItemFactory#SourceMaterialFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "喝酒相关",
    name = "drinkBuffList",
    type = "Array",
    des = "喝酒Buff",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "buff",
    arg0 = "HomeBuffFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "100"
  },
  {name = "end"},
  {
    mod = "巡航事件",
    name = "eventName",
    type = "StringT",
    des = "事件池名称",
    arg0 = ""
  },
  {
    mod = "巡航事件",
    name = "eventList",
    type = "Array",
    des = "事件列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "ID",
    arg0 = "AFKEventFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "装备词条",
    name = "EquipmentEntryList",
    type = "Array",
    des = "装备词条列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "词条ID",
    arg0 = "SkillFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "周常任务",
    name = "weekQuestList",
    type = "Array",
    des = "任务列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "日常任务",
    name = "dailyQuestList",
    type = "Array",
    des = "任务列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "ID",
    arg0 = "QuestFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "电力相关",
    name = "electricMaterialList",
    type = "Array",
    des = "消耗材料",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗道具",
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
    mod = "燃油升级",
    name = "OilMaterialList",
    type = "Array",
    des = "消耗材料",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗道具",
    arg0 = "ItemFactory#SourceMaterialFactory#HomeGoodsFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "消耗相关",
    name = "materialList",
    type = "Array",
    des = "材料及数量列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "材料ID",
    arg0 = "SourceMaterialFactory#ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "角色抽卡相关",
    name = "rewardList",
    type = "Array",
    des = "奖励列表",
    detail = "id#weight#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "角色ID",
    arg0 = "UnitFactory",
    arg1 = "玩家角色"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "掉落相关",
    name = "quality",
    type = "Enum",
    des = "品质",
    arg0 = "White#Blue#Purple#Golden",
    arg1 = "White"
  },
  {
    mod = "掉落相关",
    name = "name",
    type = "String",
    des = "名称",
    arg0 = ""
  },
  {
    mod = "掉落相关",
    name = "iconPath",
    type = "Png",
    des = "掉落图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "掉落相关",
    name = "tipsPath",
    type = "Png",
    des = "Tips图标",
    arg0 = "",
    arg1 = "500|500"
  },
  {
    mod = "掉落相关",
    name = "des",
    type = "String",
    des = "描述",
    arg0 = ""
  },
  {
    mod = "掉落相关",
    name = "dropList",
    type = "Array",
    des = "掉落列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品ID",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#HomeGoodsFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "关卡掉落列表",
    name = "leveldropList",
    type = "Array",
    des = "掉落列表",
    detail = "id#percent#numMin#numMax"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品ID",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#ListFactory#HomeWeaponFactory#HomeFurnitureFactory"
  },
  {
    name = "percent",
    type = "Double",
    des = "掉率",
    arg0 = "1"
  },
  {
    name = "numMin",
    type = "Int",
    des = "最小掉落数量",
    arg0 = "0"
  },
  {
    name = "numMax",
    type = "Int",
    des = "最大掉落数量",
    arg0 = "999"
  },
  {name = "end"},
  {
    mod = "商店购买次数奖励",
    name = "rewardList",
    type = "Array",
    des = "奖励列表",
    detail = "BuyTimes#id"
  },
  {
    mod = "商店购买次数奖励",
    name = "BuyTimes",
    type = "Int",
    des = "达标次数",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励列表ID",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "声望奖励",
    name = "repRewardList",
    type = "Array",
    des = "声望奖励列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "通用物品",
    name = "goodsList",
    type = "Array",
    des = "物品列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品ID",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "主页商店",
    name = "mainStoreList",
    type = "Array",
    des = "商店列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "商店ID",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "站点区域",
    name = "areaStationList",
    type = "Array",
    des = "区域站点",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "站点",
    arg0 = "HomeStationFactory"
  },
  {name = "end"},
  {
    mod = "站点区域",
    name = "rareGoodsNum",
    type = "Int",
    des = "稀少交易品数量",
    arg0 = "0"
  },
  {
    mod = "站点区域",
    name = "rareGoodsList",
    type = "Array",
    des = "稀少交易品列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "货物",
    arg0 = "HomeGoodsFactory"
  },
  {name = "end"},
  {
    mod = "站点区域",
    name = "areaLevelList",
    type = "Array",
    des = "区域驱逐任务列表",
    detail = "id#weight#comNum"
  },
  {
    name = "id",
    type = "Factory",
    des = "驱逐任务",
    arg0 = "LevelFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "50"
  },
  {
    name = "comNum",
    type = "Int",
    des = "限制次数",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "剧情任务",
    name = "chapterName",
    type = "StringT",
    des = "章节名",
    arg0 = ""
  },
  {
    mod = "剧情任务",
    name = "condition",
    type = "Factory",
    des = "解锁条件",
    arg0 = "QuestFactory"
  },
  {
    mod = "剧情任务",
    name = "width",
    type = "Double",
    des = "地图宽",
    arg0 = "1920"
  },
  {
    mod = "剧情任务",
    name = "height",
    type = "Double",
    des = "地图高",
    arg0 = "1080"
  },
  {
    mod = "剧情任务",
    name = "questList",
    type = "Array",
    des = "任务列表",
    detail = "id#x#y"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory"
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
  {name = "end"},
  {
    mod = "技能BUFF",
    name = "skillBuffList",
    type = "Array",
    des = "技能BUFF列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "buffId",
    arg0 = "SkillFactory"
  },
  {name = "end"},
  {
    mod = "TimeLine",
    name = "spineList",
    type = "Array",
    des = "资源列表",
    detail = "note#spinePath#weight",
    pyIgnore = true
  },
  {
    name = "note",
    type = "String",
    des = "备注",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "spinePath",
    type = "String",
    des = "资源路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "NPC对话",
    name = "listType",
    type = "Enum",
    des = "列表类型",
    arg0 = "Order#Mutex",
    arg1 = "Order",
    pyIgnore = true
  },
  {
    mod = "NPC对话",
    name = "dialogList",
    type = "Array",
    des = "对话组",
    detail = "id#reputation",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "对话文本",
    arg0 = "TextFactory",
    arg1 = "NPC对话",
    pyIgnore = true
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "城市地图",
    name = "bgList",
    type = "Array",
    des = "背景列表",
    detail = "changeTime#bgPath#effectListId",
    pyIgnore = true
  },
  {
    name = "changeTime",
    type = "String",
    des = "变化时间",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "bgPath",
    type = "Png",
    des = "背景图",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "effectListId",
    type = "Factory",
    des = "特效列表",
    arg0 = "ListFactory",
    arg1 = "城市地图特效",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "城市地图",
    name = "offsetX",
    type = "Double",
    des = "背景默认X偏移",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "城市地图",
    name = "offsetY",
    type = "Double",
    des = "背景默认Y偏移",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "城市地图",
    name = "cityNPCList",
    type = "Array",
    des = "城市功能入口",
    detail = "dev#questId#isOnlyHave#iconPath#name#x#y#func#btnType#uiPath#modelPath#npcId#bgPath#stationPlace#dialogId#dungeonId#levelId#textId#isLock#isSpecial#isInstance#effectPath#startTime#endTime#activityId#metaId#exitId",
    pyIgnore = true
  },
  {
    name = "name",
    type = "String",
    des = "按钮名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "x",
    type = "Double",
    des = "x坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "y",
    type = "Double",
    des = "y坐标",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "isSpecial",
    type = "Bool",
    des = "特殊按钮",
    arg0 = "false",
    pyIgnore = true
  },
  {
    name = "isInstance",
    type = "Bool",
    des = "副本",
    arg0 = "false",
    pyIgnore = true
  },
  {
    name = "iconPath",
    type = "Png",
    des = "按钮图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "nameIconPath",
    type = "Png",
    des = "名字图标",
    arg0 = "",
    arg1 = "50|50",
    pyIgnore = true
  },
  {
    name = "effectPath",
    type = "String",
    des = "特效",
    arg0 = "UI/UIEffect/particle/UI_city/UI_cityBtn_01/UI_cityBtn_01",
    pyIgnore = true
  },
  {
    name = "questId",
    type = "Factory",
    des = "显示任务",
    arg0 = "QuestFactory",
    pyIgnore = true
  },
  {
    name = "isOnlyHave",
    type = "Bool",
    des = "仅拥有任务时显示|解锁且未完成",
    arg0 = "True",
    pyIgnore = true
  },
  {
    name = "dev",
    type = "Int",
    des = "解锁发展度",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "activityId",
    type = "Factory",
    des = "在活动期间显示|活动ID,如果为拥有任务时显示，读取任务时间",
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
  {
    name = "isLock",
    type = "Bool",
    des = "锁定",
    arg0 = "false",
    pyIgnore = true
  },
  {
    name = "func",
    type = "Enum",
    des = "功能||OpenUI:打开界面,OpenScene:打开店铺,OpenDialog:播放剧情,OpenDungeon:进入副本,OpenLevel:进入关卡,Tips:显示提示,OpenBuilding:打开建筑,OpenLevelDetail:打开关卡详情,OpenCityMap:打开城市地图,Guide:执行引导",
    arg0 = "OpenUI#OpenScene#OpenDialog#OpenDungeon#OpenLevel#Tips#OpenBuilding#OpenCityMap#Guide",
    arg1 = "OpenUI",
    pyIgnore = true
  },
  {
    name = "btnType",
    type = "Enum",
    des = "功能枚举||HomeSafe:铁安局,HomeCOC:商会,HomeTrade:交易所,RubbishStation:垃圾站,HomeInvest:市政厅,Other:其他",
    arg0 = "HomeSafe#HomeCOC#HomeTrade#RubbishStation#Other#HomeInvest",
    arg1 = "Other",
    pyIgnore = true
  },
  {
    name = "uiPath",
    type = "String",
    des = "UI预制",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "npcId",
    type = "Factory",
    des = "NPC",
    arg0 = "NPCFactory",
    pyIgnore = true
  },
  {
    name = "buildingId",
    type = "Factory",
    des = "建筑",
    arg0 = "BuildingFactory",
    pyIgnore = true
  },
  {
    name = "stationPlace",
    type = "Factory",
    des = "车站店面",
    arg0 = "HomeStationPlaceFactory",
    pyIgnore = true
  },
  {
    name = "dialogId",
    type = "Factory",
    des = "对话",
    arg0 = "ParagraphFactory",
    pyIgnore = true
  },
  {
    name = "dungeonId",
    type = "Factory",
    des = "副本ID",
    arg0 = "ChapterFactory",
    pyIgnore = true
  },
  {
    name = "levelId",
    type = "Factory",
    des = "关卡ID",
    arg0 = "LevelFactory",
    pyIgnore = true
  },
  {
    name = "metaId",
    type = "Factory",
    des = "功能对应metaID",
    arg0 = "ListFactory#GuideFactory",
    pyIgnore = true
  },
  {
    name = "textId",
    type = "Factory",
    des = "提示文本",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    name = "bgPath",
    type = "Png",
    des = "背景图片",
    arg0 = "",
    arg1 = "216|100",
    pyIgnore = true
  },
  {
    name = "bgColor",
    type = "String",
    des = "背景图颜色",
    arg0 = "FFFFFF",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "城市地图",
    name = "isShowRep",
    type = "Bool",
    des = "显示声望",
    arg0 = "true",
    pyIgnore = true
  },
  {
    mod = "城市地图",
    name = "isShowConstruct",
    type = "Bool",
    des = "显示建设进度",
    arg0 = "False",
    pyIgnore = true
  },
  {
    mod = "城市地图",
    name = "exitId",
    type = "Factory",
    des = "返回哪里",
    arg0 = "HomeStationFactory",
    pyIgnore = true
  },
  {
    mod = "城市地图特效",
    name = "effectList",
    type = "Array",
    des = "特效列表",
    detail = "effectPath#weight",
    pyIgnore = true
  },
  {
    name = "effectPath",
    type = "String",
    des = "特效",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "车站场景",
    name = "stationSceneList",
    type = "Array",
    des = "场景列表",
    detail = "dev#stationScene#postProcessingPath#sceneWidth#bgmId#sceneGroup",
    pyIgnore = true
  },
  {
    name = "dev",
    type = "Int",
    des = "所需发展度",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "stationScene",
    type = "String",
    des = "车站场景名",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "postProcessingPath",
    type = "String",
    des = "后处理路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "sceneWidth",
    type = "Int",
    des = "场景拖拽半径",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "bgmId",
    type = "Factory",
    des = "车站BGM",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "sceneGroup",
    type = "Factory",
    des = "循环场景",
    arg0 = "HomeTrainSceneGroupFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "铁路事件",
    name = "eventList",
    type = "Array",
    des = "关卡列表",
    detail = "distance#id"
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
    des = "事件ID",
    arg0 = "AFKEventFactory",
    arg1 = "关卡事件"
  },
  {name = "end"},
  {
    mod = "铁路事件",
    name = "boxList",
    type = "Array",
    des = "宝箱列表",
    detail = "distance#id"
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
    des = "事件ID",
    arg0 = "AFKEventFactory",
    arg1 = "点击宝箱"
  },
  {name = "end"},
  {
    mod = "默认生物",
    name = "defaultCreatureList",
    type = "Array",
    des = "默认生物",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "生物",
    arg0 = "HomeCreatureFactory#PetFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "成就相关",
    name = "accumulateList",
    type = "Array",
    des = "成就点数累计列表",
    detail = "sumCount#name#stageName#png#id#achieveList"
  },
  {
    name = "sumCount",
    type = "Int",
    des = "成就累计点数",
    arg0 = "100"
  },
  {
    name = "name",
    type = "String",
    des = "总览名称",
    arg0 = ""
  },
  {
    name = "stageName",
    type = "String",
    des = "阶段名称",
    arg0 = ""
  },
  {
    name = "png",
    type = "Png",
    des = "显示图片",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励",
    arg0 = "ListFactory"
  },
  {
    name = "achieveList",
    type = "Int",
    des = "对应成就列表",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "成就相关",
    name = "achieveRewardList",
    type = "Array",
    des = "奖励列表",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "成就相关",
    name = "achieveStartList",
    type = "Array",
    des = "开启成就列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "成就",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "Tag通用",
    name = "normalTagList",
    type = "Array",
    des = "Tag列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "标签",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "宠物性格",
    name = "petPersonalityList",
    type = "Array",
    des = "宠物性格列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "宠物性格",
    arg0 = "TagFactory",
    arg1 = "宠物性格"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "宠物羁绊",
    name = "petTieList",
    type = "Array",
    des = "宠物羁绊列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "宠物羁绊",
    arg0 = "TagFactory",
    arg1 = "宠物羁绊"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "剧情回顾段落",
    name = "IncludeParagraph",
    type = "Array",
    des = "包含段落"
  },
  {
    name = "id",
    type = "Factory",
    des = "选择段落",
    arg0 = "ParagraphFactory",
    arg1 = ""
  },
  {name = "end"},
  {
    mod = "商会任务",
    name = "starWeightList",
    type = "Array",
    des = "任务星级权重",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Enum",
    des = "任务列表",
    arg0 = "questList1#questList2#questList3#questList4#questList5",
    arg1 = "questList1"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "商会任务",
    name = "questList1",
    type = "Array",
    des = "1星任务列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "订单"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "商会任务",
    name = "questList2",
    type = "Array",
    des = "2星任务列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "订单"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "商会任务",
    name = "questList3",
    type = "Array",
    des = "3星任务列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "订单"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "商会任务",
    name = "questList4",
    type = "Array",
    des = "4星任务列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "订单"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "商会任务",
    name = "questList5",
    type = "Array",
    des = "5星任务列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "订单"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "铁路宝箱",
    name = "boxGoodsList",
    type = "Array",
    des = "掉落物品列表",
    detail = "id#min#max#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品id",
    arg0 = "HomeGoodsFactory#ItemFactory#SourceMaterialFactory"
  },
  {
    name = "min",
    type = "Int",
    des = "最小数量",
    arg0 = "1"
  },
  {
    name = "max",
    type = "Int",
    des = "最大数量",
    arg0 = "1"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "列车长职级",
    name = "Rankname",
    type = "String",
    des = "职级名称",
    arg0 = ""
  },
  {
    mod = "列车长职级",
    name = "icon",
    type = "Png",
    des = "职级图标",
    arg0 = "",
    arg1 = "200|200"
  },
  {
    mod = "列车长职级",
    name = "Unlockright",
    type = "Array",
    des = "解锁特权",
    arg0 = ""
  },
  {
    mod = "列车长职级",
    name = "id",
    type = "String",
    des = "特权",
    arg0 = ""
  },
  {name = "end"},
  {
    mod = "列车长职级",
    name = "reward",
    type = "Array",
    des = "奖励列表"
  },
  {
    name = "id",
    type = "Factory",
    des = "等级奖励",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#HomeCharacterSkinFactory#HomeWeaponFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "道具数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "传单地点",
    name = "",
    type = "SysLine",
    des = "传单宣传地点"
  },
  {
    mod = "传单地点",
    name = "namePlace",
    type = "String",
    des = "地点名",
    arg0 = ""
  },
  {
    mod = "传单地点",
    name = "placeType",
    type = "Factory",
    des = "地点类型",
    arg0 = "TagFactory"
  },
  {
    mod = "传单地点",
    name = "namePlaceIcon",
    type = "Png",
    des = "店铺图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "传单地点",
    name = "PlaceDesc",
    type = "Factory",
    des = "地点描述",
    arg0 = "TextFactory"
  },
  {
    mod = "传单地点",
    name = "unlockPlace",
    type = "Int",
    des = "店铺城市声望解锁条件",
    arg0 = "0"
  },
  {
    mod = "传单地点",
    name = "placeWeight",
    type = "Int",
    des = "店铺排序权重",
    arg0 = "0"
  },
  {
    mod = "传单地点",
    name = "passageMax",
    type = "Int",
    des = "乘客招收上限",
    arg0 = "0"
  },
  {
    mod = "传单地点",
    name = "passageMin",
    type = "Int",
    des = "乘客招收下限",
    arg0 = "0"
  },
  {
    mod = "传单地点",
    name = "passageTypeList",
    type = "Array",
    des = "乘客招收构成",
    detail = "isOnly#id#weight"
  },
  {
    mod = "传单地点",
    name = "isOnly",
    type = "Bool",
    des = "是否唯一",
    arg0 = "False"
  },
  {
    mod = "传单地点",
    name = "id",
    type = "Factory",
    des = "乘客id",
    arg0 = "PassageFactory"
  },
  {
    mod = "传单地点",
    name = "weight",
    type = "Int",
    des = "乘客构成权重",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "传单地点",
    name = "passageTagList",
    type = "Array",
    des = "招收乘客标签",
    detail = "id#weight"
  },
  {
    mod = "传单地点",
    name = "isOnly",
    type = "Bool",
    des = "是否唯一",
    arg0 = "False"
  },
  {
    name = "id",
    type = "Factory",
    des = "标签id",
    arg0 = "ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "标签构成权重",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "杂志视频广告",
    name = "adList",
    type = "Array",
    des = "广告列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "广告ID",
    arg0 = "PondFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "任务追踪",
    name = "stateList",
    type = "Array",
    des = "状态列表",
    detail = "note#stateNo#nodePath#offsetX#offsetY#prefab",
    pyIgnore = true
  },
  {
    name = "stateNo",
    type = "Int",
    des = "状态",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "note",
    type = "String",
    des = "备注",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "prefab",
    type = "String",
    des = "小红点预制",
    arg0 = "UI/Common/Group_Track",
    pyIgnore = true
  },
  {
    name = "tipsType",
    type = "Enum",
    des = "小红点类型",
    arg0 = "Config#StartStation#EndStation",
    arg1 = "Config",
    pyIgnore = true
  },
  {
    name = "nodePath",
    type = "String",
    des = "小红点节点",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "offsetX",
    type = "Int",
    des = "x偏移",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "offsetY",
    type = "Int",
    des = "y偏移",
    arg0 = "0",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "任务追踪",
    name = "keyList",
    type = "Array",
    des = "条件列表",
    detail = "key#intVal#stringVal#factoryVal",
    pyIgnore = true
  },
  {
    name = "key",
    type = "Enum",
    des = "条件||IsInStation:在指定车站,IsArrived:到达指定车站,IsActivated:UI节点激活,IsEnoughGoods:拥有指定数量某货物,IsInStartStation:在任务开始车站,IsInEndStation:在任务完成车站,IsArrivedStartStation:到达任务开启车站,IsArrivedEndStation:到达任务完成车站",
    arg0 = "IsInStation#IsArrived#IsActivated#IsEnoughGoods#IsInStartStation#IsInEndStation#IsArrivedStartStation#IsArrivedEndStation",
    arg1 = "IsInStation",
    pyIgnore = true
  },
  {
    name = "intVal",
    type = "Int",
    des = "Int",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "stringVal",
    type = "String",
    des = "String",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "factoryVal",
    type = "Factory",
    des = "Factory",
    arg0 = "HomeStationFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "按钮列表",
    name = "btnList",
    type = "Array",
    des = "按钮列表",
    detail = "note#btnPath",
    pyIgnore = true
  },
  {
    name = "note",
    type = "String",
    des = "备注",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "btnPath",
    type = "String",
    des = "按钮路径",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "协议列表",
    name = "apiList",
    type = "Array",
    des = "协议列表",
    detail = "note#api",
    pyIgnore = true
  },
  {
    name = "note",
    type = "String",
    des = "备注",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "api",
    type = "String",
    des = "协议",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "车厢列表",
    name = "trainLook",
    type = "Array",
    des = "展示车厢列表",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "列车车厢id",
    arg0 = "HomeCoachSkinFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "车厢列表",
    name = "trainName",
    type = "Factory",
    des = "列车名字",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    mod = "大世界环境",
    name = "timeStart",
    type = "Int",
    des = "开始时间",
    arg0 = "0"
  },
  {
    mod = "大世界环境",
    name = "timeEnd",
    type = "Int",
    des = "结束时间",
    arg0 = "0"
  },
  {
    mod = "大世界环境",
    name = "environmentList",
    type = "Array",
    des = "环境列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "车道信息id",
    arg0 = "TrainRoadMsgFactory"
  },
  {name = "end"},
  {
    mod = "路线事件列表",
    name = "eventWeightList",
    type = "Array",
    des = "事件列表",
    detail = "weight#id"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "事件id",
    arg0 = "AFKEventFactory"
  },
  {name = "end"},
  {
    mod = "点击事件列表",
    name = "clickEventList",
    type = "Array",
    des = "点击事件数据",
    detail = "pos_x#pos_y#pos_z#id#weight"
  },
  {
    mod = "点击事件列表",
    name = "pos_x",
    type = "Double",
    des = "坐标X",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "点击事件列表",
    name = "pos_y",
    type = "Double",
    des = "坐标Y",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "点击事件列表",
    name = "pos_z",
    type = "Double",
    des = "坐标Z",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "点击事件列表",
    name = "isShowUI",
    type = "Bool",
    des = "地图显示图标",
    arg0 = "false",
    pyIgnore = true
  },
  {
    mod = "路线区域",
    name = "icon_x",
    type = "Double",
    des = "UI坐标X",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "路线区域",
    name = "icon_y",
    type = "Double",
    des = "UI坐标Y",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "事件列表id",
    arg0 = "ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "乘客标签",
    name = "name",
    type = "String",
    des = "标签名字",
    arg0 = ""
  },
  {
    mod = "乘客标签",
    name = "isIncome",
    type = "Bool",
    des = "是否计算收益",
    arg0 = "False"
  },
  {
    mod = "乘客标签",
    name = "",
    type = "SysLine",
    des = "乘客需求"
  },
  {
    mod = "乘客标签",
    name = "comfort",
    type = "Array",
    des = "舒适度基础值|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "乘客标签",
    name = "common",
    type = "Int",
    des = "舒适度基础值",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "most",
    type = "Int",
    des = "舒适度上限值",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "pay",
    type = "Int",
    des = "舒适度消费值",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "out",
    type = "Int",
    des = "舒适度超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "乘客标签",
    name = "plantScores",
    type = "Array",
    des = "绿植评分基础值|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "乘客标签",
    name = "common",
    type = "Int",
    des = "绿植评分基本",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "most",
    type = "Int",
    des = "绿植评分上限",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "pay",
    type = "Int",
    des = "绿植消费值",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "out",
    type = "Int",
    des = "绿植超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "乘客标签",
    name = "fishScores",
    type = "Array",
    des = "水族评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "乘客标签",
    name = "common",
    type = "Int",
    des = "水族评分基本",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "most",
    type = "Int",
    des = "水族评分上限",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "pay",
    type = "Int",
    des = "水族消费值",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "out",
    type = "Int",
    des = "水族超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "乘客标签",
    name = "petScores",
    type = "Array",
    des = "宠物评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "乘客标签",
    name = "common",
    type = "Int",
    des = "宠物评分基础",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "most",
    type = "Int",
    des = "宠物评分上限",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "pay",
    type = "Int",
    des = "宠物消费值",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "out",
    type = "Int",
    des = "宠物超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "乘客标签",
    name = "foodScores",
    type = "Array",
    des = "美味评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "乘客标签",
    name = "common",
    type = "Int",
    des = "美味评分基础",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "most",
    type = "Int",
    des = "美味评分上限",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "pay",
    type = "Int",
    des = "美味消费值",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "out",
    type = "Int",
    des = "美味超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "乘客标签",
    name = "playScores",
    type = "Array",
    des = "娱乐评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "乘客标签",
    name = "common",
    type = "Int",
    des = "娱乐评分基础",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "most",
    type = "Int",
    des = "娱乐评分上限",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "pay",
    type = "Int",
    des = "娱乐消费值",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "out",
    type = "Int",
    des = "娱乐超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "乘客标签",
    name = "medicalScores",
    type = "Array",
    des = "医疗评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "乘客标签",
    name = "common",
    type = "Int",
    des = "医疗评分基础",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "most",
    type = "Int",
    des = "医疗评分上限",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "pay",
    type = "Int",
    des = "医疗消费值",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "out",
    type = "Int",
    des = "医疗超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "乘客标签",
    name = "arm",
    type = "Array",
    des = "武装度评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "乘客标签",
    name = "common",
    type = "Int",
    des = "武装度评分基础",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "most",
    type = "Int",
    des = "武装度评分上限",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "pay",
    type = "Int",
    des = "武装度消费值",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "out",
    type = "Int",
    des = "武装超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "乘客标签",
    name = "clean",
    type = "Array",
    des = "清洁度评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "乘客标签",
    name = "common",
    type = "Double",
    des = "清洁度评分基础",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "most",
    type = "Double",
    des = "清洁度评分上限",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "pay",
    type = "Double",
    des = "清洁度消费值",
    arg0 = "0"
  },
  {
    mod = "乘客标签",
    name = "out",
    type = "Double",
    des = "清洁度超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "资料页签",
    name = "icon",
    type = "Png",
    des = "图标",
    arg0 = "",
    arg1 = "96|96"
  },
  {
    mod = "资料页签",
    name = "dataTab",
    type = "Array",
    des = "页签"
  },
  {
    mod = "资料页签",
    name = "name",
    type = "String",
    des = "名字",
    arg0 = ""
  },
  {
    mod = "资料页签",
    name = "level",
    type = "Int",
    des = "层级",
    arg0 = "1"
  },
  {
    mod = "资料页签",
    name = "id",
    type = "Factory",
    des = "包含内容",
    arg0 = "ListFactory#DataFactory"
  },
  {name = "end"},
  {
    mod = "资料页签",
    name = "coverPage",
    type = "Png",
    des = "文件夹背景",
    arg0 = "",
    arg1 = "140|110"
  },
  {
    mod = "资料页签",
    name = "interfaceUrl",
    type = "String",
    des = "UI界面",
    arg0 = ""
  },
  {
    mod = "手账帮助三级",
    name = "lock",
    type = "Int",
    des = "解锁条件",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "手账帮助三级",
    name = "name",
    type = "String",
    des = "名字",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "手账帮助三级",
    name = "icon",
    type = "Png",
    des = "封皮图标",
    arg0 = "",
    arg1 = "500|500",
    pyIgnore = true
  },
  {
    mod = "手账帮助三级",
    name = "notebook",
    type = "Array",
    des = "手账页签",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "手账帮助",
    arg0 = "DataFactory"
  },
  {name = "end", pyIgnore = true},
  {
    mod = "手账帮助三级",
    name = "cover",
    type = "Png",
    des = "动效封面",
    arg0 = "",
    arg1 = "500|500",
    pyIgnore = true
  },
  {
    mod = "角色档案",
    name = "",
    type = "SysLine",
    des = "角色语音"
  },
  {
    mod = "角色档案",
    name = "CvName1",
    type = "String",
    des = "国语cv"
  },
  {
    mod = "角色档案",
    name = "CvName2",
    type = "String",
    des = "日语cv"
  },
  {
    mod = "角色档案",
    name = "TrustAudio",
    type = "Array",
    des = "公用语音"
  },
  {
    name = "audioType",
    type = "Enum",
    des = "语音类型||Gacha:抽卡,#PosterGirl:设置看板娘,#Trust:默契",
    arg0 = "Gacha#PosterGirl#Trust",
    arg1 = "Trust",
    pyIgnore = true
  },
  {
    name = "AudioName",
    type = "String",
    des = "标题",
    arg0 = ""
  },
  {
    name = "Audio1",
    type = "Factory",
    des = "国语",
    arg0 = "SoundFactory"
  },
  {
    name = "Audio2",
    type = "Factory",
    des = "日语",
    arg0 = "SoundFactory"
  },
  {
    name = "UnlockLevel",
    type = "Int",
    des = "解锁等级",
    arg0 = "1"
  },
  {
    name = "StoryText",
    type = "TextT",
    des = "文本",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "角色档案",
    name = "AudioM",
    type = "Array",
    des = "对男语音"
  },
  {
    name = "AudioName",
    type = "String",
    des = "标题",
    arg0 = ""
  },
  {
    name = "Audio1",
    type = "Factory",
    des = "国语",
    arg0 = "SoundFactory"
  },
  {
    name = "Audio2",
    type = "Factory",
    des = "日语",
    arg0 = "SoundFactory"
  },
  {
    name = "UnlockLevel",
    type = "Int",
    des = "解锁等级",
    arg0 = "1"
  },
  {
    name = "StoryText",
    type = "TextT",
    des = "文本",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "角色档案",
    name = "AudioF",
    type = "Array",
    des = "对女语音"
  },
  {
    name = "AudioName",
    type = "String",
    des = "标题",
    arg0 = ""
  },
  {
    name = "Audio1",
    type = "Factory",
    des = "国语",
    arg0 = "SoundFactory"
  },
  {
    name = "Audio2",
    type = "Factory",
    des = "日语",
    arg0 = "SoundFactory"
  },
  {
    name = "UnlockLevel",
    type = "Int",
    des = "解锁等级",
    arg0 = "1"
  },
  {
    name = "StoryText",
    type = "TextT",
    des = "文本",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "角色档案",
    name = "BattleAudio",
    type = "Array",
    des = "战斗内语音",
    pyIgnore = true
  },
  {
    name = "AudioType",
    type = "Enum",
    des = "语音类型||Attack:出击,#Advance:前进,#SkillS:必杀,#Defeat:战败,#Mvp:MVP",
    arg0 = "Attack#Advance#SkillS#Defeat#Mvp",
    arg1 = "Attack",
    pyIgnore = true
  },
  {
    name = "AudioName",
    type = "String",
    des = "标题",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "id1",
    type = "Factory",
    des = "国配",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "id2",
    type = "Factory",
    des = "日配",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "StoryText",
    type = "TextT",
    des = "语音文本",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "角色档案",
    name = "",
    type = "SysLine",
    des = "角色故事"
  },
  {
    mod = "角色档案",
    name = "ResumeList",
    type = "Array",
    des = "履历",
    detail = "",
    pyIgnore = true
  },
  {
    name = "des",
    type = "TextT",
    des = "履历文本",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "角色档案",
    name = "StoryList",
    type = "Array",
    des = "角色故事",
    detail = "",
    pyIgnore = true
  },
  {
    name = "Title",
    type = "String",
    des = "标题",
    arg0 = ""
  },
  {
    name = "des",
    type = "TextT",
    des = "文本",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "UnlockLevel",
    type = "Int",
    des = "解锁等级",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "角色档案",
    name = "Restype",
    type = "Array",
    des = "资源状态列表",
    detail = "Language#isExistent",
    pyIgnore = true
  },
  {
    name = "Language",
    type = "String",
    des = "语言",
    arg0 = ""
  },
  {
    name = "isExistent",
    type = "Bool",
    des = "是否有资源",
    arg0 = "True"
  },
  {name = "end"},
  {
    mod = "游乐场",
    name = "investChoose",
    type = "Array",
    des = "投资选择",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "投资id",
    arg0 = "PondFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "角色Spine动画组",
    name = "animList",
    type = "Array",
    des = "动画",
    detail = "name",
    pyIgnore = true
  },
  {
    name = "name",
    type = "String",
    des = "动画名称",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "乘客动画",
    name = "passengerAction1",
    type = "Array",
    des = "左谈话npc",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc行为",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "乘客动画",
    name = "passengerAction2",
    type = "Array",
    des = "右谈话npc",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc行为",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "乘客动画",
    name = "passengerAction3",
    type = "Array",
    des = "跑npc",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc行为",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "乘客动画",
    name = "passengerAction4",
    type = "Array",
    des = "走路npc",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc行为",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "乘客动画",
    name = "passengerAction5",
    type = "Array",
    des = "1站立npc",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc行为",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "乘客动画",
    name = "passengerAction6",
    type = "Array",
    des = "2站立npc",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc行为",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "节日奖励",
    name = "FestivalReward",
    type = "Array",
    des = "奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励ID",
    arg0 = "ItemFactory#SourceMaterialFactory#HomeFurnitureFactory#PetFactory#HomeGoodsFactory#FridgeItemFactory#EquipmentFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "奖励数量",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "角色换装动画",
    name = "frontAnimList",
    type = "Array",
    des = "正面换装动画",
    detail = "animName",
    pyIgnore = true
  },
  {
    name = "animName",
    type = "String",
    des = "动画名称",
    arg0 = "dorm_stand"
  },
  {name = "end"},
  {
    mod = "角色换装动画",
    name = "backAnimList",
    type = "Array",
    des = "背面换装动画",
    detail = "animName",
    pyIgnore = true
  },
  {
    name = "animName",
    type = "String",
    des = "动画名称",
    arg0 = "dorm_stand_back"
  },
  {name = "end"},
  {
    mod = "帮助",
    name = "helpTitle",
    type = "Factory",
    des = "帮助标题",
    arg0 = "TextFactory"
  },
  {
    mod = "帮助",
    name = "help",
    type = "Array",
    des = "页签和内容",
    detail = "tadId#txtId"
  },
  {
    name = "tadId",
    type = "Factory",
    des = "页签id",
    arg0 = "TextFactory"
  },
  {
    name = "txtId",
    type = "Factory",
    des = "文本id",
    arg0 = "TextFactory"
  },
  {name = "end"},
  {
    mod = "路线插针",
    name = "distance",
    type = "Int",
    des = "距离",
    arg0 = "0"
  },
  {
    mod = "诱饵气球",
    name = "balloonList",
    type = "Array",
    des = "气球配置",
    detail = "ratio"
  },
  {
    name = "ratio",
    type = "Double",
    des = "概率",
    arg0 = "0",
    pythonName = "id"
  },
  {name = "end"},
  {
    mod = "固定污染",
    name = "polluteRegularList",
    type = "Array",
    des = "区域及污染",
    detail = "id#index"
  },
  {
    name = "id",
    type = "Factory",
    des = "区域id",
    arg0 = "AreaFactory"
  },
  {
    name = "index",
    type = "Int",
    des = "污染等级",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "武装列表",
    name = "trainWeaponList",
    type = "Array",
    des = "制造列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "武装",
    arg0 = "HomeWeaponFactory"
  },
  {name = "end"},
  {
    mod = "活动相关",
    name = "achievementList",
    type = "Array",
    des = "活动成就列表",
    detail = "id#icon#englishPic"
  },
  {
    name = "id",
    type = "Factory",
    des = "活动成就",
    arg0 = "QuestFactory",
    arg1 = "活动任务"
  },
  {
    name = "icon",
    type = "Png",
    des = "贸易成就图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "englishPic",
    type = "Png",
    des = "英文装饰",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "等级相关",
    name = "lvList",
    type = "Array",
    des = "等级列表",
    detail = "lv"
  },
  {
    name = "lv",
    type = "Int",
    des = "等级",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "收集卡相关",
    name = "packList",
    type = "Array",
    des = "卡包列表",
    detail = "packId#name#png"
  },
  {
    name = "packId",
    type = "Factory",
    des = "列表id",
    arg0 = "ListFactory",
    arg1 = "收集卡相关"
  },
  {
    name = "name",
    type = "String",
    des = "卡包名称",
    arg0 = ""
  },
  {
    name = "png",
    type = "Png",
    des = "背景图",
    arg0 = "",
    arg1 = "100|100"
  },
  {name = "end"},
  {
    mod = "收集卡相关",
    name = "collectionCardList",
    type = "Array",
    des = "收集卡列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "收集卡id",
    arg0 = "CollectionCardFactory"
  },
  {name = "end"}
})
