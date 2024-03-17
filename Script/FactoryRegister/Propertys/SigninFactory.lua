RegProperty("SigninFactory", {
  {
    name = "SigninRewardList",
    type = "Array",
    des = "签到列表（新）",
    detail = "id#pngMan#pngWoman"
  },
  {
    name = "id",
    type = "Factory",
    des = "奖励",
    arg0 = "ListFactory"
  },
  {
    name = "pngMan",
    type = "Png",
    des = "素材背景（男）",
    arg0 = "",
    arg1 = "50|50"
  },
  {
    name = "pngWoman",
    type = "Png",
    des = "素材背景（女）",
    arg0 = "",
    arg1 = "50|50"
  },
  {name = "end"}
})
