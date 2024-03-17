RegProperty("PassageFactory", {
  {
    mod = "基础乘客",
    name = "star",
    type = "Int",
    des = "星级",
    arg0 = "1"
  },
  {
    mod = "基础乘客",
    name = "type",
    type = "String",
    des = "名字",
    arg0 = ""
  },
  {
    mod = "基础乘客",
    name = "gender",
    type = "Factory",
    des = "性别",
    arg0 = "TagFactory"
  },
  {
    mod = "基础乘客",
    name = "career",
    type = "Factory",
    des = "职业",
    arg0 = "TagFactory"
  },
  {
    mod = "基础乘客",
    name = "age",
    type = "Factory",
    des = "年龄",
    arg0 = "TagFactory"
  },
  {
    mod = "基础乘客",
    name = "spineUrl",
    type = "String",
    des = "Spine",
    arg0 = ""
  },
  {
    mod = "基础乘客",
    name = "resUrl",
    type = "Png",
    des = "立绘",
    arg0 = "",
    arg1 = "480|480"
  },
  {
    mod = "基础乘客",
    name = "payNum",
    type = "Int",
    des = "最佳人数/车厢",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "passageDesc",
    type = "Factory",
    des = "乘客描述",
    arg0 = "TextFactory"
  },
  {
    mod = "基础乘客",
    name = "homePassage",
    type = "Factory",
    des = "对应家园角色",
    arg0 = "HomeCharacterFactory"
  },
  {
    mod = "基础乘客",
    name = "waste",
    type = "Double",
    des = "垃圾产出|每公里垃圾产出系数1-3之间",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "tag",
    type = "Array",
    des = "乘客标签",
    detail = "id#weight"
  },
  {
    mod = "基础乘客",
    name = "id",
    type = "Factory",
    des = "标签",
    arg0 = "ListFactory"
  },
  {
    mod = "基础乘客",
    name = "weight",
    type = "Int",
    des = "权重",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "基础乘客",
    name = "",
    type = "SysLine",
    des = "乘客需求"
  },
  {
    mod = "基础乘客",
    name = "comfort",
    type = "Array",
    des = "舒适度基础值|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "基础乘客",
    name = "common",
    type = "Int",
    des = "舒适度基础值",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "most",
    type = "Int",
    des = "舒适度上限值",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "pay",
    type = "Int",
    des = "舒适度消费值",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "out",
    type = "Int",
    des = "舒适度超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "基础乘客",
    name = "plantScores",
    type = "Array",
    des = "绿植评分基础值|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "基础乘客",
    name = "common",
    type = "Int",
    des = "绿植评分基本",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "most",
    type = "Int",
    des = "绿植评分上限",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "pay",
    type = "Int",
    des = "绿植消费值",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "out",
    type = "Int",
    des = "绿植超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "基础乘客",
    name = "fishScores",
    type = "Array",
    des = "水族评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "基础乘客",
    name = "common",
    type = "Int",
    des = "水族评分基本",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "most",
    type = "Int",
    des = "水族评分上限",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "pay",
    type = "Int",
    des = "水族消费值",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "out",
    type = "Int",
    des = "水族超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "基础乘客",
    name = "petScores",
    type = "Array",
    des = "宠物评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "基础乘客",
    name = "common",
    type = "Int",
    des = "宠物评分基础",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "most",
    type = "Int",
    des = "宠物评分上限",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "pay",
    type = "Int",
    des = "宠物消费值",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "out",
    type = "Int",
    des = "宠物超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "基础乘客",
    name = "foodScores",
    type = "Array",
    des = "美味评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "基础乘客",
    name = "common",
    type = "Int",
    des = "美味评分基础",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "most",
    type = "Int",
    des = "美味评分上限",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "pay",
    type = "Int",
    des = "美味消费值",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "out",
    type = "Int",
    des = "美味超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "基础乘客",
    name = "playScores",
    type = "Array",
    des = "娱乐评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "基础乘客",
    name = "common",
    type = "Int",
    des = "娱乐评分基础",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "most",
    type = "Int",
    des = "娱乐评分上限",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "pay",
    type = "Int",
    des = "娱乐消费值",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "out",
    type = "Int",
    des = "娱乐超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "基础乘客",
    name = "medicalScores",
    type = "Array",
    des = "医疗评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "基础乘客",
    name = "common",
    type = "Int",
    des = "医疗评分基础",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "most",
    type = "Int",
    des = "医疗评分上限",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "pay",
    type = "Int",
    des = "医疗消费值",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "out",
    type = "Int",
    des = "医疗超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "基础乘客",
    name = "arm",
    type = "Array",
    des = "武装度评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "基础乘客",
    name = "common",
    type = "Int",
    des = "武装度评分基础",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "most",
    type = "Int",
    des = "武装度评分上限",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "pay",
    type = "Int",
    des = "武装度消费值",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "out",
    type = "Int",
    des = "武装超额需求值",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "基础乘客",
    name = "clean",
    type = "Array",
    des = "清洁度评分基本|上限值，消费金钱产出，超额需求值",
    detail = "common#most#pay#out"
  },
  {
    mod = "基础乘客",
    name = "common",
    type = "Double",
    des = "清洁度评分基础",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "most",
    type = "Double",
    des = "清洁度评分上限",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "pay",
    type = "Double",
    des = "清洁度消费值",
    arg0 = "0"
  },
  {
    mod = "基础乘客",
    name = "out",
    type = "Double",
    des = "清洁度超额需求值",
    arg0 = "0"
  },
  {name = "end"}
})
