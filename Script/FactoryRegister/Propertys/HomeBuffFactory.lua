RegProperty("HomeBuffFactory", {
  {
    name = "name",
    type = "StringT",
    des = "技能名",
    arg0 = ""
  },
  {
    name = "desc",
    type = "TextT",
    des = "技能描述",
    arg0 = ""
  },
  {
    mod = "喝酒相关",
    name = "intensifyDesc",
    type = "TextT",
    des = "强化技能描述",
    arg0 = ""
  },
  {
    mod = "喝酒相关",
    name = "buffType",
    type = "Enum",
    des = "喝酒Buff类型",
    arg0 = "AddSpeed#HaggleSuccessRate#RiseSuccessRate#HaggleRange#RiseRange#AddHaggleNum#AddRiseNum#AddQty#AddSpecQty#AddSuccessRate#ReduceBargainFailEnergy#AddTrust#AddSpeedPercentage",
    arg1 = "HaggleSuccessRate"
  },
  {
    mod = "议价道具",
    name = "buffType",
    type = "Enum",
    des = "Buff类型||AddSuccessRate:增加议价成功率,OneOfUs:下次议价直接达到上限,AddBargainNum:增加议价次数",
    arg0 = "AddSuccessRate#OneOfUs#AddBargainNum",
    arg1 = "AddSuccessRate"
  },
  {
    mod = "喝酒相关,议价道具,活动buff",
    name = "param",
    type = "Double",
    des = "参数",
    arg0 = "0"
  },
  {
    mod = "喝酒相关",
    name = "intensifyParam",
    type = "Double",
    des = "强化后参数",
    arg0 = "0"
  },
  {
    mod = "队员默契",
    name = "buffType",
    type = "Enum",
    des = "Buff类型",
    arg0 = "AddTrust"
  },
  {
    mod = "队员默契",
    name = "indexTrust",
    type = "Double",
    des = "默契系数",
    arg0 = "0.12"
  },
  {
    mod = "列车加速",
    name = "buffType",
    type = "Enum",
    des = "Buff类型",
    arg0 = "AddSpeedPercentage#AccelerationBrakingPerformance"
  },
  {
    mod = "列车加速",
    name = "indexSpeedMin",
    type = "Double",
    des = "最小加速浮动值",
    arg0 = "0.4"
  },
  {
    mod = "列车加速",
    name = "indexSpeedMax",
    type = "Double",
    des = "最大加速浮动值",
    arg0 = "0.6"
  },
  {
    mod = "战斗buff",
    name = "buffType",
    type = "Enum",
    des = "Buff类型",
    arg0 = "HomeBattleBuff"
  },
  {
    mod = "战斗buff",
    name = "battleBuff",
    type = "Factory",
    des = "战斗buff",
    arg0 = "SkillFactory"
  },
  {
    name = "continueTime",
    type = "Int",
    des = "持续时间(秒)",
    arg0 = "1800"
  },
  {
    mod = "活动buff",
    name = "buffType",
    type = "Enum",
    des = "Buff类型||AddQty:增加买入数量,TaxCuts:减少税收",
    arg0 = "AddQty#TaxCuts",
    arg1 = "AddQty"
  },
  {
    mod = "活动buff",
    name = "goodsList",
    type = "Array",
    des = "货物列表",
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
    mod = "活动buff",
    name = "endTime",
    type = "String",
    des = "结束时间",
    arg0 = ""
  }
})
