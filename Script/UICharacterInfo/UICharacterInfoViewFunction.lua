local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = require("UICharacterInfo/DataModel")
local DataModelCharacter = require("UICharacterInfo/UICharacterInfoDataModel")
local Controller = require("UICharacterInfo/UICharacterInfoController")
local AwakeLoader = require("UICharacterInfo/ViewAwake")
local InfoLoader = require("UICharacterInfo/ViewInfo")
local CommonItem = require("Common/BtnItem")
local BreakThroughLoader = require("UICharacterInfo/ViewBreakThrough")
local BackgroundLoader = require("UICharacterInfo/ViewBackground")
local BtnController = require("UICharacterInfo/Model_Btn")
local SkillLoader = require("UICharacterInfo/ViewSkill")
local ResonanceLoader = require("UICharacterInfo/ViewResonance")
local SkillInfo = require("UICharacterInfo/ViewSkillInfo")
local FileLoader = require("UICharacterInfo/ViewFile")
local CharacterDragSetting = require("UICharacterInfo/DragSetting")
local StartBattle = require("UISquads/View_StartBattle")
local UISquadDataController = require("UISquads/UISquadsDataController")
DataModel.lock_Add = false
DataModel.click_time = 0
DataModel.oldIndex = 0
local Report_Awaken = {}
local Report_Break = {}
local Init_Awaken = function()
  Report_Awaken = {}
  Report_Awaken.hero_id = ""
  Report_Awaken.hero_name = ""
  Report_Awaken.hero_level = ""
  Report_Awaken.origin_awaken = ""
  Report_Awaken.new_awaken = ""
  Report_Awaken.resource_cost = "item_cost" .. ":"
  Report_Awaken.event_seq = ""
  Report_Awaken.is_cast = ""
end
local Init_Break = function()
  Report_Break = {}
  Report_Break.hero_id = ""
  Report_Break.hero_name = ""
  Report_Break.hero_level = ""
  Report_Break.origin_break = ""
  Report_Break.new_break = ""
  Report_Break.resource_cost = "item_cost" .. ":"
  Report_Break.event_seq = ""
  Report_Break.is_cast = ""
end
local GetResidueNum = function()
  local count = 0
  for k, v in pairs(DataModel.RoleData.equips) do
    if v ~= "" then
      count = count + 1
    end
  end
  return count
end
local Clear = function()
  if DataModel.InstantiateList then
    for k, v in pairs(DataModel.InstantiateList) do
      Object.Destroy(v)
    end
  end
end
local ClearCheck = function()
  if DataModel.InstantiateCheckList then
    for k, v in pairs(DataModel.InstantiateCheckList) do
      Object.Destroy(v)
    end
  end
end
local ClearCheckRight = function()
  if DataModel.InstantiateCheckRightList then
    for k, v in pairs(DataModel.InstantiateCheckRightList) do
      Object.Destroy(v)
    end
  end
end
local baseDesHight = 78
local SetDownSkill = function(obj, row, index)
  obj.transform:Find("Img_WordIcon").transform:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(row.icon)
  obj.transform:Find("Txt_Word").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText("<color=#FFB800>" .. row.tagNameRichText .. "：" .. "</color>" .. row.detail)
  local hight_des = obj.transform:Find("Txt_Word").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
  end
  return Hight
end
local SetDownAllSkill = function(view_skill, skillData)
  local lastY = 0
  local img_desc_y = 70
  local img_desc_x = 510
  local top_des_height = img_desc_y
  local lastY_1 = 0
  local lastY_1_Bg = 0
  local count = 1
  local baseViewSpace = 668
  local space = 0
  local Content = view_skill.ScrollView_Content.Viewport.Content
  Content.self:SetLocalPositionY(0)
  local Parent = Content.transform
  Content.Group_Top.Txt_Desc:SetText(skillData.ca.description)
  Content.Group_Top.Img_Desc:SetImgWidthAndHeight(img_desc_x, 0)
  local des_height = Content.Group_Top.Txt_Desc:GetHeight()
  if img_desc_y < des_height then
    top_des_height = des_height + 10
    Content.Group_Top.Img_Desc:SetImgWidthAndHeight(img_desc_x, 0)
  end
  lastY_1 = lastY_1 - top_des_height
  local Group_Word_Obj = "UI/CharacterInfo/CharacterInfo_splited/Group_Word"
  space = top_des_height
  for i = 1, table.count(skillData.cardCA.tagList) do
    local talentCA = PlayerData:GetFactoryData(skillData.cardCA.tagList[i].tagId)
    if talentCA.isShowDetail == true then
      local obj = View.self:GetRes(Group_Word_Obj, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel.InstantiateCheckList, obj)
      local hight_des = SetDownSkill(obj, talentCA, count)
      lastY_1_Bg = hight_des
      space = space + hight_des + hight
      count = count + 1
    end
    if baseViewSpace < space then
      view_skill.ScrollView_Content:SetContentHeight(space)
    end
  end
end
local OpenSkillCardCheck = function(index)
  local skillList = DataModel.SkillList[index]
  local skillData = {}
  skillData.ca = PlayerData:GetFactoryData(skillList.id)
  skillData.cardCA = PlayerData:GetFactoryData(skillData.ca.cardID)
  skillData.num = skillList.num
  if skillList.ExSkillList == nil or skillList.ExSkillList and table.count(skillList.ExSkillList) == 0 then
    return
  end
  View.Group_CommonTopLeft.self:SetActive(false)
  DataModel.InstantiateCheckList = {}
  UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_SkillCheck")
  local Group_SkillCheck = View.Group_SkillCheck
  Group_SkillCheck.self:SetActive(true)
  Group_SkillCheck.Group_Skill.self:SetActive(false)
  Group_SkillCheck.Group_CaptainSkill.self:SetActive(false)
  local obj
  if index == 3 then
    Group_SkillCheck.Group_CaptainSkill.self:SetActive(true)
    obj = Group_SkillCheck.Group_CaptainSkill
    if skillData.ca.leaderCardConditionDesc ~= nil and skillData.ca.leaderCardConditionDesc ~= "" then
      obj.Txt_Captain:SetText(GetText(80600414) .. skillData.ca.leaderCardConditionDesc)
    end
  else
    Group_SkillCheck.Group_Skill.self:SetActive(true)
    obj = Group_SkillCheck.Group_Skill
  end
  obj.Img_Icon:SetSprite(skillData.ca.iconPath)
  obj.Txt_CardNumber:SetText(string.format(GetText(80600451), skillData.num))
  obj.Txt_Name:SetText(skillData.ca.name)
  obj.Txt_Cost:SetText(string.format(GetText(80600452), math.floor(skillData.cardCA.cost_SN)))
  obj.Img_open:SetActive(false)
  SetDownAllSkill(obj, skillData)
  DataModel.CheckIndex = 1
  Group_SkillCheck.Img_Detail.self:SetActive(false)
  DataModel.deriveCardList = skillList.ExSkillList
  Group_SkillCheck.ScrollGrid_ExCard.grid.self:SetDataCount(table.count(skillList.ExSkillList))
  Group_SkillCheck.ScrollGrid_ExCard.grid.self:RefreshAllElement()
end
local baseDesHight = 78
local SetCheckSkill = function(obj, row, index)
  obj.transform:Find("Img_WordIcon").transform:GetComponent(typeof(CS.Seven.UIImg)):SetSprite(row.icon)
  obj.transform:Find("Txt_Word").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText("<color=#FFB800>" .. row.tagNameRichText .. "：" .. "</color>" .. row.detail)
  local hight_des = obj.transform:Find("Txt_Word").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
  end
  return Hight
end
local SetCheckRightAllSkill = function(view_skill, skillData)
  local lastY = 0
  local img_desc_y = 70
  local img_desc_x = 510
  local top_des_height = img_desc_y
  local lastY_1 = 0
  local lastY_1_Bg = 0
  local count = 1
  local baseViewSpace = 668
  local space = 0
  local Content = view_skill.ScrollView_Content.Viewport.Content
  Content.self:SetLocalPositionY(0)
  local Parent = Content.transform
  print_r(skillData)
  print_r("=====================")
  Content.Group_Top.Txt_Desc:SetText(skillData.skillCA.description)
  local des_height = Content.Group_Top.Txt_Desc:GetHeight()
  if img_desc_y < des_height then
    top_des_height = des_height + 10
  end
  lastY_1 = lastY_1 - top_des_height
  local Group_Word_Obj = "UI/CharacterInfo/CharacterInfo_splited/Group_Word"
  space = top_des_height
  for i = 1, table.count(skillData.cardCA.tagList) do
    local talentCA = PlayerData:GetFactoryData(skillData.cardCA.tagList[i].tagId)
    if talentCA.isShowDetail == true then
      local obj = View.self:GetRes(Group_Word_Obj, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel.InstantiateCheckRightList, obj)
      local hight_des = SetCheckSkill(obj, talentCA, count)
      lastY_1_Bg = hight_des
      space = space + hight_des + hight
      count = count + 1
    end
    if baseViewSpace < space then
      view_skill.ScrollView_Content:SetContentHeight(space)
    end
  end
  return space
end
local OpenCheckRight = function(row)
  DataModel.InstantiateCheckRightList = {}
  local img_base = 234
  local img_weight = 634
  local Img_Detail = View.Group_SkillCheck.Img_Detail
  Img_Detail.self:SetActive(true)
  local space = SetCheckRightAllSkill(Img_Detail, row)
  if img_base < space + 70 then
    Img_Detail:SetImgWidthAndHeight(img_weight, space + 70, 0)
    Img_Detail.ScrollView_Content:SetViewportHeight(space)
  else
    Img_Detail:SetImgWidthAndHeight(img_weight, img_base, 0)
    Img_Detail.ScrollView_Content:SetViewportHeight(img_base - 70)
  end
end
local AwakeSuccessRefresh = function(talentId)
  View.Group_CommonTopLeft.self:SetActive(false)
  View.Group_Middle.SpineAnimation_Character:SetActive(false)
  View.Group_AwakeSuccess.self:SetActive(true)
  local talent_info = PlayerData:GetFactoryData(talentId)
  local Group_AwakeSuccess = View.Group_AwakeSuccess
  Group_AwakeSuccess.Txt_TalentDetail:SetText(talent_info.desc)
  Group_AwakeSuccess.Txt_TalentName:SetText(talent_info.name)
  Group_AwakeSuccess.Img_TalentIcon:SetSprite(UIConfig.CharacterAwake[DataModel.RoleData.awake_lv])
  for i = 1, 5 do
    local obj = "Group_Star" .. i
    Group_AwakeSuccess.Group_Star[obj].Img_White:SetActive(false)
    if i <= DataModel.RoleData.awake_lv then
      Group_AwakeSuccess.Group_Star[obj].Img_White:SetActive(true)
    end
  end
  local portraitId = DataModel.RoleData.current_skin[1]
  portraitId = 0
  if portraitId == nil or portraitId == 0 then
    local viewCa = PlayerData:GetFactoryData(DataModel.RoleCA.viewId, "UnitViewFactory")
    portraitId = DataModel.RoleCA.viewId
  end
  local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
  if portrailData.spineUrl ~= nil and portrailData.spineUrl ~= "" then
    Group_AwakeSuccess.Group_Role.Img_Role:SetActive(false)
    local spineUrl = portrailData.spineUrl
    if DataModel.RoleData.resonance_lv == 5 and portrailData.spine2Url ~= nil and portrailData.spine2Url ~= "" then
      spineUrl = portrailData.spine2Url
      View.Group_Middle.SpineAnimation_Character.transform.localPosition = Vector3(DataModel.InfoInitPos.x - 100 + portrailData.spine2X, portrailData.spine2Y, 0)
      View.Group_Middle.SpineSecondMode_Character.transform.localPosition = View.Group_Middle.SpineAnimation_Character.transform.localPosition
      View.Group_Middle.SpineAnimation_Character:SetLocalScale(Vector3(portrailData.spine2Scale, portrailData.spine2Scale, 1))
    else
      View.Group_Middle.SpineAnimation_Character:SetLocalScale(Vector3(100, 100, 1))
    end
    Group_AwakeSuccess.Group_Role.SpineAnimation_Role:SetActive(true)
    Group_AwakeSuccess.Group_Role.SpineAnimation_Role:SetData(spineUrl)
  else
    View.Group_Middle.SpineAnimation_Character:SetActive(false)
    Group_AwakeSuccess.Group_Role.Img_Role:SetActive(true)
    Group_AwakeSuccess.Group_Role.Img_Role:SetSprite(portrailData.resUrl)
    if DataModel.InfoInitPos.isRecord then
      DataModel.InfoInitPos.isRecord = false
      local transform = View.Group_Middle.transform
      Group_AwakeSuccess.Group_Role.Img_Role.self:SetLocalPositionX(DataModel.InfoInitPos.x)
      DataModel.InfoInitPos.y = transform.localPosition.y
      DataModel.InfoInitPos.scale = transform.localScale.x
    end
    DataModel.InfoInitPos.offsetX = portrailData.offsetX
    DataModel.InfoInitPos.offsetY = portrailData.offsetY
  end
end
local PlayResonanceAni = function(index, callback)
  local cong_ani = {
    [1] = "ResonanceTurnTo120",
    [2] = "ResonanceTurnTo240",
    [0] = "ResonanceTurnTo360"
  }
  View.self:PlayAnim(cong_ani[index], callback)
end
local SetItemSetGridData = function(element, data)
  element.Group_Cost.Txt_Need:SetText(data.num)
  element.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.Factory.qualityInt + 1])
  element.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[data.Factory.qualityInt + 1])
  element.Group_Item.Img_Item:SetSprite(data.Factory.iconPath)
  local haveNum = PlayerData:GetGoodsById(data.id).num
  local needNum = data.num
  if data.id == 11400001 then
    element.Group_Cost.Txt_Have:SetText("")
    element.Group_Cost.Txt_And:SetText("")
    if haveNum >= needNum then
      element.Group_Cost.Txt_Need:SetColor(UIConfig.Color.White)
    else
      element.Group_Cost.Txt_Need:SetColor(UIConfig.Color.Red)
    end
  else
    element.Group_Cost.Txt_Have:SetText(haveNum)
    element.Group_Cost.Txt_And:SetText("/")
    if haveNum >= needNum then
      element.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
    else
      element.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
    end
  end
  if PlayerData:GetGoodsById(data.id).num >= data.num then
    element.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
  else
    element.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
  end
