local View = require("UIGroup_StrengthenWindow/UIGroup_StrengthenWindowView")
local DataModel = require("UIGroup_StrengthenWindow/UIGroup_StrengthenWindowDataModel")
local ViewFunction = require("UIGroup_StrengthenWindow/UIGroup_StrengthenWindowViewFunction")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    local param = Json.decode(initParams)
    DataModel.Data = param
    print_r(param)
    print_r("强化成功----------------")
    View.Img_Equipment:SetSprite(param.ca.tipsPath)
    View.Img_Message1.Txt_EquipmentName:SetText(param.ca.name)
    View.Img_Message1.Txt_Level1:SetText("LV " .. param.beforeLv)
    View.Img_Message1.Txt_Level2:SetText("LV " .. param.nowLv)
    local propertyList_before = PlayerData:GetRoleEquipProperty(param.ca, param.beforeLv)
    local pro_before = {}
    local count = 0
    for k, v in pairs(propertyList_before) do
      if v.num ~= 0 then
        count = k
      end
    end
    pro_before = propertyList_before[count]
    View.Img_Message2.Txt_AttributeName:SetText(pro_before.name)
    View.Img_Message2.Txt_Num1:SetText(pro_before.num)
    local propertyList_now = PlayerData:GetRoleEquipProperty(param.ca, param.nowLv)
    local pro_now = {}
    pro_now = propertyList_now[count]
    View.Img_Message2.Txt_Num2:SetText(pro_now.num)
    DataModel:Clear()
    local list = {}
    for k, v in pairs(DataModel.Data.content) do
      list[v.index] = v
    end
    DataModel:RefreshRightDownContent(list)
  end,
  awake = function()
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
