local PosClickHandler = {}
PosClickHandler.index = 0

function PosClickHandler.OnSpecialCharacterOver(id)
end

function PosClickHandler.OnSpecialCharacterTouch(id)
  if "UI/HomeBubble/InteractiveIcon/FastFood" == id then
    local Controller = require("UICityStore/UICityStoreDataModel")
    Controller:FastFoodClick()
  elseif tonumber(id) ~= nil then
    local idx = tonumber(id)
    local DataModel = require("UICityStore/UICityStoreDataModel")
    if idx <= #DataModel.CacheEventList then
      DataModel.CacheEventList[idx]:action()
    end
  end
end

function PosClickHandler.OnTrainClose()
end

function PosClickHandler.OnFurnitureClick(pos, typeid, uid)
  local Controller = require("UIHomeCoach/UIHomeCoachController")
  Controller:OnFurnitureClick(pos, typeid, uid)
end

function PosClickHandler.OnSpecialFurnitureClick(pos, ufid, cid)
  local Controller = require("UIHomeCoach/UIHomeCoachController")
  Controller:OnSpecialFurnitureClick(pos, ufid, cid)
end

function PosClickHandler.OnReleaseFurniture()
  local Controller = require("UIHomeCoach/UIHomeCoachController")
  Controller:OnReleaseFurniture()
end

function PosClickHandler.OnReleaseSpecialFurniture()
  local Controller = require("UIHomeCoach/UIHomeCoachController")
  Controller:OnReleaseSpecialFurniture()
end

function PosClickHandler.OnHomeRoomIndex(index)
  local Controller = require("UIHomeCoach/UIHomeCoachController")
  Controller:OnHomeRoomIndex(index)
end

function PosClickHandler.OnFurniturePileUp()
  local Controller = require("UIHomeCoach/UIHomeCoachController")
  Controller:RefreshControllerPanel()
end

function PosClickHandler.OnSpecialFurnitureTipShow(id, uid)
  local Controller = require("UIHomeCoach/UIHomeCoachController")
  Controller:OnFurnitureTipShow(id, uid)
end

function PosClickHandler.OnSpecialFurnitureClickRewards(ufid)
  Net:SendProto("creature.rec_rewards", function(json)
    PlayerData.ServerData.user_home_info.furniture[ufid] = json.furniture[ufid]
    CommonTips.OpenShowItem(json.reward)
  end, ufid, 0)
end

function PosClickHandler.OnSpecialFurnitureCollectRubbish(index, ufidStr)
  local t = PlayerData.ServerData.user_home_info.furniture
  local ufids = Split(ufidStr, ",")
  local needCid = false
  for i, ufid in ipairs(ufids) do
    local data = PlayerData.ServerData.user_home_info.furniture[ufid]
    local furniture = PlayerData:GetFactoryData(data.id, "HomeFurnitureFactory")
    local tag = PlayerData:GetFactoryData(furniture.functionType, "TagFactory")
    if tag ~= nil and tag.typeName == "垃圾桶" then
      needCid = true
    end
    if needCid then
      break
    end
  end
  local ucid = PlayerData.ServerData.user_home_info.furniture[ufids[1]].u_cid
  Net:SendProto("home.collect_waste", function(json)
    for id, v in pairs(json.furniture) do
      PlayerData.ServerData.user_home_info.furniture[id] = v
    end
    CommonTips.OpenShowItem(json.reward)
  end, needCid and ucid or "", ufidStr)
end

function PosClickHandler.OnSpecialFurnitureTipIsHave(id)
  local furniture = PlayerData:GetFactoryData(id, "HomeFurnitureFactory")
  local tag = PlayerData:GetFactoryData(furniture.functionType, "TagFactory")
  if furniture.wasteoutput > 0 or tag ~= nil and tag.typeName == "垃圾桶" or tag ~= nil and tag.typeName == "生物" then
    return true
  end
  return false
end

function PosClickHandler.IsCargoHold(index)
  local index = index + 1
  local id = PlayerData.ServerData.user_home_info.coach[index].id
  local coachData = PlayerData:GetFactoryData(id, "HomeCoachFactory")
  if coachData.coachType and coachData.coachType ~= "" and 12600247 == coachData.coachType then
    UIManager:Open("UI/Cargocompartment/cargocompartment")
    return true
  end
  return false
end

function PosClickHandler.PetClick(pos, uId, confirmCallBack)
  local json = Json.encode({uId = uId})
  UIManager:Open("UI/HomeUpgrade/HomeBubblePet", json, confirmCallBack)
  local bubbleView = require("UIHomeBubblePet/UIHomeBubblePetView")
  local vec = Vector2(pos.x + 100, pos.y + 50)
  bubbleView.Group_Panel:SetAnchoredPosition(vec)
end

function PosClickHandler.PassengerClick(pos, uId, confirmCallBack)
  local json = Json.encode({uId = uId})
  UIManager:Open("UI/HomeUpgrade/HomeBubblePassenger", json, confirmCallBack)
  local bubbleView = require("UIHomeBubblePassenger/UIHomeBubblePassengerView")
  local vec = Vector2(pos.x + 100, pos.y + 200)
  bubbleView.Group_Panel:SetAnchoredPosition(vec)
end

function PosClickHandler.CharacterClick(characterId, confirmCallBack)
  local characterCA = PlayerData:GetFactoryData(characterId, "HomeCharacterFactory")
  if table.count(characterCA.defaultSkins) > 0 then
    local json = Json.encode({characterId = characterId})
    UIManager:Open("UI/ChangeSkin/ChangeSkin", json, confirmCallBack)
  end
