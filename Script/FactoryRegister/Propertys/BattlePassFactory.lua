RegProperty("BattlePassFactory", {
  {
    name = "topicName",
    type = "String",
    des = "本期bp名",
    arg0 = ""
  },
  {
    name = "topicIcon",
    type = "String",
    des = "本期bp图标",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "topicNameEN",
    type = "String",
    des = "bp英文图标",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "skinIcon",
    type = "String",
    des = "皮肤图标",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "skinNameIcon",
    type = "String",
    des = "皮肤名图标",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "默认",
    name = "PassStartTime",
    type = "String",
    des = "开始时间",
    arg0 = "2022年7月1日0点0分0秒"
  },
  {
    mod = "默认",
    name = "PassEndTime",
    type = "String",
    des = "结束时间",
    arg0 = "2022年7月31日23点59分59秒"
  },
  {
    mod = "",
    name = "LevelLimit",
    type = "Int",
    des = "等级上限"
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "战令档位"
  },
  {
    mod = "",
    name = "bpPrice",
    type = "Array",
    des = "战令档位"
  },
  {
    name = "bpName",
    type = "String",
    des = "该价位名",
    arg0 = ""
  },
  {
    name = "price",
    type = "Int",
    des = "价格",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "付费",
    arg0 = "ValuableFactory"
  },
  {name = "end"},
  {
    mod = "",
    name = "price2",
    type = "Int",
    des = "先低后高价格",
    arg0 = "65"
  },
  {
    mod = "",
    name = "rewardShow",
    type = "Array",
    des = "低价位奖励展示",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#UnitViewFactory#FridgeItemFactory#HomeFurnitureFactory#PetFactory#HomeCharacterSkinFactory",
    pyIgnore = true
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "",
    name = "LowextraReward",
    type = "Array",
    des = "低价位额外奖励",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#FridgeItemFactory#HomeFurnitureFactory#PetFactory#ProfilePhotoFactory#HomeCharacterSkinFactory",
    pyIgnore = true
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "",
    name = "extraReward",
    type = "Array",
    des = "高价位额外奖励",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#FridgeItemFactory#HomeFurnitureFactory#PetFactory#ProfilePhotoFactory#HomeCharacterSkinFactory",
    pyIgnore = true
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    name = "skinThisSeason",
    type = "Factory",
    des = "本期皮肤",
    arg0 = "UnitViewFactory",
    pyIgnore = true
  },
  {
    name = "SpineScale",
    type = "Double",
    des = "皮肤缩放",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "SpineX",
    type = "Double",
    des = "皮肤x位置",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "SpineY",
    type = "Double",
    des = "皮肤y位置",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "SpineBackground",
    type = "String",
    des = "皮肤背景",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "SpineBGX",
    type = "Double",
    des = "皮肤背景x位置",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "SpineBGY",
    type = "Double",
    des = "皮肤背景y位置",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "PlayerSkinM",
    type = "String",
    des = "男列车长皮肤",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "PlayerSkinF",
    type = "String",
    des = "女列车长皮肤",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "background",
    type = "String",
    des = "本期背景",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "买级消耗"
  },
  {
    name = "purchaseBPLevel",
    type = "Array",
    des = "买级消耗",
    arg0 = ""
  },
  {
    name = "id",
    type = "Factory",
    des = "消耗资源",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "消耗数量",
    arg0 = "100"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "DailyQuest",
    type = "Array",
    des = "日常任务"
  },
  {
    name = "BPDailyQuest",
    type = "Factory",
    des = "战令每日任务",
    arg0 = "QuestFactory",
    pythonName = "id"
  },
  {
    name = "QuestSort",
    type = "Int",
    des = "排序优先级",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "weekQuest",
    type = "Array",
    des = "周常任务"
  },
  {
    name = "BPWeeklyQuest",
    type = "Factory",
    des = "战令每周任务",
    arg0 = "QuestFactory",
    pythonName = "id"
  },
  {
    name = "QuestSort",
    type = "Int",
    des = "排序优先级",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "weekQuestList",
    type = "Array",
    des = "周常任务列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "ID",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "PassRewardList",
    type = "Array",
    des = "通行证奖励列表",
    detail = "PassLevel#freeID#freeNum#upgradeID#upgradeNum"
  },
  {
    name = "PassLevel",
    type = "Int",
    des = "通行证等级",
    arg0 = "1"
  },
  {
    name = "freeID",
    type = "Factory",
    des = "免费奖励",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#UnitViewFactory#FridgeItemFactory#HomeFurnitureFactory#PetFactory#HomeCharacterSkinFactory"
  },
  {
    name = "freeNum",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {
    name = "upgradeID",
    type = "Factory",
    des = "付费奖励",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#UnitViewFactory#FridgeItemFactory#HomeFurnitureFactory#PetFactory#HomeCharacterSkinFactory"
  },
  {
    name = "upgradeNum",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "奖励预览"
  },
  {
    name = "RewardPreview",
    type = "Array",
    des = "可预览的等级",
    arg0 = ""
  },
  {
    name = "PreviewLevels",
    type = "Int",
    des = "可预览的等级",
    arg0 = "10"
  },
  {name = "end"},
  {
    mod = "默认",
    name = "Points",
    type = "Int",
    des = "每升一级所需要的邮票值",
    arg0 = "10"
  },
  {
    mod = "默认",
    name = "GapPassRewardList",
    type = "Array",
    des = "通行证空档期奖励列表",
    detail = "PassLevel#freeID#freeNum#upgradeID#upgradeNum"
  },
  {
    name = "GapRewardID",
    type = "Factory",
    des = "奖励",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#FridgeItemFactory#HomeFurnitureFactory#PetFactory#HomeCharacterSkinFactory"
  },
  {
    name = "GapRewardNum",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"}
})
