RegProperty("AdvLevelFactory", {
  {
    name = "name",
    type = "String",
    des = "名称",
    arg0 = ""
  },
  {
    name = "mapPath",
    type = "String",
    des = "地图数据",
    arg0 = ""
  },
  {
    name = "cost",
    type = "Int",
    des = "体力消耗",
    arg0 = "50"
  },
  {
    name = "minMine",
    type = "Int",
    des = "可挖矿最小次数",
    arg0 = "4"
  },
  {
    name = "maxMine",
    type = "Int",
    des = "可挖矿最大次数",
    arg0 = "8"
  },
  {
    name = "mineReward",
    type = "Array",
    des = "挖矿奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品ID",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "min",
    type = "Int",
    des = "物品最小数量",
    arg0 = "10"
  },
  {
    name = "max",
    type = "Int",
    des = "物品最大数量",
    arg0 = "20"
  },
  {name = "end"}
})
