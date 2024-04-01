local View = require("UIHome_MachiningMenu/UIHome_MachiningMenuView")
local DataModel = require("UIHome_MachiningMenu/UIHome_MachiningMenuDataModel")
local ViewFunction = {
  Home_MachiningMenu_ScrollGrid_Furniture_SetGrid = function(element, elementIndex)
    local info = DataModel.allProductFur[elementIndex]
    local cfg = info.productCfg.cfg
    local productData = info.productData
    local have = productData ~= nil
    element.Img_BG:SetSprite(cfg.bgPath)
    element.Txt_CheName:SetText(cfg.cName)
    element.Txt_EngName:SetText(cfg.engName)
    element.Group_None:SetActive(not have)
    element.Group_LV:SetActive(have)
    element.Group_Able:SetActive(have)
    local showUpgrade = false
    if have then
      local furData = info.productData.furData
      local furCA = PlayerData:GetFactoryData(furData.id, "HomeFurnitureFactory")
      if furCA.upgrade > 0 then
        showUpgrade = true
      end
    end
    element.Group_Able.Btn_Upgrade:SetActive(showUpgrade)
    local newFur, newFormula
    if have then
      local furId = productData.furData.id
      local furCA = PlayerData:GetFactoryData(furId, "HomeFurnitureFactory")
      element.Group_LV.Txt_Num:SetText(furCA.Level)
      newFur = not productData.furData.read or productData.furData.read == 0
      newFormula = DataModel.GetFormulaRedState(furId)
    end
    element.Img_New:SetActive(newFur)
    element.Img_RedPoint:SetActive(newFormula and not newFur)
    element.Group_Able.Btn_Upgrade:SetClickParam(elementIndex)
    element.Group_Able.Btn_Goto:SetClickParam(elementIndex)
    element.Group_None.Btn_GetWay:SetActive(not have)
    element.Group_None.Btn_GetWay:SetClickParam(elementIndex)
    element.Group_None.Img_DesBubble:SetActive(false)
    element.Group_None.Img_DesBubble.Txt_GetWay:SetText(cfg.GetWay)
    DataModel.furCtrs[elementIndex] = element
  end,
  Home_MachiningMenu_ScrollGrid_Furniture_Group_Contain_Group_None_Btn_GetWay_Click = function(btn, str)
    local info = DataModel.allProductFur[tonumber(str)]
    local element = DataModel.furCtrs[tonumber(str)]
    local show = not element.Group_None.Img_DesBubble.IsActive
    element.Group_None.Img_DesBubble:SetActive(show)
  end,
  Home_MachiningMenu_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Home_MachiningMenu_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Home_MachiningMenu_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Home_MachiningMenu_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Home_MachiningMenu_ScrollGrid_Furniture_Group_Contain_Group_Able_Btn_Goto_Click = function(btn, str)
    local info = DataModel.allProductFur[tonumber(str)]
    local furData = info.productData.furData
    local t = {}
    t.ufid = info.productData.ufid
    t.furId = info.productData.furData.id
    UIManager:Open(info.productCfg.cfg.UIName, Json.encode(t))
    if not furData.read or furData.read == 0 then
      Net:SendProto("main.read", function(json)
      end, info.productData.ufid, "furniture")
      furData.read = 1
      local element = DataModel.furCtrs[tonumber(str)]
      element.Img_New:SetActive(false)
    end
  end,
  Home_MachiningMenu_ScrollGrid_Furniture_Group_Contain_Group_Able_Btn_Upgrade_Click = function(btn, str)
    local info = DataModel.allProductFur[tonumber(str)]
    local furData = info.productData.furData
    local t = {}
    t.furUfid = info.productData.ufid
    t.furId = info.productData.furData.id
    local callBack = function()
      DataModel.RefreshAfterUpgrade()
    end
    UIManager:Open("UI/HomeUpgrade/HomeUpgrade", Json.encode(t), callBack)
    DataModel.selectUpgradeIndex = tonumber(str)
    if not furData.read or furData.read == 0 then
      Net:SendProto("main.read", function(json)
      end, info.productData.ufid, "furniture")
      furData.read = 1
      local element = DataModel.furCtrs[tonumber(str)]
      element.Img_New:SetActive(false)
    end
  end
}
return ViewFunction
