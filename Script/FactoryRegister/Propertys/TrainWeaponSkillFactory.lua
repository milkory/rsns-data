RegProperty("TrainWeaponSkillFactory", {
  {
    mod = "",
    name = "name",
    type = "StringT",
    des = "词条名称",
    arg0 = ""
  },
  {
    mod = "",
    name = "text",
    type = "TextT",
    des = "词条文本",
    arg0 = ""
  },
  {
    mod = "",
    name = "entryTag",
    type = "Factory",
    des = "词条类型",
    arg0 = "TagFactory"
  },
  {
    mod = "固定词条",
    name = "Constant",
    type = "Double",
    des = "参数1",
    arg0 = "0"
  },
  {
    mod = "",
    name = "randomConstant",
    type = "Double",
    des = "常量参数1|用于成长或随机词条中，不成长也不随机的数值",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "levelMax",
    type = "Int",
    des = "满级等级",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "",
    type = "SysLine",
    des = "数值A"
  },
  {
    mod = "成长词条",
    name = "aType",
    type = "Enum",
    des = "A数值类型",
    arg0 = "一般型#百分比型",
    arg1 = "一般型"
  },
  {
    mod = "成长词条",
    name = "aDevelopment",
    type = "Bool",
    des = "A是否成长",
    arg0 = "false"
  },
  {
    mod = "成长词条",
    name = "",
    type = "SysLine",
    des = "数值A一般型"
  },
  {
    mod = "成长词条",
    name = "aNumMin",
    type = "Double",
    des = "A初始数值",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "aUpgradeRange",
    type = "Double",
    des = "A升级幅度",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "aNumMax",
    type = "Double",
    des = "A满级数值",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "aCommonNum",
    type = "Double",
    des = "A展示系数",
    arg0 = "1"
  },
  {
    mod = "成长词条",
    name = "",
    type = "SysLine",
    des = "数值A百分比型"
  },
  {
    mod = "成长词条",
    name = "aNumMinP",
    type = "Double",
    des = "A初始数值P",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "aUpgradeRangeP",
    type = "Double",
    des = "A升级幅度P",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "aNumMaxP",
    type = "Double",
    des = "A满级数值P",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "aCommonNumP",
    type = "Double",
    des = "A展示系数P",
    arg0 = "1"
  },
  {
    mod = "成长词条",
    name = "",
    type = "SysLine",
    des = "数值B"
  },
  {
    mod = "成长词条",
    name = "bType",
    type = "Enum",
    des = "B数值类型",
    arg0 = "一般型#百分比型",
    arg1 = "一般型"
  },
  {
    mod = "成长词条",
    name = "bDevelopment",
    type = "Bool",
    des = "B是否成长",
    arg0 = "false"
  },
  {
    mod = "成长词条",
    name = "",
    type = "SysLine",
    des = "数值B一般型"
  },
  {
    mod = "成长词条",
    name = "bNumMin",
    type = "Double",
    des = "B初始数值",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "bUpgradeRange",
    type = "Double",
    des = "B升级幅度",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "bNumMax",
    type = "Double",
    des = "B满级数值",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "bCommonNum",
    type = "Double",
    des = "B展示系数",
    arg0 = "1"
  },
  {
    mod = "成长词条",
    name = "",
    type = "SysLine",
    des = "数值B百分比"
  },
  {
    mod = "成长词条",
    name = "bNumMinP",
    type = "Double",
    des = "B初始数值P",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "bUpgradeRangeP",
    type = "Double",
    des = "B升级幅度P",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "bNumMaxP",
    type = "Double",
    des = "B满级数值P",
    arg0 = "0"
  },
  {
    mod = "成长词条",
    name = "bCommonNumP",
    type = "Double",
    des = "B展示系数P",
    arg0 = "1"
  },
  {
    mod = "随机词条",
    name = "numberMin",
    type = "Double",
    des = "随机参数最小值",
    arg0 = "0"
  },
  {
    mod = "随机词条",
    name = "numberMax",
    type = "Double",
    des = "随机参数最大值",
    arg0 = "0"
  },
  {
    mod = "随机词条",
    name = "Digit",
    type = "Double",
    des = "精度",
    arg0 = "0"
  },
  {
    mod = "固定词条，随机词条",
    name = "CommonNum",
    type = "Double",
    des = "展示系数",
    arg0 = "1"
  },
  {
    mod = "固定词条",
    name = "numText",
    type = "Factory",
    des = "数值文本",
    arg0 = "TextFactory"
  },
  {
    mod = "成长词条",
    name = "",
    type = "SysLine",
    des = "以下下是战斗相关的配置"
  },
  {
    mod = "成长词条",
    name = "buffType",
    type = "Enum",
    des = "生效类型",
    arg0 = "污染区生效#大世界生效",
    arg1 = "污染区生效"
  },
  {
    mod = "成长词条",
    name = "skillBuff",
    type = "Factory",
    des = "战斗Buff",
    arg0 = "SkillFactory"
  }
})
