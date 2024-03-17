local DataModel = require("UICharacterInfo/Model_Data")
local DepotUIData = require("UIDepot/Model_Data")
local EquipTipUIData = require("UIEquipTips/Model_Data")
local EquipDataCache = require("UICharacterInfo/Data_EquipDataCache")
local FakeDataSubmit = function()
  local equipUids = EquipDataCache.EquipUids
  for i = 1, #equipUids do
    DataManager.playerData:Equip(DataModel.RoleId, i - 1, equipUids[i])
  end
end
local modulePrivate = {
  _openTip = function(self, idx, uid)
    local param = {
      Status = EquipTipUIData.UIStatus.Enum.RemoveEquip,
      Uid = uid,
      RoleId = DataModel.RoleData.id,
      RoleEquipIdx = idx
    }
    UIManager:Open("UI/Common/EquipTips", Json.encode(param))
  end,
  _openList = function(self, idx)
    local param = {
      UIData = {
        Status = DepotUIData.UIStatus.Enum.SelectEquipment,
        RoleId = DataModel.RoleData.id,
        EquipIdx = idx,
        EquipType = DataModel.RoleData.ca.equipmentSlotList[idx].type
      }
    }
    UIManager:Open("UI/Depot/Depot", Json.encode(param))
  end
}
local module = {
  Submit = function(self)
    return EquipDataCache:Destory()
  end,
  Equip = function(self, roleId, equipIdx, equipUid)
    if EquipDataCache.RoleId ~= roleId then
      EquipDataCache:Init(DataModel.RoleData)
    end
    EquipDataCache.EquipUids[equipIdx + 1] = equipUid
  end,
  GetCacheEquipUids = function(self)
    return EquipDataCache.EquipUids
  end,
  ClickIdx = function(self, idx)
    if idx >= #EquipDataCache.EquipUids then
      modulePrivate:_openList(idx)
      return
    end
    local _equipUid = EquipDataCache.EquipUids[idx + 1]
    if _equipUid == nil or _equipUid == "" then
      modulePrivate:_openList(idx)
    else
      modulePrivate:_openTip(idx, _equipUid)
    end
  end
}
return module
