RegProperty("HomeGoodsQuotationFactory", {
  {
    name = "goodsId",
    type = "Factory",
    des = "货物",
    arg0 = "HomeGoodsFactory",
    arg1 = "基础货物"
  },
  {
    name = "price",
    type = "Int",
    des = "基础价格",
    arg0 = "100"
  },
  {
    name = "minQuotation",
    type = "Double",
    des = "最低行情",
    arg0 = "0.8"
  },
  {
    name = "maxQuotation",
    type = "Double",
    des = "最高行情",
    arg0 = "1.2"
  },
  {
    name = "num",
    type = "Int",
    des = "基础数量",
    arg0 = "100"
  },
  {
    name = "stockMultipleMin",
    type = "Int",
    des = "库存倍率下限",
    arg0 = "20"
  },
  {
    name = "stockMultipleMax",
    type = "Int",
    des = "库存倍率上限",
    arg0 = "20"
  },
  {
    name = "isSudden",
    type = "Bool",
    des = "暴涨暴跌",
    arg0 = "False"
  },
  {
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    name = "needDevelopNum",
    type = "Int",
    des = "刷新要求（发展度）",
    arg0 = "0"
  },
  {
    name = "needItem",
    type = "Factory",
    des = "可购买投资货币要求",
    arg0 = "ItemFactory"
  },
  {
    name = "needItemNum",
    type = "Int",
    des = "可购买投资货币数量要求",
    arg0 = "0"
  }
})
