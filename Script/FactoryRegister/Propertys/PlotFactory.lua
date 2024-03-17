RegProperty("PlotFactory", {
  {
    mod = "剧情回顾",
    name = "MainTitle",
    type = "String",
    des = "大章标题",
    arg0 = ""
  },
  {
    mod = "剧情回顾",
    name = "TitleEN",
    type = "String",
    des = "英文标题",
    arg0 = ""
  },
  {
    mod = "剧情回顾",
    name = "MaleVideo",
    type = "Factory",
    des = "男主视频",
    arg0 = "VideoFactory"
  },
  {
    mod = "剧情回顾",
    name = "FemaleVideo",
    type = "Factory",
    des = "女主视频",
    arg0 = "VideoFactory"
  },
  {
    mod = "剧情回顾",
    name = "CoverPage",
    type = "Png",
    des = "封面小图",
    arg0 = ""
  },
  {
    mod = "剧情回顾",
    name = "IncludeStories",
    type = "Array",
    des = "包含内容"
  },
  {
    name = "SecTitle",
    type = "String",
    des = "小章标题",
    arg0 = ""
  },
  {
    name = "Picture",
    type = "Png",
    des = "人物头像",
    arg0 = ""
  },
  {
    name = "SecTitleDesc",
    type = "Text",
    des = "小章简介",
    arg0 = ""
  },
  {
    name = "IncludeParagraph",
    type = "Factory",
    des = "选择段落",
    arg0 = "ListFactory",
    arg1 = "段落"
  },
  {
    name = "UnlockOption",
    type = "Factory",
    des = "解锁条件",
    arg0 = "ParagraphFactory",
    arg1 = "剧情回顾段落"
  },
  {name = "end"},
  {
    mod = "景点剧情",
    name = "Desc",
    type = "String",
    des = "文本内容",
    arg0 = ""
  },
  {
    mod = "景点剧情",
    name = "Character",
    type = "String",
    des = "角色名称",
    arg0 = ""
  },
  {
    mod = "景点剧情",
    name = "Avatar",
    type = "Png",
    des = "角色头像",
    arg0 = ""
  },
  {
    mod = "景点剧情",
    name = "FadeInFrame",
    type = "Int",
    des = "淡入帧数",
    arg0 = "60"
  },
  {
    mod = "景点剧情",
    name = "KeepFrame",
    type = "Int",
    des = "持续帧数",
    arg0 = "300"
  },
  {
    mod = "景点剧情",
    name = "FadeOutFrame",
    type = "Int",
    des = "淡出帧数",
    arg0 = "60"
  }
})
