local View = require("UIHomeFishTank/UIHomeFishTankView")
local DataModel = require("UIHomeFishTank/UIHomeFishTankDataModel")
local Controller = require("UIHomeFishTank/UIHomeFishTankController")
local ViewFunction = {
  HomeFishTank_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    local goback = function()
      UIManager:GoBack()
      local mainUIView = require("UIMainUI/UIMainUIView")
      mainUIView.self:SetRaycastBlock(false)
      HomeManager:CamFocusEnd(function()
        mainUIView.self:SetRaycastBlock(true)
      end)
    end
    if DataModel.curFurUfid == "" then
      goback()
      return
    end
    local isChanged = false
    for k, v in pairs(DataModel.fishChangeData) do
      if v ~= 0 then
        isChanged = true
        break
      end
    end
    if isChanged or DataModel.curUsedSkinUId ~= DataModel.furSkinUId then
      CommonTips.OnPrompt(80600788, nil, nil, function()
        Controller:Save(goback)
      end, function()
        Controller:Revert()
        goback()
      end)
    else
      goback()
    end
  end,
  HomeFishTank_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  HomeFishTank_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  HomeFishTank_Btn_Setting_Click = function(btn, str)
    Controller:ToSetting()
  end,
  HomeFishTank_Group_yugangUI_Btn_AllFish_Click = function(btn, str)
    Controller:SelectShowType(DataModel.ShowTypeEnum.Fish)
  end,
  HomeFishTank_Group_yugangUI_Img_Glass_Btn_BackGroundRight_Click = function(btn, str)
    Controller:SelectShowType(DataModel.ShowTypeEnum.Skin)
  end,
  HomeFishTank_Group_yugangUI_Img_Glass_Group_Button_Btn_xiaoxingyu_Click = function(btn, str)
    Controller:SelectFishType(DataModel.FishType.small)
  end,
  HomeFishTank_Group_yugangUI_Img_Glass_Group_Button_Btn_zhongxingyu_Click = function(btn, str)
    Controller:SelectFishType(DataModel.FishType.middle)
  end,
  HomeFishTank_Group_yugangUI_Img_Glass_Group_Button_Btn_daxingyu_Click = function(btn, str)
    Controller:SelectFishType(DataModel.FishType.big)
  end,
  HomeFishTank_Group_yugangUI_Img_Glass_Group_Button_Btn_chaodaxingyu_Click = function(btn, str)
    Controller:SelectFishType(DataModel.FishType.huge)
  end,
  HomeFishTank_Group_yugangUI_Btn_Save_Click = function(btn, str)
    Controller:Save(function()
      Controller:RevertToShowView()
      HomeManager.cam:EndLockFocus()
    end)
  end,
  HomeFishTank_Group_yugangUI_Btn_Del_Click = function(btn, str)
    Controller:Clear()
  end,
  HomeFishTank_Group_yugangUI_NewScrollGrid_Yu_SetGrid = function(element, elementIndex)
    if DataModel.CurShowType == DataModel.ShowTypeEnum.Fish then
      local info = DataModel.CurSelectFishTable[elementIndex]
      element.Btn_Yu.Txt_ShuLiang:SetText("x" .. info.num)
      element.Btn_Yu.Img_YuTuPian:SetSprite(info.ca.iconPath)
      element.Btn_Yu.Txt_MingZi:SetText(info.ca.name)
      local num = (DataModel.furFishData[info.id] or 0) + (DataModel.fishChangeData[info.id] or 0)
      element.Btn_Yu.Img_FangRuShuLiang.Txt_FangRuShuLiang:SetText(num)
      element.Btn_Yu.self:SetClickParam(info.id)
      element.Btn_Yu.Btn_JianShao.self:SetClickParam(info.id)
      element.Btn_Yu.Img_BubbishBox.self:SetActive(true)
      element.Btn_Yu.Img_BubbishBox.Txt_:SetText(info.ca.fishGarbage .. "/h")
      element.Btn_Yu.Img_FangRuShuLiang.self:SetActive(0 < num)
      element.Btn_Yu.Btn_JianShao.self:SetActive(0 < num)
      element.Btn_Yu.Img_Using.self:SetActive(false)
      element.Btn_Yu.Img_Used.self:SetActive(false)
    elseif DataModel.CurShowType == DataModel.ShowTypeEnum.Skin then
      local info = DataModel.skinData[elementIndex]
      element.Btn_Yu.Txt_ShuLiang:SetText("x" .. table.count(info.u_skins))
      element.Btn_Yu.Img_YuTuPian:SetSprite(info.iconPath)
      element.Btn_Yu.Txt_MingZi:SetText(info.name)
      element.Btn_Yu.self:SetClickParam(elementIndex)
      element.Btn_Yu.Img_BubbishBox.self:SetActive(false)
      element.Btn_Yu.Img_FangRuShuLiang.self:SetActive(false)
      element.Btn_Yu.Btn_JianShao.self:SetActive(false)
      if not info.isUsed then
        element.Btn_Yu.Img_Using.self:SetActive(false)
        element.Btn_Yu.Img_Used.self:SetActive(false)
      else
        element.Btn_Yu.Img_Using.self:SetActive(DataModel.curUsedSkinUId == info.u_skin)
        element.Btn_Yu.Img_Used.self:SetActive(DataModel.curUsedSkinUId ~= info.u_skin)
      end
    end
  end,
  HomeFishTank_Group_yugangUI_NewScrollGrid_Yu_Group_Item_Btn_Yu_Click = function(btn, str)
    if DataModel.CurShowType == DataModel.ShowTypeEnum.Fish then
      local id = tonumber(str)
      Controller:AddFish(id, 1)
    else
      Controller:ChangeSkin(tonumber(str))
    end
  end,
  HomeFishTank_Group_yugangUI_NewScrollGrid_Yu_Group_Item_Btn_Yu_Btn_JianShao_Click = function(btn, str)
    if DataModel.CurShowType == DataModel.ShowTypeEnum.Fish then
      local id = tonumber(str)
      Controller:RemoveFish(id, 1)
    end
  end,
  HomeFishTank_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeFishTank_Group_yugangUI_Btn_xiaoxingyu_Click = function(btn, str)
    Controller:SelectFishType(DataModel.FishType.small)
  end,
  HomeFishTank_Group_yugangUI_Btn_zhongxingyu_Click = function(btn, str)
    Controller:SelectFishType(DataModel.FishType.middle)
  end,
  HomeFishTank_Group_yugangUI_Btn_daxingyu_Click = function(btn, str)
    Controller:SelectFishType(DataModel.FishType.big)
  end,
  HomeFishTank_Group_yugangUI_Btn_chaodaxingyu_Click = function(btn, str)
    Controller:SelectFishType(DataModel.FishType.huge)
  end
}
return ViewFunction
