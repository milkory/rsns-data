RegProperty("COCListFactory", {
  {
    mod = "订单列表",
    name = "starWeightList",
    type = "Array",
    des = "任务星级权重",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Enum",
    des = "任务列表",
    arg0 = "questList1#questList2#questList3#questList4#questList5",
    arg1 = "questList1"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "订单列表",
    name = "questList1",
    type = "Array",
    des = "1星任务列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "订单"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "订单列表",
    name = "questList2",
    type = "Array",
    des = "2星任务列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "订单"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "订单列表",
    name = "questList3",
    type = "Array",
    des = "3星任务列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "订单"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "订单列表",
    name = "questList4",
    type = "Array",
    des = "4星任务列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "订单"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "订单列表",
    name = "questList5",
    type = "Array",
    des = "5星任务列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "任务",
    arg0 = "QuestFactory",
    arg1 = "订单"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"}
})
