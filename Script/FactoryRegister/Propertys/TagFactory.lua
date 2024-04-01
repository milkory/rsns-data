RegProperty("TagFactory", {
  {
    mod = "职业",
    name = "jobDes",
    type = "StringT",
    des = "职业说明",
    arg0 = ""
  },
  {
    mod = "性格",
    name = "characteristic",
    type = "StringT",
    des = "性格",
    arg0 = ""
  },
  {
    mod = "家具",
    name = "furnitures",
    type = "StringT",
    des = "家具",
    arg0 = ""
  },
  {
    mod = "家具类型",
    name = "typeName",
    type = "StringT",
    des = "类型名",
    arg0 = ""
  },
  {
    mod = "家具类型",
    name = "iconPath",
    type = "Png",
    des = "类型图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "车厢类型",
    name = "typeName",
    type = "StringT",
    des = "类型名",
    arg0 = ""
  },
  {
    mod = "车厢类型",
    name = "carriageIcon",
    type = "Png",
    des = "类型图标",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "车厢类型",
    name = "skipJumpIcon",
    type = "Png",
    des = "快捷跳转icon",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "车厢类型",
    name = "stopCarriage",
    type = "Bool",
    des = "是否进入|勾上车厢不可进入",
    arg0 = "false"
  },
  {
    mod = "家具功能类型",
    name = "typeName",
    type = "StringT",
    des = "类型名",
    arg0 = ""
  },
  {
    mod = "容量类型",
    name = "typeName",
    type = "StringT",
    des = "类型名",
    arg0 = ""
  },
  {
    mod = "装备类型",
    name = "typeName",
    type = "Int",
    des = "词缀数量",
    arg0 = "4"
  },
  {
    mod = "装备类型",
    name = "Name",
    type = "StringT",
    des = "装备类型名字",
    arg0 = ""
  },
  {
    mod = "装备类型",
    name = "typeID",
    type = "Int",
    des = "枚举ID",
    arg0 = "4"
  },
  {
    mod = "宠物物种",
    name = "petVarity",
    type = "StringT",
    des = "物种名",
    arg0 = ""
  },
  {
    mod = "宠物品种",
    name = "petSpecies",
    type = "StringT",
    des = "品种名",
    arg0 = ""
  },
  {
    mod = "宠物性格",
    name = "petPersonalityName",
    type = "StringT",
    des = "宠物性格名",
    arg0 = ""
  },
  {
    mod = "宠物性格",
    name = "petLoveUp",
    type = "Double",
    des = "亲密度加成",
    arg0 = "1"
  },
  {
    mod = "宠物性格",
    name = "ties",
    type = "Array",
    des = "羁绊",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "羁绊名",
    arg0 = "TagFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "宠物羁绊",
    name = "tiesName",
    type = "StringT",
    des = "羁绊名",
    arg0 = ""
  },
  {
    mod = "宠物羁绊",
    name = "atkNum",
    type = "Int",
    des = "基础攻击",
    arg0 = "0"
  },
  {
    mod = "宠物羁绊",
    name = "defNum",
    type = "Int",
    des = "基础防御",
    arg0 = "0"
  },
  {
    mod = "宠物羁绊",
    name = "hpNum",
    type = "Int",
    des = "基础血量",
    arg0 = "0"
  },
  {
    mod = "传单地点",
    name = "leafletPlace",
    type = "StringT",
    des = "传单标签名",
    arg0 = ""
  },
  {
    mod = "套餐角色喜好",
    name = "numBuffMember",
    type = "Double",
    des = "默契系数",
    arg0 = "1"
  },
  {
    mod = "乘客",
    name = "leafletPlace",
    type = "StringT",
    des = "乘客区分",
    arg0 = ""
  },
  {
    mod = "服装类型",
    name = "name",
    type = "StringT",
    des = "服装类型",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "服装类型",
    name = "takeOnExtraRemove",
    type = "Array",
    des = "穿上额外脱下服装类型",
    detail = "id",
    arg0 = ""
  },
  {
    name = "id",
    type = "Factory",
    des = "服装类型",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "服装类型",
    name = "selectIconPath",
    type = "String",
    des = "标签选中图片路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "服装类型",
    name = "unSelectIconPath",
    type = "String",
    des = "标签未选中图片路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "服装类型",
    name = "selectIconPathDS",
    type = "String",
    des = "服装店标签选中图片路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "服装类型",
    name = "unSelectIconPathDS",
    type = "String",
    des = "服装店标签未选中图片路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "服装类型",
    name = "animId",
    type = "Factory",
    des = "换装动画",
    arg0 = "ListFactory",
    pyIgnore = true
  },
  {
    mod = "服装类型",
    name = "canTakeOff",
    type = "Bool",
    des = "是否可以脱下",
    arg0 = "False",
    pyIgnore = true
  },
  {
    mod = "淘金投资",
    name = "invest",
    type = "String",
    des = "投资类型",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "淘金投资",
    name = "investName",
    type = "String",
    des = "投资名字",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "淘金投资",
    name = "investIcon",
    type = "String",
    des = "投资小图标",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "淘金投资",
    name = "investEffect",
    type = "String",
    des = "投资特效路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "列车武装",
    name = "entryName",
    type = "String",
    des = "词条名字",
    arg0 = ""
  },
  {
    mod = "列车武装",
    name = "entryDes",
    type = "StringT",
    des = "词条描述",
    arg0 = ""
  },
  {
    mod = "列车武装",
    name = "addNum",
    type = "Bool",
    des = "词条数值是否增加",
    arg0 = "true"
  },
  {
    mod = "CDK兑换码",
    name = "cdkDec",
    type = "String",
    des = "cdk描述",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "敌人定位标签,卡池大保底",
    name = "tagName",
    type = "String",
    des = "名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "卡池大保底",
    name = "recordTips",
    type = "TextT",
    des = "招募记录说明",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "敌人定位标签",
    name = "tagType",
    type = "Enum",
    des = "类型||ability:特殊能力,weakness:弱点,resistance:抗性",
    arg0 = "ability#weakness#resistance",
    pyIgnore = true
  },
  {
    mod = "敌人强度标签",
    name = "enemyTypeName",
    type = "String",
    des = "名称",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "敌人强度标签",
    name = "enemyCardUrl",
    type = "String",
    des = "图鉴卡牌路径",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "敌人强度标签",
    name = "strengthText",
    type = "String",
    des = "强度展示文字",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "阵营",
    name = "nameEnglish",
    type = "String",
    des = "英文名",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "阵营",
    name = "iconPath",
    type = "Png",
    des = "白色icon",
    arg0 = "",
    arg1 = "100 | 100",
    pyIgnore = true
  }
})
