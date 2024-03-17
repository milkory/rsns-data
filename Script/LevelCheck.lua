local levelCheck = {}

function levelCheck.AllCheck(levelId, showTip)
  local result = levelCheck.CheckPlayerLv(levelId, showTip)
  if not result then
    return false
  end
  local result = levelCheck.CheckPreLevel(levelId, showTip)
  if not result then
    return false
  end
  local result = levelCheck.CheckMonsterManualUnlock(levelId, showTip)
  if not result then
    return false
  end
  return true
end

local CheckLevelPass = function(levelId, levelScore)
  local levelPass = PlayerData:GetLevelPass(levelId)
  if not levelPass then
    return false
  end
  local serverData = PlayerData.ServerData.chapter_level[tostring(levelId)]
  if serverData and levelScore <= serverData.score then
    return true
  end
  return false
end

function levelCheck.CheckPreLevel(levelId, showTip)
  local LevelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
  if LevelCA.specifiedLevelList ~= nil and #LevelCA.specifiedLevelList > 0 then
    if LevelCA.specifiedLevelLogical == true then
      for k, v in pairs(LevelCA.specifiedLevelList) do
        if CheckLevelPass(v.specifiedLevelId, v.specifiedLevelScore) ~= true then
          if showTip then
            local text = string.format(GetText(80600145), PlayerData:GetFactoryData(v.specifiedLevelId).levelChapter)
            if PlayerData:GetLevelPass(v.specifiedLevelId) then
              text = string.format(GetText(80600145), PlayerData:GetFactoryData(v.specifiedLevelId).levelChapter)
            end
            CommonTips.OpenTips(text)
          end
          return false, v.specifiedLevelId
        end
      end
    else
      for k, v in pairs(LevelCA.specifiedLevelList) do
        if CheckLevelPass(v.specifiedLevelId, v.specifiedLevelScore) == true then
          return true
        end
      end
      local id = LevelCA.specifiedLevelList[1].specifiedLevelId
      if showTip then
        local text = string.format(GetText(80600145), PlayerData:GetFactoryData(id).levelChapter)
        if PlayerData:GetLevelPass(id) then
          text = string.format(GetText(80600145), PlayerData:GetFactoryData(id).levelChapter)
        end
        CommonTips.OpenTips(text)
      end
      return false, id
    end
  end
  return true
end

function levelCheck.CheckPlayerLv(levelId, showTip)
  local user_lv = PlayerData:GetUserInfo().lv
  local LevelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
  local playerLevel = LevelCA.playerLevel
  if user_lv >= playerLevel then
    return true
  end
  if showTip then
    local text = string.format(GetText(80600144), playerLevel)
    CommonTips.OpenTips(text)
  end
  return false
end

function levelCheck.CheckMonsterManualUnlock(levelId, showTip)
  local data = PlayerData.ServerData.enemy
  if data == nil then
    return false
  end
  local LevelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
  if LevelCA.enemyBookId == nil or LevelCA.enemyBookId < 0 then
    return true
  end
  for k, v in pairs(data) do
    if tonumber(v) == LevelCA.enemyBookId then
      return true
    end
  end
  if showTip then
    CommonTips.OpenTips(80600270)
  end
  return false
end

return levelCheck
