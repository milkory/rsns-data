local DataModel = {}
local CreatData = function(life_info)
  local data = {}
  data.id = life_info.id
  data.resonance_lv = life_info.resonanceLv
  local cfg = PlayerData:GetFactoryData(data.id)
  local desc = cfg.desc
  if cfg.isReplace then
    local param = cfg.param
    if DataModel.cachePreSkillParam[cfg.id] then
      param = param + DataModel.cachePreSkillParam[cfg.id]
    end
    if cfg.isPCT then
      param = param * 100
    else
      param = math.floor(param + 0.5)
    end
    desc = string.format(desc, param)
  end
  data.desc = desc
  return data
end

function DataModel.init(role_id)
  local homeSkillList = PlayerData:GetFactoryData(role_id).homeSkillList
  DataModel.life_list = {}
  DataModel.cachePreSkillParam = {}
  DataModel.resonance_lv = PlayerData:GetRoleById(role_id).resonance_lv or 0
  for i, v in ipairs(homeSkillList) do
    local next_index = v.nextIndex or -1
    if 0 < next_index then
      table.insert(DataModel.life_list, {
        CreatData(v),
        count = 1
      })
      local count = #DataModel.life_list
      DataModel.life_list[count].unlock_level = v.resonanceLv <= DataModel.resonance_lv and 1 or 0
      local loop_count = 1
      local preId = v.id
      while homeSkillList[next_index] and loop_count < 20 do
        DataModel.cachePreSkillParam[homeSkillList[next_index].id] = PlayerData:GetFactoryData(preId).param
        table.insert(DataModel.life_list[count], CreatData(homeSkillList[next_index]))
        local now_unlock = DataModel.life_list[count].unlock_level
        DataModel.life_list[count].unlock_level = homeSkillList[next_index].resonanceLv <= DataModel.resonance_lv and now_unlock + 1 or now_unlock
        DataModel.life_list[count].count = DataModel.life_list[count].count + 1
        preId = homeSkillList[next_index].id
        next_index = homeSkillList[next_index].nextIndex
        loop_count = loop_count + 1
      end
    elseif next_index == 0 then
      table.insert(DataModel.life_list, {
        CreatData(v),
        count = 1
      })
      DataModel.life_list[#DataModel.life_list].unlock_level = v.resonanceLv <= DataModel.resonance_lv and 1 or 0
    end
  end
end

return DataModel
