local View = require("UIChapter/UIChapterView")
local DataModel = {}
local SettlementConfig = {}
local interval = 180
SettlementConfig.NumSpeed = interval * 0.5
SettlementConfig.FillSpeed = interval * 1
local Anistate = false
local RoleList = {}
local BattleResult, RoleList
local RewardList = {}
local Data = {}
local UserLevelMaxData, UnitLevelMaxData, ConfigFactory, delay_ani_time
local isGridFinish = false
local Group_PlayerExp, before_lv_ani, now_lv_ani
local now_exp_ani = 0
local before_exp_ani = 0
local show_top_exp_ani, front_exp, diff_exp, temp_lv_ani, levelChain
local module = {}
local RefreshPlayerExp = function(Group_Item)
  local exp = now_exp_ani - before_exp_ani
  if exp <= show_top_exp_ani and isGridFinish == true then
    AniState = false
    return
  end
  local data = UserLevelMaxData
  local levelUpExp
  if data[temp_lv_ani] then
    levelUpExp = data[temp_lv_ani].levelUpExp
  else
    levelUpExp = data[table.count(data)].levelUpExp
  end
  local speed_exp_top_ani = exp / SettlementConfig.NumSpeed
  show_top_exp_ani = math.ceil(show_top_exp_ani + speed_exp_top_ani)
  show_top_exp_ani = exp < show_top_exp_ani and exp or show_top_exp_ani
  if 0 < exp then
    Group_Item.Group_Exp.self:SetActive(true)
    Group_Item.Group_Exp.Txt_Num:SetText(exp < show_top_exp_ani and exp or show_top_exp_ani)
  else
    Group_Item.Group_Exp.self:SetActive(false)
    Group_Item.Group_Exp.Txt_Num:SetText(0)
  end
  if temp_lv_ani > before_lv_ani then
    if levelUpExp <= show_top_exp_ani - front_exp then
      front_exp = front_exp + levelUpExp
      temp_lv_ani = temp_lv_ani + 1
      diff_exp = now_exp_ani - show_top_exp_ani
    end
    if data[temp_lv_ani] then
      levelUpExp = data[temp_lv_ani].levelUpExp
    else
      levelUpExp = data[table.count(data)].levelUpExp
    end
    Group_PlayerExp.Img_Exp.Img_Before:SetFilledImgAmount(0)
    Group_PlayerExp.Img_Exp.Img_Now:SetFilledImgAmount((show_top_exp_ani - front_exp) / levelUpExp)
    local sum = show_top_exp_ani - front_exp
    if sum / levelUpExp == 0 then
      Group_PlayerExp.Img_Exp.Txt_Num:SetText("0%")
    else
      Group_PlayerExp.Img_Exp.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(sum / levelUpExp * 100, 1) .. "%")
    end
  else
    if levelUpExp <= show_top_exp_ani + before_exp_ani then
      front_exp = levelUpExp - before_exp_ani
      temp_lv_ani = temp_lv_ani + 1
      diff_exp = now_exp_ani - show_top_exp_ani
    end
    Group_PlayerExp.Img_Exp.Img_Now:SetFilledImgAmount((show_top_exp_ani + before_exp_ani) / levelUpExp)
    Group_PlayerExp.Img_Exp.Img_Before:SetFilledImgAmount(before_exp_ani / levelUpExp)
    local sum = show_top_exp_ani + before_exp_ani
    Group_PlayerExp.Img_Exp.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(sum / levelUpExp * 100, 1) .. "%")
  end
  Group_PlayerExp.Txt_Lv:SetText(temp_lv_ani)
