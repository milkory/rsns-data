local UICharacterInfoController = {}

function UICharacterInfoController:OnResonanceSuccess(dataModel)
  local Report_Resonance = {}
  Report_Resonance.hero_id = dataModel.RoleId
  Report_Resonance.hero_level = dataModel.RoleData.lv
  Report_Resonance.event_seq = "hero.resonance"
  Report_Resonance.resonance_lv = dataModel.RoleData.resonance_lv
  SdkReporter.TrackCharacter(Report_Resonance)
end

return UICharacterInfoController
