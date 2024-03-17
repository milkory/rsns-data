function AirEcho(str)
  if not G4AirManagerForSimulator then
    G4AirManagerForSimulator = CBus:GetManager(CS.ManagerName.G4AirManagerForSimulator)
  end
  G4AirManagerForSimulator:SendProtoForced("Echo", {str})
end
