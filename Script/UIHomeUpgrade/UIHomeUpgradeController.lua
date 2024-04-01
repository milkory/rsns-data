local View = require("UIHomeUpgrade/UIHomeUpgradeView")
local DataModel = require("UIHomeUpgrade/UIHomeUpgradeDataModel")
local Controller = {}
local CalRubbishChannelCnt = function(level)
  local homeCfg = PlayerData:GetFactoryData(99900014)
  if level < homeCfg.secondOpenLevel then
    return 1
  elseif level >= homeCfg.secondOpenLevel and level < homeCfg.thirdOpenLevel then
    return 2
  else
    return 3
  end
end

function Controller:Init()
  local furCA = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
  local afterFurCA = PlayerData:GetFactoryData(furCA.upgrade, "HomeFurnitureFactory")
  local wasteoutputShow = furCA.wasteoutput > 0
  local yinuooutputShow = 0 < furCA.yinuooutput
  View.Img_UpgradeBG.Group_Title.Txt_Title:SetText(furCA.name)
  View.Img_UpgradeBG.Group_Level.Txt_LevelBefore:SetText(furCA.Level)
  View.Img_UpgradeBG.Group_Level.Txt_NumAfter:SetText(afterFurCA.Level)
  View.Img_UpgradeBG.Group_Attribute1.self:SetActive(0 < furCA.comfort)
  View.Img_UpgradeBG.Group_Attribute1.Txt_ScoresBefore:SetText(furCA.comfort)
  View.Img_UpgradeBG.Group_Attribute1.Txt_ScoresAfter:SetText(afterFurCA.comfort)
  View.Img_UpgradeBG.Group_Attribute2.self:SetActive(0 < furCA.foodScores)
  View.Img_UpgradeBG.Group_Attribute2.Txt_ScoresBefore:SetText(furCA.foodScores)
  View.Img_UpgradeBG.Group_Attribute2.Txt_ScoresAfter:SetText(afterFurCA.foodScores)
  View.Img_UpgradeBG.Group_Attribute3.self:SetActive(0 < furCA.playScores)
  View.Img_UpgradeBG.Group_Attribute3.Txt_ScoresBefore:SetText(furCA.playScores)
  View.Img_UpgradeBG.Group_Attribute3.Txt_ScoresAfter:SetText(afterFurCA.playScores)
  View.Img_UpgradeBG.Group_Attribute4.self:SetActive(0 < furCA.plantScores)
  View.Img_UpgradeBG.Group_Attribute4.Txt_ScoresBefore:SetText(furCA.plantScores)
  View.Img_UpgradeBG.Group_Attribute4.Txt_ScoresAfter:SetText(afterFurCA.plantScores)
  View.Img_UpgradeBG.Group_Attribute5.self:SetActive(0 < furCA.petScores)
  View.Img_UpgradeBG.Group_Attribute5.Txt_ScoresBefore:SetText(furCA.petScores)
  View.Img_UpgradeBG.Group_Attribute5.Txt_ScoresAfter:SetText(afterFurCA.petScores)
  View.Img_UpgradeBG.Group_Attribute6.self:SetActive(0 < furCA.fishScores)
  View.Img_UpgradeBG.Group_Attribute6.Txt_ScoresBefore:SetText(furCA.fishScores)
  View.Img_UpgradeBG.Group_Attribute6.Txt_ScoresAfter:SetText(afterFurCA.fishScores)
  local seatPrice = furCA.seatPrice or 0
  View.Img_UpgradeBG.Group_SeatPrice.self:SetActive(0 < seatPrice)
  View.Img_UpgradeBG.Group_SeatPrice.Txt_ScoresBefore:SetText(string.format(GetText(80602069), seatPrice))
  View.Img_UpgradeBG.Group_SeatPrice.Txt_ScoresAfter:SetText(string.format(GetText(80602069), afterFurCA.seatPrice or 0))
  local trustUp = furCA.trustUp or 0
  View.Img_UpgradeBG.Group_TrustUp.self:SetActive(0 < trustUp)
  View.Img_UpgradeBG.Group_TrustUp.Txt_ScoresBefore:SetText(string.format(GetText(80602068), trustUp))
  View.Img_UpgradeBG.Group_TrustUp.Txt_ScoresAfter:SetText(string.format(GetText(80602068), afterFurCA.trustUp or 0))
  View.Img_UpgradeBG.Group_Output1.self:SetActive(wasteoutputShow)
  View.Img_UpgradeBG.Group_Output1.Txt_ScoresBefore:SetText(string.format(GetText(80600743), furCA.wasteoutput))
  View.Img_UpgradeBG.Group_Output1.Txt_ScoresAfter:SetText(string.format(GetText(80600743), afterFurCA.wasteoutput))
  View.Img_UpgradeBG.Group_Output2.self:SetActive(yinuooutputShow)
  View.Img_UpgradeBG.Group_Output2.Txt_ScoresBefore:SetText(string.format(GetText(80600744), furCA.yinuooutput))
  View.Img_UpgradeBG.Group_Output2.Txt_ScoresAfter:SetText(string.format(GetText(80600744), afterFurCA.yinuooutput))
  local costInfo = furCA.upgradeCostList
  DataModel.CostItems = costInfo
  View.Img_UpgradeBG.Group_MaterialsItem.ScrollGrid_Materials.grid.self:SetStartCorner("Center")
  View.Img_UpgradeBG.Group_MaterialsItem.ScrollGrid_Materials.grid.self:SetDataCount(#costInfo)
  View.Img_UpgradeBG.Group_MaterialsItem.ScrollGrid_Materials.grid.self:RefreshAllElement()
  View.Img_UpgradeBG.Group_Rubbish:SetActive(false)
  View.Img_UpgradeBG.Group_RubbishObtain:SetActive(false)
  View.Img_UpgradeBG.Group_RubbishTime:SetActive(false)
  View.Img_UpgradeBG.Group_RubbishStore:SetActive(false)
  View.Img_UpgradeBG.Group_RubbishStoreMax:SetActive(false)
  if furCA.functionType == 12600474 then
    View.Img_UpgradeBG.Group_Rubbish:SetActive(true)
    View.Img_UpgradeBG.Group_RubbishTime:SetActive(true)
    View.Img_UpgradeBG.Group_RubbishObtain:SetActive(true)
    View.Img_UpgradeBG.Group_RubbishStore:SetActive(true)
    View.Img_UpgradeBG.Group_RubbishStoreMax:SetActive(true)
    local nowChannelCnt = CalRubbishChannelCnt(furCA.Level)
    local nextLevelChannelCnt = CalRubbishChannelCnt(afterFurCA.Level)
    View.Img_UpgradeBG.Group_Rubbish.Txt_ScoresBefore:SetText(string.format(GetText(80601576), nowChannelCnt))
    View.Img_UpgradeBG.Group_Rubbish.Txt_ScoresAfter:SetText(string.format(GetText(80601576), nextLevelChannelCnt))
    View.Img_UpgradeBG.Group_RubbishTime.Txt_ScoresBefore:SetText(furCA.compressionTime .. "s")
    View.Img_UpgradeBG.Group_RubbishTime.Txt_ScoresAfter:SetText(afterFurCA.compressionTime .. "s")
    local homeCfg = PlayerData:GetFactoryData(99900014)
    local nowObtainType = furCA.Level < homeCfg.autoModeLevel and GetText(80601890) or GetText(80601889)
    local NextObtainType = afterFurCA.Level < homeCfg.autoModeLevel and GetText(80601890) or GetText(80601889)
    View.Img_UpgradeBG.Group_RubbishObtain.Txt_ScoresBefore:SetText(nowObtainType)
    View.Img_UpgradeBG.Group_RubbishObtain.Txt_ScoresAfter:SetText(NextObtainType)
    View.Img_UpgradeBG.Group_RubbishStore.Txt_ScoresBefore:SetText(furCA.StoreRubbish)
    View.Img_UpgradeBG.Group_RubbishStore.Txt_ScoresAfter:SetText(afterFurCA.StoreRubbish)
    View.Img_UpgradeBG.Group_RubbishStoreMax.Txt_ScoresBefore:SetText(furCA.StoreRubbishMax)
    View.Img_UpgradeBG.Group_RubbishStoreMax.Txt_ScoresAfter:SetText(afterFurCA.StoreRubbishMax)
  end
end

function Controller:DoUpGrade()
  local items = {}
  for k, v in pairs(DataModel.CostItems) do
    if v.num > PlayerData:GetGoodsById(v.id).num then
      CommonTips.OpenTips(80600696)
      return
    end
    items[v.id] = v.num
  end
  Net:SendProto("furniture.upgrade", function(json)
    local mainUIDataModel = require("UIMainUI/UIMainUIDataModel")
    PlayerData:RefreshUseItems(items)
    local furCA = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
    if PlayerData.TempCache.MainUIShowState == mainUIDataModel.UIShowEnum.Coach then
      HomeManager:UpGradeFurniture(-1, DataModel.curFurUfid, furCA.upgrade)
    end
    local serverData = PlayerData:GetHomeInfo().furniture[DataModel.curFurUfid]
    PlayerData.RefreshFurSkillData(serverData, true)
    serverData.id = tostring(furCA.upgrade)
    PlayerData.RefreshFurSkillData(serverData)
    if UIManager:GetPanel("UI/MainUI/MainUI").IsActive then
      local UIMainUIView = require("UIMainUI/UIMainUIView")
      UIMainUIView.Group_Common.Group_TopLeft.Btn_Gold.Txt_Num:SetText(PlayerData:GetUserInfo().gold)
    end
    mainUIDataModel.RefreshData(PlayerData.ServerData.user_home_info.coach)
    local homeCoachDataModel = require("UIHomeCoach/UIHomeCoachDataModel")
    homeCoachDataModel.InitRoomData(PlayerData.ServerData.user_home_info.furniture)
    local afterFurCA = PlayerData:GetFactoryData(furCA.upgrade, "HomeFurnitureFactory")
    if json.reward ~= nil and #json.reward > 0 then
      CommonTips.OpenShowItem(json.reward, function()
        UIManager:Open("UI/HomeUpgrade/UpgradeSuccess", Json.encode({
          beforeNum = furCA.Level,
          afterNum = afterFurCA.Level
        }))
      end)
    else
      UIManager:Open("UI/HomeUpgrade/UpgradeSuccess", Json.encode({
        beforeNum = furCA.Level,
        afterNum = afterFurCA.Level
      }))
    end
    View.self:Confirm()
  end, DataModel.curFurUfid)
end

return Controller
