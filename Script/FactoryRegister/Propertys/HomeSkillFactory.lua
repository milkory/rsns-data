RegProperty("HomeSkillFactory", {
  {
    name = "name",
    type = "String",
    des = "技能名",
    arg0 = ""
  },
  {
    name = "desc",
    type = "TextT",
    des = "技能描述",
    arg0 = ""
  },
  {
    name = "tag",
    type = "Int",
    des = "标签",
    arg0 = "1"
  },
  {
    name = "sort",
    type = "Int",
    des = "排序权重|越大越靠前",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "homeSkillType",
    type = "Enum",
    des = "生活技能类型||AfterBargainFail:每次议价失败后增加下次议价成功率,FirstBargain:增加每次议价时第1次成功率,AddEnergyMax:增加澄明度上限,ReduceDriveCost:减少列车行驶增加的疲劳值,ReduceEscapeEnergy:减少加速脱离和撞击脱离增加的疲劳值,ReduceCleanCost:洗车费用减免,AddPassengerGains:乘客收益,AddDeterrence:增加威慑度,AddColoudness:增加协响度,ReduceBuyPassCost:减少花钱买路花费,AddBalloonSR:增加诱饵气球成功率,RiseEnergyLimited:增加疲劳值上限,ReducePetFoodConsume:减少宠物口粮消耗",
    arg0 = "HaggleSuccessRate#RiseSuccessRate#HaggleRange#RiseRange#AddHaggleNum#AddRiseNum#AddQty#TaxCuts#OneForAll#AddSpeed#ReduceBargainFailEnergy#RiseGrassOutput#RiseWoodOutput#RiseOreOutput#RiseTrashOutput#AddFemaleGains#AddmaleGains#RiseFliersEffect#RiseWorkshopOutput#RiseCMEffect#RiseFishingRate#RiseReadEffect#RiseFansRate#RiseEnergyLimited#RiseSpaceLimited#RiseFliersSaveLimited#RiseElectricLimited#RiseDurabilityLimited#RiseTrashStagingLimited#RiseRushLimited#AddFishScores#AddPlantScores#AddPetScores#AddFoodScores#AddMedicalScores#AddPlayScores#AddClean#AddComfort#RisePetLoveGains#ReducePetFoodConsume#RiseBentoEnergy#RedueceStrafingEnergy#ReduceEscapeEnergy#ReduceReadEnergy#AutoPickup#ReduceRepairCost#RiseTrainWeaponATK#AfterBargainFail#FirstBargain#AddEnergyMax#ReduceDriveCost#ReduceEscapeEnergy#ReduceCleanCost#AddPassengerGains#AddDeterrence#ReduceBuyPassCost#AddBalloonSR#AddColoudness",
    arg1 = "HaggleSuccessRate"
  },
  {
    name = "",
    type = "SysLine",
    des = "！！！带有+的技能，参数只配增加部分！！！"
  },
  {
    name = "param",
    type = "Double",
    des = "参数",
    arg0 = "0"
  },
  {
    name = "isReplace",
    type = "Bool",
    des = "替换描述中参数",
    arg0 = "True",
    pyIgnore = true
  },
  {
    name = "isPCT",
    type = "Bool",
    des = "百分比",
    arg0 = "True",
    pyIgnore = true
  },
  {
    mod = "增加可购买数量,税率减免",
    name = "city",
    type = "Factory",
    des = "城市",
    arg0 = "HomeStationFactory"
  },
  {
    mod = "增加可购买数量",
    name = "goodsList",
    type = "Array",
    des = "货物列表",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "货物",
    arg0 = "HomeGoodsFactory"
  },
  {name = "end"}
})