end
local RefreshCharacterExp = function()
  for k, v in pairs(View.Group_LCSettlement.Group_Victory.Group_Right.Group_CharacterExp.StaticGrid_Character.grid) do
    local row = RoleList[tonumber(k)]
    local element = v
    if row == nil then
      return
    end
    local before_lv = row.before.lv or 1
    local now_lv = row.now.lv or 1
    local Group_Character01 = element.Group_Character01
    local data = UnitLevelMaxData
    local levelUpExp
    if data[row.lv_ani] then
      levelUpExp = data[row.lv_ani].levelUpExp
    else
      levelUpExp = data[table.count(data)].levelUpExp
    end
    local now_exp = row.now.exp or 0
    local before_exp = row.before.exp or 0
    local exp = row.now_role_exp - before_exp
    row.exp_ani_speed = exp / SettlementConfig.NumSpeed
    row.exp_ani = math.ceil(row.exp_ani_speed + row.exp_ani)
    row.exp_ani = exp < row.exp_ani and exp or row.exp_ani
    if 0 < exp then
      Group_Character01.Group_Exp.self:SetActive(true)
      Group_Character01.Group_Exp.Txt_Num:SetText(now_exp < row.exp_ani and now_exp or row.exp_ani)
    else
      Group_Character01.Group_Exp.self:SetActive(false)
      Group_Character01.Group_Exp.Txt_Num:SetText(0)
    end
    local isMax = PlayerData:RoleLvIsMax(row.roleid, before_lv)
    if isMax == true then
      Group_Character01.Txt_LevelMax:SetText("最大")
      Group_Character01.Img_Exp.Img_Now:SetFilledImgAmount(1)
      Group_Character01.Img_Exp.Img_Before:SetFilledImgAmount(0)
    else
      Group_Character01.Txt_LevelMax:SetText("")
    end
    if before_lv < row.lv_ani then
      if levelUpExp <= row.exp_ani - row.front_exp then
        row.front_exp = row.front_exp + levelUpExp
        row.lv_ani = row.lv_ani + 1
        diff_exp = now_exp_ani - row.exp_ani
      end
      if data[row.lv_ani] then
        levelUpExp = data[row.lv_ani].levelUpExp
      else
        levelUpExp = data[table.count(data)].levelUpExp
      end
      Group_Character01.Img_Exp.Img_Before:SetFilledImgAmount(0)
      Group_Character01.Img_Exp.Img_Now:SetFilledImgAmount((row.exp_ani - row.front_exp) / levelUpExp)
    else
      if levelUpExp <= row.exp_ani + before_exp then
        row.front_exp = levelUpExp - before_exp
        row.lv_ani = row.lv_ani + 1
        diff_exp = now_exp_ani - row.exp_ani
      end
      Group_Character01.Img_Exp.Img_Now:SetFilledImgAmount((row.exp_ani + before_exp) / levelUpExp)
      Group_Character01.Img_Exp.Img_Before:SetFilledImgAmount(before_exp / levelUpExp)
    end
    Group_Character01.Group_Exp.Txt_Num:SetText(exp < row.exp_ani and exp or row.exp_ani)
    Group_Character01.Group_Lv.Txt_Num:SetText(now_lv < row.lv_ani and now_lv or row.lv_ani)
  end
end
local RefreshAni = function()
  RefreshPlayerExp()
  RefreshCharacterExp()
end
local RefreshLevelChainFinishResultPage = function(levelChainId)
  View.Group_LCSettlement.self:SetActive(true)
  View.Group_LCSettlement.Group_Victory.self:SetActive(true)
  local levelChainFactory = PlayerData:GetFactoryData(levelChainId, "LevelChainFactory")
  local level_chapter = levelChainFactory.index or "1-1"
  local chapter_name = levelChainFactory.levelChainName or "null"
  View.Group_LCSettlement.Group_Victory.Group_Left.Group_Level.Txt_LevelNumber:SetText(level_chapter)
  View.Group_LCSettlement.Group_Victory.Group_Left.Group_Level.Txt_LevelName:SetText(chapter_name)
  local before_lv = DataModel.user_info.lv
  local now_lv = Data.user_info.lv
  Group_PlayerExp.Txt_Lv:SetText(before_lv)
  local data = UserLevelMaxData
  local levelUpExp
  if data[now_lv] then
    levelUpExp = data[now_lv].levelUpExp
  else
    levelUpExp = data[table.count(data)].levelUpExp
  end
  local now_exp = Data.user_info.exp
  local before_exp = DataModel.user_info.exp
  Group_PlayerExp.Group_Exp.Txt_Num:SetText(0)
  Group_PlayerExp.Img_Exp.Img_Now:SetFilledImgAmount(before_exp / levelUpExp)
  Group_PlayerExp.Img_Exp.Img_Before:SetFilledImgAmount(before_exp / levelUpExp)
  Group_PlayerExp.Img_Exp.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(before_exp / levelUpExp * 100, 1) .. "%")
  View.Group_LCSettlement.Group_Victory.Group_Right.Group_CharacterExp.self:SetActive(true)
  View.Group_LCSettlement.Group_Victory.Group_Right.Group_CharacterExp.StaticGrid_Character.self:RefreshAllElement()
  View.Group_LCSettlement.Group_Reward.self:SetActive(true)
  View.Group_LCSettlement.Group_Reward.StaticGrid_Reward.self:RefreshAllElement()
