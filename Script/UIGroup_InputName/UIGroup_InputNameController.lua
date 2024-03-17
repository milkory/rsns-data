local View = require("UIGroup_InputName/UIGroup_InputNameView")
local DataModel = require("UIGroup_InputName/UIGroup_InputNameDataModel")
local Controller = {}
local characterLimit = 18

function Controller:InitView(initData)
  if next(initData) == nil then
    DataModel.isGuide = false
  end
  View.Group_BG.InputField_Name.self:SetText("")
  View.Group_BG.InputField_Name.self:SetCharacterLimit(characterLimit)
  if next(DataModel.FirstName) == nil then
    local data = GetCA(99900011)
    DataModel.FirstName = {}
    DataModel.LastName = {}
    for k, v in pairs(data.firstNameList) do
      DataModel.FirstName[k] = v.firstName
    end
    for k, v in pairs(data.secondNameList) do
      DataModel.LastName[k] = v.secondName
    end
  end
  local isFree = self:IsFree()
  View.Group_BG.Txt_Free:SetActive(isFree)
  View.Group_BG.Group_Cost:SetActive(not isFree)
end

function Controller:IsFree()
  local renameCnt = PlayerData:GetUserInfo().rename_cnt
  local isFree = renameCnt < 2
  return isFree
end

function Controller:ModifyName()
  local isFree = self:IsFree()
  local diamondNeed = 0
  if View.Group_BG.InputField_Name.self:GetText() == "" then
    CommonTips.OpenTips(GetText(80600225))
    return
  end
  local costList = PlayerData:GetFactoryData(99900001, "ConfigFactory").renameCost
  for k, v in pairs(costList) do
    local id = v.id
    diamondNeed = v.num
    if not isFree and PlayerData:GetGoodsById(id).num < v.num then
      CommonTips.OpenTips(80600488)
      return
    end
  end
  local result = View.Group_BG.InputField_Name.self:CheckText(characterLimit)
  if result == 0 then
    Net:SendProto("main.set_rolename", function(json)
      local trackArgs = {}
      trackArgs.amount = diamondNeed
      trackArgs.reason = "change_name"
      SdkReporter.TrackUseDiamond(trackArgs)
      PlayerData:GetUserInfo().rename_cnt = PlayerData:GetUserInfo().rename_cnt + 1
      DataModel.isGuide = false
      UIManager:GoBack()
      CommonTips.OpenTips(80601268)
    end, View.Group_BG.InputField_Name.self:GetText())
  elseif result == 1 then
    CommonTips.OpenTips(GetText(80600088))
    return
  elseif result == 2 or result == 3 then
    CommonTips.OpenTips(GetText(80600087))
    return
  end
end

function Controller:RandomName()
  local firstRandom = math.random(1, #DataModel.FirstName)
  local lastRandom = math.random(1, #DataModel.LastName)
  View.Group_BG.InputField_Name.self:SetText(DataModel.FirstName[firstRandom] .. DataModel.LastName[lastRandom])
end

return Controller
