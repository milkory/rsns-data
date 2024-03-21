RegProperty("NPCFactory", {
  {
    name = "name",
    type = "String",
    des = "名字",
    arg0 = ""
  },
  {
    name = "spineUrl",
    type = "String",
    des = "Spine",
    arg0 = ""
  },
  {
    name = "spineOffsetX",
    type = "Double",
    des = "SpineX轴偏移",
    arg0 = "0"
  },
  {
    name = "spineOffsetY",
    type = "Double",
    des = "SpineY轴偏移",
    arg0 = "0"
  },
  {
    name = "spineScale",
    type = "Double",
    des = "Spine缩放",
    arg0 = "1"
  },
  {
    name = "resUrl",
    type = "Png",
    des = "立绘",
    arg0 = "",
    arg1 = "300|300"
  },
  {
    name = "offsetX",
    type = "Double",
    des = "立绘X轴偏移",
    arg0 = "0"
  },
  {
    name = "offsetY",
    type = "Double",
    des = "立绘Y轴偏移",
    arg0 = "0"
  },
  {
    mod = "交易所",
    name = "qResUrl",
    type = "Png",
    des = "Q版（临时）",
    arg0 = "",
    arg1 = "300|300"
  },
  {
    name = "",
    type = "SysLine",
    des = "台词"
  },
  {
    name = "enterText",
    type = "Array",
    des = "打开界面",
    detail = "id#weight#reputation#activityId#startTime#endTime"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {
    name = "activityId",
    type = "Factory",
    des = "在活动期间显示|活动ID",
    arg0 = "ActivityFactory"
  },
  {
    name = "startTime",
    type = "String",
    des = "开始时间|与活动时间互斥",
    arg0 = ""
  },
  {
    name = "endTime",
    type = "String",
    des = "结束时间|与活动时间互斥",
    arg0 = ""
  },
  {name = "end"},
  {
    name = "talkText",
    type = "Array",
    des = "交谈",
    detail = "id#weight#reputation#activityId#startTime#endTime"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {
    name = "activityId",
    type = "Factory",
    des = "在活动期间显示|活动ID",
    arg0 = "ActivityFactory"
  },
  {
    name = "startTime",
    type = "String",
    des = "开始时间|与活动时间互斥",
    arg0 = ""
  },
  {
    name = "endTime",
    type = "String",
    des = "结束时间|与活动时间互斥",
    arg0 = ""
  },
  {name = "end"},
  {
    name = "UseItem",
    type = "Array",
    des = "使用道具",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    name = "ItemText",
    type = "Array",
    des = "道具不足文本",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "商会",
    name = "questListText",
    type = "Array",
    des = "打开任务列表",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "商会",
    name = "questListNullText",
    type = "Array",
    des = "任务列表为空",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "商会",
    name = "acceptQuestText",
    type = "Array",
    des = "接受任务",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "商会",
    name = "cancelQuestText",
    type = "Array",
    des = "取消任务",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "商会",
    name = "addQuestSuccessText",
    type = "Array",
    des = "添加任务成功",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "商会",
    name = "notEnoughText",
    type = "Array",
    des = "道具不足",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "酒吧",
    name = "drinkText",
    type = "Array",
    des = "成功喝酒文本",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "酒吧",
    name = "StoreText",
    type = "Array",
    des = "浏览黑市文本",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "酒吧",
    name = "OneText",
    type = "Array",
    des = "喝一杯文本",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "酒吧",
    name = "upperText",
    type = "Array",
    des = "上限后文本",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "治安中心",
    name = "levelListText",
    type = "Array",
    des = "浏览关卡文本",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "治安中心",
    name = "enterOfferText",
    type = "Array",
    des = "进入悬赏关文本",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "治安中心",
    name = "notEnterOfferText",
    type = "Array",
    des = "不可进入悬赏关文本",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "tabBuyText",
    type = "Array",
    des = "打开购买页签",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "tabSellText",
    type = "Array",
    des = "打开出售页签",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "buyDownText",
    type = "Array",
    des = "将打折商品加入预购",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "buyUpText",
    type = "Array",
    des = "将涨价商品加入预购",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "buyFlatText",
    type = "Array",
    des = "将原价商品加入预购",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "cancelBuyText",
    type = "Array",
    des = "将物品从预购中取消",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "buySuccessText",
    type = "Array",
    des = "购买成功",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "sellDownText",
    type = "Array",
    des = "将折扣商品加入预出售",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "sellUpText",
    type = "Array",
    des = "将涨价商品加入预出售",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "sellFlatText",
    type = "Array",
    des = "将原价商品加入预出售",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "cancelSellText",
    type = "Array",
    des = "将物品从预出售中取消",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "sellSuccessText",
    type = "Array",
    des = "出售成功",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "haggleSuccessText",
    type = "Array",
    des = "砍价成功",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "haggleFailText",
    type = "Array",
    des = "砍价失败",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "raiseSuccessText",
    type = "Array",
    des = "抬价成功",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "raiseFailText",
    type = "Array",
    des = "抬价失败",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "openWarehouseText",
    type = "Array",
    des = "打开仓库",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "buySettlementText",
    type = "Array",
    des = "买入结算",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "交易所",
    name = "sellSettlementText",
    type = "Array",
    des = "卖出结算",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "市政厅",
    name = "investText",
    type = "Array",
    des = "投资对话",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "市政厅",
    name = "investOneText",
    type = "Array",
    des = "投资（10w）",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "市政厅",
    name = "investTwoText",
    type = "Array",
    des = "投资（20w）",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "市政厅",
    name = "investThreeText",
    type = "Array",
    des = "投资（30w）",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "市政厅",
    name = "investFourText",
    type = "Array",
    des = "投资（40w）",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "市政厅",
    name = "investFiveText",
    type = "Array",
    des = "投资（50w）",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "市政厅",
    name = "investSixText",
    type = "Array",
    des = "投资（100w）",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "宠物店",
    name = "animalStoreText",
    type = "Array",
    des = "打开买卖界面",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "宠物店",
    name = "petStoreText",
    type = "Array",
    des = "打开宠物店页签",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "宠物店",
    name = "plantStoreText",
    type = "Array",
    des = "打开植物店页签",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "宠物店",
    name = "fishStoreText",
    type = "Array",
    des = "打开水族店页签",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "宠物店",
    name = "petStuffStoreText",
    type = "Array",
    des = "打开宠物用品店页签",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "宠物店",
    name = "petSellText",
    type = "Array",
    des = "宠物回收商店",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "宠物店",
    name = "plantSellText",
    type = "Array",
    des = "植物回收商店",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "宠物店",
    name = "fishSellText",
    type = "Array",
    des = "水族回收商店",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "宠物店",
    name = "petStuffSellText",
    type = "Array",
    des = "宠物用品回收商店",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "tabBattleText",
    type = "Array",
    des = "打开作战计划页签",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "tabOrderText",
    type = "Array",
    des = "打开物资运输页签",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "orderSuccessText",
    type = "Array",
    des = "成功交付",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "signText",
    type = "Array",
    des = "标记订单",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "cancelSignText",
    type = "Array",
    des = "取消标记",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "discardText",
    type = "Array",
    des = "丢弃",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "垃圾站",
    name = "enterRecycleText",
    type = "Array",
    des = "进入回收界面",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "垃圾站",
    name = "recycleSuccessText",
    type = "Array",
    des = "成功回收",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "垃圾站",
    name = "rewardGetText",
    type = "Array",
    des = "任务奖励领取",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心,兑换站",
    name = "enterExchangeText",
    type = "Array",
    des = "进入兑换界面",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "enterSaleText",
    type = "Array",
    des = "进入出售界面",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心,兑换站",
    name = "exchangeSuccessText",
    type = "Array",
    des = "成功兑换",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "作战中心",
    name = "saleSuccessText",
    type = "Array",
    des = "成功出售",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "播放文本",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "所需声望等级",
    arg0 = "0"
  },
  {name = "end"}
})
