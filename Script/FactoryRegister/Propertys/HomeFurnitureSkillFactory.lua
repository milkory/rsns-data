RegProperty("HomeFurnitureSkillFactory", {
  {
    mod = "默认",
    name = "isOnly",
    type = "Bool",
    des = "是否唯一",
    arg0 = "False"
  },
  {
    mod = "默认",
    name = "SkillRange",
    type = "Enum",
    des = "效果范围||Carriage:所处车厢,Train:整个火车,Furniture:家具自身",
    arg0 = "Carriage#Train#Furniture",
    arg1 = "Carriage"
  },
  {
    mod = "默认",
    name = "SkillType",
    type = "Enum",
    des = "技能类型||AddComfort:舒适度,AddPlantScores:绿植评分,AddFishScores:水族评分,AddPetScores:宠物评分,AddFoodScores:美味评分,AddPlayScores:娱乐评分,AddMedicalScores:医疗评分,RiseElectricLimited:电力上限,AddPassengerGains:乘客收益",
    arg0 = "AddComfort#AddPlantScores#AddFishScores#AddPetScores#AddFoodScores#AddPlayScores#AddMedicalScores#RiseElectricLimited#AddPassengerGains",
    arg1 = "AddComfort"
  },
  {
    mod = "默认",
    name = "NumType",
    type = "Enum",
    des = "数值类型||percent:百分值,fix:固定值,both:固定值和百分值",
    arg0 = "percent#fix#both",
    arg1 = "percent"
  },
  {
    mod = "默认",
    name = "percent",
    type = "Double",
    des = "百分值",
    arg0 = 0.0
  },
  {
    mod = "默认",
    name = "fix",
    type = "Int",
    des = "固定值",
    arg0 = 0
  }
})
