local UIController = require("UIChapter/Model_UIController")
local DataModel = require("UIChapter/UIChapterDataModel")
local CommonItem = require("Common/BtnItem")
local View = require("UIChapter/UIChapterView")
local UIChapterSettlemenet = require("UIChapter/UIChapterSettlement")
local ChaperMapEventListener = require("UIChapterMap/UIChapterMapEventListener")
local MapDataController = require("UIChapterMap/UIChapterMapDataController")
local MapNewDataController = require("UIChapterMap/UIChapterMapNewDataController")
local MapLevelChain = require("UIChapterMap/UIChapterMapLevelChain")
local UIChapterMapDataModel = require("UIChapterMap/UIChapterMapDataModel")
local OpenDropDetails = function()
  View.Group_DropDetails.self:SetActive(true)
  View.Group_DropDetails.ScrollGrid_Common.grid.self:SetDataCount(table.count(DataModel.dropList))
  View.Group_DropDetails.ScrollGrid_Common.grid.self:RefreshAllElement()
  View.Group_DropDetails.ScrollGrid_First.grid.self:SetDataCount(table.count(DataModel.firstPassAward))
  View.Group_DropDetails.ScrollGrid_First.grid.self:RefreshAllElement()
  View.Group_DropDetails.Txt_Perfect:SetActive(false)
  View.Group_DropDetails.ScrollGrid_Perfect.self:SetActive(false)
  if table.count(DataModel.perfectAward) > 0 then
    View.Group_DropDetails.Txt_Perfect:SetActive(true)
    View.Group_DropDetails.ScrollGrid_Perfect.self:SetActive(true)
    View.Group_DropDetails.ScrollGrid_Perfect.grid.self:SetDataCount(table.count(DataModel.perfectAward))
    View.Group_DropDetails.ScrollGrid_Perfect.grid.self:RefreshAllElement()
  end
