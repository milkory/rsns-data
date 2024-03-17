Class = require("UIDialog/MetatableClass")
local RedpointTree = Class.New("RedpointTree")
local RedpointNode = require("Redpoint/RedpointNode")
RedpointTree.NodeNames = {
  Root = "Root",
  AchievementUI = "Root|AchievementUI",
  AchieveGroup1 = "Root|AchievementUI|Group1",
  AchieveGroup2 = "Root|AchievementUI|Group2",
  AchieveGroup3 = "Root|AchievementUI|Group3",
  AchieveGroup4 = "Root|AchievementUI|Group4",
  AchieveGroup5 = "Root|AchievementUI|Group5",
  AchieveGroup6 = "Root|AchievementUI|Group6",
  Quest = "Root|Quest",
  QuestMain = "Root|Quest|Main",
  QuestSide = "Root|Quest|Side",
  QuestHome = "Root|Quest|Home",
  QuestOrder = "Root|Quest|Order",
  Core = "Root|Core"
}
local _init = function(self)
  self.root = RedpointNode.New("Root")
  for _, name in pairs(self.NodeNames) do
    self:InsertNode(name)
  end
end
local Ctor = function(self)
end
local InsertNode = function(self, name)
  if string.nilorempty(name) then
    return false
  end
  if self:SearchNode(name) then
    return false
  end
  local node = self.root
  node.passCnt = node.passCnt + 1
  local pathList = string.split(name, "|")
  for _, path in pairs(pathList) do
    if nil == node.children[path] then
      node.children[path] = RedpointNode.New(path)
      node.children[path].endCnt = node.children[path].endCnt + 1
    end
    node = node.children[path]
    node.passCnt = node.passCnt + 1
  end
  node.endCnt = node.endCnt + 1
  return true
end
local SearchNode = function(self, name)
  if string.nilorempty(name) then
    return nil
  end
  local node = self.root
  local pathList = string.split(name, "|")
  for _, path in pairs(pathList) do
    if node == nil or node.children == nil or nil == node.children[path] then
      return nil
    end
    node = node.children[path]
  end
  if node.endCnt > 0 then
    return node
  end
  return nil
end
local DeleteNode = function(self, name)
  if nil == self:SearchNode(name) then
    return false
  end
  local node = self.root
  node.passCnt = node.passCnt - 1
  local pathList = string.split(name, "|")
  for _, path in pairs(pathList) do
    local childNode = node.children[path]
    childNode.passCnt = childNode.passCnt - 1
    if 0 == childNode.passCnt then
      node.children[path] = nil
      return true
    end
    node = childNode
  end
  node.endCnt = node.endCnt - 1
  return true
end
local ForceDeleteNodeChildren = function(self, name)
  if nil == self:SearchNode(name) then
    return false
  end
  local node = self.root
  local pathList = string.split(name, "|")
  for _, path in pairs(pathList) do
    local childNode = node.children[path]
    node = childNode
  end
  local childrenCnt = table.count(node.children)
  node = self.root
  node.passCnt = node.passCnt - childrenCnt
  for _, path in pairs(pathList) do
    local childNode = node.children[path]
    childNode.passCnt = childNode.passCnt - childrenCnt
    if 0 == childNode.passCnt then
      node.children[path] = nil
      return true
    end
    node = childNode
  end
  node.children = {}
  return true
end
local ChangeRedpointCnt = function(self, name, delta)
  local targetNode = self:SearchNode(name)
  if nil == targetNode then
    return
  end
  if next(targetNode.children) then
    CS.UnityEngine.Debug.LogWarning(targetNode.name .. "节点：不是叶子节点")
    return
  end
  if targetNode.redpointCnt > 0 and 0 < delta then
    CS.UnityEngine.Debug.LogWarning(targetNode.name .. "节点：叶子节点已经存在红点，不需要设置")
    return
  end
  if 1 < delta or delta < -1 then
    CS.UnityEngine.Debug.LogWarning(targetNode.name .. "节点：每次设置红点数 只能为 1或-1")
    return
  end
  if delta < 0 and targetNode.redpointCnt + delta < 0 then
    delta = -targetNode.redpointCnt
  end
  local node = self.root
  local pathList = string.split(name, "|")
  for _, path in pairs(pathList) do
    local childNode = node.children[path]
    childNode.redpointCnt = childNode.redpointCnt + delta
    node = childNode
    for _, cb in pairs(node.updateCb) do
      cb(node.redpointCnt)
    end
  end
end
local SearchNodeCallBack = function(self, name, key)
  local node = self:SearchNode(name)
  if nil == node then
    return
  end
  return node.updateCb[key]
end
local SetCallBack = function(self, name, key, cb)
  local node = self:SearchNode(name)
  if nil == node then
    return
  end
  node.updateCb[key] = cb
end
local GetRedpointCnt = function(self, name)
  local node = self:SearchNode(name)
  if nil == node then
    return 0
  end
  return node.redpointCnt or 0
end
RedpointTree._init = _init
RedpointTree.Ctor = Ctor
RedpointTree.InsertNode = InsertNode
RedpointTree.SearchNode = SearchNode
RedpointTree.DeleteNode = DeleteNode
RedpointTree.ForceDeleteNodeChildren = ForceDeleteNodeChildren
RedpointTree.ChangeRedpointCnt = ChangeRedpointCnt
RedpointTree.SearchNodeCallBack = SearchNodeCallBack
RedpointTree.SetCallBack = SetCallBack
RedpointTree.GetRedpointCnt = GetRedpointCnt
return RedpointTree