end
local changeTab = function(index, isDrag)
  if index == DataModel.oldIndex and not DataModel.InitAnimatorState and not isDrag then
    return
  end
  View.Group_Middle.Img_BlackMask:SetActive(false)
  DataModelCharacter.CloseCardDes()
  if DataModel.oldIndex == 2 then
    Clear()
  end
  local num = "1"
  if index < DataModel.oldIndex then
    num = "2"
  end
  local old = DataModel.TabEnum[DataModel.oldIndex]
  if old and old.btn then
    old.btn.Img_N.self:SetActive(true)
    old.btn.Img_P.self:SetActive(false)
  end
  if old and old.view and not isDrag then
    old.view.self:SetActive(false)
    if DataModel.oldIndex == 1 or DataModel.oldIndex == 5 then
    elseif old["out" .. num] then
    end
  end
  local new = DataModel.TabEnum[index]
  if new.btn then
    new.btn.Img_N.self:SetActive(false)
    new.btn.Img_P.self:SetActive(true)
  end
  if new.view then
    new.view.self:SetActive(true)
    if isDrag or DataModel.InitAnimatorState or index == 1 or index == 4 then
    elseif new["in" .. num] then
    end
  end
  if new.loader then
    new.loader:Load()
  end
  if new.isDrag then
    View.Group_Middle.Drag_Spine:SetActive(new.isDrag)
  else
    View.Group_Middle.Drag_Spine:SetActive(false)
  end
  DataModel.oldIndex = index
  DataModel.InitAnimatorState = false
  View.Group_Files.self:SetActive(false)
end
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
      LevelUpLoader:Load()
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
local SetEquipment = function(data, element, index)
  if data == nil then
    local eid = DataModel.RoleData.equips[1]
    if index == 2 then
      element.Img_Ban:SetActive(false)
      if eid ~= nil and eid ~= "" then
        local equip_server = PlayerData:GetEquipByEid(eid)
      end
    end
    element.Img_Bottom:SetActive(false)
    element.Img_Mask:SetActive(false)
    element.Img_Item:SetActive(false)
    element.Group_EType:SetActive(false)
  else
    element.Img_Item:SetActive(true)
    element.Img_Bottom:SetActive(true)
    element.Img_Mask:SetActive(true)
    element.Group_EType:SetActive(true)
    local index = PlayerData:GetTypeInt("enumEquipTypeList", data.equipTagId)
    element.Group_EType.Img_Icon:SetSprite(UIConfig.EquipmentTypeMark[index])
    element.Group_EType.Img_IconBg:SetSprite(UIConfig.EquipmentTypeMarkBg[data.qualityInt])
    element.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.qualityInt + 1])
    element.Img_Mask:SetSprite(UIConfig.MaskConfig[data.qualityInt + 1])
    element.Img_Item:SetSprite(data.iconPath)
  end
end
local baseBgHeight = 400
local baseDesHeight = 80
local TurnResonanceActive = function(isActive)
  if DataModel.RightResonanceIndex then
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabResonance")
    local Group_AwakeIcon = View.Group_TabResonance.Group_AwakeIcon
    local img = "Group_Stage0" .. DataModel.RightResonanceIndex
    local Img_resonanceselect = Group_AwakeIcon[img].Img_resonanceselect
    Img_resonanceselect:SetActive(isActive)
  end
end
local ShowNewResonance = function(index)
  if index > table.count(DataModel.RoleCA.talentList) then
    return
  end
  DataModel.RightResonanceIndex = index
  UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabResonance")
  local Group_ResonanceSuccess = View.Group_TabResonance.Group_ResonanceCheck
  Group_ResonanceSuccess.self:SetActive(true)
  Group_ResonanceSuccess.Img_ResonanceIconBase:SetActive(true)
  View.Group_TabResonance.Btn_CloseCheck:SetActive(true)
  View.Group_Middle.Img_BlackMask:SetActive(true)
  local talentId = DataModel.RoleCA.talentList[index].talentId
  local data = PlayerData:GetFactoryData(talentId, "AwakeFactory")
  Group_ResonanceSuccess.Txt_Name:SetText(data.name)
  Group_ResonanceSuccess.Txt_Des:SetText(data.desc)
  Group_ResonanceSuccess.Txt_Des:OnTextChange()
  Group_ResonanceSuccess.Img_ResonanceIconBase.Img_ResonanceIcon:SetSprite(data.path)
  local Group_AwakeIcon = View.Group_TabResonance.Group_AwakeIcon
  for i = 1, 5 do
    local img = "Group_Stage0" .. i
    local Img_resonanceselect = Group_AwakeIcon[img].Img_resonanceselect
    Img_resonanceselect:SetActive(false)
    if index == i then
      Img_resonanceselect:SetActive(true)
    end
  end
  local homeSkillList = DataModel.RoleCA.homeSkillList
  local life_id, need_lv
  local skillPreParamRecord = {}
  for i, v in ipairs(homeSkillList) do
    if v.nextIndex and v.nextIndex > 0 then
      local nextId = homeSkillList[v.nextIndex].id
      local cfg = PlayerData:GetFactoryData(v.id, "HomeSkillFactory")
      skillPreParamRecord[nextId] = cfg.param
    end
    if v.resonanceLv == index then
      life_id = v.id
      need_lv = v.resonanceLv
      break
    end
  end
  View.Group_TabResonance.Group_ResonanceCheck.Group_LifeSkillDesc:SetActive(false)
  if life_id then
    local life_cfg = PlayerData:GetFactoryData(life_id)
    View.Group_TabResonance.Group_ResonanceCheck.Group_LifeSkillDesc.Img_Lock:SetActive(need_lv > DataModel.RoleData.resonance_lv)
    local desc = life_cfg.desc
    if life_cfg.isReplace then
      local param = life_cfg.param
      if skillPreParamRecord[life_id] then
        param = param + skillPreParamRecord[life_id]
      end
      if life_cfg.isPCT then
        param = param * 100
      else
        param = math.modf(param)
      end
      desc = string.format(desc, param)
    end
    View.Group_TabResonance.Group_ResonanceCheck.Group_LifeSkillDesc.Txt_SkillDesc:SetWidth(500)
    View.Group_TabResonance.Group_ResonanceCheck.Group_LifeSkillDesc.Txt_SkillDesc:SetText(desc)
    View.Group_TabResonance.Group_ResonanceCheck.Group_LifeSkillDesc.Txt_SkillName:SetText(life_cfg.name)
    View.Group_TabResonance.Group_ResonanceCheck.Group_LifeSkillDesc:SetActive(true)
  end
end
local ShowNewAwake = function(index)
  if index > table.count(DataModel.RoleCA.breakthroughList) then
    return
  end
  UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabAwake")
  local Group_AwakeCheck = View.Group_TabAwake.Group_AwakeCheck
  Group_AwakeCheck.self:SetActive(true)
  View.Group_TabAwake.Btn_CloseCheck:SetActive(true)
  View.Group_Middle.Img_BlackMask:SetActive(true)
  local breakthroughId = DataModel.RoleCA.breakthroughList[index + 1].breakthroughId
  local data = PlayerData:GetFactoryData(breakthroughId)
  Group_AwakeCheck.Txt_Name:SetText(data.name)
  Group_AwakeCheck.Txt_Des:SetText(data.desc)
  Group_AwakeCheck.Txt_Des:OnTextChange()
  Group_AwakeCheck.Img_AwakeIconBase.Img_AwakeIcon:SetSprite(data.path)
  local Group_Icon1 = View.Group_TabAwake.Group_Icon1
  for i = 1, 5 do
    local img = "Group_SkillIcon" .. i
    local Img_lightselect = Group_Icon1[img].Img_lightselect
    Img_lightselect:SetActive(false)
    if index == i then
      Img_lightselect:SetActive(true)
    end
  end
end
local CloseNewResonance = function()
  View.Group_ResonanceSuccess.self:SetActive(false)
end
local CloseNewAwake = function()
  View.Group_AwakeCheck.self:SetActive(false)
