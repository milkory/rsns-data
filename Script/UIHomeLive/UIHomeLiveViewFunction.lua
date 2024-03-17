local View = require("UIHomeLive/UIHomeLiveView")
local DataModel = require("UIHomeLive/UIHomeLiveDataModel")
local Controller = require("UIHomeLive/UIHomeLiveController")
local ViewFunction = {
  HomeLive_Btn_FH_Click = function(btn, str)
    local length = #DataModel.curCharacter
    local isSame = true
    for i = 1, length do
      isSame = isSame and DataModel.curCharacter[i] == DataModel.oriCurCharacter[i]
    end
    if isSame then
      UIManager:GoBack()
      return
    end
    local str = ""
    for i = 1, length do
      str = str .. DataModel.curCharacter[i]
      if i ~= length then
        str = str .. ","
      end
    end
    Net:SendProto("hero.check_in", function(json)
      PlayerData.ServerData.user_home_info.furniture[DataModel.curUfid].roles = {}
      for k, v in pairs(DataModel.curCharacter) do
        PlayerData.ServerData.user_home_info.furniture[DataModel.curUfid].roles[k] = v
        if v ~= "" then
          PlayerData.ServerData.roles[v].u_fid = DataModel.curUfid
        end
      end
      for k, v in pairs(DataModel.oriCurCharacter) do
        if v ~= "" then
          if DataModel.tCharacterToFuniture[v] ~= nil then
            local ufid = DataModel.tCharacterToFuniture[v].ufid
            if PlayerData.ServerData.user_home_info.furniture[ufid].roles == nil then
              PlayerData.ServerData.user_home_info.furniture[ufid].roles = {}
            end
            PlayerData.ServerData.user_home_info.furniture[ufid].roles[DataModel.tCharacterToFuniture[v].pos] = v
            PlayerData.ServerData.roles[v].u_fid = ufid
          else
            PlayerData.ServerData.roles[v].u_fid = nil
          end
        end
      end
      UIManager:GoBack()
    end, DataModel.curUfid, str, function(json)
      CommonTips.OnPromptConfirmOnly(GetText(json.msg), nil, function()
        UIManager:GoBack()
      end)
    end)
  end,
  HomeLive_Btn_QK_Click = function(btn, str)
    local isHave = false
    for k, v in pairs(DataModel.curCharacter) do
      if v ~= "" then
        isHave = true
        break
      end
    end
    if isHave then
      CommonTips.OnPrompt(80600353, nil, nil, function()
        for i = 1, #DataModel.curCharacter do
          local id = DataModel.curCharacter[i]
          if id ~= "" then
            DataModel.tCharacterToFuniture[id] = nil
          end
          DataModel.curCharacter[i] = ""
        end
        Controller:RefreshBedInfo()
      end)
    end
  end,
  HomeLive_Group_Bed1_Btn_Empty_Click = function(btn, str)
    Controller:ClickBedBtn(1)
  end,
  HomeLive_Group_Bed1_Btn_Character_Click = function(btn, str)
    Controller:ClickBedBtn(1)
  end,
  HomeLive_Group_Bed2_Btn_Empty_Click = function(btn, str)
    Controller:ClickBedBtn(2)
  end,
  HomeLive_Group_Bed2_Btn_Character_Click = function(btn, str)
    Controller:ClickBedBtn(2)
  end,
  HomeLive_Group_QH_Btn_S_Click = function(btn, str)
  end,
  HomeLive_Group_QH_Btn_X_Click = function(btn, str)
  end,
  HomeLive_Group_replace_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.Group_replace.self:SetActive(false)
  end,
  HomeLive_Group_replace_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  HomeLive_Group_replace_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomeLive_Group_replace_ScrollGrid_TH_SetGrid = function(element, elementIndex)
    Controller:RefreshElement(element.Group_Character, elementIndex)
  end,
  HomeLive_Group_replace_ScrollGrid_TH_Group_Item_Group_Character_Btn_Mask_Click = function(btn, str)
  end,
  HomeLive_Group_replace_ScrollGrid_TH_Group_Item_Group_Character_Group_Break_StaticGrid_BK_SetGrid = function(element, elementIndex)
    local isBreak = elementIndex <= DataModel.curRefreshBreakLv
    element.Img_Off:SetActive(not isBreak)
    element.Img_On:SetActive(isBreak)
  end,
  HomeLive_Group_replace_ScrollGrid_TH_Group_Item_Group_Character_Btn_Item_Click = function(btn, str)
    local idx = tonumber(str)
    if DataModel.curSelectCharacterIdx == idx then
      DataModel.curSelectCharacterIdx = 0
    else
      DataModel.curSelectCharacterIdx = tonumber(str)
    end
    View.Group_replace.ScrollGrid_TH.grid.self:RefreshAllElement()
    Controller:RefreshRoleLH()
  end,
  HomeLive_Group_replace_Group_QR_Btn_QR_Click = function(btn, str)
    if DataModel.curSelectCharacterIdx == 0 then
      local oriId = DataModel.curCharacter[DataModel.curSelectBedIdx]
      if oriId ~= "" then
        DataModel.tCharacterToFuniture[oriId] = nil
        DataModel.allCoachCharacterCurNum = DataModel.allCoachCharacterCurNum - 1
      end
      DataModel.curCharacter[DataModel.curSelectBedIdx] = ""
      Controller:RefreshBedInfo()
      Controller:RefreshRightTopShow()
      View.Group_replace.self:SetActive(false)
      return
    end
    local data = DataModel.allCanCheckInCharacter[DataModel.curSelectCharacterIdx]
    local cb = function()
      local oriId = DataModel.curCharacter[DataModel.curSelectBedIdx]
      if oriId ~= data.id then
        DataModel.curCharacter[DataModel.curSelectBedIdx] = data.id
        if oriId ~= "" then
          if DataModel.tCharacterToFuniture[data.id] ~= nil then
            DataModel.tCharacterToFuniture[oriId].ufid = DataModel.tCharacterToFuniture[data.id].ufid
            DataModel.tCharacterToFuniture[oriId].pos = DataModel.tCharacterToFuniture[data.id].pos
          else
            DataModel.tCharacterToFuniture[oriId] = nil
          end
        else
          DataModel.allCoachCharacterCurNum = DataModel.allCoachCharacterCurNum + 1
        end
        if DataModel.tCharacterToFuniture[data.id] == nil then
          DataModel.tCharacterToFuniture[data.id] = {}
        end
        if DataModel.tCharacterToFuniture[data.id].ufid == DataModel.curUfid then
          DataModel.curCharacter[DataModel.tCharacterToFuniture[data.id].pos] = oriId
        end
        DataModel.tCharacterToFuniture[data.id].ufid = DataModel.curUfid
        DataModel.tCharacterToFuniture[data.id].pos = DataModel.curSelectBedIdx
        Controller:RefreshBedInfo()
        Controller:RefreshRightTopShow()
      end
      View.Group_replace.self:SetActive(false)
    end
    if data.checkInInfo ~= nil then
      CommonTips.OnPrompt(80600355, nil, nil, function()
        cb()
      end)
      return
    end
    cb()
  end,
  HomeLive_Group_replace_Group_QR_Btn_QX_Click = function(btn, str)
    DataModel.curSelectCharacterIdx = 0
    View.Group_replace.ScrollGrid_TH.grid.self:RefreshAllElement()
    View.Group_replace.Txt_Empty:SetActive(true)
    View.Group_replace.Img_LH:SetActive(false)
  end
}
return ViewFunction
