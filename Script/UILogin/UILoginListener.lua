local DataModel = require("UILogin/UILoginDataModel")
local Listener = {}

function Listener:Start()
  EventMgr:AddEvent("event_mainindex_receive", self.OnMainIndex)
end

function Listener:Stop()
  EventMgr:RemoveEvent("event_mainindex_receive", self.OnMainIndex)
end

function Listener.OnMainIndex()
  DataModel.SetSoundLanguage()
end

return Listener
