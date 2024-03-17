RegProperty("ParagraphFactory", {
  {
    name = "completeQuest",
    type = "Factory",
    des = "结束后完成任务",
    arg0 = "QuestFactory",
    pyIgnore = true
  },
  {
    mod = "景点剧情列表",
    name = "DescList",
    type = "Array",
    des = "对话列表",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "景点剧情",
    arg0 = "PlotFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "段落",
    name = "isAuto",
    type = "Bool",
    des = "是否强制自动播放",
    arg0 = "false"
  },
  {
    mod = "段落脚本",
    name = "isAuto",
    type = "Bool",
    des = "是否强制自动播放",
    arg0 = "false"
  },
  {
    name = "showBtnList",
    type = "Bool",
    des = "显示按钮列表|右上角",
    arg0 = "false",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "触发任务"
  },
  {
    name = "triggerQuest",
    type = "Factory",
    des = "结束后触发任务",
    arg0 = "QuestFactory",
    pyIgnore = true
  }
})
