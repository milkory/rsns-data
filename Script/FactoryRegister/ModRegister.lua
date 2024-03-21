local RegMod = function(factoryName, modNames)
  factory = CS.CBus.Instance:GetFactory(factoryName, false, true)
  if factory ~= nil then
    factory:RegModsOutside(modNames)
  end
end
RegMod("ForgeListFactory", {
  "制作列表"
})
RegMod("ListFactory", {
  "通用物品",
  "通用奖励",
  "消耗相关",
  "角色抽卡相关",
  "掉落相关",
  "商店购买次数奖励",
  "剧情任务",
  "技能BUFF",
  "日常任务",
  "周常任务",
  "巡航事件",
  "签到相关",
  "电力相关",
  "货物",
  "列车武装",
  "主页商店",
  "装备词条",
  "站点区域",
  "声望奖励",
  "TimeLine",
  "NPC对话",
  "喝酒相关",
  "城市地图",
  "投资相关",
  "铁路事件",
  "默认生物",
  "成就相关",
  "治安关卡",
  "车站场景",
  "商会任务",
  "燃油升级",
  "Tag通用",
  "铁路宝箱",
  "作战中心",
  "任务追踪",
  "按钮列表",
  "协议列表",
  "车厢列表",
  "大世界环境",
  "路线事件列表",
  "点击事件列表",
  "乘客标签",
  "票价列表",
  "角色档案",
  "发动机核心",
  "城市地图特效",
  "商品",
  "帮助",
  "路线插针",
  "诱饵气球",
  "杂志视频广告",
  "固定污染",
  "武装列表",
  "手账帮助三级",
  "活动相关",
  "插针小地图坐标",
  "活动跳转相关",
  "等级相关",
  "收集卡相关"
})
RegMod("StoreConditionFactory", {
  "默认条件"
})
RegMod("ConfigFactory", {
  "初始配置",
  "任务完成类型表",
  "日常任务表",
  "随机昵称配置",
  "节假日配置",
  "贸易经验表",
  "家园电力",
  "宠物配置",
  "装备配置",
  "装备数值参数",
  "行情反转概率表",
  "Loading文本",
  "默契相关配置",
  "成就相关",
  "主界面配置",
  "盆栽配置",
  "车厢仓库",
  "剧情回顾列表",
  "功能开启",
  "首次进入引导",
  "职级一览",
  "揽客配置",
  "随机展示列车",
  "大世界环境",
  "大世界污染",
  "素材路径",
  "发动机核心",
  "节日奖励",
  "加载视频",
  "手账帮助",
  "诱饵气球",
  "列车武装",
  "乘客手账",
  "招揽手账",
  "铁盟拖车",
  "交易所",
  "制造家具",
  "活动总览",
  "官方群",
  "渠道商店",
  "行驶辅助配置"
})
RegMod("ExtractFactory", {
  "抽角色配置",
  "家园扭蛋"
})
RegMod("TextFactory", {
  "UI文本",
  "NPC对话",
  "引导提示"
})
RegMod("ItemFactory", {
  "跳转道具",
  "月卡道具",
  "插画",
  "照片",
  "录像",
  "磁带",
  "通行证道具",
  "头像",
  "食材",
  "声望特权",
  "荣誉道具",
  "装备道具",
  "皮肤",
  "任务点道具",
  "捐赠点道具",
  "图纸道具",
  "建设进度",
  "资料道具",
  "战令道具",
  "议价道具",
  "收集卡随机包",
  "活动纪念卡"
})
RegMod("SkillLvUpFactory", {
  "基础升级"
})
RegMod("MailFactory", {
  "基础邮件",
  "补偿邮件",
  "事件邮件"
})
RegMod("BookFactory", {
  "角色图鉴",
  "插画图鉴",
  "音乐图鉴",
  "照片图鉴",
  "录像图鉴",
  "磁带图鉴",
  "头像"
})
RegMod("QuestFactory", {
  "基础任务",
  "订单",
  "站点任务",
  "成就",
  "交货订单",
  "车站月任务",
  "活动任务"
})
RegMod("SourceMaterialFactory", {
  "经验书",
  "突破材料",
  "宠物口粮",
  "宠物好感道具",
  "冰箱材料"
})
RegMod("GuideOrderFactory", {
  "开始战斗",
  "对话",
  "指定位置高亮",
  "关闭指定位置高亮",
  "提示",
  "关闭提示",
  "打开面板",
  "指定关卡居中",
  "点击按钮",
  "设置任务追踪",
  "指定UI高亮",
  "更新引导序号",
  "延迟",
  "设置UI面板",
  "等待帧事件触发",
  "关闭当前界面",
  "返回主界面",
  "关闭UI拖动",
  "清除帧事件缓存",
  "保存面板触发引导序号",
  "检测协议参数",
  "IFELSE跳转",
  "转动视角",
  "关闭转动视角",
  "图片教学",
  "标签",
  "强制开车",
  "完成任务",
  "聚焦家具",
  "聚焦角色并高亮",
  "编队空角色位高亮",
  "相机",
  "聚焦货物并高亮",
  "ScrollView聚焦"
})
RegMod("ChapterFactory", {
  "资源章节"
})
RegMod("StoreFactory", {
  "活动商店",
  "充值商店",
  "家具商店",
  "回收商店",
  "推荐商店"
})
RegMod("ValuableFactory", {
  "基础商品"
})
RegMod("TagFactory", {
  "性格",
  "家具",
  "家具类型",
  "车厢类型",
  "武装类型",
  "家具功能类型",
  "容量类型",
  "装备类型",
  "宠物物种",
  "宠物品种",
  "宠物性格",
  "宠物羁绊",
  "传单地点",
  "套餐角色喜好",
  "乘客",
  "服装类型",
  "淘金投资",
  "卡池大保底",
  "列车武装",
  "CDK兑换码",
  "敌人定位标签",
  "敌人强度标签",
  "收集卡牌类型"
})
RegMod("PictureFactory", {
  "基础插图"
})
RegMod("VideoFactory", {
  "基础视频"
})
RegMod("BattlePassFactory", {"默认"})
RegMod("ProfilePhotoFactory", {
  "基础头像"
})
RegMod("HomeGoodsFactory", {
  "基础货物",
  "垃圾",
  "订单货物"
})
RegMod("HomeStationFactory", {
  "基础车站",
  "垃圾站"
})
RegMod("HomeWeaponFactory", {
  "车厢配件",
  "车厢辅助挂件"
})
RegMod("FoodFactory", {
  "免费工作餐",
  "爱心便当",
  "付费外卖",
  "炸鸡店套餐",
  "冰箱道具"
})
RegMod("PetFactory", {
  "基础宠物"
})
RegMod("GrowthFactory", {
  "家园武装"
})
RegMod("AdvLevelFactory", {"默认"})
RegMod("PetUpgradeFactory", {"默认"})
RegMod("NPCFactory", {
  "站长",
  "商会",
  "市政厅",
  "酒吧",
  "治安中心",
  "交易所",
  "宠物店",
  "垃圾站",
  "作战中心",
  "兑换站",
  "活动"
})
RegMod("DictionaryFactory", {"卡牌", "词缀"})
RegMod("HomeSkillFactory", {
  "基础技能",
  "增加可购买数量",
  "税率减免"
})
RegMod("TimeLineFactory", {"基础TL", "剧情TL"})
RegMod("HomeBuffFactory", {
  "默认",
  "喝酒相关",
  "队员默契",
  "列车加速",
  "议价道具",
  "战斗buff",
  "活动buff"
})
RegMod("HomeCreatureFactory", {"盆栽"})
RegMod("HomeFurnitureFactory", {"花盆"})
RegMod("PlotFactory", {
  "剧情回顾",
  "景点剧情"
})
RegMod("ListFactory", {
  "宠物性格",
  "宠物羁绊",
  "剧情回顾段落",
  "列车长职级",
  "传单地点",
  "资料页签",
  "游乐场",
  "角色Spine动画组",
  "关卡掉落列表",
  "乘客动画",
  "节日奖励",
  "角色换装动画"
})
RegMod("PassageFactory", {
  "基础乘客",
  "唯一乘客"
})
RegMod("RankFactory", {"默认"})
RegMod("BuildingFactory", {
  "动态建筑",
  "作战中心",
  "交易所",
  "商会",
  "铁安局",
  "酒吧",
  "商店",
  "炸鸡店",
  "垃圾站",
  "兑换站",
  "传单地点"
})
RegMod("DataFactory", {
  "默认",
  "手账配置"
})
RegMod("AreaFactory", {
  "路线区域"
})
RegMod("ParagraphFactory", {
  "景点剧情列表"
})
RegMod("HomeGoodsQuotationFactory", {"默认"})
RegMod("ProductionFactory", {
  "默认配方"
})
RegMod("FridgeItemFactory", {"默认"})
RegMod("TrainWeaponSkillFactory", {
  "默认",
  "固定词条",
  "随机词条",
  "成长词条"
})
RegMod("TrainWeaponBulletFactory", {"默认"})
RegMod("EngineCoreFactory", {"默认"})
RegMod("FormulaFactory", {"默认"})
RegMod("HomeCharacterSkinFactory", {"默认", "发型"})
RegMod("PondFactory", {
  "淘金投资",
  "杂志视频广告"
})
RegMod("CdkFactory", {"默认"})
RegMod("HomeFurnitureSkillFactory", {"默认"})
RegMod("COCListFactory", {
  "订单列表"
})
RegMod("ActivityFactory", {
  "签到",
  "红茶活动"
})
RegMod("ActivityListFactory", {
  "城市列表"
})
RegMod("CollectionCardFactory", {
  "活动纪念卡"
})
RegMod("CollectionCardPackFactory", {
  "基础卡包"
})
