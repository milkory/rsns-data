RegProperty("SkillFactory", {
  {
    name = "temptypeStr",
    type = "StringT",
    des = "类型描述|(在这里做修改)",
    arg0 = ""
  },
  {
    name = "typeStr",
    type = "StringT",
    des = "类型描述预览|(请勿修改)",
    arg0 = ""
  },
  {
    name = "typeColor",
    type = "Enum",
    des = "类型颜色",
    arg0 = "Red#Orange#Blue",
    arg1 = "Red"
  },
  {
    name = "CommonNum",
    type = "Double",
    des = "展示系数",
    arg0 = "1"
  },
  {
    name = "floatNum",
    type = "Int",
    des = "保留小数位数",
    arg0 = "1"
  },
  {
    name = "ExSkillList",
    type = "Array",
    des = "衍生技能列表",
    detail = "ExSkillName"
  },
  {
    name = "ExSkillName",
    type = "Factory",
    des = "衍生技能",
    arg0 = "SkillFactory"
  },
  {name = "end"},
  {
    name = "specialTagList",
    type = "Array",
    des = "特殊标签列表",
    detail = "specialTag"
  },
  {
    name = "specialTag",
    type = "Factory",
    des = "特殊标签",
    arg0 = "TagFactory"
  },
  {name = "end"}
})
