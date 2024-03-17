local View = require("UIEquipTips/UIEquipTipsView")
local DataModel = require("UIEquipTips/UIEquipTipsDataModel")
local ViewFunction = require("UIEquipTips/UIEquipTipsViewFunction")
local notGet = function()
  View.Group_Show.self:SetLocalPositionY(0)
end
local CA
local GetShowAttrWeight = function(data)
  local weight = data.weight or 0
  local attributeWeight = 0
  local randomWeight = 0
  if data.attributePluginList and 0 < table.count(data.attributePluginList) then
    for k, v in pairs(data.attributePluginList) do
      attributeWeight = attributeWeight + v.weight
    end
  end
  if data.randomPluginList and 0 < table.count(data.randomPluginList) then
    for c, d in pairs(data.randomPluginList) do
      randomWeight = randomWeight + d.weight
    end
  end
  return weight + attributeWeight + randomWeight
end
local GetEquipmentAttr = function(data)
  local attrList = {}
  attrList.attack_SN = UIConfig.AttributeType.Atk
  attrList.attack_SN.num = data.attack_SN or 0
  attrList.defence_SN = UIConfig.AttributeType.Def
  attrList.defence_SN.num = data.defence_SN or 0
  attrList.healthPoint_SN = UIConfig.AttributeType.CurrentHp
  attrList.healthPoint_SN.num = data.healthPoint_SN or 0
  if data.server.attribute_plugin and 0 < table.count(data.server.attribute_plugin) then
    for k, v in pairs(data.server.attribute_plugin) do
      local pluginCA = PlayerData:GetFactoryData(v)
      if pluginCA.attributeList and 0 < table.count(pluginCA.attributeList) then
        for k, v in pairs(pluginCA.attributeList) do
          local row = UIConfig.AttributeType[v.attributeType]
          if row then
            if attrList[row.type] then
              attrList[row.type].num = attrList[row.type].num + v.num_SN
            else
              attrList[row.type] = row
              attrList[row.type].num = v.num_SN
            end
          end
        end
      end
    end
  else
    local attribute_plugin = CA.attributePluginList
    if attribute_plugin and 0 < table.count(attribute_plugin) then
      for k, v in pairs(attribute_plugin) do
        if v ~= -1 then
          local pluginCA = PlayerData:GetFactoryData(v.pluginId)
          if pluginCA.attributeList and 0 < table.count(pluginCA.attributeList) then
            for k, v in pairs(pluginCA.attributeList) do
              local row = UIConfig.AttributeType[v.attributeType]
              if attrList[row.type] then
                attrList[row.type].num = attrList[row.type].num + v.num_SN
              else
                attrList[row.type] = row
                attrList[row.type].num = v.num_SN
              end
            end
          end
        end
      end
    end
  end
  return attrList
end
local haveGet = function()
  View.Group_Show.self:SetLocalPositionY(48)
  View.Group_Change.self:SetActive(true)
end
local changeGet = function()
  View.Group_Show.self:SetLocalPositionY(48)
  View.Group_Strengthen.self:SetActive(true)
end
local buttomState = {
  [0] = notGet,
  [1] = haveGet,
  [2] = changeGet
}
local init = function(parms)
  CA = PlayerData:GetFactoryData(parms.id)
  View.Group_Show.Group_Details.self:SetActive(false)
  local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", parms.equipTagId or CA.equipTagId)
  View.Group_Show.Img_Type:SetSprite(UIConfig.EquipmentTypeMark[typeInt])
  View.Group_Show.Img_Icon:SetSprite(parms.tipsPath)
  View.Group_Show.Img_Rarity:SetSprite(UIConfig.TipConfig[tonumber(parms.qualityInt + 1)])
  View.Group_Show.Img_Quality:SetSprite(UIConfig.ItemTipQuality[tonumber(parms.qualityInt + 1)])
  View.Group_Show.Group_NameAndType.Txt_Name:SetText(parms.name)
  View.Group_Show.Group_NameAndType.Txt_Type:SetText(PlayerData:ChangeEquipmentType(parms.type))
  local Group_Att = View.Group_Show.Group_Att
  View.Group_Show.Group_Weight.self:SetActive(false)
  local attrList = GetEquipmentAttr(parms)
  local obj_attr = View.Group_Show.Group_GhaJian
  obj_attr.self:SetActive(false)
  for i = 1, 3 do
    local gaijian = "Group_GaiJian0" .. i
    View.Group_Show[gaijian]:SetActive(false)
    View.Group_Show[gaijian].Txt_Name:SetText("改良输出装置")
    View.Group_Show[gaijian].Img_Icon:SetSprite("UI\\Common\\equip_kong")
  end
  DataModel.Detail = {}
  DataModel.IsDetail = false
  if parms.server.attribute_plugin ~= nil then
    local attribute_plugin = parms.server.attribute_plugin
    if attribute_plugin and table.count(attribute_plugin) > 0 then
      local row_attr = PlayerData:GetFactoryData(attribute_plugin[1])
      local obj_attr = View.Group_Show.Group_GhaJian
      obj_attr.self:SetActive(true)
      obj_attr.Txt_Name:SetText(row_attr.name)
      obj_attr.Img_Icon:SetSprite(row_attr.iconSmallPath)
      DataModel.Detail[1] = row_attr
      DataModel.IsDetail = true
    end
    local random_plugin = parms.server.random_plugin
    if random_plugin and table.count(random_plugin) > 0 then
      DataModel.Detail[2] = random_plugin
      for i = 1, 3 do
        local gaijian = "Group_GaiJian0" .. i
        View.Group_Show[gaijian]:SetActive(false)
        if random_plugin[i] then
          View.Group_Show[gaijian]:SetActive(true)
          local random_row = PlayerData:GetFactoryData(random_plugin[i])
          View.Group_Show[gaijian].Txt_Name:SetText(random_row.name)
          View.Group_Show[gaijian].Img_Icon:SetSprite(random_row.iconSmallPath)
        end
      end
      DataModel.IsDetail = true
    end
  end
  local attributeList = {}
  for k, v in pairs(attrList) do
    if v.num ~= 0 then
      table.insert(attributeList, v)
    end
  end
  table.sort(attributeList, function(a, b)
    return a.index < b.index
  end)
  local Group_Basic = Group_Att.Group_Basic
  for i = 1, 6 do
    local attr = "Group_Attr0" .. i
    Group_Basic[attr]:SetActive(false)
    if attributeList[i] and attributeList[i].num ~= 0 then
      Group_Basic[attr]:SetActive(true)
      Group_Basic[attr].Img_Icon:SetSprite(attributeList[i].icon)
      Group_Basic[attr].Txt_Add:SetText("")
      Group_Basic[attr].Txt_Num:SetText(math.floor(attributeList[i].num))
    end
  end
  View.Group_Show.Txt_Describe:SetText(parms.des)
  View.Group_Change.self:SetActive(false)
  View.Group_Strengthen.self:SetActive(false)
  buttomState[parms.scene or 0]()
end
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    if initParams then
      local data = Json.decode(initParams)
      DataModel.params = data
      init(data)
    end
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
