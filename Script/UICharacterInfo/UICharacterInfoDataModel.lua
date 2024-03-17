local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = {}
local space = 30
local downSpace = 10
local bgHight = 255
local baseDowny = -300
local baseUPy = -40
local lastSkillId

function DataModel.OpenCardDes(data)
  if lastSkillId and lastSkillId == data.id then
    return
  end
  View.Group_TabInfo.Group_TIRight.Group_TIMiddle.Btn_Close_Des.self:SetActive(true)
  local CardDesCharacter = View.Group_TabInfo.Group_TIRight.Group_TIMiddle.Group_CardDesCharacter
  CardDesCharacter.self:SetActive(false)
  CardDesCharacter.self:SetActive(true)
  CardDesCharacter.Btn_Close.self:SetActive(false)
  local CA = PlayerData:GetFactoryData(data.id)
  local Group_LeaderCondition = CardDesCharacter.Group_LeaderCondition
  Group_LeaderCondition.self:SetActive(false)
  local Group_Skill = CardDesCharacter.Group_Skill.Group_Content.Group_UP.Group_Skill
  Group_Skill.Txt_Des_Leader:SetText("")
  if CA.leaderCardConditionDesc ~= nil and CA.leaderCardConditionDesc ~= "" then
    local tagCA = PlayerData:GetFactoryData(80600356)
    if tagCA.text ~= "" then
      Group_Skill.Txt_Des_Leader:SetText(tagCA.text .. CA.leaderCardConditionDesc)
    end
  end
  Group_Skill.Img_Item:SetSprite(CA.iconPath)
  Group_Skill.Txt_Des:SetText(data.description)
  Group_Skill.Txt_Name:SetText(CA.name)
  Group_Skill.Txt_LvNum:SetText("")
  Group_Skill.Txt_Lv:SetText("")
  Group_Skill.Txt_Des_Dmg:SetText(data.detailDescription)
  local des_space = 30
  local Skill_Space = Group_Skill.Txt_Des:GetHeight()
  local Skill_Space_Dmg = 0
  Group_Skill.Txt_Des:SetHeight()
  Group_Skill.Txt_Des.Rect.sizeDelta.y = Skill_Space
  if data.detailDescription ~= "" then
    Skill_Space_Dmg = Group_Skill.Txt_Des_Dmg:GetHeight()
    Group_Skill.Txt_Des_Dmg:SetHeight()
    Group_Skill.Txt_Des_Dmg.Rect.sizeDelta.y = Skill_Space_Dmg
    Skill_Space_Dmg = Skill_Space_Dmg + des_space
    local des_y = Group_Skill.Txt_Des.transform.localPosition.y - Skill_Space - des_space
    Group_Skill.Txt_Des_Dmg.transform.localPosition = Vector3(Group_Skill.Txt_Des_Dmg.transform.localPosition.x, des_y, 0)
  end
  local Group_Cost = CardDesCharacter.Group_Skill.Group_Content.Group_UP.Group_Cost
  Group_Cost.Txt_CostNum:SetText("")
  Group_Cost.Txt_Cost:SetText("")
  local skillCA = PlayerData:GetFactoryData(CA.cardID, "cardFactory")
  local costNum = CA.cardID and skillCA.cost_SN or nil
  if costNum == nil or costNum == "" or costNum == 0 then
    Group_Cost.Txt_Cost:SetActive(false)
  else
    Group_Cost.Txt_Cost:SetActive(true)
    Group_Cost.Txt_Cost:SetText("COST")
    Group_Cost.Txt_CostNum:SetText(math.ceil(costNum))
  end
  local Group_Type = CardDesCharacter.Group_Skill.Group_Content.Group_UP.Group_Type
  Group_Type.self:SetActive(false)
  local Group_DownTag = CardDesCharacter.Group_Skill.Group_Content.Group_DownTag
  Group_DownTag.self:SetActive(true)
  local show_list = {}
  local count = 1
  for k, v in pairs(skillCA.tagList) do
    local tagCA = PlayerData:GetFactoryData(v.tagId)
    show_list[count] = tagCA
    count = count + 1
  end
  local lastY = 0
  local lastSpace = 5
  local allSpace = 0
  for i = 1, 8 do
    local obj = "Group_Tag" .. i
    Group_DownTag[obj]:SetActive(false)
    local row = show_list[i]
    if row and row.isShowDetail == true then
      Group_DownTag[obj]:SetActive(true)
      Group_DownTag[obj].Txt_Tag:SetText(row.tagNameRichText .. "：" .. row.detail)
      Group_DownTag[obj].Txt_Tag:SetHeight()
      local height = Group_DownTag[obj].Txt_Tag:GetHeight()
      Group_DownTag[obj].Img_Tag:SetSprite(row.icon)
      Group_DownTag[obj].Img_Tag:SetNativeSize()
      if i == 1 then
        lastY = Group_DownTag[obj].transform.localPosition.y
        lastSpace = height
      else
        local y = lastY - lastSpace - downSpace
        Group_DownTag[obj].transform.localPosition = Vector3(Group_DownTag[obj].transform.localPosition.x, y, 0)
        lastY = y
        lastSpace = height
      end
      if height < Group_DownTag[obj].Img_Tag:GetImgHeight() then
        lastSpace = Group_DownTag[obj].Img_Tag:GetImgHeight()
      end
      allSpace = allSpace + lastSpace
    end
  end
  local finishSpace = space + allSpace + Skill_Space + Skill_Space_Dmg
  CardDesCharacter.Group_Skill.Img_Bg:SetImgWidthAndHeight(700, bgHight + finishSpace)
  CardDesCharacter.Group_Skill.Group_Content.Group_UP.transform.localPosition = Vector3(0, baseUPy + finishSpace, 0)
  local donwY = finishSpace - Skill_Space + space * 2 - Skill_Space_Dmg
  if donwY < baseDowny then
    donwY = baseDowny
  end
  CardDesCharacter.Group_Skill.Group_Content.Group_DownTag.transform.localPosition = Vector3(0, donwY + baseDowny, 0)
  local initY = 0
  for i = 0, 6 do
    local obj = "Group_" .. i
    CardDesCharacter.Group_Right[obj]:SetActive(false)
    CardDesCharacter.Group_Right[obj].transform.localPosition = Vector3(-50, initY, 0)
  end
  local baseRightHeightBg = 115
  local rightSpace = 15
  local rightLastY = 0
  local rightLastSpace
  local rightYSpace = 0
  local tagOutsideList = skillCA.tagOutsideList
  if tagOutsideList and 0 < table.count(tagOutsideList) then
    for i = 1, table.count(tagOutsideList) do
      local v = tagOutsideList[i]
      local tagCA = PlayerData:GetFactoryData(v.tagId)
      if tagCA and tagCA.isShowDetail == true then
        local obj = "Group_" .. i - 1
        CardDesCharacter.Group_Right[obj]:SetActive(true)
        CardDesCharacter.Group_Right[obj].Img_Face_Bg.Img_Face:SetSprite(tagCA.icon)
        CardDesCharacter.Group_Right[obj].Img_Mask:SetSprite(UIConfig.SkillRightPath)
        CardDesCharacter.Group_Right[obj].Txt_Des:SetText("<color=#FFB800>" .. tagCA.tagNameRichText .. "：" .. "</color>" .. tagCA.detail)
        local textHeight = CardDesCharacter.Group_Right[obj].Txt_Des:GetHeight()
        CardDesCharacter.Group_Right[obj].Txt_Des:SetHeight()
        rightLastSpace = baseRightHeightBg
        CardDesCharacter.Group_Right[obj].Img_Bg:SetImgWidthAndHeight(425, baseRightHeightBg)
        if baseRightHeightBg < textHeight then
          rightLastSpace = textHeight + rightSpace * 2
          rightYSpace = textHeight - baseRightHeightBg + rightSpace
          CardDesCharacter.Group_Right[obj].Img_Bg:SetImgWidthAndHeight(425, rightLastSpace)
        end
        if 1 < i then
          CardDesCharacter.Group_Right[obj].transform.localPosition = Vector3(-50, rightLastY + rightYSpace, 0)
        else
          CardDesCharacter.Group_Right[obj].transform.localPosition = Vector3(-50, initY + rightYSpace, 0)
        end
        rightLastY = rightLastSpace + rightSpace + rightLastY + rightYSpace
      end
    end
  end
  lastSkillId = data.id
end

function DataModel.CloseCardDes()
  View.Group_TabInfo.Group_TIRight.Group_TIMiddle.Btn_Close_Des.self:SetActive(false)
  View.Group_TabInfo.Group_TIRight.Group_TIMiddle.Group_CardDesCharacter.self:SetActive(false)
  lastSkillId = nil
end

function DataModel.AwakeSuccessRefresh()
end

return DataModel
