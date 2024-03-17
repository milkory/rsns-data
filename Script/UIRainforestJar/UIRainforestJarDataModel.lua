local DataModel = {}
local CreateSkinData = function(skin_id, skin_ufid, count)
  local index = DataModel.skin_list[skin_id]
  if DataModel.skin_list[index] then
    DataModel.skin_list[index].num = DataModel.skin_list[index].num + count
  else
    DataModel.skin_list[index] = {
      id = skin_id,
      num = count,
      skin_ufid = skin_ufid
    }
  end
end

function DataModel._init(ufid)
  DataModel.u_fid = ufid
  local fur_id = PlayerData:GetHomeInfo().furniture[DataModel.u_fid].id
  local fur_cfg = PlayerData:GetFactoryData(fur_id)
  DataModel.skin_list = {}
  DataModel.default_skin = fur_cfg.defaultSkin
  table.insert(DataModel.skin_list, {
    id = fur_cfg.defaultSkin,
    num = 0,
    skin_ufid = ""
  })
  DataModel.skin_list[tostring(fur_cfg.defaultSkin)] = 1
  DataModel.now_skin = DataModel.default_skin
  local index = 1
  local all_skin_list = {}
  for k, v in pairs(fur_cfg.SkinList) do
    all_skin_list[tostring(v.id)] = 1
  end
  for k, v in pairs(PlayerData:GetHomeInfo().furniture) do
    local cfg = PlayerData:GetFactoryData(v.id)
    if cfg.functionType == fur_cfg.functionType and v.u_skin ~= "" and v.u_skin ~= nil then
      DataModel.skin_list[1].num = DataModel.skin_list[1].num + 1
    end
  end
  for k, v in pairs(PlayerData:GetHomeInfo().furniture_skins) do
    if all_skin_list[v.id] then
      if v.u_fid == ufid then
        if DataModel.skin_list[tostring(v.id)] == nil then
          index = index + 1
          DataModel.skin_list[tostring(v.id)] = index
        end
        DataModel.now_skin = v.id
        CreateSkinData(v.id, k, 0)
      elseif v.u_fid == "" then
        if DataModel.skin_list[tostring(v.id)] == nil then
          index = index + 1
          DataModel.skin_list[tostring(v.id)] = index
        end
        CreateSkinData(v.id, k, 1)
      end
    end
  end
  DataModel.select_Index = 1
  table.sort(DataModel.skin_list, function(t1, t2)
    if t1.id == DataModel.now_skin then
      return true
    end
    if t2.id == DataModel.now_skin then
      return false
    end
    return tonumber(t1.id) > tonumber(t2.id)
  end)
  for i, v in ipairs(DataModel.skin_list) do
    DataModel.skin_list[v.id] = i
  end
end

function DataModel.RefreshSkinData(select_index)
  local now_index = DataModel.skin_list[DataModel.now_skin]
  local skin_ufid = DataModel.skin_list[now_index].skin_ufid
  if skin_ufid ~= "" then
    PlayerData:GetHomeInfo().furniture_skins[skin_ufid].u_fid = ""
  end
  DataModel.skin_list[now_index].num = DataModel.skin_list[now_index].num + 1
  PlayerData:GetHomeInfo().furniture[DataModel.u_fid].u_skin = ""
  local skin_ufid = DataModel.skin_list[select_index].skin_ufid
  if skin_ufid ~= "" then
    PlayerData:GetHomeInfo().furniture_skins[skin_ufid].u_fid = DataModel.u_fid
    PlayerData:GetHomeInfo().furniture[DataModel.u_fid].u_skin = skin_ufid
  end
  DataModel.skin_list[select_index].num = DataModel.skin_list[select_index].num - 1
  DataModel.now_skin = DataModel.skin_list[select_index].id
end

return DataModel
