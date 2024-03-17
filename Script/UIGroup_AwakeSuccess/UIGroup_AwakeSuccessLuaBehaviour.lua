local View = require("UIGroup_AwakeSuccess/UIGroup_AwakeSuccessView")
local DataModel = require("UIGroup_AwakeSuccess/UIGroup_AwakeSuccessDataModel")
local ViewFunction = require("UIGroup_AwakeSuccess/UIGroup_AwakeSuccessViewFunction")
local InfoInitPos = {
  isRecord = true,
  x = 0,
  y = 0,
  scale = 1,
  offsetX = 0,
  offsetY = 1
}
local AwakeSuccessRefresh = function(talentId)
  View.self:SetActive(true)
  View.Group_Role.SpineAnimation_Role:SetActive(false)
  View.Group_Role.Img_Role:SetActive(false)
  local talent_info = PlayerData:GetFactoryData(talentId)
  View.Txt_TalentDetail:SetText(talent_info.desc)
  View.Txt_TalentName:SetText(talent_info.name)
  View.Img_TalentIcon:SetSprite(PlayerData:GetFactoryData(DataModel.RoleCA.breakthroughList[DataModel.RoleData.awake_lv + 1].breakthroughId).path)
  for i = 1, 5 do
    local obj = "Group_Star" .. i
    View.Group_Star[obj].Img_White:SetActive(false)
    if i <= DataModel.RoleData.awake_lv then
      View.Group_Star[obj].Img_White:SetActive(true)
    end
  end
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local list = Json.decode(initParams)
    DataModel.RoleData = list.RoleData
    DataModel.RoleCA = list.RoleCA
    View.self:PlayAnim("Awake_In")
    AwakeSuccessRefresh(list.id)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
