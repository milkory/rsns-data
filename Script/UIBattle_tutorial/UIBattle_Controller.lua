local View = require("UIBattle_tutorial/UIBattle_tutorialView")
local Controller = {}
local Count, Index, List
local SetImg = function()
  View.Group_minor.Btn_right:SetActive(true)
  View.Group_minor.Btn_left:SetActive(true)
  if Index == Count then
    View.Group_minor.Btn_right:SetActive(false)
    View.Btn_close:SetActive(true)
  elseif Index == 1 then
    View.Group_minor.Btn_left:SetActive(false)
    Index = 1
  end
  local path = List[Index].path
  View.Group_photo.Img_photo:SetSprite(path)
  View.ScrollGrid_Line.grid.self:RefreshAllElement()
end

function Controller.InitUI(params)
  local ca = PlayerData:GetFactoryData(Json.decode(params), "GuildanceOrderFactory")
  List = ca.list
  Count = #List
  Index = 1
  View.Btn_close:SetActive(false)
  local length = (View.ScrollGrid_Line.grid.self.CellSize.x + View.ScrollGrid_Line.grid.self.Spacing.x) / 2
  View.ScrollGrid_Line.grid.self:SetAnchoredPositionX(966 - Count * length)
  View.ScrollGrid_Line.grid.self:SetDataCount(Count)
  SetImg()
end

function Controller.OnClickBtn(isRight)
  if isRight then
    Index = Index + 1
  else
    Index = Index - 1
  end
  SetImg()
end

function Controller.SetElement(element, elementIndex)
  element.Btn_Item:SetClickParam(elementIndex)
  element.Img_0:SetActive(elementIndex == Index)
end

function Controller.GridBtn(index)
  Index = index
  SetImg()
end

return Controller
