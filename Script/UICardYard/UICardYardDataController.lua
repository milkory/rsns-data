local DataModel = require("UICardYard/UICardYardDataModel")
local module = {}

function module.Deserialize()
  local battleControlManager = CBus:GetManager(CS.ManagerName.BattleControlManager)
  battleControlManager:Pause(true)
  DataModel.DeckList = Json.decode(battleControlManager:SendDeckDataToLua())
  DataModel.GraveyardList = Json.decode(battleControlManager:SendGraveYardDataToLua())
  for k, v in pairs(DataModel.DeckList) do
    local des
    local SkillList = PlayerData:GetCardDes(v.roleId)
    for c, d in pairs(SkillList) do
      if tonumber(v.skillId) == tonumber(d.id) then
        des = d.des
        break
      end
    end
    if des == nil then
      tCardDes = Json.decode(DataManager:GetCardDes(v.skillId))
      if tCardDes ~= nil then
        des = tCardDes.des
      end
    end
    v.des = des
  end
  for k, v in pairs(DataModel.GraveyardList) do
    local des
    local SkillList = PlayerData:GetCardDes(v.roleId)
    for c, d in pairs(SkillList) do
      if tonumber(v.skillId) == tonumber(d.id) then
        des = d.des
        break
      end
    end
    if des == nil then
      tCardDes = Json.decode(DataManager:GetCardDes(v.skillId))
      if tCardDes ~= nil then
        des = tCardDes.des
      end
    end
    v.des = des
  end
  battleControlManager = nil
  DataModel.currentState = DataModel.Enum.Deck
  DataModel.Current = DataModel.DeckList
  for k, v in pairs(DataModel.DeckList) do
    DataModel.DeckCount = DataModel.DeckCount + v.num
  end
  for k, v in pairs(DataModel.GraveyardList) do
    DataModel.GraveyardCount = DataModel.GraveyardCount + v.num
  end
end

function module.Destroy()
  DataModel.Current = {}
  DataModel.DeckList = {}
  DataModel.GraveyardList = {}
  DataModel.currentState = nil
  DataModel.DeckCount = 0
  DataModel.GraveyardCount = 0
end

return module
