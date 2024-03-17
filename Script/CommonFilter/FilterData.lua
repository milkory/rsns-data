local DataModel = {}
DataModel.View = {}
DataModel.SortData = {}
DataModel.FilterData = {}
DataModel.isInit = true
DataModel.FromView = EnumDefine.CommonFilterType.SquadView
DataModel.tempData = {}
DataModel.temp_Filter_Sort_Data = {}
DataModel.callback = nil
DataModel.EnumSort = {
  up_off = 1,
  up_on = 2,
  down_off = 3,
  down_on = 4
}
DataModel.EnumFilter = {open = 1, close = 2}
DataModel.RoleSort = {
  [1] = EnumDefine.SortType.level,
  [2] = EnumDefine.SortType.rarity,
  [3] = EnumDefine.SortType.time,
  [4] = EnumDefine.SortType.filter
}
DataModel.RoleFilter = {
  [1] = {
    name = "职业",
    isImg = false,
    filters = {
      [1] = "全部",
      [2] = "斥候",
      [3] = "盾卫",
      [4] = "辅助",
      [5] = "强击",
      [6] = "战医",
      [7] = "利刃",
      [8] = "哨戒",
      [9] = "先锋",
      [10] = "援击"
    }
  },
  [2] = {
    name = "阵营",
    isImg = false,
    filters = {
      [1] = "全部",
      [2] = "阿妮塔全球能源",
      [3] = "地球联合宪章",
      [4] = "黑月链条",
      [5] = "混响者",
      [6] = "科伦巴商会",
      [7] = "曼杜斯帝国",
      [8] = "铁盟",
      [9] = "学会",
      [10] = "园丁"
    }
  },
  [3] = {
    name = "稀有度",
    isImg = true,
    filters = {
      [1] = "全部",
      [2] = "UI\\Common\\Common_icon_rarity_N_middle",
      [3] = "UI\\Common\\Common_icon_rarity_R_middle",
      [4] = "UI\\Common\\Common_icon_rarity_SR_middle",
      [5] = "UI\\Common\\Common_icon_rarity_SSR_middle"
    }
  }
}
return DataModel
