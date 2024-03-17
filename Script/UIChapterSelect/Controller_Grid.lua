local module = {
  currentGrid = nil,
  currentGridList = nil,
  RefreshCurrentGrid = function(self)
    self.currentGrid.grid.self:SetDataCount(#self.currentGridList)
    self.currentGrid.grid.self:RefreshAllElement()
  end,
  RefreshLeftCurrentGrid = function(self, currentGrid)
    currentGrid.grid.self:SetDataCount(#self.currentGridList)
    currentGrid.grid.self:RefreshAllElement()
  end,
  RefreshLeftNameGrid = function(self, currentGrid)
    currentGrid.grid.self:SetDataCount(#self.currentGridList)
    currentGrid.grid.self:RefreshAllElement()
  end
}

function module.RefreshChapterNum(Gourp_ChapterNum, chapertNum, l, r)
  if chapertNum < l or r < chapertNum then
    Gourp_ChapterNum.self:SetActive(false)
    return
  end
  local numStr = ""
  if chapertNum < 10 then
    numStr = "0" .. chapertNum
  else
    numStr = tostring(chapertNum)
  end
  local iconPath = UIConfig.chapterIconWithoutNumber .. numStr
  Gourp_ChapterNum.Img_Num:SetSprite(iconPath)
  Gourp_ChapterNum.self:SetActive(true)
end

return module
