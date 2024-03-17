local View = require("UIChapterMap/UIChapterMapView")

function VectorLength(x1, y1, x2, y2)
  local x = x2 - x1
  local y = y2 - y1
  return math.sqrt(x * x + y * y)
end

function Cross(x1, y1, x2, y2)
  return x1 * y2 - x2 * y1
end

function GetAngle(x1, y1, x2, y2)
  if x2 == x1 then
    if y1 < y2 then
      return 90
    else
      return -90
    end
  end
  if y2 == y1 then
    if x1 < x2 then
      return 0
    else
      return 180
    end
  end
  if x1 < x2 then
    if y1 < y2 then
      return 45
    else
      return -45
    end
  elseif y1 < y2 then
    return 135
  else
    return -135
  end
  if y1 < y2 then
    if x1 < x2 then
      return -135
    else
      return -45
    end
  elseif x1 < x2 then
    return 135
  else
    return 45
  end
end

function GetDirection(x1, y1, x2, y2)
  if x2 == x1 then
    if y1 < y2 then
      return -1
    else
      return 1
    end
  end
  if y2 == y1 then
    if x1 < x2 then
      return 1
    else
      return -1
    end
  end
  if x1 < x2 then
    return 1
  else
    return -1
  end
  if y1 < y2 then
    return -1
  else
    return 1
  end
end

function SetNodeTransform(node, x, y, rotation, flip)
  node.self:SetLocalPosition(Vector3(x, y, 0))
  node.self:SetLocalEulerAngles(rotation)
  for k, v in pairs(node) do
    if k ~= "self" and k ~= "data" then
      v:SetWidthHeight(90, 90)
    end
  end
  if flip == true then
    node.self:SetLocalScale(Vector3(1, -1, 1))
  else
    node.self:SetLocalScale(Vector3.one)
  end
end

function SetRouteTransform(node, x, y, rotation, length)
  node.self:SetLocalPosition(Vector3(x, y, 0))
  node.self:SetLocalEulerAngles(rotation)
  for k, v in pairs(node) do
    if k ~= "self" and k ~= "data" then
      v:SetWidth(length - 80)
    end
  end
  node.self:SetLocalScale(Vector3.one)
end

function SetNode(node, direction)
  local mapNode
  local name = "Group_Node" .. node.sid
  if View.Group_Map.Group_Track.Group_Node[name] ~= nil then
    mapNode = View.Group_Map.Group_Track.Group_Node[name]
    mapNode.self:SetActive(true)
  else
    mapNode = View.self:InstantiateNode(name, View.Group_Map.Group_Track.Group_Node.self.transform)
    View.Group_Map.Group_Track.Group_Node[name] = mapNode
  end
  if mapNode.data ~= nil and mapNode.data.isActive == true then
    return mapNode
  end
  SetNodeTransform(mapNode, node.x, node.y, node.asset.rot, node.asset.flip)
  mapNode.data = {}
  mapNode.data.isActive = true
  mapNode.data.next = {}
  mapNode.data.prev = {}
  mapNode.data.sid = node.sid
  mapNode.data.a = node.asset.a
  mapNode.data.type = node.asset.color
  mapNode.data.isNode = true
  mapNode.data.dir = direction
  mapNode.data.rot = node.asset.rot
  return mapNode
end

function SetRoute(node, rotation, routeCount, length)
  local name = "Group_Route" .. routeCount
  local route
  if View.Group_Map.Group_Track.Group_Route[name] ~= nil then
    route = View.Group_Map.Group_Track.Group_Route[name]
    route.self:SetActive(true)
  else
    route = View.self:InstantiateRoute(name, View.Group_Map.Group_Track.Group_Route.self.transform)
    View.Group_Map.Group_Track.Group_Route[name] = route
  end
  SetRouteTransform(route, node.x, node.y, rotation, length)
  route.data = {}
  route.data.next = {}
  route.data.type = node.asset.color
  route.data.a = "s"
  return route
end

