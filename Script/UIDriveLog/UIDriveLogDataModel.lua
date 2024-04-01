local DataModel = {}
local PetInfoData = require("UIPetInfo/UIPetInfoDataModel")
local RubbishDataModel = require("UIHomeRubbish/UIHomeRubbishDataModel")
local UpdataData = function(self)
  local coach = PlayerData.ServerData.user_home_info.coach
  local furniture = PlayerData.ServerData.user_home_info.furniture
  local unit_waste = 0
  for k, v in pairs(coach) do
    local coach_cfg = PlayerData:GetFactoryData(v.id)
    unit_waste = coach_cfg.carriageRubbish
    DataModel.createRubbish = DataModel.createRubbish + unit_waste
    for k1, v1 in pairs(v.location) do
      local tempfurniture = furniture[tostring(v1.id)]
      if tempfurniture then
        local furCA = PlayerData:GetFactoryData(tempfurniture.id)
        DataModel.comfortScore = DataModel.comfortScore + (furCA.comfort or 0)
        DataModel.foodScore = DataModel.foodScore + (furCA.foodScores or 0)
        DataModel.petScore = DataModel.petScore + PlayerData.GetFurPetScoreWithAllBuff(v1.id)
        DataModel.plantScore = DataModel.plantScore + (furCA.plantScores or 0)
        DataModel.clearScore = 999
        DataModel.entScore = DataModel.entScore + (furCA.playScores or 0)
        DataModel.fishScore = DataModel.fishScore + PlayerData.GetFurFishScoresWithAllBuff(v1.id)
        DataModel.medicalScore = DataModel.medicalScore + (furCA.medicalScores or 0)
        DataModel.bedNum = DataModel.bedNum + (furCA.characterNum or 0)
        DataModel.createGold = DataModel.createGold + (furCA.yinuooutput or 0)
        DataModel.createRubbish = DataModel.createRubbish + RubbishDataModel.CalFurRubbishCnt(tempfurniture)
        if tempfurniture.space and tempfurniture.space.reward_ts then
          local totalGenerate = 0
          local totalTime = 0
          for i, v in ipairs(tempfurniture.space.creatures) do
            local create = PlayerData:GetFactoryData(v, "HomeCreatureFactory")
            totalGenerate = totalGenerate + create.rewards[1].num
            totalTime = totalTime + create.purifyTime
          end
          totalGenerate = totalGenerate * (1 - 0.1 * (#tempfurniture.space.creatures - 1)) / (totalTime / 3600)
          DataModel.createGland = DataModel.createGland + totalGenerate
        end
      end
    end
  end
  for k, v in pairs(PlayerData:GetHomeInfo().warehouse) do
    if PlayerData:GetFactoryData(k).mod == "基础货物" then
      DataModel.tradeGoodNum = DataModel.tradeGoodNum + v.num
    end
  end
  for i, v in pairs(PlayerData.ServerData.user_home_info.furniture) do
    local furCA = PlayerData:GetFactoryData(v.id, "HomeFurnitureFactory")
    if furCA.functionType == 12600296 and v.roles and v.roles[1] and v.roles[1] ~= "" then
      local unitCA = PlayerData:GetFactoryData(v.roles[1], "UnitFactory")
      DataModel.medicalScore = DataModel.medicalScore + unitCA.medicalPoint
    end
  end
  for k, v in pairs(PlayerData:GetRoles()) do
    DataModel.memberNum = DataModel.memberNum + 1
  end
  local addValue = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddComfort)
  DataModel.comfortScore = math.floor(DataModel.comfortScore * (1 + addValue))
  addValue = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddPlantScores)
  DataModel.plantScore = math.floor(DataModel.plantScore * (1 + addValue))
  addValue = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddFoodScores)
  DataModel.foodScore = math.floor(DataModel.foodScore * (1 + addValue))
  addValue = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddPlayScores)
  DataModel.entScore = math.floor(DataModel.entScore * (1 + addValue))
  addValue = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddMedicalScores)
  DataModel.medicalScore = math.floor(DataModel.medicalScore * (1 + addValue))
