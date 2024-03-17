local View = require("UIEquipTips/UIEquipTipsView")
local DataModel = require("UIEquipTips/UIEquipTipsDataModel")
local EquipSelected = require("UISquads/SquadEquipSelected")
local OpenDetail = function()
  View.Group_Show.Group_Details.self:SetActive(true)
  local row_attr = DataModel.Detail[1]
  local obj_attr = View.Group_Show.Group_Details.Group_GhaJian.Group_Info
  if row_attr then
    obj_attr.self:SetActive(true)
    obj_attr.Txt_Name:SetText(row_attr.name)
    obj_attr.Txt_Describe:SetText(row_attr.des)
  else
    obj_attr.self:SetActive(false)
  end
  local random_plugin = DataModel.Detail[2]
  for i = 1, 3 do
    local gaijian = "Group_GaiJian0" .. i
    View.Group_Show.Group_Details[gaijian].Group_Info:SetActive(false)
    if random_plugin and random_plugin[i] then
      View.Group_Show.Group_Details[gaijian].Group_Info:SetActive(true)
      local row_random = PlayerData:GetFactoryData(random_plugin[i])
      View.Group_Show.Group_Details[gaijian].Group_Info.Txt_Name:SetText(row_random.name)
      View.Group_Show.Group_Details[gaijian].Group_Info.Txt_Describe:SetText(row_random.des)
      View.Group_Show.Group_Details[gaijian].Group_Info.Img_Icon:SetSprite(row_random.iconSmallPath)
    end
  end
end
local ViewFunction = {
  EquipTips_Btn_Shade_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  EquipTips_Group_Show_Btn_Access_Click = function(btn, str)
  end,
  EquipTips_Group_Change_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  EquipTips_Group_Change_Btn_Remove_Click = function(btn, str)
    UIManager:GoBack(false, 1)
    EquipSelected:RemoveEquip(DataModel.params)
  end,
  EquipTips_Group_Change_Btn_Change_Click = function(btn, str)
    local params = {
      Type = DataModel.params.Type,
      RoleId = DataModel.params.RoleId,
      Index = DataModel.params.Index,
      effect = 2
    }
    UIManager:GoBack(false, 1)
    EquipSelected:InitEquipPage(DataModel.params)
  end,
  EquipTips_Group_Strengthen_Btn_Strengthen_Click = function(btn, str)
  end,
  EquipTips_Group_Strengthen_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false, 1)
  end,
  EquipTips_Group_Show_Btn_Lock_Click = function(btn, str)
  end,
  EquipTips_Group_Show_Btn_Details_Click = function(btn, str)
    if DataModel.IsDetail == false then
      return
    end
    OpenDetail()
  end,
  EquipTips_Group_Show_Group_Details_Btn_Close_Click = function(btn, str)
    View.Group_Show.Group_Details.self:SetActive(false)
  end,
  EquipTips_Group_Show_Group_Att_Group_Extra_StaticGrid_Extra_SetGrid = function(element, elementIndex)
    local row = DataModel.Txt_Additional[tonumber(elementIndex)]
    element:SetActive(false)
    if row ~= "" and row ~= nil then
      element:SetActive(true)
      element.Txt_Att:SetText(row)
    end
  end
}
return ViewFunction