function SetLevel(node)
  local level
  local name = "Group_Level" .. node.sid
  if View.Group_Map.Group_Track.Group_Level[name] ~= nil then
    level = View.Group_Map.Group_Track.Group_Level[name]
    level.self:SetActive(true)
  else
    level = View.self:InstantiateLevel(name, View.Group_Map.Group_Track.Group_Level.self.transform)
    View.Group_Map.Group_Track.Group_Level[name] = level
  end
  level.Btn_Item:SetClickParam(name)
  level.data = {}
  level.data.next = {}
  return level
end

local model = {}

function model.SetNodes(track, nodes, count)
  local currentNodeData = nodes[tostring(track.nodes[1])]
  local nextNodeData = nodes[tostring(track.nodes[2])]
  local routeCount = count
  local offset = 0
  local prevRotation = 0
  local prevVectorX = nextNodeData.x - currentNodeData.x
  local prevVectorY = nextNodeData.y - currentNodeData.y
  local prevRoute
  local count = #track.nodes
  for i = 1, count - 1 do
    currentNodeData = nodes[tostring(track.nodes[i])]
    nextNodeData = nodes[tostring(track.nodes[i + 1])]
    local rotation = GetAngle(currentNodeData.x, currentNodeData.y, nextNodeData.x, nextNodeData.y)
    local vectorX = nextNodeData.x - currentNodeData.x
    local vectorY = nextNodeData.y - currentNodeData.y
    local direction = GetDirection(currentNodeData.x, currentNodeData.y, nextNodeData.x, nextNodeData.y)
    local curRoute = SetRoute(currentNodeData, rotation, routeCount, VectorLength(currentNodeData.x, currentNodeData.y, nextNodeData.x, nextNodeData.y))
    routeCount = routeCount + 1
    local curNode = SetNode(currentNodeData, direction)
    if prevRoute ~= nil then
      table.insert(prevRoute.data.next, curNode)
    end
    table.insert(curNode.data.next, curRoute)
    prevRoute = curRoute
    prevRotation = rotation
    prevVectorX = vectorX
    prevVectorY = vectorY
  end
  currentNodeData = nodes[tostring(track.nodes[count])]
  local curNode = SetNode(currentNodeData, prevRotation, 0, 0)
  table.insert(prevRoute.data.next, curNode)
  return routeCount
end

function model.SetLevels(levels, idList)
  local count = table.count(levels)
  local levelList = {}
  for k, v in pairs(levels) do
    table.insert(levelList, v)
  end
  table.sort(levelList, function(a, b)
    return b.y < a.y
  end)
  for i = 1, count do
    local levelData = levelList[i]
    local level = SetLevel(levelData)
    level.self:SetLocalPosition(Vector3(levelData.x, levelData.y, 0))
    level.self:SetLocalScale(Vector3(1, 1, 1))
    level.data.node = View.Group_Map.Group_Track.Group_Node["Group_Node" .. levelData.node]
    level.data.node.data.hasLevel = true
    level.data.node.data.level = level
    if level.data.node.data.a == "s" then
      for k, v in pairs(level.data.node) do
        if k ~= "self" and k ~= "data" then
          v:SetWidthHeight(90, 14)
        end
      end
    end
    level.data.levelId = idList[levelData.sid].levelId
    level.data.sid = levelData.sid
    level.data.x = levelData.x
    level.data.y = levelData.y
  end
end

function model:BuildMap(allPath, stageInfoList)
  local levels = allPath.levels
  local tracks = allPath.tracks
  local canvas = allPath.canvas
  local nodes = allPath.nodes
  local routeCount = 1
  View.self:SetCanvasWidthHeight(canvas.width, canvas.height)
  View.self:SetToWorldCanvas()
  View.self:ResetMapTransform()
  local trackCount = table.count(tracks)
  local idx = 1
  local validIdx = 1
  while trackCount >= validIdx do
    if tracks[tostring(idx)] ~= nil then
      routeCount = self.SetNodes(tracks[tostring(idx)], nodes, routeCount)
      validIdx = validIdx + 1
    end
    idx = idx + 1
  end
  self.SetLevels(levels, stageInfoList)
end

return model
