local npcId = 0
local defaultHeight = 102
local NPCDiagGroupEnum = {Mutex = "Mutex", Order = "Order"}
local dialogGroup = {
  belongName = "",
  listId = 0,
  curIdx = 0
}
local setNpcText = function(element, txt)
  element.Img_Dialog.self:SetActive(true)
  element.Img_Dialog.Txt_Talk:SetText(txt)
  local height = element.Img_Dialog.Txt_Talk:GetHeight()
  element.Img_Dialog.Txt_Talk:SetHeight(height)
  element.Img_Dialog.self:SetHeight(defaultHeight + height)
  element.Img_Dialog.Txt_Talk:SetTweenContent(txt)
end
local getDetailText = function(info)
  local text = info.detailTxt
  if text == nil then
    text = GetTextNPCMod(info.id)
  end
  return text
end
local checkTimeLimit = function(info)
  local startTime = info.startTime or ""
  local endTime = info.endTime or ""
  if info.activityId and info.activityId > 0 then
    local activityCA = PlayerData:GetFactoryData(info.activityId)
    startTime = activityCA.startTime or ""
    endTime = activityCA.endTime or ""
  end
  local curTime = PlayerData:GetSeverTime()
  if startTime ~= "" then
    local timeStamp = TimeUtil:TimeStamp(startTime)
    if curTime < timeStamp then
      return false
    end
  end
  if endTime ~= "" then
    local timeStamp = TimeUtil:TimeStamp(endTime)
    if curTime > timeStamp then
      return false
    end
  end
  return true
end
local module = {}

function module.SetNPC(element, id, enum, specifiedUrl)
  npcId = id
  local npcConfig = PlayerData:GetFactoryData(id, "NPCFactory")
  element.self:SetActive(true)
  if specifiedUrl ~= nil then
    element.SpineAnimation_Character:SetActive(false)
    element.Img_Role:SetActive(true)
    element.Img_Role:SetSprite(npcConfig[specifiedUrl])
  elseif npcConfig.spineUrl ~= "" then
    element.SpineAnimation_Character:SetActive(true)
    element.Img_Role:SetActive(false)
    element.SpineAnimation_Character:SetData(npcConfig.spineUrl)
    local offset = Vector2(npcConfig.spineOffsetX, npcConfig.spineOffsetY)
    element.SpineAnimation_Character:SetAnchoredPosition(offset)
    if npcConfig.spineScale ~= nil then
      element.SpineAnimation_Character:SetLocalScale(Vector3(npcConfig.spineScale * 100, npcConfig.spineScale * 100, npcConfig.spineScale))
    end
  else
    element.SpineAnimation_Character:SetActive(false)
    element.Img_Role:SetActive(true)
    element.Img_Role:SetSprite(npcConfig.resUrl)
    local offset = Vector2(npcConfig.offsetX, npcConfig.offsetY)
    element.Img_Role:SetAnchoredPosition(offset)
  end
  element.Img_Name.Txt_Name:SetText(npcConfig.name)
  dialogGroup.belongName = ""
  dialogGroup.listId = 0
  dialogGroup.curIdx = 0
  if enum ~= nil then
    module.SetNPCTextByEnum(element, enum)
  end
end

function module.HandleNPCTxtTable(extraValue)
  local npcConfig = PlayerData:GetFactoryData(npcId, "NPCFactory")
  local curReputationLv = 0
  if extraValue ~= nil then
    curReputationLv = extraValue.repLv or 0
  end
  for k, v in pairs(npcConfig) do
    if type(v) == "table" then
      for k1, v1 in pairs(v) do
        local factoryName = DataManager:GetFactoryNameById(v1.id)
        if factoryName == "ListFactory" then
          local listCA = PlayerData:GetFactoryData(v1.id, factoryName)
          if listCA.listType == NPCDiagGroupEnum.Mutex then
            local dialogList = listCA.dialogList
            for i = 1, #dialogList - 1 do
              local cur = dialogList[i]
              local next = dialogList[i + 1]
              cur.detailTxt = nil
              cur.isHide = true
              if curReputationLv <= next.reputation then
                cur.isHide = false
              else
                next.isHide = false
              end
            end
          end
        else
          v1.detailTxt = nil
          v1.isHide = nil
        end
      end
    end
  end
end

function module.HandleNPCTxtSpecialTable(enum, extraValue)
  local npcConfig = PlayerData:GetFactoryData(npcId, "NPCFactory")
  if npcConfig[enum] ~= nil then
    local t = npcConfig[enum]
    if enum == "ItemText" then
      local value = extraValue[1]
      for k, v in pairs(t) do
        v.detailTxt = string.format(GetText(v.id), value)
      end
    end
  end
end

function module.SetNPCText(element, txtTable, tableName)
  if txtTable == nil or #txtTable <= 0 then
    return
  end
  if dialogGroup.belongName == tableName and dialogGroup.listId ~= 0 then
    local listCA = PlayerData:GetFactoryData(dialogGroup.listId, "ListFactory")
    local dialogList = listCA.dialogList
    if #dialogList > dialogGroup.curIdx then
      dialogGroup.curIdx = dialogGroup.curIdx + 1
      local info = dialogList[dialogGroup.curIdx]
      local text = getDetailText(info)
      setNpcText(element, text)
      return
    end
  end
  dialogGroup.belongName = tableName
  dialogGroup.listId = 0
  dialogGroup.curIdx = 0
  local totalWeight = 0
  local tempTxtTable = txtTable
  txtTable = {}
  for i, info in ipairs(tempTxtTable) do
    if checkTimeLimit(info) then
      table.insert(txtTable, info)
    end
  end
  for k, v in pairs(txtTable) do
    if not v.isHide then
      totalWeight = totalWeight + v.weight
    end
  end
  local randomWeight = math.random(1, totalWeight)
  local detailTxt = ""
  for k, v in pairs(txtTable) do
    if not v.isHide then
      randomWeight = randomWeight - v.weight
      if randomWeight <= 0 then
        local factoryName = DataManager:GetFactoryNameById(v.id)
        if factoryName == "ListFactory" then
          do
            local listCA = PlayerData:GetFactoryData(v.id, factoryName)
            local dialogList = listCA.dialogList
            if listCA.listType == NPCDiagGroupEnum.Mutex then
              for k1, v1 in pairs(dialogList) do
                if not v1.isHide then
                  detailTxt = getDetailText(v1)
                  break
                end
              end
              break
            end
            if listCA.listType == NPCDiagGroupEnum.Order then
              dialogGroup.listId = v.id
              dialogGroup.curIdx = 1
              local info = dialogList[dialogGroup.curIdx]
              detailTxt = getDetailText(info)
            end
          end
          break
        end
        detailTxt = getDetailText(v)
        break
      end
    end
  end
  if detailTxt == "" then
    element.Img_Dialog.self:SetActive(false)
    return
  end
  setNpcText(element, detailTxt)
end

function module.SetNPCTextByEnum(element, enum)
  local npcConfig = PlayerData:GetFactoryData(npcId, "NPCFactory")
  local textTable = npcConfig[enum]
  if textTable == nil then
    return
  end
  module.SetNPCText(element, textTable, enum)
end

function module.SetNPCTextOne(element, txt)
  local text = txt
  if type(txt) == "number" then
    if txt <= 0 then
      element.Img_Dialog.self:SetActive(false)
      return
    end
    text = GetText(txt)
  end
  setNpcText(element, text)
end

return module
