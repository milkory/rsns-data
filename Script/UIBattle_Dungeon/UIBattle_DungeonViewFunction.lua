local View = require("UIBattle_Dungeon/UIBattle_DungeonView")
local DataModel = require("UIBattle_Dungeon/UIBattle_DungeonDataModel")
local MainController = require("UIMainUI/UIMainUIController")
local CommonItem = require("Common/BtnItem")
local ViewFunction = {
  Battle_Dungeon_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Battle_Dungeon_Group_Right_Group_Drop_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.ChooseRewardList[elementIndex]
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    element.Group_First.self:SetActive(false)
    element.Group_Allready.self:SetActive(false)
    CommonItem:SetItem(element.Group_Item, row)
  end,
  Battle_Dungeon_Group_Right_Group_Fight_Btn_StartFight_Click = function(btn, str)
    PlayerData.TempCache.Yaw = TrainManager.FreeCamera.m_yaw
    PlayerData.TempCache.Pitch = TrainManager.FreeCamera.m_pitch
    local mainDataModel = require("UIMainUI/UIMainUIDataModel")
    mainDataModel.TrainEventId = DataModel.EventId
    mainDataModel.TrainLevelId = DataModel.LevelId
    PlayerData.TempCache.EventIndex = DataModel.EventIndex
    PlayerData.TempCache.AreaId = DataModel.AreaId
    MainController.ImmediatelyStop()
    MainController.Battle(DataModel.NeedLv)
  end,
  Battle_Dungeon_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Battle_Dungeon_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  Battle_Dungeon_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Battle_Dungeon_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Battle_Dungeon_Group_Right_Group_Drop_ScrollGrid_Item_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(DataModel.ChooseRewardList[tonumber(str)].id, nil, true)
  end,
  Battle_Dungeon_Group_Right_Btn_Energy_Click = function(btn, str)
    UIManager:Open("UI/Energy/Energy", nil, function()
      local user_info = PlayerData:GetUserInfo()
      local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
      local maxEnergy = user_info.max_energy or initConfig.energyMax
      local currEnergy = user_info.energy or 0
      View.Group_Right.Btn_Energy.Txt_Num:SetText(currEnergy .. "/" .. maxEnergy)
    end)
  end,
  Battle_Dungeon_Group_Right_Btn_Energy_Btn_Add_Click = function(btn, str)
  end,
  Battle_Dungeon_Group_Right_Group_Energy_Btn_AddEnergy_Click = function(btn, str)
  end
}
return ViewFunction
