local View = require("UISelectItem/UISelectItemView")
local DataModel = require("UISelectItem/UISelectItemDataModel")
local CommonItem = require("Common/BtnItem")
local RefreshSelectRoleInfo = function()
  local roleCa = PlayerData:GetFactoryData(DataModel.Data.exchangeList[DataModel.selectIdx].itemId)
  View.Txt_NameCn:SetText(roleCa.name)
  View.Txt_NameEn:SetText(roleCa.EnglishName)
  View.Img_Camp:SetSprite(UIConfig.RoleCamp[tonumber(PlayerData:SearchRoleCampInt(roleCa.sideId))])
  local lineCA = PlayerData:GetFactoryData(99900017).enumJobList
  if roleCa.line == 1 or roleCa.line == 0 then
    View.Txt_Line:SetText(PlayerData:GetFactoryData(lineCA[1].tagId).tagName)
  end
  if roleCa.line == 2 then
    View.Txt_Line:SetText(PlayerData:GetFactoryData(lineCA[2].tagId).tagName)
  end
  if roleCa.line == 3 then
    View.Txt_Line:SetText(PlayerData:GetFactoryData(lineCA[3].tagId).tagName)
  end
  View.Img_LIne:SetSprite(UIConfig.CharacterLine[roleCa.line])
  View.Img_Rarity:SetSprite(UIConfig.WeaponQuality[roleCa.qualityInt])
  local viewCa = PlayerData:GetFactoryData(roleCa.viewId)
  View.Img_Mask.Group_Pos.Img_Character:SetLocalPosition(Vector3(viewCa.offsetX * 0.7 - 300, viewCa.offsetY * 0.7 + 10, 0))
  View.Img_Mask.Group_Pos.Img_Character:SetSprite(viewCa.resUrl)
end
local ViewFunction = {
  SelectItem_Btn_BG_Click = function(btn, str)
    UIManager:GoBack()
  end,
  SelectItem_Btn_Select_Click = function(btn, str)
    if DataModel.selectIdx == nil then
      CommonTips.OpenTips(80600018)
      return
    end
    local data = DataModel.Data.exchangeList[tonumber(DataModel.selectIdx)]
    local roleName = PlayerData:GetFactoryData(data.itemId).name
    CommonTips.OnPrompt(string.format(GetText(80602690), roleName), "80600068", "80600067", function()
      Net:SendProto("item.use_items", function(json)
        PlayerData:RefreshUseItems({
          [DataModel.Id] = 1
        })
        UIManager:GoBack()
        CommonTips.OpenShowItem(json.reward)
      end, tostring(DataModel.Id), 1, DataModel.selectIdx - 1)
    end)
  end,
  SelectItem_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack()
  end,
  SelectItem_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local data = DataModel.Data.exchangeList[tonumber(elementIndex)]
    local itemData = PlayerData:GetFactoryData(data.itemId)
    CommonItem:SetItem(element, {
      num = data.num,
      id = data.itemId
    })
    element.Btn_Item:SetClickParam(elementIndex)
    element.Img_Selected:SetActive(elementIndex == DataModel.selectIdx)
    local isOwn = next(PlayerData:GetRoleById(data.itemId))
    element.Img_Have:SetActive(isOwn)
  end,
  SelectItem_ScrollGrid_List_Group_Item_Btn_Item_Click = function(btn, str)
    DataModel.selectIdx = tonumber(str)
    View.ScrollGrid_List.grid.self:RefreshAllElement()
    RefreshSelectRoleInfo()
  end,
  SelectItem_Btn_Info_Click = function(btn, str)
    CommonTips.OpenUnitDetail({
      id = DataModel.Data.exchangeList[DataModel.selectIdx].itemId
    })
  end,
  RefreshSelectRoleInfo = RefreshSelectRoleInfo
}
return ViewFunction
