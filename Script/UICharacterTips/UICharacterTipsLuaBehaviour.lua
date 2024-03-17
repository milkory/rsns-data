local View = require("UICharacterTips/UICharacterTipsView")
local DataModel = require("UICharacterTips/UICharacterTipsDataModel")
local ViewFunction = require("UICharacterTips/UICharacterTipsViewFunction")
local SetRole = function(roleId)
  DataModel.RoleData = {}
  DataModel.RoleCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
  DataModel.RoleData.equips = {}
  DataModel.RoleData.equips[1] = ""
  DataModel.RoleData.equips[2] = ""
  DataModel.RoleData.equips[3] = ""
  DataModel.RoleData.skills = {}
  DataModel.RoleData.lv = 1
  DataModel.RoleData.awake_lv = 0
  DataModel.RoleData.resonance_lv = 0
  DataModel.RoleData.trust_lv = 1
  DataModel.RoleData.current_skin = {}
  DataModel.RoleData.current_skin[1] = DataModel.RoleCA.viewId
  DataModel.InstantiateList = {}
  DataModel.SkillList = {}
  local SkillList = {}
  SkillList = PlayerData:GetCardDes(roleId, 1)
  for k, v in pairs(SkillList) do
    v.ExSkillList = PlayerData:GetFactoryData(v.id).ExSkillList
    table.insert(DataModel.SkillList, {
      id = v.id,
      des = v.des,
      isEx = false,
      num = DataModel.RoleCA.skillList[k].num
    })
    for c, d in pairs(v.ExSkillList) do
      local skill = DataManager:GetCardDes(d.ExSkillName)
      local skillList = Json.decode(skill)
      d.description = skillList.des
      d.ca = skill
      table.insert(DataModel.SkillList, {
        id = d.ExSkillName,
        des = d.description,
        ca = skill,
        isEx = true
      })
    end
  end
  DataModel:InfoLoad()
  DataModel:CharacterLoad()
  DataModel.Top_Right_List = {
    [1] = {
      name = "角色技能",
      element = "",
      obj = "UI/CharacterInfo/Group_Skill"
    },
    [2] = {
      name = "共振天赋",
      element = "",
      obj = "UI/CharacterInfo/Group_Resonance"
    },
    [3] = {
      name = "觉醒天赋",
      element = "",
      obj = "UI/CharacterInfo/Group_Awake"
    }
  }
  DataModel:RightInfoLoad()
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    DataModel.InfoInitPos.x = -Screen.width * 0.1 + 100
    local row = Json.decode(initParams)
    DataModel.RoleId = row.id
    DataModel.Type = row.type and row.type or 0
    DataModel.IsGoback = row.isGoback or false
    DataModel.IsBook = row.isBook or false
    if DataModel.IsBook and row.content then
      DataModel.BookRoleData = row.content
    end
    DataModel.live2D = false
    View.self:PlayAnim("TipsIn")
    View.Btn_Close:SetActive(false)
    DataModel:Reset()
    DataModel:Clear()
    SetRole(row.id)
    local Img_Live2dBg = View.Group_Information.Img_Live2dBg
    if DataModel.live2D then
      Img_Live2dBg.Img_On.transform.localPosition = Vector3(24, 0, 0)
      Img_Live2dBg:SetSprite("UI/CharacterInfo/Skin/onbg")
    else
      Img_Live2dBg.Img_On.transform.localPosition = Vector3(-24, 0, 0)
      Img_Live2dBg:SetSprite("UI/CharacterInfo/Skin/offbg")
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
    if DataModel.RoleData.current_skin[1] and not DataModel.isSpine2 and View.Group_CharacterSkin.ScrollView_Skin.self.ScrollRect.enabled then
      local scrollDelta = Input.GetAxis("Mouse ScrollWheel")
      if scrollDelta ~= 0 then
        local scale = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.transform.localScale
        if scale.x + scrollDelta >= 0.5 and scale.x + scrollDelta <= 1.5 then
          scale.x = scale.x + scrollDelta
        end
        if 0.5 <= scale.y + scrollDelta and 1.5 >= scale.y + scrollDelta then
          scale.y = scale.y + scrollDelta
        end
        View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.transform.localScale = scale
        View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Character.transform.localScale = scale
      end
      if Input.touchCount ~= 2 then
        DataModel.touchInit = false
      end
      if Input.touchCount == 2 and not DataModel.touchInit then
        DataModel.touchInit = true
        local x = math.floor(Input.GetTouch(0).position.x - Input.GetTouch(1).position.x)
        local y = math.floor(Input.GetTouch(0).position.y - Input.GetTouch(1).position.y)
        DataModel.startDis = math.floor(math.sqrt(x * x + y * y))
      end
      if Input.touchCount == 2 and DataModel.touchInit then
        local cfg = PlayerData:GetFactoryData(99900001, "ConfigFactory")
        local x = math.floor(Input.GetTouch(0).position.x - Input.GetTouch(1).position.x)
        local y = math.floor(Input.GetTouch(0).position.y - Input.GetTouch(1).position.y)
        local dis = math.floor(math.sqrt(x * x + y * y))
        local changeDisRatio = (dis - DataModel.startDis) / cfg.scaleCoefficient
        if changeDisRatio ~= 0 then
          changeDisRatio = changeDisRatio * 0.1
          local scale = View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.transform.localScale
          if scale.x + changeDisRatio >= 0.5 and scale.x + changeDisRatio <= 1.5 then
            scale.x = scale.x + changeDisRatio
          end
          if 0.5 <= scale.y + changeDisRatio and 1.5 >= scale.y + changeDisRatio then
            scale.y = scale.y + changeDisRatio
          end
          View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.transform.localScale = scale
          View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Character.transform.localScale = scale
          DataModel.startDis = dis
        end
      end
    end
  end,
  ondestroy = function()
    View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.SpineAnimation_Character:SetData("")
    View.Group_CharacterSkin.ScrollView_Skin.Viewport.Content.Group_Spine.SpineAnimation_Character.transform:GetComponent(typeof(CS.UnityEngine.MeshRenderer)).material = nil
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
