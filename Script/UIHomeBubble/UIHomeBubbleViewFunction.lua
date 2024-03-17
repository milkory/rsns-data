local View = require("UIHomeBubble/UIHomeBubbleView")
local DataModel = require("UIHomeBubble/UIHomeBubbleDataModel")
local Controller = require("UIHomeBubble/UIHomeBubbleController")
local ViewFunction = {
  HomeBubble_Btn_Close_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  HomeBubble_Group_Panel_Img_Glass_Img_BubbleBG_Group_Title_Btn_Info_Click = function(btn, str)
    Controller:SwitchShow()
  end,
  HomeBubble_Group_Panel_Img_Glass_Img_BubbleBG_Btn_Upgrade_Click = function(btn, str)
    View.self:CloseUI()
    local t = {}
    t.furUfid = DataModel.curFurUfid
    t.furId = DataModel.curFurId
    UIManager:Open("UI/HomeUpgrade/HomeUpgrade", Json.encode(t))
  end,
  HomeBubble_Group_Panel_Img_Glass_Img_BubbleBG_Btn_Interactive_Click = function(btn, str)
    local furCA = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
    if furCA.interfaceUrl == "UI/Home/HomeEmergency/HomeEmergency" then
      Controller:RefreshEmergency(true)
      View.Group_Panel.Img_Glass.Img_BubbleBG.Btn_Interactive:SetActive(false)
      return
    end
    if furCA.interfaceUrl ~= nil and furCA.interfaceUrl ~= "" then
      UIManager:GoBack(false)
      if furCA.functionType == 12600143 or furCA.functionType == 12600187 or furCA.functionType == 12600144 then
        local mainUIView = require("UIMainUI/UIMainUIView")
        local mainUIController = require("UIMainUI/UIMainUIController")
        local data = {}
        data.onlyShow = true
        data.ufid = DataModel.curFurUfid
        mainUIController:ExitTo(furCA.interfaceUrl, Json.encode(data))
        local v3 = Vector3(furCA.checkCameraX, furCA.checkCameraY, furCA.checkCameraZ)
        HomeManager:CamFocusToFurniture(DataModel.curFurUfid, v3, furCA.checkCameraTime, false, furCA.focusCamMove, function()
        end)
      elseif furCA.interfaceUrl == "UI/ChangeSkin/ChangeSkin" then
        local id = PlayerData:GetUserInfo().gender == 1 and 70000067 or 70000063
        UIManager:Open("UI/ChangeSkin/ChangeSkin", Json.encode({characterId = id}))
      elseif furCA.functionType == 12600294 then
        UIManager:Open(furCA.interfaceUrl, Json.encode(EnumDefine.Depot.FridgeItem))
      elseif furCA.interfaceUrl == "UI/Home/NewHomeLive" then
        local v3 = Vector3(furCA.checkCameraX, furCA.checkCameraY, furCA.checkCameraZ)
        local furData = PlayerData:GetFurniture()[tostring(DataModel.curFurUfid)]
        if furData and furData.roles then
          for _, roleId in pairs(furData.roles) do
            if roleId ~= "" and PlayerData:GetRoleRemainSleepTime(roleId) > 0 then
              local unitCA = PlayerData:GetFactoryData(roleId, "UnitFactory")
              HomeCharacterManager:AddFilterHideId(tonumber(unitCA.homeCharacter))
            end
          end
        end
        HomeManager:CamFocusToFurniture(DataModel.curFurUfid, v3, furCA.checkCameraTime, false, furCA.focusCamMove, function()
          HomeCharacterManager:ClearFilteHideIdList()
        end)
        UIManager:Open(furCA.interfaceUrl, Json.encode({
          ufid = DataModel.curFurUfid
        }))
      else
        UIManager:Open(furCA.interfaceUrl, Json.encode({
          ufid = DataModel.curFurUfid,
          furId = DataModel.curFurId
        }))
      end
    else
      if DataModel.CurHomeFurniture == nil then
        DataModel.CurHomeFurniture = HomeManager:GetFurniture(DataModel.curFurUfid)
      end
      DataModel.CurHomeFurniture:PlayAnimationByState(DataModel.ToAnimationState)
      PlayerData:SetPlayerPrefs("int", "FurnitureAnimationState" .. DataModel.curFurUfid, DataModel.ToAnimationState)
      UIManager:GoBack(false)
    end
  end,
  HomeBubble_Group_Panel_Img_Glass_Img_BubbleBG_Btn_CharacterInteractive_Click = function(btn, str)
    local furCA = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
    local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
    local conductor = PlayerData:GetUserInfo().gender == 1 and homeConfig.conductorM or homeConfig.conductorW
    if DataModel.curFurId == "81300016" and not HomeCharacterManager:GetCharacterById(conductor) then
      local TradeDataModel = require("UIHome/UIHomeTradeDataModel")
      if TradeDataModel.GetIsTravel() then
        CommonTips.OpenTips("列车长正在驾驶列车")
      end
      return
    end
    local stop = tonumber(str) == 0
    if stop then
      HomeCharacterManager:StopOp(HomeCharacterManager:GetCharacterById(conductor))
    else
      HomeCharacterManager:StartOp(HomeCharacterManager:GetCharacterById(conductor), DataModel.curFurUfid, 0, 15)
    end
    UIManager:GoBack(false)
  end,
  HomeBubble_Group_Panel_Img_Glass_Img_BubbleBG_Group_Working_Group_add_Btn__Click = function(btn, str)
    local furCA = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
    UIManager:Open(furCA.interfaceUrl, Json.encode({
      ufid = DataModel.curFurUfid,
      furId = DataModel.curFurId
    }))
  end,
  HomeBubble_Group_Panel_Img_Glass_Img_BubbleBG_Group_Working_Group_change_Group_Member_Btn_Change_Click = function(btn, str)
    local furCA = PlayerData:GetFactoryData(DataModel.curFurId, "HomeFurnitureFactory")
    UIManager:Open(furCA.interfaceUrl, Json.encode({
      ufid = DataModel.curFurUfid,
      furId = DataModel.curFurId
    }))
  end
}
return ViewFunction
