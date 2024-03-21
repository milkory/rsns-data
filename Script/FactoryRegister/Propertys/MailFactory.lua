RegProperty("MailFactory", {
  {
    name = "title",
    type = "StringT",
    des = "主题",
    arg0 = ""
  },
  {
    name = "content",
    type = "TextT",
    des = "正文",
    arg0 = ""
  },
  {
    name = "addresser",
    type = "StringT",
    des = "发件人",
    arg0 = ""
  },
  {
    mod = "",
    name = "rewards",
    type = "Array",
    des = "奖励",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "物品",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#HomeCharacterSkinFactory#ProfilePhotoFactory#UnitViewFactory#HomeFurnitureFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    name = "containEquipment",
    type = "Bool",
    des = "奖励中包含装备",
    arg0 = "False"
  },
  {
    name = "keepDays",
    type = "Int",
    des = "保存天数",
    arg0 = "15"
  },
  {
    mod = "补偿邮件",
    name = "start_Lv",
    type = "Int",
    des = "开始等级",
    arg0 = "1"
  },
  {
    mod = "补偿邮件",
    name = "end_Lv",
    type = "Int",
    des = "结束等级",
    arg0 = "100"
  },
  {
    mod = "补偿邮件",
    name = "questId",
    type = "Factory",
    des = "完成任务",
    arg0 = "QuestFactory"
  },
  {
    mod = "补偿邮件",
    name = "startTime",
    type = "String",
    des = "开始时间",
    arg0 = ""
  },
  {
    mod = "补偿邮件,事件邮件",
    name = "endTime",
    type = "String",
    des = "结束时间",
    arg0 = ""
  },
  {
    mod = "基础邮件",
    name = "addresserPath",
    type = "Png",
    des = "发件人头像",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "事件邮件",
    name = "eventType",
    type = "Enum",
    des = "邮件事件类型||Null,upUID:上传UID",
    arg0 = "Null#upUID",
    arg1 = "Null"
  },
  {
    mod = "事件邮件",
    name = "nameBtn",
    type = "StringT",
    des = "按钮名称",
    arg0 = ""
  }
})
