local View = require("UIGroup_TabLevelUp/UIGroup_TabLevelUpView")
local DataModel = require("UIGroup_TabLevelUp/UIGroup_TabLevelUpDataModel")
local CommonItem = require("Common/BtnItem")
local Controller = require("UIGroup_TabLevelUp/UIGroup_TabLevelUpController")
local InfoLoader = require("UICharacterInfo/ViewInfo")
local SkillLoader = require("UICharacterInfo/ViewSkill")
local AwakeLoader = require("UICharacterInfo/ViewAwake")
local ResonanceLoader = require("UICharacterInfo/ViewResonance")
local LevelUpSend = function()
  DataModel.lock_LevelUp = true
  local items = {}
  for i, v in ipairs(DataModel.TempLvUpUse) do
    if v.tempNum > 0 then
      items[v.id] = v.tempNum
    end
  end
  if DataModel.IsNoMoney then
    CommonTips.OpenTips(80600129)
    return
  end
  if DataModel.tempLvUpExp ~= DataModel.RoleData.exp or DataModel.tempLvUpLevel ~= DataModel.RoleData.lv then
    if table.count(items) == 0 then
      return CommonTips.OpenTips(80600134)
    end
    if DataModel.tempLvUpLevel == DataModel.RoleData.lv and DataModel.tempLvUpExp == DataModel.RoleData.exp then
      return
    end
    Net:SendProto("hero.add_exp_by_material", function(json)
      local originalLv = DataModel.RoleData.lv
      local ogrinalExp = DataModel.RoleData.exp
      DataModel.lock_LevelUp = false
      DataModel.isLevelUp_Long = false
      PlayerData:RefreshUseItems(items)
      DataModel.RoleData = PlayerData:GetRoleById(DataModel.RoleId)
      DataModel.InitState = true
      Controller:Load()
      if UseGSDK then
        local info = PlayerData:GetGameUploadInfo()
        GSDKManager:RoleLevelUpload(info.RoleName, info.RoleLevel, info.Balance, info.Chapter)
      end
    end, tostring(DataModel.RoleId), items)
  else
    CommonTips.OpenTips(80600130)
    DataModel.lock_LevelUp = false
    return
  end
