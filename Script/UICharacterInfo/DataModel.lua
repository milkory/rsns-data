local View = require("UICharacterInfo/UICharacterInfoView")
local lastRoleId
local DataModel = {
  RoleId = -1,
  RoleData = nil,
  RoleCA = nil,
  DragOver = false,
  DragOverPosX = nil,
  Roles = {},
  RoleAttributeCurrent = {},
  RoleAttributeNext = {},
  QueueData = {CurrentIndex = -1, Count = -1},
  InitState = false,
  IsNoMoney = false,
  InfoInitPos = {
    isRecord = true,
    x = 0,
    y = 0,
    scale = 1,
    offsetX = 0,
    offsetY = 1
  },
  LevelUpInitPos = {
    isRecord = true,
    x = 0,
    y = 0,
    scale = 1
  },
  Job = {
    [1] = "强袭",
    [2] = "防暴",
    [3] = "射手",
    [4] = "灵子",
    [5] = "援护",
    [6] = "特职"
  }
}
DataModel.lock_Add = false
DataModel.lock_LevelUp = false
DataModel.isLevelUp_Long = false
DataModel.MaterialList = {}

function DataModel.UpdateMaterialList(data)
  DataModel.MaterialList = {}
  for k, v in pairs(data) do
    local Factory = PlayerData:GetFactoryData(tonumber(v.id))
    local ItemViewFactory = PlayerData:GetFactoryData(tonumber(Factory.viewId))
    table.insert(DataModel.MaterialList, {
      id = v.id,
      Factory = Factory,
      num = v.num,
      ItemViewFactory = ItemViewFactory
    })
  end
end

function DataModel.StaticGrid_Item_SetGrid(index)
  return DataModel.MaterialList[index]
end

DataModel.AttributeConfig = {
  {
    type = "tAtk",
    txt = "攻击力",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_attack"
  },
  {
    type = "tHp",
    txt = "生命值",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_health"
  },
  {
    type = "tDef",
    txt = "防御力",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_defense"
  },
  {
    type = "tCri",
    txt = "暴击率",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_cri"
  },
  {
    type = "tCriDamage",
    txt = "暴击伤害",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_cri_damage"
  },
  {
    type = "tSpeed",
    txt = "攻撃速度",
    sprite = "UI\\Common\\Characterinfo_icon_att_attackSpd"
  },
  {
    type = "tSpeedRange",
    txt = "攻撃範囲",
    sprite = "UI\\Common\\Characterinfo_icon_att_attackRange"
  },
  {
    type = "tSpName",
    txt = "特殊技能名称",
    sprite = "UI\\Common\\Characterinfo_icon_att_sp"
  }
}
DataModel.AttributeBreakConfig = {
  {
    type = "tAtk",
    txt = "攻击力",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_attack"
  },
  {
    type = "tHp",
    txt = "生命值",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_health"
  },
  {
    type = "tDef",
    txt = "防御力",
    sprite = "UI\\CharacterInfo\\Characterinfo_icon_att_defense"
  }
}

function DataModel.GetShowType()
  local portraitId = DataModel.RoleData.current_skin[1]
  if portraitId == nil or portraitId == 0 then
    local viewCa = PlayerData:GetFactoryData(DataModel.RoleCA.viewId, "UnitViewFactory")
    portraitId = DataModel.RoleCA.viewId
  end
  local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
  if DataModel.RoleData.resonance_lv == 5 and portrailData.spine2Url ~= nil and portrailData.spine2Url ~= "" then
    if DataModel.RoleData.current_skin[2] == 1 then
      return "Spine2"
    else
      return "Spine"
    end
  end
  if portrailData.spineUrl ~= nil and portrailData.spineUrl ~= "" then
    return "Spine"
  else
    return "Img"
  end
end

function DataModel.RefreshPage()
  for i = 1, #DataModel.TabEnum do
    if DataModel.TabEnum[i].btn.Img_RedPoint then
      DataModel.TabEnum[i].btn.Img_RedPoint:SetActive(PlayerData:GetAllRoleAwakeRedID(tostring(DataModel.RoleId)))
    end
  end
end

local UITable

function DataModel.LevelUpInit()
  View.Group_TabLevelUp.self:SetActive(true)
  if lastRoleId == DataModel.RoleId and DataModel.InitState == false then
    return
  end
  local portraitId = DataModel.RoleData.current_skin[1]
  if portraitId == nil or portraitId == 0 then
    local viewCa = PlayerData:GetFactoryData(DataModel.RoleCA.viewId, "UnitViewFactory")
    portraitId = DataModel.RoleCA.viewId
  end
  local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
  if portrailData.spineUrl ~= nil and portrailData.spineUrl ~= "" then
    View.Group_TabLevelUp.Img_Character:SetActive(false)
    View.Group_TabLevelUp.Spine_Character:SetActive(true)
    View.Group_TabLevelUp.Spine_Character:SetData(portrailData.spineUrl)
  else
    View.Group_TabLevelUp.Spine_Character:SetActive(false)
    View.Group_TabLevelUp.Img_Character:SetActive(true)
    View.Group_TabLevelUp.Img_Character:SetSprite(portrailData.resUrl)
  end
  UITable = View.Group_TabLevelUp
  local Group_TARight = UITable.Group_TARight
  Group_TARight.Img_LevelBottom.Txt_LVNum.self:SetText(tostring(DataModel.RoleData.lv))
  Group_TARight.Group_Awake.Txt_Awake:SetText("覚醒" .. DataModel.RoleData.resonance_lv)
  lastRoleId = DataModel.RoleId
