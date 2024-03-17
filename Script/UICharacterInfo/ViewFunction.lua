local View = require("UICharacterInfo/View")
local EquipHandle = require("UICharacterInfo/ModelEquipment")
local BreakThroughLoader = require("UICharacterInfo/ViewBreakThrough")
local BtnController = require("UICharacterInfo/Model_Btn")
local DataModel = require("UICharacterInfo/Model_Data")
local AwakeLoader = require("UICharacterInfo/ViewAwake")
local SkillLoader = require("UICharacterInfo/ViewSkill")
local ViewFunction = {
  Group_TabInfo_Group_TIBottomLeft_Img_LevelBottom_Btn_LevelUp_click = function(str)
  end,
  Group_TabInfo_Group_TIBottomLeft_Btn_Attribute_click = function(str)
  end,
  Group_TabInfo_Group_TIBottomLeft_Btn_Skin_click = function(str)
  end,
  Group_TabInfo_Group_TIBottomLeft_Btn_Information_click = function(str)
  end,
  Group_TabInfo_Group_TIBottomLeft_Btn_Show_click = function(str)
  end,
  Group_TabInfo_Group_TIRight_Group_TIMiddle_Btn_Skill01_click = function(str)
  end,
  Group_TabInfo_Group_TIRight_Group_TIMiddle_Btn_Skill02_click = function(str)
  end,
  Group_TabInfo_Group_TIRight_Group_TIMiddle_Btn_Skill03_click = function(str)
  end,
  Group_TabInfo_Group_TIRight_Group_TIMiddle_Btn_LvUp_click = function(str)
    View.Group_TabSkill.self:SetActive(true)
    SkillLoader:Load()
  end,
  Group_TabInfo_Group_TIRight_Group_TIBottom_Btn_Equipment01_Btn_Item_click = function(str)
  end,
  Group_TabInfo_Group_TIRight_Group_TIBottom_Btn_Equipment02_Btn_Item_click = function(str)
  end,
  Group_TabInfo_Group_TIRight_Group_TIBottom_Btn_Equipment03_Btn_Item_click = function(str)
  end,
  Group_TabAwake_Group_TARight_Group_TAMiddle_Btn_Detail_click = function(str)
  end,
  Group_TabAwake_Group_TARight_Group_TABottom_Btn_Awake_click = function(str)
    local p = ProtocolFactory:CreateProtocol(ProtocolType.CharacterAwake)
    p.roleId = DataModel.RoleId
    p:SetCallback(callBack)
    ServerConnectManager:Add(p)
  end,
  LuaBridge_Group_TabAwake_Group_TARight_Group_TABottom_ScrollGrid_Item = {
    SetElement = function(self, element, elementIndex)
      local level = DataModel.RoleData.awakeLevel
      if level >= DataManager.defaultConfig.ca.awakeTime then
        return
      end
      local awakeId = DataModel.RoleData.ca.awakeList[level].awakeId
      local data = AwakeFactory:GetCA(awakeId)
      local materialList = data.materialList
      local group = element.Group_Container
      element.self:SetActive(materialList.Count > elementIndex + 1)
      if elementIndex < materialList.Count then
        local item = materialList[elementIndex]
        element.self:SetActive(true)
        local itemData = SourceMaterialFactory:GetCA(item.itemId)
        local needNum = item.num
        local haveNum = DataManager.playerData:GetItemNum(item.itemId)
        group.Txt_Need:SetText(needNum)
        group.Txt_Have:SetText(haveNum)
        if needNum <= haveNum then
          group.Txt_Need:SetColor(UIConfig.Color.White)
        else
          group.Txt_Need:SetColor(UIConfig.Color.Red)
        end
        local image = ItemViewFactory:GetCA(itemData.viewId).iconUrl
        group.Group_Item.Img_Item:SetSprite(image)
        group.Group_Item.Img_Bottom:SetSprite(UIConfig.FrameConfig[itemData.qualityInt])
      else
      end
    end
  },
  Group_TabAwake_Group_TARight_Group_TABottom_ScrollGrid_Item_Grid_Group_Container_Group_Item_Btn_Item_click = function(str)
  end,
  LuaBridge_Group_TabBreakThrough_Group_TBRight_Group_TBMiddle_ScrollGrid_Stage = {
    SetElement = function(self, element, elementIndex)
      if elementIndex >= DataModel.RoleData.ca.breakthroughList.Count - 1 then
        element.self:SetActive(false)
      else
        local bkId = DataModel.RoleData.ca.breakthroughList[elementIndex + 1].breakthroughId
        local bkCA = BreakthroughFactory:GetCA(bkId)
        if bkCA and bkCA.desc and bkCA.desc ~= "" then
          local str = "突破" .. elementIndex + 1 .. "    " .. bkCA.desc
          element.Txt_Off:SetText(str)
          element.Txt_On:SetText(str)
        end
        element.Txt_Off:SetActive(elementIndex >= DataModel.RoleData.breakthroughLevel)
        element.Txt_On:SetActive(elementIndex < DataModel.RoleData.breakthroughLevel)
        element.self:SetActive(true)
      end
    end
  },
  Group_TabBreakThrough_Group_TBRight_Group_TBBottom_Btn_BK_click = function(str)
    local p = ProtocolFactory:CreateProtocol(ProtocolType.CharacterBreakThrough)
    p.roleId = DataModel.RoleId
    p:SetCallback(callBack)
    ServerConnectManager:Add(p)
  end,
  LuaBridge_Group_TabBreakThrough_Group_TBRight_Group_TBBottom_ScrollGrid_Item = {
    SetElement = function(self, element, elementIndex)
      local level = DataModel.RoleData.breakthroughLevel
      if level >= DataManager.defaultConfig.ca.breakthroughTime then
        print("满级")
        return
      end
      local bkId = DataModel.RoleData.ca.breakthroughList[level + 1].breakthroughId
      local materialList = BreakthroughFactory:GetCA(bkId).materialList
      local group = element.Group_Container
      element.self:SetActive(materialList.Count > elementIndex + 1)
      if elementIndex < materialList.Count then
        local item = materialList[elementIndex]
        element.self:SetActive(true)
        local itemData = SourceMaterialFactory:GetCA(item.itemId)
        local needNum = item.num
        local haveNum = DataManager.playerData:GetItemNum(item.itemId)
        group.Txt_Need:SetText(needNum)
        group.Txt_Have:SetText(haveNum)
        if needNum <= haveNum then
          group.Txt_Need:SetColor(UIConfig.Color.White)
        else
          group.Txt_Need:SetColor(UIConfig.Color.Red)
        end
        local image = ItemViewFactory:GetCA(itemData.viewId).iconUrl
        group.Group_Item.Img_Item:SetSprite(image)
        group.Group_Item.Img_Bottom:SetSprite(UIConfig.FrameConfig[itemData.qualityInt])
      else
      end
    end
  },
  Group_TabBreakThrough_Group_TBRight_Group_TBBottom_ScrollGrid_Item_Grid_Group_Container_Group_Item_Btn_Item_click = function(str)
  end,
  LuaBridge_Group_TabTalent_Group_TTRight_ScrollGrid_Awaka = {
    SetElement = function(self, element, elementIndex)
      local level = DataModel.RoleData.awakeLevel
      if elementIndex < DataModel.RoleData.ca.talentList.Count then
        local id = DataModel.RoleData.ca.talentList[elementIndex].talentId
        local needLv = TalentFactory:GetCA(id).awakeLv
        element.Txt_Level:SetText(elementIndex + 1)
        element.Txt_Tips:SetText(string.format("覚醒%d解锁", needLv))
        if level >= needLv then
          element.Img_Skill.Img_Lock:SetActive(false)
        else
          element.Img_Skill.Img_Lock:SetActive(true)
        end
        element.self:SetActive(true)
      else
        element.self:SetActive(false)
      end
    end
  },
  LuaBridge_Group_TabSkill_ScrollGrid_SkillList = {
    SetElement = function(self, element, elementIndex)
      local count = DataModel.RoleData.ca.skillList.Count
      element.self:SetClickParam(elementIndex)
      if elementIndex < DataModel.RoleData.ca.skillList.Count then
        element.Group_Off.self:SetActive(elementIndex ~= SkillLoader.skillSelectIndex)
        element.Group_On.self:SetActive(elementIndex == SkillLoader.skillSelectIndex)
        local data = SkillFactory:GetCA(DataModel.RoleData.ca.skillList[elementIndex].skillId)
        local level = DataModel.RoleData.skillsLevel[elementIndex]
        local damage = tonumber(data.skillRateList[level - 1].rate_SN)
        if level == data.levelMax then
          damage = math.tointeger(damage * 0.01)
          local str = string.gsub(data.skillDesc, "%[%+%%s%%%%%]", "")
          element.Txt_Desc:SetText(string.format(str, tostring(damage)))
          element.Txt_Lv:SetText("Lv.Max")
        else
          local diff = tonumber(data.skillRateList[level].rate_SN) - damage
          diff = diff * 0.01
          diff = math.tointeger(diff)
          element.Txt_Desc:SetText(string.format(data.skillDesc, tostring(math.tointeger(damage * 0.01)), tostring(diff)))
          element.Txt_Lv:SetText(string.format("Lv.%d", level))
        end
        element.Img_Icon:SetSprite(data.iconPath)
        element.Txt_Name:SetText(data.name)
        element.self:SetActive(true)
      else
        element.self:SetActive(false)
      end
    end
  },
  Group_TabSkill_ScrollGrid_SkillList_Grid_Btn_Skill_click = function(str)
    SkillLoader:SelectSkill(str)
  end,
  LuaBridge_Group_TabSkill_ScrollGrid_Item = {
    SetElement = function(self, element, elementIndex)
      local data = SkillFactory:GetCA(DataModel.RoleData.ca.skillList[SkillLoader.skillSelectIndex].skillId)
      local UITable = View.Group_TabSkill
      local itemGrid = UITable.ScrollGrid_Item.grid.self
      local level = DataModel.RoleData.skillsLevel[SkillLoader.skillSelectIndex]
      if 6 <= elementIndex then
        element.self:SetActive(false)
      else
        local materialId = data.materialList[level]["itemId" .. elementIndex + 1]
        local materialNum = data.materialList[level]["num" .. elementIndex + 1]
        if materialId and materialId ~= -1 and materialId ~= tostring(-1) then
          local group = element.Group_Container
          local itemData = SourceMaterialFactory:GetCA(materialId)
          local haveNum = DataManager.playerData:GetItemNum(materialId)
          group.Txt_Need:SetText(materialNum)
          group.Txt_Have:SetText(haveNum)
          if materialNum <= haveNum then
            group.Txt_Need:SetColor(UIConfig.Color.White)
          else
            group.Txt_Need:SetColor(UIConfig.Color.Red)
          end
          local image = ItemViewFactory:GetCA(itemData.viewId).iconUrl
          group.Group_Item.Img_Item:SetSprite(image)
          group.Group_Item.Img_Bottom:SetSprite(UIConfig.FrameConfig[itemData.qualityInt])
          element.self:SetActive(true)
        else
          element.self:SetActive(false)
        end
      end
    end
  },
  Group_TabSkill_ScrollGrid_Item_Grid_Group_Container_Group_Item_Btn_Item_click = function(str)
  end,
  Group_TabSkill_Btn_Lvup_click = function(str)
  end,
  Group_TabResonance_Group_TARight_Group_TAMiddle_Btn_Detail_click = function(str)
  end,
  Group_TabResonance_Group_TARight_Group_TABottom_Btn_Resonance_click = function(str)
  end,
  LuaBridge_Group_TabResonance_Group_TARight_Group_TABottom_ScrollGrid_Item = {
    SetElement = function(self, element, elementIndex)
      element.Group_Container.Group_Item.Btn_Item:SetClickParam(elementIndex)
      if elementIndex < ConfigFactory:GetCA(99900001).resonanceSourceMaterialList.Count then
        element.self:SetActive(true)
      else
        element.self:SetActive(false)
      end
    end
  },
  Group_TabResonance_Group_TARight_Group_TABottom_ScrollGrid_Item_Grid_Group_Container_Group_Item_Btn_Item_click = function(str)
  end,
  Group_TopLeft_Group_CommonTopLeft_Btn_Return_click = function(str)
    if View.Group_TabSkill.IsActive then
      View.Group_TabSkill.self:SetActive(false)
    else
      EquipHandle:Submit()
      UIManager:GoBack()
    end
  end,
  Group_TopLeft_Group_CommonTopLeft_Btn_Home_click = function(str)
    EquipHandle:Submit()
    UIManager:GoHome()
  end,
  Group_TopLeft_Group_CommonTopLeft_Btn_Help_click = function(str)
  end,
  Group_TopRight_Btn_TabInfo_click = function(str)
    BtnController:Click(View.Group_TopRight.Btn_TabInfo)
  end,
  Group_TopRight_Btn_TabAwake_click = function(str)
    BtnController:Click(View.Group_TopRight.Btn_TabAwake)
  end,
  Group_TopRight_Btn_TabBreakThrough_click = function(str)
    BtnController:Click(View.Group_TopRight.Btn_TabBreakThrough)
  end,
  Group_TopRight_Btn_TabResonance_click = function(str)
    if DataModel.RoleData.level >= 100 then
      BtnController:Click(View.Group_TopRight.Btn_TabResonance)
    else
      print("等级没到，不可以打开共振")
    end
  end,
  Group_TopRight_Btn_TabTalent_click = function(str)
    BtnController:Click(View.Group_TopRight.Btn_TabTalent)
  end
}
return ViewFunction
