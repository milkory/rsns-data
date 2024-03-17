local HomeFurnitureCollection = {}
local coach2FurMap = {}
local functionFurCollection = {}

function HomeFurnitureCollection.Init()
  coach2FurMap = {}
  functionFurCollection = {}
end

local InitfurData = function()
  local furList = PlayerData:GetFurniture()
  for k, v in pairs(furList) do
    if v.u_cid ~= "" then
      if coach2FurMap[v.u_cid] == nil then
        coach2FurMap[v.u_cid] = {}
      end
      coach2FurMap[v.u_cid][k] = v.id
    end
    local cfg = PlayerData:GetFactoryData(v.id)
    if cfg.functionType and cfg.functionType ~= -1 then
      if functionFurCollection[cfg.functionType] == nil then
        functionFurCollection[cfg.functionType] = {}
      end
      functionFurCollection[cfg.functionType][k] = v.u_cid
    end
  end
end

function HomeFurnitureCollection.GetCoach2FurMap()
  if next(coach2FurMap) == nil then
    InitfurData()
  end
  return coach2FurMap
end

function HomeFurnitureCollection.GetFunctionByID(functionID)
  if next(coach2FurMap) == nil then
    InitfurData()
  end
  return functionFurCollection[functionID]
end

function HomeFurnitureCollection.FurDecorate(cid, ufid)
  if next(coach2FurMap) == nil then
    return
  end
  if coach2FurMap[cid] == nil then
    coach2FurMap[cid] = {}
  end
  local serverFurData = PlayerData:GetFurniture()[ufid]
  local cfg = PlayerData:GetFactoryData(serverFurData.id)
  coach2FurMap[cid][ufid] = serverFurData.id
  if cfg.functionType and cfg.functionType ~= -1 then
    if functionFurCollection[cfg.functionType] == nil then
      functionFurCollection[cfg.functionType] = {}
    end
    functionFurCollection[cfg.functionType][ufid] = cid
  end
end

function HomeFurnitureCollection.FurRemove(cid, ufid)
  if next(coach2FurMap) == nil then
    return
  end
  if coach2FurMap[cid] then
    coach2FurMap[cid][ufid] = nil
  end
  local serverFurData = PlayerData:GetFurniture()[ufid]
  local cfg = PlayerData:GetFactoryData(serverFurData.id)
  if cfg.functionType and cfg.functionType ~= -1 then
    functionFurCollection[cfg.functionType][ufid] = ""
  end
end

function HomeFurnitureCollection.FurReward(rewardTable)
  if next(coach2FurMap) == nil then
    return
  end
  for k, v in pairs(rewardTable) do
    local cfg = PlayerData:GetFactoryData(v.id)
    if cfg.functionType and cfg.functionType ~= -1 then
      if functionFurCollection[cfg.functionType] == nil then
        functionFurCollection[cfg.functionType] = {}
      end
      functionFurCollection[cfg.functionType][cfg.functionType] = v.u_cid or ""
    end
    if v.u_cid and v.u_cid ~= "" then
      if coach2FurMap[v.u_cid] == nil then
        coach2FurMap[v.u_cid] = {}
      end
      coach2FurMap[v.u_cid][k] = v.id
    end
  end
end

return HomeFurnitureCollection
