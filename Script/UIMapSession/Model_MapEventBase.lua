Class = require("UIDialog/MetatableClass")
local MapEventBase = Class.New("MapEventBase")

function MapEventBase.Ctor()
end

function MapEventBase:OnStart(ca)
end

function MapEventBase:OnUpdate()
end

function MapEventBase:GetState()
end

function MapEventBase:Dtor()
end

function MapEventBase:OnSuccess()
end

function MapEventBase:OnFail()
end

return MapEventBase
