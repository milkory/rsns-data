local View = require("UISettlement/UISettlementView")
local DataModel = {}
DataModel.user_info = {}
DataModel.before_roles = {}
DataModel.DropAwardList = {}
DataModel.InitPos = {
  isRecord = true,
  x = 0,
  y = 0,
  scale = 1
}
DataModel.IsReStart = false
DataModel.LevelCA = {}

function DataModel:CleanEffect()
  local Parent_1 = View.Group_Victory.Group_Score.Img_Bottom.Group_Effect.self
  local Parent_2 = View.Group_Victory.Group_Score.Img_Grade.Group_Effect.self
  Parent_1:HideDynamicGameObject()
  Parent_2:HideDynamicGameObject()
end

function DataModel.LoadSpineBg(viewId)
  local spineBg = View.Group_Victory.Group_Center.Img_SpineBG
  local viewCfg = PlayerData:GetFactoryData(viewId, "UnitViewFactory")
  if viewCfg.SpineBackground and viewCfg.SpineBackground ~= "" then
    spineBg:SetSprite(viewCfg.SpineBackground)
    local offsetX = viewCfg.SpineBGX and viewCfg.SpineBGX or 0
    local offsetY = viewCfg.SpineBGY and viewCfg.SpineBGY or 0
    local x = View.Group_Victory.Group_Center.SpineAnimation_Character.transform.localPosition.x - offsetX
    spineBg.transform.localPosition = Vector3(x, offsetY, 0)
    local scale = viewCfg.SpineBGScale or 1
    spineBg.transform.localScale = Vector3(scale, scale, 0)
  end
  spineBg:SetActive(viewCfg.SpineBackground and viewCfg.SpineBackground ~= "")
end

return DataModel
