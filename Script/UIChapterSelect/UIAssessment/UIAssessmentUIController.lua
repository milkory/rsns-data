local DataModel = require("UIChapterSelect/UIAssessment/UIAssessmentDataModel")
local View = require("UIChapterSelect/UIChapterSelectView")
local CommonItem = require("Common/BtnItem")
local ShowFirstPassAward = function(item, itemCA, isReceived)
  if item.Current == nil then
    item.Current = {}
  end
  item.Current = itemCA
  CommonItem:SetItem(item.Group_Item, itemCA)
  item.Img_Got:SetActive(isReceived)
end
local OpenBonusWindow = function()
  View.Group_Bonus.self:SetActive(true)
end
local module = {
  OnDestroy = function()
    DataModel.selectedChapterId = nil
    DataModel.levelList = nil
    DataModel.selectedLevelIndex = nil
  end
}

function module:RefreshAll()
  local levelData = DataModel.levelList[DataModel.selectedLevelIndex]
  local levelCA = PlayerData:GetFactoryData(levelData.levelId, "LevelFactory")
  self.RrefreshLevelInfo(View.Group_Assessment.Group_Right, levelCA)
  self.RefreshBonus(View.Group_Bonus, View.Group_Assessment, levelCA)
end

function module.RrefreshLevelInfo(Group_Right, levelCA)
  if Group_Right.Current == nil then
    Group_Right.Current = {}
  end
  Group_Right.Group_Pre.Img_Pre:SetSprite(levelCA.levelPreview)
  Group_Right.Group_Info.Group_LevelTitle.Txt_MainTitle:SetText(levelCA.levelName)
  Group_Right.Group_Info.Group_Plot.Txt_Plot:SetText(levelCA.description)
end

function module.RefreshBonus(Group_Bonus, Group_Assessment, levelCA)
  local levelPassed = PlayerData:GetLevelPass(levelCA.id)
  local rewardsReceived = PlayerData:GetLevelFirstRewardsReceived(levelCA.id)
  if levelPassed and rewardsReceived then
    Group_Assessment.Group_Right.Group_Bonus.Btn_Bonus.self:SetActive(false)
  else
    Group_Assessment.Group_Right.Group_Bonus.Btn_Bonus.self:SetActive(true)
    Group_Assessment.Group_Right.Group_Bonus.Btn_Bonus.Img_Outline:SetActive(levelPassed and not rewardsReceived)
  end
  Group_Bonus.self:SetActive(false)
  local items = Group_Bonus.Img_win
  for i = 1, 3 do
    local item = items["Group_Item_0" .. i]
    local bonus = levelCA.firstPassAward[i]
    if bonus ~= nil then
      item.self:SetActive(true)
      local itemCA = PlayerData:GenItemInfo(bonus.itemId, bonus.num)
      ShowFirstPassAward(item, itemCA, levelPassed)
    else
      item.self:SetActive(false)
    end
  end
end

function module.StartBattle(levelCA)
  local status = {}
  status.curLevelId = levelCA.id
  status.Current = "College"
  UIManager:Open("UI/Squads/Squads", Json.encode(status))
end

function module.BonusClick()
  local levelId = DataModel.levelList[DataModel.selectedLevelIndex].levelId
  local callback = function(json)
    local reward = json.reward
    if table.count(reward) > 0 then
      PlayerData:RefreshItems(reward, "add")
    end
    OpenBonusWindow()
  end
  if PlayerData:GetLevelPass(levelId) == false then
    OpenBonusWindow()
    return
  end
  Net:SendProto("battle.academy_awards", callback, levelId)
end

return module