end
local ViewFunction = {
  Chapter_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if table.count(PlayerData.Last_Chapter_Parms) ~= 0 then
      View.self:PlayAnim("ChapterOut")
      local list
      if DataModel.ChapterRecoure.UI and DataModel.ChapterRecoure.UI == "BattlePass" then
        list = Json.encode(DataModel.ChapterRecoure)
      end
      if DataModel.GobackUIPath ~= nil and DataModel.GobackUIPath ~= "" then
        UIManager:Open(DataModel.GobackUIPath, list)
      else
        UIManager:Open("UI/ChapterSelect/ChapterSelect", list)
      end
      return
    end
    UIManager:GoBack()
  end,
  Chapter_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    local callback = function()
      View.self:PlayAnim("ChapterOut")
      UIManager:GoHome()
    end
    callback()
  end,
  Chapter_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Chapter_Group_LeftBottom_Btn_Arrownext_Click = function(btn, str)
  end,
  Chapter_Group_LeftBottom_Btn_Arrowlast_Click = function(btn, str)
  end,
  Chapter_Group_SecondPanel_Btn_Background_Click = function(btn, str)
  end,
  Chapter_Group_SecondPanel_Group_BottomLeft_Group_Drop_Group_Item_00_Btn_Item_Click = function(btn, str)
    OpenDropDetails()
  end,
  Chapter_Group_SecondPanel_Group_BottomLeft_Group_Drop_Group_Item_01_Btn_Item_Click = function(btn, str)
    OpenDropDetails()
  end,
  Chapter_Group_SecondPanel_Group_BottomLeft_Group_Drop_Group_Item_02_Btn_Item_Click = function(btn, str)
    OpenDropDetails()
  end,
  Chapter_Group_SecondPanel_Group_Right_Group_BottomRight_Btn_StartFight_Click = function(btn, str)
    if DataModel.ChapterRecoure.resources then
      local row = DataModel.ChapterRecoure.resources
      if row.isOpenTime == false then
        CommonTips.OpenTips(80600140)
        return
      end
      if row.isOpen == false then
        CommonTips.OpenTips(80600140)
        return
      end
      if row.isFinshNum == 0 then
        CommonTips.OpenTips(80600143)
        return
      end
    end
    if CommonTips.OpenBuyEnergyTips(DataModel.levelId, function()
      local userInfo = PlayerData.ServerData.user_info
      UIController.SecondPanel.ShowEnergy(userInfo.energy, userInfo.max_energy or userInfo.energy)
    end) then
      return
    end
    View.self:PlayAnim("ChapterOut")
    if PlayerData.LevelChain.OnLevelChain == true then
      MapLevelChain.StartBattleLevelChain()
    else
      UIController.SecondPanel.StartBattle("Chapter", PlayerData.BattleInfo.squadIndex, nil, DataModel.ChapterRecoure.eventId)
    end
  end,
  Chapter_Group_SecondPanel_Group_Right_Group_MiddleRight_Btn_BossList_Click = function(btn, str)
  end,
  Chapter_Group_DropDetails_Btn_Close_Click = function(btn, str)
    MapLevelChain.CloseLevelChainDrops()
    View.Group_DropDetails.self:SetActive(false)
  end,
  Chapter_Group_DropDetails_ScrollGrid_First_SetGrid = function(element, elementIndex)
    local row = DataModel.firstPassAward[elementIndex]
    row.id = row.itemId
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    CommonItem:SetItem(element.Group_Item, row)
    if MapLevelChain.IsLevelChainDrops() == true then
      element.Img_Got:SetActive(MapLevelChain.GetLevelChainPass() == true)
      return
    end
    element.Img_Got:SetActive(false)
    if PlayerData:GetLevelPass(DataModel.levelId) == true then
      element.Img_Got:SetActive(true)
    end
  end,
  Chapter_Group_DropDetails_ScrollGrid_First_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.firstPassAward[tonumber(str)].itemId)
  end,
  Chapter_Group_DropDetails_ScrollGrid_Common_SetGrid = function(element, elementIndex)
    local row = DataModel.dropList[elementIndex]
    row.id = row.itemId or row.id
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    CommonItem:SetItem(element.Group_Item, row)
  end,
  Chapter_Group_DropDetails_ScrollGrid_Common_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.dropList[tonumber(str)].itemId or DataModel.dropList[tonumber(str)].id)
  end,
  Chapter_Group_SecondPanel_Group_BottomLeft_Group_Drop_Btn_More_Click = function(btn, str)
  end,
  Chapter_Btn_OpenLevelChain_Click = function(btn, str)
    MapNewDataController:LevelChainReverseTracks()
  end,
  Chapter_Group_SecondPanel_Group_Right_Group_BottomRight_Btn_LevelChainSquad_Click = function(btn, str)
    local levelChainData = PlayerData:GetFactoryData(MapLevelChain.GetLevelChainId(), "LevelChainFacotry")
    View.Group_LevelChainSquad.Group_Title.Txt_Text2_0:SetText(levelChainData.index)
    View.Group_LevelChainSquad.Group_Title.Txt_Text1_0:SetText(levelChainData.levelChainName)
    View.Group_LevelChainSquad.self:SetActive(true)
    View.Group_LevelChainSquad.StaticGrid_Squad.self:RefreshAllElement()
  end,
  Chapter_Group_LevelChainSquad_Btn_Close_Click = function(btn, str)
    View.Group_LevelChainSquad.self:SetActive(false)
  end,
  Chapter_Group_LevelChainInfo_Btn_Close_Click = function(btn, str)
    ChaperMapEventListener:EnableListener()
    View.Group_LevelChainInfo.self:SetActive(false)
  end,
  Chapter_Group_LevelChainInfo_Btn_StartLevelChain_Click = function(btn, str)
    local levelChainId = MapLevelChain.GetLevelChainId()
    View.self:PlayAnim("ChapterOut")
    MapDataController.View.self:PlayAnim("Out")
    UIController.SecondPanel.StartBattle("LevelChain", 100, levelChainId)
  end,
  Chapter_Group_ChooseSkill_StaticGrid_Skill_SetGrid = function(element, elementIndex)
    local LCLevelIndex = MapLevelChain.GetSelectedLCLevel().data.idx
    UIController.SetGridLevelChainSkills(LCLevelIndex, element, elementIndex)
  end,
  Chapter_Group_ChooseSkill_StaticGrid_Skill_Group_Item_Btn_Lvup_Click = function(btn, str)
    MapLevelChain.SetBuff(tonumber(str))
    View.Group_ChooseSkill.self:SetActive(false)
  end,
  Chapter_Group_ChooseSkill_Btn_Mask_Click = function(btn, str)
    View.Group_ChooseSkill.self:SetActive(false)
  end,
  Chapter_Group_LevelChainSquad_StaticGrid_Squad_SetGrid = function(element, elementIndex)
    UIController.SetGridLevelChainSquad(element, elementIndex)
  end,
  Chapter_Group_SecondPanel_Group_Right_Group_BottomRight_Btn_LevelEnemy_Click = function(btn, str)
    UIController.InitEnemyInfo(DataModel.levelId)
    local isHaveUnlock = false
    for k, v in pairs(DataModel.enemyDetailShowInfo) do
      if v.isUnlock == true then
        UIController.EnemyDetailShow(k)
        isHaveUnlock = true
        break
      end
    end
    View.Group_MonsterManual.self:SetActive(true)
    View.Group_MonsterManual.Group_EnemyDetail.Group_Blank.self:SetActive(not isHaveUnlock)
    View.Group_MonsterManual.Group_Enemy.ScrollGrid_Face.grid.self:SetDataCount(#DataModel.enemyDetailShowInfo)
    View.Group_MonsterManual.Group_Enemy.ScrollGrid_Face.grid.self:RefreshAllElement()
  end,
  Chapter_Group_MonsterManual_Btn_BG_Click = function(btn, str)
    View.Group_MonsterManual.Group_EnemyDetail.Group_Details.self:SetActive(false)
    View.Group_MonsterManual.self:SetActive(false)
    DataModel.curShowIdx = 0
  end,
  Chapter_Group_MonsterManual_Group_Enemy_ScrollGrid_Face_SetGrid = function(element, elementIndex)
    local curInfo = DataModel.enemyDetailShowInfo[elementIndex]
    element.Btn_tubiao.Group_Select.Img_FaceSelect:SetSprite(curInfo.faceRes)
    element.Btn_tubiao.Group_Unselect.Img_Face:SetSprite(curInfo.faceRes)
    element.Btn_tubiao.Group_Unselect.Img_Lock:SetActive(not curInfo.isUnlock)
    element.Btn_tubiao.Group_Select.Img_Boss:SetActive(curInfo.isBoss)
    element.Btn_tubiao.Group_Unselect.Img_Boss:SetActive(curInfo.isBoss)
    local isSelected = elementIndex == DataModel.curShowIdx
    element.Btn_tubiao.Group_Select.self:SetActive(isSelected)
    element.Btn_tubiao.Group_Unselect.self:SetActive(not isSelected)
    element.Btn_tubiao:SetClickParam(elementIndex)
  end,
  Chapter_Group_MonsterManual_Group_Enemy_ScrollGrid_Face_Group_Item_Btn_tubiao_Click = function(btn, str)
    local curClickIdx = tonumber(str)
    UIController.EnemyDetailShow(curClickIdx)
    View.Group_MonsterManual.Group_Enemy.ScrollGrid_Face.grid.self:RefreshAllElement()
  end,
  Chapter_Group_SecondPanel_Group_Right_Group_BottomRight_Btn_StartLevelChain_Click = function(btn, str)
  end,
  Chapter_Group_SecondPanel_Group_Right_Group_BottomRight_Btn_AutoFight_Click = function(btn, str)
  end,
  Chapter_Btn_Replay_Click = function(btn, str)
  end,
  Chapter_Group_DropDetails_ScrollGrid_Perfect_SetGrid = function(element, elementIndex)
    local row = DataModel.perfectAward[elementIndex]
    row.id = row.itemId
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    CommonItem:SetItem(element.Group_Item, row)
    if MapLevelChain.IsLevelChainDrops() == true then
      element.Img_Got:SetActive(MapLevelChain.GetLevelChainPass() == true)
      return
    end
    element.Img_Got:SetActive(false)
    if PlayerData:GetLevelPass(DataModel.levelId) == true then
      element.Img_Got:SetActive(true)
    end
  end,
  Chapter_Group_DropDetails_ScrollGrid_Perfect_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.perfectAward[tonumber(str)].itemId)
  end,
  Chapter_Group_SecondPanel_Group_Right_Group_TopRight_Btn_AddEnergy_Click = function(btn, str)
    UIManager:Open("UI/Energy/Energy", nil, function()
      local userInfo = PlayerData.ServerData.user_info
      UIController.SecondPanel.ShowEnergy(userInfo.energy, userInfo.max_energy or userInfo.energy)
    end)
  end,
  Chapter_Group_LevelChainInfo_Group_Monster_Group__ScrollGrid__SetGrid = function(element, elementIndex)
  end,
  Chapter_Group_LevelChainInfo_Group_Energy_Group_Energy_Btn_Add_Click = function(btn, str)
  end,
  Chapter_Group_ChooseSkill_StaticGrid_Skill_Group_Item_Btn_LvMax_Click = function(btn, str)
  end,
  Chapter_Group_ChooseSkill_StaticGrid_Skill_Group_Item_Btn_LvLock_Click = function(btn, str)
  end,
  Chapter_Group_ChooseSkill_Group_Item_Btn_Lvup_Click = function(btn, str)
  end,
  Chapter_Group_ChooseSkill_Group_Item_Btn_LvMax_Click = function(btn, str)
  end,
  Chapter_Group_ChooseSkill_Group_Item_Btn_LvLock_Click = function(btn, str)
  end,
  Chapter_Group_LCSettlement_Group_Victory_Group_Right_Group_CharacterExp_StaticGrid_Character_SetGrid = function(element, elementIndex)
  end,
  Chapter_Group_LCSettlement_Group_Victory_Group_Right_Group_CharacterExp_BtnPolygon_Statistics_Click = function(btn, str)
  end,
  Chapter_Group_LCSettlement_Group_Victory_Group_Right_BtnPolygon_Next_Click = function(btn, str)
  end,
  Chapter_Group_LCSettlement_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  Chapter_Group_LCSettlement_Group_Reward_StaticGrid_Reward_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Chapter_Group_LCSettlement_Group_Reward_ScrollGrid_Reward_Tab = function(index)
  end,
  Chapter_Group_LCSettlement_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  Chapter_Group_LCSettlement_Group_Reward_ScrollGrid_Reward_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Chapter_Group_MonsterManual_Group_Challenge_Btn_Start_Click = function(btn, str)
  end,
  Chapter_Group_MonsterManual_Group_Challenge_Group_Reward_Btn_Item_Click = function(btn, str)
  end,
  Chapter_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("ChapterOut", function()
      UIManager:GoBack(false)
    end)
  end,
  Chapter_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Chapter_Group_SecondPanel_Group_Right_Group_TopRight_Group_Energy_Btn_Add_Click = function(btn, str)
  end,
  Chapter_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
    UIChapterSettlemenet.SetGridReward(element, elementIndex)
  end,
  Chapter_Group_Victory_Group_Right_Group_CharacterExp_StaticGrid_Character_SetGrid = function(element, elemenetIndex)
    UIChapterSettlemenet.SetGridCharacter(element, elemenetIndex)
  end,
  Chapter_Group_Victory_Group_Right_BtnPolygon_Next_Click = function(btn, str)
    View.Group_LCSettlement.self:SetActive(false)
    MapLevelChain.ClosePanel()
  end,
  Chapter_Group_SecondPanel_Group_Right_Group_TopRight_Btn_Add_Click = function(btn, str)
  end
}
return ViewFunction
