local View = require("UIGroup_TabLevelUp/UIGroup_TabLevelUpView")
local DataModel = require("UIGroup_TabLevelUp/UIGroup_TabLevelUpDataModel")
local Controller = {}
local UITable, tempLvUpLevel
local UseCost = function()
  local num = 0
  for i, v in pairs(DataModel.TempLvUpUse) do
    if 0 < v.tempNum then
      num = num + v.cost * v.tempNum
    end
  end
  if num == 0 then
    UITable.Group_TABottom.Group_Cost.self:SetActive(false)
    return
  end
  UITable.Group_TABottom.Group_Cost.self:SetActive(true)
  local have = PlayerData:GetUserInfo().gold
  UITable.Group_TABottom.Group_Cost.Txt_Have:SetText(have)
  UITable.Group_TABottom.Group_Cost.Txt_Need:SetText(num)
  if num > have then
    UITable.Group_TABottom.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
    DataModel.IsNoMoney = true
  else
    UITable.Group_TABottom.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
    DataModel.IsNoMoney = false
  end
end
local SetExpEveryAll = function()
  local num = 0
  for k, v in pairs(DataModel.LvUpConfigFactory) do
    num = num + v.levelUpExp
    DataModel.LvUpEveryExp[k] = num
  end
end
local lastRoleId

function Controller:Load()
  DataModel.lock_Add = false
  DataModel.isLevelUp_Long = false
  DataModel.tempLvUpLevel = DataModel.RoleData.lv
  DataModel.tempLvUpExp = DataModel.RoleData.exp
  DataModel.allLvUpExp = DataModel.RoleData.exp
  DataModel.LvUpEveryExp = {}
  DataModel.LvUpConfigFactory = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
  SetExpEveryAll()
  UITable = View
  tempLvUpLevel = nil
  self:Refresh()
end

function Controller:Refresh(isTemp)
  DataModel.tempLvUpLevel = DataModel.tempLvUpLevel or DataModel.RoleData.lv
  DataModel.tempLvUpExp = DataModel.tempLvUpExp or DataModel.RoleData.exp
  if lastRoleId == DataModel.RoleId and DataModel.InitState == false and not isTemp then
    return
  end
  local portraitId = DataModel.RoleData.current_skin[1]
  if portraitId == nil or portraitId == 0 then
    local viewCa = PlayerData:GetFactoryData(DataModel.RoleCA.viewId, "UnitViewFactory")
    portraitId = DataModel.RoleCA.viewId
  end
  local Group_TATop = UITable.Group_TATop
  local Img_Icon = Group_TATop.Group_Icon.Img_Icon
  Img_Icon:SetSprite(PlayerData:GetFactoryData(PlayerData:GetFactoryData(DataModel.RoleId).viewId).face)
  Group_TATop.Img_LevelBottom.Txt_Name:SetText(DataModel.RoleCA.name)
  local Group_LV = Group_TATop.Img_LevelBottom.Group_LV
  Group_LV.Txt_LVCap.Txt_LVNum:SetText(tostring(DataModel.tempLvUpLevel))
  Group_LV.Txt_LVCap:SetText(DataModel.AwakeMaxLevel)
  if not isTemp then
    local data = PlayerData:GetFactoryData(99900001, "ConfigFactory").expSourceMaterialList
    DataModel.TempLvUpUse = DataModel.TempLvUpUse or {}
    for i, v in ipairs(data) do
      local num = PlayerData:GetMaterialById(v.id).num
      local itemData = PlayerData:GetFactoryData(v.id, "SourceMaterialFactory")
      DataModel.TempLvUpUse[i] = {
        id = v.id,
        maxNum = num,
        exp = itemData.exp,
        tempNum = 0,
        cost = itemData.cost
      }
    end
  end
  self:SetExp()
  local Group_TABottom = UITable.Group_TABottom
  Group_TABottom.StaticGrid_Item.self:RefreshAllElement()
  UseCost()
end

function Controller:SetExp()
  local Img_LevelBottom = UITable.Group_TATop.Img_LevelBottom
  local Group_EXP = Img_LevelBottom.Group_EXP
  local lv = DataModel.tempLvUpLevel
  local endExp = 0
  local ConfigFactory = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
  local isMaxLevel = false
  if lv >= DataModel.AwakeMaxLevel then
    isMaxLevel = true
  else
    endExp = ConfigFactory[DataModel.tempLvUpLevel].levelUpExp
  end
  Group_EXP.Txt_EXPNum:SetActive(not isMaxLevel)
  if DataModel.RoleData.lv == DataModel.tempLvUpLevel and DataModel.tempLvUpExp == DataModel.RoleData.exp then
    Img_LevelBottom.Img_EXPPB:SetFilledImgAmount(DataModel.tempLvUpExp / endExp)
    Img_LevelBottom.Img_EXPAdd:SetFilledImgAmount(DataModel.tempLvUpExp / endExp)
  else
    if DataModel.tempLvUpLevel > DataModel.RoleData.lv then
      Img_LevelBottom.Img_EXPPB:SetFilledImgAmount(0)
    elseif DataModel.tempLvUpLevel == DataModel.RoleData.lv then
      Img_LevelBottom.Img_EXPPB:SetFilledImgAmount(DataModel.RoleData.exp / endExp)
    end
    Img_LevelBottom.Img_EXPAdd:SetFilledImgAmount(DataModel.tempLvUpExp / endExp)
  end
  if DataModel.tempLvUpLevel == DataModel.AwakeMaxLevel then
    Img_LevelBottom.Img_EXPPB:SetFilledImgAmount(0)
    Img_LevelBottom.Img_EXPAdd:SetFilledImgAmount(0)
  else
    Group_EXP.Txt_EXPNum:SetText(DataModel.tempLvUpExp .. "/" .. endExp)
  end
end

return Controller
