local View = require("UICardDrawing/UICardDrawingView")
local DataModel = require("UICardDrawing/UICardDrawingDataModel")
local nowProcess = 0
local startPosx = 0
local drawingiSPlaying = false
local ViewFunction = {
  CardDrawing_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("CardDrawing_Out", function()
      UIManager:GoBack(false)
      View.self:Confirm()
    end)
  end,
  CardDrawing_Drag__BeginDrag = function(direction, dragPos)
    startPosx = dragPos.x
    nowProcess = 0
    local animator = View.animator
    animator:Play("CardDrawing_Opening")
    animator.enabled = false
    drawingiSPlaying = false
  end,
  CardDrawing_Drag__EndDrag = function(direction, dragPos)
    if drawingiSPlaying then
      return
    end
    local animator = View.animator
    if nowProcess < (animator:GetCurrentAnimatorStateInfo().length or 0.667) / 2 then
      animator:Update(-nowProcess)
      animator.enabled = true
      animator:Play("CardDrawing_Loop")
    else
      animator.enabled = true
      drawingiSPlaying = true
      View.self:PlayAnim("CardDrawing_Opening", function()
        View.self:PlayAnim("CardDrawing_Open", function()
          animator.enabled = false
          View.Btn_Return:SetBtnInteractable(true)
        end)
      end)
      animator:Play("CardDrawing_Opening", 0, nowProcess / (animator:GetCurrentAnimatorStateInfo().length or 0.667))
    end
  end,
  CardDrawing_Drag__OnDrag = function(direction, dragPos)
    if drawingiSPlaying then
      return
    end
    local animator = View.animator
    local process = (dragPos.x - startPosx) / 450 * (animator:GetCurrentAnimatorStateInfo().length or 0.667)
    startPosx = dragPos.x
    nowProcess = process + nowProcess
    if nowProcess <= 0 then
      process = 0
      nowProcess = 0
    end
    if nowProcess >= (animator:GetCurrentAnimatorStateInfo().length or 0.667) then
      animator.enabled = true
      drawingiSPlaying = true
      View.self:PlayAnim("CardDrawing_Open", function()
        animator.enabled = false
        View.Btn_Return:SetBtnInteractable(true)
      end)
      return
    end
    animator:Update(process)
  end
}
return ViewFunction