end

local SwitchSpeed = function(tSpeed)
  if tSpeed <= 80 then
    return 80600232
  elseif tSpeed <= 120 then
    return 80600233
  elseif tSpeed <= 200 then
    return 80600234
  elseif tSpeed <= 275 then
    return 80600235
  else
    return 80600236
  end
end
local SwitchSpeedRange = function(line)
  local line_config = {
    [0] = 80600228,
    [1] = 80600229,
    [2] = 80600230,
    [3] = 80600231
  }
  return line_config[line] or line
end

function DataModel:SetRoleAttributeCurrent()
  local RoleData = DataModel.RoleData
  DataModel.RoleAttributeCurrent = {}
  local temp_data = {}
  temp_data.tHp, temp_data.tDef, temp_data.tAtk, temp_data.tCri, temp_data.tCriDamage, temp_data.tSpeed, temp_data.tBlock, temp_data.tBlockRate, temp_data.tPDamageUp, temp_data.tMDamageUp, temp_data.tFReduce, temp_data.tGetPDamageDown, temp_data.tGetMDamageDown, temp_data.tGetFDamageDown, temp_data.tGetHealUp, temp_data.tGetShieldUp, temp_data.tSummonAtkUp, temp_data.tSummonFinalDamageUp = PlayerData:CountRoleAttributeById(DataModel.RoleId, RoleData.skills[1] and RoleData.skills[1].lv or 1, RoleData.skills[2] and RoleData.skills[2].lv or 1, RoleData.skills[2] and RoleData.skills[2].lv or 1, RoleData.lv, RoleData.awake_lv, RoleData.resonance_lv, RoleData.trust_lv or 1)
  for k, v in pairs(PlayerData.AttributeConfig) do
    local row = {}
    DataModel.RoleAttributeCurrent[k] = row
    row.name = v.txt
    if temp_data[v.type] then
      row.num = temp_data[v.type] + 1.0E-7 or 0
      row.num = PlayerData:GetPreciseDecimalFloor(row.num, 2)
      if v.type == "tSpeed" then
        row.num = GetText(SwitchSpeed(temp_data[v.type]))
      end
    else
      if v.type == "tSpeedRange" then
        row.num = GetText(SwitchSpeedRange(DataModel.RoleCA.line))
      end
      if v.type == "tSpName" then
        row.num = DataModel.RoleCA.specialGiftDes
      end
    end
    row.sprite = v.sprite
  end
end

function DataModel.LoadSpineBg()
  local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d")
  if live2D == 1 then
    View.Group_Middle.Img_SpineBG:SetActive(false)
    return
  end
  local viewCfg = PlayerData:GetFactoryData(DataModel.RoleData.portrait_id, "UnitViewFactory")
  if viewCfg.SpineBackground and viewCfg.SpineBackground ~= "" then
    View.Group_Middle.Img_SpineBG:SetSprite(viewCfg.SpineBackground)
    DataModel.offsetX = viewCfg.SpineBGX and viewCfg.SpineBGX or 0
    DataModel.offsetY = viewCfg.SpineBGY and viewCfg.SpineBGY or 0
    local x
    if DataModel.DragOverPosX and DataModel.DragOverPosX ~= 0 then
      x = 0 < DataModel.DragOverPosX and -Screen.width or Screen.width
    else
      x = View.Group_Middle.SpineAnimation_Character.transform.localPosition.x - DataModel.offsetX
    end
    local y = viewCfg.SpineBGY and viewCfg.SpineBGY or 0
    View.Group_Middle.Img_SpineBG.transform.localPosition = Vector3(x, y, 0)
    local scale = viewCfg.SpineBGScale or 1
    View.Group_Middle.Img_SpineBG.transform.localScale = Vector3(scale, scale, 0)
  end
  View.Group_Middle.Img_SpineBG:SetActive(viewCfg.SpineBackground and viewCfg.SpineBackground ~= "")
end

function DataModel.SpineBgFollow()
  if View.Group_Middle.Img_SpineBG.IsActive then
    local x = View.Group_Middle.SpineAnimation_Character.transform.localPosition.x - DataModel.offsetX
    local pos = Vector3(x, DataModel.offsetY, 0)
    View.Group_Middle.Img_SpineBG.transform.localPosition = pos
    local alpha = View.Group_Middle.SpineAnimation_Character.color.a
    View.Group_Middle.Img_SpineBG:SetAlpha(alpha)
  end
end

return DataModel
