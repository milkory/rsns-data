local View = require("UINotice/UINoticeView")
local DataModel = require("UINotice/UINoticeDataModel")
local Controller = {}
local btnURL = ""

function Controller.InitView()
  local count = table.count(PlayerData.Notice)
  View.ScrollGrid_Choice.grid.self:SetDataCount(count)
  View.ScrollGrid_Choice.grid.self:RefreshAllElement()
  local index = DataModel.CurrentIndex
  if count >= index then
    Controller.RefreshGrid(index)
  else
    DataModel.CurrentIndex = 1
  end
  ReportTrackEvent.Guide_flow(12)
end

function Controller.SetElement(element, index)
  local data = PlayerData.Notice[index - 1]
  element.Btn_Check:SetClickParam(index)
  element.Img_Red:SetActive(false)
  local tab = data.Tab or "NO Tab"
  element.Group_On.Txt_T:SetText(tab)
  local isSelect = index == DataModel.CurrentIndex
  local off = element.Group_Off
  off:SetActive(not isSelect)
  if not isSelect then
    off.Txt_T:SetText(tab)
  end
  local label = data.TabLabel or ""
  if label == "" then
    element.Img_Label:SetActive(false)
  else
    element.Img_Label:SetActive(true)
    element.Img_Label.Txt_Label:SetText(label)
  end
  if isSelect then
    local content = View.Img_Content
    content.Img_Title:SetActive(false)
    content.Txt_Title:SetActive(data.Title ~= nil)
    content.Txt_Title:SetText(data.Title or "NO Title")
    content.ScrollView_Content.Viewport.Content.TextHyperlink_Content:SetText(data.Content or "NO Content")
    content.ScrollView_Content:SetContentHeight(content.ScrollView_Content.Viewport.Content.TextHyperlink_Content:GetHeight())
    btnURL = data.TargetURL or ""
    if btnURL == "" then
      content.Btn_URL:SetActive(false)
    else
      content.Btn_URL:SetActive(true)
      content.Btn_URL.Txt_T:SetText(data.ButtonText)
    end
  end
end

function Controller.RefreshGrid(index)
  CoroutineManager:UnReg("notice")
  local ImgURL = PlayerData.Notice[index - 1].ImageURL
  if ImgURL ~= nil and ImgURL ~= "" then
    CoroutineManager:Reg("notice", MGameManager.DownloadTexture(ImgURL, function(texture)
      if DataModel.IsDestroy == false then
        local img = View.Img_Content.Img_Title
        img:SetActive(true)
        img:SetTexture2D(texture)
        DOTweenTools.DOFadeCallback(img.transform, 0, 1, 1)
      end
    end))
  end
end

function Controller.OpenURL()
  if btnURL ~= "" then
    MGameManager.WebView(GetText(80600183), btnURL)
  end
end

return Controller