end
local Init = function(self)
  local homeInfo = PlayerData.ServerData.user_home_info
  DataModel.trainName = homeInfo.home_name ~= "" and homeInfo.home_name or PlayerData:GetFactoryData(99900014).defaultName
  DataModel.durability = homeInfo.readiness.repair.current_durable
  DataModel.totalDurability = PlayerData.GetCoachMaxDurability()
  DataModel.driverNum = TimeUtil:GetTimeStampTotalDays(PlayerData:GetSeverTime() - homeInfo.open_time)
  DataModel.trainLength = #homeInfo.coach
  DataModel.bedNum = 0
  DataModel.petNum = 0
  DataModel.tPNum = homeInfo.transport_passenger_num
  local disRatio = PlayerData:GetFactoryData(99900014).disRatio
  DataModel.mileageNum = math.floor((homeInfo.drive_distance or 0) * disRatio)
  DataModel.seatNum = PlayerData:GetMaxPassengerNum()
  DataModel.memberNum = 0
  DataModel.gPNume = homeInfo.transport_goods_num
  DataModel.tradeGoodNum = 0
  DataModel.electricLevel = homeInfo.electric_lv
  DataModel.maxSpeed = PlayerData.GetCoachMaxSpeed()
  DataModel.comfortScore = 0
  DataModel.foodScore = 0
  DataModel.petScore = 0
  DataModel.plantScore = 0
  DataModel.clearScore = 0
  DataModel.entScore = 0
  DataModel.fishScore = 0
  DataModel.medicalScore = 0
  DataModel.nowGoodsNum = PlayerData:GetUserInfo().space_info.now_train_goods_num or 0
  DataModel.totalGoods = PlayerData.GetMaxTrainGoodsNum()
  DataModel.nowRubbish = homeInfo.warehouse["82900012"] and homeInfo.warehouse["82900012"].num or 0
  DataModel.createGold = 0
  DataModel.createGland = 0
  DataModel.createRubbish = 0
  DataModel.deterrence = PlayerData:GetUserInfo().deterrence + PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddDeterrence) + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AddDeterrence, PlayerData:GetUserInfo().deterrence)
  DataModel.coloudness = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.AddColoudness) + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.AddColoudness, 0)
  UpdataData(self)
end

function DataModel.LoadSpineBg(viewId)
  local View = require("UIDriveLog/UIDriveLogView")
  local roleId = PlayerData.ServerData.user_info.receptionist_id
  local live2D = PlayerData:GetPlayerPrefs("int", roleId .. "live2d")
  if live2D == 1 or DataModel.playMainAni then
    View.Group_PosterGirl.Img_SpineBG:SetActive(false)
    return
  end
  local viewCfg = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  if viewCfg.SpineBackground and viewCfg.SpineBackground ~= "" then
    View.Group_PosterGirl.Img_SpineBG:SetSprite(viewCfg.SpineBackground)
    DataModel.offsetX = viewCfg.SpineBGX and viewCfg.SpineBGX or 0
    DataModel.offsetY = viewCfg.SpineBGY and viewCfg.SpineBGY or 0
    local x = View.Group_PosterGirl.Spine_.transform.localPosition.x - DataModel.offsetX
    View.Group_PosterGirl.Img_SpineBG.transform.localPosition = Vector3(x, DataModel.offsetY, 0)
    local scale = viewCfg.SpineBGScale or 1
    View.Group_PosterGirl.Img_SpineBG.transform.localScale = Vector3(scale, scale, 0)
  end
  View.Group_PosterGirl.Img_SpineBG:SetActive(viewCfg.SpineBackground and viewCfg.SpineBackground ~= "")
end

function DataModel.SpineBgFollow()
  local View = require("UIDriveLog/UIDriveLogView")
  if View.Group_PosterGirl.Img_SpineBG.IsActive then
    local x = View.Group_PosterGirl.Spine_.transform.localPosition.x - DataModel.offsetX
    local pos = Vector3(x, DataModel.offsetY, 0)
    View.Group_PosterGirl.Img_SpineBG.transform.localPosition = pos
  end
end

DataModel.Init = Init
return DataModel
