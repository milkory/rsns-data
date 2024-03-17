local DataModel = require("UIIncubator/UIIncubatorDataModel")
local View = require("UIIncubator/UIIncubatorView")
local Controller = {}

function Controller:ChangeIndex(index)
  local right = View.Group_PurificationInterface
  if DataModel.Index ~= index then
    DataModel.Index = index
    View.Group_SelectionInterface.ScrollGrid_Choice.grid.self:SetDataCount(#DataModel.Type[index].data)
    View.Group_SelectionInterface.ScrollGrid_Choice.grid.self:RefreshAllElement()
  end
end

function Controller:RefreshRight()
  local right = View.Group_PurificationInterface
  DataModel.SendStr = ""
  right.Txt_Time:SetText("")
  right.Txt_Produce:SetText("")
  View.Group_PurificationInterface.Txt_Object:SetText("")
  if DataModel.TotalUse <= 0 then
    return
  end
  local totalUseTime = 0
  local str = ""
  local totalGenerate = 0
  local totalUse = 0
  for _, v in pairs(DataModel.SelectData) do
    if v.use ~= 0 then
      for i = 1, v.use do
        str = str .. v.config.name .. "\n"
        totalUseTime = totalUseTime + v.config.purifyTime
        totalGenerate = totalGenerate + v.config.rewards[1].num
        totalUse = totalUse + 1
        if totalUse ~= DataModel.TotalUse then
          DataModel.SendStr = DataModel.SendStr .. v.config.id .. ","
        else
          DataModel.SendStr = DataModel.SendStr .. v.config.id
        end
      end
    end
  end
  totalGenerate = totalGenerate * (1 - 0.1 * (DataModel.TotalUse - 1)) / (totalUseTime / 3600)
  right.Txt_Time:SetText(TimeUtil:GetStandardTime(TimeUtil:SecondToTable(totalUseTime)))
  right.Txt_Produce:SetText(totalGenerate .. "/h")
  View.Group_PurificationInterface.Txt_Object:SetText(str)
end

function Controller:RefreshHaveRight()
  local totalTime = 0
  local totalGenerate = 0
  local str = ""
  local right = View.Group_PurificationInterface
  local isGroup = false
  if #DataModel.CurrFurnitureConfig.PurificationsiloList > 1 and 1 < #DataModel.FurnitureServerData.space.creatures then
    isGroup = true
  else
    isGroup = false
  end
  right.Group_Image.self:SetActive(isGroup)
  right.Img_PurificationSilo:SetActive(not isGroup)
  for i, v in ipairs(DataModel.FurnitureServerData.space.creatures) do
    local create = PlayerData:GetFactoryData(v, "HomeCreatureFactory")
    totalTime = totalTime + create.purifyTime
    str = str .. create.name .. "\n"
    totalGenerate = totalGenerate + create.rewards[1].num
    if isGroup then
      right.Group_Image["Img_" .. i]:SetSprite(create.iconPath)
    else
      right.Img_PurificationSilo:SetSprite(create.iconPath)
    end
  end
  local lastTime = totalTime + DataModel.FurnitureServerData.space.start_ts - TimeUtil:GetServerTimeStamp()
  if 0 <= lastTime then
    right.Txt_Time:SetText(TimeUtil:GetStandardTime(TimeUtil:SecondToTable(lastTime)))
  else
    right.Txt_Time:SetText("到此为止拉")
  end
  totalGenerate = totalGenerate * (1 - 0.1 * (#DataModel.FurnitureServerData.space.creatures - 1)) / (totalTime / 3600)
  right.Txt_Produce:SetText(totalGenerate .. "/h")
  View.Group_PurificationInterface.Txt_Object:SetText(str)
end

return Controller
