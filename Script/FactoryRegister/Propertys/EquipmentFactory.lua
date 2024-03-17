RegProperty("EquipmentFactory", {
  {
    name = "equipTagId",
    type = "Factory",
    des = "装备类型ID",
    arg0 = "TagFactory"
  },
  {
    name = "campTagId",
    type = "Factory",
    des = "阵营ID",
    arg0 = "TagFactory"
  },
  {
    name = "skillList",
    type = "Array",
    des = "固定技能"
  },
  {
    name = "skillId",
    type = "Factory",
    des = "技能",
    arg0 = "SkillFactory",
    pythonName = "id"
  },
  {name = "end"},
  {
    name = "randomSkillList",
    type = "Array",
    des = "随机技能"
  },
  {
    name = "skillId",
    type = "Factory",
    des = "技能",
    arg0 = "SkillFactory#ListFactory",
    pythonName = "id"
  },
  {
    name = "weight",
    type = "Int",
    des = "随机权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "disappearSkillList",
    type = "Array",
    des = "不会出现词缀"
  },
  {
    name = "skillId",
    type = "Factory",
    des = "技能",
    arg0 = "SkillFactory",
    pythonName = "id"
  },
  {name = "end"},
  {
    name = "iconPath",
    type = "Png",
    des = "装备图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "tipsPath",
    type = "Png",
    des = "Tips图标",
    arg0 = "",
    arg1 = "180|180",
    pyIgnore = true
  },
  {
    name = "Getway",
    type = "Array",
    des = "获取途径",
    pyIgnore = true
  },
  {
    name = "funcId",
    type = "Int",
    des = "功能ID",
    arg0 = "-1",
    pyIgnore = true
  },
  {
    name = "FromLevel",
    type = "Factory",
    des = "关卡掉落",
    arg0 = "LevelFactory",
    pyIgnore = true
  },
  {
    name = "DisplayName",
    type = "String",
    des = "显示名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "UIName",
    type = "String",
    des = "UI名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "Way3",
    type = "String",
    des = "程序提供",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true}
})
