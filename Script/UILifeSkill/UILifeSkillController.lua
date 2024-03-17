local View = require("UILifeSkill/UILifeSkillView")
local DataModel = require("UILifeSkill/UILifeSkillDataModel")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  View.ScrollGrid_SkillList.grid.self:SetDataCount(#DataModel.HomeSkillInfo)
  View.ScrollGrid_SkillList.grid.self:RefreshAllElement()
end

function Controller:Exit()
  View.self:CloseUI()
end

function Controller:RefreshElement(element, elementIndex)
  local info = DataModel.HomeSkillInfo[elementIndex]
  element.Txt_SkillName:SetText(info.homeSkillCA.name)
  local text = info.homeSkillCA.desc
  if info.homeSkillCA.isReplace then
    local param = info.param
    if info.homeSkillCA.isPCT then
      param = param * 100
    else
      param = math.modf(param)
    end
    text = string.format(text, param)
  end
  local count = #info.unitInfo
  element.Txt_SkillDesc:SetText(text)
  element.ScrollGrid_Photo.grid.self:SetParentParam(elementIndex)
  element.ScrollGrid_Photo.grid.self:SetDataCount(count)
  if count <= 6 then
    element.ScrollGrid_Photo.self:SetEnable(false)
    element.ScrollGrid_Photo.grid.self:SetStartCorner("Center")
  else
    element.ScrollGrid_Photo.self:SetEnable(true)
    element.ScrollGrid_Photo.grid.self:SetStartCorner("Left")
    element.ScrollGrid_Photo.grid.self:MoveToTop()
  end
  element.ScrollGrid_Photo.grid.self:RefreshAllElement()
end

function Controller:RefreshPhotoElement(element, elementIndex)
  local info = DataModel.HomeSkillInfo[tonumber(element.ParentParam)].unitInfo[elementIndex]
  local unitCA = PlayerData:GetFactoryData(info.unitId, "unitFactory")
  local unitViewCA = PlayerData:GetFactoryData(unitCA.viewId, "UnitViewFactory")
  element.Img_PicBg.Img_Photo:SetSprite(unitViewCA.face)
  element.Img_NotOwned:SetActive(not info.hadUnit)
  element.Img_Unactivated:SetActive(info.hadUnit and not info.unlock)
  element.Btn_Tips:SetClickParam(tostring(info.unitId))
  element.Txt_LV:SetActive(info.unlock)
  if info.unlock then
    element.Txt_LV:SetText(string.format(GetText(80601968), info.skillLv))
  end
end

return Controller
