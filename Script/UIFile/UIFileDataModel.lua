local DataModel = {processBarWidth = 0}

function DataModel.initData(roleId)
  local roleCofig = PlayerData:GetFactoryData(roleId)
  DataModel.RoleCA = roleCofig
  DataModel.roleId = roleId
  DataModel.roleTrustLv = PlayerData:GetRoleById(roleId).trust_lv or 1
  DataModel.roleTrustLvExp = PlayerData:GetRoleById(roleId).trust_exp or 0
  local trustCfg = PlayerData:GetFactoryData(99900039)
  DataModel.trustExpList = trustCfg.trustExpList
  DataModel.trustAudioList = {}
  local file_id = roleCofig.fileList[1].file
  local file_cfg = PlayerData:GetFactoryData(file_id)
  DataModel.BattleAudio = file_cfg.BattleAudio
  DataModel.file_cfg = file_cfg
  local has_gender_sound = file_cfg.AudioM and next(file_cfg.AudioM)
  if has_gender_sound then
    local gender = PlayerData:GetUserInfo().gender or 1
    local gender_list = gender == 1 and file_cfg.AudioM or file_cfg.AudioF
    local normal_list = file_cfg.TrustAudio
    local normal_indx = 1
    local gender_indx = 1
    while normal_list[normal_indx] or gender_list[gender_indx] do
      if gender_list[gender_indx] == nil then
        table.insert(DataModel.trustAudioList, normal_list[normal_indx])
        normal_indx = normal_indx + 1
      elseif normal_list[normal_indx] == nil then
        table.insert(DataModel.trustAudioList, gender_list[gender_indx])
        gender_indx = gender_indx + 1
      elseif normal_list[normal_indx].UnlockLevel <= gender_list[gender_indx].UnlockLevel then
        table.insert(DataModel.trustAudioList, normal_list[normal_indx])
        normal_indx = normal_indx + 1
      else
        table.insert(DataModel.trustAudioList, gender_list[gender_indx])
        gender_indx = gender_indx + 1
      end
    end
  else
    DataModel.trustAudioList = file_cfg.TrustAudio
  end
  DataModel.soundIsExist = true
  local nowLanguage = PlayerData:GetPlayerPrefs("int", "soundLanguage")
  nowLanguage = nowLanguage == 0 and GameSetting.defaultSoundLanguage or nowLanguage
  if DataModel.file_cfg.Restype[nowLanguage] then
    DataModel.soundIsExist = DataModel.file_cfg.Restype[nowLanguage].isExistent
  end
end

return DataModel
