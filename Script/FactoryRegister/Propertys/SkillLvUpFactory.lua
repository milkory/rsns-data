RegProperty("SkillLvUpFactory", {
  {
    name = "levelMax",
    type = "Int",
    des = "最大等级",
    arg0 = "1"
  },
  {
    mod = "",
    name = "unitLevelList",
    type = "Array",
    des = "队员等级条件",
    detail = "level"
  },
  {
    name = "level",
    type = "Int",
    des = "队员等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "",
    name = "materialList",
    type = "Array",
    des = "消耗材料",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "材料列表",
    arg0 = "ListFactory"
  },
  {name = "end"}
})
