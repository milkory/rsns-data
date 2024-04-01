RegProperty("UnitViewFactory", {
  {
    mod = "",
    name = "character",
    type = "Factory",
    des = "对应角色",
    arg0 = "UnitFactory"
  },
  {
    mod = "",
    name = "SkinName",
    type = "String",
    des = "皮肤名字",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "quality",
    type = "Enum",
    des = "品质||White:白,Blue:蓝,Purple:紫,Golden:金,Orange:橙",
    arg0 = "White#Blue#Purple#Golden#Orange",
    arg1 = "White",
    pyIgnore = true
  },
  {
    mod = "",
    name = "isSpine2",
    type = "Int",
    des = "是否有精二 ",
    arg0 = "1",
    pyIgnore = true
  },
  {
    mod = "",
    name = "SkinDesc",
    type = "Text",
    des = "皮肤描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "HomeresDir",
    type = "String",
    des = "家园Q版资源路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "获取途径"
  },
  {
    mod = "",
    name = "GetWay",
    type = "String",
    des = "途径",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "立绘偏移",
    pyIgnore = true
  },
  {
    name = "offsetX",
    type = "Double",
    des = "精一立绘X轴",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "offsetY",
    type = "Double",
    des = "精一立绘Y轴",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "offsetScale",
    type = "Double",
    des = "精一立绘缩放",
    arg0 = "1.0",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "精二立绘偏移",
    pyIgnore = true
  },
  {
    name = "offsetX2",
    type = "Double",
    des = "精二立绘X轴",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "offsetY2",
    type = "Double",
    des = "精二立绘Y轴",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "编队界面偏移",
    pyIgnore = true
  },
  {
    name = "squadsX",
    type = "Double",
    des = "编队X轴",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "squadsY",
    type = "Double",
    des = "编队Y轴",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "Spine偏移",
    pyIgnore = true
  },
  {
    name = "spineX",
    type = "Double",
    des = "精一SpineX轴",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "spineY",
    type = "Double",
    des = "精一SpineY轴",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "spineScale",
    type = "Double",
    des = "精一Spine缩放",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "squadsHalf1",
    type = "String",
    des = "编队半身精一",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "clickAnimationList",
    type = "Array",
    des = "点击动画列表",
    detail = "name#weight#needAlphaChange",
    pyIgnore = true
  },
  {
    name = "name",
    type = "String",
    des = "动画名称",
    arg0 = "click",
    pyIgnore = true
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "needAlphaChange",
    type = "Bool",
    des = "需要过渡",
    arg0 = "False",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "Spine背景",
    pyIgnore = true
  },
  {
    name = "SpineBackground",
    type = "String",
    des = "皮肤背景",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "SpineBGX",
    type = "Double",
    des = "皮肤背景x位置",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "SpineBGY",
    type = "Double",
    des = "皮肤背景y位置",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "SpineBGScale",
    type = "Double",
    des = "皮肤背景缩放",
    arg0 = "0.01",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "精二",
    pyIgnore = true
  },
  {
    mod = "",
    name = "State2Name",
    type = "String",
    des = "精二皮肤名",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "State2Desc",
    type = "Text",
    des = "精二皮肤描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "State2Face",
    type = "String",
    des = "精二头像",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "State2Gacha",
    type = "String",
    des = "精二抽卡头像",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "State2Res",
    type = "String",
    des = "精二立绘",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "State2RoleListRes",
    type = "String",
    des = "精二半身像",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "squadsHalf2",
    type = "String",
    des = "编队半身精二",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "gachaSpine2Url",
    type = "String",
    des = "精二Spine素材",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "spine2Url",
    type = "String",
    des = "精二U3D素材",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "gachaPerformUrl",
    type = "String",
    des = "抽卡演出动画",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "spine2EffectUrl",
    type = "String",
    des = "精二特效素材",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "spine2BgUrl",
    type = "String",
    des = "精二背景素材",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "state2Overturn",
    type = "Bool",
    des = "精二翻转",
    arg0 = "False",
    pyIgnore = true
  },
  {
    name = "spine2Scale",
    type = "Double",
    des = "精二缩放",
    arg0 = "125",
    pyIgnore = true
  },
  {
    name = "spine2X",
    type = "Double",
    des = "精二spineX轴",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "spine2Y",
    type = "Double",
    des = "精二spineY轴",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "",
    type = "SysLine",
    des = "头像",
    pyIgnore = true
  },
  {
    name = "profilePhotoID",
    type = "Factory",
    des = "激活头像",
    arg0 = "ProfilePhotoFactory"
  },
  {
    name = "State2profilePhotoID",
    type = "Factory",
    des = "精二激活头像",
    arg0 = "ProfilePhotoFactory",
    pyIgnore = true
  },
  {
    name = "rewardList",
    type = "Array",
    des = "重复获得转化"
  },
  {
    name = "id",
    type = "Factory",
    des = "道具",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "数量",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "",
    name = "iconPath",
    type = "Png",
    des = "道具图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "",
    name = "tipsPath",
    type = "Png",
    des = "详情图标",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "大头贴机头像",
    pyIgnore = true
  },
  {
    mod = "",
    name = "ProfilePhotoList",
    type = "Array",
    des = "头像列表",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "头像",
    arg0 = "ProfilePhotoFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "图鉴立绘",
    pyIgnore = true
  },
  {
    name = "bookHalf",
    type = "String",
    des = "图鉴半身像",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "bookFull",
    type = "String",
    des = "图鉴全身像",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "",
    name = "",
    type = "SysLine",
    des = "图鉴全身偏移",
    pyIgnore = true
  },
  {
    name = "bookX",
    type = "Double",
    des = "图鉴全身X轴",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "bookY",
    type = "Double",
    des = "图鉴全身Y轴",
    arg0 = "0",
    pyIgnore = true
  }
})
