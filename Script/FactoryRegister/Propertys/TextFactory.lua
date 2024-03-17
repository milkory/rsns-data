RegProperty("TextFactory", {
  {
    mod = "",
    name = "text",
    type = "TextT",
    des = "文本",
    arg0 = ""
  },
  {
    mod = "NPC对话",
    name = "isReplace",
    type = "Bool",
    des = "开启替换",
    arg0 = "False"
  },
  {
    mod = "NPC对话",
    name = "replaceType",
    type = "Enum",
    des = "替换类型||PlayerName:玩家名,BuySuddenRise:买入暴涨,BuySuddenDrop:买入暴跌,SellSuddenRise:卖出暴涨,SellSuddenDrop:卖出暴跌,Drop:购买打折,Rise:出售涨价,RareGoods:稀少交易品",
    arg0 = "PlayerName#BuySuddenRise#BuySuddenDrop#SellSuddenRise#SellSuddenDrop#Rise#Drop#RareGoods",
    arg1 = "PlayerName"
  },
  {
    mod = "NPC对话",
    name = "playerNameString",
    type = "String",
    des = "名字格式",
    arg0 = "{playername}"
  },
  {
    mod = "NPC对话",
    name = "stationString",
    type = "String",
    des = "车站格式",
    arg0 = "{station}"
  },
  {
    mod = "NPC对话",
    name = "goodsString",
    type = "String",
    des = "货物格式",
    arg0 = "{goods}"
  },
  {
    mod = "NPC对话",
    name = "noDataString",
    type = "TextT",
    des = "无数据时文本",
    arg0 = "......"
  },
  {
    mod = "引导提示",
    name = "pfp",
    type = "Png",
    des = "头像",
    arg0 = ""
  }
})
