local View = require("UICharacterInfo/UICharacterInfoView")
local DataModel = require("UICharacterInfo/DataModel")
local module = {
  Init = function(self)
  end,
  Load = function(self)
    View.Group_Files.self:SetActive(true)
    local Group_Detail = View.Group_Files.Group_TIRight.Group_TITop.Group_Detail
    local Group_TIBottom = View.Group_Files.Group_TIRight.Group_TIBottom
    local RoleCA = DataModel.RoleCA
    local TemporaryText = ""
    Group_Detail.Group_Age.Txt_Age:SetText(RoleCA.age or TemporaryText)
    Group_Detail.Group_Birthday.Txt_Birthday:SetText(RoleCA.birthday or TemporaryText)
    Group_Detail.Group_Height.Txt_Height:SetText(RoleCA.height or TemporaryText)
    Group_Detail.Group_Birthplace.Txt_Birthplace:SetText(RoleCA.birthplace or TemporaryText)
    Group_Detail.Group_Identity.Txt_Identity:SetText(RoleCA.identity or TemporaryText)
    local Scroll_Content = View.Group_Files.Group_TIRight.ScrollView_Text
    Scroll_Content.Viewport.Content.Txt_Des:SetText(RoleCA.ResumeList[1] ~= nil and RoleCA.ResumeList[1].des or TemporaryText)
    Scroll_Content:SetContentHeight(View.Group_Files.Group_TIRight.ScrollView_Text.Viewport.Content.Txt_Des:GetHeight())
    local classifyList = DataModel.RoleCA.classifyList
    local Group_TIBottomLeft = View.Group_Files.Group_TIBottomLeft
    local Group_Classify = Group_TIBottomLeft.Group_Classify
    if classifyList ~= nil and table.GetTableState(classifyList) then
      Group_Classify.self:SetActive(true)
      for i = 1, 3 do
        local img = "Img_Tag0" .. i
        local row = classifyList[i]
        Group_Classify[img]:SetActive(false)
        if row then
          Group_Classify[img]:SetActive(true)
          Group_Classify[img].Txt_Title:SetText(row.des)
        end
      end
    else
      Group_Classify.self:SetActive(false)
    end
    local jobInt = PlayerData:SearchRoleJobInt(DataModel.RoleCA.jobId)
    Group_TIBottomLeft.Group_Career.Txt_Title:SetText(DataModel.Job[jobInt])
    Group_TIBottomLeft.Txt_NameCH:SetText(DataModel.RoleCA.name)
    Group_TIBottomLeft.Img_Quality:SetSprite(UIConfig.WeaponQuality[DataModel.RoleCA.qualityInt])
    Group_TIBottomLeft.Img_Quality:SetNativeSize()
    Group_TIBottomLeft.Group_Camp.Img_Icon:SetSprite(UIConfig.RoleCamp[tonumber(DataModel.RoleCA.campInt + 1)])
  end
}
return module
