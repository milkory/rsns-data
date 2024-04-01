local View = require("UIGroup_GetWay/UIGroup_GetWayView")
local DataModel = require("UIGroup_GetWay/UIGroup_GetWayDataModel")
local funcCommon = require("Common/FuncCommon")
local ViewFunction = {
  Group_GetWay_Btn_Back_Click = function(btn, str)
    View.self:Confirm()
    View.self:CloseUI()
  end,
  Group_GetWay_Img_WayBg_ScrollGrid__SetGrid = function(element, elementIndex)
    local indexId = tonumber(elementIndex)
    local content = DataModel.getwayList[indexId].DisplayName
    local UIpath = DataModel.getwayList[indexId].UIName
    local funcId = DataModel.getwayList[indexId].funcId
    local btnContent = GetText(80602159)
    local isUnlock = true
    if funcId ~= -1 then
      isUnlock = funcCommon.FuncActiveCheck(funcId, false)
      if not isUnlock then
        btnContent = GetText(80602158)
      end
    end
    if UIpath ~= "" and isUnlock == true then
      element.Group_Text:SetActive(false)
      element.Group_Forward:SetActive(true)
      element.Group_Forward.Btn_Forward:SetClickParam(elementIndex)
      element.Group_Forward.Txt_WayEg:SetText(content)
    else
      element.Group_Text:SetActive(true)
      element.Group_Text.Img_None.Txt_Forwad:SetText(btnContent)
      element.Group_Forward:SetActive(false)
      element.Group_Text.Txt_WayEg:SetText(content)
    end
  end,
  Group_GetWay_Img_WayBg_ScrollGrid__Group_Item_Group_Forward_Btn_Forward_Click = function(btn, str)
    local indexId = tonumber(str)
    local levelId = DataModel.getwayList[indexId].FromLevel
    if levelId and levelId ~= -1 then
    else
      local UIpath = DataModel.getwayList[indexId].UIName
      if UIpath == "UI/Store/Store" then
        Net:SendProto("shop.info", function(json)
          json.index = 2
          UIManager:Open("UI/Store/Store", Json.encode(json))
        end)
        return
      end
      if UIpath == "UI/BP_Quest/BattlePass_Quest" then
        local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
        local battlePass = PlayerData:GetFactoryData(initConfig.BattlePassId, "BattlePassFactory")
        if TimeUtil:LastTime(battlePass.PassEndTime) < 0 then
          CommonTips.OpenTips(80602313)
          return
        end
      end
      UIManager:Open(UIpath)
    end
  end
}
return ViewFunction
