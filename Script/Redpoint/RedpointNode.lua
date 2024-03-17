Class = require("UIDialog/MetatableClass")
local RedpointNode = Class.New("RedpointNode")
local Ctor = function(self, name)
  self.name = name
  self.passCnt = 0
  self.endCnt = 0
  self.redpointCnt = 0
  self.children = {}
  self.updateCb = {}
  self.parentTrans = nil
end
RedpointNode.Ctor = Ctor
return RedpointNode
