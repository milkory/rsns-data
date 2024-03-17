RegProperty("BookFactory", {
  {
    mod = "角色图鉴",
    name = "unitList",
    type = "Array",
    des = "队员列表",
    detail = "id#serialNum#enemyName"
  },
  {
    name = "id",
    type = "Factory",
    des = "队员ID",
    arg0 = "UnitFactory"
  },
  {
    name = "serialNum",
    type = "String",
    des = "序号",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "插画图鉴",
    name = "pictureList",
    type = "Array",
    des = "插画列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "插画ID",
    arg0 = "PictureFactory"
  },
  {name = "end"},
  {
    mod = "音乐图鉴",
    name = "musicList",
    type = "Array",
    des = "音乐列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "插画ID",
    arg0 = "SoundFactory"
  },
  {name = "end"},
  {
    mod = "照片图鉴",
    name = "postcardList",
    type = "Array",
    des = "照片列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "照片ID",
    arg0 = "ItemFactory"
  },
  {name = "end"},
  {
    mod = "录像图鉴",
    name = "videoList",
    type = "Array",
    des = "录像列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "录像ID",
    arg0 = "ItemFactory"
  },
  {name = "end"},
  {
    mod = "磁带图鉴",
    name = "soundList",
    type = "Array",
    des = "磁带列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "磁带ID",
    arg0 = "ItemFactory"
  },
  {name = "end"},
  {
    mod = "头像",
    name = "profilePhotoList",
    type = "Array",
    des = "头像列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "头像ID",
    arg0 = "ProfilePhotoFactory"
  },
  {name = "end"}
})