end
local ViewFunction = {
  CharacterInfo_Group_TopRight_Btn_TabInfo_Click = function(btn, str)
    changeTab(1)
    BtnController.RefreshSetRole(DataModel.RoleId)
  end,
  CharacterInfo_Group_TopRight_Btn_TabAwake_Click = function(btn, str)
    changeTab(4)
    BtnController.RefreshSetRole(DataModel.RoleId)
  end,
  CharacterInfo_Group_TopRight_Btn_TabResonance_Click = function(btn, str)
    changeTab(3)
    BtnController.RefreshSetRole(DataModel.RoleId)
  end,
  CharacterInfo_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    DataModelCharacter.CloseCardDes()
    Clear()
    if DataModel.oldIndex == 5 then
      changeTab(1)
      BtnController.RefreshSetRole(DataModel.RoleId)
    else
      View.self:PlayAnim("Out")
      if DataModel.fromView == EnumDefine.CommonFilterType.SquadView then
        UIManager:GoBack()
      else
        UIManager:GoBack()
      end
    end
  end,
  CharacterInfo_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UISquadsGlobalData:ResetSelectSquadIndex()
    DataModelCharacter.CloseCardDes()
    Clear()
    View.self:PlayAnim("Out")
    MapNeedleData.GoHome()
  end,
  CharacterInfo_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabInfo_Group_TIBottomLeft_Btn_Skin_Click = function(btn, str)
    DataModel.isOpenSkin = true
    local params = {}
    params.RoleId = DataModel.RoleId
    params.RoleData = DataModel.RoleData
    params.RoleCA = DataModel.RoleCA
    params.isSkinView = false
    View.Group_TabInfo.self:SetActive(false)
    local callback = function()
      View.Group_TabInfo.self:SetActive(true)
      View.Group_Middle.Img_Black:SetActive(true)
      View.Group_Middle.Img_Bg:SetActive(true)
      DataModel.isOpenSkin = false
    end
    View.Group_Middle.Img_Black:SetActive(false)
    View.Group_Middle.Img_Bg:SetActive(false)
    View.Group_CommonTopLeft:SetActive(false)
    CommonTips.OpenSkinViewTips(params, callback)
  end,
  CharacterInfo_Group_TabInfo_Group_TIBottomLeft_Btn_Information_Click = function(btn, str)
    View.Group_TabInfo.self:SetActive(false)
    local data = {}
    data.status = 1
    data.roleId = DataModel.RoleId
    DataModel.openFilePanel = true
    DataModel.DragRoleId = DataModel.RoleId
    View.Group_CommonTopLeft:SetActive(false)
    UIManager:Open("UI/CharacterInfo/File/File", Json.encode(data), nil, function()
      View.Group_TabInfo.self:SetActive(true)
      DataModel.openFilePanel = false
      View.Group_CommonTopLeft:SetActive(true)
    end)
  end,
  CharacterInfo_Group_TabInfo_Group_TIBottomLeft_Btn_Show_Click = function(btn, str)
    View.Group_TabInfo.self:SetActive(false)
    local data = {}
    data.status = 2
    data.roleId = DataModel.RoleId
    DataModel.openFilePanel = true
    UIManager:Open("UI/CharacterInfo/File/File", Json.encode(data))
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIMiddle_Btn_LvUp_Click = function(btn, str)
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabSkill")
    View.Group_TabSkill.self:SetActive(true)
    changeTab(2)
    BtnController.RefreshSetRole(DataModel.RoleId)
  end,
  CharacterInfo_Group_TopRight_Btn_TabSkill_Click = function(btn, str)
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabSkill")
    View.Group_TabSkill.self:SetActive(true)
    changeTab(2)
    BtnController.RefreshSetRole(DataModel.RoleId)
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIBottom_StaticGrid_Equipment_SetGrid = function(element, elementIndex)
    local eid = DataModel.RoleData.equips[elementIndex]
    element.Btn_Item:SetClickParam(tonumber(elementIndex))
    element.Group_Equipment.Btn_Item:SetClickParam(tonumber(elementIndex))
    element.Btn_Item:SetActive(true)
    local equip = PlayerData:GetEquipByEid(eid)
    element.Img_Ban:SetActive(false)
    element.Group_Equipment.Img_NoType:SetActive(false)
    element.Group_Equipment.Img_Select:SetActive(false)
    local tagID = DataModel.RoleCA.equipmentSlotList[elementIndex].tagID
    local index = PlayerData:GetFactoryData(tagID).typeID
    element.Btn_Item.Img_Type:SetSprite(UIConfig.EquipBgType[index])
    if equip == nil then
      element.Group_Equipment:SetActive(false)
    else
      local list = {}
      list.data = PlayerData:GetFactoryData(equip.id)
      list.server = equip
      element.Group_Equipment:SetActive(true)
      CommonItem:SetEquipment(element.Group_Equipment, list, false)
      element.Group_Equipment.Group_Face:SetActive(false)
      element.Group_Equipment.Img_Lock:SetActive(false)
    end
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIBottom_StaticGrid_Equipment_Group_Equipment_Btn_Item_Click = function(btn, str)
    local residueNum = GetResidueNum()
    local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.RoleCA.equipmentSlotList[tonumber(str)].tagID)
    local params = {
      Type = typeInt,
      RoleId = DataModel.RoleId,
      Index = tonumber(str),
      ResidueNum = residueNum,
      RoleCA = DataModel.RoleCA
    }
    CommonTips.OpenGroupWeapon(params)
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIBottom_StaticGrid_Equipment_Group_Equipment_Group_Equipment_Btn_Item_Click = function(btn, str)
    local residueNum = GetResidueNum()
    local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.RoleCA.equipmentSlotList[tonumber(str)].tagID)
    local params = {
      Type = typeInt,
      RoleId = DataModel.RoleId,
      Index = tonumber(str),
      ResidueNum = residueNum,
      RoleCA = DataModel.RoleCA
    }
    CommonTips.OpenGroupWeapon(params)
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIBottom_Group_Equipment_Group_Equipment_Btn_Item_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIMiddle_StaticGrid_Skill_SetGrid = function(element, elementIndex)
    element.Btn_Skill:SetClickParam(tostring(elementIndex))
    element.Txt_SkillLV.Txt_Num:SetText(DataModel.RoleData.skills[elementIndex] and DataModel.RoleData.skills[elementIndex].lv or 1)
    local skillId = DataModel.RoleCA.skillList[tonumber(elementIndex)].skillId
    local data = PlayerData:GetFactoryData(skillId, "SkillFactory")
    element.Txt_Name:SetText(data.name)
    element.Img_Icon:SetSprite(data.iconPath)
    local cardCA = PlayerData:GetFactoryData(data.cardID)
    element.Img_Icon:SetColor(Color.white)
    if cardCA.color == "Red" then
      element.Img_Icon:SetColor(GameSetting.redCardColor)
    end
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIMiddle_StaticGrid_Skill_Group_Item_Btn_Skill_Click = function(btn, str)
    local aa = {}
    local skill = DataModel.SkillList[tonumber(str)]
    aa.id = skill.id
    aa.type = 4
    aa.description = skill.des
    aa.detailDescription = skill.detailDescription
    DataModelCharacter.OpenCardDes(aa)
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIMiddle_Btn_Close_Des_Click = function(btn, str)
    DataModelCharacter.CloseCardDes()
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIMiddle_Group_Item_Btn_Skill_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIBottom_Group_Equipment_Btn_Item_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TITop_Img_LevelBottom_Btn_LevelUp_Click = function(btn, str)
    UIManager:Open("UI/CharacterInfo/Group_TabLevelUp", Json.encode({
      roleId = DataModel.RoleData.id,
      ui = "characterinfo"
    }))
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TITop_Btn_Attribute_Click = function(btn, str)
  end,
  CharacterInfo_Group_Middle_Drag_Spine_BeginDrag = function(direction, dragPos)
    DataModel.BeginDragPosX = dragPos.x
    local isSpine2 = DataModel.GetShowType() == "Spine2"
    if isSpine2 then
      DataModel.SpinePosX = View.Group_Middle.SpineSecondMode_Character:GetAnchoredPositionX()
    else
      DataModel.SpinePosX = View.Group_Middle.SpineAnimation_Character:GetAnchoredPositionX()
    end
    if DataModel.fromView == EnumDefine.CommonFilterType.SquadView then
      return
    end
  end,
  CharacterInfo_Group_Middle_Drag_Spine_EndDrag = function(direction, dragPos)
    if DataModel.fromView == EnumDefine.CommonFilterType.SquadView then
      return
    end
    if not DataModel.DragOver then
      View.self:SetRaycastBlock(false)
      local showType = DataModel.GetShowType()
      local isSpine2 = showType == "Spine2"
      local isSpine = showType == "Spine"
      local show, detail
      if isSpine2 then
        show = View.Group_Middle.SpineSecondMode_Character
        detail = View.Group_Middle.SpineSecondMode_Character
      elseif isSpine then
        show = View.Group_Middle.SpineAnimation_Character
        detail = View.Group_Middle.SpineAnimation_Character
      else
        show = View.Group_Middle.Group_Character
        detail = View.Group_Middle.Group_Character.Img_Character
      end
      if DataModel.live2D == 1 then
        show = View.Group_Middle.Group_Character
        detail = View.Group_Middle.Group_Character.Img_Character
      end
      local posX = BtnController.GetSpinePortraitPos()
      if not isSpine2 and not isSpine then
        posX = BtnController.GetPortraitPos()
      end
      DOTweenTools.DOLocalMoveXCallback(show.transform, posX, CharacterDragSetting.Time, nil, function()
        View.Group_Middle.Drag_Spine:SetAnchoredPositionX(posX)
      end)
      DOTweenTools.DOLocalMoveX(DataModel.TabEnum[DataModel.oldIndex].view.self.transform, DataModel.TabEnum[DataModel.oldIndex].posX, CharacterDragSetting.Time)
      DOTweenTools.DOFadeColorCallback(detail, Color(1, 1, 1, 1), CharacterDragSetting.Time, function()
        DataModel.TabEnum[DataModel.oldIndex].view.self:SetEnableAnimator(true)
        View.self:SetRaycastBlock(true)
      end)
      DOTweenTools.DOFade(DataModel.TabEnum[DataModel.oldIndex].view.self.transform, 1, CharacterDragSetting.Time)
    end
    DataModel.DragOver = false
  end,
  CharacterInfo_Group_Middle_Drag_Spine_OnDrag = function(direction, dragPos)
    if DataModel.fromView == EnumDefine.CommonFilterType.SquadView then
      return
    end
    if DataModel.DragOver or not DataModel.BeginDragPosX then
      return
    end
    local showType = DataModel.GetShowType()
    local isSpine2 = showType == "Spine2"
    local isSpine = showType == "Spine"
    local show, detail
    local posX = DataModel.SpinePosX
    if isSpine2 then
      show = View.Group_Middle.SpineSecondMode_Character
      detail = View.Group_Middle.SpineSecondMode_Character
    elseif isSpine then
      show = View.Group_Middle.SpineAnimation_Character
      detail = View.Group_Middle.SpineAnimation_Character
    else
      show = View.Group_Middle.Group_Character
      detail = View.Group_Middle.Group_Character.Img_Character
      posX = DataModel.ImgCharacterPosX
    end
    if DataModel.live2D == 1 then
      show = View.Group_Middle.Group_Character
      detail = View.Group_Middle.Group_Character.Img_Character
      posX = DataModel.ImgCharacterPosX
    end
    local dragPosX = dragPos.x
    local viewPosX = DataModel.TabEnum[DataModel.oldIndex].posX
    DataModel.DragOverPosX = posX + (dragPosX - DataModel.BeginDragPosX) * CharacterDragSetting.DragCharacterRatio
    DataModel.DragOverViewPosX = viewPosX + (dragPosX - DataModel.BeginDragPosX) * CharacterDragSetting.DragViewRatio
    local limit = Screen.width / 200
    local offset = math.abs(DataModel.DragOverPosX - posX)
    show:SetAnchoredPositionX(DataModel.DragOverPosX)
    detail:SetColor(Color(1, 1, 1, 1 - offset / Screen.width * 4))
    View.Group_Middle.Drag_Spine:SetAnchoredPositionX(DataModel.DragOverPosX)
    DataModel.TabEnum[DataModel.oldIndex].view.self:SetAlpha(1 - offset / Screen.width * 4)
    DataModel.TabEnum[DataModel.oldIndex].view.self:SetEnableAnimator(false)
    View.self:SetRaycastBlock(true)
    DataModel.TabEnum[DataModel.oldIndex].view.self:SetAnchoredPositionX(DataModel.DragOverViewPosX)
    if math.abs(DataModel.DragOverPosX - posX) >= Screen.width / 5 then
      DataModel.DragOver = true
      View.self:SetRaycastBlock(false)
      DOTweenTools.DOFade(DataModel.TabEnum[DataModel.oldIndex].view.self.transform, 0, CharacterDragSetting.Time)
      DOTweenTools.DOFadeColorCallback(detail, Color(1, 1, 1, 0), CharacterDragSetting.Time)
      DOTweenTools.DOLocalMoveX(DataModel.TabEnum[DataModel.oldIndex].view.self.transform, DataModel.DragOverViewPosX > 0 and Screen.width or -Screen.width, CharacterDragSetting.Time)
      DOTweenTools.DOLocalMoveXCallback(show.transform, DataModel.DragOverPosX > 0 and Screen.width or -Screen.width, CharacterDragSetting.Time, nil, function()
        BtnController.NextRole(DataModel.DragOverPosX < 0)
        changeTab(DataModel.oldIndex, true)
        BtnController.RefreshSetRole(DataModel.RoleId)
        if DataModel.TabEnum[4].btn.Img_RedPoint then
          DataModel.TabEnum[4].btn.Img_RedPoint:SetActive(PlayerData:GetAllRoleAwakeRedID(tostring(DataModel.RoleId)))
        end
        if DataModel.openFilePanel then
          DataModel.DragRoleId = DataModel.RoleId
          View.Group_TabInfo.self:SetActive(false)
          local data = {}
          data.status = 1
          data.roleId = DataModel.RoleId
          local UIFileLuaBehaviour = require("UIFile/UIFileLuaBehaviour")
          UIFileLuaBehaviour[1].deserialize(Json.encode(data))
        end
        if DataModel.isOpenSkin then
          DataModel.DragRoleId = DataModel.RoleId
          View.Group_TabInfo.self:SetActive(false)
          local params = {}
          params.RoleId = DataModel.RoleId
          params.RoleData = DataModel.RoleData
          params.RoleCA = DataModel.RoleCA
          local UISkinLuaBehaviour = require("UISkin/UISkinLuaBehaviour")
          UISkinLuaBehaviour[1].deserialize(Json.encode(params))
        end
        showType = DataModel.GetShowType()
        isSpine2 = showType == "Spine2"
        isSpine = showType == "Spine"
        posX = BtnController.GetSpinePortraitPos()
        if isSpine2 then
          show = View.Group_Middle.SpineSecondMode_Character
        elseif isSpine then
          show = View.Group_Middle.SpineAnimation_Character
        else
          show = View.Group_Middle.Group_Character
          posX = BtnController.GetPortraitPos()
        end
        show:SetAnchoredPositionX(-(DataModel.DragOverPosX > 0 and Screen.width or -Screen.width))
        DataModel.TabEnum[DataModel.oldIndex].view.self:SetAnchoredPositionX(-(0 < DataModel.DragOverViewPosX and Screen.width or -Screen.width))
        DOTweenTools.DOFade(DataModel.TabEnum[DataModel.oldIndex].view.self.transform, 1, CharacterDragSetting.Time)
        DOTweenTools.DOFadeColorCallback(detail, Color(1, 1, 1, 1), CharacterDragSetting.Time)
        DOTweenTools.DOLocalMoveXCallback(show.transform, posX, CharacterDragSetting.Time, nil, function()
          DataModel.SerializeData.currentRoleId = DataModel.RoleId
          DataModel.TabEnum[DataModel.oldIndex].view.self:SetEnableAnimator(true)
          View.self:SetRaycastBlock(true)
          View.Group_Middle.Drag_Spine:SetAnchoredPositionX(posX)
        end)
        DOTweenTools.DOLocalMoveX(DataModel.TabEnum[DataModel.oldIndex].view.self.transform, DataModel.TabEnum[DataModel.oldIndex].posX, CharacterDragSetting.Time)
      end)
    else
    end
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_Attribute_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.RoleAttributeCurrent[tonumber(elementIndex)]
    element.Txt_Name:SetText(row.name)
    element.Img_Icon:SetSprite(row.sprite)
    if tonumber(elementIndex) > 5 then
      if tonumber(elementIndex) == 8 then
        element.Txt_PreNum:SetText("")
        if DataModel.RoleCA.spName == "" then
          element.Txt_Name:SetText("无")
        else
          element.Txt_Name:SetText(DataModel.RoleCA.spName .. ":" .. row.num)
        end
      else
        element.Txt_PreNum:SetText(row.num ~= nil and row.num or "无")
      end
    else
      element.Txt_PreNum:SetText(PlayerData:GetAttributeShow(row.name, row.num, 2))
    end
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TITop_Img_BKBottom_StaticGrid_BK_SetGrid = function(element, elementIndex)
    element.Img_On:SetActive(false)
    if elementIndex <= DataModel.RoleData.awake_lv then
      element.Img_On:SetActive(true)
    end
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_Check_Btn_Attribute_Click = function(btn, str)
    CommonTips.OpenRoleDetail(DataModel.RoleId)
  end,
  CharacterInfo_Group_TabInfo_Group_TIBottomLeft_Group_Type_StaticGrid_Type_SetGrid = function(element, elementIndex)
  end,
  CharacterInfo_Group_TabInfo_Group_TIBottomLeft_Group_Type_StaticGrid_Type_Group_Item_Btn_Bg_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabInfo_Group_TIBottomLeft_Group_Type_Group_Item_Btn_Bg_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabInfo_Group_TIBottomLeft_Btn_Test_Click = function(btn, str)
    local idList = {
      {
        id = DataModel.RoleId
      }
    }
    local tRoleDataList = UISquadDataController:GetRoleDataList(idList)
    StartBattle:StartBattleTest(PlayerData:GetFactoryData(99900001, "ConfigFactory").testLevelId, tRoleDataList)
  end,
  CharacterInfo_Group_TabInfo_Btn_Trust_Click = function(btn, str)
    local growthCfg = PlayerData:GetFactoryData(DataModel.RoleCA.growthId)
    local atk_SN = math.floor(growthCfg.gAtk_SN * math.floor(DataModel.roleTrustLv / 2))
    local hp_SN = math.floor(growthCfg.gHp_SN * math.floor(DataModel.roleTrustLv / 2))
    local def_SN = math.floor(growthCfg.gDef_SN * math.floor(DataModel.roleTrustLv / 2))
    local Img_Bonus = View.Group_TabInfo.Btn_Trust.Img_Bonus
    Img_Bonus:SetActive(true)
    Img_Bonus.Txt_Atk1:SetText("+" .. atk_SN)
    Img_Bonus.Txt_Def1:SetText("+" .. def_SN)
    Img_Bonus.Txt_Hp1:SetText("+" .. hp_SN)
  end,
  CharacterInfo_Group_TabInfo_Btn_Trust_Img_Bonus_Btn_CloseBonus_Click = function(btn, str)
    View.Group_TabInfo.Btn_Trust.Img_Bonus:SetActive(false)
  end,
  CharacterInfo_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabInfo_Group_TIBottomLeft_Btn_LifeSkill_Click = function(btn, str)
    UIManager:Open("UI/LifeSkillTips/LifeSkillTips", tostring(DataModel.RoleId))
  end,
  CharacterInfo_Group_TabInfo_Group_TIBottomLeft_Btn_Information_Btn_Blocked_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIMiddle_Group_CardDesCharacter_Btn_Close_Click = function(btn, str)
  end,
  CharacterInfo_Group_SkillLvup_Btn_BG_Click = function(btn, str)
    View.Group_SkillLvup.self:SetActive(false)
  end,
  CharacterInfo_Group_SkillLvup_Btn_Lvup_Click = function(btn, str)
    SkillLoader:SkillUp()
  end,
  CharacterInfo_Group_SkillLvup_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local data = DataModel.StaticGrid_Item_SetGrid(tonumber(elementIndex))
    if data == nil then
      element.self:SetActive(false)
      return
    end
    element.self:SetActive(true)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    SetItemSetGridData(element, data)
  end,
  CharacterInfo_Group_CareerDetail_Btn_BG_Click = function(btn, str)
    View.Group_CareerDetail.self:SetActive(false)
  end,
  CharacterInfo_Group_CareerDetail_StaticGrid_Career_SetGrid = function(element, elementIndex)
  end,
  CharacterInfo_Group_TabAwake_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local level = DataModel.RoleData.awake_lv
    if level >= #DataModel.RoleCA.breakthroughList - 1 then
      print("满级")
      element.self:SetActive(false)
      return
    end
    local bkId = DataModel.RoleCA.breakthroughList[level + 1].breakthroughId
    local materialList = PlayerData:GetFactoryData(bkId, "BreakthroughFactory").materialList
    local group = element
    element.self:SetActive(elementIndex <= #materialList)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    if elementIndex <= #materialList then
      local item = materialList[elementIndex]
      element.self:SetActive(true)
      local itemData = PlayerData:GetFactoryData(item.itemId, "SourceMaterialFactory")
      local needNum = item.num
      local haveNum = PlayerData:GetGoodsById(item.itemId).num
      group.Group_Cost.Txt_Need:SetText(needNum)
      group.Group_Cost.Txt_Have:SetText(haveNum)
      if needNum <= haveNum then
        group.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
      else
        group.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
      end
      local image = itemData.iconPath
      group.Group_Item.Img_Item:SetSprite(image)
      group.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[itemData.qualityInt + 1])
      group.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[itemData.qualityInt + 1])
      if element.Group_Break then
        element.Group_Break.self:SetActive(false)
        if type(itemData.breakPath) == "string" and itemData.breakPath ~= "" or type(itemData.breakPath) ~= "string" and itemData.breakPath then
          element.Group_Break.self:SetActive(true)
          element.Group_Break.Img_Mask.Img_Face:SetSprite(itemData.breakPath)
        end
      end
    end
  end,
  CharacterInfo_Group_TabAwake_StaticGrid_Item_Group_Consume_Group_Item_Btn_Item_Click = function(btn, str)
    local bkId = DataModel.RoleCA.breakthroughList[DataModel.RoleData.awake_lv + 1].breakthroughId
    local materialList = PlayerData:GetFactoryData(bkId, "BreakthroughFactory").materialList
    CommonTips.OpenRewardDetail(materialList[tonumber(str)].itemId)
  end,
  CharacterInfo_Group_SkillLvup_StaticGrid_Item_Group_Consume_Group_Item_Btn_Item_Click = function(btn, str)
    local data = DataModel.StaticGrid_Item_SetGrid(tonumber(str))
    CommonTips.OpenRewardDetail(data.id)
  end,
  CharacterInfo_Group_Files_Btn_Return_Click = function(btn, str)
    View.Group_Files.self:SetActive(false)
    View.Group_TabInfo.self:SetActive(true)
  end,
  CharacterInfo_Group_Files_Group_TIBottomLeft_Group_Career_Img_Career_Btn_Career_Click = function(btn, str)
  end,
  CharacterInfo_Group_Files_Btn_Close_Click = function(btn, str)
    View.Group_Files.self:SetActive(false)
    View.Group_TabInfo.self:SetActive(true)
  end,
  CharacterInfo_Group_Files_Btn_Home_Click = function(btn, str)
    View.self:PlayAnim("Out")
    UIManager:GoHome()
  end,
  CharacterInfo_Group_SkillLvup_Btn_LvLock_Click = function(btn, str)
    CommonTips.OpenTips(80600039)
  end,
  CharacterInfo_Group_TabResonance_Group_TAMiddle_Btn_Detail_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabResonance_Group_AwakeIcon_Group_Stage01_Btn_Stage_Click = function(btn, str)
    ShowNewResonance(1)
  end,
  CharacterInfo_Group_TabResonance_Group_AwakeIcon_Group_Stage02_Btn_Stage_Click = function(btn, str)
    ShowNewResonance(2)
  end,
  CharacterInfo_Group_TabResonance_Group_AwakeIcon_Group_Stage03_Btn_Stage_Click = function(btn, str)
    ShowNewResonance(3)
  end,
  CharacterInfo_Group_TabResonance_Group_AwakeIcon_Group_Stage04_Btn_Stage_Click = function(btn, str)
    ShowNewResonance(4)
  end,
  CharacterInfo_Group_TabResonance_Group_AwakeIcon_Group_Stage05_Btn_Stage_Click = function(btn, str)
    ShowNewResonance(5)
  end,
  CharacterInfo_Group_TabResonance_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local level = DataModel.RoleData.resonance_lv
    if level >= #DataModel.RoleCA.awakeList then
      return
    end
    local awakeId = DataModel.RoleCA.awakeList[level + 1].awakeId
    local data = PlayerData:GetFactoryData(awakeId, "AwakeFactory")
    local materialList = data.materialList
    local group = element
    group.Group_Consume.self:SetActive(elementIndex <= #materialList)
    group.Group_Consume.Group_Item.Btn_Item:SetClickParam(elementIndex)
    if elementIndex <= #materialList then
      local item = materialList[elementIndex]
      element.Group_Consume.self:SetActive(true)
      local itemData = PlayerData:GetFactoryData(item.itemId, "SourceMaterialFactory")
      local needNum = item.num
      local haveItem = PlayerData:GetGoodsById(item.itemId)
      local haveNum = haveItem.num or 0
      group.Group_Consume.Group_Cost.Txt_Need:SetText(needNum)
      group.Group_Consume.Group_Cost.Txt_Have:SetText(PlayerData:TransitionNum(haveNum))
      if needNum <= haveNum then
        group.Group_Consume.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
      else
        group.Group_Consume.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
      end
      group.Group_Consume.Group_Item.Img_Item:SetSprite(itemData.iconPath)
      group.Group_Consume.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[itemData.qualityInt + 1])
      group.Group_Consume.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[itemData.qualityInt + 1])
    else
    end
  end,
  CharacterInfo_Group_TabResonance_ScrollGrid_Item_Group_Item_Group_Consume_Group_Item_Btn_Item_Click = function(btn, str)
    local awakeId = DataModel.RoleCA.awakeList[DataModel.RoleData.resonance_lv + 1].awakeId
    local materialList = PlayerData:GetFactoryData(awakeId, "AwakeFactory").materialList
    CommonTips.OpenRewardDetail(materialList[tonumber(str)].itemId)
  end,
  CharacterInfo_Group_TabResonance_Btn_Awake_Click = function(btn, str)
    local callback = function()
      Init_Awaken()
      local level = DataModel.RoleData.resonance_lv
      if level >= #DataModel.RoleCA.awakeList - 1 then
        CommonTips.OpenTips(80600042)
        return
      end
      local awakeId = DataModel.RoleCA.awakeList[level + 1].awakeId
      local data = PlayerData:GetFactoryData(awakeId, "AwakeFactory")
      local materialList = data.materialList
      local isEnoughMaterial = true
      local items = {}
      local re_item = {}
      for i = 1, #materialList do
        local item = materialList[i]
        local needNum = item.num
        local haveItem = PlayerData:GetGoodsById(item.itemId)
        local haveNum = haveItem.num
        if needNum > haveNum and isEnoughMaterial then
          isEnoughMaterial = false
        end
        items[item.itemId] = needNum
        re_item[tostring(item.itemId)] = needNum
      end
      if not isEnoughMaterial then
        CommonTips.OpenTips(80600062)
        return
      end
      if DataModel.RoleData.lv < data.level then
        CommonTips.OpenTips(80600039)
        return
      end
      if isEnoughMaterial then
        Net:SendProto("hero.resonance", function(json)
          PlayerData:RefreshUseItems(items)
          Controller:OnResonanceSuccess(DataModel)
          local animName = "Stage0" .. DataModel.RoleData.resonance_lv + 1
          UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabResonance")
          View.self:SelectPlayAnim(View.Group_TabResonance.self, animName, function()
            DataModel.InitState = true
            DataModel.RoleData = PlayerData:GetRoleById(DataModel.RoleId)
            DataModel.RoleData.portrait_id = DataModel.RoleData.current_skin[1]
            CommonTips.OpenTips(80600075)
            DataModel.TabResonance_Lock = true
            ResonanceLoader:Load()
            CommonTips.OpenRoleResonanceSuccess(DataModel.RoleData, DataModel.RoleCA, DataModel.RoleCA.talentList[DataModel.RoleData.resonance_lv].talentId)
            local portraitId = DataModel.RoleData.current_skin[1]
            local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
            if portrailData.spineUrl ~= nil and portrailData.spineUrl ~= "" and DataModel.RoleData.resonance_lv == 5 and portrailData.isSpine2 == 1 then
              Net:SendProto("hero.change_skin", function(json)
                print_r(json)
                DataModel.RoleData.current_skin = PlayerData:GetRoleById(DataModel.RoleId).current_skin
                BackgroundLoader:Load()
                PlayerData.RefreshRoleInCoachSkin(DataModel.RoleId)
              end, DataModel.RoleId, portraitId, 1)
            end
            BtnController:SetSkillList()
          end)
        end, tostring(DataModel.RoleId), items)
      else
        return
      end
    end
    callback()
  end,
  CharacterInfo_Group_TabResonance_Btn_LvLock_Click = function(btn, str)
    local callback_no = function()
      TurnResonanceActive(true)
    end
    local callback_yes = function()
      UIManager:Open("UI/CharacterInfo/Group_TabLevelUp", Json.encode({
        roleId = DataModel.RoleData.id,
        ui = "characterinfo",
        index = DataModel.oldIndex
      }))
    end
    TurnResonanceActive(false)
    CommonTips.OnPrompt("80601854", nil, nil, callback_yes, callback_no)
  end,
  CharacterInfo_Group_TabAwake_Btn_BK_Click = function(btn, str)
    Init_Break()
    local level = DataModel.RoleData.awake_lv
    if level >= #DataModel.RoleCA.breakthroughList - 1 then
      CommonTips.OpenTips(80600038)
      return
    end
    local bkId = DataModel.RoleCA.breakthroughList[DataModel.RoleData.awake_lv + 1].breakthroughId
    local bkCA = PlayerData:GetFactoryData(bkId, "BreakthroughFactory")
    local materialList = bkCA.materialList
    PlayerData:GetFactoryData(bkId, "BreakthroughFactory")
    local isEnough = true
    local items = {}
    local re_item = {}
    for i = 1, #materialList do
      local item = materialList[i]
      local needNum = item.num
      local haveNum = PlayerData:GetGoodsById(item.itemId).num
      if needNum > haveNum and isEnough then
        isEnough = false
      end
      items[item.itemId] = needNum
      re_item[tostring(item.itemId)] = needNum
    end
    if not isEnough then
      CommonTips.OpenTips(80600062)
      return
    end
    Net:SendProto("hero.awakening", function(json)
      PlayerData:RefreshUseItems(items)
      local animName = "Awake0" .. DataModel.RoleData.awake_lv + 1
      View.self:SelectPlayAnim(View.Group_TabAwake.self, animName, function()
        Report_Awaken.origin_awaken = DataModel.RoleData.awake_lv
        DataModel.RoleData = PlayerData:GetRoleById(DataModel.RoleId)
        Report_Awaken.hero_id = DataModel.RoleId
        Report_Awaken.hero_name = DataModel.RoleCA.name
        Report_Awaken.hero_level = DataModel.RoleData.lv
        Report_Awaken.new_awaken = DataModel.RoleData.awake_lv
        Report_Awaken.event_seq = "hero.awakening"
        Report_Awaken.resource_cost = "itme_cost:" .. Json.encode(re_item)
        Report_Awaken.is_cast = PlayerData:GetHasSquads(DataModel.RoleId)
        ReportTrackEvent.awaken_flow(Report_Awaken)
        SdkReporter.TrackCharacter(Report_Awaken)
        DataModel.InitState = true
        BtnController.RefreshSetRole(DataModel.RoleId)
        AwakeLoader:Load()
        PlayerData:GetAllRoleAwakeRed()
        local element = DataModel.TabEnum[DataModel.oldIndex]
        if element.btn.Img_RedPoint then
          element.btn.Img_RedPoint:SetActive(PlayerData:GetAllRoleAwakeRedID(tostring(DataModel.RoleId)))
        end
        CommonTips.OpenRoleAwakeSuccess(DataModel.RoleData, DataModel.RoleCA, DataModel.RoleCA.breakthroughList[DataModel.RoleData.awake_lv + 1].breakthroughId)
        DataModel.AwakeMaxLevel = math.min(PlayerData:GetUserInfo().lv, PlayerData:GetFactoryData(99900001).roleLevelMax)
        BtnController:SetSkillList()
      end)
    end, tostring(DataModel.RoleId))
  end,
  CharacterInfo_Group_TabAwake_Group_BK_Group_Current_StaticGrid_BK_SetGrid = function(element, elementIndex)
    element.Img_Off:SetActive(true)
    if tonumber(elementIndex) <= DataModel.RoleData.awake_lv then
      element.Img_On:SetActive(true)
    else
      element.Img_On:SetActive(false)
    end
  end,
  CharacterInfo_Group_TabAwake_Group_BK_Group_Next_StaticGrid_BK_SetGrid = function(element, elementIndex)
    if tonumber(elementIndex) <= DataModel.RoleData.awake_lv + 1 then
      element.Img_On:SetActive(true)
    else
      element.Img_On:SetActive(false)
    end
  end,
  CharacterInfo_Group_TabAwake_Group_TBRight_Group_TBMiddle_StaticGrid_Stage_SetGrid = function(element, elementIndex)
  end,
  CharacterInfo_Group_TabAwake_Group_TBRight_Group_TBMiddle_StaticGrid_Item_SetGrid = function(element, elementIndex)
  end,
  CharacterInfo_Group_TabAwake_Group_TBRight_Group_TBBottom_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabAwake_Group_Icon1_Group_SkillIcon1_Btn_SkillIcon1_Click = function(btn, str)
    ShowNewAwake(1)
  end,
  CharacterInfo_Group_TabAwake_Group_Icon1_Group_SkillIcon2_Btn_SkillIcon2_Click = function(btn, str)
    ShowNewAwake(2)
  end,
  CharacterInfo_Group_TabAwake_Group_Icon1_Group_SkillIcon3_Btn_SkillIcon3_Click = function(btn, str)
    ShowNewAwake(3)
  end,
  CharacterInfo_Group_TabAwake_Group_Icon1_Group_SkillIcon4_Btn_SkillIcon4_Click = function(btn, str)
    ShowNewAwake(4)
  end,
  CharacterInfo_Group_TabAwake_Group_Icon1_Group_SkillIcon5_Btn_SkillIcon5_Click = function(btn, str)
    ShowNewAwake(5)
  end,
  CharacterInfo_Group_TabAwake_Btn_CloseCheck_Click = function(btn, str)
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabAwake")
    View.Group_TabAwake.Group_AwakeCheck.self:SetActive(false)
    View.Group_TabAwake.Btn_CloseCheck:SetActive(false)
    View.Group_Middle.Img_BlackMask:SetActive(false)
    local Group_Icon1 = View.Group_TabAwake.Group_Icon1
    for i = 1, 5 do
      local img = "Group_SkillIcon" .. i
      local Img_lightselect = Group_Icon1[img].Img_lightselect
      Img_lightselect:SetActive(false)
    end
  end,
  CharacterInfo_Group_TabResonance_Btn_CloseCheck_Click = function(btn, str)
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabResonance")
    DataModel.RightResonanceIndex = nil
    View.Group_TabResonance.Group_ResonanceCheck.self:SetActive(false)
    View.Group_TabResonance.Btn_CloseCheck:SetActive(false)
    View.Group_Middle.Img_BlackMask:SetActive(false)
    local Group_AwakeIcon = View.Group_TabResonance.Group_AwakeIcon
    for i = 1, 5 do
      local img = "Group_Stage0" .. i
      local Img_resonanceselect = Group_AwakeIcon[img].Img_resonanceselect
      Img_resonanceselect:SetActive(false)
    end
  end,
  CharacterInfo_Group_SkillCheck_Btn_Close_Click = function(btn, str)
    ClearCheck()
    ClearCheckRight()
    DataModel.CheckIndex = nil
    View.Group_SkillCheck.self:SetActive(false)
    View.Group_CommonTopLeft.self:SetActive(true)
  end,
  CharacterInfo_Group_SkillCheck_ScrollGrid_ExCard_SetGrid = function(element, elementIndex)
    local row = DataModel.deriveCardList[elementIndex]
    local skillCA = PlayerData:GetFactoryData(row.ExSkillName)
    local cardCA = PlayerData:GetFactoryData(skillCA.cardID)
    row.skillCA = skillCA
    row.cardCA = cardCA
    local Btn_ExCard = element.Btn_ExCard
    Btn_ExCard.Group_Select:SetActive(false)
    Btn_ExCard.Img_Icon:SetSprite(cardCA.iconPath)
    Btn_ExCard.Txt_CardName:SetText(cardCA.name)
    Btn_ExCard.Txt_Cost:SetText(string.format(GetText(80600452), math.floor(cardCA.cost_SN)))
    Btn_ExCard:SetClickParam(elementIndex)
  end,
  CharacterInfo_Group_SkillCheck_ScrollGrid_ExCard_Group_Item_Btn_ExCard_Click = function(btn, str)
    if DataModel.CheckIndex ~= nil then
      View.Group_SkillCheck.ScrollGrid_ExCard.grid[DataModel.CheckIndex].Btn_ExCard.Group_Select:SetActive(false)
    end
    local row = DataModel.deriveCardList[tonumber(str)]
    DataModel.CheckIndex = tonumber(str)
    View.Group_SkillCheck.ScrollGrid_ExCard.grid[DataModel.CheckIndex].Btn_ExCard.Group_Select:SetActive(true)
    ClearCheckRight()
    OpenCheckRight(row)
  end,
  CharacterInfo_Group_SkillCheck_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    ClearCheck()
    ClearCheckRight()
    DataModel.CheckIndex = nil
    View.Group_SkillCheck.self:SetActive(false)
    View.Group_CommonTopLeft.self:SetActive(true)
  end,
  CharacterInfo_Group_SkillCheck_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  CharacterInfo_Group_SkillCheck_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill_Btn_Dictionary_Click = function(btn, str)
    UIManager:Open("UI/Dictionary/Dictionary")
  end,
  CharacterInfo_Group_TabSkill1_StaticGrid_Skill_SetGrid = function(element, elementIndex)
  end,
  CharacterInfo_Group_TabSkill1_StaticGrid_Skill_Group_Item_Btn_Lvup_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill1_StaticGrid_Skill_Group_Item_Btn_LvMax_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill1_StaticGrid_Skill_Group_Item_Btn_LvLock_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill1_Group_Item_Btn_Lvup_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill1_Group_Item_Btn_LvMax_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill1_Group_Item_Btn_LvLock_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill1_Group_Skill1_Btn_open_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill1_Group_Skill2_Btn_open_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill1_Group_Skill3_Btn_open_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill1_Btn_Dictionary_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill_Btn_Card1_Click = function(btn, str)
    SkillLoader:ClickChooseTopSkillInfo(1)
  end,
  CharacterInfo_Group_TabSkill_Btn_Card2_Click = function(btn, str)
    SkillLoader:ClickChooseTopSkillInfo(2)
  end,
  CharacterInfo_Group_TabSkill_Btn_Card3_Click = function(btn, str)
    SkillLoader:ClickChooseTopSkillInfo(3)
  end,
  CharacterInfo_Group_TabSkill_ScrollGrid_ExCard_SetGrid = function(element, elementIndex)
    local row = DataModel.deriveCardList[elementIndex]
    local skillCA = PlayerData:GetFactoryData(row.ExSkillName)
    local cardCA = PlayerData:GetFactoryData(skillCA.cardID)
    row.skillCA = skillCA
    row.cardCA = cardCA
    local Btn_ExCard = element.Btn_ExCard
    Btn_ExCard.Img_Select:SetActive(false)
    Btn_ExCard.Img_Black:SetActive(true)
    Btn_ExCard.Group_SkillIcon.Img_MaskSkill.Img_Skill:SetSprite(cardCA.iconPath)
    local viewId = DataModel.RoleCA.viewId
    local portrailData = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
    Btn_ExCard.Img_Mask.Img_Face:SetSprite(portrailData.roleListResUrl)
    Btn_ExCard.Img_CardMask.Img_Cost:SetNum(math.floor(cardCA.cost_SN))
    Btn_ExCard:SetClickParam(elementIndex)
    row.element = element
  end,
  CharacterInfo_Group_TabSkill_ScrollGrid_ExCard_Group_Item_Btn_ExCard_Click = function(btn, str)
    SkillLoader:ClickChooseDownSkillInfo(tonumber(str))
  end,
  CharacterInfo_Group_TabSkill_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  CharacterInfo_Group_SkillCheck_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabAwake_Group_TalentLock_Btn_Off_Click = function(btn, str)
    local hStatus = PlayerData:IsRoleAwakeLock(DataModel.RoleCA.id) and 0 or 1
    PlayerData:SetRoleAwakeLock(DataModel.RoleCA.id, hStatus, function()
      AwakeLoader:Load(nil, true)
      BtnController:SetSkillList()
    end)
  end,
  CharacterInfo_Group_TabAwake_Group_TalentLock_Btn_On_Click = function(btn, str)
    local hStatus = PlayerData:IsRoleAwakeLock(DataModel.RoleCA.id) and 0 or 1
    PlayerData:SetRoleAwakeLock(DataModel.RoleCA.id, hStatus, function()
      AwakeLoader:Load(nil, true)
      BtnController:SetSkillList()
    end)
  end,
  CharacterInfo_Group_TabResonance_Group_TalentLock_Btn_Off_Click = function(btn, str)
    local hStatus = PlayerData:IsRoleResonanceLock(DataModel.RoleCA.id) and 0 or 1
    PlayerData:SetRoleResonanceLock(DataModel.RoleCA.id, hStatus, function()
      ResonanceLoader:Refresh(true)
      BtnController:SetSkillList()
    end)
  end,
  CharacterInfo_Group_TabResonance_Group_TalentLock_Btn_On_Click = function(btn, str)
    local hStatus = PlayerData:IsRoleResonanceLock(DataModel.RoleCA.id) and 0 or 1
    PlayerData:SetRoleResonanceLock(DataModel.RoleCA.id, hStatus, function()
      ResonanceLoader:Refresh(true)
      BtnController:SetSkillList()
    end)
  end,
  CharacterInfo_Group_CommonTopLeft_Group_Help_Group_window_Group_tabList_ScrollGrid_list_SetGrid = function(element, elementIndex)
  end,
  CharacterInfo_Group_TabInfo_Group_TIRight_Group_TIMiddle_CardDesCharacter_Btn_Close_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill_StaticGrid_Skill_SetGrid = function(element, elementIndex)
    element.Btn_Lvup.self:SetClickParam(tostring(elementIndex))
    local skillId = DataModel.RoleCA.skillList[tonumber(elementIndex)].skillId
    local skillData = PlayerData:GetFactoryData(skillId, "SkillFactory")
    local level = PlayerData:GetRoleSkillLv(DataModel.RoleId, elementIndex)
    local str = SkillFactory:GetSkillDes(tonumber(skillId), level)
    element.Img_Desc.Txt_Desc:SetText(str)
    if tonumber(elementIndex) == 3 and skillData.leaderCardConditionDesc ~= nil and skillData.leaderCardConditionDesc ~= "" then
      element.Img_Captain.self:SetActive(true)
      element.Img_Captain.Txt_Desc:SetText(GetText(80600414) .. skillData.leaderCardConditionDesc)
    else
      element.Img_Captain.self:SetActive(false)
    end
    element.Img_LvDes:SetActive(false)
    if skillData.levelUpDescription ~= nil and skillData.levelUpDescription ~= "" then
      element.Img_LvDes:SetActive(true)
      element.Img_LvDes.Txt_Desc:SetText(skillData.levelUpDescription)
    end
    local costNum = skillData.cardID and PlayerData:GetFactoryData(skillData.cardID, "cardFactory").cost_SN or nil
    if costNum == nil or costNum == "" or costNum == 0 then
      element.Txt_Cost:SetActive(false)
    else
      element.Txt_Cost:SetActive(true)
      element.Txt_Cost:SetText("Cost " .. math.ceil(costNum))
    end
    element.Img_Icon:SetSprite(skillData.iconPath)
    element.Txt_Name:SetText(skillData.name)
    element.Txt_LvNum.self:SetText(level)
    element.Img_Type.Txt_Des:SetText("")
    element.Btn_Lvup.self:SetActive(false)
    element.Btn_LvMax.self:SetActive(false)
    element.Btn_LvLock.self:SetActive(false)
    local state, updateLv, maxLv = PlayerData:GetNotSkillUpdate(DataModel.RoleId, elementIndex)
    local cardCA = PlayerData:GetFactoryData(skillData.cardID)
    element.Img_Icon:SetColor(Color.white)
    if cardCA.color == "Red" then
      element.Img_Icon:SetColor(GameSetting.redCardColor)
    end
  end,
  CharacterInfo_Group_TabSkill_StaticGrid_Skill_Group_Item_Btn_Lvup_Click = function(btn, index)
    local state, updateLv, maxLv = PlayerData:GetNotSkillUpdate(DataModel.RoleId, index)
    if state == true then
      SkillInfo:SkillUp(index)
      SkillLoader.skillSelectIndex = index
    elseif updateLv == maxLv then
      CommonTips.OpenTips(80600041)
    else
      CommonTips.OpenTips(80600039)
    end
  end,
  CharacterInfo_Group_TabSkill_StaticGrid_Skill_Group_Item_Btn_LvMax_Click = function(btn, str)
    CommonTips.OpenTips(80600041)
  end,
  CharacterInfo_Group_TabSkill_StaticGrid_Skill_Group_Item_Btn_LvLock_Click = function(btn, str)
    CommonTips.OpenTips(80600039)
  end,
  CharacterInfo_Group_TabSkill_Group_Item_Btn_Lvup_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill_Group_Item_Btn_LvMax_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill_Group_Item_Btn_LvLock_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill_Group_Skill1_Btn_open_Click = function(btn, str)
    OpenSkillCardCheck(1)
  end,
  CharacterInfo_Group_TabSkill_Group_Skill2_Btn_open_Click = function(btn, str)
    OpenSkillCardCheck(2)
  end,
  CharacterInfo_Group_TabSkill_Group_Skill3_Btn_open_Click = function(btn, str)
    OpenSkillCardCheck(3)
  end,
  CharacterInfo_Group_ResonanceSuccess_Btn_BG_Click = function(btn, str)
    CloseNewResonance()
  end,
  CharacterInfo_Group_AwakeSuccess_Btn_Close_Click = function(btn, str)
    View.Group_AwakeSuccess.self:SetActive(false)
    View.Group_CommonTopLeft.self:SetActive(true)
    View.Group_Middle.SpineAnimation_Character:SetActive(true)
  end,
  CharacterInfo_Group_AwakeSuccess_old_Btn_Close_Click = function(btn, str)
  end,
  CharacterInfo_Group_AwakeSuccess_Btn_UseOne_Click = function(btn, str)
  end,
  CharacterInfo_Group_SkillCheck_Group_Skill_Btn_open_Click = function(btn, str)
  end,
  CharacterInfo_Group_SkillCheck_Group_CaptainSkill_Btn_open_Click = function(btn, str)
  end,
  CharacterInfo_Group_AwakeCheck_Btn_BG_Click = function(btn, str)
    CloseNewAwake()
  end,
  CharacterInfo_Group_TopRight_Btn_TabBreakThrough_Click = function(btn, str)
    changeTab(3)
    BtnController.RefreshSetRole(DataModel.RoleId)
  end,
  CharacterInfo_Group_TopRight_Btn_TabTalent_Click = function(btn, str)
    changeTab(4)
    BtnController.RefreshSetRole(DataModel.RoleId)
  end,
  CharacterInfo_Group_TabAwake_Group_TAMiddle_Btn_Detail_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabBreakThrough_Group_TBRight_Group_TBMiddle_StaticGrid_Stage_SetGrid = function(element, elementIndex)
    local bkId = DataModel.RoleCA.breakthroughList[elementIndex + 1].breakthroughId
    local bkCA = PlayerData:GetFactoryData(bkId, "BreakthroughFactory")
    if bkCA and bkCA.desc and bkCA.desc ~= "" then
      local str = "突破" .. elementIndex .. "    " .. bkCA.desc
      element.Txt_Off:SetText(str)
      element.Txt_On:SetText(str)
    end
    element.Txt_Off:SetActive(elementIndex > DataModel.RoleData.awake_lv)
    element.Txt_On:SetActive(elementIndex <= DataModel.RoleData.awake_lv)
    element.self:SetActive(true)
  end,
  CharacterInfo_Group_TabResonance_Group_TARight_Group_TAMiddle_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local current = DataModel.RoleAttributeCurrent[tonumber(elementIndex)]
    local next = DataModel.RoleAttributeNext[tonumber(elementIndex)] ~= nil and DataModel.RoleAttributeNext[tonumber(elementIndex)] or "最大等级"
    element.Img_Icon:SetSprite(current.sprite)
    element.Txt_Name:SetText(current.name)
    element.Txt_PreNum:SetText(current.num)
    element.Txt_NextNum:SetText(next)
    element.Txt_PreNum:SetText(PlayerData:GetAttributeShow(current.name, current.num, 2))
    element.Txt_NextNum:SetText(PlayerData:GetAttributeShow(next.name, next.num, 2))
  end,
  CharacterInfo_Group_TabBreakThrough_Group_TBRight_Group_TBMiddle_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local current = DataModel.RoleAttributeCurrent[tonumber(elementIndex)]
    local next = DataModel.RoleAttributeNext[tonumber(elementIndex)] ~= nil and DataModel.RoleAttributeNext[tonumber(elementIndex)] or "最大等级"
    element.Img_Icon:SetSprite(current.sprite)
    element.Txt_Name:SetText(current.name)
    element.Txt_PreNum:SetText(current.num)
    element.Txt_NextNum:SetText(next)
    element.Txt_PreNum:SetText(PlayerData:GetAttributeShow(current.name, current.num, 2))
    element.Txt_NextNum:SetText(PlayerData:GetAttributeShow(next.name, next.num, 2))
  end,
  CharacterInfo_Group_TabBreakThrough_Group_TBRight_Group_TBBottom_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabBreakThrough_Btn_BK_Click = function(index)
    Init_Break()
    local level = DataModel.RoleData.awake_lv
    if level >= #DataModel.RoleCA.breakthroughList - 1 then
      CommonTips.OpenTips(80600037)
      return
    end
    local bkId = DataModel.RoleCA.breakthroughList[DataModel.RoleData.awake_lv + 1].breakthroughId
    local bkCA = PlayerData:GetFactoryData(bkId, "BreakthroughFactory")
    local materialList = bkCA.materialList
    PlayerData:GetFactoryData(bkId, "BreakthroughFactory")
    local isEnough = true
    local items = {}
    local re_item = {}
    for i = 1, #materialList do
      local item = materialList[i]
      local needNum = item.num
      local haveNum = PlayerData:GetGoodsById(item.itemId).num
      if needNum > haveNum and isEnough then
        isEnough = false
      end
      items[item.itemId] = needNum
      re_item[tostring(item.itemId)] = needNum
    end
    if not isEnough then
      CommonTips.OpenTips(80600062)
      return
    end
    Net:SendProto("hero.breakthrough", function(json)
      Report_Break.origin_break = DataModel.RoleData.awake_lv
      DataModel.RoleData = PlayerData:GetRoleById(DataModel.RoleId)
      Report_Break.hero_id = DataModel.RoleId
      Report_Break.hero_name = DataModel.RoleCA.name
      Report_Break.hero_level = DataModel.RoleData.lv
      Report_Break.new_break = DataModel.RoleData.awake_lv
      Report_Break.event_seq = "hero.breakthrough"
      Report_Break.resource_cost = "itme_cost:" .. Json.encode(re_item)
      Report_Break.is_cast = PlayerData:GetHasSquads(DataModel.RoleId)
      ReportTrackEvent.break_flow(Report_Break)
      CommonTips.OpenTips(80600073)
      DataModel.InitState = true
      PlayerData:RefreshUseItems(items)
      local list = {
        current = DataModel.RoleAttributeCurrent,
        next = DataModel.RoleAttributeNext
      }
      CommonTips.OpenBreakSuccessTip(list)
      BtnController.RefreshSetRole(DataModel.RoleId)
      BreakThroughLoader:Load()
    end, tostring(DataModel.RoleId))
  end,
  CharacterInfo_Group_TabBreakThrough_Group_BK_Group_Current_StaticGrid_BK_SetGrid = function(element, elementIndex)
    element.Img_Off:SetActive(true)
    if tonumber(elementIndex) <= DataModel.RoleData.awake_lv then
      element.Img_On:SetActive(true)
    else
      element.Img_On:SetActive(false)
    end
  end,
  CharacterInfo_Group_TabBreakThrough_Group_BK_Group_Next_StaticGrid_BK_SetGrid = function(element, elementIndex)
    if tonumber(elementIndex) <= DataModel.RoleData.awake_lv + 1 then
      element.Img_On:SetActive(true)
    else
      element.Img_On:SetActive(false)
    end
  end,
  CharacterInfo_Group_TabBreakThrough_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local level = DataModel.RoleData.awake_lv
    if level >= #DataModel.RoleCA.breakthroughList - 1 then
      print("满级")
      element.self:SetActive(false)
      return
    end
    local bkId = DataModel.RoleCA.breakthroughList[level + 1].breakthroughId
    local materialList = PlayerData:GetFactoryData(bkId, "BreakthroughFactory").materialList
    local group = element
    element.self:SetActive(elementIndex <= #materialList)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    if elementIndex <= #materialList then
      local item = materialList[elementIndex]
      element.self:SetActive(true)
      local itemData = PlayerData:GetFactoryData(item.itemId, "SourceMaterialFactory")
      local needNum = item.num
      local haveNum = PlayerData:GetGoodsById(item.itemId).num
      group.Group_Cost.Txt_Need:SetText(needNum)
      group.Group_Cost.Txt_Have:SetText(haveNum)
      if needNum <= haveNum then
        group.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
      else
        group.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
      end
      local image = itemData.iconPath
      group.Group_Item.Img_Item:SetSprite(image)
      group.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[itemData.qualityInt + 1])
      group.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[itemData.qualityInt + 1])
      if element.Group_Break then
        element.Group_Break.self:SetActive(false)
        if type(itemData.breakPath) == "string" and itemData.breakPath ~= "" or type(itemData.breakPath) ~= "string" and itemData.breakPath then
          element.Group_Break.self:SetActive(true)
          element.Group_Break.Img_Mask.Img_Face:SetSprite(itemData.breakPath)
        end
      end
    end
  end,
  CharacterInfo_Group_TabBreakThrough_StaticGrid_Item_Group_Consume_Group_Item_Btn_Item_Click = function(btn, str)
    local bkId = DataModel.RoleCA.breakthroughList[DataModel.RoleData.awake_lv + 1].breakthroughId
    local materialList = PlayerData:GetFactoryData(bkId, "BreakthroughFactory").materialList
    CommonTips.OpenRewardDetail(materialList[tonumber(str)].itemId)
  end,
  CharacterInfo_Group_TabAwake_Btn_Awake_Click = function(btn, str)
    local callback = function()
      Init_Awaken()
      local item_cost = {}
      local level = DataModel.RoleData.resonance_lv
      if level >= #DataModel.RoleCA.awakeList - 1 then
        CommonTips.OpenTips(80600038)
        return
      end
      local awakeId = DataModel.RoleCA.awakeList[level + 1].awakeId
      local data = PlayerData:GetFactoryData(awakeId, "AwakeFactory")
      local materialList = data.materialList
      local isEnoughMaterial = true
      local items = {}
      local re_item = {}
      for i = 1, #materialList do
        local item = materialList[i]
        local needNum = item.num
        local haveItem = PlayerData:GetGoodsById(item.itemId)
        local haveNum = haveItem.num
        if needNum > haveNum and isEnoughMaterial then
          isEnoughMaterial = false
        end
        items[item.itemId] = needNum
        re_item[tostring(item.itemId)] = needNum
      end
      if not isEnoughMaterial then
        CommonTips.OpenTips(80600062)
        return
      end
      if DataModel.RoleData.lv < data.level then
        CommonTips.OpenTips(80600039)
        return
      end
      if isEnoughMaterial then
        Net:SendProto("hero.awakening", function(json)
          Report_Awaken.origin_awaken = DataModel.RoleData.resonance_lv
          DataModel.RoleData = PlayerData:GetRoleById(DataModel.RoleId)
          Report_Awaken.hero_id = DataModel.RoleId
          Report_Awaken.hero_name = DataModel.RoleCA.name
          Report_Awaken.hero_level = DataModel.RoleData.lv
          Report_Awaken.new_awaken = DataModel.RoleData.resonance_lv
          Report_Awaken.event_seq = "hero.awakening"
          Report_Awaken.resource_cost = "itme_cost:" .. Json.encode(re_item)
          Report_Awaken.is_cast = PlayerData:GetHasSquads(DataModel.RoleId)
          ReportTrackEvent.awaken_flow(Report_Awaken)
          SdkReporter.TrackCharacter(Report_Awaken)
          PlayerData:RefreshUseItems(items)
          DataModel.InitState = true
          BtnController.RefreshSetRole(DataModel.RoleId)
          AwakeLoader:Load()
          local id = DataModel.RoleCA.awakeList[DataModel.RoleData.resonance_lv + 1] and DataModel.RoleCA.awakeList[DataModel.RoleData.resonance_lv + 1].awakeId or DataModel.RoleCA.awakeList[table.count(DataModel.RoleCA.awakeList)].awakeId
          AwakeSuccessRefresh(DataModel.RoleCA.talentList[DataModel.RoleData.resonance_lv].talentId)
          DataModel.AwakeMaxLevel = math.min(PlayerData:GetUserInfo().lv, PlayerData:GetFactoryData(99900001).roleLevelMax)
        end, tostring(DataModel.RoleId))
      else
        print("级别不够s")
        return
      end
    end
    callback()
  end,
  CharacterInfo_Group_TabResonance_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local data = PlayerData:GetFactoryData(99900001, "ConfigFactory").resonanceSourceMaterialList[elementIndex]
    local num = PlayerData:GetGoodsById(data.sourceMaterialId).num
    local itemData = PlayerData:GetFactoryData(data.sourceMaterialId, "SourceMaterialFactory")
    element.Group_Item.Img_Item:SetSprite(itemData.iconPath)
    element.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[itemData.qualityInt + 1])
    element.Txt_Have:SetText(num)
    element.Btn_Reduce.self:SetActive(false)
    element.Btn_Reduce.self:SetClickParam(tostring(elementIndex))
    element.Btn_Add:SetClickParam(tostring(elementIndex))
    local temp = DataModel.TempUse[elementIndex]
    if temp.tempNum > 0 then
      element.Txt_Use:SetActive(true)
      element.Btn_Reduce.self:SetActive(true)
      element.Txt_Use:SetText(temp.tempNum)
    else
      element.Txt_Use:SetText(0)
      element.Btn_Reduce.self:SetActive(false)
    end
  end,
  CharacterInfo_Group_TabResonance_StaticGrid_Item_Group_Item_Btn_Add_Click = function(btn, str)
    if DataModel.RoleData.lv < DataModel.ResonanceLevelMax then
      CommonTips.OpenTips(80600061)
      return
    end
    local currStage = DataModel.tempStage
    local id = DataModel.RoleCA.resonanceList[currStage + 1].resonanceId
    local maxId = DataModel.RoleCA.resonanceList[#DataModel.RoleCA.resonanceList].resonanceId
    local maxData = PlayerData:GetFactoryData(maxId, "ResonanceFactory")
    local maxLevel
    if DataModel.tempStage == #DataModel.RoleCA.resonanceList - 1 and maxData.maxLevel == DataModel.RoleData.re_lv then
      maxLevel = maxData.maxLevel - 1
    else
      maxLevel = maxData.maxLevel
    end
    if id == maxId and maxLevel <= DataModel.tempLevel then
      CommonTips.OpenTips(80600130)
      return
    end
    local index = tonumber(str)
    local data = DataModel.TempUse[tonumber(str)]
    if data.tempNum == data.maxNum then
      CommonTips.OpenTips(80600062)
      return
    end
    local totalExp = DataModel.TempUse[index].exp
    local stage = DataModel.tempStage
    local level = DataModel.tempLevel
    local id = DataModel.RoleCA.resonanceList[stage + 1].resonanceId
    local resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
    local maxExp = resonance.expList[level].levelUpExp
    local exp = DataModel.tempExp
    if maxExp <= exp then
      CommonTips.OpenTips(80600130)
      return
    end
    local tempExp = exp + totalExp
    data.tempNum = math.min(data.tempNum + 1, data.maxNum)
    if DataModel.tempStage == #DataModel.RoleCA.resonanceList - 1 and level == resonance.maxLevel - 1 then
      tempExp = 0
      DataModel.tempLevel = DataModel.tempLevel + 1
      return
    end
    DataModel.tempExp = tempExp
    DataModel.TabResonance_Lock = false
    ResonanceLoader:Refresh(true)
  end,
  CharacterInfo_Group_TabResonance_StaticGrid_Item_Group_Item_Btn_Add_LongPress = function(btn, str)
    if DataModel.RoleData.lv < DataModel.ResonanceLevelMax then
      CommonTips.OpenTips(80600061)
      return
    end
    local index = tonumber(str)
    local data = DataModel.TempUse[tonumber(str)]
    if data.tempNum == data.maxNum then
      CommonTips.OpenTips(80600062)
      return
    end
    local element = View.Group_TabResonance.StaticGrid_Item.grid[index]
    View.self:StartC(LuaUtil.cs_generator(function()
      while btn.Btn.isHandled do
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
        local id = DataModel.RoleCA.resonanceList[DataModel.tempStage + 1].resonanceId
        local maxId = DataModel.RoleCA.resonanceList[#DataModel.RoleCA.resonanceList].resonanceId
        local maxData = PlayerData:GetFactoryData(maxId, "ResonanceFactory")
        local resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
        local maxLevel
        if DataModel.tempStage == #DataModel.RoleCA.resonanceList - 1 and maxData.maxLevel == DataModel.RoleData.re_lv then
          maxLevel = maxData.maxLevel - 1
        else
          maxLevel = maxData.maxLevel
        end
        if id == maxId and maxLevel <= DataModel.tempLevel then
          CommonTips.OpenTips(80600130)
          break
        end
        if data.tempNum == data.maxNum and data.tempNum ~= 0 then
          break
        end
        if data.tempNum > 0 then
          element.Txt_Use:SetActive(true)
          element.Btn_Reduce.self:SetActive(true)
          element.Txt_Use:SetText(data.tempNum)
        else
          element.Txt_Use:SetText(0)
          element.Btn_Reduce.self:SetActive(false)
        end
        local totalExp = DataModel.TempUse[index].exp
        local level = DataModel.tempLevel
        local exp = DataModel.tempExp
        local maxExp = resonance.expList[DataModel.tempLevel].levelUpExp
        if exp >= maxExp then
          CommonTips.OpenTips(80600130)
          return
        end
        local tempExp = exp + totalExp
        data.tempNum = math.min(data.tempNum + 1, data.maxNum)
        if DataModel.tempStage == #DataModel.RoleCA.resonanceList - 1 and level == resonance.maxLevel - 1 then
          tempExp = 0
          DataModel.tempLevel = DataModel.tempLevel + 1
          break
        end
        DataModel.tempExp = tempExp
        DataModel.TabResonance_Lock = false
        ResonanceLoader:Refresh(true)
      end
    end))
  end,
  CharacterInfo_Group_TabResonance_StaticGrid_Item_Group_Item_Btn_Reduce_Click = function(btn, str)
    local index = tonumber(str)
    local data = DataModel.TempUse[tonumber(str)]
    data.tempNum = math.max(data.tempNum - 1, 0)
    local element = View.Group_TabResonance.StaticGrid_Item.grid[index]
    if data.tempNum > 0 then
      element.Txt_Use:SetActive(true)
      element.Btn_Reduce.self:SetActive(true)
      element.Txt_Use:SetText(data.tempNum)
    else
      element.Txt_Use:SetText(0)
      element.Btn_Reduce.self:SetActive(false)
    end
    local totalExp = DataModel.TempUse[index].exp
    local exp = DataModel.tempExp
    local tempExp = exp - totalExp
    local id = DataModel.RoleCA.resonanceList[DataModel.tempStage + 1].resonanceId
    local resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
    local level = DataModel.tempLevel == resonance.maxLevel and 1 < DataModel.tempLevel and DataModel.tempLevel - 1 or DataModel.tempLevel
    local maxExp = resonance.expList[level].levelUpExp
    while tempExp < 0 do
      if DataModel.tempLevel == 1 then
        DataModel.tempStage = DataModel.tempStage - 1
        id = DataModel.RoleCA.resonanceList[DataModel.tempStage + 1].resonanceId
        resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
        DataModel.tempLevel = resonance.maxLevel
      else
        DataModel.tempLevel = DataModel.tempLevel - 1
      end
      maxExp = resonance.expList[DataModel.tempLevel + 0].levelUpExp
      tempExp = tempExp + maxExp
    end
    DataModel.tempExp = tempExp
    DataModel.TabResonance_Lock = false
    ResonanceLoader:Refresh(true)
  end,
  CharacterInfo_Group_TabResonance_StaticGrid_Item_Group_Item_Btn_Reduce_LongPress = function(btn, str)
    local index = tonumber(str)
    local data = DataModel.TempUse[tonumber(str)]
    local element = View.Group_TabResonance.StaticGrid_Item.grid[index]
    local tCoroutine = View.self:StartC(LuaUtil.cs_generator(function()
      while element.Btn_Reduce.Btn.isHandled do
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
        if data.tempNum == 0 then
          break
        end
        data.tempNum = math.max(data.tempNum - 1, 0)
        if data.tempNum > 0 then
          element.Txt_Use:SetActive(true)
          element.Btn_Reduce:SetActive(true)
          element.Txt_Use:SetText(data.tempNum)
        else
          element.Txt_Use:SetText(0)
          element.Btn_Reduce:SetActive(false)
        end
        local totalExp = DataModel.TempUse[index].exp
        local exp = DataModel.tempExp
        local tempExp = exp - totalExp
        local id = DataModel.RoleCA.resonanceList[DataModel.tempStage + 1].resonanceId
        local resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
        local level = DataModel.tempLevel == resonance.maxLevel and 1 < DataModel.tempLevel and DataModel.tempLevel - 1 or DataModel.tempLevel
        local maxExp = resonance.expList[level].levelUpExp
        while tempExp < 0 do
          if DataModel.tempLevel == 1 then
            DataModel.tempStage = DataModel.tempStage - 1
            id = DataModel.RoleCA.resonanceList[DataModel.tempStage + 1].resonanceId
            resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
            DataModel.tempLevel = resonance.maxLevel
          else
            DataModel.tempLevel = DataModel.tempLevel - 1
          end
          maxExp = resonance.expList[DataModel.tempLevel + 0].levelUpExp
          tempExp = tempExp + maxExp
        end
        DataModel.tempExp = tempExp
        DataModel.TabResonance_Lock = false
        ResonanceLoader:Refresh(true)
      end
    end))
  end,
  CharacterInfo_Group_TabResonance_Group_Item_Btn_Add_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabResonance_Group_Item_Btn_Add_LongPress = function(btn, str)
  end,
  CharacterInfo_Group_TabResonance_Group_Item_Btn_Reduce_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabResonance_Group_Item_Btn_Reduce_LongPress = function(btn, str)
  end,
  CharacterInfo_Group_TabResonance_Btn_Lock_Click = function(index)
    CommonTips.OpenTips(80600061)
  end,
  CharacterInfo_Group_TabAwake_Group_AwakeIcon_Group_Stage01_Btn_Stage_Click = function(index)
    local talent_info = PlayerData:GetFactoryData(DataModel.RoleCA.talentList[1].talentId)
    CommonTips.OpenAwakeTalentTip(talent_info)
  end,
  CharacterInfo_Group_TabAwake_Group_AwakeIcon_Group_Stage02_Btn_Stage_Click = function(index)
    local talent_info = PlayerData:GetFactoryData(DataModel.RoleCA.talentList[2].talentId)
    CommonTips.OpenAwakeTalentTip(talent_info)
  end,
  CharacterInfo_Group_TabAwake_Group_AwakeIcon_Group_Stage03_Btn_Stage_Click = function(index)
    local talent_info = PlayerData:GetFactoryData(DataModel.RoleCA.talentList[3].talentId)
    CommonTips.OpenAwakeTalentTip(talent_info)
  end,
  CharacterInfo_Group_TabAwake_Group_AwakeIcon_Group_Stage04_Btn_Stage_Click = function(index)
    local talent_info = PlayerData:GetFactoryData(DataModel.RoleCA.talentList[4].talentId)
    CommonTips.OpenAwakeTalentTip(talent_info)
  end,
  CharacterInfo_Group_AwakeSuccess_Btn_BG_Click = function(btn, str)
    View.Group_AwakeSuccess.self:SetActive(false)
  end,
  CharacterInfo_Group_TabAwake_Btn_LvLock_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabInfo_Group_TIBottomLeft_Group_Career_Img_Career_Btn_Career_Click = function(btn, str)
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_CareerDetail")
    View.Group_CareerDetail.self:SetActive(true)
  end,
  CharacterInfo_Group_TopRight_Group_Files_Group_TIBottomLeft_Group_Career_Img_Career_Btn_Career_Click = function(btn, str)
  end,
  CharacterInfo_Group_TopRight_Group_Files_Btn_Return_Click = function(btn, str)
  end,
  CharacterInfo_Group_Tab_Btn_Close_Click = function(btn, str)
  end,
  CharacterInfo_Group_Tab_StaticGrid_Item_SetGrid = function(element, elementIndex)
  end,
  CharacterInfo_Group_Tab_StaticGrid_Item_Group_Item_Btn_Reduce_Click = function(btn, str)
  end,
  CharacterInfo_Group_Tab_StaticGrid_Item_Group_Item_Btn_Reduce_LongPress = function(btn, str)
  end,
  CharacterInfo_Group_Tab_StaticGrid_Item_Group_Item_Btn_Add_Click = function(btn, str)
  end,
  CharacterInfo_Group_Tab_StaticGrid_Item_Group_Item_Btn_Add_LongPress = function(btn, str)
  end,
  CharacterInfo_Group_Tab_Group_Item_Btn_Reduce_Click = function(btn, str)
  end,
  CharacterInfo_Group_Tab_Group_Item_Btn_Reduce_LongPress = function(btn, str)
  end,
  CharacterInfo_Group_Tab_Group_Item_Btn_Add_Click = function(btn, str)
  end,
  CharacterInfo_Group_Tab_Group_Item_Btn_Add_LongPress = function(btn, str)
  end,
  CharacterInfo_Group_SkillLvup_StaticGrid_Item_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local data = DataModel.StaticGrid_Item_SetGrid(tonumber(str))
    CommonTips.OpenRewardDetail(data.id)
  end,
  CharacterInfo_Group_SkillLvup_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabAwake_Group_TABottom_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local level = DataModel.RoleData.resonance_lv
    if level >= #DataModel.RoleCA.awakeList then
      return
    end
    local awakeId = DataModel.RoleCA.awakeList[level + 1].awakeId
    local data = PlayerData:GetFactoryData(awakeId, "AwakeFactory")
    local materialList = data.materialList
    local group = element
    element.self:SetActive(elementIndex <= #materialList)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    if elementIndex <= #materialList then
      local item = materialList[elementIndex]
      element.self:SetActive(true)
      local itemData = PlayerData:GetFactoryData(item.itemId, "SourceMaterialFactory")
      local needNum = item.num
      local haveItem = PlayerData:GetGoodsById(item.itemId)
      local haveNum = haveItem.num or 0
      group.Group_Cost.Txt_Need:SetText(needNum)
      group.Group_Cost.Txt_Have:SetText(haveNum)
      if needNum <= haveNum then
        group.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
      else
        group.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
      end
      group.Group_Item.Img_Item:SetSprite(itemData.iconPath)
    else
    end
  end,
  CharacterInfo_Group_TabAwake_Group_TABottom_StaticGrid_Item_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local awakeId = DataModel.RoleCA.awakeList[DataModel.RoleData.resonance_lv + 1].awakeId
    local materialList = PlayerData:GetFactoryData(awakeId, "AwakeFactory").materialList
    CommonTips.OpenRewardDetail(materialList[tonumber(str)].itemId)
  end,
  CharacterInfo_Group_TabResonance_Group_TARight_Group_TABottom_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local data = PlayerData:GetFactoryData(99900001, "ConfigFactory").resonanceSourceMaterialList[elementIndex]
    local num = PlayerData:GetGoodsById(data.sourceMaterialId).num
    local itemData = PlayerData:GetFactoryData(data.sourceMaterialId, "SourceMaterialFactory")
    element.Group_Item.Img_Item:SetSprite(itemData.iconPath)
    element.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[itemData.qualityInt + 1])
    element.Txt_Have:SetText(num)
    element.Btn_Reduce.self:SetActive(false)
    element.Btn_Reduce.self:SetClickParam(tostring(elementIndex))
    element.Btn_Add:SetClickParam(tostring(elementIndex))
    local temp = DataModel.TempUse[elementIndex]
    if temp.tempNum > 0 then
      element.Txt_Use:SetActive(true)
      element.Btn_Reduce.self:SetActive(true)
      element.Txt_Use:SetText(temp.tempNum)
    else
      element.Txt_Use:SetText(0)
      element.Btn_Reduce.self:SetActive(false)
    end
  end,
  CharacterInfo_Group_TabResonance_Group_TARight_Group_TABottom_StaticGrid_Item_Group_Item_Btn_Reduce_Click = function(btn, str)
    local index = tonumber(str)
    local data = DataModel.TempUse[tonumber(str)]
    data.tempNum = math.max(data.tempNum - 1, 0)
    local element = View.Group_TabResonance.Group_TARight.Group_TABottom.StaticGrid_Item.grid[index]
    if data.tempNum > 0 then
      element.Txt_Use:SetActive(true)
      element.Btn_Reduce.self:SetActive(true)
      element.Txt_Use:SetText(data.tempNum)
    else
      element.Txt_Use:SetText(0)
      element.Btn_Reduce.self:SetActive(false)
    end
    local totalExp = DataModel.TempUse[index].exp
    local exp = DataModel.tempExp
    local tempExp = exp - totalExp
    local id = DataModel.RoleCA.resonanceList[DataModel.tempStage + 1].resonanceId
    local resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
    local level = DataModel.tempLevel == resonance.maxLevel and 1 < DataModel.tempLevel and DataModel.tempLevel - 1 or DataModel.tempLevel
    local maxExp = resonance.expList[level].levelUpExp
    while tempExp < 0 do
      if DataModel.tempLevel == 1 then
        DataModel.tempStage = DataModel.tempStage - 1
        id = DataModel.RoleCA.resonanceList[DataModel.tempStage + 1].resonanceId
        resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
        DataModel.tempLevel = resonance.maxLevel
      else
        DataModel.tempLevel = DataModel.tempLevel - 1
      end
      maxExp = resonance.expList[DataModel.tempLevel + 0].levelUpExp
      tempExp = tempExp + maxExp
    end
    DataModel.tempExp = tempExp
    DataModel.TabResonance_Lock = false
    ResonanceLoader:Refresh(true)
  end,
  CharacterInfo_Group_TabResonance_Group_TARight_Group_TABottom_StaticGrid_Item_Group_Item_Btn_Reduce_LongPress = function(btn, str)
    local index = tonumber(str)
    local data = DataModel.TempUse[tonumber(str)]
    local element = View.Group_TabResonance.Group_TARight.Group_TABottom.StaticGrid_Item.grid[index]
    local tCoroutine = View.self:StartC(LuaUtil.cs_generator(function()
      while element.Btn_Reduce.Btn.isHandled do
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
        if data.tempNum == 0 then
          break
        end
        data.tempNum = math.max(data.tempNum - 1, 0)
        if data.tempNum > 0 then
          element.Txt_Use:SetActive(true)
          element.Btn_Reduce:SetActive(true)
          element.Txt_Use:SetText(data.tempNum)
        else
          element.Txt_Use:SetText(0)
          element.Btn_Reduce:SetActive(false)
        end
        local totalExp = DataModel.TempUse[index].exp
        local exp = DataModel.tempExp
        local tempExp = exp - totalExp
        local id = DataModel.RoleCA.resonanceList[DataModel.tempStage + 1].resonanceId
        local resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
        local level = DataModel.tempLevel == resonance.maxLevel and 1 < DataModel.tempLevel and DataModel.tempLevel - 1 or DataModel.tempLevel
        local maxExp = resonance.expList[level].levelUpExp
        while tempExp < 0 do
          if DataModel.tempLevel == 1 then
            DataModel.tempStage = DataModel.tempStage - 1
            id = DataModel.RoleCA.resonanceList[DataModel.tempStage + 1].resonanceId
            resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
            DataModel.tempLevel = resonance.maxLevel
          else
            DataModel.tempLevel = DataModel.tempLevel - 1
          end
          maxExp = resonance.expList[DataModel.tempLevel + 0].levelUpExp
          tempExp = tempExp + maxExp
        end
        DataModel.tempExp = tempExp
        DataModel.TabResonance_Lock = false
        ResonanceLoader:Refresh(true)
      end
    end))
  end,
  CharacterInfo_Group_TabResonance_Group_TARight_Group_TABottom_StaticGrid_Item_Group_Item_Btn_Add_Click = function(btn, str)
    local currStage = DataModel.tempStage
    local id = DataModel.RoleCA.resonanceList[currStage + 1].resonanceId
    local maxId = DataModel.RoleCA.resonanceList[#DataModel.RoleCA.resonanceList].resonanceId
    local maxData = PlayerData:GetFactoryData(maxId, "ResonanceFactory")
    local maxLevel
    if DataModel.tempStage == #DataModel.RoleCA.resonanceList - 1 and maxData.maxLevel == DataModel.RoleData.re_lv then
      maxLevel = maxData.maxLevel - 1
    else
      maxLevel = maxData.maxLevel
    end
    if id == maxId and maxLevel <= DataModel.tempLevel then
      CommonTips.OpenTips(80600130)
      return
    end
    local index = tonumber(str)
    local data = DataModel.TempUse[tonumber(str)]
    if data.tempNum == data.maxNum then
      CommonTips.OpenTips(80600062)
      return
    end
    data.tempNum = math.min(data.tempNum + 1, data.maxNum)
    local totalExp = DataModel.TempUse[index].exp
    local stage = DataModel.tempStage
    local level = DataModel.tempLevel
    local exp = DataModel.tempExp
    local tempExp = exp + totalExp
    local id = DataModel.RoleCA.resonanceList[stage + 1].resonanceId
    local resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
    local maxExp = resonance.expList[level].levelUpExp
    while tempExp >= maxExp do
      if DataModel.tempStage == #DataModel.RoleCA.resonanceList - 1 and level == resonance.maxLevel - 1 then
        tempExp = 0
        DataModel.tempLevel = DataModel.tempLevel + 1
        break
      end
      tempExp = tempExp - maxExp
      if resonance.maxLevel == DataModel.tempLevel then
        DataModel.tempLevel = 1
        DataModel.tempStage = DataModel.tempStage + 1
        id = DataModel.RoleCA.resonanceList[DataModel.tempStage].resonanceId
        resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
      else
        DataModel.tempLevel = DataModel.tempLevel + 1
      end
      if DataModel.tempLevel == DataModel.RoleData.re_lv and DataModel.tempStage == DataModel.RoleData.re_stage then
        tempExp = DataModel.RoleData.re_exp
      end
      if DataModel.tempLevel == maxData.maxLevel and DataModel.tempStage == #DataModel.RoleCA.resonanceList - 1 then
        tempExp = maxData.expList[maxLevel].levelUpExp
      end
      maxExp = resonance.expList[DataModel.tempLevel].levelUpExp
    end
    DataModel.tempExp = tempExp
    DataModel.TabResonance_Lock = false
    ResonanceLoader:Refresh(true)
  end,
  CharacterInfo_Group_TabResonance_Group_TARight_Group_TABottom_StaticGrid_Item_Group_Item_Btn_Add_LongPress = function(btn, str)
    local index = tonumber(str)
    local data = DataModel.TempUse[tonumber(str)]
    if data.tempNum == data.maxNum then
      CommonTips.OpenTips(80600062)
      return
    end
    local element = View.Group_TabResonance.Group_TARight.Group_TABottom.StaticGrid_Item.grid[index]
    View.self:StartC(LuaUtil.cs_generator(function()
      while btn.Btn.isHandled do
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.05))
        local id = DataModel.RoleCA.resonanceList[DataModel.tempStage + 1].resonanceId
        local maxId = DataModel.RoleCA.resonanceList[#DataModel.RoleCA.resonanceList].resonanceId
        local maxData = PlayerData:GetFactoryData(maxId, "ResonanceFactory")
        local resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
        local maxLevel
        if DataModel.tempStage == #DataModel.RoleCA.resonanceList - 1 and maxData.maxLevel == DataModel.RoleData.re_lv then
          maxLevel = maxData.maxLevel - 1
        else
          maxLevel = maxData.maxLevel
        end
        if id == maxId and maxLevel <= DataModel.tempLevel then
          CommonTips.OpenTips(80600130)
          break
        end
        if data.tempNum == data.maxNum and data.tempNum ~= 0 then
          break
        end
        data.tempNum = math.min(data.tempNum + 1, data.maxNum)
        if data.tempNum > 0 then
          element.Txt_Use:SetActive(true)
          element.Btn_Reduce.self:SetActive(true)
          element.Txt_Use:SetText(data.tempNum)
        else
          element.Txt_Use:SetText(0)
          element.Btn_Reduce.self:SetActive(false)
        end
        local totalExp = DataModel.TempUse[index].exp
        local level = DataModel.tempLevel
        local exp = DataModel.tempExp
        local tempExp = exp + totalExp
        local maxExp = resonance.expList[DataModel.tempLevel].levelUpExp
        while tempExp >= maxExp do
          if DataModel.tempStage == #DataModel.RoleCA.resonanceList - 1 and level == resonance.maxLevel - 1 then
            tempExp = 0
            DataModel.tempLevel = DataModel.tempLevel + 1
            break
          end
          tempExp = tempExp - maxExp
          if resonance.maxLevel == DataModel.tempLevel then
            DataModel.tempLevel = 1
            DataModel.tempStage = DataModel.tempStage + 1
            id = DataModel.RoleCA.resonanceList[DataModel.tempStage + 1].resonanceId
            resonance = PlayerData:GetFactoryData(id, "ResonanceFactory")
          else
            DataModel.tempLevel = DataModel.tempLevel + 1
          end
          if DataModel.tempLevel == DataModel.RoleData.re_lv and DataModel.tempStage == DataModel.RoleData.re_stage then
            tempExp = DataModel.RoleData.re_exp
          end
          maxExp = resonance.expList[DataModel.tempLevel].levelUpExp
        end
        DataModel.tempExp = tempExp
        DataModel.TabResonance_Lock = false
        ResonanceLoader:Refresh(true)
      end
    end))
  end,
  CharacterInfo_Group_TabAwake_Group_TABottom_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabResonance_Group_TARight_Group_TABottom_Group_Item_Btn_Reduce_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabResonance_Group_TARight_Group_TABottom_Group_Item_Btn_Reduce_LongPress = function(btn, str)
  end,
  CharacterInfo_Group_TabResonance_Group_TARight_Group_TABottom_Group_Item_Btn_Add_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabResonance_Group_TARight_Group_TABottom_Group_Item_Btn_Add_LongPress = function(btn, str)
  end,
  CharacterInfo_Group_TabBreakThrough_StaticGrid_Item_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local bkId = DataModel.RoleCA.breakthroughList[DataModel.RoleData.awake_lv + 1].breakthroughId
    local materialList = PlayerData:GetFactoryData(bkId, "BreakthroughFactory").materialList
    CommonTips.OpenRewardDetail(materialList[tonumber(str)].itemId)
  end,
  CharacterInfo_Group_TabBreakThrough_Group_TBRight_Group_TBBottom_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local level = DataModel.RoleData.awake_lv
    if level >= #DataModel.RoleCA.breakthroughList - 1 then
      print("满级")
      element.self:SetActive(false)
      return
    end
    local bkId = DataModel.RoleCA.breakthroughList[level + 1].breakthroughId
    local materialList = PlayerData:GetFactoryData(bkId, "BreakthroughFactory").materialList
    local group = element
    element.self:SetActive(elementIndex <= #materialList)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    if elementIndex <= #materialList then
      local item = materialList[elementIndex]
      element.self:SetActive(true)
      local itemData = PlayerData:GetFactoryData(item.itemId, "SourceMaterialFactory")
      local needNum = item.num
      local haveNum = PlayerData:GetGoodsById(item.itemId).num
      group.Group_Cost.Txt_Need:SetText(needNum)
      group.Group_Cost.Txt_Have:SetText(haveNum)
      if needNum <= haveNum then
        group.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
      else
        group.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
      end
      local image = itemData.iconPath
      group.Group_Item.Img_Item:SetSprite(image)
    end
  end,
  CharacterInfo_Group_TabBreakThrough_Group_TBRight_Group_TBBottom_StaticGrid_Item_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local bkId = DataModel.RoleCA.breakthroughList[DataModel.RoleData.awake_lv + 1].breakthroughId
    local materialList = PlayerData:GetFactoryData(bkId, "BreakthroughFactory").materialList
    CommonTips.OpenRewardDetail(materialList[tonumber(str)].itemId)
  end,
  CharacterInfo_Group_TabBreakThrough_Group_TALeft_Group_BK_Group_Current_StaticGrid_BK_SetGrid = function(element, elementIndex)
    if tonumber(elementIndex) <= DataModel.RoleData.awake_lv then
      element.Img_Off:SetActive(false)
      element.Img_On:SetActive(true)
    else
      element.Img_Off:SetActive(true)
      element.Img_On:SetActive(false)
    end
  end,
  CharacterInfo_Group_TabBreakThrough_Group_TALeft_Group_BK_Group_Next_StaticGrid_BK_SetGrid = function(element, elementIndex)
    if tonumber(elementIndex) <= DataModel.RoleData.awake_lv + 1 then
      element.Img_Off:SetActive(false)
      element.Img_On:SetActive(true)
    else
      element.Img_Off:SetActive(true)
      element.Img_On:SetActive(false)
    end
  end,
  CharacterInfo_Group_TabLevelUp_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.Group_TabLevelUp.self:SetActive(false)
    changeTab(DataModel.oldIndex, true)
    BtnController.RefreshSetRole(DataModel.RoleId)
  end,
  CharacterInfo_Group_TabLevelUp_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  CharacterInfo_Group_TabLevelUp_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabTalent_Group_TTRight_StaticGrid_Awake_SetGrid = function(element, elementIndex)
    local level = DataModel.RoleData.resonance_lv
    local id = DataModel.RoleCA.talentList[elementIndex].talentId
    local needLv = PlayerData:GetFactoryData(id, "TalentFactory").awakeLv
    element.Txt_Level:SetText(elementIndex)
    element.Txt_Tips:SetText(string.format("觉醒%d解锁", needLv))
    if level >= needLv then
      element.Img_Skill.Img_Lock:SetActive(false)
    else
      element.Img_Skill.Img_Lock:SetActive(true)
    end
    element.self:SetActive(true)
  end,
  CharacterInfo_Group_TabBreakThrough_Group_TBRight_Group_TBBottom_StaticGrid_Item_Group_Item02_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CharacterInfo_Group_TopRight_Group_CareerDetail_StaticGrid_Career_SetGrid = function(element, elementIndex)
  end,
  CharacterInfo_Group_TabResonance_Group_TARight_Group_TAMiddle_Btn_Detail_Click = function(btn, str)
  end,
  Init_Show_Active_Page = function()
    View.Group_SkillLvup.self:SetActive(false)
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabSkill")
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabAwake")
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/CharacterInfo", "Group_TabResonance")
    DataModel.TabEnum = {
      [1] = {
        btn = View.Group_TopRight.Btn_TabInfo,
        view = View.Group_TabInfo,
        loader = InfoLoader,
        isDrag = true,
        in1 = "TabInfoIn",
        out1 = "TabInfoOut",
        posX = View.Group_TabInfo.self.transform.localPosition.x
      },
      [3] = {
        btn = View.Group_TopRight.Btn_TabResonance,
        view = View.Group_TabResonance,
        loader = ResonanceLoader,
        isDrag = true,
        in1 = "TabResonanceIn",
        in2 = "TabResonanceIn2",
        out1 = "TabResonanceOut",
        out2 = "TabResonanceOut2",
        posX = View.Group_TabResonance.self.transform.localPosition.x
      },
      [4] = {
        btn = View.Group_TopRight.Btn_TabAwake,
        view = View.Group_TabAwake,
        loader = AwakeLoader,
        isDrag = true,
        in1 = "TabAwakeIn",
        in2 = "TabAwakeIn2",
        out1 = "TabAwakeOut",
        out2 = "TabAwakeOut2",
        posX = View.Group_TabAwake.self.transform.localPosition.x
      },
      [2] = {
        btn = View.Group_TopRight.Btn_TabSkill,
        view = View.Group_TabSkill,
        loader = SkillLoader,
        in1 = "TabSkillIn",
        out1 = "TabSkillOut"
      }
    }
    for i = 1, #DataModel.TabEnum do
      DataModel.TabEnum[i].loader.Init()
      DataModel.TabEnum[i].view:SetActive(false)
      if i == 4 and DataModel.TabEnum[i].btn.Img_RedPoint then
        DataModel.TabEnum[i].btn.Img_RedPoint:SetActive(PlayerData:GetAllRoleAwakeRedID(tostring(DataModel.RoleId)))
      end
    end
    changeTab(1)
  end,
  CharacterInfo_Group_TabSkill_Btn_Lvup_Click = function(btn, str)
    SkillLoader:SkillUp()
  end,
  CharacterInfo_Group_TabSkill_StaticGrid_Skill_Group_Item_Btn_Skill_Click = function(btn, str)
    local index = tonumber(str)
    SkillLoader:SelectSkill(index)
  end,
  CharacterInfo_Group_TabSkill_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local data = PlayerData:GetFactoryData(DataModel.RoleData.skills[SkillLoader.skillSelectIndex].id, "SkillFactory")
    local UITable = View.Group_TabSkill
    local itemGrid = UITable.StaticGrid_Item.grid.self
    local level = 1
    if DataModel.RoleData.skills[SkillLoader.skillSelectIndex] and DataModel.RoleData.skills[SkillLoader.skillSelectIndex].lv then
      level = DataModel.RoleData.skills[SkillLoader.skillSelectIndex].lv
    end
    local materialList = PlayerData:GetFactoryData(data.materialList[level + 1].listId, "ListFactory").materialList
    local elementData = materialList[elementIndex]
    if elementData == nil then
      element.self:SetActive(false)
      return
    end
    local materialId = elementData.id
    local materialNum = elementData.num
    local group = element
    local itemData = PlayerData:GetFactoryData(materialId, "SourceMaterialFactory")
    local haveNum = PlayerData:GetGoodsById(materialId).num
    group.Group_Cost.Txt_Need:SetText(materialNum)
    group.Group_Cost.Txt_Have:SetText(haveNum)
    if materialNum <= haveNum then
      group.Group_Cost.Txt_Have:SetColor(UIConfig.Color.White)
    else
      group.Group_Cost.Txt_Have:SetColor(UIConfig.Color.Red)
    end
    group.Group_Item.Img_Item:SetSprite(itemData.iconPath)
    element.self:SetActive(true)
  end,
  CharacterInfo_Group_TabSkill_StaticGrid_Item_Group_Item02_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  CharacterInfo_Group_TabSkill_Group_Item_Btn_Skill_Click = function(btn, str)
  end
}
return ViewFunction
