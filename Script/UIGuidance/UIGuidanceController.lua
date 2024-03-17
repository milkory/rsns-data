local View = require("UIGuidance/UIGuidanceView")
local Controller = {}
Controller.Sound = nil
local isFinish = false
local CloseSelf = function()
  if Controller.IsOpen then
    View.self:CloseUI()
  end
end

function Controller.SetFocus(x, y, w, h, left, top)
  View.Img_GuidanceMask:SetActive(true)
  View.Img_Glow:SetActive(true)
  View.Img_GuidanceMask:SetLocalPositionX(x, left)
  View.Img_GuidanceMask:SetLocalPositionY(y, top)
  View.Img_Glow:SetLocalPositionX(x, left)
  View.Img_Glow:SetLocalPositionY(y, top)
  View.Img_GuidanceMask:SetWidthHeight(w, h)
  View.Img_Glow:SetWidthHeight(w + 10, h + 10)
  isFinish = false
end

function Controller.PosOffset(x, y)
  View.Img_GuidanceMask:SetLocalPositionOffset(x, y)
  View.Img_Glow:SetLocalPositionOffset(x, y)
  isFinish = false
end

function Controller.SetBgAlpha(value)
  View.Img_GuidanceMask.Img_Bg:SetAlpha(value)
end

function Controller.ShowFinger(isShow)
  View.Img_Glow.Img_Finger:SetActive(isShow)
end

function Controller.ShowRotation()
  View.Group_Rotation.self:SetActive(true)
end

function Controller.ShowTip(x, y, text, left, top, sprite, isWaitClick, isDoTween, speed)
  View.Btn_Tip:SetActive(isWaitClick)
  View.Group_Tip:SetActive(true)
  View.Group_Tip:SetLocalPositionX(x, left)
  View.Group_Tip:SetLocalPositionY(y, top)
  View.Group_Tip.Txt_Next:SetActive(isWaitClick)
  View.Group_Tip.Img_Guide.Img_Head:SetSprite(sprite)
  if isDoTween then
    View.Group_Tip.Txt_Context:SetTweenContent(text, nil, speed)
  else
    View.Group_Tip.Txt_Context:SetText(text)
  end
  isFinish = false
end

function Controller.ShowClick(isShow)
  View.Btn_Tip:SetActive(isShow)
end

function Controller.CloseFocusView()
  if Controller.IsOpen then
    View.Img_GuidanceMask:SetActive(false)
    View.Img_Glow:SetActive(false)
    CloseSelf()
  end
end

function Controller.CloseTipView()
  if Controller.IsOpen then
    View.Btn_Tip:SetActive(false)
    View.Group_Tip:SetActive(false)
  end
end

function Controller.CloseRotation()
  if Controller.IsOpen then
    View.Group_Rotation.self:SetActive(false)
    CloseSelf()
  end
end

function Controller.ClickTip()
  isFinish = true
end

function Controller.IsFinish()
  return isFinish
end

function Controller.GetLocalPos(pos)
  return View.self.transform:InverseTransformPoint(pos)
end

function Controller.RecycleSound()
  if Controller.Sound ~= nil then
    Controller.Sound:Recycle()
    Controller.Sound = nil
  end
end

function Controller.PlaySound(soundId)
  if 0 < soundId then
    local sound = SoundManager:CreateSound(soundId)
    if sound then
      Controller.RecycleSound()
      sound:Play()
      Controller.Sound = sound
    end
  end
end

Controller.IsOpen = false
return Controller