end
local InitPage = function()
  DataModel.user_info = PlayerData.ServerData.user_info
  DataModel.before_roles = {}
  DataModel.AutoNextTime = 600
  delay_ani_time = 60
  isGridFinish = false
  DataModel.SettingTime = math.max(SettlementConfig.NumSpeed, SettlementConfig.FillSpeed)
  Group_PlayerExp = View.Group_LCSettlement.Group_Victory.Group_Right.Group_PlayerExp
  UnitLevelMaxData = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
  UserLevelMaxData = PlayerData:GetFactoryData(99900004, "ConfigFactory").expList
  for k, v in pairs(PlayerData.ServerData.roles) do
    DataModel.before_roles[k] = v
  end
  BattleResult = PlayerData.BattleInfo.BattleResult
  RoleList = PlayerData.ServerData.squad[100].role_list
  View.Group_LCSettlement.Group_Victory.self:SetActive(false)
  View.Group_LCSettlement.Group_Reward.self:SetActive(false)
  View.Group_LCSettlement.Group_Victory.Group_Right.BtnPolygon_Next.Txt_Time:SetText(string.format(GetText(80600167), DataModel.AutoNextTime / 60))
end

function module.Open(jsons, levelChainId, roleList)
  ConfigFactory = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  levelChain = PlayerData:GetFactoryData(levelChainId, "LevelChainFactory")
  InitPage()
  DataModel.RoleList = {}
  Data = jsons
  for k, v in pairs(roleList) do
    local row = {}
    row.roleid = v
    if v ~= nil and v ~= "" then
      local factory = PlayerData:GetFactoryData(row.roleid, "UnitFactory")
      row.name = factory.name
      row.viewId = factory.viewId
      row.viewList = PlayerData:GetFactoryData(row.viewId, "UnitViewFactory")
      row.face = row.viewList.face
      row.before = DataModel.before_roles[tostring(row.roleid)] == nil and PlayerData:GetFactoryData(tostring(row.roleid)) or DataModel.before_roles[tostring(row.roleid)]
      row.now = PlayerData.ServerData.roles[tostring(row.roleid)] or row.before
      local now_role_exp = row.now.exp or 0
      local before_role_exp = row.before.exp or 0
      local before_role_lv = row.before.lv or 0
      local now_role_lv = row.now.lv or 0
      local temp_exp = 0
      if 0 < now_role_lv - before_role_lv then
        for i = before_role_lv, now_role_lv - 1 do
          local levelUpExp = UnitLevelMaxData[i].levelUpExp
          temp_exp = temp_exp + levelUpExp - before_role_exp
        end
        now_role_exp = now_role_exp + temp_exp + before_role_exp
      end
      row.now_role_exp = now_role_exp
      row.battleInfo = v
      row.exp_ani = 0
      table.insert(DataModel.RoleList, row)
    end
  end
  AniState = true
  local user_info = PlayerData.ServerData.user_info
  before_lv_ani = DataModel.user_info.lv
  temp_lv_ani = before_lv_ani
  now_lv_ani = Data.user_info.lv
  now_exp_ani = Data.user_info.exp
  before_exp_ani = DataModel.user_info.exp
  local temp_exp = 0
  if now_exp_ani - before_exp_ani <= 0 then
    if 0 < now_lv_ani - temp_lv_ani then
      for i = temp_lv_ani, now_lv_ani - 1 do
        local levelUpExp = UserLevelMaxData[i].levelUpExp
        temp_exp = temp_exp + levelUpExp - before_exp_ani
      end
      now_exp_ani = now_exp_ani + temp_exp
    else
      now_exp_ani = -1 * now_exp_ani
    end
    now_exp_ani = now_exp_ani + before_exp_ani
  end
  damage_ani = 0
  top_exp_ani = 0
  show_top_exp_ani = 0
  RewardList = PlayerData:SortShowItem(jsons.reward)
  RefreshLevelChainFinishResultPage(levelChainId)
end

function module.Update()
  if PlayerData.ChooseChapterType ~= 3 then
    DataModel.AutoNextTime = DataModel.AutoNextTime - 1
    DataModel.SettingTime = DataModel.SettingTime - 1
    if DataModel.SettingTime <= 0 then
      isGridFinish = true
    end
    delay_ani_time = delay_ani_time - 1
    if AniState == true and delay_ani_time <= 0 then
      RefreshAni()
    end
  end
end

function module.SetGridReward(element, elementIndex)
  if elementIndex > table.count(RewardList) then
    element.self:SetActive(false)
  else
    element.self:SetActive(true)
    local item = RewardList[elementIndex]
    local itemData = PlayerData:GetFactoryData(item.id, item.factoryName)
    element.Img_Item:SetSprite(itemData.iconPath)
    element.Txt_Num:SetText(item.num)
  end
end

function module.SetGridCharacter(element, elementIndex)
  if elementIndex > table.count(DataModel.RoleList) then
    element.self:SetActive(false)
  else
    element.self:SetActive(true)
    local roleData = DataModel.RoleList[elementIndex]
    element.Group_Character01.Img_Mask.Img_Face:SetSprite(roleData.face)
    element.Group_Character01.Group_Lv.Txt_Num:SetText(roleData.now_role_lv)
    element.Group_Character01.Group_Exp.Txt_Num:SetText(tostring(levelChain.characterExp))
  end
end

return module
