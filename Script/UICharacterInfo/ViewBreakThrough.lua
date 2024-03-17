local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = require("UICharacterInfo/DataModel")
local _DecodeSafeNum = function(safeNumber)
  return math.floor(safeNumber / SafeMath.safeNumberTime)
end
local UICache = {}
local module = {
  Init = function(self)
    UICache = {}
  end,
  Load = function(self)
    if _Assert(UICache, {
      roleId = DataModel.RoleData.id,
      bklevel = DataModel.RoleData.awake_lv
    }) and DataModel.InitState == false then
      return
    end
    local UITable = View.Group_TabBreakThrough
    if UICache.bklevel < #DataModel.RoleCA.breakthroughList then
      local itemGrid = UITable.StaticGrid_Item.grid.self
      local bkId = DataModel.RoleCA.breakthroughList[UICache.bklevel + 1].breakthroughId
      itemGrid:RefreshAllElement()
    end
    UITable.Group_BKIcon.Img_BK:SetSprite(UIConfig.CharacterDetailBreak[UICache.bklevel])
    UITable.Group_BK.Group_Current.StaticGrid_BK.grid.self:RefreshAllElement()
    UITable.Group_BK.Group_Next.StaticGrid_BK.grid.self:RefreshAllElement()
    local RoleData = DataModel.RoleData
    DataModel.RoleAttributeNext = {}
    if RoleData.awake_lv + 1 < table.count(DataModel.RoleCA.breakthroughList) then
      local temp_data = {}
      temp_data.tHp, temp_data.tDef, temp_data.tAtk, temp_data.tCri, temp_data.tCriDamage, temp_data.tSpeed, temp_data.tBlock, temp_data.tBlockRate, temp_data.tPDamageUp, temp_data.tMDamageUp, temp_data.tFReduce, temp_data.tGetPDamageDown, temp_data.tGetMDamageDown, temp_data.tGetFDamageDown, temp_data.tGetHealUp, temp_data.tGetShieldUp, temp_data.tSummonAtkUp, temp_data.tSummonFinalDamageUp = PlayerData:CountRoleAttributeById(DataModel.RoleData.id, RoleData.skills[1].lv, RoleData.skills[2].lv, RoleData.skills[3].lv, RoleData.lv, RoleData.awake_lv + 1, RoleData.resonance_lv, RoleData.role.trust_lv or 1)
      for k, v in pairs(DataModel.AttributeBreakConfig) do
        local row = {}
        DataModel.RoleAttributeNext[k] = row
        row.name = v.txt
        row.num = temp_data[v.type] + 1.0E-7 or 0
        row.num = PlayerData:GetPreciseDecimalFloor(row.num, 2)
        row.sprite = v.sprite
      end
    end
  end
}
return module
