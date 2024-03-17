local view = require("UIDialog/UIDialogView")
local base = require("UIDialog/Model_PlotBase")
local DataModel = require("UIDialog/UIDialogDataModel")
local Gender = Class.New("SelectGender", base)
local plotCA
local finish = false
local genderView, genderInt

function Gender:Ctor()
  genderInt = -1
  finish = false
end

function Gender.Boy(isSelect)
  local boy = genderView.Btn_nan
  if isSelect then
    genderInt = 1
    boy:SetSprite(plotCA.selectedBoyPath)
    boy.CachedTransform:SetAsLastSibling()
  else
    boy:SetSprite(plotCA.unselectedBoyPath)
    boy.CachedTransform:SetAsFirstSibling()
  end
  genderView.Img_text1:SetActive(isSelect)
  genderView.Btn_affirm:SetActive(isSelect)
end

function Gender.Girl(isSelect)
  local girl = genderView.Btn_nv
  if isSelect then
    genderInt = 0
    girl:SetSprite(plotCA.selectedGirlPath)
    girl.CachedTransform:SetAsLastSibling()
  else
    girl:SetSprite(plotCA.unselectedGirlPath)
    girl.CachedTransform:SetAsFirstSibling()
  end
  genderView.Img_text2:SetActive(isSelect)
  genderView.Btn_affirm:SetActive(isSelect)
end

local OpenGenderView = function(isOpen)
  if isOpen then
    genderView.Img_text1.Txt_Content:SetText(plotCA.boyText)
    genderView.Img_text2.Txt_Content:SetText(plotCA.girlText)
  end
  genderView:SetActive(isOpen)
  DataModel.SetSkipAndAutoBtn(not isOpen)
end

function Gender.Confirm()
  CommonTips.OnPrompt("80600137", "80600068", "80600067", function()
    Net:SendProto("main.set_gender", function(json)
      finish = true
      OpenGenderView(false)
    end, genderInt)
  end, nil)
end

function Gender:OnStart(ca)
  if finish == false then
    plotCA = ca
    genderView = view.Group_Gender
    OpenGenderView(true)
    Gender.Boy(false)
    Gender.Girl(false)
  end
end

function Gender.GetState()
  return finish
end

function Gender:Dtor()
  genderView = nil
end

return Gender
