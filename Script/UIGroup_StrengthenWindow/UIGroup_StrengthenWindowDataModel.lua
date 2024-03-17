local View = require("UIGroup_StrengthenWindow/UIGroup_StrengthenWindowView")
local DataModel = {}
local Clear = function()
  if DataModel.AffixList then
    for k, v in pairs(DataModel.AffixList) do
      Object.Destroy(v)
    end
  end
end

function DataModel:Clear()
  Clear()
end

local baseDesHight = 24
local SetDownAffix = function(obj, row)
  obj.transform:Find("Txt_NewChangeEntry").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.isTitle)
  obj.transform:Find("Img_Diamond1/Txt_EntryDetail").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.descriptionShow)
  if row.index ~= 1 then
    obj.transform:Find("Txt_NewChangeEntry").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText("")
  end
  local hight_des = obj.transform:Find("Img_Diamond1/Txt_EntryDetail").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
  end
  return Hight
end
local SetDownAllAffix = function(Content, AffixList)
  local lastY = 0
  local img_desc_y = 70
  local top_des_height = img_desc_y
  local lastY_1 = 10
  local lastY_1_Bg = 0
  local count = 1
  local baseViewSpace = 668
  local space = 0
  Content.self:SetLocalPositionY(0)
  local Parent = Content.transform
  local Group_Entry = "UI/CharacterInfo/weapon/StrengthenWindow/Group_Change"
  space = top_des_height
  DataModel.AffixList = {}
  local affix_list = AffixList
  if 0 < table.count(affix_list) then
    for i = 1, table.count(affix_list) do
      local row = affix_list[i]
      local obj = View.self:GetRes(Group_Entry, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      hight = 45
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel.AffixList, obj)
      local hight_des = SetDownAffix(obj, row)
      lastY_1_Bg = hight_des
      space = space + hight_des + hight
      count = count + 1
      if baseViewSpace < space then
        View.Group_Right.ScrollView_Content:SetContentHeight(space)
      end
    end
  end
end

function DataModel:RefreshRightDownContent(list)
  local ScrollView_Content = View.Img_Message3.ScrollView_Content
  local affix_list = {}
  if list[1] then
    local row_1 = list[1]
    local now_all_affix = DataModel.Data.equip.random_affix
    local count_1 = 1
    if now_all_affix and table.count(now_all_affix) > 0 then
      for i = table.count(now_all_affix), table.count(now_all_affix) - row_1.num + 1, -1 do
        local row = now_all_affix[tostring(i - 1)]
        row.index = count_1
        row.isTitle = "获得新词缀"
        local talentCA = {}
        talentCA = PlayerData:GetFactoryData(row.id)
        if -1 < row.value then
          talentCA.descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(row.value * talentCA.CommonNum), talentCA.floatNum))
        else
          talentCA.descriptionShow = talentCA.description
        end
        row.descriptionShow = talentCA.descriptionShow
        table.insert(affix_list, row)
        count_1 = count_1 + 1
      end
    end
  end
  if list[2] then
    local row_2 = list[2]
    local now_all_extra = DataModel.Data.equip.extra_affix
    if now_all_extra and table.count(now_all_extra) > 0 then
      local row = now_all_extra
      row.index = 1
      row.num = row_2.num
      row.isTitle = "获得新替换词缀"
      local talentCA_2 = {}
      talentCA_2 = PlayerData:GetFactoryData(row.id)
      if -1 < row.value then
        talentCA_2.descriptionShow = string.format(talentCA_2.description, PlayerData:GetPreciseDecimalFloor(tonumber(row.value * talentCA_2.CommonNum), talentCA_2.floatNum))
      else
        talentCA_2.descriptionShow = talentCA_2.description
      end
      row.descriptionShow = talentCA_2.descriptionShow .. " <color='#FFB800'> " .. string.format(GetText(80601043), row.num) .. "</color>"
      table.insert(affix_list, row)
    end
  end
  print_r(affix_list)
  print_r("强化成功显示----------------")
  if affix_list and table.count(affix_list) == 0 then
    ScrollView_Content:SetActive(false)
    return
  end
  ScrollView_Content:SetActive(true)
  SetDownAllAffix(ScrollView_Content.Viewport.Content, affix_list)
end

return DataModel
