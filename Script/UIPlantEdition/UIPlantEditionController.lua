local View = require("UIPlantEdition/UIPlantEditionView")
local DataModel = require("UIPlantEdition/UIPlantEditionDataModel")
local Controller = {}

function Controller:RefreshTop()
  local totalMood = 0
  if DataModel.FurnitureServerData and DataModel.FurnitureServerData.plants then
    for i, v in ipairs(DataModel.FurnitureServerData.plants) do
      local create = PlayerData:GetFactoryData(v, "HomeCreatureFactory")
      if create ~= nil and create.purifyTime == -1 then
        totalMood = totalMood + create.PlantMood
      else
      end
    end
  end
  View.Group_Top.Btn_Mood.Txt_:SetText("心情 +" .. totalMood .. "/时")
end

function Controller:SortRuleView()
  local Group_PlantSort = View.Group_Edition.Group_Bottom.Btn_PlantSort.Group_PlantSort
  if DataModel.CurrSort.Type == DataModel.SortType.Num then
    if DataModel.CurrSort.IsDown then
      Group_PlantSort.Btn_Num.Img_Selected.self:SetActive(true)
      Group_PlantSort.Btn_Mood.Img_Selected.self:SetActive(false)
      local arrow = Group_PlantSort.Btn_Num.Img_Selected.Img_Arrow
      arrow:SetLocalEulerAngles(0)
    else
      Group_PlantSort.Btn_Num.Img_Selected.self:SetActive(true)
      Group_PlantSort.Btn_Mood.Img_Selected.self:SetActive(false)
      local arrow = Group_PlantSort.Btn_Num.Img_Selected.Img_Arrow
      arrow:SetLocalEulerAngles(180)
    end
  elseif DataModel.CurrSort.Type == DataModel.SortType.Mood then
    if DataModel.CurrSort.IsDown then
      Group_PlantSort.Btn_Num.Img_Selected.self:SetActive(false)
      Group_PlantSort.Btn_Mood.Img_Selected.self:SetActive(true)
      local arrow = Group_PlantSort.Btn_Mood.Img_Selected.Img_Arrow
      arrow:SetLocalEulerAngles(0)
    else
      Group_PlantSort.Btn_Num.Img_Selected.self:SetActive(false)
      Group_PlantSort.Btn_Mood.Img_Selected.self:SetActive(true)
      local arrow = Group_PlantSort.Btn_Mood.Img_Selected.Img_Arrow
      arrow:SetLocalEulerAngles(180)
    end
  end
end

return Controller
