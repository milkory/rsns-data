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
    des = "技能类型||AddComfort:舒适度,AddPlantScores:绿植评分,AddFishScores:水族评分,AddPetScores:宠物评分,AddFoodScores:美味评分,AddPlayScores:娱乐评分,AddMedicalScores:医疗评分,RiseElectricMax:电力上限,AddPassengerGains:乘客收益",
    arg0 = "AddComfort#AddPlantScores#AddFishScores#AddPetScores#AddFoodScores#AddPlayScores#AddMedicalScores#RiseElectricMax#AddPassengerGains",
    arg1 = "AddComfort"
  },
  {
    mod = "默认",
    name = "param",
    type = "Double",
    des = "参数",
    arg0 = "0"
  }
})
