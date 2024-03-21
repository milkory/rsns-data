local View = require("UIItemTips/UIItemTipsView")
local DataModel = require("UIItemTips/UIItemTipsDataModel")
local Controller = {}
local ButtonType = {
  BatchAndUse = 1,
  BatchAndCompose = 2,
  SingleAndUse = 3,
  SingleAndCompose = 4
}
local IsActiveBtn = function(btnState)
  local height = 0
  if btnState then
    height = 48
  end
  View.Group_Show.self:SetLocalPositionY(height)
  return btnState
end

function Controller.RefreshMain()
  local factoryName = DataManager:GetFactoryNameById(DataModel.Id)
  DataModel.ItemInfo = PlayerData:GetGoodsById(DataModel.Id)
  if DataModel.LimitedTimeData then
    DataModel.ItemInfo.num = DataModel.LimitedTimeData.num
  end
  local data = PlayerData:GetFactoryData(DataModel.Id, factoryName)
  DataModel.Data = data
  View.Group_Use.self:SetActive(false)
  View.Group_BatchUse.self:SetActive(false)
  View.Group_Goto.self:SetActive(false)
  View.Group_Compose.self:SetActive(false)
  View.Group_BatchCompose.self:SetActive(false)
  View.Group_Sale.self:SetActive(DataModel.Data.saletype == "Sale" and DataModel.ItemInfo.num ~= 0)
  View.Group_Convert.self:SetActive(DataModel.Data.isBreakChange == true)
  if next(DataModel.SaleData) == nil then
    if DataModel.Data.isBreakChange == false then
      IsActiveBtn(false)
    else
      IsActiveBtn(true)
    end
  else
    IsActiveBtn(true)
  end
  if DataModel.Source == EnumDefine.OpenTip.Depot and factoryName ~= "SourceMaterialFactory" then
    if data.modInt == EnumDefine.ItemModType.Use then
      local type = 0
      if data.isCompose and data.isBatch then
        if DataModel.ItemInfo.num < data.numRequired * 2 then
          type = ButtonType.SingleAndCompose
        else
          type = ButtonType.BatchAndCompose
        end
      elseif not data.isCompose and data.isBatch then
        if DataModel.ItemInfo.num < data.numRequired * 2 then
          type = ButtonType.SingleAndUse
        else
          type = ButtonType.BatchAndUse
        end
      elseif data.isCompose and not data.isBatch then
        type = ButtonType.SingleAndCompose
      elseif not data.isCompose and not data.isBatch then
        type = ButtonType.SingleAndUse
      end
      if data.isBatch then
        type = ButtonType.SingleAndUse
      end
      if type == ButtonType.BatchAndUse then
        View.Group_BatchUse.self:SetActive(IsActiveBtn(true))
      elseif type == ButtonType.BatchAndCompose then
      elseif type == ButtonType.SingleAndUse then
        View.Group_Use.self:SetActive(IsActiveBtn(true))
      elseif type == ButtonType.SingleAndCompose then
        View.Group_Compose.self:SetActive(IsActiveBtn(true))
      end
    elseif data.modInt == EnumDefine.ItemModType.Jump then
      View.Group_Goto.self:SetActive(IsActiveBtn(true))
    end
    if data.endTime ~= "" then
      local lastTime = TimeUtil:LastTime(data.endTime)
      if lastTime < 0 then
        View.Group_Sale.self:SetActive(IsActiveBtn(true))
        View.Group_Show.Txt_EndTime:SetActive(true)
        View.Group_Show.Txt_EndTime:SetText(GetText(80600019))
      else
        local testFunc = function()
          local lastTime = TimeUtil:LastTime(data.endTime)
          local time = TimeUtil:SecondToTable(lastTime)
          View.Group_Show.Txt_EndTime:SetText(TimeUtil:GetCommonDesc(time))
          if lastTime == 0 then
            EventManager:RemoveOnSecondEvent(DataModel.TimeFunc)
            DataModel.TimeFunc = nil
          end
        end
        DataModel.TimeFunc = testFunc
        EventManager:AddOnSecondEvent(DataModel.TimeFunc)
        View.Group_Show.Txt_EndTime:SetActive(true)
      end
    else
      View.Group_Show.Txt_EndTime:SetActive(false)
    end
  else
    View.Group_Show.Txt_EndTime:SetActive(false)
  end
  View.Group_Show.Txt_Name:SetText(data.name)
  local des = ""
  local tipsPath = ""
  if factoryName == "CollectionCardPackFactory" then
    des = data.itemDes
    tipsPath = data.itemTipsPath
    View.Group_Show.Group_Num:SetActive(false)
    View.Group_Show.Img_Quality:SetActive(false)
  else
    View.Group_Show.Group_Num:SetActive(true)
    View.Group_Show.Img_Quality:SetActive(true)
    des = data.des or data.describe
    tipsPath = data.tipsPath
    if DataModel.isHomeGoods then
      tipsPath = data.imagePath
    end
  end
  View.Group_Show.ScrollView_Describe.Viewport.Txt_Describe:SetText(des)
  View.Group_Show.Img_Icon:SetSprite(tipsPath)
  if data.qualityInt ~= nil then
    View.Group_Show.Img_Rarity:SetSprite(UIConfig.TipConfig[data.qualityInt + 1])
    View.Group_Show.Img_Quality:SetSprite(UIConfig.ItemTipQuality[data.qualityInt + 1])
  elseif data.rarityInt ~= nil then
    View.Group_Show.Img_Rarity:SetSprite(UIConfig.TipConfig[data.rarityInt + 1])
    View.Group_Show.Img_Quality:SetSprite(UIConfig.ItemTipQuality[data.rarityInt + 1])
  end
  View.Group_Show.Img_Rarity:SetActive(true)
  View.Group_Show.Group_Num.Txt_Num:SetText(DataModel.ItemInfo.num)
  if DataModel.ItemInfo.num == 0 then
    View.Group_Convert.self:SetActive(false)
  end
  View.Group_Show.ScrollView_Describe:SetContentHeight(View.Group_Show.ScrollView_Describe.Viewport.Txt_Describe:GetHeight())
  View.Group_Show.ScrollView_Describe:SetVerticalNormalizedPosition(1)
  local path = DataModel.Data.breakPath
  View.Group_Show.Group_Break:SetActive(path and path ~= "")
  if path and path ~= "" then
    View.Group_Show.Group_Break.Img_Mask.Img_Face:SetSprite(path)
  end
end

return Controller
