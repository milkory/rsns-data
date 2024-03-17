local View = require("UIBook/UIBookView")
local DataModel = require("UIBook/UIBookDataModel")
local Data = {}
local Controller = {}
local allCount = 0
local getCount = 0
local IsUnlock = function(data, id)
  if data then
    for k, v in pairs(data) do
      if tonumber(v) == id then
        return true
      end
    end
  end
  return false
end
local InitView = function()
  local result = getCount / allCount
  local Btn = View.Group_BookMain.Btn_Picture
  Btn.Txt_RoleNum:SetText(getCount .. "/" .. allCount)
  Btn.Txt_Progress:SetText(tostring(PlayerData:GetPreciseDecimalFloor(result * 100, 1)) .. "%")
  Btn.Img_bar:SetFilledImgAmount(result)
  View.Group_Picture.self:SetActive(false)
end
local InitData = function()
  local all = PlayerData:GetFactoryData(80900003, "BookFactory")
  allCount = #all.pictureList
  local pictures = PlayerData.ServerData.pictures
  getCount = 0
  local tab = {}
  for _, v in ipairs(all.pictureList) do
    local id = tonumber(v.id)
    local info = {}
    local data = PlayerData:GetFactoryData(id, "PictureFactory")
    info.id = id
    info.isUnlock = IsUnlock(pictures, id)
    if info.isUnlock then
      getCount = getCount + 1
    end
    info.name = data.name
    info.picturePath = data.picturePath
    info.width = data.width
    info.height = data.height
    info.iconPath = data.iconPath
    table.insert(tab, info)
  end
  Data = tab
end

function Controller.Init()
  InitData()
  InitView()
end

function Controller.Open()
  DataModel.CurrentPage = DataModel.EnumPage.Picture
  View.Group_Picture.self:SetActive(true)
  local grid = View.Group_Picture.ScrollGrid_CG.grid.self
  grid:SetDataCount(#Data)
  grid:RefreshAllElement()
end

function Controller.SetElement(element, elementIndex)
  element.Btn_Select:SetClickParam(elementIndex)
  local data = Data[tonumber(elementIndex)]
  element.Txt_name:SetText(data.name)
  element.Img_Icon:SetSprite(data.iconPath)
  local lock = element.Group_Lock
  lock.self:SetActive(not data.isUnlock)
end

function Controller.OnClickBtn(elementIndex)
  local data = Data[elementIndex]
  if not data.isUnlock then
    CommonTips.OpenTips(80600221)
    return
  end
  View.Group_PictureBig:SetActive(true)
  View.Group_PictureBig.Img_Picture:SetSprite(data.picturePath)
  View.Group_PictureBig.Img_Picture:SetImgWidthAndHeight(data.width, data.height)
end

function Controller.Close()
  DataModel.CurrentPage = DataModel.EnumPage.Main
  View.Group_Picture.self:SetActive(false)
end

return Controller