end
local ViewFunction = {
  Group_TabLevelUp_Btn_BG_Click = function(btn, str)
    if DataModel.ShowUI and DataModel.ShowUI == "characterinfo" then
      View.self:CloseUI()
      if DataModel.Index == 1 then
        InfoLoader:Load(DataModel.RoleData, true)
        InfoLoader:_set_exp()
      end
      if DataModel.Index == 2 then
        SkillLoader:Load()
      end
      if DataModel.Index == 3 then
        ResonanceLoader:Load(DataModel.RoleData)
      end
      if DataModel.Index == 4 then
        AwakeLoader:Load(DataModel.RoleData)
      end
    else
      UIManager:GoBack()
    end
  end,
  Group_TabLevelUp_Group_TABottom_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local data = PlayerData:GetFactoryData(99900001, "ConfigFactory").expSourceMaterialList[elementIndex]
    local num = PlayerData:GetGoodsById(data.id).num
    local temp = DataModel.TempLvUpUse[elementIndex]
    temp.Now_num = num
    local itemData = PlayerData:GetFactoryData(data.id, "SourceMaterialFactory")
    CommonItem:SetItem(element.Group_Item, itemData)
    element.Btn_Add:SetClickParam(tostring(elementIndex))
    element.Txt_Use:SetText(num - temp.tempNum)
  end,
  Group_TabLevelUp_Group_TABottom_StaticGrid_Item_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Group_TabLevelUp_Group_TABottom_StaticGrid_Item_Group_Item_Btn_Add_Click = function(btn, str)
    if DataModel.lock_Add == false and DataModel.isLevelUp_Long == false then
      local index = tonumber(str)
      local data = DataModel.TempLvUpUse[index]
      if data.Now_num == 0 then
        CommonTips.OpenTips(80600062)
        return
      end
      DataModel.lock_Add = true
      DataModel.click_time = 0
      local ConfigFactory = DataModel.LvUpConfigFactory
      local maxLevel = DataModel.AwakeMaxLevel
      local tempLvUpLevel = DataModel.tempLvUpLevel == maxLevel and DataModel.tempLvUpLevel - 1 or DataModel.tempLvUpLevel
      local maxExp = ConfigFactory[tempLvUpLevel] and ConfigFactory[tempLvUpLevel].levelUpExp or 0
      if data.tempNum == data.maxNum then
        CommonTips.OpenTips(80600062)
        return
      end
      if maxLevel <= DataModel.tempLvUpLevel then
        CommonTips.OpenTips(80600130)
        return
      end
      data.tempNum = math.min(data.tempNum + 1, data.maxNum)
      local totalExp = data.exp
      local exp = DataModel.tempLvUpExp
      local tempExp = exp + totalExp
      DataModel.allLvUpExp = DataModel.allLvUpExp + totalExp
      while maxExp <= tempExp do
        if DataModel.tempLvUpLevel == maxLevel - 1 then
          tempExp = 0
          DataModel.tempLvUpLevel = DataModel.tempLvUpLevel + 1
          break
        end
        tempExp = tempExp - maxExp
        if maxLevel == DataModel.tempLvUpLevel then
          DataModel.tempLvUpLevel = 1
        else
          DataModel.tempLvUpLevel = DataModel.tempLvUpLevel + 1
        end
        maxExp = ConfigFactory[DataModel.tempLvUpLevel].levelUpExp
      end
      View.self:PlayAnim("TapLevelUpStart")
      DataModel.tempLvUpExp = tempExp
      LevelUpSend()
    end
  end,
  Group_TabLevelUp_Group_TABottom_StaticGrid_Item_Group_Item_Btn_Add_LongPress = function(btn, str)
    local index = tonumber(str)
    local data = DataModel.TempLvUpUse[index]
    if data.Now_num == 0 then
      CommonTips.OpenTips(80600062)
      return
    end
    View.self:StartC(LuaUtil.cs_generator(function()
      while btn.Btn.isHandled do
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
        DataModel.isLevelUp_Long = true
        if data.tempNum == data.maxNum then
          CommonTips.OpenTips(80600062)
          LevelUpSend()
          return
        end
        local maxLevel = DataModel.AwakeMaxLevel
        local tempLvUpLevel = DataModel.tempLvUpLevel == maxLevel and DataModel.tempLvUpLevel - 1 or DataModel.tempLvUpLevel
        local ConfigFactory = DataModel.LvUpConfigFactory
        local maxExp = ConfigFactory[tempLvUpLevel] and ConfigFactory[tempLvUpLevel].levelUpExp or 0
        if maxLevel <= DataModel.tempLvUpLevel then
          CommonTips.OpenTips(80600130)
          LevelUpSend()
          return
        end
        data.tempNum = math.min(data.tempNum + 1, data.maxNum)
        local totalExp = data.exp
        local exp = DataModel.tempLvUpExp
        local tempExp = exp + totalExp
        while maxExp <= tempExp do
          if DataModel.tempLvUpLevel == maxLevel - 1 then
            tempExp = 0
            DataModel.tempLvUpLevel = DataModel.tempLvUpLevel + 1
            break
          end
          tempExp = tempExp - maxExp
          if maxLevel == DataModel.tempLvUpLevel then
            DataModel.tempLvUpLevel = 1
          else
            DataModel.tempLvUpLevel = DataModel.tempLvUpLevel + 1
          end
          maxExp = ConfigFactory[DataModel.tempLvUpLevel].levelUpExp
        end
        DataModel.tempLvUpExp = tempExp
        Controller:Refresh(true)
      end
      View.self:PlayAnim("TapLevelUpStart")
      LevelUpSend()
    end))
  end,
  Group_TabLevelUp_Group_TABottom_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Group_TabLevelUp_Group_TABottom_Group_Item_Btn_Add_Click = function(btn, str)
  end,
  Group_TabLevelUp_Group_TABottom_Group_Item_Btn_Add_LongPress = function(btn, str)
  end
}
return ViewFunction