end

function PosClickHandler.GetCoachDirtyPercent()
  local wash = PlayerData:GetHomeInfo().readiness.wash
  local percent = wash.cleanliness or 1
  return percent
end

function PosClickHandler.GetCoachDirtyType()
  local percent = PosClickHandler.GetCoachDirtyPercent()
  local homeCoachSkinCA = PlayerData:GetFactoryData(70500001, "HomeCoachSkinFactory")
  for k, v in pairs(homeCoachSkinCA.dirtySkins) do
    if percent < v.dirtyPercent then
      return k
    end
  end
  return 0
end

function PosClickHandler.RefreshLiveFurniture(ufid)
  local furnitureInfo = PlayerData:GetHomeInfo().furniture[ufid]
  local furCA = PlayerData:GetFactoryData(furnitureInfo.id, "HomeFurnitureFactory")
  if furCA.functionType == 12600199 and furCA.characterNum > 0 then
    for i = 1, furCA.characterNum do
      local state = furnitureInfo.roles and furnitureInfo.roles[i] and furnitureInfo.roles[i] ~= ""
      local iconPath = ""
      if state then
        local unitCA = PlayerData:GetFactoryData(furnitureInfo.roles[i], "UnitFactory")
        local unitViewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
        local profilePhotoCA = PlayerData:GetFactoryData(unitViewCA.profilePhotoID, "ProfilePhotoFactory")
        iconPath = profilePhotoCA.imagePath
      end
      HomeManager:RefreshFurPhotoFrame(ufid, i, state, iconPath)
    end
    local liveDataModel = require("UINewHomeLive/UINewHomeLiveDataModel")
    if furCA.characterNum == 2 and 0 >= furCA.upgrade then
      local value = PlayerData:GetPlayerPrefs("string", "FurLightColor" .. ufid)
      if value == "" then
        value = liveDataModel.defaultLightColorType
      end
      HomeManager:ChangeFurLight(ufid, EnumDefine.EFurLightColor[value])
    elseif furCA.characterNum == 1 and 0 >= furCA.upgrade then
      local value = PlayerData:GetPlayerPrefs("string", "FurLightColor" .. ufid)
      if value == "" then
        value = liveDataModel.defaultLightColorType
      end
      HomeManager:ChangeFurMaterial(ufid, EnumDefine.EFurLightMaterialPath[value])
    end
  end
end

function PosClickHandler.GotoSleep(ufid, index)
  local dataModel = require("UINewHomeLive/UINewHomeLiveDataModel")
  local furnitureInfo = PlayerData:GetHomeInfo().furniture[ufid]
  if furnitureInfo.roles and furnitureInfo.roles[index] and furnitureInfo.roles[index] ~= "" then
    if dataModel.IsInEmergency(furnitureInfo.roles[index]) then
      local txtCA = PlayerData:GetFactoryData("80601267", "TextFactory")
      CommonTips.OpenTips(txtCA.text)
      return
    end
    local remainTime = PlayerData:GetRoleRemainSleepTime(furnitureInfo.roles[index])
    if remainTime <= 0 then
      local time = math.random(25, 100)
      PlayerData:SetRoleSleepTime(furnitureInfo.roles[index], time, true)
      remainTime = time
    end
    local unitCA = PlayerData:GetFactoryData(furnitureInfo.roles[index], "unitFactory")
    HomeCharacterManager:StartOp(HomeCharacterManager:GetCharacterById(tonumber(unitCA.homeCharacter)), ufid, index - 1, remainTime)
  end
end

function PosClickHandler.GetFurnitureAnimationState(ufid)
  local skinId = PosClickHandler.GetFurnitureSkinId(ufid)
  local furSkinCA = PlayerData:GetFactoryData(skinId, "HomeFurnitureFactory")
  if furSkinCA.banswitchAnimation then
    local dataModel = require("UIHome/UIHomeTradeDataModel")
    if dataModel.GetInTravel() then
      return 0
    end
  end
  local value = PlayerData:GetPlayerPrefs("int", "FurnitureAnimationState" .. ufid)
  return value
end

function PosClickHandler.GetFurnitureSkinId(ufid)
  local skinId = 0
  local serverFurData = PlayerData.ServerData.user_home_info.furniture[ufid]
  if serverFurData.u_skin ~= nil and serverFurData.u_skin ~= "" then
    skinId = tonumber(PlayerData:GetHomeInfo().furniture_skins[serverFurData.u_skin].id)
  else
    local furCA = PlayerData:GetFactoryData(serverFurData.id, "HomeFurnitureFactory")
    if furCA == nil then
      error("家具 ufid :" .. ufid .. " 家具id : " .. (serverFurData.id or 0) .. " 客户端不存在配置")
    end
    skinId = furCA.defaultSkin
  end
  return skinId
end

function PosClickHandler.GetRoomIsHaveEmptyTile(roomIdx)
  local room = HomeManager:GetRoom(roomIdx - 1)
  local floorMap
  if room then
    floorMap = room.floorMap
  end
  if floorMap then
    local maxX = room.ca.CoachX
    local maxZ = room.ca.CoachZ
    local limitNum = 4
    local count = 0
    for i = 0, maxX - 1 do
      for j = 0, maxZ - 1 do
        local tile = floorMap:GetTileVO(i, j)
        if tile and tile:isEmpty() then
          count = count + 1
          if limitNum < count then
            return true
          end
        end
      end
    end
  end
  return false
end

return PosClickHandler
